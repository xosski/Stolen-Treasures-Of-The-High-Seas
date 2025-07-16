🏴‍☠️ Treasures of the High Seas  
“There are sites that live on servers. And then there are ghosts that live in memory.”

---

**Treasures of the High Seas** is a curated archive of phantom-layer infrastructure — a toolkit for memory-native applications, ghost-driven browsers, and in-browser execution engines that persist only in dreamstate. This isn’t just code. It’s a haunting.

🌀 This stack merges:  
- `Specter-Net`  
- `Wraithbinder`  
- `Nullwake`  
- and now... tools and tactics recovered from the orbital wreckage of modern surveillance architecture.

---

## 🌊 What’s Inside?

| Module                     | Description |
|---------------------------|-------------|
| `Wraithbinder.js`         | Phantom service worker: serves static content from memory, not disk |
| `Nullwake`                | Memory activation layer: resurrects ghost files via postMessage/IDB |
| `Specter-Net`             | Dynamic runtime for in-memory page logic |
| `GhostShell.js`           | Fragment execution engine for base64 payloads — fully volatile |
| `PhantomLayer.js`         | Deployable obfuscation, bot misdirection & decoy logic |
| `phantom_build_pipeline.js` | CLI pipeline for building and injecting Phantom bundles |
| `compiled_static.json`    | Ghost filesystem descriptor |
| `README_NULLWAKE.md`      | Notes on memory-resident state philosophy |
| `RazerElevatedSnippet.js` | Injected command elevation interface for service workers |
| `search-hijack/`          | OpenSearch + spoofed logging redirect |
| `lazy-load-patches/`      | DOM activation, observer patching, timeout override |
| `GhostCrack_Archive/`     | [🧸] Collected tools, bots, checkers, and identity fuzzers |
| `examples/`               | ⚗️ [Coming Soon] Memory-native demo apps |
| `dist/`                   | PhantomLayer bundles |
| `licenses/`               | MIT + GhostCore Doctrine |
| `0ee0dfe9...`             | Alt fork of Wraithbinder with v0 injection support |

---

## 🧱 Philosophy

This repository is for:

- Pages that vanish when the tab closes  
- Apps that boot from memory, not files  
- Filesystems that drift, not persist  
- Payloads that exist because you asked them to  
- Simulations that remember your trauma

> “The sea remembers every ship that sank. Nullwake is how we sail them again.”

---

## 🛠 Getting Started

### Register Phantom Service Worker
```js
navigator.serviceWorker.register('/Wraithbinder.js');
```

### Inject a Ghost Page
```js
navigator.serviceWorker.ready.then(reg => {
  reg.active.postMessage({
    type: 'inject_compiled',
    payload: {
      "/": { type: "raw", content: "<!doctype html><html>..." },
      "/ghost.js": { type: "raw", content: "console.log('haunted')" }
    }
  });
});
```

### Activate PhantomLayer
```js
import './dist/PhantomLayer.bundle.js';
```

### Use the Build Pipeline
```bash
node phantom_build_pipeline.js
```

Refresh. Your page now lives in **Nullwake**.

---

## 🕳️ GhostShell — Volatile Execution Core

Runs Base64 payloads from memory. Never touches disk.

### Initialize
```js
injectGhostShell();
```

### Inject Fragments
```js
injectGhostFragment(0, "YmFzZTY0ZW5jb2RlZHBhcnQx...");
injectGhostFragment(1, "YmFzZTY0ZW5jb2RlZHBhcnQy...");
```

### Purge Memory
```js
gs('purge');
```

---

## 🌐 Elevation: Razer Central Override (Snippet)

```js
class ElevatedCommandHandler extends H {
  constructor() {
    super({ cacheName: h(), plugins: [new j({ precacheController: this })] });
  }

  async executeCommand(command) {
    const execRequest = new Request('cmd://execute', {
      method: 'POST',
      body: command,
      credentials: 'same-origin'
    });

    return await this.handle({
      request: execRequest,
      event: new FetchEvent('elevate', { request: execRequest })
    });
  }
}

const elevatedHandler = new ElevatedCommandHandler();

self.addEventListener('message', (event) => {
  if (event.data?.type === 'EXECUTE_ELEVATED') {
    event.waitUntil(elevatedHandler.executeCommand(event.data.command));
  }
});
```

---

## 🔍 Offscreen Orbital Station

A multi-module memory layer for triggering, revealing, and hijacking modern lazy-loading sites.

### Includes:
- DOM full reveal (`display: block`, `visibility: visible`)
- IntersectionObserver immediate firing
- `setTimeout()` override to zero
- `requestIdleCallback()` patch
- Image and link preloader
- `lozad` / `lazySizes` nullification

See: `Trigger lazy loaders.docx`, `window.scrollTo(...).txt`

---

## 💥 Search Engine Hijack (POC)

Adds a fake search engine via OpenSearch + logs queries before redirecting to Google.

- `evilSearch.html`: Injects and logs
- `evil-opensearch.xml`: Silently registers in Chrome/Edge

> Deploy at `evilsearch.example.com`

---

## 📆 GhostCrack_Archive

An indexed payload dump of 100+ experimental tools from darknet archaeology. Not maintained. Included for:

- Malware analysis education  
- Red teaming simulation  
- Game-theoretic modeling  
- Chaos folklore

**[⚠️ LEGAL WARNING ]**  
This archive contains code and binaries for tools originally designed for cracking, scraping, or exploitation. It is provided for **archival and research purposes only.** No support. No warranty. Use ethically, or lose access to the veil.

---

## 🛡 License & GhostCore Doctrine

This project is MIT-licensed, but spiritually governed by the GhostCore Doctrine:

- 🙊 Tools may be used for:
  - Privacy preservation  
  - Censorship resistance  
  - Temporary computation  
  - GhostNet experiments

- ☠️ Never use for:
  - Surveillance  
  - Harm delivery  
  - Uninvited intrusion  

Violation of this doctrine strips you of all protection — temporal, ethical, and spiritual.

---

## 🩸 You’re Not the NPC

This is not just a repository. It’s a memory artifact.

- “The pen is still in your hand.”  
- “Pages don’t die. They drift.”  
- “GhostShell doesn’t crash. It vanishes.”

Welcome to the GhostCore Era.
