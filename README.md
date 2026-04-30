# plugin-roblox-template

A minimal scaffolding template for Roblox Studio plugins using [Rojo](https://rojo.space/) and [aftman](https://github.com/LPGhatguy/aftman).

## Using this template

Click **Use this template** on GitHub to create a new repository, then clone it locally.

## Prerequisites

- **Git** — to clone the repository ([download](https://git-scm.com/downloads))
- **aftman** — toolchain manager ([installation guide](https://github.com/LPGhatguy/aftman#installation))
- **Roblox Studio** — installed and signed in

## Quick start

Run the bootstrap script to set your plugin name and install tools in one step:

**Windows (PowerShell):**

```powershell
.\setup.ps1
```

**Mac / Linux / Git Bash:**

```bash
bash setup.sh
```

The script will prompt for your plugin name, update all config files, install the toolchain, fetch packages, and build the plugin.

If you prefer to set up manually, follow the steps below.

## Manual setup

### 1. Install toolchain

```bash
aftman install
```

This installs Rojo and Wally (pinned in `aftman.toml`).

### 2. Rename the plugin

Update the following three locations with your plugin name:

- **`default.project.json`** — change the `name` field from `"template-plugin"` to your plugin name (e.g. `"my-cool-plugin"`). This controls the build output filename.
- **`src/init.server.luau`** — change the `PLUGIN_NAME` variable from `"Template Plugin"` to your display name (e.g. `"My Cool Plugin"`). This controls what appears in Studio.
- **`.cursor/rules/plugin-build.mdc`** — change `template-plugin.rbxmx` to match the name in `default.project.json` (e.g. `my-cool-plugin.rbxmx`).

### 3. Install packages and build

```bash
wally install
rojo build --plugin template-plugin.rbxmx
```

Open Roblox Studio — your plugin will appear in the **Plugins** toolbar.

## Project structure

```
.
├── src/
│   └── init.server.luau   # Plugin entry point (toolbar, UI, action handler)
├── default.project.json   # Rojo project config
├── aftman.toml            # Toolchain versions (Rojo, Wally)
├── wally.toml             # Package dependencies (React, ReactRoblox)
├── selene.toml            # Luau linter config
├── stylua.toml            # Luau formatter config
├── setup.ps1              # Bootstrap script (Windows / PowerShell)
├── setup.sh               # Bootstrap script (Mac / Bash)
└── .cursor/rules/
    ├── plugin-build.mdc   # Auto-build rule for Cursor agents
    └── plugin-testing.mdc # Auto-test rule for Cursor agents
```

## Development workflow

1. Edit `src/init.server.luau` (and add any modules under `src/`).
2. Build: `rojo build --plugin <your-plugin-name>.rbxmx`
3. Reload the plugin in Roblox Studio (**Plugins → Manage Plugins → Reload**).
4. Test in the Studio viewport.

## Packages

This template uses [Wally](https://wally.run/) for package management. Dependencies are declared in `wally.toml` and installed into the `Packages/` directory.

The template includes [React](https://github.com/jsdotlua/react-lua) and [ReactRoblox](https://github.com/jsdotlua/react-lua) from jsdotlua. To add more packages, edit `wally.toml` and run:

```bash
wally install
```

Then rebuild the plugin so the new packages are included.

## Linting & formatting

```bash
# Lint
selene src/

# Format
stylua src/
```
