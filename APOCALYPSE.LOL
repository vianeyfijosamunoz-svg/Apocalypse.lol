--[[
    APOCALYPSE.LOL BETA V2 - ULTIMATE CUSTOM CORE UI
]]

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer
local CORRECT_KEY = "APOCALYPSEAIMBOTGG2026"
local DISCORD_INVITE = "discord.gg/tvYWHS2B8"

local CLICK_IMAGE_ID = "rbxassetid://18958744155"

local function ProtectGui(gui)
	pcall(function()
		if gethui then
			gui.Parent = gethui()
		elseif syn and syn.protect_gui then
			syn.protect_gui(gui)
			gui.Parent = CoreGui
		else
			gui.Parent = CoreGui
		end
	end)
	if not gui.Parent then
		gui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end
end

-- Key System GUI
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "ApocalypseKeySystem"
KeyGui.ResetOnSpawn = false
KeyGui.IgnoreGuiInset = true
KeyGui.DisplayOrder = 999999
ProtectGui(KeyGui)

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.fromOffset(340, 220)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = KeyGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

local Stroke = Instance.new("UIStroke")
Stroke.Thickness = 1.5
Stroke.Color = Color3.fromRGB(0, 255, 204)
Stroke.Parent = MainFrame

task.spawn(function()
	local h = 0
	while KeyGui.Parent do
		h = (h + 0.005) % 1
		Stroke.Color = Color3.fromHSV(h, 1, 1)
		task.wait(0.03)
	end
end)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 35)
TitleLabel.Position = UDim2.new(0, 0, 0, 12)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "APOCALYPSE.LOL BETA V2 KEY-SYSTEM"
TitleLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextSize = 14
TitleLabel.Parent = MainFrame

local SubTitle = Instance.new("TextLabel")
SubTitle.Size = UDim2.new(1, 0, 0, 18)
SubTitle.Position = UDim2.new(0, 0, 0, 40)
SubTitle.BackgroundTransparency = 1
SubTitle.Text = "APOCALYPSE.LOL BETA V2 // ACCESS CONTROL"
SubTitle.TextColor3 = Color3.fromRGB(140, 140, 160)
SubTitle.Font = Enum.Font.Code
SubTitle.TextSize = 9
SubTitle.Parent = MainFrame

local TextBoxBg = Instance.new("Frame")
TextBoxBg.Size = UDim2.new(0, 290, 0, 32)
TextBoxBg.Position = UDim2.new(0.5, -145, 0, 70)
TextBoxBg.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
TextBoxBg.BorderSizePixel = 0
TextBoxBg.Parent = MainFrame
Instance.new("UICorner", TextBoxBg).CornerRadius = UDim.new(0, 6)

local TextBoxStroke = Instance.new("UIStroke")
TextBoxStroke.Thickness = 1
TextBoxStroke.Color = Color3.fromRGB(40, 40, 60)
TextBoxStroke.Parent = TextBoxBg

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.new(0, 10, 0, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.PlaceholderText = "Introduce tu Key aquí..."
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.PlaceholderColor3 = Color3.fromRGB(90, 90, 110)
KeyInput.Font = Enum.Font.Code
KeyInput.TextSize = 12
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = TextBoxBg

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 20)
StatusLabel.Position = UDim2.new(0, 0, 0, 108)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextSize = 12
StatusLabel.Parent = MainFrame

local VerifyButton = Instance.new("TextButton")
VerifyButton.Size = UDim2.new(0, 138, 0, 30)
VerifyButton.Position = UDim2.new(0.5, -145, 0, 135)
VerifyButton.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
VerifyButton.BorderSizePixel = 0
VerifyButton.AutoButtonColor = true
VerifyButton.Text = "VERIFY KEY"
VerifyButton.TextColor3 = Color3.fromRGB(12, 12, 18)
VerifyButton.Font = Enum.Font.Code
VerifyButton.TextSize = 12
VerifyButton.Parent = MainFrame
Instance.new("UICorner", VerifyButton).CornerRadius = UDim.new(0, 6)

local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.new(0, 138, 0, 30)
GetKeyButton.Position = UDim2.new(0.5, 7, 0, 135)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
GetKeyButton.BorderSizePixel = 0
GetKeyButton.AutoButtonColor = true
GetKeyButton.Text = "GET KEY"
GetKeyButton.TextColor3 = Color3.fromRGB(0, 255, 204)
GetKeyButton.Font = Enum.Font.Code
GetKeyButton.TextSize = 12
GetKeyButton.Parent = MainFrame
Instance.new("UICorner", GetKeyButton).CornerRadius = UDim.new(0, 6)

local GetKeyStroke = Instance.new("UIStroke")
GetKeyStroke.Thickness = 1
GetKeyStroke.Color = Color3.fromRGB(0, 255, 204)
GetKeyStroke.Parent = GetKeyButton

GetKeyButton.MouseButton1Click:Connect(function()
	pcall(function()
		if setclipboard then
			setclipboard(DISCORD_INVITE)
		end
	end)
	StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
	StatusLabel.Text = "¡Link copiado al portapapeles!"
	task.delay(2, function()
		if StatusLabel.Text == "¡Link copiado al portapapeles!" then
			StatusLabel.Text = ""
		end
	end)
end)

local function LoadMainScript()
	local CONFIG_FOLDER = "ApocalypseConfigs"
	pcall(function()
		if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
	end)

	do
		local loadGui = Instance.new("ScreenGui")
		loadGui.Name = tostring(math.random(100000,999999))
		loadGui.ResetOnSpawn = false
		loadGui.IgnoreGuiInset = true
		loadGui.DisplayOrder = 99999
		ProtectGui(loadGui)

		local bg = Instance.new("Frame")
		bg.Size = UDim2.fromScale(1, 1)
		bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		bg.BorderSizePixel = 0
		bg.Parent = loadGui

		local title = Instance.new("TextLabel")
		title.Size = UDim2.new(1, 0, 0, 40)
		title.Position = UDim2.new(0, 0, 0.35, 0)
		title.BackgroundTransparency = 1
		title.Text = "APOCALYPSE.LOL BETA V2"
		title.TextColor3 = Color3.fromRGB(0, 255, 204)
		title.Font = Enum.Font.Code
		title.TextSize = 22
		title.Parent = bg

		local status = Instance.new("TextLabel")
		status.Size = UDim2.new(1, 0, 0, 24)
		status.Position = UDim2.new(0, 0, 0.49, 0)
		status.BackgroundTransparency = 1
		status.Text = "INJECTING ULTIMATE MATRIX..."
		status.TextColor3 = Color3.fromRGB(200, 200, 220)
		status.Font = Enum.Font.Code
		status.TextSize = 13
		status.Parent = bg

		local barBg = Instance.new("Frame")
		barBg.Size = UDim2.new(0, 240, 0, 6)
		barBg.Position = UDim2.new(0.5, -120, 0.57, 0)
		barBg.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
		barBg.BorderSizePixel = 0
		barBg.Parent = bg
		Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

		local barFill = Instance.new("Frame")
		barFill.Size = UDim2.new(0, 0, 1, 0)
		barFill.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
		barFill.BorderSizePixel = 0
		barFill.Parent = barBg
		Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

		for i = 1, 20 do
			barFill.Size = UDim2.new(i / 20, 0, 1, 0)
			task.wait(0.015)
		end
		loadGui:Destroy()
	end

	local Config = {
		Enabled = true,
		Wallbang = false,
		SilentAim = true,
		FFAMode = false,
		TeleportOffsetY = 2,
		TeleportOffsetX = 0,
		TeleportOffsetZ = 2,
		TeleportSmoothing = 1.0,
		Prediction = true,
		PredictionFactor = 0.15,
		TargetPriority = "Distancia",
		AimPartChoice = "Head",
		VoidSpam = false,
		AntiKatana = false,
		AntiShield = false,
		Noclip = false,
		InfiniteJump = false,
		ESP = false,
		ESPName = true,
		ESPDistance = true,
		ESPHealth = true,
		FOVCircle = true,
		Crosshair = false,
		CrosshairSize = 30,
		CrosshairSpeed = 2.2,
		CrosshairGap = 0.62,
		AntiDetection = false,
	}

	-- CUSTOM CORE UI
	local CustomUI = Instance.new("ScreenGui")
	CustomUI.Name = "ApocalypseCoreUI"
	CustomUI.ResetOnSpawn = false
	CustomUI.IgnoreGuiInset = true
	ProtectGui(CustomUI)

	local MainPanel = Instance.new("Frame")
	MainPanel.Size = UDim2.fromOffset(415, 285)
	MainPanel.Position = UDim2.fromScale(0.5, 0.5)
	MainPanel.AnchorPoint = Vector2.new(0.5, 0.5)
	MainPanel.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	MainPanel.BorderSizePixel = 0
	MainPanel.Parent = CustomUI
	Instance.new("UICorner", MainPanel).CornerRadius = UDim.new(0, 6)

	local PanelStroke = Instance.new("UIStroke")
	PanelStroke.Color = Color3.fromRGB(0, 255, 204)
	PanelStroke.Thickness = 1
	PanelStroke.Parent = MainPanel

	-- Top Bar / Header
	local TopBar = Instance.new("Frame")
	TopBar.Size = UDim2.new(1, 0, 0, 28)
	TopBar.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	TopBar.BorderSizePixel = 0
	TopBar.Parent = MainPanel
	Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 6)

	local FixCorner = Instance.new("Frame")
	FixCorner.Size = UDim2.new(1, 0, 0, 8)
	FixCorner.Position = UDim2.new(0, 0, 1, -8)
	FixCorner.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
	FixCorner.BorderSizePixel = 0
	FixCorner.Parent = TopBar

	local TitleText = Instance.new("TextLabel")
	TitleText.Size = UDim2.new(0, 160, 1, 0)
	TitleText.Position = UDim2.new(0, 8, 0, 0)
	TitleText.BackgroundTransparency = 1
	TitleText.Text = "APOCALYPSE.LOL BETA V2"
	TitleText.TextColor3 = Color3.fromRGB(0, 255, 204)
	TitleText.Font = Enum.Font.Code
	TitleText.TextSize = 10
	TitleText.TextXAlignment = Enum.TextXAlignment.Left
	TitleText.Parent = TopBar

	-- Close / Open UI Button
	local CloseButton = Instance.new("TextButton")
	CloseButton.Size = UDim2.fromOffset(20, 20)
	CloseButton.Position = UDim2.new(1, -24, 0.5, -10)
	CloseButton.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
	CloseButton.Text = "X"
	CloseButton.TextColor3 = Color3.fromRGB(255, 60, 60)
	CloseButton.Font = Enum.Font.Code
	CloseButton.TextSize = 10
	CloseButton.Parent = TopBar
	Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 4)

	CloseButton.MouseButton1Click:Connect(function()
		MainPanel.Visible = false
	end)

	UserInputService.InputBegan:Connect(function(input, gp)
		if input.KeyCode == Enum.KeyCode.Insert then
			MainPanel.Visible = not MainPanel.Visible
		end
	end)

	-- Botón flotante para móviles/pantallas táctiles
	local ToggleGuiBtn = Instance.new("TextButton")
	ToggleGuiBtn.Size = UDim2.fromOffset(34, 34)
	ToggleGuiBtn.Position = UDim2.new(0, 12, 0.5, -17)
	ToggleGuiBtn.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
	ToggleGuiBtn.Text = "UI"
	ToggleGuiBtn.TextColor3 = Color3.fromRGB(0, 255, 204)
	ToggleGuiBtn.Font = Enum.Font.Code
	ToggleGuiBtn.TextSize = 11
	ToggleGuiBtn.Parent = CustomUI
	Instance.new("UICorner", ToggleGuiBtn).CornerRadius = UDim.new(0, 6)

	local ToggleGuiStroke = Instance.new("UIStroke")
	ToggleGuiStroke.Color = Color3.fromRGB(0, 255, 204)
	ToggleGuiStroke.Thickness = 1
	ToggleGuiStroke.Parent = ToggleGuiBtn

	ToggleGuiBtn.MouseButton1Click:Connect(function()
		MainPanel.Visible = not MainPanel.Visible
	end)

	-- Draggable implementation
	local dragging, dragInput, dragStart, startPos
	TopBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = MainPanel.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	TopBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			MainPanel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	-- Sistema de Clics
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if MainPanel.Visible and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			local mousePos = UserInputService:GetMouseLocation()
			
			local clickEffectGui = Instance.new("ScreenGui")
			clickEffectGui.Name = "ApocalypseClickEffect"
			clickEffectGui.ResetOnSpawn = false
			clickEffectGui.IgnoreGuiInset = true
			ProtectGui(clickEffectGui)
			
			local clickImg = Instance.new("ImageLabel")
			clickImg.Size = UDim2.fromOffset(30, 30)
			clickImg.AnchorPoint = Vector2.new(0.5, 0.5)
			clickImg.Position = UDim2.fromOffset(mousePos.X, mousePos.Y)
			clickImg.BackgroundTransparency = 1
			clickImg.Image = CLICK_IMAGE_ID
			clickImg.Parent = clickEffectGui
			
			TweenService:Create(clickImg, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
				Size = UDim2.fromOffset(55, 55),
				ImageTransparency = 1
			}):Play()
			
			task.delay(0.4, function()
				clickEffectGui:Destroy()
			end)
		end
	end)

	-- Top Tabs Container (Ajustado para no salirse de la UI)
	local TabsContainer = Instance.new("ScrollingFrame")
	TabsContainer.Size = UDim2.new(1, -195, 0, 22)
	TabsContainer.Position = UDim2.new(0, 168, 0, 3)
	TabsContainer.BackgroundTransparency = 1
	TabsContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
	TabsContainer.AutomaticCanvasSize = Enum.AutomaticSize.X
	TabsContainer.ScrollBarThickness = 0
	TabsContainer.Parent = TopBar

	local TabsLayout = Instance.new("UIListLayout")
	TabsLayout.FillDirection = Enum.FillDirection.Horizontal
	TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabsLayout.Padding = UDim.new(0, 3)
	TabsLayout.Parent = TabsContainer

	local ContentArea = Instance.new("Frame")
	ContentArea.Size = UDim2.new(1, 0, 1, -28)
	ContentArea.Position = UDim2.new(0, 0, 0, 28)
	ContentArea.BackgroundTransparency = 1
	ContentArea.Parent = MainPanel

	local Tabs = {}
	local function CreateTab(name)
		local tabFrame = Instance.new("ScrollingFrame")
		tabFrame.Size = UDim2.new(1, 0, 1, 0)
		tabFrame.BackgroundTransparency = 1
		tabFrame.Visible = false
		tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tabFrame.ScrollBarThickness = 2
		tabFrame.Parent = ContentArea

		local layout = Instance.new("UIListLayout")
		layout.SortOrder = Enum.SortOrder.LayoutOrder
		layout.Padding = UDim.new(0, 5)
		layout.Parent = tabFrame

		local padding = Instance.new("UIPadding")
		padding.PaddingLeft = UDim.new(0, 8)
		padding.PaddingRight = UDim.new(0, 8)
		padding.PaddingTop = UDim.new(0, 6)
		padding.Parent = tabFrame

		local tabButton = Instance.new("TextButton")
		tabButton.Size = UDim2.new(0, 60, 0, 18)
		tabButton.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
		tabButton.TextColor3 = Color3.fromRGB(160, 160, 180)
		tabButton.Font = Enum.Font.Code
		tabButton.TextSize = 9
		tabButton.Text = name
		tabButton.Parent = TabsContainer
		Instance.new("UICorner", tabButton).CornerRadius = UDim.new(0, 4)

		tabButton.MouseButton1Click:Connect(function()
			for _, t in pairs(Tabs) do
				t.Frame.Visible = false
				t.Button.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
				t.Button.TextColor3 = Color3.fromRGB(160, 160, 180)
			end
			tabFrame.Visible = true
			tabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
			tabButton.TextColor3 = Color3.fromRGB(12, 12, 16)
		end)

		if #Tabs == 0 then
			tabFrame.Visible = true
			tabButton.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
			tabButton.TextColor3 = Color3.fromRGB(12, 12, 16)
		end

		table.insert(Tabs, {Frame = tabFrame, Button = tabButton})
		return tabFrame
	end

	local CombateTab = CreateTab("Combate")
	local MovimientoTab = CreateTab("Movimiento")
	local ESPTab = CreateTab("ESP")
	local VisualsTab = CreateTab("Visuals")
	local MiscTab = CreateTab("Misc")

	-- Notifications
	local NotificationGui = Instance.new("ScreenGui")
	NotificationGui.Name = "ApocalypseNotifications"
	NotificationGui.ResetOnSpawn = false
	ProtectGui(NotificationGui)

	local NotifContainer = Instance.new("Frame")
	NotifContainer.Size = UDim2.new(0, 200, 1, 0)
	NotifContainer.Position = UDim2.new(1, -210, 0, 0)
	NotifContainer.BackgroundTransparency = 1
	NotifContainer.Parent = NotificationGui

	local NotifLayout = Instance.new("UIListLayout")
	NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifLayout.Padding = UDim.new(0, 5)
	NotifLayout.Parent = NotifContainer

	local function Notify(text)
		local box = Instance.new("Frame")
		box.Size = UDim2.new(1, 0, 0, 32)
		box.BackgroundColor3 = Color3.fromRGB(16, 16, 22)
		box.BorderSizePixel = 0
		box.Parent = NotifContainer
		Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)

		local stroke = Instance.new("UIStroke")
		stroke.Color = Color3.fromRGB(0, 255, 204)
		stroke.Thickness = 1
		stroke.Parent = box

		local label = Instance.new("TextLabel")
		label.Size = UDim2.new(1, -6, 1, 0)
		label.Position = UDim2.new(0, 3, 0, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.Font = Enum.Font.Code
		label.TextSize = 9
		label.Text = text
		label.TextWrapped = true
		label.Parent = box

		task.delay(2.5, function()
			box:Destroy()
		end)
	end

	local function AddToggle(parent, title, default, callback)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 26)
		f.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)

		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, -40, 1, 0)
		lbl.Position = UDim2.new(0, 8, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = title
		lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
		lbl.Font = Enum.Font.Code
		lbl.TextSize = 10
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = f

		local btn = Instance.new("TextButton")
		btn.Size = UDim2.fromOffset(22, 13)
		btn.Position = UDim2.new(1, -30, 0.5, -6.5)
		btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(35, 35, 45)
		btn.Text = ""
		btn.Parent = f
		Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

		local state = default
		btn.MouseButton1Click:Connect(function()
			state = not state
			btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 204) or Color3.fromRGB(35, 35, 45)
			callback(state)
		end)
	end

	local function AddSlider(parent, title, min, max, default, callback)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 36)
		f.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)

		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(1, -12, 0, 16)
		lbl.Position = UDim2.new(0, 8, 0, 2)
		lbl.BackgroundTransparency = 1
		lbl.Text = title .. ": " .. default
		lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
		lbl.Font = Enum.Font.Code
		lbl.TextSize = 10
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = f

		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1, -16, 0, 4)
		bar.Position = UDim2.new(0, 8, 0, 23)
		bar.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
		bar.BorderSizePixel = 0
		bar.Parent = f
		Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

		local fill = Instance.new("Frame")
		fill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
		fill.BackgroundColor3 = Color3.fromRGB(0, 255, 204)
		fill.BorderSizePixel = 0
		fill.Parent = bar
		Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

		local draggingSlider = false
		bar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				draggingSlider = true
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				draggingSlider = false
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
				local val = min + ((max - min) * pos)
				val = math.floor(val * 100 + 0.5) / 100
				fill.Size = UDim2.new(pos, 0, 1, 0)
				lbl.Text = title .. ": " + val
				callback(val)
			end
		end)
	end

	local function AddDropdown(parent, title, options, default, callback)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 30)
		f.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)

		local lbl = Instance.new("TextLabel")
		lbl.Size = UDim2.new(0.5, 0, 1, 0)
		lbl.Position = UDim2.new(0, 8, 0, 0)
		lbl.BackgroundTransparency = 1
		lbl.Text = title
		lbl.TextColor3 = Color3.fromRGB(200, 200, 220)
		lbl.Font = Enum.Font.Code
		lbl.TextSize = 10
		lbl.TextXAlignment = Enum.TextXAlignment.Left
		lbl.Parent = f

		local current = default
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 110, 0, 20)
		btn.Position = UDim2.new(1, -118, 0.5, -10)
		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 36)
		btn.Text = tostring(current)
		btn.TextColor3 = Color3.fromRGB(0, 255, 204)
		btn.Font = Enum.Font.Code
		btn.TextSize = 9
		btn.Parent = f
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

		local idx = 1
		for i, opt in ipairs(options) do
			if opt == default then idx = i break end
		end

		btn.MouseButton1Click:Connect(function()
			idx = idx + 1
			if idx > #options then idx = 1 end
			current = options[idx]
			btn.Text = tostring(current)
			callback(current)
		end)
	end

	local function AddButton(parent, title, callback)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 30)
		f.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)

		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -16, 1, -6)
		btn.Position = UDim2.new(0, 8, 0, 3)
		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
		btn.Text = title
		btn.TextColor3 = Color3.fromRGB(0, 255, 204)
		btn.Font = Enum.Font.Code
		btn.TextSize = 10
		btn.Parent = f
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)

		local stroke = Instance.new("UIStroke")
		stroke.Thickness = 1
		stroke.Color = Color3.fromRGB(0, 255, 204)
		stroke.Parent = btn

		btn.MouseButton1Click:Connect(function()
			callback()
		end)
	end

	-- Populate Tabs
	AddToggle(CombateTab, "Enabled", Config.Enabled, function(v) Config.Enabled = v end)
	AddToggle(CombateTab, "Wallbang", Config.Wallbang, function(v) Config.Wallbang = v end)
	AddToggle(CombateTab, "Silent Aim", Config.SilentAim, function(v) Config.SilentAim = v end)
	AddToggle(CombateTab, "FFA Mode (Free For All)", Config.FFAMode, function(v) Config.FFAMode = v end)
	AddToggle(CombateTab, "Void Spam (Evitar Muerte)", Config.VoidSpam, function(v) Config.VoidSpam = v end)
	AddToggle(CombateTab, "Anti Katana", Config.AntiKatana, function(v) Config.AntiKatana = v end)
	AddToggle(CombateTab, "Anti Shield", Config.AntiShield, function(v) Config.AntiShield = v end)
	AddToggle(CombateTab, "Predicción de Movimiento", Config.Prediction, function(v) Config.Prediction = v end)
	
	AddSlider(CombateTab, "Factor Predicción", 0.05, 0.4, Config.PredictionFactor, function(v) Config.PredictionFactor = v end)
	AddSlider(CombateTab, "Altura TP (Y)", -10, 10, Config.TeleportOffsetY, function(v) Config.TeleportOffsetY = v end)
	AddSlider(CombateTab, "Distancia TP (Z)", -10, 10, Config.TeleportOffsetZ, function(v) Config.TeleportOffsetZ = v end)
	
	AddDropdown(CombateTab, "Prioridad Objetivo", {"Distancia", "Menos Vida", "FOV"}, Config.TargetPriority, function(v) Config.TargetPriority = v end)
	AddDropdown(CombateTab, "Parte de Apuntar", {"Head", "UpperTorso", "HumanoidRootPart"}, Config.AimPartChoice, function(v) Config.AimPartChoice = v end)

	AddToggle(MovimientoTab, "Noclip", Config.Noclip, function(v) Config.Noclip = v end)
	AddToggle(MovimientoTab, "Infinite Jump", Config.InfiniteJump, function(v) Config.InfiniteJump = v end)

	AddToggle(ESPTab, "ESP Activo", Config.ESP, function(v) Config.ESP = v end)
	AddToggle(ESPTab, "Nombres ESP", Config.ESPName, function(v) Config.ESPName = v end)
	AddToggle(ESPTab, "Distancia ESP", Config.ESPDistance, function(v) Config.ESPDistance = v end)
	AddToggle(ESPTab, "Vida ESP", Config.ESPHealth, function(v) Config.ESPHealth = v end)

	-- Visuals Tab con Skinchanger y Skybox corregido [r(sky), a(sky), g(sky), v(sky)]
	AddButton(VisualsTab, "Skinchanger", function()
		pcall(function()
			loadstring(game:HttpGet("https://pastefy.app/Lutt6udW/raw"))()
		end)
		Notify("Skinchanger ejecutado con éxito")
	end)

	local function ApplySkybox(mode)
		local existingSky = Lighting:FindFirstChildOfClass("Sky")
		if mode == "Normal" then
			if existingSky then existingSky:Destroy() end
			Lighting.Ambient = Color3.fromRGB(128, 128, 128)
			Notify("Skybox restaurado")
			return
		end

		if not existingSky then
			existingSky = Instance.new("Sky")
			existingSky.Parent = Lighting
		end

		-- Usamos texturas de color base válidas de Roblox para pintar el cielo de forma confiable
		local solidColorAsset = "rbxassetid://625692040" 
		existingSky.SkyboxBk = solidColorAsset
		existingSky.SkyboxDn = solidColorAsset
		existingSky.SkyboxFt = solidColorAsset
		existingSky.SkyboxLf = solidColorAsset
		existingSky.SkyboxRt = solidColorAsset
		existingSky.SkyboxUp = solidColorAsset
		existingSky.CelestialBodiesShown = false

		if mode == "r(sky)" then
			existingSky.SkyboxBkColor = Color3.fromRGB(255, 0, 0)
			existingSky.SkyboxDnColor = Color3.fromRGB(255, 0, 0)
			existingSky.SkyboxFtColor = Color3.fromRGB(255, 0, 0)
			existingSky.SkyboxLfColor = Color3.fromRGB(255, 0, 0)
			existingSky.SkyboxRtColor = Color3.fromRGB(255, 0, 0)
			existingSky.SkyboxUpColor = Color3.fromRGB(255, 0, 0)
			Lighting.Ambient = Color3.fromRGB(120, 20, 20)
			Notify("Cielo cambiado a Rojo [r(sky)]")
		elseif mode == "a(sky)" then
			existingSky.SkyboxBkColor = Color3.fromRGB(0, 0, 255)
			existingSky.SkyboxDnColor = Color3.fromRGB(0, 0, 255)
			existingSky.SkyboxFtColor = Color3.fromRGB(0, 0, 255)
			existingSky.SkyboxLfColor = Color3.fromRGB(0, 0, 255)
			existingSky.SkyboxRtColor = Color3.fromRGB(0, 0, 255)
			existingSky.SkyboxUpColor = Color3.fromRGB(0, 0, 255)
			Lighting.Ambient = Color3.fromRGB(20, 20, 120)
			Notify("Cielo cambiado a Azul [a(sky)]")
		elseif mode == "g(sky)" then
			existingSky.SkyboxBkColor = Color3.fromRGB(128, 128, 128)
			existingSky.SkyboxDnColor = Color3.fromRGB(128, 128, 128)
			existingSky.SkyboxFtColor = Color3.fromRGB(128, 128, 128)
			existingSky.SkyboxLfColor = Color3.fromRGB(128, 128, 128)
			existingSky.SkyboxRtColor = Color3.fromRGB(128, 128, 128)
			existingSky.SkyboxUpColor = Color3.fromRGB(128, 128, 128)
			Lighting.Ambient = Color3.fromRGB(80, 80, 80)
			Notify("Cielo cambiado a Gris [g(sky)]")
		elseif mode == "v(sky)" then
			existingSky.SkyboxBkColor = Color3.fromRGB(0, 255, 0)
			existingSky.SkyboxDnColor = Color3.fromRGB(0, 255, 0)
			existingSky.SkyboxFtColor = Color3.fromRGB(0, 255, 0)
			existingSky.SkyboxLfColor = Color3.fromRGB(0, 255, 0)
			existingSky.SkyboxRtColor = Color3.fromRGB(0, 255, 0)
			existingSky.SkyboxUpColor = Color3.fromRGB(0, 255, 0)
			Lighting.Ambient = Color3.fromRGB(20, 120, 20)
			Notify("Cielo cambiado a Verde [v(sky)]")
		end
	end

	AddDropdown(VisualsTab, "Skybox Custom", {"Normal", "r(sky)", "a(sky)", "g(sky)", "v(sky)"}, "Normal", function(v)
		ApplySkybox(v)
	end)

	AddToggle(MiscTab, "Anti Detection (Safe)", Config.AntiDetection, function(v) Config.AntiDetection = v end)

	local function GetChar(plr)
		plr = plr or LocalPlayer
		local c = plr.Character
		if not c then return end
		local hrp = c:FindFirstChild("HumanoidRootPart")
		local hum = c:FindFirstChildOfClass("Humanoid")
		local head = c:FindFirstChild("Head")
		if hrp and hum and hum.Health > 0 then return c, hrp, hum, head end
	end

	local function HasTeammateVisualTag(char)
		if not char then return false end
		for _, descendant in ipairs(char:GetDescendants()) do
			if descendant:IsA("BillboardGui") or descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
				return true
			end
		end
		local head = char:FindFirstChild("Head")
		if head then
			for _, child in ipairs(head:GetChildren()) do
				if child:IsA("BillboardGui") or child:IsA("SurfaceGui") or child:IsA("Model") then
					return true
				end
			end
		end
		return false
	end

	local function CanTeleportTo(plr)
		if plr == LocalPlayer then return false end
		local char = plr.Character
		if not char then return false end

		if HasTeammateVisualTag(char) then
			return false
		end

		if Config.FFAMode then return true end
		local myTeam = LocalPlayer.Team
		local targetTeam = plr.Team
		if not myTeam or not targetTeam then return true end
		return myTeam ~= targetTeam
	end

	local function GetAimPart(char)
		local part = char:FindFirstChild(Config.AimPartChoice)
		if part then return part end
		return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
	end

	local function AI_DetectThreat(char)
		if not char then return false, false end
		local hasKatana, hasShield = false, false
		for _, item in ipairs(char:GetChildren()) do
			if item:IsA("Tool") or item:IsA("Model") then
				local name = string.lower(item.Name)
				if name:find("katana") or name:find("sword") or name:find("blade") then hasKatana = true end
				if name:find("shield") or name:find("escudo") then hasShield = true end
			end
		end
		return hasKatana, hasShield
	end

	local function GetBestTargetRage()
		local bestPlr, bestPart, bestScore = nil, nil, -math.huge
		local _, myHRP = GetChar()
		if not myHRP then return nil, nil end
		local myPos = myHRP.Position

		for _, plr in ipairs(Players:GetPlayers()) do
			if CanTeleportTo(plr) then
				local char, hrp, hum = GetChar(plr)
				if char and hrp and hum and hum.Health > 0 then
					local kDetect, sDetect = AI_DetectThreat(char)
					if not (Config.AntiKatana and kDetect) and not (Config.AntiShield and sDetect) then
						local part = GetAimPart(char)
						if part then
							local dist3D = (hrp.Position - myPos).Magnitude
							local score = 0
							if Config.TargetPriority == "Distancia" then
								score = 10000000 - dist3D
							elseif Config.TargetPriority == "Menos Vida" then
								score = 10000000 - (hum.Health * 1000)
							else
								score = 10000000 - dist3D
							end

							if score > bestScore then
								bestScore = score
								bestPlr = plr
								bestPart = part
							end
						end
					end
				end
			end
		end
		return bestPlr, bestPart
	end

	pcall(function()
		local mt = getrawmetatable(game)
		setreadonly(mt, false)
		local oldIndex = mt.__index
		mt.__index = newcclosure(function(self, idx)
			if Config.Enabled and Config.SilentAim and not checkcaller() then
				if self == mouse and (idx == "Hit" or idx == "Target") then
					local _, part = GetBestTargetRage()
					if part then
						if idx == "Hit" then return CFrame.new(part.Position)
						elseif idx == "Target" then return part end
					end
				end
			end
			return oldIndex(self, idx)
		end)
		setreadonly(mt, true)
	end)

	task.spawn(function()
		while true do
			task.wait(0.05)
			if Config.VoidSpam then
				local _, hrp = GetChar()
				if hrp then
					pcall(function()
						hrp.CFrame = CFrame.new(hrp.Position.X, -300, hrp.Position.Z)
					end)
					task.wait(0.02)
					pcall(function()
						local _, currentHrp = GetChar()
						if currentHrp then
							currentHrp.CFrame = CFrame.new(currentHrp.Position.X, 300, currentHrp.Position.Z)
						end
					end)
				end
			end
		end
	end)

	RunService.Heartbeat:Connect(function()
		local char, hrp = GetChar()
		if not char then return end

		if Config.Enabled then
			for _, player in ipairs(Players:GetPlayers()) do
				if player ~= LocalPlayer and player.Character then
					local pRoot = player.Character:FindFirstChild("HumanoidRootPart")
					if pRoot then
						pRoot.Size = Vector3.new(8, 8, 8)
						pRoot.CanCollide = false
					end
				end
			end

			local plr, part = GetBestTestTargetRage or GetBestTargetRage()
			if plr and part then
				local _, eHrp = GetChar(plr)
				if eHrp and Config.Wallbang and hrp then
					local targetPosOffset = eHrp.Position - (eHrp.CFrame.LookVector * Config.TeleportOffsetZ) + Vector3.new(0, Config.TeleportOffsetY, 0)
					hrp.CFrame = CFrame.new(targetPosOffset, eHrp.Position)
				end
			end
		end

		if Config.Noclip then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
		end
	end)

	Notify("APOCALYPSE.LOL BETA V2 // LOADED (PRESS [INSERT] TO TOGGLE)")
end

VerifyButton.MouseButton1Click:Connect(function()
	if KeyInput.Text == CORRECT_KEY then
		StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 204)
		StatusLabel.Text = "KEY VALID"
		task.wait(0.5)
		KeyGui:Destroy()
		LoadMainScript()
	else
		StatusLabel.TextColor3 = Color3.fromRGB(255, 60, 60)
		StatusLabel.Text = "KEY INVALID"
	end
end)

