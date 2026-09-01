# Project Plan

Phases to go from 41 stories → published, selling product.

---

## Phase 1 — Foundation ✅ DONE

**Goal:** Working site that auto-deploys.

- [x] mdBook project with `book.toml`, `src/`, `SUMMARY.md`
- [x] GitHub repo created and pushed
- [x] GitHub Pages enabled, live URL working
- [x] `deploy.yml` GitHub Actions workflow
- [x] Landing page `index.html`
- [x] `add-story.sh` and `batch-generate-stories.sh` scripts
- [x] README.md and USAGE.md

---

## Phase 2 — Core Content (41/100) 🔄 IN PROGRESS

**Goal:** Enough high-quality stories to sell.

- [x] 41 stories written and live on site
- [ ] Verify revenue/date claims against public sources (tweets, interviews, post-mortems)
- [ ] Remove or replace Jon O'Bryan (unverifiable subject)
- [ ] Write stories 42–59 (next batch — see `names.txt`)
- [ ] Write stories 60–79
- [ ] Write stories 80–100

**Launch gate:** Can launch at 41 with Early Access framing. Do not wait for 100.

---

## Phase 3 — Export Pipeline ✅ DONE (needs one upgrade)

**Goal:** EPUB and PDF produced reliably, stored permanently.

- [x] EPUB generated locally via prebuilt `mdbook-epub.exe`
- [x] EPUB page-break bug fixed (`epub-override.css`)
- [x] PDF generated locally via `generate-pdf.sh` (headless Edge)
- [x] PDF CI pipeline (`generate-pdf.yml`) — builds on ubuntu-latest
- [ ] **UPGRADE: Change `generate-pdf.yml` to publish PDF to GitHub Release** instead of artifact
      (artifacts expire in 90 days; Releases are permanent and give a stable download URL)
- [ ] **UPGRADE: Move EPUB build into CI** — add `[output.epub]` build + `mv book/html/* book/`
      restructure step before deploy, so EPUB is always in sync with latest stories

---

## Phase 4 — Pre-Launch Content Audit ❌ NOT STARTED

**Goal:** Book is safe to sell.

- [ ] Add disclaimer to `src/introduction.md` front matter:
      *"These stories are dramatized retellings based on publicly available information.
      Specific figures and dialogue are reconstructed for narrative purposes."*
- [ ] Add same disclaimer to `index.html` landing page (small text under CTA)
- [ ] Verify top 10 stories: check at least one primary source per revenue/date claim
- [ ] Remove Jon O'Bryan or replace with a verified founder
- [ ] Update story count in `index.html` stats bar (currently says "100") to match reality (41 or "41+")
- [ ] Update book title/subtitle to reflect actual state — options:
      - "41 Solopreneur Short Stories" (honest, simple)
      - "100 Solopreneur Short Stories — Early Access" (signals more coming)
      - Keep "100" but add note "Volume 1: First 41 Stories, more added monthly"

---

## Phase 5 — Payment Setup ❌ NOT STARTED

**Goal:** Someone can actually buy the book.

- [ ] Create Lemon Squeezy account at https://lemonsqueezy.com
- [ ] Create one product: "Solopreneur Stories — EPUB + PDF Bundle"
- [ ] Attach both files: `.epub` (from local build) and `.pdf` (from CI Release download)
- [ ] Set price: $9 suggested (both AIs: keep single price, no tiering)
- [ ] Copy the checkout URL
- [ ] Replace `YOUR_PAYMENT_URL_HERE` in `index.html` (line 194)
- [ ] Replace `YOUR_LEMON_SQUEEZY_OR_GUMROAD_URL` in `src/introduction.md` (line 10)
- [ ] Update CTA text: "Download EPUB + PDF — $9" (not just EPUB)
- [ ] Update footer: "EPUB + PDF available for $9"
- [ ] `git commit` and `git push` — site goes live with working buy button

---

## Phase 6 — Launch ❌ NOT STARTED

**Goal:** First paying customer.

- [ ] Announce on Twitter/X with first story teaser
- [ ] Post to Indie Hackers (show HN or product launch)
- [ ] Share in relevant communities (r/SideProject, r/solopreneur)
- [ ] Monitor Lemon Squeezy dashboard for purchases
- [ ] Validate auto-delivery works (buy a test copy yourself first)

---

## Phase 7 — Grow to 100 Stories ❌ FUTURE

**Goal:** Deliver on the "100 stories" promise to early buyers.

- [ ] Continue writing stories from `names.txt`
- [ ] Publish updates via `git push` (site auto-rebuilds)
- [ ] Re-upload updated EPUB + PDF to Lemon Squeezy after each batch
- [ ] Email Early Access buyers when complete edition ships
- [ ] Update price to $12–$15 when 100 stories are live

---

## Decision Log

| Date | Decision | Choice | Reason |
|---|---|---|---|
| 2026-09-01 | PDF delivery method | GitHub Release (not artifact) | Artifacts expire in 90 days; Releases are permanent |
| 2026-09-01 | EPUB in CI | Yes, with `mv` restructure | Local-only builds cause human error (forget to update) |
| 2026-09-01 | Product structure | Single bundle EPUB+PDF | Eliminates decision fatigue; same checkout friction as one product |
| 2026-09-01 | Launch timing | Launch at 41 with Early Access | Waiting for 100 means months of zero revenue validation |
| 2026-09-01 | John O'Bryan story | Remove before launch | Cannot verify as real person; legal exposure |
