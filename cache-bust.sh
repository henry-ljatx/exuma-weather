#!/bin/bash

# Cache-busting script for GitHub Pages
# Increments version number in index.html to force browser cache invalidation

VERSION_FILE=".cache-version"
CURRENT_VERSION=${1:-$(cat "$VERSION_FILE" 2>/dev/null || echo "0")}
NEW_VERSION=$((CURRENT_VERSION + 1))

# Update version number in index.html using proper escaping
sed -i.bak "s/const version = '[^']*'/const version = '$NEW_VERSION'/" index.html
rm -f index.html.bak

# Save new version number
echo "$NEW_VERSION" > "$VERSION_FILE"

# Update cache buster file timestamp
date > _cache_buster.txt

echo "✅ Cache-busted: v$CURRENT_VERSION → v$NEW_VERSION"
echo "   Modified: index.html, $VERSION_FILE, _cache_buster.txt"
