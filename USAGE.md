# How To Use This Book Factory

Practical instructions for running, editing, and publishing the book.

| Thing | Value |
|---|---|
| Local folder | `C:\git\dynamic-book-generator` |
| GitHub repo | https://github.com/janny844/solopreneur-stories |
| Live site | https://janny844.github.io/solopreneur-stories/ |
| Stories now | 41 |
| Cost to run | $0/month |

---

## The 30-Second Version

```bash
cd /c/git/dynamic-book-generator

# 1. Add a story file
./scripts/add-story.sh "Some Founder"

# 2. Write the story in src/stories/some-founder.md

# 3. Publish
git add .
git commit -m "add story: Some Founder"
git push
```

Wait ~60 seconds. The site rebuilds itself. That's the whole workflow.

---

## How Publishing Actually Works

You never build the site yourself. Pushing is publishing.

```
git push  →  GitHub Actions  →  mdbook build  →  gh-pages branch  →  live site
             (~9 seconds)                          (~30 sec to propagate)
```

The workflow lives at [.github/workflows/deploy.yml](.github/workflows/deploy.yml). It runs on every push to `main`. No secrets needed — it uses the built-in `GITHUB_TOKEN`.

**Check a deploy:**
```bash
gh run list --limit 3          # see recent runs
gh run view --log-failed       # if one failed, read why
```

---

## Adding Stories

### One at a time

```bash
./scripts/add-story.sh "Alex Hormozi"
```

This does three things:
1. Creates `src/stories/alex-hormozi.md` from a template
2. Appends a link to `src/SUMMARY.md`
3. Skips safely if the story already exists (won't overwrite your writing)

Then open the file and replace the template prompts with real content.

### Many at once

Put names in `names.txt`, one per line, then:

```bash
./scripts/batch-generate-stories.sh names.txt
```

This creates **empty templates only** — it does not write the stories. You still fill each one in.

### The nav menu

`src/SUMMARY.md` is the table of contents. A story file that isn't listed there **will not appear on the site**. The script handles this automatically, but if you create a file by hand, add the line yourself:

```markdown
- [Alex Hormozi](stories/alex-hormozi.md)
```

---

## Previewing Before You Publish

You currently have **no local mdBook installed**, so you have two options.

### Option A — Just push (easiest)

Push to a branch and look at the deploy, or push to `main` and look at the live site. For a text-only book this is usually fine.

### Option B — Install mdBook for real local preview

Download the Windows binary from https://github.com/rust-lang/mdBook/releases, unzip it, put `mdbook.exe` somewhere on your PATH, then:

```bash
cd /c/git/dynamic-book-generator
mdbook serve --open        # live-reloads at http://localhost:3000
```

This is worth doing if you plan to edit CSS or layout, since those are hard to judge without seeing them.

---

## Getting an EPUB (to sell)

**Heads up: EPUB is not generated automatically.** The deploy pipeline builds HTML only, and `[output.epub]` is deliberately **not** kept in the committed `book.toml`. If it were, the next CI build would nest HTML under `book/html/` instead of `book/` (mdBook changes its output layout the moment more than one renderer is configured), which would 404 every page on the live site. Generate the EPUB locally instead — no need to touch the repo config permanently.

You do **not** need to install Rust/cargo for this — both tools ship prebuilt Windows binaries, which is faster and avoids needing a C linker:

```bash
mkdir -p .tools/bin
cd .tools/bin

# mdBook itself
gh release download -R rust-lang/mdBook -p "mdbook-*-x86_64-pc-windows-msvc.zip" --clobber
unzip -o mdbook-*.zip && rm mdbook-*.zip

# the EPUB renderer plugin — must be named exactly mdbook-epub.exe to be found by mdBook
gh release download -R Michael-F-Bryan/mdbook-epub -p "mdbook-epub-windows-amd64.exe" --clobber
mv mdbook-epub-windows-amd64.exe mdbook-epub.exe
chmod +x mdbook-epub.exe

cd ../..
```

Then, **temporarily** add this to the bottom of `book.toml` (do not commit it — see warning above):

```toml
[output.epub]
```

Build with the local tools on PATH:
```bash
PATH="$PWD/.tools/bin:$PATH" mdbook build
# EPUB appears at: book/epub/100 Solopreneur Short Stories.epub
# HTML appears at: book/html/  (nested, because 2 renderers are now active — ignore it, don't push it)
```

**Then revert `book.toml`** — remove the `[output.epub]` line before committing anything else, so the live deploy pipeline stays on its flat, working HTML layout.

Upload the resulting `.epub` file to Lemon Squeezy as the digital product. `.tools/` and `*.epub` are both gitignored — the binaries and the book file are local-only and never get pushed.

---

## Turning On Payments

The buy buttons are currently **placeholders and do not work**. Two strings need replacing:

| File | Placeholder |
|---|---|
| [index.html](index.html) | `YOUR_PAYMENT_URL_HERE` |
| [src/introduction.md](src/introduction.md) | `YOUR_LEMON_SQUEEZY_OR_GUMROAD_URL` |

Steps:
1. Create a free account at https://lemonsqueezy.com
2. New Product → Digital → upload your EPUB
3. Set price (suggested: $9)
4. Copy the checkout URL
5. Replace both placeholders with it
6. `git commit` and `git push`

Full detail in [PAYMENT_SETUP.md](PAYMENT_SETUP.md).

Lemon Squeezy is used instead of raw Stripe because it delivers the file by email automatically and handles VAT. Raw Stripe would need a backend server, which would break the $0/month model.

---

## Editing Look and Feel

| What | Where |
|---|---|
| Book title / author | `book.toml` under `[book]` |
| Reading page styles | `src/custom.css` |
| Marketing landing page | `index.html` |
| Book's first page + CTA | `src/introduction.md` |
| Chapter order | `src/SUMMARY.md` |

Reorder chapters by rearranging lines in `SUMMARY.md`. The order in that file is the order on the site.

---

## Writing Style Guide

Stories follow a narrative essay style. The rules that make them work:

- **Open mid-scene.** A specific time, place, and number. Not "X was born in..."
- **Show emotion through action.** "He refreshed the dashboard. $0." not "He felt discouraged."
- **Use real numbers.** Dates, revenue, user counts. Vagueness kills it.
- **Use `---` scene breaks** between major shifts.
- **Close with a callback** to the opening image.

Good reference examples: [marc-lou.md](src/stories/marc-lou.md), [sara-blakely.md](src/stories/sara-blakely.md), [pat-flynn.md](src/stories/pat-flynn.md).

---

## Troubleshooting

**Deploy failed — how do I see why?**
```bash
gh run view --log-failed
```
Read the actual error. The last failure was a bad field in `book.toml`; the log named the exact line.

**A story I added isn't on the site.**
It's missing from `src/SUMMARY.md`. Add the link line.

**`create-missing = false` error during build.**
`book.toml` is set to fail if `SUMMARY.md` links to a file that doesn't exist. This is deliberate — it catches typos. Fix the filename or create the missing file.

**Script says `[SKIP] Story already exists`.**
That's protection, not an error. It refuses to overwrite writing you've already done.

**Site shows old content.**
Hard-refresh (`Ctrl+F5`). GitHub Pages caches aggressively.

---

## ⚠️ Before You Charge Money

The 41 stories were written from general knowledge of public founders. Specific figures, dates, and scene details are **reconstructed, not sourced** — some will be wrong, and at least one subject (`john-obrien.md`) I could not verify as a real person.

Before selling this:
- Verify every revenue and date claim against a primary source
- Remove or replace any subject you can't verify
- Consider a note stating stories are dramatized retellings

Publishing unverified financial claims about named real people carries genuine legal and reputational exposure.
