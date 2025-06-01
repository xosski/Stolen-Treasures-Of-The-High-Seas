self.addEventListener('install', event => {
    self.skipWaiting()
})

self.addEventListener('activate', event => {
    event.waitUntil(self.clients.claim())
})

const DB_NAME = '__v0'
const DB_VERSION = 1
const COMPILED_CACHE_NAME = '/__v0_compiled'

let compiled = null
let compiledPromiseResolve
const compiledPromise = new Promise(r => compiledPromiseResolve = r)

function loadCompiledFromIndexedDB() {
    const dbRequest = indexedDB.open(DB_NAME, DB_VERSION)

    dbRequest.onupgradeneeded = event => {
        const db = event.target.result
        if (!db.objectStoreNames.contains('data')) {
            db.createObjectStore('data')
        }
    }

    dbRequest.onsuccess = event => {
        const db = event.target.result
        const tx = db.transaction('data', 'readonly')
        const store = tx.objectStore('data')
        const request = store.get(COMPILED_CACHE_NAME)

        request.onsuccess = event => {
            compiled = event.target.result
            if (compiled) compiledPromiseResolve()
        }
    }
}

loadCompiledFromIndexedDB()

let port2 = null
self.onmessage = event => {
    if (!event.data) return
    if (event.data.type === 'v0_init') {
        compiled = event.data.compiled
        if (compiled) compiledPromiseResolve()
        port2 = event.ports[0]

        const dbRequest = indexedDB.open(DB_NAME, DB_VERSION)
        dbRequest.onupgradeneeded = event => {
            const db = event.target.result
            if (!db.objectStoreNames.contains('data')) {
                db.createObjectStore('data')
            }
        }

        dbRequest.onsuccess = event => {
            const db = event.target.result
            const tx = db.transaction('data', 'readwrite')
            const store = tx.objectStore('data')
            store.put(compiled, COMPILED_CACHE_NAME)
        }
    }
}

const currentOrigin = self.location.origin

self.onfetch = event => {
    event.respondWith(fetchHandler(event))
}

async function fetchHandler(event) {
    await compiledPromise

    if (!compiled || !compiled.staticFiles) return fetch(event.request)

    const url = new URL(event.request.url)

    if (url.origin !== currentOrigin) return fetch(event.request)

    const response = handleStaticFile(url)

    if (response) event.respondWith(response)
    else return fetch(event.request)
}

function handleStaticFile(url) {
    let maybeResource
    let resourcePath

    if (compiled.staticFiles[url.pathname]) {
        maybeResource = compiled.staticFiles[url.pathname]
        resourcePath = url.pathname
    } else if (compiled.staticFiles[url.pathname + '.html']) {
        maybeResource = compiled.staticFiles[url.pathname + '.html']
        resourcePath = url.pathname + '.html'
    }

    if (!maybeResource) return null

    if (typeof maybeResource === 'string' || maybeResource.type === 'raw') {
        const content = maybeResource.content || maybeResource
        return new Response(content)
    }

    if (maybeResource.type === 'url') {
        return fetch(maybeResource.content)
    }

    return null
}
