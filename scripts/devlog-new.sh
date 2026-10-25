#!/usr/bin/env bash
# Usage: bash scripts/devlog-new.sh <type> "<title>"
set -euo pipefail
TYPE="${1:?type: feat|fix|perf|refactor|docs|chore|decision}"
TITLE="${2:?title required}"
case "$TYPE" in feat|fix|perf|refactor|docs|chore|decision) ;; *) echo "invalid type: $TYPE" >&2; exit 1;; esac

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DIR="$ROOT/docs/devlog"; ENT="$DIR/entries"; IDX="$DIR/INDEX.md"
mkdir -p "$ENT"

LAST=$(ls "$ENT" 2>/dev/null | grep -E '^[0-9]{4}-' | sed -E 's/^([0-9]{4}).*/\1/' | sort | tail -1 || true)
NUM=$(printf "%04d" $((10#${LAST:-0} + 1)))
SLUG=$(printf '%s' "$TITLE" \
  | sed 's/ç/c/g; s/ğ/g/g; s/ı/i/g; s/ö/o/g; s/ş/s/g; s/ü/u/g; s/Ç/C/g; s/Ğ/G/g; s/İ/I/g; s/Ö/O/g; s/Ş/S/g; s/Ü/U/g; s/â/a/g; s/î/i/g; s/û/u/g' \
  | tr '[:upper:]' '[:lower:]' \
  | sed -E 's/[^a-z0-9]+/-/g; s/^-+|-+$//g' | cut -c1-50 || true)
[ -z "$SLUG" ] && SLUG="entry"
FILE="$ENT/$NUM-$TYPE-$SLUG.md"
DATE="$(date +%Y-%m-%d)"

sed -e "s/{{NUM}}/$NUM/g" -e "s/{{TITLE}}/$TITLE/g" -e "s/{{DATE}}/$DATE/g" -e "s/{{TYPE}}/$TYPE/g" \
  "$DIR/TEMPLATE.md" > "$FILE"

ROW="| $NUM | $DATE | $TYPE | $TITLE | in-progress | (özet yaz) | [$NUM](entries/$NUM-$TYPE-$SLUG.md) |"
printf '%s\n' "$ROW" >> "$IDX"

echo "Created: ${FILE#$ROOT/}"
echo "Index row appended. Fill the entry, then set Status/Summary in INDEX.md."
