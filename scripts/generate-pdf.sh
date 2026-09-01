#!/usr/bin/env bash
# generate-pdf.sh — build the book and print it to a single PDF via headless Edge/Chrome.
#
# Why this exists: mdBook has no first-party PDF renderer. The standard trick is to
# print mdBook's own auto-generated "whole book on one page" file (book/print.html)
# through a real browser's print-to-PDF engine, so typography matches the live site
# exactly. No Rust/cargo/plugin needed for this step.
#
# Path gotcha this script exists to avoid: `pwd` under Git Bash returns a POSIX-style
# path (/c/git/...). Handing that straight to a native Windows browser .exe in a
# file:// URL fails silently — Edge just renders its own "File not found" page,
# which still produces a real (tiny, blank) PDF with no error. Always convert with
# `pwd -W` first and verify the output actually contains book text before trusting it.
set -euo pipefail

cd "$(dirname "$0")/.."

OUT_NAME="${1:-100-solopreneur-short-stories.pdf}"
LOCAL_TOOLS="$(pwd)/.tools/bin"

# Prefer locally downloaded mdbook (see USAGE.md) if present, else fall back to PATH.
if [ -x "$LOCAL_TOOLS/mdbook.exe" ]; then
  export PATH="$LOCAL_TOOLS:$PATH"
fi

if ! command -v mdbook >/dev/null 2>&1; then
  echo "[ERROR] mdbook not found. See USAGE.md 'Previewing Before You Publish' for how to fetch the prebuilt binary."
  exit 1
fi

# Locate a Chromium-family browser. Check common Windows install paths first.
BROWSER=""
for candidate in \
  "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
  "/c/Program Files/Microsoft/Edge/Application/msedge.exe" \
  "/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe"; do
  if [ -x "$candidate" ]; then
    BROWSER="$candidate"
    break
  fi
done

if [ -z "$BROWSER" ]; then
  echo "[ERROR] Could not find Edge or Chrome in any standard install location."
  echo "        Install one, or edit this script to add its path."
  exit 1
fi

echo "[INFO] Using browser: $BROWSER"
echo "[INFO] Building book (single-renderer, flat HTML output)..."

# Deliberately does NOT enable [output.epub] here — a second renderer changes
# mdBook's output layout (book/html/ + book/epub/ instead of flat book/), which
# would move print.html to a different path. Keep this build single-renderer.
rm -rf book
mdbook build

if [ ! -f "book/print.html" ]; then
  echo "[ERROR] book/print.html was not generated. Check the mdbook build output above."
  exit 1
fi

# Windows-style absolute path (C:/...), required for a file:// URL passed to a
# native .exe — a Git-Bash POSIX path (/c/...) here fails silently, see header comment.
WIN_PRINT_HTML="$(pwd -W)/book/print.html"
OUT_PATH="$(pwd -W)/book/$OUT_NAME"

echo "[INFO] Printing book/print.html to PDF..."
"$BROWSER" --headless --disable-gpu --print-to-pdf="$OUT_PATH" "file:///$WIN_PRINT_HTML"

# Give the headless process a moment to flush the file before we check it.
sleep 2

if [ ! -f "book/$OUT_NAME" ]; then
  echo "[ERROR] PDF was not created at book/$OUT_NAME"
  exit 1
fi

SIZE=$(stat -c%s "book/$OUT_NAME" 2>/dev/null || stat -f%z "book/$OUT_NAME")
if [ "$SIZE" -lt 50000 ]; then
  echo "[WARN] book/$OUT_NAME is only $SIZE bytes — suspiciously small for a 41-story book."
  echo "       This is the exact symptom of the file:// path bug (Edge prints its own"
  echo "       'File not found' page instead of the book). Verify with:"
  echo "         pdftotext \"book/$OUT_NAME\" - | head -20"
  exit 1
fi

echo "[OK] Created: book/$OUT_NAME ($SIZE bytes)"
