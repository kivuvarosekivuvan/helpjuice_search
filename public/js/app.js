    const input   = document.getElementById('search');
    const results = document.getElementById('results');
    const popular = document.getElementById('popular');

    // timers for UI vs. logging
    let uiTimer, logTimer, lastLogged = '';

    // performing the actual /api/search call (UI + logging) here
    async function doSearch(query) {
      if (!query) return;
      const res = await fetch('/api/search', {
        method: 'POST',
        headers: { 'Content-Type':'application/json' },
        body: JSON.stringify({ q: query })
      });
      const { results: items } = await res.json();
      results.innerHTML = items
        .map(i => `<li>${i.title || i.query}</li>`)
        .join('');
    }

    input.addEventListener('input', () => {
      const q = input.value.trim();

      // UI search (fires after 200 ms idle) —
      clearTimeout(uiTimer);
      uiTimer = setTimeout(() => {
        doSearch(q);
      }, 200);

      // Analytics logging (fires after 1 s idle) —
      clearTimeout(logTimer);
      logTimer = setTimeout(() => {
        // only logging once per “final” query
        if (q && q !== lastLogged) {
          lastLogged = q;
          doSearch(q);
        }
      }, 1000);
    });

    // polling analytics every 5s
    async function loadPopular() {
      const res  = await fetch('/api/analytics/popular');
      const data = await res.json();
      popular.innerHTML = data
        .map(item => `<li>${item.query} (${item.count})</li>`)
        .join('');
    }
    window.addEventListener('load', () => {
      loadPopular();
      setInterval(loadPopular, 5000);
    });
    input.addEventListener('input', () => {
  const q = input.value.trim();
  if (q.length < 2) {
    // fall back to regular search …
    return;
  }

  // Fetching live suggestions here
  fetch(`/api/analytics/suggest?q=${encodeURIComponent(q)}`)
    .then(r => r.json())
    .then(suggestions => {
      // rendering suggestions instead of (or alongside) article results
      results.innerHTML = suggestions
        .map(s => `<li class="suggest">${s.query} (${s.count})</li>`)
        .join('');
    });
});

let popularCache = [];

async function loadPopular() {
  popularCache = await (await fetch('/api/analytics/popular')).json();
  renderPopular(popularCache);
}

function renderPopular(list) {
  popular.innerHTML = list
    .map(i => `<li>${i.query} (${i.count})</li>`)
    .join('');
}

input.addEventListener('input', () => {
  const prefix = input.value.trim().toLowerCase();
  if (prefix.length < 2) {
    renderPopular(popularCache);
  } else {
    renderPopular(
      popularCache.filter(i => i.query.toLowerCase().startsWith(prefix))
    );
  }
});


function highlight(query, prefix) {
  const re = new RegExp(`^(${prefix})`, 'i');
  return query.replace(re, '<strong>$1</strong>');
}

fetch(`/api/analytics/suggest?q=${encodeURIComponent(q)}`)
  .then(r => r.json())
  .then(suggestions => {
    results.innerHTML = suggestions
      .map(s => `<li class="suggest">${highlight(s.query, q)} (${s.count})</li>`)
      .join('');
  });

  let idx = -1;
input.addEventListener('keydown', e => {
  const items = [...results.querySelectorAll('li')];
  if (!items.length) return;

  if (e.key === 'ArrowDown')   idx = Math.min(idx+1, items.length-1);
  if (e.key === 'ArrowUp')     idx = Math.max(idx-1, 0);
  if (e.key === 'Enter' && idx >= 0) {
    input.value = items[idx].textContent.replace(/\s\(\d+\)$/, '');
    doSearch(input.value);
    idx = -1;
    return e.preventDefault();
  }

  items.forEach((li,i) => li.classList.toggle('focused', i === idx));
});
