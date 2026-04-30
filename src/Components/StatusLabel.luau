--!strict

local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type Props = {
	text: string,
	isError: boolean,
}

local function StatusLabel(props: Props)
	return e("TextLabel", {
		Name = "Status",
		Size = UDim2.new(1, 0, 0, 16),
		BackgroundTransparency = 1,
		TextColor3 = if props.isError
			then Color3.fromRGB(255, 100, 100)
			else Color3.fromRGB(180, 230, 180),
		Font = Enum.Font.Gotham,
		TextSize = 11,
		Text = props.text,
		TextXAlignment = Enum.TextXAlignment.Left,
		LayoutOrder = 2,
	})
end

return StatusLabel
