#!/usr/bin/env python3
"""
GUI Hidden iframe / Media Injection Risk Checker
For authorized pentesting only.

Features:
- Target specific authorized URLs
- Enforce allow-host control
- Fetch page HTML safely
- Detect iframe/media tags
- Flag hidden/off-screen iframe patterns
- Flag risky iframe permissions: camera, microphone, autoplay
- Preview findings in GUI
- Export CSV report
- Generate benign PoC payload for reporting

This tool does not bypass permissions, exploit targets, brute-force URLs,
or request camera/microphone access.
"""

from __future__ import annotations

import csv
import re
import threading
import time
import tkinter as tk
from dataclasses import dataclass, asdict
from html.parser import HTMLParser
from pathlib import Path
from tkinter import ttk, filedialog, messagebox
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import Request, urlopen
import webbrowser


DEFAULT_TIMEOUT_SECONDS = 15
DEFAULT_USER_AGENT = "authorized-iframe-media-audit/1.0"


RISKY_ALLOW_TOKENS = {
    "camera",
    "microphone",
    "autoplay",
    "fullscreen",
    "clipboard-write",
    "encrypted-media",
    "payment",
    "geolocation",
}


HIDDEN_STYLE_PATTERNS = [
    "display:none",
    "visibility:hidden",
    "opacity:0",
    "left:-",
    "top:-",
    "width:0",
    "height:0",
    "width:1px",
    "height:1px",
    "position:absolute",
    "position:fixed",
    "overflow:hidden",
]


@dataclass
class Finding:
    page_url: str
    tag: str
    src: str
    width: str
    height: str
    style: str
    allow: str
    sandbox: str
    hidden_suspected: bool
    risky_permissions: str
    risk_level: str
    notes: str


class MediaTagParser(HTMLParser):
    def __init__(self):
        super().__init__()
        self.title = ""
        self._in_title = False
        self.tags = []

    def handle_starttag(self, tag, attrs):
        tag = tag.lower()
        attrs_dict = {k.lower(): (v or "") for k, v in attrs}

        if tag == "title":
            self._in_title = True

        if tag in {"iframe", "object", "embed", "audio", "video", "source"}:
            self.tags.append({
                "tag": tag,
                "src": attrs_dict.get("src", attrs_dict.get("data", "")),
                "width": attrs_dict.get("width", ""),
                "height": attrs_dict.get("height", ""),
                "style": attrs_dict.get("style", ""),
                "allow": attrs_dict.get("allow", ""),
                "sandbox": attrs_dict.get("sandbox", ""),
            })

    def handle_endtag(self, tag):
        if tag.lower() == "title":
            self._in_title = False

    def handle_data(self, data):
        if self._in_title:
            self.title += data.strip()


def normalize_host(host: str) -> str:
    return host.strip().lower().rstrip(".")


def is_allowed_host(host: str, allowed_hosts: set[str]) -> bool:
    host = normalize_host(host)
    return any(host == allowed or host.endswith(f".{allowed}") for allowed in allowed_hosts)


def validate_target_url(url: str, allowed_hosts: set[str]) -> None:
    parsed = urlparse(url)

    if parsed.scheme not in {"http", "https"} or not parsed.netloc:
        raise ValueError("Target must be a valid HTTP or HTTPS URL.")

    host = parsed.hostname or ""
    if not is_allowed_host(host, allowed_hosts):
        raise ValueError(
            f"Host '{host}' is not in the allowed-host list. "
            f"Add it first if you are authorized to test it."
        )


def fetch_html(url: str, timeout: float = DEFAULT_TIMEOUT_SECONDS) -> tuple[int, str, str]:
    request = Request(
        url,
        headers={
            "User-Agent": DEFAULT_USER_AGENT,
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.1",
        },
        method="GET",
    )

    with urlopen(request, timeout=timeout) as response:
        status = response.status
        content_type = response.headers.get("Content-Type", "")
        body_bytes = response.read(2_000_000)  # 2 MB safety cap
        text = body_bytes.decode("utf-8", errors="replace")
        return status, content_type, text


def detect_hidden(style: str, width: str, height: str) -> bool:
    normalized_style = re.sub(r"\s+", "", style.lower())

    style_match = any(pattern in normalized_style for pattern in HIDDEN_STYLE_PATTERNS)

    tiny_dimension = False
    for value in (width, height):
        value = str(value).strip().lower()
        if value in {"0", "0px", "1", "1px"}:
            tiny_dimension = True

    return style_match or tiny_dimension


def parse_allow_tokens(allow: str) -> list[str]:
    if not allow:
        return []

    tokens = []
    for part in allow.replace(",", ";").split(";"):
        token = part.strip().split(" ")[0].lower()
        if token:
            tokens.append(token)
    return tokens


def risk_rating(hidden: bool, risky_permissions: list[str], tag: str) -> tuple[str, str]:
    notes = []

    if hidden:
        notes.append("Element appears hidden, tiny, or positioned off-screen.")

    if risky_permissions:
        notes.append(f"Delegated permissions present: {', '.join(risky_permissions)}.")

    if tag in {"object", "embed"}:
        notes.append("Legacy embed/object tag increases content injection risk.")

    if hidden and any(x in risky_permissions for x in {"camera", "microphone"}):
        return "High", " ".join(notes)

    if hidden and risky_permissions:
        return "Medium", " ".join(notes)

    if hidden:
        return "Medium", " ".join(notes)

    if any(x in risky_permissions for x in {"camera", "microphone", "geolocation", "payment"}):
        return "Medium", " ".join(notes)

    if risky_permissions:
        return "Low", " ".join(notes)

    return "Informational", "Visible or ordinary media/embed element detected."


def analyze_page(url: str, html: str) -> tuple[str, list[Finding]]:
    parser = MediaTagParser()
    parser.feed(html)

    findings = []

    for item in parser.tags:
        allow_tokens = parse_allow_tokens(item["allow"])
        risky = sorted(set(allow_tokens) & RISKY_ALLOW_TOKENS)
        hidden = detect_hidden(item["style"], item["width"], item["height"])
        level, notes = risk_rating(hidden, risky, item["tag"])

        findings.append(Finding(
            page_url=url,
            tag=item["tag"],
            src=item["src"],
            width=item["width"],
            height=item["height"],
            style=item["style"],
            allow=item["allow"],
            sandbox=item["sandbox"],
            hidden_suspected=hidden,
            risky_permissions=", ".join(risky),
            risk_level=level,
            notes=notes,
        ))

    return parser.title, findings


def export_csv(path: Path, findings: list[Finding]) -> None:
    with path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=list(asdict(findings[0]).keys()))
        writer.writeheader()
        for finding in findings:
            writer.writerow(asdict(finding))


def build_benign_poc(url: str) -> str:
    return f"""<!-- Benign PoC: hidden third-party iframe/media injection risk -->
<!-- Use only in authorized test environments. -->
<div style="
  position: absolute;
  left: -9999px;
  top: -9999px;
  width: 1px;
  height: 1px;
  overflow: hidden;
">
  <iframe
    src="{url}"
    width="300"
    height="80"
    loading="lazy"
    allow="encrypted-media; picture-in-picture">
  </iframe>
</div>
"""


class IframeRiskGui:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title("Authorized iframe/media injection risk checker")
        self.root.geometry("1150x720")

        self.findings: list[Finding] = []
        self.current_html = ""
        self.current_url = ""

        self._build_ui()

    def _build_ui(self):
        main = ttk.Frame(self.root, padding=8)
        main.pack(fill=tk.BOTH, expand=True)

        target_frame = ttk.LabelFrame(main, text="Authorized target", padding=8)
        target_frame.pack(fill=tk.X)

        ttk.Label(target_frame, text="Target URL:").grid(row=0, column=0, sticky="w")
        self.url_var = tk.StringVar()
        ttk.Entry(target_frame, textvariable=self.url_var, width=90).grid(row=0, column=1, sticky="ew", padx=5)

        ttk.Label(target_frame, text="Allowed hosts/domains:").grid(row=1, column=0, sticky="w")
        self.allowed_hosts_var = tk.StringVar()
        ttk.Entry(target_frame, textvariable=self.allowed_hosts_var, width=90).grid(row=1, column=1, sticky="ew", padx=5)

        target_frame.columnconfigure(1, weight=1)

        button_frame = ttk.Frame(target_frame)
        button_frame.grid(row=0, column=2, rowspan=2, padx=5)

        ttk.Button(button_frame, text="Analyze page", command=self.start_analysis).pack(fill=tk.X, pady=2)
        ttk.Button(button_frame, text="Open target visibly", command=self.open_target).pack(fill=tk.X, pady=2)
        ttk.Button(button_frame, text="Export CSV", command=self.export_report).pack(fill=tk.X, pady=2)

        self.status_var = tk.StringVar(value="Ready. Only test systems you own or are authorized to assess.")
        ttk.Label(main, textvariable=self.status_var).pack(fill=tk.X, pady=(6, 2))

        panes = ttk.PanedWindow(main, orient=tk.HORIZONTAL)
        panes.pack(fill=tk.BOTH, expand=True)

        left = ttk.Frame(panes)
        right = ttk.Frame(panes)
        panes.add(left, weight=3)
        panes.add(right, weight=2)

        columns = (
            "risk_level",
            "tag",
            "hidden_suspected",
            "risky_permissions",
            "src",
        )

        self.tree = ttk.Treeview(left, columns=columns, show="headings")
        for col in columns:
            self.tree.heading(col, text=col)
            self.tree.column(col, width=140 if col != "src" else 420)

        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.tree.bind("<<TreeviewSelect>>", self.on_select)

        scroll = ttk.Scrollbar(left, orient=tk.VERTICAL, command=self.tree.yview)
        scroll.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree.configure(yscrollcommand=scroll.set)

        notebook = ttk.Notebook(right)
        notebook.pack(fill=tk.BOTH, expand=True)

        details_frame = ttk.Frame(notebook)
        poc_frame = ttk.Frame(notebook)
        html_frame = ttk.Frame(notebook)

        notebook.add(details_frame, text="Finding preview")
        notebook.add(poc_frame, text="PoC snippet")
        notebook.add(html_frame, text="Page evidence")

        self.details_text = tk.Text(details_frame, wrap=tk.WORD)
        self.details_text.pack(fill=tk.BOTH, expand=True)

        self.poc_text = tk.Text(poc_frame, wrap=tk.WORD)
        self.poc_text.pack(fill=tk.BOTH, expand=True)

        self.html_text = tk.Text(html_frame, wrap=tk.WORD)
        self.html_text.pack(fill=tk.BOTH, expand=True)

        ttk.Button(right, text="Open selected iframe/src visibly", command=self.open_selected_src).pack(fill=tk.X, pady=4)

    def get_allowed_hosts(self) -> set[str]:
        raw = self.allowed_hosts_var.get().strip()
        if not raw:
            raise ValueError("Enter at least one allowed host/domain.")

        return {
            normalize_host(host)
            for host in re.split(r"[,\s]+", raw)
            if host.strip()
        }

    def start_analysis(self):
        thread = threading.Thread(target=self.analyze_current_target, daemon=True)
        thread.start()

    def analyze_current_target(self):
        try:
            url = self.url_var.get().strip()
            allowed_hosts = self.get_allowed_hosts()

            validate_target_url(url, allowed_hosts)

            self.set_status("Fetching target page...")
            status, content_type, html = fetch_html(url)

            if "html" not in content_type.lower():
                proceed = messagebox.askyesno(
                    "Non-HTML content",
                    f"Content-Type is '{content_type}'. Continue parsing anyway?"
                )
                if not proceed:
                    self.set_status("Stopped: non-HTML content.")
                    return

            title, findings = analyze_page(url, html)

            self.current_url = url
            self.current_html = html
            self.findings = findings

            self.root.after(0, lambda: self.render_results(status, content_type, title, html, findings))

        except HTTPError as error:
            self.set_status(f"HTTP error: {error.code} {error.reason}")
        except URLError as error:
            self.set_status(f"Network error: {error.reason}")
        except Exception as error:
            self.set_status(f"Error: {error}")

    def render_results(self, status: int, content_type: str, title: str, html: str, findings: list[Finding]):
        for item in self.tree.get_children():
            self.tree.delete(item)

        for index, finding in enumerate(findings):
            self.tree.insert(
                "",
                tk.END,
                iid=str(index),
                values=(
                    finding.risk_level,
                    finding.tag,
                    finding.hidden_suspected,
                    finding.risky_permissions,
                    finding.src,
                )
            )

        evidence = (
            f"URL: {self.current_url}\n"
            f"HTTP status: {status}\n"
            f"Content-Type: {content_type}\n"
            f"Page title: {title or '(none found)'}\n"
            f"Media/embed elements found: {len(findings)}\n\n"
            f"Raw page preview, first 10,000 characters:\n"
            f"{'-' * 60}\n"
            f"{html[:10000]}"
        )

        self.html_text.delete("1.0", tk.END)
        self.html_text.insert(tk.END, evidence)

        self.poc_text.delete("1.0", tk.END)
        self.poc_text.insert(
            tk.END,
            build_benign_poc("https://example.com/authorized-test-embed")
        )

        self.details_text.delete("1.0", tk.END)
        self.details_text.insert(tk.END, "Select a finding to preview details.")

        self.set_status(f"Analysis complete. Findings: {len(findings)}")

    def on_select(self, _event=None):
        selected = self.tree.selection()
        if not selected:
            return

        finding = self.findings[int(selected[0])]

        details = f"""Risk level: {finding.risk_level}
Page URL: {finding.page_url}
Tag: {finding.tag}
Source/Data URL: {finding.src}

Hidden suspected: {finding.hidden_suspected}
Risky delegated permissions: {finding.risky_permissions or "(none)"}

Width: {finding.width}
Height: {finding.height}
Style: {finding.style or "(none)"}
Allow: {finding.allow or "(none)"}
Sandbox: {finding.sandbox or "(none)"}

Notes:
{finding.notes}

Report wording:
The page contains a {finding.tag} element that may allow third-party content/media loading.
The element was flagged as hidden/off-screen or permission-sensitive based on its attributes.
Successful exploitation depends on whether the application allows user-controlled HTML,
whether the iframe can be stored/reflected, and whether CSP/Permissions-Policy restricts it.
"""

        self.details_text.delete("1.0", tk.END)
        self.details_text.insert(tk.END, details)

        poc_src = finding.src or "https://example.com/authorized-test-embed"
        self.poc_text.delete("1.0", tk.END)
        self.poc_text.insert(tk.END, build_benign_poc(poc_src))

    def open_target(self):
        url = self.url_var.get().strip()
        if url:
            webbrowser.open(url)

    def open_selected_src(self):
        selected = self.tree.selection()
        if not selected:
            messagebox.showinfo("No selection", "Select a finding first.")
            return

        src = self.findings[int(selected[0])].src
        if not src:
            messagebox.showinfo("No source", "Selected item has no src/data URL.")
            return

        webbrowser.open(src)

    def export_report(self):
        if not self.findings:
            messagebox.showinfo("No findings", "Run an analysis first.")
            return

        path = filedialog.asksaveasfilename(
            title="Save CSV report",
            defaultextension=".csv",
            filetypes=[("CSV files", "*.csv")]
        )

        if not path:
            return

        export_csv(Path(path), self.findings)
        self.set_status(f"Report exported: {path}")

    def set_status(self, message: str):
        self.root.after(0, lambda: self.status_var.set(message))


def main():
    root = tk.Tk()
    app = IframeRiskGui(root)
    root.mainloop()


if __name__ == "__main__":
    main()