// Wraithbinder.js — Phantom Site Service Worker

const DB_NAME = '__specter_core'
const DB_VERSION = 1
const COMPILED_CACHE_NAME = '/compiled_soul'

let compiled = null
let compiledReady = new Promise(resolve => {
    self.addEventListener('message', event => {
        if (event.data?.type === 'inject_compiled') {
            compiled = event.data.payload
            cacheCompiled(compiled)
            resolve()
        }
    })
})

self.addEventListener('install', () => self.skipWaiting())
self.addEventListener('activate', () => self.clients.claim())

self.addEventListener('fetch', event => {
    event.respondWith(handleFetch(event))
})

async function handleFetch(event) {
    await compiledReady

    const url = new URL(event.request.url)
    if (url.origin !== location.origin) return fetch(event.request)

    let resource = compiled?.[url.pathname] || compiled?.[url.pathname + '.html']
    if (!resource) return fetch(event.request)

    if (typeof resource === 'string' || resource.type === 'raw') {
        const body = resource.content || resource
        return new Response(body, { headers: { 'Content-Type': detectMime(url.pathname) } })
    } else if (resource.type === 'url') {
        return fetch(resource.content)
    }

    return fetch(event.request)
}

function detectMime(path) {
    if (path.endsWith('.js')) return 'application/javascript'
    if (path.endsWith('.css')) return 'text/css'
    if (path.endsWith('.html')) return 'text/html'
    if (path.endsWith('.json')) return 'application/json'
    return 'text/plain'
}

function cacheCompiled(data) {
    const req = indexedDB.open(DB_NAME, DB_VERSION)
    req.onupgradeneeded = e => {
        const db = e.target.result
        if (!db.objectStoreNames.contains('core')) {
            db.createObjectStore('core')
        }
    }
    req.onsuccess = e => {
        const db = e.target.result
        const tx = db.transaction('core', 'readwrite')
        tx.objectStore('core').put(data, COMPILED_CACHE_NAME)
    }
}
