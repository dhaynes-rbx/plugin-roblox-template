--Single root that nests every plugin panel inside one right-aligned scroller.
--Panels are ordered by LayoutOrder; each panel returns nil when its selection
--isn't relevant, so the stack auto-collapses when nothing is selected.

local React = require(script.Parent.Parent.Packages.React)

local ExamplePanel = require(script.Parent.ExamplePanel)
local Theme = require(script.Parent.Theme)

local e = React.createElement

local SCROLLER_WIDTH = Theme.PANEL_WIDTH + 8

export type Props = {
	plugin: Plugin,
}

local function PanelStack(props: Props)
	return e("ScrollingFrame", {
		Name = "PanelStack",
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, -2, 0, 2),
		Size = UDim2.new(0, SCROLLER_WIDTH, 1, -4),
		CanvasSize = UDim2.new(),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ScrollBarThickness = 6,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, {
		Layout = e("UIListLayout", {
			FillDirection = Enum.FillDirection.Vertical,
			HorizontalAlignment = Enum.HorizontalAlignment.Right,
			VerticalAlignment = Enum.VerticalAlignment.Top,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 4),
		}),
		Padding = e("UIPadding", {
			PaddingRight = UDim.new(0, 8),
		}),

		Example = e(ExamplePanel, { plugin = props.plugin, layoutOrder = 1 }),
	})
end

return PanelStack
