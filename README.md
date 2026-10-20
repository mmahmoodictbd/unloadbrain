# Unload Brain

This website is built with [Quarto](https://quarto.org/) and published to
https://unloadbrain.com. Post URLs retain the Jekyll-style
`/<category>/<year>/<month>/<day>/<slug>.html` structure.

## Build locally

Install Quarto 1.10.19 and Python 3, then:

```sh
python3 -m pip install -r requirements.txt
python3 scripts/build_site_data.py
quarto render
```

The rendered website is in `_site/`. To preview at http://localhost:4000:

```sh
python3 scripts/build_site_data.py
quarto preview --port 4000
```

Alternatively, run `./local_serve.sh build` or `./local_serve.sh serve` with
Docker. The GitHub Actions workflow builds the same site and publishes `_site/`
to `gh-pages`. GitHub Pages must be configured to deploy from that branch.

## Content

Write posts at `<category>/YYYY/MM/DD/<slug>.md`, with `title`, `date`,
`categories`, `tags`, and `excerpt` in YAML front matter. Keep the folder date
in sync with `date` to preserve the public URL. Set `show_in_homepage: false`
to omit a post from the homepage without removing its archive or feed entry.
Top-level `.md` files are site pages. Drafts in `_drafts/` and poetry source in
`_datalake_kobita_app/` are not rendered as pages.

Run `python3 scripts/build_site_data.py` after editing content and before
rendering. It generates the homepage, year/category/tag archives, `/feed.xml`,
and the poetry JSON endpoints under `/assets/generated/kobita_app/`. These
generated files are ignored by Git; do not edit them by hand.

The homepage shows posts as responsive cards. Its search, topic, and year
filters run in the browser; each card uses the first image in its post, or an
original styled cover when no distinct image is available.

Pandoc emoji shortcodes (for example `:bangladesh:`) are enabled in the
Quarto HTML format. Use a supported shortcode or a Unicode emoji for new content.
