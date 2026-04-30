--!strict

local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type Props = {
	disabled: boolean,
	onActivated: () -> (),
}

local function ActionButton(props: Props)
	return e("TextButton", {
		Name = "ActionButton",
		Size = UDim2.new(1, 0, 0, 28),
		BackgroundColor3 = Color3.fromRGB(86, 180, 233),
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Font = Enum.Font.GothamBold,
		TextSize = 13,
		Text = "Run Action",
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Active = not props.disabled,
		[React.Event.MouseButton1Click] = props.onActivated,
	}, {
		Corner = e("UICorner", { CornerRadius = UDim.new(0, 5) }),
	})
end

return ActionButton
