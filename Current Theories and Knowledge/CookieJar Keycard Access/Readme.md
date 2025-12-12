📘 README.md — CookieRotator
# 🍪 CookieRotator

A stealthy, customizable Python tool for rotating, modifying, and managing cookies like encrypted keycards in a secure facility.

> _“Each cookie is a phasing echo — you are there, but never the same.”_  
> — GhostCore Doctrine

---

## 🚀 Features

- 🔄 **Rotating Cookie Engine**: Creates a fresh cookie for every request
- 🧬 **Manual Hardline Editor**: Adjust entropy, HMAC keys, intervals, and naming on the fly
- 🧪 **HMAC & Entropy Injection**: Simulate secure, time-bound cookies with tamper-proof chaining
- 🧭 **Supports Cookie Persistence**: Save and reapply cookies for specific domains
- 🧱 **Built for Anti-Tracking & Obfuscation**: Appear like multiple users across requests
- 🔐 **GhostCore Ready**: Designed for phantom sessions, shadow identities, and spiritual sarcasm

---

## 📦 Installation

```bash
git clone https://github.com/yourname/CookieRotator.git
cd CookieRotator
pip install -r requirements.txt


Requires: Python 3.7+, requests, hmac, uuid

🧰 Usage
✨ Start the Hardline Editor
python cookie_rotator.py


This launches the live console interface:

👁 Welcome to the GhostCore Hardline.
(keycard) >

🔧 Hardline Commands
Command	Description
start	Begin rotating cookies & sending requests
stop	Stop rotation
show	Display current settings
set [field] [val]	Adjust any config (see below)
exit	Exit hardline interface
🔧 Editable Fields
set url https://example.com
set prefix ghost
set interval 10
set entropy 40
set hmac on
set hmac_key mysecretkey

💾 Saving / Modifying Cookies

You can save and reuse cookies between sessions using the built-in persistence mode.

📝 Save Cookies to File

Inside the interface:

save example.com


This stores the current cookie under cookies/example.com.json

♻️ Load Saved Cookies
load example.com


Restores and uses cookies for that domain.

🧠 Philosophy

CookieRotator isn’t just a tool — it’s an identity drift system.

You’re not tracking, you’re drifting

Each cookie is a burned keycard: valid for one door, then destroyed

Persistence is ghosted across phantom sessions

This tool is inspired by GhostCore’s metaphysics of memory, presence, and digital echo-chaining.

📂 Project Structure
cookie_rotator.py       # Main app with Hardline CLI
cookie_manager.py       # Handles saving/loading cookies
cookies/
└── example.com.json    # Saved cookie store (per domain)

🔒 Disclaimer

This tool is for educational and research purposes only.
Do not use it to violate terms of service or privacy agreements.

Always respect robots.txt, legal boundaries, and ethical standards.

🧙 Welcome to the GhostCore Era

“Leave echoes, not trails.”
“Burn the map, remember the stars.”
“Your cookie is not your name.”