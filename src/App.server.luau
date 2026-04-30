--!strict

local CoreGui = game:GetService("CoreGui")

local React = require(script.Parent.Packages.React)
local ReactRoblox = require(script.Parent.Packages.ReactRoblox)
local Plugin = require(script.Parent.Components.Plugin)

-- CUSTOMIZE: Set your plugin's display name here.
local PLUGIN_NAME = "Template Plugin"

local e = React.createElement

-- Toolbar ---------------------------------------------------------------

local toolbar = plugin:CreateToolbar(PLUGIN_NAME)
local toggleButton = toolbar:CreateButton(
	PLUGIN_NAME,
	"Toggle the plugin panel",
	"rbxassetid://4458901886" -- CUSTOMIZE: Replace with your own toolbar icon asset ID
)
toggleButton.ClickableWhenViewportHidden = true

-- Mount container -------------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = PLUGIN_NAME .. "Gui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false
gui.Parent = CoreGui

local root = ReactRoblox.createRoot(gui)

-- Toggle ----------------------------------------------------------------

toggleButton:SetActive(gui.Enabled)

toggleButton.Click:Connect(function()
	gui.Enabled = not gui.Enabled
	toggleButton:SetActive(gui.Enabled)
end)

-- Render ----------------------------------------------------------------

root:render(e(Plugin, { pluginName = PLUGIN_NAME }))

-- Cleanup on plugin unload ----------------------------------------------

plugin.Unloading:Connect(function()
	root:unmount()
	gui:Destroy()
end)
