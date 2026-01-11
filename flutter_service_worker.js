'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "24bc71911b75b5f8135c949e27a2984e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "e0c8e6b3888398a8370990cfe68fabe8",
"index.html": "d981ad3b75aa71fa27225109d6778dc5",
"/": "d981ad3b75aa71fa27225109d6778dc5",
"assets/shaders/stretch_effect.frag": "40d68efbbf360632f614c731219e95f0",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "f47ff8c7e8cf15b5da1bf54de7966db8",
"assets/assets/project_img/porfolio.png": "46027c82a03b42286c219a935b9d0a0c",
"assets/assets/project_img/noble.png": "78af279441e88edad2e71dcc78951a4f",
"assets/assets/project_img/baykinn.png": "d4786a2367a6fb2eb7103846ef2961dc",
"assets/assets/images/css.png": "f9540150cc63759dd0a9f756e4fc466a",
"assets/assets/images/riverpod.png": "0b55977f0ded15f4552aece152be33ce",
"assets/assets/images/mysql.png": "d88b85ed02b2d3ac97842d383469075d",
"assets/assets/images/about1.png": "142e5831e0b4221ba3d9627f837a8c62",
"assets/assets/images/dart.png": "a15214020eb3fa609e1a54914bb44601",
"assets/assets/images/java.png": "e5b3c2a1c7f77712acbe642d1e79e484",
"assets/assets/images/html.png": "446e4c5a77cab091ef30b6838e5fb7a5",
"assets/assets/images/aws.png": "4f1c48a5dbb803c4ea89d3e9a1095d5c",
"assets/assets/images/git.png": "fb17ebb7b3cd9f4cf7394304293e5ebe",
"assets/assets/images/image.png": "15411c8f7ba5efa0fbac6ba8a7f27e27",
"assets/assets/images/laravel.png": "2b531f0c49fdc7fef664cfdd8a259b9d",
"assets/assets/images/supabase.png": "5da018047964c18ce7ee108278537e24",
"assets/assets/images/bootstrap.png": "367d21fe9fb8b24923068bb2dbe7cc55",
"assets/assets/images/chroma.png": "9bb8b25422b698ba186c8368b128e201",
"assets/assets/images/firebase.png": "54801cc0f531cf6655743423d15712d0",
"assets/assets/images/postgresql.png": "fa9759e6d15ae1ee21c06b0201f56e3c",
"assets/assets/images/isar.png": "0959bd6f9f39270f6b190ace77a5a6e1",
"assets/assets/images/js.png": "0225da742e2d43ce8507f685c14107fb",
"assets/assets/images/flutter.png": "e4fc474bbedd5009e2fd072833007322",
"assets/assets/images/about.png": "3f426ed0506bc0814fb19d549dd9233e",
"assets/assets/images/figma.png": "2302a32b2265a516afb731642068723b",
"assets/assets/images/about_me.png": "aea58b9cba606c3c1d744a301c569f5c",
"assets/assets/images/fastapi.png": "4d2c477ada6d86739aaf2913e258bace",
"assets/assets/images/python.png": "f5dcf37071be923cc9d5b75495d61c4c",
"assets/assets/fonts/NotoSans-Regular.ttf": "f46b08cc90d994b34b647ae24c46d504",
"assets/assets/fonts/SpaceGrotesk-Bold.ttf": "52e5e29a7805a81bac01a170e45d103d",
"assets/assets/fonts/SpaceGrotesk-Regular.ttf": "778bb9a271006ab9d103287699611325",
"assets/assets/fonts/SpaceGrotesk-SemiBold.ttf": "b7bae4f584fc5d817de4178708946eb0",
"assets/assets/fonts/SpaceGrotesk-Light.ttf": "9ef30f36fbe394633b7235332346f5b1",
"assets/assets/fonts/SpaceGrotesk-Medium.ttf": "518133df6fcaf4237f97187e2ea1019e",
"assets/assets/data/about_me.json": "ccce14abf37260108b2160f03e5f13b0",
"assets/assets/data/feature_list.json": "eff647eebb0af436f09ace9878423e3c",
"assets/assets/data/README.md": "3f173701b324f686dc66e187d00b8f87",
"assets/assets/data/tech_icons.json": "c970432a21253c412c6300977bbcd14f",
"assets/assets/data/main.yml": "d41d8cd98f00b204e9800998ecf8427e",
"assets/fonts/MaterialIcons-Regular.otf": "c2a5cd94df9f0aec8fa05a09d99c655f",
"assets/NOTICES": "6220850c92b07859fdfd1c7c7cb68fc7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "59d0451f249a7a35786e4dea4da1a24c",
"assets/AssetManifest.bin": "5e9d519dc57ababf487bb94b70d73296",
"canvaskit/chromium/canvaskit.wasm": "a726e3f75a84fcdf495a15817c63a35d",
"canvaskit/chromium/canvaskit.js": "a80c765aaa8af8645c9fb1aae53f9abf",
"canvaskit/chromium/canvaskit.js.symbols": "e2d09f0e434bc118bf67dae526737d07",
"canvaskit/skwasm_heavy.wasm": "b0be7910760d205ea4e011458df6ee01",
"canvaskit/skwasm_heavy.js.symbols": "0755b4fb399918388d71b59ad390b055",
"canvaskit/skwasm.js": "8060d46e9a4901ca9991edd3a26be4f0",
"canvaskit/canvaskit.wasm": "9b6a7830bf26959b200594729d73538e",
"canvaskit/skwasm_heavy.js": "740d43a6b8240ef9e23eed8c48840da4",
"canvaskit/canvaskit.js": "8331fe38e66b3a898c4f37648aaf7ee2",
"canvaskit/skwasm.wasm": "7e5f3afdd3b0747a1fd4517cea239898",
"canvaskit/canvaskit.js.symbols": "a3c9f77715b642d0437d9c275caba91e",
"canvaskit/skwasm.js.symbols": "3a4aadf4e8141f284bd524976b1d6bdc",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"robots.txt": "ffa02375a9460c84019305c51a6a5476",
"sitemap.xml": "31d1a73d27c0cf412c9eb46eeb13b317",
"flutter_bootstrap.js": "ec6b05357e88d28571c92140c2a512d9",
"version.json": "b11d630f32bbfc537b36af5695f2775f",
"main.dart.js": "663b25c1bbf0e77075cdd3cad9c9852c",
"cv/Moe%20Win_Flutter_Developer_Resume.pdf": "f412254971f8393284b4d71e913ffe92"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
