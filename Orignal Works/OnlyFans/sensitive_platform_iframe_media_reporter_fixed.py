#!/usr/bin/env python3
"""
Sensitive Platform iframe/media Access-Control Reporter GUI.

Authorized pentesting only. This tool is intentionally conservative:
- explicit URLs only
- allow-host list required
- no URL guessing, scraping, or enumeration
- no protected media preview
- no response-body saving in sensitive metadata mode
- records metadata and iframe/media policy evidence for reporting

Safety notes:
- This tool does not bypass authentication or permissions.
- Metadata mode uses HEAD or GET with Range: bytes=0-0.
- Public iframe/media policy mode fetches HTML pages only for inspection.
- Opening a selected raw URL in a browser requires confirmation when the URL
  appears to contain sensitive query parameters.
"""

from __future__ import annotations

import csv
import json
import re
import threading
import tkinter as tk
from dataclasses import asdict, dataclass
from datetime import datetime, timezone
from html.parser import HTMLParser
from pathlib import Path
from tkinter import filedialog, messagebox, ttk
from urllib.error import HTTPError, URLError
from urllib.parse import parse_qsl, urlencode, urlparse, urlunparse
from urllib.request import Request, urlopen
import webbrowser


APP_NAME = "Sensitive Platform iframe/media Access-Control Reporter"
DEFAULT_TIMEOUT_SECONDS = 15
DEFAULT_USER_AGENT = "authorized-sensitive-platform-audit/1.0"
MAX_HTML_READ_BYTES = 2_000_000

SENSITIVE_QUERY_KEYS = {
    "token", "signature", "sig", "expires", "policy", "key", "keyid",
    "x-amz-signature", "x-amz-credential", "x-amz-security-token", "x-amz-expires",
    "auth", "authorization", "session", "jwt", "access_token", "refresh_token",
}

RISKY_ALLOW_TOKENS = {
    "camera", "microphone", "autoplay", "fullscreen", "clipboard-write",
    "encrypted-media", "payment", "geolocation",
}

HIDDEN_STYLE_PATTERNS = [
    "display:none", "visibility:hidden", "opacity:0", "left:-", "top:-",
    "right:-", "bottom:-", "width:0", "height:0", "width:1px", "height:1px",
    "position:absolute", "position:fixed", "overflow:hidden",
]


@dataclass
class MetadataResult:
    url: str
    redacted_url: str
    method: str
    status: int | str
    accessible_without_auth: bool
    content_type: str
    content_length: str
    cache_control: str
    etag: str
    location: str
    final_url: str
    redacted_final_url: str
    error: str
    notes: str
    timestamp_utc: str


@dataclass
class Finding:
    page_url: str
    redacted_page_url: str
    tag: str
    src: str
    redacted_src: str
    width: str
    height: str
    style: str
    allow: str
    sandbox: str
    hidden_suspected: bool
    risky_permissions: str
    risk_level: str
    notes: str
    timestamp_utc: str


class MediaTagParser(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.title = ""
        self._in_title = False
        self.tags: list[dict[str, str]] = []

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
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

    def handle_endtag(self, tag: str) -> None:
        if tag.lower() == "title":
            self._in_title = False

    def handle_data(self, data: str) -> None:
        if self._in_title:
            self.title += data.strip()


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


def normalize_host(host: str) -> str:
    return host.strip().lower().rstrip(".")


def is_allowed_host(host: str, allowed_hosts: set[str]) -> bool:
    host = normalize_host(host)
    return any(host == allowed or host.endswith(f".{allowed}") for allowed in allowed_hosts)


def parse_allowed_hosts(raw: str) -> set[str]:
    hosts = {normalize_host(h) for h in re.split(r"[,\s]+", raw.strip()) if h.strip()}
    if not hosts:
        raise ValueError("At least one allowed host/domain is required.")
    return hosts


def validate_url(url: str, allowed_hosts: set[str]) -> None:
    parsed = urlparse(url)
    if parsed.scheme not in {"http", "https"} or not parsed.netloc:
        raise ValueError(f"Not a valid HTTP(S) URL: {url}")
    host = parsed.hostname or ""
    if not is_allowed_host(host, allowed_hosts):
        raise ValueError(
            f"Host '{host}' is not in the allowed-host list. "
            "Only test systems you own or have written authorization to assess."
        )


def has_sensitive_query(url: str) -> bool:
    """Return True when a URL appears to contain sensitive query parameters."""
    try:
        parsed = urlparse(url)
        for key, _value in parse_qsl(parsed.query, keep_blank_values=True):
            if key.lower() in SENSITIVE_QUERY_KEYS:
                return True
        return False
    except Exception:
        return True


def redact_url(url: str) -> str:
    if not url:
        return ""
    try:
        parsed = urlparse(url)
        redacted_pairs = []
        for key, value in parse_qsl(parsed.query, keep_blank_values=True):
            if key.lower() in SENSITIVE_QUERY_KEYS:
                redacted_pairs.append((key, "[REDACTED]"))
            elif len(value) > 80:
                redacted_pairs.append((key, value[:16] + "...[TRUNCATED]"))
            else:
                redacted_pairs.append((key, value))
        return urlunparse((parsed.scheme, parsed.netloc, parsed.path,
                           parsed.params, urlencode(redacted_pairs), parsed.fragment))
    except Exception:
        return "[UNPARSEABLE URL REDACTED]"


def parse_header_lines(raw: str) -> dict[str, str]:
    headers: dict[str, str] = {}
    for line in raw.splitlines():
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if ":" not in line:
            raise ValueError(f"Header must use 'Name: value' format: {line!r}")
        name, value = line.split(":", 1)
        name, value = name.strip(), value.strip()
        if not name or not value:
            raise ValueError(f"Header must use 'Name: value' format: {line!r}")
        headers[name] = value
    return headers


def build_headers(extra_headers: dict[str, str]) -> dict[str, str]:
    headers = {
        "User-Agent": DEFAULT_USER_AGENT,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.1",
    }
    headers.update(extra_headers)
    return headers


def classify_access(status: int | str) -> bool:
    return status in {200, 206, 301, 302, 303, 307, 308}


def metadata_notes(status: int | str, content_type: str) -> str:
    low_ct = content_type.lower()
    if status in {401, 403}:
        return "Protected: expected access-control response."
    if status in {301, 302, 303, 307, 308}:
        return "Redirect observed. Verify whether final destination is login or public content."
    if status in {200, 206}:
        if any(x in low_ct for x in ("video", "audio", "octet-stream", "image/")):
            return "Potential exposure if expected private. Metadata only; body not downloaded."
        return "Reachable without additional tool-side auth. Review expected access level."
    return "No apparent anonymous access based on status code."


def metadata_probe(url: str, extra_headers: dict[str, str], timeout: float, range_probe: bool) -> MetadataResult:
    method = "GET" if range_probe else "HEAD"
    headers = build_headers(extra_headers)
    if range_probe:
        headers["Range"] = "bytes=0-0"
    request = Request(url, headers=headers, method=method)
    try:
        with urlopen(request, timeout=timeout) as response:
            h = response.headers
            status = response.status
            final_url = response.geturl()
            return MetadataResult(
                url=url, redacted_url=redact_url(url), method=method, status=status,
                accessible_without_auth=classify_access(status),
                content_type=h.get("Content-Type", ""), content_length=h.get("Content-Length", ""),
                cache_control=h.get("Cache-Control", ""), etag=h.get("ETag", ""),
                location=h.get("Location", ""), final_url=final_url,
                redacted_final_url=redact_url(final_url), error="",
                notes=metadata_notes(status, h.get("Content-Type", "")), timestamp_utc=utc_now()
            )
    except HTTPError as error:
        h = error.headers
        status = error.code
        return MetadataResult(
            url=url, redacted_url=redact_url(url), method=method, status=status,
            accessible_without_auth=classify_access(status),
            content_type=h.get("Content-Type", ""), content_length=h.get("Content-Length", ""),
            cache_control=h.get("Cache-Control", ""), etag=h.get("ETag", ""),
            location=h.get("Location", ""), final_url=url, redacted_final_url=redact_url(url),
            error=str(error.reason), notes=metadata_notes(status, h.get("Content-Type", "")),
            timestamp_utc=utc_now()
        )
    except URLError as error:
        return MetadataResult(
            url=url, redacted_url=redact_url(url), method=method, status="ERROR",
            accessible_without_auth=False, content_type="", content_length="",
            cache_control="", etag="", location="", final_url=url,
            redacted_final_url=redact_url(url), error=str(error.reason),
            notes="Network or DNS error. No content accessed.", timestamp_utc=utc_now()
        )


def fetch_html_for_policy_check(
    url: str,
    extra_headers: dict[str, str],
    timeout: float,
) -> tuple[int, str, str, str]:
    """GET an HTML page and return (status, content_type, final_url, decoded_html)."""
    request = Request(url, headers=build_headers(extra_headers), method="GET")
    with urlopen(request, timeout=timeout) as response:
        status = response.status
        content_type = response.headers.get("Content-Type", "")
        final_url = response.geturl()
        body = response.read(MAX_HTML_READ_BYTES)
        html = body.decode("utf-8", errors="replace")
        return status, content_type, final_url, html


def sanitize_html_for_preview(html: str) -> str:
    """
    Remove risky active markup before showing page evidence.

    Tkinter Text does not execute HTML, but sanitizing the preview keeps exports
    and copied snippets safer.
    """
    html = re.sub(r"(?is)<script[^>]*>.*?</script>", "[SCRIPT REMOVED]", html)
    html = re.sub(r"(?is)<iframe[^>]*>.*?</iframe>", lambda m: m.group(0), html)
    html = re.sub(r'(?is)\s+on\w+\s*=\s*"[^"]*"', "", html)
    html = re.sub(r"(?is)\s+on\w+\s*=\s*'[^']*'", "", html)
    html = re.sub(r"(?is)\s+on\w+\s*=\s*[^ >]*", "", html)
    return html


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


def risk_rating(hidden: bool, risky_permissions: list[str], tag: str, sandbox: str) -> tuple[str, str]:
    notes = []
    if hidden:
        notes.append("Element appears hidden, tiny, or positioned off-screen.")
    if risky_permissions:
        notes.append(f"Delegated permissions present: {', '.join(risky_permissions)}.")
    if tag in {"object", "embed"}:
        notes.append("Legacy object/embed tag increases content injection risk.")
    if tag == "iframe" and not sandbox:
        notes.append("iframe has no sandbox attribute.")
    if hidden and any(x in risky_permissions for x in {"camera", "microphone"}):
        return "High", " ".join(notes)
    if hidden and risky_permissions:
        return "Medium", " ".join(notes)
    if hidden:
        return "Medium", " ".join(notes)
    if any(x in risky_permissions for x in {"camera", "microphone", "geolocation", "payment"}):
        return "Medium", " ".join(notes)
    if risky_permissions or (tag == "iframe" and not sandbox):
        return "Low", " ".join(notes) or "iframe/media policy issue detected."
    return "Informational", "Visible or ordinary media/embed element detected."


def analyze_iframe_media(page_url: str, html: str) -> tuple[str, list[Finding]]:
    parser = MediaTagParser()
    parser.feed(html)
    findings = []
    timestamp = utc_now()
    for item in parser.tags:
        risky = sorted(set(parse_allow_tokens(item["allow"])) & RISKY_ALLOW_TOKENS)
        hidden = detect_hidden(item["style"], item["width"], item["height"])
        level, notes = risk_rating(hidden, risky, item["tag"], item["sandbox"])
        findings.append(Finding(
            page_url=page_url, redacted_page_url=redact_url(page_url),
            tag=item["tag"], src=item["src"], redacted_src=redact_url(item["src"]),
            width=item["width"], height=item["height"], style=item["style"],
            allow=item["allow"], sandbox=item["sandbox"], hidden_suspected=hidden,
            risky_permissions=", ".join(risky), risk_level=level, notes=notes,
            timestamp_utc=timestamp,
        ))
    return parser.title, findings


def write_csv(path: Path, rows: list[dict]) -> None:
    if not rows:
        raise ValueError("No rows to export.")
    keys = []
    for row in rows:
        for k in row.keys():
            if k not in keys:
                keys.append(k)
    with path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(output, fieldnames=keys)
        writer.writeheader()
        writer.writerows(rows)


def finding_markdown(metadata: list[MetadataResult], findings: list[Finding]) -> str:
    lines = [
        "# Sensitive Platform iframe/media Access-Control Report", "",
        f"Generated UTC: {utc_now()}", "",
        "## Scope and handling", "",
        "- Explicit target URLs only.",
        "- Protected media content was not downloaded or previewed.",
        "- Metadata checks used HEAD or Range probing.",
        "- URLs were redacted for common tokens/signatures where possible.",
        "",
        "## Metadata results", "",
    ]
    if metadata:
        for item in metadata:
            lines += [
                f"### {item.redacted_url}", "",
                f"- Method: `{item.method}`",
                f"- Status: `{item.status}`",
                f"- Accessible without tool-side auth: `{item.accessible_without_auth}`",
                f"- Content-Type: `{item.content_type}`",
                f"- Content-Length: `{item.content_length}`",
                f"- Cache-Control: `{item.cache_control}`",
                f"- Notes: {item.notes}", "",
            ]
    else:
        lines.append("No metadata results recorded.\n")
    lines += ["## iframe/media findings", ""]
    if findings:
        for item in findings:
            lines += [
                f"### {item.risk_level}: `{item.tag}`", "",
                f"- Page: `{item.redacted_page_url}`",
                f"- Source: `{item.redacted_src}`",
                f"- Hidden/off-screen suspected: `{item.hidden_suspected}`",
                f"- Risky delegated permissions: `{item.risky_permissions or 'none'}`",
                f"- Allow: `{item.allow or 'none'}`",
                f"- Sandbox: `{item.sandbox or 'none'}`",
                f"- Notes: {item.notes}", "",
            ]
    else:
        lines.append("No iframe/media findings recorded.\n")
    lines += [
        "## Suggested remediation", "",
        "- Strip or allowlist iframe/media tags in user-controlled content.",
        "- Enforce `Content-Security-Policy: frame-src` with only trusted providers.",
        "- Enforce `Permissions-Policy: camera=(), microphone=(), autoplay=()` unless required.",
        "- Never allow arbitrary `allow` attributes from user-controlled HTML.",
        "- For sensitive media, expected anonymous responses should be `401`, `403`, or a login redirect.",
        "",
    ]
    return "\n".join(lines)


class ReporterGui:
    def __init__(self, root: tk.Tk) -> None:
        self.root = root
        self.root.title(APP_NAME)
        self.root.geometry("1280x780")
        self.metadata_results: list[MetadataResult] = []
        self.findings: list[Finding] = []
        self.current_html_preview = ""
        self._build_ui()

    def _build_ui(self) -> None:
        main = ttk.Frame(self.root, padding=8)
        main.pack(fill=tk.BOTH, expand=True)

        scope = ttk.LabelFrame(main, text="Authorized scope", padding=8)
        scope.pack(fill=tk.X)

        ttk.Label(scope, text="Target URLs, one per line:").grid(row=0, column=0, sticky="nw")
        self.urls_text = tk.Text(scope, height=4, width=95)
        self.urls_text.grid(row=0, column=1, sticky="ew", padx=6)

        ttk.Label(scope, text="Allowed hosts/domains:").grid(row=1, column=0, sticky="w")
        self.allowed_hosts_var = tk.StringVar()
        ttk.Entry(scope, textvariable=self.allowed_hosts_var).grid(row=1, column=1, sticky="ew", padx=6)

        self.authorization_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(
            scope,
            text="I confirm I have written authorization for these targets.",
            variable=self.authorization_var,
        ).grid(row=2, column=1, sticky="w", padx=6, pady=(4, 0))
        scope.columnconfigure(1, weight=1)

        options = ttk.LabelFrame(main, text="Mode and request options", padding=8)
        options.pack(fill=tk.X, pady=(6, 0))

        self.mode_var = tk.StringVar(value="Sensitive platform metadata check")
        ttk.Combobox(
            options,
            textvariable=self.mode_var,
            values=["Sensitive platform metadata check", "Public iframe/media policy check", "Combined safe check"],
            state="readonly",
            width=38,
        ).grid(row=0, column=0, sticky="w")

        self.range_probe_var = tk.BooleanVar(value=True)
        ttk.Checkbutton(
            options, text="Use Range: bytes=0-0 for metadata checks", variable=self.range_probe_var
        ).grid(row=0, column=1, sticky="w", padx=12)

        ttk.Label(options, text="Timeout seconds:").grid(row=0, column=2, sticky="e")
        self.timeout_var = tk.StringVar(value=str(DEFAULT_TIMEOUT_SECONDS))
        ttk.Entry(options, textvariable=self.timeout_var, width=8).grid(row=0, column=3, sticky="w", padx=4)

        ttk.Label(options, text="Optional authorized headers/cookies:").grid(row=1, column=0, sticky="nw", pady=(6, 0))
        self.headers_text = tk.Text(options, height=3, width=95)
        self.headers_text.grid(row=1, column=1, columnspan=3, sticky="ew", padx=6, pady=(6, 0))
        options.columnconfigure(1, weight=1)

        buttons = ttk.Frame(main)
        buttons.pack(fill=tk.X, pady=6)
        ttk.Button(buttons, text="Run check", command=self.start_run).pack(side=tk.LEFT, padx=3)
        ttk.Button(buttons, text="Clear results", command=self.clear_results).pack(side=tk.LEFT, padx=3)
        ttk.Button(buttons, text="Export CSV", command=self.export_csv).pack(side=tk.LEFT, padx=3)
        ttk.Button(buttons, text="Export Markdown", command=self.export_markdown).pack(side=tk.LEFT, padx=3)
        ttk.Button(buttons, text="Export JSON", command=self.export_json).pack(side=tk.LEFT, padx=3)
        ttk.Button(buttons, text="Open selected URL visibly", command=self.open_selected_url).pack(side=tk.LEFT, padx=3)

        self.status_var = tk.StringVar(value="Ready. The tool will not preview or save protected media.")
        ttk.Label(main, textvariable=self.status_var).pack(fill=tk.X)

        paned = ttk.PanedWindow(main, orient=tk.HORIZONTAL)
        paned.pack(fill=tk.BOTH, expand=True, pady=(6, 0))

        left = ttk.Frame(paned)
        right = ttk.Frame(paned)
        paned.add(left, weight=3)
        paned.add(right, weight=2)

        self.tree = ttk.Treeview(
            left,
            columns=("type", "risk_or_status", "method_tag", "hidden", "permissions", "url"),
            show="headings",
        )
        headings = {
            "type": "Type", "risk_or_status": "Risk/Status", "method_tag": "Method/Tag",
            "hidden": "Hidden?", "permissions": "Permissions", "url": "URL / Source",
        }
        for col, label in headings.items():
            self.tree.heading(col, text=label)
            self.tree.column(col, width=130 if col != "url" else 480)
        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        self.tree.bind("<<TreeviewSelect>>", self.on_select)

        yscroll = ttk.Scrollbar(left, orient=tk.VERTICAL, command=self.tree.yview)
        yscroll.pack(side=tk.RIGHT, fill=tk.Y)
        self.tree.configure(yscrollcommand=yscroll.set)

        notebook = ttk.Notebook(right)
        notebook.pack(fill=tk.BOTH, expand=True)
        self.details_text = tk.Text(notebook, wrap=tk.WORD)
        self.report_text = tk.Text(notebook, wrap=tk.WORD)
        self.html_text = tk.Text(notebook, wrap=tk.WORD)
        notebook.add(self.details_text, text="Selected evidence")
        notebook.add(self.report_text, text="Report draft")
        notebook.add(self.html_text, text="HTML preview")

    def get_target_urls(self) -> list[str]:
        urls = []
        for line in self.urls_text.get("1.0", tk.END).splitlines():
            line = line.strip()
            if line and not line.startswith("#"):
                urls.append(line)
        if not urls:
            raise ValueError("At least one target URL is required.")
        return urls

    def get_timeout(self) -> float:
        try:
            timeout = float(self.timeout_var.get().strip())
        except ValueError as exc:
            raise ValueError("Timeout must be a number.") from exc
        if timeout <= 0 or timeout > 120:
            raise ValueError("Timeout must be between 1 and 120 seconds.")
        return timeout

    def start_run(self) -> None:
        threading.Thread(target=self.run_checks, daemon=True).start()

    def run_checks(self) -> None:
        try:
            if not self.authorization_var.get():
                raise ValueError("Written authorization confirmation is required.")
            urls = self.get_target_urls()
            allowed_hosts = parse_allowed_hosts(self.allowed_hosts_var.get())
            extra_headers = parse_header_lines(self.headers_text.get("1.0", tk.END))
            timeout = self.get_timeout()
            mode = self.mode_var.get()
            for url in urls:
                validate_url(url, allowed_hosts)

            self.set_status("Running checks...")
            new_metadata = []
            new_findings = []
            html_preview_parts = []

            for index, url in enumerate(urls, start=1):
                self.set_status(f"[{index}/{len(urls)}] Checking {redact_url(url)}")

                last_meta = None
                if mode in {"Sensitive platform metadata check", "Combined safe check"}:
                    last_meta = metadata_probe(url, extra_headers, timeout, self.range_probe_var.get())
                    new_metadata.append(last_meta)

                if mode in {"Public iframe/media policy check", "Combined safe check"}:
                    should_fetch_html = True
                    if mode == "Combined safe check" and last_meta:
                        ct = last_meta.content_type.lower()
                        if any(x in ct for x in ("video", "audio", "octet-stream", "image/")):
                            should_fetch_html = False
                        if last_meta.status in {401, 403}:
                            should_fetch_html = False
                    if should_fetch_html:
                        try:
                            status, content_type, final_url, html = fetch_html_for_policy_check(url, extra_headers, timeout)
                            if "html" in content_type.lower() or mode == "Public iframe/media policy check":
                                title, page_findings = analyze_iframe_media(final_url, html)
                                new_findings.extend(page_findings)
                                safe_preview = sanitize_html_for_preview(html[:10000])
                                html_preview_parts.append(
                                    f"URL: {redact_url(url)}\n"
                                    f"Final URL: {redact_url(final_url)}\n"
                                    f"HTTP status: {status}\n"
                                    f"Content-Type: {content_type}\n"
                                    f"Title: {title or '(none found)'}\n"
                                    f"{'-' * 72}\n{safe_preview}\n\n"
                                )
                            else:
                                html_preview_parts.append(
                                    f"Skipped HTML analysis for {redact_url(url)}; Content-Type was {content_type!r}.\n\n"
                                )
                        except Exception as exc:
                            html_preview_parts.append(f"HTML policy check failed for {redact_url(url)}: {exc}\n\n")

            self.metadata_results.extend(new_metadata)
            self.findings.extend(new_findings)
            self.current_html_preview = "\n".join(html_preview_parts)
            self.root.after(0, self.render_results)
            self.set_status("Checks complete.")
        except Exception as exc:
            self.set_status(f"Error: {exc}")
            self.root.after(0, lambda: messagebox.showerror("Error", str(exc)))

    def render_results(self) -> None:
        for item in self.tree.get_children():
            self.tree.delete(item)
        for idx, meta in enumerate(self.metadata_results):
            self.tree.insert("", tk.END, iid=f"m:{idx}", values=(
                "metadata", meta.status, meta.method, "", "", meta.redacted_url,
            ))
        for idx, finding in enumerate(self.findings):
            self.tree.insert("", tk.END, iid=f"f:{idx}", values=(
                "iframe/media", finding.risk_level, finding.tag,
                finding.hidden_suspected, finding.risky_permissions, finding.redacted_src,
            ))
        self.report_text.delete("1.0", tk.END)
        self.report_text.insert(tk.END, finding_markdown(self.metadata_results, self.findings))
        self.html_text.delete("1.0", tk.END)
        self.html_text.insert(
            tk.END,
            self.current_html_preview or "No HTML preview available. Sensitive metadata mode does not fetch/display bodies."
        )

    def on_select(self, _event=None) -> None:
        selected = self.tree.selection()
        if not selected:
            return
        item_id = selected[0]
        if item_id.startswith("m:"):
            meta = self.metadata_results[int(item_id.split(":", 1)[1])]
            text = "\n".join([
                "Metadata result", "=" * 72,
                f"URL: {meta.redacted_url}",
                f"Method: {meta.method}",
                f"Status: {meta.status}",
                f"Accessible without tool-side auth: {meta.accessible_without_auth}",
                f"Content-Type: {meta.content_type}",
                f"Content-Length: {meta.content_length}",
                f"Cache-Control: {meta.cache_control}",
                f"ETag: {meta.etag}",
                f"Location: {redact_url(meta.location)}",
                f"Final URL: {meta.redacted_final_url}",
                f"Error: {meta.error}",
                f"Notes: {meta.notes}",
                f"Timestamp UTC: {meta.timestamp_utc}",
            ])
        else:
            finding = self.findings[int(item_id.split(":", 1)[1])]
            text = "\n".join([
                "iframe/media finding", "=" * 72,
                f"Risk level: {finding.risk_level}",
                f"Page URL: {finding.redacted_page_url}",
                f"Tag: {finding.tag}",
                f"Source: {finding.redacted_src}",
                f"Hidden/off-screen suspected: {finding.hidden_suspected}",
                f"Risky delegated permissions: {finding.risky_permissions or 'none'}",
                f"Width: {finding.width}",
                f"Height: {finding.height}",
                f"Style: {finding.style or 'none'}",
                f"Allow: {finding.allow or 'none'}",
                f"Sandbox: {finding.sandbox or 'none'}",
                f"Notes: {finding.notes}",
                f"Timestamp UTC: {finding.timestamp_utc}",
                "",
                "Report language:",
                "The page contains iframe/media content that may enable hidden third-party loading "
                "or permission delegation. Browser permission prompts should still prevent silent "
                "camera/microphone access, but weak CSP/Permissions-Policy and deceptive UI can increase risk.",
            ])
        self.details_text.delete("1.0", tk.END)
        self.details_text.insert(tk.END, text)

    def selected_raw_url(self) -> str | None:
        selected = self.tree.selection()
        if not selected:
            return None
        item_id = selected[0]
        if item_id.startswith("m:"):
            return self.metadata_results[int(item_id.split(":", 1)[1])].url
        finding = self.findings[int(item_id.split(":", 1)[1])]
        return finding.src or finding.page_url

    def open_selected_url(self) -> None:
        url = self.selected_raw_url()
        if not url:
            messagebox.showinfo("No URL", "Select a row with a URL first.")
            return

        if has_sensitive_query(url):
            proceed = messagebox.askyesno(
                "Sensitive URL warning",
                "The selected URL appears to contain token/signature/session-like query parameters.\n\n"
                "Opening it in your browser may load protected content or leak authorization material "
                "through browser history, extensions, referrers, or logs.\n\n"
                "Continue only if this is explicitly authorized."
            )
            if not proceed:
                self.set_status("Open cancelled.")
                return

        webbrowser.open(url)

    def export_csv(self) -> None:
        rows = []
        for item in self.metadata_results:
            row = asdict(item)
            row["record_type"] = "metadata"
            rows.append(row)
        for item in self.findings:
            row = asdict(item)
            row["record_type"] = "iframe_media"
            rows.append(row)
        if not rows:
            messagebox.showinfo("No data", "No results to export.")
            return
        path = filedialog.asksaveasfilename(title="Save CSV report", defaultextension=".csv",
                                            filetypes=[("CSV files", "*.csv")])
        if path:
            write_csv(Path(path), rows)
            self.set_status(f"CSV exported: {path}")

    def export_markdown(self) -> None:
        path = filedialog.asksaveasfilename(title="Save Markdown report", defaultextension=".md",
                                            filetypes=[("Markdown files", "*.md"), ("Text files", "*.txt")])
        if path:
            Path(path).write_text(finding_markdown(self.metadata_results, self.findings), encoding="utf-8")
            self.set_status(f"Markdown exported: {path}")

    def export_json(self) -> None:
        path = filedialog.asksaveasfilename(title="Save JSON report", defaultextension=".json",
                                            filetypes=[("JSON files", "*.json")])
        if path:
            payload = {
                "generated_utc": utc_now(),
                "metadata_results": [asdict(x) for x in self.metadata_results],
                "iframe_media_findings": [asdict(x) for x in self.findings],
                "handling": {
                    "protected_media_downloaded": False,
                    "protected_media_previewed": False,
                    "url_guessing_or_enumeration": False,
                    "explicit_urls_only": True,
                },
            }
            Path(path).write_text(json.dumps(payload, indent=2), encoding="utf-8")
            self.set_status(f"JSON exported: {path}")

    def clear_results(self) -> None:
        self.metadata_results.clear()
        self.findings.clear()
        self.current_html_preview = ""
        self.render_results()
        self.details_text.delete("1.0", tk.END)
        self.report_text.delete("1.0", tk.END)
        self.html_text.delete("1.0", tk.END)
        self.set_status("Results cleared.")

    def set_status(self, message: str) -> None:
        self.root.after(0, lambda: self.status_var.set(message))


def main() -> None:
    root = tk.Tk()
    ReporterGui(root)
    root.mainloop()


if __name__ == "__main__":
    main()
