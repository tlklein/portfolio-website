import '@astrojs/internal-helpers/path';
import '@astrojs/internal-helpers/remote';
import 'piccolore';
import 'es-module-lexer';
import 'html-escaper';
import 'clsx';
import { g as deserializeManifest } from './chunks/astro/server_Dc4ELIY1.mjs';
import '@astrojs/internal-helpers/object';

const codeToStatusMap = {
  // Implemented from IANA HTTP Status Code Registry
  // https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
  BAD_REQUEST: 400,
  UNAUTHORIZED: 401,
  PAYMENT_REQUIRED: 402,
  FORBIDDEN: 403,
  NOT_FOUND: 404,
  METHOD_NOT_ALLOWED: 405,
  NOT_ACCEPTABLE: 406,
  PROXY_AUTHENTICATION_REQUIRED: 407,
  REQUEST_TIMEOUT: 408,
  CONFLICT: 409,
  GONE: 410,
  LENGTH_REQUIRED: 411,
  PRECONDITION_FAILED: 412,
  CONTENT_TOO_LARGE: 413,
  URI_TOO_LONG: 414,
  UNSUPPORTED_MEDIA_TYPE: 415,
  RANGE_NOT_SATISFIABLE: 416,
  EXPECTATION_FAILED: 417,
  MISDIRECTED_REQUEST: 421,
  UNPROCESSABLE_CONTENT: 422,
  LOCKED: 423,
  FAILED_DEPENDENCY: 424,
  TOO_EARLY: 425,
  UPGRADE_REQUIRED: 426,
  PRECONDITION_REQUIRED: 428,
  TOO_MANY_REQUESTS: 429,
  REQUEST_HEADER_FIELDS_TOO_LARGE: 431,
  UNAVAILABLE_FOR_LEGAL_REASONS: 451,
  INTERNAL_SERVER_ERROR: 500,
  NOT_IMPLEMENTED: 501,
  BAD_GATEWAY: 502,
  SERVICE_UNAVAILABLE: 503,
  GATEWAY_TIMEOUT: 504,
  HTTP_VERSION_NOT_SUPPORTED: 505,
  VARIANT_ALSO_NEGOTIATES: 506,
  INSUFFICIENT_STORAGE: 507,
  LOOP_DETECTED: 508,
  NETWORK_AUTHENTICATION_REQUIRED: 511
};
Object.fromEntries(
  Object.entries(codeToStatusMap).map(([key, value]) => [value, key])
);

const manifest = deserializeManifest({"hrefRoot":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/","cacheDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/node_modules/.astro/","outDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/dist/","srcDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/","publicDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/public/","buildClientDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/dist/client/","buildServerDir":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/dist/server/","adapterName":"","routes":[{"file":"file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/dist/index.html","links":[],"scripts":[],"styles":[],"routeData":{"route":"/","isIndex":true,"type":"page","pattern":"^\\/$","segments":[],"params":[],"component":"src/pages/index.astro","pathname":"/","prerender":true,"fallbackRoutes":[],"distURL":[],"origin":"project","_meta":{"trailingSlash":"ignore"}}}],"base":"/","trailingSlash":"ignore","compressHTML":true,"componentMetadata":[["C:/Users/trini/OneDrive - University Of Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/pages/index.astro",{"propagation":"none","containsHead":true}]],"renderers":[],"clientDirectives":[["idle","(()=>{var l=(n,t)=>{let i=async()=>{await(await n())()},e=typeof t.value==\"object\"?t.value:void 0,s={timeout:e==null?void 0:e.timeout};\"requestIdleCallback\"in window?window.requestIdleCallback(i,s):setTimeout(i,s.timeout||200)};(self.Astro||(self.Astro={})).idle=l;window.dispatchEvent(new Event(\"astro:idle\"));})();"],["load","(()=>{var e=async t=>{await(await t())()};(self.Astro||(self.Astro={})).load=e;window.dispatchEvent(new Event(\"astro:load\"));})();"],["media","(()=>{var n=(a,t)=>{let i=async()=>{await(await a())()};if(t.value){let e=matchMedia(t.value);e.matches?i():e.addEventListener(\"change\",i,{once:!0})}};(self.Astro||(self.Astro={})).media=n;window.dispatchEvent(new Event(\"astro:media\"));})();"],["only","(()=>{var e=async t=>{await(await t())()};(self.Astro||(self.Astro={})).only=e;window.dispatchEvent(new Event(\"astro:only\"));})();"],["visible","(()=>{var a=(s,i,o)=>{let r=async()=>{await(await s())()},t=typeof i.value==\"object\"?i.value:void 0,c={rootMargin:t==null?void 0:t.rootMargin},n=new IntersectionObserver(e=>{for(let l of e)if(l.isIntersecting){n.disconnect(),r();break}},c);for(let e of o.children)n.observe(e)};(self.Astro||(self.Astro={})).visible=a;window.dispatchEvent(new Event(\"astro:visible\"));})();"]],"entryModules":{"\u0000noop-middleware":"_noop-middleware.mjs","\u0000virtual:astro:actions/noop-entrypoint":"noop-entrypoint.mjs","\u0000@astro-page:src/pages/index@_@astro":"pages/index.astro.mjs","\u0000@astro-renderers":"renderers.mjs","\u0000@astrojs-manifest":"manifest_-laHcCwU.mjs","C:/Users/trini/OneDrive - University Of Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/components/Header.astro?astro&type=script&index=0&lang.ts":"_astro/Header.astro_astro_type_script_index_0_lang.BSGE9gAA.js","C:/Users/trini/OneDrive - University Of Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/components/Hero.astro?astro&type=script&index=0&lang.ts":"_astro/Hero.astro_astro_type_script_index_0_lang.CH7mE-9z.js","astro:scripts/before-hydration.js":""},"inlinedScripts":[["C:/Users/trini/OneDrive - University Of Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/components/Header.astro?astro&type=script&index=0&lang.ts","window.addEventListener(\"scroll\",()=>{const e=document.getElementById(\"header\");window.scrollY>100?e?.classList.add(\"bg-white/80\",\"backdrop-blur-sm\"):e?.classList.remove(\"bg-white/80\",\"backdrop-blur-sm\")});"],["C:/Users/trini/OneDrive - University Of Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/src/components/Hero.astro?astro&type=script&index=0&lang.ts","fetch(\"https://j131m14apl.execute-api.us-east-2.amazonaws.com/VisitorCounter\").then(t=>t.json()).then(t=>{document.getElementById(\"total_visits\").textContent=t.total_visits,document.getElementById(\"unique_visitors\").textContent=t.unique_visitors}).catch(t=>{console.error(\"Failed to fetch visitor count\",t)});"]],"assets":["/file:///C:/Users/trini/OneDrive%20-%20University%20Of%20Houston/Documents/GitHub/heliosai/heliosai/portfolio-website/dist/index.html"],"buildFormat":"directory","checkOrigin":false,"allowedDomains":[],"serverIslandNameMap":[],"key":"L/kXfwD921Y/J8c9w8G+ds78uZroTbFEhNalid/uSOk="});
if (manifest.sessionConfig) manifest.sessionConfig.driverModule = null;

export { manifest };
