'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "d778d8b1f42d0dd1bb284e5ca9549187",
".git/config": "3e8ddb772abae7f3036744148be5b328",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "9507ab8e47a8750e42d7d8e9cf12ca9b",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "b09ae5cc2f5b60b5fbe6eb271d686579",
".git/logs/refs/heads/main": "b09ae5cc2f5b60b5fbe6eb271d686579",
".git/logs/refs/remotes/origin/main": "401fd78ed075304e6ffd636cf0dd7011",
".git/objects/05/4af8100e304197b558b6b8b333912d99771e57": "605c62e27d692ea0e7f998ffe13f7ea9",
".git/objects/0b/57786315ee7e01d096dc712cd577558aaa2fcb": "7b9bd55d774b9d74dba0c74b9aec2910",
".git/objects/0b/9fcf3d6c6058acc662279d9d22099086a0c78a": "0f20d8b31472ed851f3506e98bb44282",
".git/objects/0e/59c6a92f01af9dcdaf412276fe739a33d34a47": "21dce588565b392f246c2fe82b11fca4",
".git/objects/19/93be277af990c5620d055bc03493a436cf3e50": "50172dee64d950adb90ca120ee94b3f6",
".git/objects/1a/d7683b343914430a62157ebf451b9b2aa95cac": "94fdc36a022769ae6a8c6c98e87b3452",
".git/objects/33/bb8a8db44cc2c9e46a44efe1cbd4c5aafd2092": "0d5c06eae49511ca72b44536df2a64ef",
".git/objects/34/46611c117ed3d72c2d09253fad5ec0d8a06ee8": "f8ad56f17165d68ee4a25434be8765d1",
".git/objects/36/0c1b4c6a9055f840257738fdbd18582aca5ebf": "f13499055e86f54707a9ad8e7e38bc54",
".git/objects/3e/75cf8bff1fcd454c703ca098c8ed83f08f223a": "84b1d88f858c1ccf28433742fbf01d2c",
".git/objects/41/792bc7d414aecfd99dce1b18d4714759246952": "12263fadb941f6fe00a6bd2ca971db61",
".git/objects/45/728fcfc831ad95b4a4ef5239ddd42950126087": "c71cca0fc09d65bf1baf74a09c7b73a1",
".git/objects/46/07d05bc196b707cf5c17a83ce455ed3fc24286": "bcaf3929072bfd2a2ef08b4517b8e615",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/49/b0800dd9d6536075ffcc0017b0ad91c421b8dd": "8cee4b475f239e24e019df0243bb510c",
".git/objects/4c/1c9bc0def6dfeffce4d8adaaa44286796d2dad": "30609ab711c750070a33536aad445f77",
".git/objects/4c/51fb2d35630595c50f37c2bf5e1ceaf14c1a1e": "a20985c22880b353a0e347c2c6382997",
".git/objects/4d/7c1d5852e467dc31456bcce35124de262ba451": "ad04844aceea9f81babd7401813e0eed",
".git/objects/53/18a6956a86af56edbf5d2c8fdd654bcc943e88": "a686c83ba0910f09872b90fd86a98a8f",
".git/objects/53/3d2508cc1abb665366c7c8368963561d8c24e0": "4592c949830452e9c2bb87f305940304",
".git/objects/53/df0d5d88096130caf36501a2f2270f9d38f05a": "b182876a722ce53e70bad41782887852",
".git/objects/56/13eaf6cecfbde0ad6295afa586019185822700": "528264cffce23e916baaabf8456f51b2",
".git/objects/60/1675ab88af5bf52f0dc0b62be527644827f8e4": "2b039da5d2b86edbf03dc87d866c9abf",
".git/objects/63/ef18b775b600915a9462ab18077ae67814a15f": "2f0bc2fb37f7798464ba1c1d417a19c8",
".git/objects/64/fe90fdeb5c9d47ef4877092c6163aa45b8a047": "13e9eb42f43e542f7e227cc21ad42f11",
".git/objects/66/006e331839e811bf02c68b6c68eb500644ea65": "6ccdff93cd527ef0a019dc55d8f1d637",
".git/objects/6b/9862a1351012dc0f337c9ee5067ed3dbfbb439": "85896cd5fba127825eb58df13dfac82b",
".git/objects/6e/b08815b045db6039bba44b7234405942328a63": "e1df0283856146159db466990b2c95aa",
".git/objects/70/a234a3df0f8c93b4c4742536b997bf04980585": "d95736cd43d2676a49e58b0ee61c1fb9",
".git/objects/72/5a20e26146026e2b7bb9b605737b0e184d0332": "3afbf91f25aaffb1ddc3fff9b4c24c06",
".git/objects/73/c63bcf89a317ff882ba74ecb132b01c374a66f": "6ae390f0843274091d1e2838d9399c51",
".git/objects/75/3f7472fbdc5b0da4272e01252b430477463697": "a1943712b9cf4fc6a4c9d7c5effb7d4d",
".git/objects/7f/fbb3b98165fd73f352ea7024d3d48f00b1c12c": "685446950bd5bf83f61f8113b9acaa92",
".git/objects/86/03d0a3d2a91580f77171968c7d13e73fd1482a": "dc750bd17c929d834d260dd7dc0293e7",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8b/eabe5dd895544cde70b1fc1f6c73d2d3fd16d8": "01f32f209f5bbd1b00298b1fb7f4a6a9",
".git/objects/8e/3c7d6bbbef6e7cefcdd4df877e7ed0ee4af46e": "025a3d8b84f839de674cd3567fdb7b1b",
".git/objects/92/c76766e684d9cf9605afa87462ea4c8f70be24": "6347b10ca2adc1644d2b423c80e213df",
".git/objects/9b/d3accc7e6a1485f4b1ddfbeeaae04e67e121d8": "784f8e1966649133f308f05f2d98214f",
".git/objects/9d/41ce16a77b7069236019647cdb6298bf3457d7": "199643f13e7d6c148edae8e91d3fed11",
".git/objects/a8/6dc166149d83195a99bec1bf3d1b6b151f0eba": "5f8f893ddaecf1dfd9d6a942e17583b3",
".git/objects/b5/e6e04a5b04864bf3a6b75da87cfd5e6e7ac8ab": "4f6df27b3e2b3c553759f9aa87e0e1de",
".git/objects/b7/306664e8c58392cfe812aaa6e5af5f66958c46": "7f048203fa66287ae69000f9ba2bf6e0",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/b9/6a5236065a6c0fb7193cb2bb2f538b2d7b4788": "4227e5e94459652d40710ef438055fe5",
".git/objects/c5/9fe2a04023a0ce90e2dca4f716e7746a05ecf4": "b1eb2dd150ad0d74d3a1c541a86afdea",
".git/objects/c7/14c75d2fb820c4ba2ccdd003d039e08fe46eda": "f58607df9a3b8c135c5dbaa991587e67",
".git/objects/c8/08fb85f7e1f0bf2055866aed144791a1409207": "92cdd8b3553e66b1f3185e40eb77684e",
".git/objects/c9/8aa9be9fe3fe393cc3fb467b97711368222611": "19225dbbfe441dc6098c61601ff2e62b",
".git/objects/ce/db5a96760f59da9f79febf600c81b9f561c27b": "ae81c40c4c856fde07da965c4b5d7b70",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/dc/11fdb45a686de35a7f8c24f3ac5f134761b8a9": "761c08dfe3c67fe7f31a98f6e2be3c9c",
".git/objects/e0/7797437d096064bd90c373800dcb0f335c14b0": "16f9b9defb16491f8c733b09b022688c",
".git/objects/e0/7ac7b837115a3d31ed52874a73bd277791e6bf": "74ebcb23eb10724ed101c9ff99cfa39f",
".git/objects/e9/94225c71c957162e2dcc06abe8295e482f93a2": "2eed33506ed70a5848a0b06f5b754f2c",
".git/objects/ea/0858fe3975877dd4a39eb249fd8967c4ce9b8a": "87645c31008fd374ac7747a653eeafbf",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f4/f2ebb2d8aa795b8aff4f02406d7d9d218da91c": "c7c4f83a5e1bc415d0b5c7bb5175dad1",
".git/objects/f5/72b90ef57ee79b82dd846c6871359a7cb10404": "e68f5265f0bb82d792ff536dcb99d803",
".git/objects/f9/cccfe93264ff5fdb7ca10bb4ad48e5d3523b3e": "0367dc19cfcc08248439102234d9889f",
".git/objects/fe/8a4a988c82f872ef2f3fdba05a3b8afb384e63": "6ab3ea338a5acde47e7038d606d2d31d",
".git/objects/fe/d0e7884e784b0eee96d46989a8e83bc56afc62": "7c74d6046f785d9497e237e9776cc703",
".git/refs/heads/main": "ceecc271e44d98cc592eb392629964fc",
".git/refs/remotes/origin/main": "ceecc271e44d98cc592eb392629964fc",
"assets/AssetManifest.bin": "c56c8a5b49f579432d38412186eeae91",
"assets/AssetManifest.bin.json": "c73e567b5553d20cbb0128ae77791f42",
"assets/AssetManifest.json": "e508b0ef365d31d407e9661a3ad94202",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "04a7731f29c0630092206259422ed079",
"assets/lib/about.dart": "cc0db52be21e1acaaba6c718d6c266d4",
"assets/lib/assets/videoList.csv": "67010a91c8ef968dbf0aaa0a51104d36",
"assets/lib/blog.dart": "cb8977f14ca61b4bd054f50a07087580",
"assets/lib/donate.dart": "013589e95f0956a0cd3cc84f2be0f98e",
"assets/lib/main.dart": "90e7b92a591521d96a33304dd3da1e82",
"assets/lib/map.dart": "5c72af9dd7662dcc37979520f539814f",
"assets/lib/utility/csvHandler.dart": "387d41adcb338fbecad7f750843f5074",
"assets/lib/utility/stringDict.dart": "32a73d4909db4dd6ba14e3c4a50c7148",
"assets/lib/utility/translator.dart": "5d48489d855cbe77e3141f2a05fa06d0",
"assets/lib/utility/youtubePlayer.dart": "a2615cd53a95e9ea1c925c8616f4089b",
"assets/NOTICES": "0fa9fd1f341b0f3c481ad77119d89ffe",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/flutter_map/lib/assets/flutter_map_logo.png": "208d63cc917af9713fc9572bd5c09362",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "33e2094f274ea96c8099ebcab6b3da03",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "17a3616e95bdb2390520118e9cc75c0e",
"/": "17a3616e95bdb2390520118e9cc75c0e",
"main.dart.js": "f807e972cb9511d220039ed575e5f2a4",
"manifest.json": "af2cde65b01cb08f09f23b25c6245f1c",
"version.json": "2e79aa5e82116409ae3fea9f47a50451"};
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
