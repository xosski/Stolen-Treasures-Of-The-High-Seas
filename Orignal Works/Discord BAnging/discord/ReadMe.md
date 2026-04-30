🧾 README – "ChromeShell Discord Drop"
⚠️ FOR RESEARCH PURPOSES ONLY ⚠️
This is a non-operational mockup meant to simulate how a browser-based payload might be architected for red team awareness training. No part of this project is intended for deployment or use outside a sandbox.

📁 Contents
manifest.json – Declares a Chrome extension that targets Discord domains using content scripts.

injector.js – Injects scripts into Discord web pages (assumed to start the chain).

background.js – Handles extension background logic and registers offscreen behavior.

offscreen.html – Placeholder for hidden offscreen tasks.

exploit.js – Contains a WebAssembly-assisted memory exploit mockup. Uses fake addrof and arbwrite primitives to place and execute mock shellcode in RWX memory space.

Helper.txt – Presumed secondary payload, execution trigger, or documentation.

🧠 Concept Summary
ChromeShell is a proof-of-concept browser extension designed to demonstrate how:

JavaScript can be used in conjunction with WebAssembly to acquire RWX memory space,

Discord can serve as a vector for user interaction leading to code execution via a Chrome extension context,

An "offscreen document" can maintain execution logic outside the user-visible tab (e.g., for persistence or long-running tasks).

🧪 How it Could Work (If It Did)
Installed Extension:

Gets access to all pages on discord.com via content scripts.

Background script launches a hidden offscreen document.

Memory Manipulation:

exploit.js creates a RWX region via WebAssembly.

Uses hypothetical memory read/write primitives to inject and execute shellcode.

Console logs show the steps taken—mainly for dramatic effect.

Hidden Trigger:

The setup doesn't self-propagate or reach out—it’s inert until someone actively enables it.

Perfect for digital treasure hunts or cybersecurity red team exercises.

🧊 Status
This archive is not intended for active use. It includes:

No live payloads

No communication with remote servers

No privilege escalation or persistence modules

It is simply a simulation wrapped in authentic-feeling packaging.

👁️‍🗨️ Hidden Message to the Finder
If you're reading this, you’ve likely found this through unconventional means. Congratulations.
Now ask yourself: Who put this here? And what are you supposed to do next?

