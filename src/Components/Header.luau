local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type Props = {
	title: string,
	collapsed: boolean,
	onToggle: () -> (),
	layoutOrder: number?,
}

--A panel header with a title and a small arrow button that toggles the panel
--between collapsed and expanded.
local function Header(props: Props)
	return e("Frame", {
		Size = UDim2.new(1, 0, 0, 20),
		BackgroundTransparency = 1,
		LayoutOrder = props.layoutOrder,
	}, {
		Title = e("TextLabel", {
			Size = UDim2.new(1, -22, 1, 0),
			Position = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 1,
			Text = props.title,
			TextColor3 = Color3.fromRGB(230, 230, 230),
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
		}),
		Toggle = e("TextButton", {
			Size = UDim2.new(0, 20, 0, 20),
			Position = UDim2.new(1, 0, 0, 0),
			AnchorPoint = Vector2.new(1, 0),
			Text = if props.collapsed then "\u{25B6}" else "\u{25BC}",
			TextColor3 = Color3.fromRGB(230, 230, 230),
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			BackgroundColor3 = Color3.fromRGB(60, 60, 60),
			[React.Event.MouseButton1Click] = props.onToggle,
		}),
	})
end

return Header
