#!/usr/bin/env bash
# add-story.sh — add a single entrepreneur story file
# Usage: ./scripts/add-story.sh "Founder Name"
set -euo pipefail

if [ -z "${1:-}" ]; then
  echo "Usage: ./scripts/add-story.sh \"Founder Name\""
  exit 1
fi

TITLE="$1"

# Transliterate accents to ASCII, falling back to the raw title if iconv is unavailable.
# Kept as its own step: chaining `|| echo` onto a pipeline makes the `||` swallow
# every later stage whenever iconv succeeds, which silently skips slugification.
ASCII_TITLE=$(echo "$TITLE" | iconv -t ascii//TRANSLIT 2>/dev/null) || ASCII_TITLE="$TITLE"

# Sanitize to URL slug: lowercase, strip punctuation, replace spaces with hyphens
SLUG=$(echo "$ASCII_TITLE" \
  | tr -d "'" \
  | tr -cs '[:alnum:]' '-' \
  | tr '[:upper:]' '[:lower:]' \
  | sed 's/^-*//;s/-*$//')

if [ -z "$SLUG" ]; then
  echo "[ERROR] Could not build a filename from: $TITLE"
  exit 1
fi

FILE="src/stories/${SLUG}.md"
mkdir -p src/stories

# Duplicate detection
if [ -f "$FILE" ]; then
  echo "[SKIP] Story already exists: $FILE"
  exit 0
fi

# Write story template
cat << EOF > "$FILE"
# ${TITLE}

*Replace this line with a gripping opening scene — a specific moment, time, and number.*

---

## The Setup

Describe who they were before, what their life looked like, what wasn't working.

---

## The Turning Point

The one thing that changed everything. Be specific: what did they build, when, and what happened?

---

## The Numbers

The metric that proves the story. Revenue, users, time — make it concrete.

---

## What They Learned

One or two hard-won lessons. Not principles. The actual things they did differently.

---

## The Last Thing

End with a callback to the opening. Complete the circle.
EOF

# Ensure SUMMARY.md exists with proper structure
if [ ! -f "src/SUMMARY.md" ]; then
  cat << 'SUMMARY' > src/SUMMARY.md
# Summary

[Introduction](introduction.md)

## Stories

SUMMARY
fi

# Avoid duplicate entries in SUMMARY.md
if grep -q "stories/${SLUG}.md" src/SUMMARY.md 2>/dev/null; then
  echo "[SKIP] Already in SUMMARY.md: $TITLE"
else
  echo "- [${TITLE}](stories/${SLUG}.md)" >> src/SUMMARY.md
  echo "[OK] Added to SUMMARY.md: $TITLE"
fi

echo "[OK] Created: $FILE"
