local React = require(script.Parent.Parent.Packages.React)
local Theme = require(script.Parent.Theme)

local e = React.createElement

local function merge(a: { [string]: any }?, b: { [string]: any }?): { [string]: any }
	local result = {}
	if a then
		for key, value in a do
			result[key] = value
		end
	end
	if b then
		for key, value in b do
			result[key] = value
		end
	end
	return result
end

export type Props = {
	children: { [string]: any }?,
	layoutOrder: number?,
}

--The shared flat panel shell: dark background, top-aligned vertical list, and
--uniform interior padding. Pass panel contents as the second argument.
local function Panel(props: Props)
	local ephemerals = {
		Layout = e("UIListLayout", {
			Padding = UDim.new(0, 1),
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		Padding = e("UIPadding", {
			PaddingTop = UDim.new(0, Theme.PADDING),
			PaddingBottom = UDim.new(0, Theme.PADDING),
			PaddingLeft = UDim.new(0, Theme.PADDING),
			PaddingRight = UDim.new(0, Theme.PADDING),
		}),
	}

	return e("Frame", {
		Name = "Panel",
		Size = UDim2.new(0, Theme.PANEL_WIDTH, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		LayoutOrder = props.layoutOrder,
		BackgroundColor3 = Theme.BACKGROUND_COLOR,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
	}, merge(props.children, ephemerals))
end

return function(props: Props, children: { [string]: any }?)
	if children then
		props.children = children
	end
	return e(Panel, props)
end
