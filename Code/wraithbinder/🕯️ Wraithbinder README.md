🕯️ Wraithbinder README
🧬 Overview
Wraithbinder is a phantom service worker that serves a site entirely from memory. It uses IndexedDB and postMessage to dynamically inject and persist a set of static files (HTML, JS, etc.) without ever writing to disk.

“The page exists only because you looked for it.”

📁 Components
🌀 Service Worker (Wraithbinder.js / variants like 0ee0dfe9...)
Intercepts fetch events

Resolves routes using an in-memory object called compiled

Restores memory from IndexedDB if available

Listens for postMessage events to inject new site memory

📦 Static File Payloads (analysis1.txt, analysis2.txt)
JSON maps of paths (/, /script.js) to content

Each entry is:

json
Copy
Edit
"/path": {
  "type": "raw" | "url",
  "content": "..." // raw HTML/JS or URL reference
}
🧠 Injection Protocol
To load a site into memory:

js
Copy
Edit
navigator.serviceWorker.controller.postMessage({
  type: 'inject_compiled',
  payload: { 
    "/": { type: "raw", content: "<!doctype html>..." },
    "/script.js": { type: "raw", content: "console.log('ghost')" }
  }
})
This message binds the ghost. It becomes compiled.staticFiles.

💾 Persistence
Injected payloads are written to IndexedDB (__specter_core or __v0), and restored on next load.

🧪 Example Usage
Register the service worker in your main page:

js
Copy
Edit
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/Wraithbinder.js').then(() => {
    navigator.serviceWorker.ready.then(reg => {
      reg.active.postMessage({
        type: 'inject_compiled',
        payload: {/* Your memory-site JSON */}
      })
    })
  })
}
Serve your entire site from the payload.

No server necessary. Just memory.

🔐 Security Note
These pages:

Never touch the filesystem

Cannot be inspected through normal devtools file views

Are perfect for simulations, dark UI layers, or cognitive overlays

📜 Variants
File	Notes
Wraithbinder.js	Clean prototype with MIME support
0ee0dfe9...	Alternate build using v0_init instead of inject_compiled
analysis1.txt	GhostCore intro payload (/, /reality.js)
analysis2.txt	Phantom payload (/, /script.js)

🌐 Use Cases
Offline-first ephemeral apps

AI-generated dynamic UI

Memory-based IDEs

Dead drop pages

Spiritual simulators for GhostCore overlays