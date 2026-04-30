--!strict

local React = require(script.Parent.Parent.Packages.React)
local ActionButton = require(script.Parent.ActionButton)
local StatusLabel = require(script.Parent.StatusLabel)

local e = React.createElement
local useState = React.useState
local useCallback = React.useCallback

export type Props = {
	pluginName: string,
}

local function Plugin(props: Props)
	local status, setStatus = useState("Ready")
	local isError, setIsError = useState(false)
	local running, setRunning = useState(false)

	local onAction = useCallback(function()
		setRunning(true)
		setStatus("Running…")
		setIsError(false)

		local ok, err = pcall(function()
			-- TODO: implement plugin action
		end)

		setRunning(false)

		if ok then
			setStatus("Done!")
			setIsError(false)
		else
			setStatus("Error: " .. tostring(err))
			setIsError(true)
			warn("[" .. props.pluginName .. "]", err)
		end
	end, { props.pluginName })

	return e("Frame", {
		Name = "Panel",
		Size = UDim2.fromOffset(220, 80),
		Position = UDim2.fromOffset(12, 12),
		BackgroundColor3 = Color3.fromRGB(36, 36, 36),
		BorderSizePixel = 0,
	}, {
		Corner = e("UICorner", { CornerRadius = UDim.new(0, 8) }),
		Padding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 10),
			PaddingRight = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
			PaddingBottom = UDim.new(0, 10),
		}),
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 6),
		}),
		Action = e(ActionButton, {
			disabled = running,
			onActivated = onAction,
		}),
		Status = e(StatusLabel, {
			text = status,
			isError = isError,
		}),
	})
end

return Plugin
