--Selection-gated panel: only renders when a Part is selected.
--Demonstrates the Tool module + Panel pattern.

local Selection = game:GetService("Selection")

local React = require(script.Parent.Parent.Packages.React)

local Panel = require(script.Parent.Panel)
local Header = require(script.Parent.Header)
local SelectionButton = require(script.Parent.SelectionButton)
local Theme = require(script.Parent.Theme)
local ExampleTool = require(script.Parent.Parent.ExampleTool)

local e = React.createElement
local useState = React.useState
local useEffect = React.useEffect

export type Props = {
	plugin: Plugin,
	layoutOrder: number,
}

local function ExamplePanel(props: Props)
	local selectedPart, setSelectedPart = useState(nil :: BasePart?)
	local collapsed, setCollapsed = useState(false)
	local status, setStatus = useState("")

	useEffect(function()
		local function onSelectionChanged()
			local sel = Selection:Get()
			local part = nil
			for _, obj in sel do
				if obj:IsA("Part") then
					part = obj
					break
				end
			end
			setSelectedPart(part)
		end

		onSelectionChanged()
		local conn = Selection.SelectionChanged:Connect(onSelectionChanged)
		return function()
			conn:Disconnect()
		end
	end, {})

	if not selectedPart then
		return nil
	end

	return e(Panel, { layoutOrder = props.layoutOrder }, {
		Header = e(Header, {
			title = "Example",
			collapsed = collapsed,
			onToggle = function()
				setCollapsed(not collapsed)
			end,
			layoutOrder = 1,
		}),

		Content = if collapsed
			then nil
			else e("Frame", {
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				LayoutOrder = 2,
			}, {
				Layout = e("UIListLayout", {
					Padding = UDim.new(0, 2),
					SortOrder = Enum.SortOrder.LayoutOrder,
				}),
				Action = e(SelectionButton, {
					text = "Announce Part",
					layoutOrder = 1,
					backgroundColor = Theme.ACCENT.Action,
					onActivated = function()
						if selectedPart then
							ExampleTool.announce(selectedPart)
							setStatus("Announced: " .. selectedPart.Name)
						end
					end,
				}),
				Status = e("TextLabel", {
					Size = UDim2.new(1, 0, 0, 14),
					BackgroundTransparency = 1,
					Text = status,
					TextColor3 = Theme.MUTED_TEXT_COLOR,
					Font = Theme.FONT,
					TextSize = 10,
					TextXAlignment = Enum.TextXAlignment.Left,
					LayoutOrder = 2,
				}),
			}),
	})
end

return ExamplePanel
