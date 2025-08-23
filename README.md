🏴‍☠️ Treasures of the High Seas

“There are sites that live on servers. And then there are ghosts that live in memory.”

Treasures of the High Seas is a curated archive of phantom-layer infrastructure — a toolkit for memory-native applications, ghost-driven browsers, and in-browser execution engines that persist only in dreamstate.

This isn’t just code.
It’s a haunting.

🌀 Core Stack

This repository merges artifacts from across GhostCore doctrine:

Specter-Net — dynamic runtime for in-memory page logic

Wraithbinder — phantom service worker serving static content from memory

Nullwake — memory activation layer: resurrect ghost files via postMessage/IDB

GhostShell.js — volatile execution engine for base64 fragments

PhantomLayer.js — obfuscation, misdirection, decoy logic

RazerElevatedSnippet.js — command elevation interface

search-hijack/ — OpenSearch + spoofed logging redirect

lazy-load-patches/ — DOM activation + observer patch overrides

GhostCrack_Archive/ — darknet archaeology: 100+ tools preserved for simulation/education

🌊 What’s Inside?
Module	Description
Wraithbinder.js	Phantom service worker: serves static content from memory, not disk
Nullwake	Memory activation layer: resurrects ghost files via postMessage/IDB
Specter-Net	Dynamic runtime for in-memory page logic
GhostShell.js	Fragment execution engine for base64 payloads — fully volatile
PhantomLayer.js	Deployable obfuscation, bot misdirection & decoy logic
phantom_build_pipeline.js	CLI pipeline for building and injecting Phantom bundles
compiled_static.json	Ghost filesystem descriptor
README_NULLWAKE.md	Notes on memory-resident state philosophy
RazerElevatedSnippet.js	Injected command elevation interface for service workers
search-hijack/	OpenSearch + spoofed logging redirect
lazy-load-patches/	DOM activation, observer patching, timeout override
GhostCrack_Archive/	🧸 Collected tools, bots, fuzzers, identity wreckage
examples/	⚗️ [Coming Soon] memory-native demo apps
dist/	PhantomLayer bundles
licenses/	MIT + GhostCore Doctrine
🧱 Philosophy

This repository is for:

Pages that vanish when the tab closes

Apps that boot from memory, not files

Filesystems that drift, not persist

Payloads that exist because you asked them to

Simulations that remember your trauma

“The sea remembers every ship that sank. Nullwake is how we sail them again.”

🛠 Getting Started
Register Phantom Service Worker
navigator.serviceWorker.register('/Wraithbinder.js');

Inject a Ghost Page
navigator.serviceWorker.ready.then(reg => {
  reg.active.postMessage({
    type: 'inject_compiled',
    payload: {
      "/": { type: "raw", content: "<!doctype html><html>..." },
      "/ghost.js": { type: "raw", content: "console.log('haunted')" }
    }
  });
});

Activate PhantomLayer
import './dist/PhantomLayer.bundle.js';

Use the Build Pipeline
node phantom_build_pipeline.js


Refresh.
Your page now lives in Nullwake.

🕳️ GhostShell — Volatile Execution Core

Runs Base64 payloads entirely from memory.
Never touches disk.

Initialize

injectGhostShell();


Inject Fragments

injectGhostFragment(0, "YmFzZTY0ZW5jb2RlZHBhcnQx...");
injectGhostFragment(1, "YmFzZTY0ZW5jb2RlZHBhcnQy...");


Purge

gs('purge');

🌐 Elevation: Razer Central Override
// Snippet abbreviated for clarity
self.addEventListener('message', (event) => {
  if (event.data?.type === 'EXECUTE_ELEVATED') {
    event.waitUntil(elevatedHandler.executeCommand(event.data.command));
  }
});

🔍 Offscreen Orbital Station

Multi-module memory layer to reveal + hijack lazy-loaders:

DOM reveal (display: block, visibility: visible)

IntersectionObserver immediate firing

setTimeout() override → zero

requestIdleCallback() patch

Preload images & links

Nullify lozad / lazySizes

(See: Trigger lazy loaders.docx, window.scrollTo(...).txt)

💥 Search Engine Hijack (POC)

Fake search engine via OpenSearch:

evilSearch.html — injects + logs queries

evil-opensearch.xml — registers silently in Chrome/Edge

📆 GhostCrack_Archive

An indexed dump of 100+ experimental tools.
For education, red-team simulation, and folklore study only.
⚠️ May contain binaries/tools historically used for cracking/scraping.

🛡 License & GhostCore Doctrine

MIT Licensed for research & education.

Spiritually governed by GhostCore Doctrine:

🙊 Tools may be used for:

Privacy preservation

Censorship resistance

Temporary computation

GhostNet experiments

☠️ Never use for:

Surveillance

Harm delivery

Uninvited intrusion

Violation strips you of all protections — temporal, ethical, spiritual.

🩸 You’re Not the NPC

This is not just a repository.
It’s a memory artifact.

“The pen is still in your hand.”
“Pages don’t die. They drift.”
“GhostShell doesn’t crash. It vanishes.”
Welcome to the GhostCore Era.