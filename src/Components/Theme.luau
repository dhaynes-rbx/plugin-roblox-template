--Shared visual tokens for every plugin panel. Centralizing these keeps all
--panels looking like one plugin: same width, dark flat background, light text,
--and Gotham fonts. Change a value here and it applies everywhere.
local Theme = {}

--Every panel is this wide. The scroller in PanelStack sizes itself from this.
Theme.PANEL_WIDTH = 140

--Flat dark shell, no corners / stroke / gradient.
Theme.BACKGROUND_COLOR = Color3.fromRGB(40, 40, 40)

--Foreground text on the dark shell.
Theme.TEXT_COLOR = Color3.fromRGB(230, 230, 230)
Theme.MUTED_TEXT_COLOR = Color3.fromRGB(180, 180, 180)

--Small controls (header toggle, icon buttons) sit slightly lighter than the shell.
Theme.CONTROL_COLOR = Color3.fromRGB(60, 60, 60)

--Light grey surface for buttons that sit on the dark shell.
Theme.BUTTON_COLOR = Color3.fromRGB(163, 162, 165)

--Text rendered on the light BUTTON_COLOR surface.
Theme.BUTTON_TEXT_COLOR = Color3.fromRGB(0, 0, 0)

--Editable input field surface (e.g. numeric fields).
Theme.INPUT_COLOR = Color3.fromRGB(255, 255, 255)

--Interior padding used by the shared Panel shell.
Theme.PADDING = 2

Theme.FONT = Enum.Font.Gotham
Theme.FONT_BOLD = Enum.Font.GothamBold

--Accent colors for action buttons.
Theme.ACCENT = {
	Action = Color3.fromRGB(70, 130, 200),
}

return Theme
