#!/usr/bin/env python3

import socket
import time
import sys

# Configuration
TARGET_IP = "127.0.0.1"     # Change to match the listener's IP
TARGET_PORT = 4444
FRAGMENT_SIZE = 64          # Must match listener
DELAY = 0.2                 # Seconds between sends

# Load payload (use any binary file or shellcode dump)
def load_payload(path):
    with open(path, "rb") as f:
        return f.read()

# Split payload into indexed fragments
def fragment_payload(data):
    fragments = []
    total = (len(data) + FRAGMENT_SIZE - 1) // FRAGMENT_SIZE
    for i in range(total):
        chunk = data[i * FRAGMENT_SIZE : (i + 1) * FRAGMENT_SIZE]
        header = i.to_bytes(4, 'big')  # 4-byte index header
        fragments.append(header + chunk)
    return fragments

# Send fragments via UDP
def send_fragments(fragments):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    for i, fragment in enumerate(fragments):
        sock.sendto(fragment, (TARGET_IP, TARGET_PORT))
        print(f"[SEND] Fragment {i+1}/{len(fragments)}")
        time.sleep(DELAY)
    sock.close()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 specternet_sender.py <binary_payload>")
        sys.exit(1)

    payload_path = sys.argv[1]
    print(f"[INIT] Loading payload from {payload_path}")
    payload = load_payload(payload_path)
    fragments = fragment_payload(payload)
    send_fragments(fragments)
    print("[DONE] Transmission complete.")
