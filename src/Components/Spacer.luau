local React = require(script.Parent.Parent.Packages.React)

local e = React.createElement

export type Props = {
	layoutOrder: number,
	size: UDim2?,
}

--A small empty frame used to add vertical space between sections.
local function Spacer(props: Props)
	return e("Frame", {
		BackgroundTransparency = 1,
		Size = props.size or UDim2.fromOffset(100, 8),
		LayoutOrder = props.layoutOrder,
	})
end

return Spacer
