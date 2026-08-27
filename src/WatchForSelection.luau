local CoreGui = game:GetService("CoreGui")

local React = require(script.Parent.Packages.React)
local ReactRoblox = require(script.Parent.Packages.ReactRoblox)
local PanelStack = require(script.Parent.Components.PanelStack)

local e = React.createElement

--Mount every plugin panel into a single ScreenGui in CoreGui. The PanelStack
--root owns the shared scroller and renders each panel based on the current
--selection. Returns a cleanup function that unmounts React and removes the gui.
local function watchForSelection(plugin: Plugin, pluginName: string)
	local existing = CoreGui:FindFirstChild(pluginName)
	if existing then
		existing:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = pluginName
	screenGui.Parent = CoreGui

	local root = ReactRoblox.createRoot(screenGui)
	root:render(e(PanelStack, { plugin = plugin }))

	return function()
		root:unmount()
		screenGui:Destroy()
	end
end

return watchForSelection
