#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

echo "=== Roblox Plugin Setup ==="
echo ""

read -rp "Enter your plugin name (e.g. my-cool-plugin): " name
if [ -z "$name" ]; then
    echo "No name provided. Exiting."
    exit 1
fi

read -rp "Enter a display name for Studio (e.g. My Cool Plugin): " display_name
if [ -z "$display_name" ]; then
    display_name="$name"
fi

echo ""
echo "Updating config files..."

if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "s/\"template-plugin\"/\"$name\"/" default.project.json
    sed -i '' "s|your-username/template-plugin|your-username/$name|" wally.toml
    sed -i '' "s/template-plugin\.rbxmx/$name.rbxmx/" .cursor/rules/plugin-build.mdc
    sed -i '' "s/local PLUGIN_NAME = \"Template Plugin\"/local PLUGIN_NAME = \"$display_name\"/" src/App.server.luau
else
    sed -i "s/\"template-plugin\"/\"$name\"/" default.project.json
    sed -i "s|your-username/template-plugin|your-username/$name|" wally.toml
    sed -i "s/template-plugin\.rbxmx/$name.rbxmx/" .cursor/rules/plugin-build.mdc
    sed -i "s/local PLUGIN_NAME = \"Template Plugin\"/local PLUGIN_NAME = \"$display_name\"/" src/App.server.luau
fi

echo "Installing toolchain..."
aftman install

echo "Installing packages..."
wally install

echo "Building plugin..."
rojo build --plugin "$name.rbxmx"

echo ""
echo "Done! Open Roblox Studio to find your plugin in the Plugins toolbar."
