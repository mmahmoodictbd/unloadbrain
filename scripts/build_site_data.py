#!/usr/bin/env python3
"""Build Quarto landing pages and legacy JSON/Atom endpoints from source content."""

from collections import defaultdict
from datetime import date
from html import escape
import json
from pathlib import Path
import random
import re
from xml.etree import ElementTree as ET

import yaml


ROOT = Path(__file__).resolve().parents[1]
SITE_URL = "https://unloadbrain.com"


def document(path):
    text = path.read_text(encoding="utf-8")
    match = re.match(r"\A---\s*\n(.*?)\n---\s*\n", text, re.DOTALL)
    if not match:
        raise ValueError(f"Missing front matter: {path}")
    return yaml.safe_load(match.group(1)), text[match.end():]


def write(path, content):
    path.parent.mkdir(parents=True, exist_ok=True)
    if path.exists() and path.read_text(encoding="utf-8") == content:
        return
    path.write_text(content, encoding="utf-8")


def post_info(path):
    metadata, body = document(path)
    if not isinstance(metadata.get("date"), (date, str)):
        raise ValueError(f"Missing date: {path}")
    posted = str(metadata["date"])[:10]
    category = metadata["categories"][0]
    url = f"/{category}/{posted.replace('-', '/')}/{path.stem}.html"
    if path.relative_to(ROOT).with_suffix(".html").as_posix() != url.lstrip("/"):
        raise ValueError(f"Post location must match its date and category: {path}")
    image = re.search(r"!\[[^\]]*\]\((/assets/images/[^)\s]+)\)", body)
    if image and not (ROOT / image.group(1).lstrip("/")).is_file():
        raise ValueError(f"Post image does not exist: {image.group(1)}")
    return {
        "metadata": metadata,
        "date": posted,
        "url": url,
        "year": posted[:4],
        "image": image.group(1) if image else None,
    }


def post_card(post):
    meta = post["metadata"]
    title = escape(meta["title"])
    url = escape(post["url"])
    excerpt = " ".join(meta.get("excerpt", "").split())
    date_label = date.fromisoformat(post["date"]).strftime("%b %d, %Y").replace(" 0", " ")
    tags = meta["tags"]
    if post["image"]:
        cover = f'<img src="{escape(post["image"])}" alt="" loading="lazy">'
    else:
        color = "security" if any(tag in tags for tag in ("appsec", "security")) else (
            "home" if "home-assistant" in tags else "default"
        )
        cover = (
            f'<span class="post-cover-art post-cover-{color}" aria-hidden="true">'
            '<span class="post-cover-label">UNLOAD / BRAIN</span>'
            '<span class="post-cover-shape"></span>'
            f'<span class="post-cover-topic">{escape(tags[0].replace("-", " "))}</span>'
            '</span>'
        )
    search = escape(" ".join((meta["title"], excerpt, *tags)).lower())
    return "\n".join([
        f'<article class="post-card" data-search="{search}" data-year="{post["year"]}" data-tags="|{"|".join(tags)}|">',
        f'<a class="post-cover" href="{url}" aria-label="Read {title}">{cover}</a>',
        '<div class="post-card-body">',
        f'<time datetime="{post["date"]}">{date_label}</time>',
        f'<h3 class="no-anchor"><a href="{url}">{title}</a></h3>',
        f'<p>{escape(excerpt)}</p>',
        '<div class="post-card-footer">',
        '<span>Mossaddeque Mahmood</span>',
        f'<span class="post-card-category">{escape(meta["categories"][0].replace("-", " "))}</span>',
        '</div></div></article>',
    ])


def archive(title, posts):
    lines = [
        "---", f"title: {json.dumps(title, ensure_ascii=False)}", "---", "",
        f"{len(posts)} {'post' if len(posts) == 1 else 'posts'} in this archive.",
        "", '<div class="post-grid">', "",
    ]
    for post in posts:
        lines.extend((post_card(post), ""))
    lines.append("</div>")
    return "\n".join(lines) + "\n"


def build_posts():
    posts = [post_info(path) for path in ROOT.glob("tech/**/*.qmd")]
    posts += [post_info(path) for path in ROOT.glob("life-happens/**/*.qmd")]
    posts.sort(key=lambda post: (post["date"], post["url"]), reverse=True)
    if not posts:
        raise ValueError("No posts found")
    used_images = set()
    for post in posts:
        if post["image"] in used_images:
            post["image"] = None
        elif post["image"]:
            used_images.add(post["image"])

    visible_posts = [post for post in posts if post["metadata"].get("show_in_homepage", True)]
    topics = sorted({tag for post in visible_posts for tag in post["metadata"]["tags"]})
    years = sorted({post["year"] for post in visible_posts}, reverse=True)
    listing = [
        '<section class="blog-posts" aria-label="Browse posts">',
        '<div class="post-filters">',
        '<label class="search-field"><span class="visually-hidden">Search posts</span>',
        '<input id="post-search" type="search" placeholder="Search the journal..." autocomplete="off"></label>',
        '<label class="visually-hidden" for="topic-filter">Filter by topic</label>',
        '<select id="topic-filter"><option value="">All topics</option>',
    ]
    listing += [
        f'<option value="{escape(tag)}">{escape(tag.replace("-", " ").title())}</option>'
        for tag in topics
    ]
    listing += [
        '</select>',
        '<label class="visually-hidden" for="year-filter">Filter by year</label>',
        '<select id="year-filter"><option value="">All years</option>',
    ]
    listing += [f'<option value="{year}">{year}</option>' for year in years]
    listing += [
        '</select></div>',
        f'<p class="post-count" id="post-count" role="status" aria-live="polite">Showing {len(visible_posts)} posts</p>',
        '<div class="post-grid" id="post-grid">',
    ]
    for post in visible_posts:
        listing.extend((post_card(post), ""))
    listing += [
        '</div>',
        '<p id="post-empty" hidden>No posts match your search. Try another topic or year.</p>',
        '</section>',
        "",
    ]
    groups = defaultdict(list)
    titles = {}
    for post in posts:
        meta = post["metadata"]
        year = f"{post['year']}/index.qmd"
        groups[year].append(post)
        titles[year] = f"Year: {post['year']}"
        for category in meta["categories"]:
            key = f"category/{category}/index.qmd"
            groups[key].append(post)
            titles[key] = f"Category: {category}"
        for tag in meta["tags"]:
            key = f"tag/{tag}/index.qmd"
            groups[key].append(post)
            titles[key] = f"Tag: {tag}"
    for directory in (ROOT / "category", ROOT / "tag"):
        for old in directory.glob("*/index.qmd"):
            if old.relative_to(ROOT).as_posix() not in groups:
                old.unlink()
    for old in ROOT.glob("20??/index.qmd"):
        if old.relative_to(ROOT).as_posix() not in groups:
            old.unlink()
    for relative, members in groups.items():
        write(ROOT / relative, archive(titles[relative], members))

    listing += [
        '<section class="blog-archives">',
        '<p class="eyebrow">KEEP EXPLORING</p>',
        '<h2>Browse the archive</h2>',
        "",
        '<p>Categories: ' + ", ".join(
            f'<a href="/category/{escape(category)}/">{escape(category)}</a>'
            for category in sorted({category for post in posts for category in post["metadata"]["categories"]})
        ) + '</p>',
        "",
        '<p>Years: ' + ", ".join(
            f'<a href="/{year}/">{year}</a>' for year in sorted({post["year"] for post in posts}, reverse=True)
        ) + '</p>',
        "",
        '<p>Tags: ' + ", ".join(
            f'<a href="/tag/{escape(tag)}/">{escape(tag)}</a>'
            for tag in sorted({tag for post in posts for tag in post["metadata"]["tags"]})
        ) + '</p>',
        '</section>',
        "",
    ]
    write(ROOT / "_site_data/home.qmd", "\n".join(listing).rstrip() + "\n")

    atom = "http://www.w3.org/2005/Atom"
    ET.register_namespace("", atom)
    feed = ET.Element(f"{{{atom}}}feed")
    ET.SubElement(feed, f"{{{atom}}}id").text = SITE_URL + "/feed.xml"
    ET.SubElement(feed, f"{{{atom}}}title").text = "Unload Brain"
    ET.SubElement(feed, f"{{{atom}}}subtitle").text = "Uploading my brain dump."
    ET.SubElement(feed, f"{{{atom}}}updated").text = posts[0]["date"] + "T00:00:00Z"
    ET.SubElement(feed, f"{{{atom}}}link", href=SITE_URL + "/feed.xml", rel="self")
    ET.SubElement(feed, f"{{{atom}}}link", href=SITE_URL + "/")
    author = ET.SubElement(feed, f"{{{atom}}}author")
    ET.SubElement(author, f"{{{atom}}}name").text = "Mossaddeque Mahmood"
    for post in posts:
        entry = ET.SubElement(feed, f"{{{atom}}}entry")
        ET.SubElement(entry, f"{{{atom}}}id").text = SITE_URL + post["url"]
        ET.SubElement(entry, f"{{{atom}}}title").text = post["metadata"]["title"]
        ET.SubElement(entry, f"{{{atom}}}published").text = post["date"] + "T00:00:00Z"
        ET.SubElement(entry, f"{{{atom}}}updated").text = post["date"] + "T00:00:00Z"
        ET.SubElement(entry, f"{{{atom}}}link", href=SITE_URL + post["url"])
        ET.SubElement(entry, f"{{{atom}}}summary").text = post["metadata"].get("excerpt", "").strip()
    ET.indent(feed)
    write(ROOT / "feed.xml", ET.tostring(feed, encoding="unicode", xml_declaration=True) + "\n")


def build_poetry():
    collections = defaultdict(list)
    for path in sorted((ROOT / "data/kobita_app").rglob("*.md")):
        metadata, body = document(path)
        kind = metadata["post_type"]
        item = {
            "draft": False,
            "categories": metadata.get("categories", []),
            **{key: value for key, value in metadata.items() if key != "categories"},
            "slug": path.stem,
            "ext": ".md",
            "excerpt": f"<p>{escape(body.strip().split(chr(10) * 2, 1)[0])}</p>\n",
        }
        collections[kind].append(item)
    destination = ROOT / "assets/generated/kobita_app"
    for kind, items in collections.items():
        write(destination / f"{kind}s.json", json.dumps(items, ensure_ascii=False))
    fragments = collections["kobita-fragment"]
    if not fragments:
        raise ValueError("No poetry fragments found")
    write(destination / "random-kobita.json", json.dumps(random.choice(fragments), ensure_ascii=False))


if __name__ == "__main__":
    build_posts()
    build_poetry()
