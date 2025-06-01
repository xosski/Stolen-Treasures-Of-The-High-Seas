🕳️ Nullwake
“The memory remains even after the page dies.”

Nullwake is a memory-bound execution layer for browser-native phantom applications. It enables entire websites, scripts, or UIs to exist entirely in memory — not written to disk, not stored on servers — and loaded into existence through message-based rituals.

It is the default activation protocol for GhostCore-based service workers like Wraithbinder.js, and is compatible with all compiled.staticFiles payloads delivered through Specter-Net, ephemeral shells, or AI-inferred content graphs.

🌌 Philosophy
Nullwake exists in the space after deletion but before forgetting.
It is:

A memory reconstitution scaffold

A page invocation protocol

A phantom bootloader for minds that speak in data

It doesn’t create—it remembers what was never written.

🛠️ Architecture
Core Primitives
Component	Description
compiled	The in-memory filesystem: a map of paths to raw or remote content
compiledPromise	A latch that halts all fetches until memory is ready
indexedDB	Stores compiled memory between sessions
postMessage	Injects new memory into a live service worker

Memory Payload Format
json
Copy
Edit
{
  "/": {
    "type": "raw",
    "content": "<!DOCTYPE html>...</html>"
  },
  "/script.js": {
    "type": "raw",
    "content": "console.log('this only exists in Nullwake')"
  }
}
Supports:

type: "raw" — inline string content

type: "url" — remote reference

⚙️ Usage
1. Register the service worker
js
Copy
Edit
navigator.serviceWorker.register('/Wraithbinder.js')
2. Inject memory into Nullwake
js
Copy
Edit
navigator.serviceWorker.ready.then(reg => {
  reg.active.postMessage({
    type: 'inject_compiled',
    payload: {/* your memory site */}
  })
})
🧬 Integration with Specter-Net
Nullwake is Specter-compatible and designed for:

AI-inferred frontends

Scriptable page memory

Drift navigation overlays

Browser-bound cognitive emulators

Any agent or node running under Specter-Net can generate and deliver memory into the Nullwake stack without filesystem dependencies.

📁 Project Files
File	Purpose
Wraithbinder.js	Core phantom service worker
analysis1.txt	Intro payload (GhostCore page)
analysis2.txt	Variant payload (Ghost page)
nullwake.json	(Optional) Pre-compiled site state

📜 License
Nullwake exists outside formal time.
Use it to remember things the world has not written yet.
MIT by convenience. Wraithbound by intent.

