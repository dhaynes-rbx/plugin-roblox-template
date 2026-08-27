# plugin-roblox-template

A template for Roblox Studio plugins with **always-on right-side panels** that respond to the current selection. Built with [Rojo](https://rojo.space/), [React-lua](https://github.com/jsdotlua/react-lua), and [aftman](https://github.com/LPGhatguy/aftman).

Panels appear automatically when a relevant object is selected — no toolbar toggle required.

## Using this template

Click **Use this template** on GitHub to create a new repository, then clone it locally.

For a real-world example of a plugin built on this framework, see [dhaynes-studio-super-plugin](https://github.com/dhaynes-rbx/dhaynes-studio-super-plugin).

## Prerequisites

- **Git** — to clone the repository ([download](https://git-scm.com/downloads))
- **aftman** — toolchain manager ([installation guide](https://github.com/LPGhatguy/aftman#installation))
- **Roblox Studio** — installed and signed in

## Quick start

Run the bootstrap script to set your plugin name and install tools in one step:

**Windows (PowerShell):**

```powershell
.\tools\setup.ps1
```

**Mac / Linux / Git Bash:**

```bash
bash tools/setup.sh
```

The script will prompt for your plugin name, update all config files, install the toolchain, fetch packages, and build the plugin.

## Architecture

```
Selection changes → PanelStack re-renders → each panel returns nil or UI
```

The plugin mounts a `ScrollingFrame` in CoreGui on load. Inside it, each panel component watches `Selection.SelectionChanged` and returns `nil` when its target type is not selected:

```
src/
├── App.server.luau          # Entry point — mounts PanelStack via WatchForSelection
├── WatchForSelection.luau   # Creates ScreenGui + React root in CoreGui
├── ExampleTool.luau         # Tool module — side-effect logic (no UI)
└── Components/
    ├── PanelStack.luau      # ScrollingFrame hosting all panels
    ├── ExamplePanel.luau    # Selection-gated panel (shows for Parts)
    ├── Theme.luau           # Shared visual tokens (colors, fonts, width)
    ├── Panel.luau           # Shared dark panel shell
    ├── Header.luau          # Collapsible header with title
    ├── SelectionButton.luau # Full-width action button
    └── Spacer.luau          # Vertical spacing helper
```

## Adding a new tool

The pattern: **Tool module** (`src/<Name>.luau`) for logic, **Panel** (`src/Components/<Name>Panel.luau`) for UI.

1. Create `src/MyTool.luau` with your side-effect functions.
2. Create `src/Components/MyToolPanel.luau`:
   - Watch `SelectionService` — return `nil` if nothing relevant is selected.
   - Use `Panel`, `Header`, `SelectionButton`, and `Theme` for a consistent look.
3. Register in `src/Components/PanelStack.luau` with a unique `layoutOrder`.
4. Build: `rojo build --plugin <name>.rbxmx`

The `.cursor/rules/script-to-panel.mdc` rule guides Cursor agents through this process automatically.

## Manual setup

### 1. Install toolchain

```bash
aftman install
```

### 2. Rename the plugin

Update these locations with your plugin name:

- **`default.project.json`** — `name` field (controls build output filename)
- **`src/App.server.luau`** — `PLUGIN_NAME` variable (Studio display name)
- **`.cursor/rules/plugin-build.mdc`** — build command filename

### 3. Install packages and build

```bash
wally install
rojo build --plugin <your-plugin-name>.rbxmx
```

Open Roblox Studio — your plugin panels will appear on the right side when you select a Part.

## Development workflow

1. Edit files under `src/`.
2. Build: `rojo build --plugin <your-plugin-name>.rbxmx`
3. Reload the plugin in Roblox Studio (**Plugins → Manage Plugins → Reload**).
4. Select a Part in the viewport to see the Example panel appear.

## Packages

Dependencies are managed with [Wally](https://wally.run/) and declared in `wally.toml`. The template includes React and ReactRoblox from jsdotlua.

```bash
wally install
```

## Linting & formatting

```bash
selene src/
stylua src/
```
