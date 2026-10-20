const search = document.querySelector("#post-search");
const topic = document.querySelector("#topic-filter");
const year = document.querySelector("#year-filter");
const cards = [...document.querySelectorAll("#post-grid .post-card")];
const count = document.querySelector("#post-count");
const empty = document.querySelector("#post-empty");

if (search && topic && year && count && empty) {
  function filterPosts() {
    const query = search.value.trim().toLocaleLowerCase();
    let visible = 0;

    for (const card of cards) {
      const matches = card.dataset.search.includes(query) &&
        (!topic.value || card.dataset.tags.includes(`|${topic.value}|`)) &&
        (!year.value || card.dataset.year === year.value);
      card.hidden = !matches;
      if (matches) visible++;
    }

    count.textContent = `Showing ${visible} ${visible === 1 ? "post" : "posts"}`;
    empty.hidden = visible !== 0;
  }

  search.addEventListener("input", filterPosts);
  topic.addEventListener("change", filterPosts);
  year.addEventListener("change", filterPosts);
}
