'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "e213c80f0da6d193617cc76edf5e680d",
"assets/AssetManifest.bin.json": "478937f40b6f086ca2e70c05e0c46d3b",
"assets/AssetManifest.json": "391c2f323f7421c3436cec30098db414",
"assets/assets/fonts/Nunito-Bold.ttf": "ba43cdecf9625c0dcec567ba29555e15",
"assets/assets/fonts/Nunito-Medium.ttf": "d26cecc95cdc8327b337357e6c5c1f5b",
"assets/assets/images/astral-logo.png": "4c861f10fa981d6301e2b2c25c4fac93",
"assets/assets/images/moon.png": "f342d6c648dc5449f0c159561b211fb5",
"assets/assets/weatherIcons/icons8-clouds-50.png": "80fd71e5fbd7d706b86c829786b45163",
"assets/assets/weatherIcons/icons8-heavy-rain-50.png": "4f4ea416ac78c82abfc0c2a7a78d4c59",
"assets/assets/weatherIcons/icons8-lightning-bolt-50.png": "d7c65888e3909d5a28208da730ae606d",
"assets/assets/weatherIcons/icons8-rain-50.png": "569524bfb504f7edbd126d7839d88607",
"assets/assets/weatherIcons/icons8-rain-cloud-50-2.png": "580cf097a7a3e52b256c6cf8e28c2f7a",
"assets/assets/weatherIcons/icons8-rain-cloud-50.png": "ca9abae1ff7016c73e477919feda41b5",
"assets/assets/weatherIcons/icons8-rainy-weather-50.png": "f8fbd1fcaff4fd26d8203ca7596e4471",
"assets/assets/weatherIcons/icons8-sleet-50.png": "ca54d7c265e13a33ad75f0c9468df045",
"assets/assets/weatherIcons/icons8-snow-50.png": "ec4ecf749a1ee4380d7cf1485ca74791",
"assets/assets/weatherIcons/icons8-sun-50-2.png": "c397b197a59c4e8bfe2ebf7496ee3f25",
"assets/assets/weatherIcons/icons8-sun-50.png": "c24dceea01aff1801b83299eeeacd8b6",
"assets/assets/weatherIcons/icons8-sunrise-50.png": "3e80787465789bfff9ddbcdf55699b70",
"assets/assets/weatherIcons/icons8-sunset-50.png": "58ff555d5d56eacdda31306aef041f70",
"assets/assets/weatherIcons/icons8-wet-50.png": "4e8430dfe80ea17d89473d3f26db6e0f",
"assets/assets/weatherIcons/icons8-wind-50.png": "54fc42cc1c1eabcef5bcb98c86fd1aa6",
"assets/FontManifest.json": "5a144e071e789fda70f6e343e1ef3d92",
"assets/fonts/MaterialIcons-Regular.otf": "008ff95ad4d8ffb5395a01ea180b6e05",
"assets/images/astral-logo.png": "4c861f10fa981d6301e2b2c25c4fac93",
"assets/images/moon.png": "f342d6c648dc5449f0c159561b211fb5",
"assets/logs.json": "9c855f6a46252a888e21c509649073d4",
"assets/NOTICES": "0b0ff212620e12a3eaf71b991b462dff",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"favicon.png": "4c861f10fa981d6301e2b2c25c4fac93",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"icons/Icon-192.png": "4c861f10fa981d6301e2b2c25c4fac93",
"icons/Icon-512.png": "4c861f10fa981d6301e2b2c25c4fac93",
"icons/Icon-maskable-192.png": "4c861f10fa981d6301e2b2c25c4fac93",
"icons/Icon-maskable-512.png": "4c861f10fa981d6301e2b2c25c4fac93",
"index.html": "5f81ed93ea9f4f6e9a0e95ea80930111",
"/": "5f81ed93ea9f4f6e9a0e95ea80930111",
"main.dart.js": "e619f0aa205202103fdf8dcde24f00a0",
"manifest.json": "e309e37f4051cae0550b3d25ac516c0e",
"version.json": "4dcd9cb46b3e4014e4d116b41bf0c443"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
