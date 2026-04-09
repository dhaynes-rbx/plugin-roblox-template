# plugin-roblox-template

A minimal scaffolding template for Roblox Studio plugins using [Rojo](https://rojo.space/) and [aftman](https://github.com/LPGhatguy/aftman).

## Using this template

Click **Use this template** on GitHub to create a new repository, then clone it locally.

## Setup

### 1. Install toolchain

```bash
aftman install
```

This installs Rojo (pinned in `aftman.toml`).

### 2. Rename the plugin

Edit `default.project.json` and change the `name` field from `my-plugin` to your plugin's name:

```json
{
    "name": "your-plugin-name",
    ...
}
```

### 3. Update the Cursor build rule

Open `.cursor/rules/plugin-build.mdc` and confirm the build output path matches your plugin name. The agent will read `default.project.json` automatically, but you can also hardcode it:

```bash
rojo build default.project.json --output ~/Documents/Roblox/Plugins/your-plugin-name.rbxmx
```

### 4. Build and install the plugin

```bash
rojo build default.project.json --output ~/Documents/Roblox/Plugins/your-plugin-name.rbxmx
```

Open Roblox Studio — your plugin will appear in the **Plugins** toolbar.

## Project structure

```
.
├── src/
│   └── init.server.luau   # Plugin entry point (toolbar, UI, action handler)
├── default.project.json   # Rojo project config
├── aftman.toml            # Toolchain versions (Rojo)
├── selene.toml            # Luau linter config
├── stylua.toml            # Luau formatter config
└── .cursor/rules/
    ├── plugin-build.mdc   # Auto-build rule for Cursor agents
    └── plugin-testing.mdc # Auto-test rule for Cursor agents
```

## Development workflow

1. Edit `src/init.server.luau` (and add any modules under `src/`).
2. Build: `rojo build default.project.json --output ~/Documents/Roblox/Plugins/<name>.rbxmx`
3. Reload the plugin in Roblox Studio (**Plugins → Manage Plugins → Reload**).
4. Test in the Studio viewport.

## Linting & formatting

```bash
# Lint
selene src/

# Format
stylua src/
```
