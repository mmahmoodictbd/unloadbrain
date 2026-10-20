#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v quarto >/dev/null 2>&1; then
  echo "Quarto is required to preview this site. Install it from https://quarto.org/docs/get-started/." >&2
  exit 1
fi

printf 'Which project would you like to preview?\n  1) Blog (http://localhost:4000)\n  2) Recipe book (http://localhost:4001)\n'
read -r -p 'Choose 1 or 2: ' choice

case "$choice" in
  1)
    exec quarto preview --port 4000
    ;;
  2)
    exec quarto preview books/recipes-for-the-amature-husbends --port 4001
    ;;
  *)
    echo "Invalid choice: choose 1 for the blog or 2 for the recipe book." >&2
    exit 1
    ;;
esac
