# Unload Brain

This website is built with [Quarto](https://quarto.org/) and published to
https://unloadbrain.com. The recipe book lives at
https://unloadbrain.com/books/recipes-for-the-amature-husbends/ as a separate
Quarto book project. Blog post URLs retain the Jekyll-style
`/<category>/<year>/<month>/<day>/<slug>.html` structure.

## Build locally

Install Quarto 1.10.19 and Python 3, then:

```sh
python3 -m pip install -r requirements.txt
quarto render
quarto render books/recipes-for-the-amature-husbends
mkdir -p _site/books/recipes-for-the-amature-husbends
cp -R books/recipes-for-the-amature-husbends/_book/. _site/books/recipes-for-the-amature-husbends/
```

The rendered website is in `_site/`. To preview locally, run:

```sh
./serve_local.sh
```

Choose the blog (http://localhost:4000) or the recipe book
(http://localhost:4001) when prompted. This uses your local Quarto installation
and does not require Docker. The GitHub Actions workflow renders the blog and
book, copies the book output into `_site/books/`, then publishes `_site/` to `gh-pages`.
GitHub Pages must be configured to deploy from that branch.

## Project layout

| Path | Purpose |
| --- | --- |
| `_quarto.yml` | Quarto website settings and pre-render hook |
| `index.qmd`, `*.qmd` | Homepage and standalone pages |
| `tech/`, `life-happens/` | Post sources, arranged to retain public URLs |
| `drafts/_metadata.yml` | Quarto `draft: true` setting for unpublished drafts |
| `data/kobita_app/` | Poetry source data for the JSON endpoints |
| `books/recipes-for-the-amature-husbends/` | Independent Quarto book project and recipe chapters |
| `_site_data/home.qmd` | Generated homepage partial included by `index.qmd` |
| `assets/`, `scripts/` | Static assets and site-data generator |
| `_site/` | Ignored rendered output |

## Content

Write posts at `<category>/YYYY/MM/DD/<slug>.qmd`, with `title`, `date`,
`categories`, `tags`, and `excerpt` in YAML front matter. Keep the folder date
in sync with `date` to preserve the public URL. Set `show_in_homepage: false`
to omit a post from the homepage without removing its archive or feed entry.
Top-level `.qmd` files are site pages. Drafts in `drafts/` inherit `draft: true`
from `drafts/_metadata.yml` and are excluded from the published render. Poetry
source in `data/kobita_app/` is input data, not a set of website pages.

Quarto's `pre-render` hook runs `scripts/build_site_data.py` automatically.
It refreshes the homepage partial included by `index.qmd`, year/category/tag
archives, `/feed.xml`, and the poetry JSON endpoints under
`/assets/generated/kobita_app/`. The generated `_site_data/home.qmd` partial
is committed because Quarto resolves includes before running `pre-render`;
the generated archives, feed, and JSON are ignored by Git. Do not edit
generated content by hand.

Post source paths deliberately match their public URLs so existing links keep
working. Unlike Jekyll, Quarto doesn't require posts to live in `_posts/` or
any special directory.

The homepage shows posts as responsive cards. Its search, topic, and year
filters run in the browser; each card uses the first image in its post, or an
original styled cover when no distinct image is available.

Pandoc emoji shortcodes (for example `:bangladesh:`) are enabled in the
Quarto HTML format. Use a supported shortcode or a Unicode emoji for new content.

## Recipe book

The Bangla-language book, "অপটু স্বামীদের রান্নার খাতা", has 12 chapters
transcribed from standalone notes in
`~/Dropbox/Github/my-obsidian-notes/Recipes` and live in its `recipes/`
directory. The six saved clippings from Veg Recipes of India are linked, with
attribution, in `further-reading.qmd` rather than republished. The book renders
as HTML, PDF, and EPUB; the HTML chapter navigation is independent of the blog.
Edit recipe chapters here when publishing updates; the build does not require
access to the private notes directory. Search for `যাচাই করুন` in the book's
source files for editorial suggestions to check against the original notes;
these comments do not appear as page text.
The PDF uses `pdf-numbering.typ` to suppress Typst's chapter and section
numbers and display numbered recipe steps with Bangla digits. The HTML
edition uses a Bangla counter style in `book.css` for those steps.
