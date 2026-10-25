#!/usr/bin/env bash

set -e

# Download catalog.json from the main branch of each repo and merge them
# into catalog.json next to this script.

REPOS="catalog gatekeeper starlark"
OUT="$(dirname "$(realpath "$0")")/catalog.json"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

files=()
for repo in $REPOS; do
        file="$TMPDIR/$repo.json"
        curl -fsSL -o "$file" "https://raw.githubusercontent.com/krm-functions/$repo/main/catalog.json"
        files+=("$file")
done

jq -s '.[0].functions=([.[].functions]|flatten)|.[0]' "${files[@]}" >"$TMPDIR/merged.json"
mv "$TMPDIR/merged.json" "$OUT"
