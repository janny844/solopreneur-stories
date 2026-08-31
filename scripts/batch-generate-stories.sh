#!/usr/bin/env bash
# batch-generate-stories.sh — batch create story files from a names list
# Usage: ./scripts/batch-generate-stories.sh [names.txt]
set -euo pipefail

NAMES_FILE="${1:-names.txt}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ADD_SCRIPT="${SCRIPT_DIR}/add-story.sh"

if [ ! -f "$NAMES_FILE" ]; then
  echo "[ERROR] File not found: $NAMES_FILE"
  echo "Create a text file with one founder name per line, then run:"
  echo "  ./scripts/batch-generate-stories.sh names.txt"
  exit 1
fi

chmod +x "$ADD_SCRIPT"

count=0
skipped=0

echo "[BATCH] Reading from: $NAMES_FILE"
echo "--------------------------------------"

while IFS= read -r line || [ -n "$line" ]; do
  # Skip empty lines and comment lines
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  if "$ADD_SCRIPT" "$line"; then
    ((count++)) || true
  else
    ((skipped++)) || true
  fi

done < "$NAMES_FILE"

echo "--------------------------------------"
echo "[DONE] Created: $count  |  Skipped: $skipped"
echo "[INFO] Run 'mdbook build' to preview, or push to GitHub to deploy."
