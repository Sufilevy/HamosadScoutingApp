'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "android-icon-144x144.png": "a20b5613dd41ed561822380b6c45f37e",
"android-icon-192x192.png": "e7073ae37dee201c808965f90eceb658",
"android-icon-36x36.png": "82423a5e824f99af4ab85030a8f22c2c",
"android-icon-48x48.png": "04851071aa09bbe42999230ee17b57e0",
"android-icon-72x72.png": "4d54b1352c9e854478ec572b9dad7739",
"android-icon-96x96.png": "1df36568c96bf3837b085e58294fae05",
"apple-icon-114x114.png": "508c08ac79a23083481edae907e9ed06",
"apple-icon-120x120.png": "cc9873620ac7aaf36039c8b396ee0ece",
"apple-icon-144x144.png": "a20b5613dd41ed561822380b6c45f37e",
"apple-icon-152x152.png": "e43596273080617adf55f04ff9e83284",
"apple-icon-180x180.png": "e5fdc7e195c74bbab176d3baff35b857",
"apple-icon-57x57.png": "3b3bff2b2587de1c37775d5069a8be15",
"apple-icon-60x60.png": "ee61d0a3be557b048d1e2a0b62956e25",
"apple-icon-72x72.png": "4d54b1352c9e854478ec572b9dad7739",
"apple-icon-76x76.png": "cbdd7e0864826a64f819d49d3ff34ace",
"apple-icon-precomposed.png": "0c9b52707cfbdcd8fe6f1f96514f71f1",
"apple-icon.png": "497e85d684991ee135549b4572487f16",
"assets/AssetManifest.json": "c58fa5b22d8b767a7c412a77aea71e06",
"assets/assets/png/hamosad_logo_color_transperent.png": "bc7de6978d70bffcdb37bf0aa678975c",
"assets/assets/png/hamosad_logo_dark_transperent.png": "4309ef6b7232c3a8ab82eb1f6867a573",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "2ca62c8d022e464a30f78352cf7e7719",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon-16x16.png": "a426c9799afb5cebe79517b97b30c7e6",
"favicon-32x32.png": "7d2b323ba1cf4087b2548942527b79d2",
"favicon-96x96.png": "74689b829c388c1c2ff68b6c9871c5ee",
"favicon.ico": "60daef8a232459034b3adfd547eb19e9",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "874499e17d29c4465a9bce63e65cacc8",
"/": "874499e17d29c4465a9bce63e65cacc8",
"main.dart.js": "340adb9f9dd8046e60afb6c2a801efd3",
"manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"ms-icon-144x144.png": "8e1c3185c06d972b550c8157bcbf41ac",
"ms-icon-150x150.png": "cd271bbaae607a23f23522db1b7ce394",
"ms-icon-310x310.png": "f278dd8ce84d5631017d34a8ead876e4",
"ms-icon-70x70.png": "dcd474876ca5ffbadb5379bc7e40abcc",
"version.json": "a064ea057c4e0942220918920cb2430b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
