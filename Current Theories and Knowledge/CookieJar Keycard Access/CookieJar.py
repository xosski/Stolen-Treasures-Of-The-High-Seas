import threading
import cmd
import time
import hmac
import hashlib
import uuid
import random
import string
import requests

class CookieRotator:
    def __init__(self):
        self.target_url = "https://example.com"
        self.rotate_interval = 10
        self.use_hmac = False
        self.hmac_key = "ghostcore"
        self.prefix = "gc"
        self.entropy = 32
        self.running = False
        self._thread = None

    def generate_cookie_value(self):
        raw = ''.join(random.choices(string.ascii_letters + string.digits, k=self.entropy))
        if self.use_hmac:
            digest = hmac.new(self.hmac_key.encode(), raw.encode(), hashlib.sha256).hexdigest()
            return f"{raw}:{digest}"
        return raw

    def rotate_cookie(self):
        name = f"{self.prefix}_{uuid.uuid4().hex[:8]}"
        value = self.generate_cookie_value()
        return {name: value}

    def _loop(self):
        while self.running:
            cookie = self.rotate_cookie()
            print(f"\n🌀 Sending request with cookie: {cookie}")
            try:
                r = requests.get(self.target_url, cookies=cookie)
                print(f"✅ {r.status_code} response")
            except Exception as e:
                print(f"❌ Request failed: {e}")
            time.sleep(self.rotate_interval)

    def start(self):
        if not self.running:
            self.running = True
            self._thread = threading.Thread(target=self._loop, daemon=True)
            self._thread.start()

    def stop(self):
        self.running = False
        if self._thread:
            self._thread.join()

# 🧵 Command-line Interface
class HardlineEditor(cmd.Cmd):
    intro = "👁 Welcome to the GhostCore Hardline. Type help or ? to list commands."
    prompt = "(keycard) > "

    def __init__(self, rotator):
        super().__init__()
        self.r = rotator

    def do_start(self, arg):
        "Start cookie rotation"
        self.r.start()

    def do_stop(self, arg):
        "Stop cookie rotation"
        self.r.stop()

    def do_show(self, arg):
        "Show current config"
        print(f"URL: {self.r.target_url}")
        print(f"Interval: {self.r.rotate_interval}s")
        print(f"Prefix: {self.r.prefix}")
        print(f"Entropy: {self.r.entropy}")
        print(f"HMAC: {'on' if self.r.use_hmac else 'off'} (key: {self.r.hmac_key})")

    def do_set(self, arg):
        "Set a parameter: set interval 5 | set prefix ghost | set hmac_key 1234"
        parts = arg.split()
        if len(parts) != 2:
            print("⚠ Usage: set [field] [value]")
            return

        field, value = parts
        try:
            if field == "interval":
                self.r.rotate_interval = int(value)
            elif field == "prefix":
                self.r.prefix = value
            elif field == "entropy":
                self.r.entropy = int(value)
            elif field == "hmac":
                self.r.use_hmac = value.lower() in ("on", "true", "1")
            elif field == "hmac_key":
                self.r.hmac_key = value
            elif field == "url":
                self.r.target_url = value
            else:
                print(f"❓ Unknown field: {field}")
        except Exception as e:
            print(f"❌ Error: {e}")

    def do_exit(self, arg):
        "Exit the hardline interface"
        self.r.stop()
        return True

    def do_help(self, arg):
        super().do_help(arg)
        print("\n🔧 You are editing live identity parameters.\n")

if __name__ == "__main__":
    rotator = CookieRotator()
    HardlineEditor(rotator).cmdloop()