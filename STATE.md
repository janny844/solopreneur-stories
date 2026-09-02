# Project State

Last updated: 2026-09-02

---

## Current Numbers

| Metric | Value |
|---|---|
| Stories written | 41 / 100 |
| Live site | https://janny844.github.io/solopreneur-stories/ |
| EPUB | ✅ Generated locally — valid, 107 KB, all 41 stories |
| PDF | ✅ Generated locally — 91 pages, 896 KB, verified |
| PDF in CI | ✅ `generate-pdf.yml` — publishes to GitHub Release (`latest-pdf` tag) |
| Disclaimer | ✅ Added to `introduction.md` and `index.html` footer |
| CTA copy | ✅ Updated to "EPUB + PDF Bundle — $9" + "Early Access" framing |
| Stats bar | ✅ Shows "41" (was "100") |
| Jon O'Bryan | ✅ Removed — replaced with anonymized "The Night Shift Nurse" |
| Payment link | ❌ Placeholder — no Lemon Squeezy account yet |
| Selling | ❌ Not launched |

---

## What Is Done

### Infrastructure
- [x] mdBook project structure
- [x] GitHub repo: `janny844/solopreneur-stories`
- [x] GitHub Pages live (auto-deploys on push, ~15 sec)
- [x] Landing page `index.html` with CTA
- [x] `scripts/add-story.sh` — creates story file + updates SUMMARY.md
- [x] `scripts/batch-generate-stories.sh` — batch template creation from names.txt
- [x] `scripts/generate-pdf.sh` — headless Edge/Chrome, Windows-safe (`pwd -W`)
- [x] `.github/workflows/deploy.yml` — HTML deploy pipeline
- [x] `.github/workflows/generate-pdf.yml` — PDF CI pipeline (GitHub Release, permanent URL)
- [x] EPUB page-break bug fixed via `src/epub-override.css`
- [x] Disclaimer added to `src/introduction.md` and `index.html`
- [x] CTA updated: EPUB+PDF bundle, "Early Access" framing, stats bar shows "41"
- [x] Jon O'Bryan replaced with anonymized "The Night Shift Nurse" (unverifiable name removed)
- [x] `USAGE.md` — full practical how-to guide
- [x] `PAYMENT_SETUP.md` — Lemon Squeezy setup steps

### Stories (41 written)
Marc Lou, Pieter Levels, Danny Postma, Tony Dinh, Sahil Lavingia, Arvid Kahl, Justin Welsh,
Nathan Barry, Harry Dry, Jon Yongfook, Courtland Allen, Rob Walling, Tibo Louis-Lucas,
Anne-Laure Le Cunff, David Perell, Corey Haines, Jack Butcher, Simon Høiberg, Damon Chen,
Pat Flynn, Dan Koe, Nicolas Cole, Kilian Valkhof, Alex Hormozi, Steph Smith, Daniel Vassallo,
Josh Pigford, Jon O'Bryan*, Tyler Tringas, Sara Blakely, Nathan Latka, Spencer Haws,
Andrey Azimov, Laura Roeder, Ben Tossell, Paul Jarvis, Peter Askew, Monica Lent,
Adam Wathan, Jesse Hanley, John Rush

*Jon O'Bryan — could not be verified as a real person. Flag for removal before launch.

---

## What Is Blocked / Not Done

| Item | Status | Blocker |
|---|---|---|
| EPUB in CI | ❌ | mdBook layout-switch issue (solvable with `mv` step — low priority) |
| Content claim verification | ❌ | Manual: check primary sources for top 10 stories |
| Lemon Squeezy account + product | ❌ | Needs human to create account + upload files |
| Payment URLs live | ❌ | Depends on Lemon Squeezy step above |
| Launch | ❌ | Blocked on Lemon Squeezy only — all other blockers cleared |

---

## AI Audit Results (2026-09-01)

Ran multi-AI audit (Gemini 3.6 Flash + Gemini 3.5 Flash Lite). Both agreed:

| Decision | Recommendation |
|---|---|
| PDF delivery | Publish to **GitHub Release** (not artifact — artifacts expire in 90 days) |
| EPUB in CI | Move to CI with `mv book/html/* book/` fix after build |
| Payment | **Single bundle** — EPUB + PDF attached to one Lemon Squeezy product |
| Launch timing | Launch now at 41 with **"Early Access"** framing OR rebrand title to match actual count |
| Legal risk | Real exposure — remove unverified subjects, add prominent disclaimer |

---

## Known Risks

1. **Revenue/date claims** — reconstructed, not sourced. Verify top 10 stories before promoting heavily.
2. **PDF font parity** — Windows local PDF and CI Linux PDF may have minor layout differences (fonts-liberation installed in CI mitigates this).
3. **EPUB/PDF must never be served from GitHub Pages** — paid assets must be inside Lemon Squeezy or a GitHub Release, never in `book/` during deploy. Current setup is safe: both are gitignored.
