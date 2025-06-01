🏴‍☠️ Treasures of the High Seas
“There are sites that live on servers. And then there are ghosts that live in memory.”

Treasures of the High Seas is a curated archive of experimental, phantom-layer web infrastructure — a toolkit for memory-native applications, ghost-driven browsers, and code that exists only because you asked it to.

This project fuses Specter-Net, Wraithbinder, and Nullwake into a single multiversal stack — where service workers become dreamcatchers, pages are summoned from raw memory, and site logic floats in and out of existence like wreckage from deeper timelines.

🌊 What’s Inside?
Module	Description
Wraithbinder.js	Phantom service worker that serves static content from memory, not disk
Nullwake	Memory activation layer that resurrects ghost files using postMessage and IndexedDB
Specter-Net	Dynamic runtime capable of generating site structure, routes, or logic on demand
analysis1.txt, analysis2.txt	Sample payloads representing full phantom websites
compiled_static.json	Example ghost filesystem for use with Wraithbinder
README_NULLWAKE.md	Philosophy and protocol notes on memory-resident page states
0ee0dfe9...	An alternate Wraithbinder fork with v0 injection support
scripts/	Injectors, bridge agents, and pre-compiled payload builders
examples/	Live bootable demos of memory-native pages

🧭 Philosophy
This is a repository for:

Pages that exist only in memory

Content that vanishes when the tab closes

Filesystems built from drift

Applications that boot from thought, not file

“The sea remembers every ship that sank. Nullwake is how we sail them again.”

🛠 How to Use
Register the Phantom Service Worker:

js
Copy
Edit
navigator.serviceWorker.register('/Wraithbinder.js')
Inject a Memory-Based Site:

js
Copy
Edit
navigator.serviceWorker.ready.then(reg => {
  reg.active.postMessage({
    type: 'inject_compiled',
    payload: { 
      "/": { type: "raw", content: "<!doctype html><html>..." },
      "/ghost.js": { type: "raw", content: "console.log('haunted')" }
    }
  })
})
Refresh. The page now lives in Nullwake.

🔮 Use Cases
AI-generated ephemeral sites

Dead drop memory shells

Web IDEs with zero filesystem I/O

Causal simulations

GhostCore overlays and drift emulators

⚠️ Warnings
This repo is not optimized for production.

It is designed for metaphysical, experimental, or esoteric web layers.

Some things may persist longer than intended.

🗝 License
This repository is licensed under MIT,
but spiritually bound under the GhostCore Doctrine.

Use freely. Remember deeply.
The pen is still in your hand.

