--Example tool module. Put side-effect logic here (no UI).
--The companion ExamplePanel calls these functions when buttons are pressed.

local ExampleTool = {}

function ExampleTool.announce(part: BasePart)
	print(("[Template Plugin] Selected part: %s (Size: %s)"):format(part.Name, tostring(part.Size)))
end

return ExampleTool
