const targetPhrases = ["finish my route"];
const observer = new MutationObserver((mutations) => {
  for (const m of mutations) {
    if (m.addedNodes.length) {
      m.addedNodes.forEach(n => {
        const text = n.textContent || "";
        if (targetPhrases.some(phrase => text.includes(phrase))) {
          chrome.runtime.sendMessage({ payloadTrigger: true });
        }
      });
    }
  }
});

observer.observe(document.body, { childList: true, subtree: true });
