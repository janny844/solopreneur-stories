# 100 Solopreneur Short Stories

A fully free, deployable book system built on mdBook + GitHub Pages + Lemon Squeezy.

**Live site:** https://janny844.github.io/solopreneur-stories/

**👉 For day-to-day instructions, read [USAGE.md](USAGE.md).**

---

## What This Is

A static book website that:
- Renders beautifully on desktop and mobile
- Hosts 100 founder stories in narrative essay style
- Deploys automatically on every `git push`
- Sells the full EPUB via Lemon Squeezy (zero backend, zero monthly cost)

**Cost to run: $0/month**

---

## Quick Start (10 Minutes to Live)

### Prerequisites

- Git and a GitHub account
- A terminal (Git Bash on Windows, Terminal on Mac/Linux)
- mdBook installed locally (for previewing — optional for deploy)

### Step 1: Clone the repo

```bash
git clone https://github.com/janny844/solopreneur-stories
cd solopreneur-stories
```

### Step 2: Install mdBook locally (optional, for preview)

```bash
# macOS
brew install mdbook

# Windows (via cargo)
cargo install mdbook

# Or download a pre-built binary from:
# https://github.com/rust-lang/mdBook/releases
```

### Step 3: Preview locally

```bash
mdbook serve --open
# Opens http://localhost:3000
```

### Step 4: Push to GitHub

```bash
git push origin main
```

### Step 5: Enable GitHub Pages

In your GitHub repo:
1. Go to **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: **gh-pages** / **/ (root)**
4. Save

Your book will be live at https://janny844.github.io/solopreneur-stories/ within 2 minutes.

*(Already done for this repo — Pages is enabled and deploying.)*

---

## Adding Stories

### Add one story

```bash
./scripts/add-story.sh "Alex Hormozi"
```

This creates `src/stories/alex-hormozi.md` with a template and adds it to `src/SUMMARY.md`.

Fill in the story content in the generated file, then push:

```bash
git add .
git commit -m "add story: Alex Hormozi"
git push
```

The site redeploys automatically.

### Add many stories from a list

Edit `names.txt` — one name per line — then run:

```bash
./scripts/batch-generate-stories.sh names.txt
```

This creates template files for every name. You then fill in the story content.

---

## Project Structure

```
dynamic-book-generator/
├── book.toml                        # mdBook configuration
├── index.html                       # Landing page (root)
├── names.txt                        # Founder name list for batch generation
├── src/
│   ├── SUMMARY.md                   # Table of contents (auto-updated by scripts)
│   ├── introduction.md              # Book intro + buy CTA
│   ├── custom.css                   # mdBook custom styles
│   └── stories/
│       ├── marc-lou.md              # Story files (one per founder)
│       ├── pieter-levels.md
│       └── ...
├── scripts/
│   ├── add-story.sh                 # Add single story
│   └── batch-generate-stories.sh   # Batch generate from names.txt
├── .github/
│   └── workflows/
│       └── deploy.yml               # Auto-deploy to GitHub Pages on push
└── PAYMENT_SETUP.md                 # Guide to setting up Lemon Squeezy payments
```

---

## Setting Up Payments

See [PAYMENT_SETUP.md](PAYMENT_SETUP.md) for full instructions.

**Short version:**
1. Create a free [Lemon Squeezy](https://lemonsqueezy.com) account
2. Upload your EPUB, set price ($9 suggested)
3. Copy your checkout URL
4. Replace `YOUR_PAYMENT_URL_HERE` in `index.html` and `src/introduction.md`

---

## Getting the EPUB

**The CI pipeline builds HTML only — it does not produce an EPUB.**

Generate one locally when you need it (you only need it once, to upload to Lemon Squeezy):

```bash
cargo install mdbook-epub      # requires Rust: https://rustup.rs
```

Add to `book.toml`:
```toml
[output.epub]
```

Then `mdbook build` — the EPUB lands in `book/epub/`.

Full steps in [USAGE.md](USAGE.md#getting-an-epub-to-sell).

---

## Customising the Book

### Change the title and author

Edit `book.toml`:
```toml
[book]
title = "Your Book Title"
authors = ["Your Name"]
```

### Change the color theme

Edit `src/custom.css`. The current theme uses a clean light palette.

### Change the landing page

Edit `index.html` (the marketing landing page) and/or `src/introduction.md` (the book's first page).

### Update the GitHub repository URL

In `book.toml`:
```toml
[output.html]
git-repository-url = "https://github.com/YOUR_USERNAME/YOUR_REPO"
```

---

## Story Writing Style

Stories follow the Sun Yu-cheng public essay style:
- Open **in the middle of a moment** — a specific time, place, and number
- No biography summaries in the opening paragraph
- Emotions shown through physical actions, not stated directly
- Specific numbers throughout (revenue, dates, users)
- Scene breaks (`---`) between major story shifts
- End with a callback to the opening moment

See these stories for reference:
- [Marc Lou](src/stories/marc-lou.md)
- [Sara Blakely](src/stories/sara-blakely.md)
- [Pat Flynn](src/stories/pat-flynn.md)

**41 stories are currently written.** See [src/SUMMARY.md](src/SUMMARY.md) for the full list.

> ⚠️ Story facts are reconstructed from general knowledge, not sourced. Verify all figures before selling. See [USAGE.md](USAGE.md#️-before-you-charge-money).

---

## AI-Assisted Story Generation

To generate story content with AI, use the companion project at `c:/git/ai-book-factory`:

```bash
cd c:/git/ai-book-factory
python test_phase1.py single   # Generate one story
```

Copy the generated `output/books/FOUNDER/book.md` content into the corresponding story file here.

---

## GitHub Actions Workflow

The workflow at `.github/workflows/deploy.yml`:
- Triggers on every push to `main`
- Installs mdBook via pre-built binary (~15 seconds, not ~8 minutes)
- Builds the book HTML and EPUB
- Copies `index.html` into the built site
- Deploys to the `gh-pages` branch

No secrets required beyond the default `GITHUB_TOKEN`.

---

## License

Stories are original content. The project structure and scripts are MIT licensed.
