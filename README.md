# 100 Solopreneur Short Stories

A fully free, deployable book system built on mdBook + GitHub Pages + Lemon Squeezy.

**Live demo:** `https://YOUR_USERNAME.github.io/dynamic-book-generator`

---

## What This Is

A static book website that:
- Renders beautifully on desktop and mobile
- Hosts 100 founder stories in narrative essay style
- Deploys automatically on every `git push`
- Sells the full EPUB via Lemon Squeezy (zero backend, zero monthly cost)
- Exports an EPUB file for Kindle and e-readers via CI/CD

**Cost to run: $0/month**

---

## Quick Start (10 Minutes to Live)

### Prerequisites

- Git and a GitHub account
- A terminal (Git Bash on Windows, Terminal on Mac/Linux)
- mdBook installed locally (for previewing — optional for deploy)

### Step 1: Fork or clone this repo

```bash
git clone https://github.com/YOUR_USERNAME/dynamic-book-generator
cd dynamic-book-generator
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
git remote set-url origin https://github.com/YOUR_USERNAME/dynamic-book-generator.git
git push origin main
```

### Step 5: Enable GitHub Pages

In your GitHub repo:
1. Go to **Settings → Pages**
2. Source: **Deploy from a branch**
3. Branch: **gh-pages** / **/ (root)**
4. Save

Your book will be live at `https://YOUR_USERNAME.github.io/dynamic-book-generator` within 2 minutes.

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

The GitHub Actions workflow automatically builds the EPUB on every push.

To download it:
1. Go to your repo on GitHub
2. Click **Actions** tab
3. Open the latest successful workflow run
4. Download the artifact (or find `book/epub/output.epub`)

Upload this file to Lemon Squeezy as your digital product.

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

See the 3 sample stories for reference:
- [Marc Lou](src/stories/marc-lou.md)
- [Pieter Levels](src/stories/pieter-levels.md)
- [Danny Postma](src/stories/danny-postma.md)

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
