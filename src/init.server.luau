--!strict

-- Plugin entry point.
-- Creates a ScreenGui overlay in CoreGui with a panel and placeholder action button.

local CoreGui = game:GetService("CoreGui")

-- CUSTOMIZE: Set your plugin's display name here.
local PLUGIN_NAME = "Template Plugin"

-- Toolbar ---------------------------------------------------------------

local toolbar = plugin:CreateToolbar(PLUGIN_NAME)
local toggleButton = toolbar:CreateButton(
	PLUGIN_NAME,
	"Toggle the plugin panel",
	"rbxassetid://14978120386" -- CUSTOMIZE: Replace with your own toolbar icon asset ID
)
toggleButton.ClickableWhenViewportHidden = true

-- UI --------------------------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = PLUGIN_NAME .. "Gui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Enabled = false
gui.Parent = CoreGui

toggleButton:SetActive(gui.Enabled)

toggleButton.Click:Connect(function()
	gui.Enabled = not gui.Enabled
	toggleButton:SetActive(gui.Enabled)
end)

local frame = Instance.new("Frame")
frame.Name = "Panel"
frame.Size = UDim2.fromOffset(220, 80)
frame.Position = UDim2.fromOffset(12, 12)
frame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local padding = Instance.new("UIPadding")
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.PaddingTop = UDim.new(0, 10)
padding.PaddingBottom = UDim.new(0, 10)
padding.Parent = frame

local layout = Instance.new("UIListLayout")
layout.FillDirection = Enum.FillDirection.Vertical
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 6)
layout.Parent = frame

local actionButton = Instance.new("TextButton")
actionButton.Name = "ActionButton"
actionButton.Size = UDim2.new(1, 0, 0, 28)
actionButton.BackgroundColor3 = Color3.fromRGB(86, 180, 233)
actionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
actionButton.Font = Enum.Font.GothamBold
actionButton.TextSize = 13
actionButton.Text = "Run Action"
actionButton.BorderSizePixel = 0
actionButton.LayoutOrder = 1
actionButton.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 5)
btnCorner.Parent = actionButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, 0, 0, 16)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.Text = "Ready"
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.LayoutOrder = 2
statusLabel.Parent = frame

-- Helpers ---------------------------------------------------------------

local function setStatus(msg: string, isError: boolean?)
	statusLabel.Text = msg
	statusLabel.TextColor3 = if isError
		then Color3.fromRGB(255, 100, 100)
		else Color3.fromRGB(180, 230, 180)
end

-- Button handlers -------------------------------------------------------

actionButton.MouseButton1Click:Connect(function()
	actionButton.Active = false
	setStatus("Running…")

	local ok, err = pcall(function()
		-- TODO: implement plugin action
	end)

	actionButton.Active = true

	if ok then
		setStatus("Done!", false)
	else
		setStatus("Error: " .. tostring(err), true)
		warn("[" .. PLUGIN_NAME .. "]", err)
	end
end)

-- Cleanup on plugin unload ----------------------------------------------

plugin.Unloading:Connect(function()
	gui:Destroy()
end)
