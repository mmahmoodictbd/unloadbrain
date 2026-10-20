#!/usr/bin/env bash
set -euo pipefail

image="unloadbrain-quarto"
case "${1:-}" in
  build)
    docker build -t "$image" .
    docker run --rm -v "$PWD/_site:/usr/src/app/_site" "$image" \
      sh -c 'python3 scripts/build_site_data.py && quarto render'
    ;;
  serve)
    docker build -t "$image" .
    docker run --rm -p 4000:4000 -v "$PWD:/usr/src/app" "$image"
    ;;
  *)
    echo "Usage: $0 {build|serve}" >&2
    exit 1
    ;;
esac
