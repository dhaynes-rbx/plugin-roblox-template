local watchForSelection = require(script.Parent.WatchForSelection)

local PLUGIN_NAME = "Template Plugin"

local cleanup = watchForSelection(plugin, PLUGIN_NAME)

plugin.Unloading:Connect(function()
	cleanup()
end)
