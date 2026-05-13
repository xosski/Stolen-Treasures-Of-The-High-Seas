#!/usr/bin/env python3
"""
Safe access-control exposure checker for authorized pentesting.

This tool checks whether explicitly supplied URLs, or URLs built from an
explicit hash list and URL template, are reachable without downloading or
displaying protected content. It records HTTP status and metadata only.

It intentionally does not brute-force, mutate, enumerate adjacent hashes, or
save response bodies. Use only on systems you own or are authorized to test.
"""

from __future__ import annotations

import argparse
import csv
import re
import sys
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable
from urllib.error import HTTPError, URLError
from urllib.parse import urlparse
from urllib.request import Request, urlopen


URL_RE = re.compile(r"https?://[^\s\"'<>]+", re.IGNORECASE)
DEFAULT_TIMEOUT_SECONDS = 15
DEFAULT_DELAY_SECONDS = 0.5
BLOCKED_HOST_SUFFIXES = (
)


@dataclass(frozen=True)
class ProbeResult:
    url: str
    method: str
    status: int | str
    accessible_without_auth: bool
    content_type: str
    content_length: str
    cache_control: str
    etag: str
    final_url: str
    error: str


def parse_header(raw_header: str) -> tuple[str, str]:
    if ":" not in raw_header:
        raise argparse.ArgumentTypeError(
            f"Header must use 'Name: value' format: {raw_header!r}"
        )
    name, value = raw_header.split(":", 1)
    name = name.strip()
    value = value.strip()
    if not name or not value:
        raise argparse.ArgumentTypeError(
            f"Header must use 'Name: value' format: {raw_header!r}"
        )
    return name, value


def normalize_host(host: str) -> str:
    return host.strip().lower().rstrip(".")


def is_allowed_host(host: str, allowed_hosts: set[str]) -> bool:
    host = normalize_host(host)
    return any(host == allowed or host.endswith(f".{allowed}") for allowed in allowed_hosts)


def is_blocked_host(host: str) -> bool:
    host = normalize_host(host)
    return any(host == blocked or host.endswith(f".{blocked}") for blocked in BLOCKED_HOST_SUFFIXES)


def extract_urls(paths: Iterable[Path]) -> list[str]:
    urls: list[str] = []
    seen: set[str] = set()
    for path in paths:
        text = path.read_text(encoding="utf-8", errors="ignore")
        for match in URL_RE.finditer(text):
            url = match.group(0).rstrip(".,);]")
            if url not in seen:
                seen.add(url)
                urls.append(url)
    return urls


def urls_from_hashes(hash_file: Path, url_template: str) -> list[str]:
    if "{hash}" not in url_template:
        raise ValueError("--url-template must include the literal placeholder {hash}")

    urls: list[str] = []
    seen: set[str] = set()
    for line in hash_file.read_text(encoding="utf-8", errors="ignore").splitlines():
        value = line.strip()
        if not value or value.startswith("#"):
            continue
        url = url_template.replace("{hash}", value)
        if url not in seen:
            seen.add(url)
            urls.append(url)
    return urls


def validate_urls(urls: Iterable[str], allowed_hosts: set[str]) -> list[str]:
    valid_urls: list[str] = []
    for url in urls:
        parsed = urlparse(url)
        if parsed.scheme not in {"http", "https"} or not parsed.netloc:
            raise ValueError(f"Not an HTTP(S) URL: {url}")

        host = parsed.hostname or ""
        if is_blocked_host(host):
            raise ValueError(
                f"Refusing to probe third-party paywalled content host {host!r}. "
                "Use this tool only on systems you own or have written authorization to test."
            )
        if not is_allowed_host(host, allowed_hosts):
            raise ValueError(
                f"URL host {host!r} is not in --allow-host. "
                "Add the exact authorized host or parent domain to continue."
            )
        valid_urls.append(url)
    return valid_urls


def probe_url(
    url: str,
    headers: dict[str, str],
    timeout: float,
    range_probe: bool,
) -> ProbeResult:
    method = "GET" if range_probe else "HEAD"
    request_headers = {
        "User-Agent": "authorized-access-control-audit/1.0",
        **headers,
    }
    if range_probe:
        request_headers["Range"] = "bytes=0-0"

    request = Request(url, headers=request_headers, method=method)
    try:
        with urlopen(request, timeout=timeout) as response:
            status = response.status
            response_headers = response.headers
            # Do not read or display the body. Closing the response is enough.
            return ProbeResult(
                url=url,
                method=method,
                status=status,
                accessible_without_auth=status in {200, 206, 301, 302, 303, 307, 308},
                content_type=response_headers.get("Content-Type", ""),
                content_length=response_headers.get("Content-Length", ""),
                cache_control=response_headers.get("Cache-Control", ""),
                etag=response_headers.get("ETag", ""),
                final_url=response.geturl(),
                error="",
            )
    except HTTPError as error:
        response_headers = error.headers
        return ProbeResult(
            url=url,
            method=method,
            status=error.code,
            accessible_without_auth=error.code in {200, 206, 301, 302, 303, 307, 308},
            content_type=response_headers.get("Content-Type", ""),
            content_length=response_headers.get("Content-Length", ""),
            cache_control=response_headers.get("Cache-Control", ""),
            etag=response_headers.get("ETag", ""),
            final_url=url,
            error=str(error.reason),
        )
    except URLError as error:
        return ProbeResult(
            url=url,
            method=method,
            status="ERROR",
            accessible_without_auth=False,
            content_type="",
            content_length="",
            cache_control="",
            etag="",
            final_url=url,
            error=str(error.reason),
        )


def write_csv(path: Path, results: Iterable[ProbeResult]) -> None:
    with path.open("w", newline="", encoding="utf-8") as output:
        writer = csv.DictWriter(
            output,
            fieldnames=[
                "url",
                "method",
                "status",
                "accessible_without_auth",
                "content_type",
                "content_length",
                "cache_control",
                "etag",
                "final_url",
                "error",
            ],
        )
        writer.writeheader()
        for result in results:
            writer.writerow(result.__dict__)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description=(
            "Check explicit URLs or hash-template URLs for anonymous HTTP "
            "reachability without downloading/displaying content."
        )
    )
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument(
        "--input",
        action="append",
        type=Path,
        help="Text/HTML file to extract explicit URLs from. Repeat for multiple files.",
    )
    source.add_argument(
        "--hash-file",
        type=Path,
        help="File containing one explicit hash/id per line for an authorized target.",
    )
    parser.add_argument(
        "--url-template",
        help="Template used with --hash-file, for example https://app.test/files/{hash}.",
    )
    parser.add_argument(
        "--allow-host",
        action="append",
        required=True,
        help="Authorized host/domain to probe. Repeat for multiple hosts.",
    )
    parser.add_argument(
        "--header",
        action="append",
        type=parse_header,
        default=[],
        help="Optional request header in 'Name: value' format. Repeat as needed.",
    )
    parser.add_argument(
        "--range-probe",
        action="store_true",
        help="Use GET with Range: bytes=0-0 instead of HEAD for servers that reject HEAD.",
    )
    parser.add_argument(
        "--delay",
        type=float,
        default=DEFAULT_DELAY_SECONDS,
        help=f"Seconds to wait between requests. Default: {DEFAULT_DELAY_SECONDS}.",
    )
    parser.add_argument(
        "--timeout",
        type=float,
        default=DEFAULT_TIMEOUT_SECONDS,
        help=f"Request timeout in seconds. Default: {DEFAULT_TIMEOUT_SECONDS}.",
    )
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("access_control_audit.csv"),
        help="CSV report path. Default: access_control_audit.csv.",
    )
    return parser


def main(argv: list[str]) -> int:
    parser = build_parser()
    args = parser.parse_args(argv)

    if args.hash_file and not args.url_template:
        parser.error("--hash-file requires --url-template")
    if args.input and args.url_template:
        parser.error("--url-template is only valid with --hash-file")

    allowed_hosts = {normalize_host(host) for host in args.allow_host}
    headers = dict(args.header)

    try:
        urls = (
            urls_from_hashes(args.hash_file, args.url_template)
            if args.hash_file
            else extract_urls(args.input)
        )
        urls = validate_urls(urls, allowed_hosts)
    except (OSError, ValueError) as error:
        print(f"error: {error}", file=sys.stderr)
        return 2

    if not urls:
        print("No URLs found to probe.")
        return 0

    results: list[ProbeResult] = []
    for index, url in enumerate(urls, start=1):
        result = probe_url(url, headers, args.timeout, args.range_probe)
        results.append(result)
        print(
            f"[{index}/{len(urls)}] {result.status} "
            f"anonymous_access={result.accessible_without_auth} {url}"
        )
        if index < len(urls) and args.delay > 0:
            time.sleep(args.delay)

    write_csv(args.output, results)
    print(f"Wrote report: {args.output}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
