local React = require(script.Parent.Parent.Packages.React)
local Theme = require(script.Parent.Theme)

local e = React.createElement

export type Props = {
	text: string,
	layoutOrder: number,
	onActivated: () -> (),
	backgroundColor: Color3?,
	disabled: boolean?,
}

--A reusable button that stretches to the panel width.
local function SelectionButton(props: Props)
	return e("TextButton", {
		Size = UDim2.new(1, 0, 0, 25),
		AutomaticSize = Enum.AutomaticSize.Y,
		Text = props.text,
		TextScaled = false,
		TextSize = 8,
		TextWrapped = true,
		LayoutOrder = props.layoutOrder,
		BackgroundColor3 = props.backgroundColor or Theme.BUTTON_COLOR,
		BorderSizePixel = 0,
		TextTransparency = if props.disabled then 0.4 else 0,
		Active = not props.disabled,
		AutoButtonColor = not props.disabled,
		[React.Event.MouseButton1Click] = function()
			if props.disabled then
				return
			end
			props.onActivated()
		end,
	}, {
		UIPadding = e("UIPadding", {
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingTop = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 4),
		}),
	})
end

return SelectionButton
