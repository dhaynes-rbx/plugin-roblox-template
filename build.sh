#!/usr/bin/env bash
set -euo pipefail

name=$(grep -o '"name"[[:space:]]*:[[:space:]]*"[^"]*"' default.project.json | head -1 | sed 's/.*: *"//;s/"//')

echo "Installing packages..."
wally install

echo "Building $name.rbxmx..."
rojo build --plugin "$name.rbxmx"

echo "Done!"
