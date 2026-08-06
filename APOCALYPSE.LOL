local LocalPlayers = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local LocalPlayer = LocalPlayers.LocalPlayer
local Camera = workspace.CurrentCamera

local CONFIG_FOLDER = "APOCALYPSELOGConfigs"
local CORRECT_KEY = "CC1-LQOEHQBENEPQSJWBSAKAKASB0QQNWA"
local DISCORD_LINK = "discord.gg/tvYWHS2B8"

pcall(function()
	if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
end)

local math_abs = math.abs
local math_floor = math.floor
local math_clamp = math.clamp
local tick_func = tick

local CurrentVersion = "V3"

local Config = {
	Ragebot = false,
	RageSpeed = 0.005,
	RageMode = "OMEGA_DESTRUCTOR_BRUTAL",
	AimPartDynamic = true,
	Wallbang = true,
	NoSpread = true,
	NoRecoil = true,
	RapidFire = true,
	InfiniteAmmo = true,
	AutoReload = true,
	ExtendedRange = true,
	InstantHit = true,
	AutoShoot = true,
	AntiAim = false,
	Desync = false,
	ESP = true,
	ESPName = true,
	ESPDistance = true,
	ESPHealth = true,
	ESPTeamColor = true,
	TrajectoryLines = true,
	Crosshair = true,
	CrosshairSize = 40,
	NoHands = true,
	Fullbright = true,
	Speed = false,
	SpeedValue = 220,
	Noclip = false,
	InfiniteJump = false,
	JumpPower = 350,
	Bhop = false,
	FPSBoost = true,
	SkyEnabled = true,
	SkyR = 10, SkyG = 0, SkyB = 20,
	AntiDetection = true,
	UIKey = Enum.KeyCode.RightShift,
	RageKey = Enum.KeyCode.R,
	ESPKey = Enum.KeyCode.V,
	NoclipKey = Enum.KeyCode.N,
}

local Connections = {}
local ESPObjects = {}
local OriginalWalkSpeed = 16
local OriginalJumpPower = 50
local Loaded = false
local CurrentTarget = nil
local RainbowHue = 0
local CrossAngle = 0
local fpsFrames, fpsLast, CurrentFPS = 0, tick_func(), 60
local UIOpen = false
local UIAnimating = false
local HandsHidden = false
local MegaSpinCounter = 0
local LastRageTick = 0

local Theme = {
	Bg = Color3.fromRGB(5, 2, 8),
	Panel = Color3.fromRGB(15, 5, 22),
	Card = Color3.fromRGB(22, 8, 35),
	Accent = Color3.fromRGB(255, 0, 80),
	AccentDark = Color3.fromRGB(120, 0, 35),
	Text = Color3.fromRGB(255, 255, 255),
	TextDim = Color3.fromRGB(180, 140, 200),
	Success = Color3.fromRGB(0, 255, 150),
	Stroke = Color3.fromRGB(100, 10, 60),
}

local function ProtectInstance(obj)
	pcall(function()
		if Config.AntiDetection then
			if syn and syn.protect_gui then syn.protect_gui(obj) end
			if gethui then obj.Parent = gethui()
			elseif get_hidden_gui then obj.Parent = get_hidden_gui() end
		end
	end)
end

local function Notify(text, t)
	t = t or 0.8
	local sg = Instance.new("ScreenGui")
	sg.Name = "Notif_" .. tostring(math.random(10000,99999))
	sg.ResetOnSpawn = false
	ProtectInstance(sg)
	pcall(function()
		if gethui then sg.Parent = gethui() else sg.Parent = CoreGui end
	end)
	if not sg.Parent then sg.Parent = LocalPlayer:WaitForChild("PlayerGui") end
	
	local f = Instance.new("Frame")
	f.Size = UDim2.new(0, 320, 0, 28)
	f.Position = UDim2.new(0.5, -160, 0.03, 0)
	f.BackgroundColor3 = Theme.Panel
	f.BorderSizePixel = 0
	f.Parent = sg
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 4)
	local s = Instance.new("UIStroke", f)
	s.Color = Theme.Accent
	s.Thickness = 1.6
	
	local l = Instance.new("TextLabel")
	l.Size = UDim2.new(1, -10, 1, 0)
	l.Position = UDim2.new(0, 5, 0, 0)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = Theme.Text
	l.Font = Enum.Font.GothamBold
	l.TextSize = 12
	l.Parent = f
	
	task.delay(t, function() pcall(function() sg:Destroy() end) end)
end

local function CopyToClipboard(text)
	pcall(function()
		if setclipboard then setclipboard(text)
		elseif toclipboard then toclipboard(text) end
	end)
end

local function InitKeySystem(onSuccess)
	local keyGui = Instance.new("ScreenGui")
	keyGui.Name = "KeySys_" .. tostring(math.random(1000,9999))
	keyGui.ResetOnSpawn = false
	keyGui.IgnoreGuiInset = true
	keyGui.DisplayOrder = 99999
	ProtectInstance(keyGui)
	pcall(function()
		if gethui then keyGui.Parent = gethui() else keyGui.Parent = CoreGui end
	end)
	if not keyGui.Parent then keyGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local overlay = Instance.new("Frame")
	overlay.Size = UDim2.fromScale(1, 1)
	overlay.BackgroundColor3 = Color3.fromRGB(3, 1, 5)
	overlay.BackgroundTransparency = 0.1
	overlay.BorderSizePixel = 0
	overlay.Parent = keyGui

	local mainBox = Instance.new("Frame")
	mainBox.Size = UDim2.new(0, 380, 0, 210)
	mainBox.Position = UDim2.fromScale(0.5, 0.5)
	mainBox.AnchorPoint = Vector2.new(0.5, 0.5)
	mainBox.BackgroundColor3 = Theme.Bg
	mainBox.BorderSizePixel = 0
	mainBox.Parent = overlay
	Instance.new("UICorner", mainBox).CornerRadius = UDim.new(0, 8)
	local stroke = Instance.new("UIStroke", mainBox)
	stroke.Color = Theme.Accent
	stroke.Thickness = 1.8

	local titleLabel = Instance.new("TextLabel")
	titleLabel.Size = UDim2.new(1, 0, 0, 35)
	titleLabel.Position = UDim2.new(0, 0, 0, 12)
	titleLabel.BackgroundTransparency = 1
	titleLabel.Text = "AXE HUB"
	titleLabel.TextColor3 = Theme.Accent
	titleLabel.Font = Enum.Font.GothamBold
	titleLabel.TextSize = 14
	titleLabel.Parent = mainBox

	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(1, -40, 0, 40)
	textBox.Position = UDim2.new(0, 20, 0, 55)
	textBox.BackgroundColor3 = Theme.Card
	textBox.Text = ""
	textBox.PlaceholderText = "Escribe tu key aquí..."
	textBox.TextColor3 = Theme.Text
	textBox.PlaceholderColor3 = Theme.TextDim
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 12
	textBox.ClearTextOnFocus = false
	textBox.Parent = mainBox
	Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)
	local textStroke = Instance.new("UIStroke", textBox)
	textStroke.Color = Theme.Stroke
	textStroke.Thickness = 1.2

	local verifyBtn = Instance.new("TextButton")
	verifyBtn.Size = UDim2.new(0, 160, 0, 38)
	verifyBtn.Position = UDim2.new(0, 20, 0, 115)
	verifyBtn.BackgroundColor3 = Theme.Accent
	verifyBtn.Text = "VERIFY KEY"
	verifyBtn.TextColor3 = Color3.new(1,1,1)
	verifyBtn.Font = Enum.Font.GothamBold
	verifyBtn.TextSize = 12
	verifyBtn.Parent = mainBox
	Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 6)

	local getBtn = Instance.new("TextButton")
	getBtn.Size = UDim2.new(0, 160, 0, 38)
	getBtn.Position = UDim2.new(1, -180, 0, 115)
	getBtn.BackgroundColor3 = Theme.Card
	getBtn.Text = "GET KEY"
	getBtn.TextColor3 = Theme.Text
	getBtn.Font = Enum.Font.GothamBold
	getBtn.TextSize = 12
	getBtn.Parent = mainBox
	Instance.new("UICorner", getBtn).CornerRadius = UDim.new(0, 6)
	local getStroke = Instance.new("UIStroke", getBtn)
	getStroke.Color = Theme.Stroke
	getStroke.Thickness = 1.2

	local statusLbl = Instance.new("TextLabel")
	statusLbl.Size = UDim2.new(1, 0, 0, 20)
	statusLbl.Position = UDim2.new(0, 0, 1, -26)
	statusLbl.BackgroundTransparency = 1
	statusLbl.Text = "Discord: " .. DISCORD_LINK
	statusLbl.TextColor3 = Theme.TextDim
	statusLbl.Font = Enum.Font.Gotham
	statusLbl.TextSize = 10
	statusLbl.Parent = mainBox

	verifyBtn.MouseButton1Click:Connect(function()
		statusLbl.TextColor3 = Theme.TextDim
		statusLbl.Text = "Verificando key..."
		task.wait(0.2)
		if textBox.Text == CORRECT_KEY then
			statusLbl.TextColor3 = Theme.Success
			statusLbl.Text = "¡Key correcta! Desatando APOCALYPSE.LOL..."
			task.delay(0.4, function()
				pcall(function() keyGui:Destroy() end)
				if onSuccess then onSuccess() end
			end)
		else
			statusLbl.TextColor3 = Theme.Accent
			statusLbl.Text = "Key incorrecta"
		end
	end)

	getBtn.MouseButton1Click:Connect(function()
		CopyToClipboard(DISCORD_LINK)
		statusLbl.TextColor3 = Theme.Success
		statusLbl.Text = "¡Enlace copiado al portapapeles!"
	end)
end

local function GetChar(plr)
	plr = plr or LocalPlayer
	local c = plr.Character
	if not c then return end
	local hrp = c:FindFirstChild("HumanoidRootPart")
	local hum = c:FindFirstChildOfClass("Humanoid")
	local head = c:FindFirstChild("Head")
	if hrp and hum and hum.Health > 0 then return c, hrp, hum, head end
end

local function IsEnemy(plr)
	if not LocalPlayer.Team or not plr.Team then return true end
	return plr.Team ~= LocalPlayer.Team
end

local function GetBestRageTarget()
	local myChar, myHRP = GetChar(LocalPlayer)
	if not myHRP then return nil, nil, nil, nil end
	
	local bestPlr, bestPart, bestHrp, bestHum, shortestDist = nil, nil, nil, nil, math.huge
	
	for _, plr in ipairs(LocalPlayers:GetPlayers()) do
		if plr ~= LocalPlayer and IsEnemy(plr) then
			local char, hrp, hum, head = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				local targetPart = head or hrp
				local dist = (myHRP.Position - hrp.Position).Magnitude
				if dist < shortestDist then
					shortestDist = dist
					bestPlr = plr
					bestPart = targetPart
					bestHrp = hrp
					bestHum = hum
				end
			end
		end
	end

	return bestPlr, bestPart, bestHrp, bestHum
end

local function AimAt(part)
	if not part then return end
	Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
end

local function CreateESP(plr)
	if ESPObjects[plr] then return end
	local char = plr.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end

	local bill = Instance.new("BillboardGui")
	bill.Name = "APOCALYPSE_ESP"
	bill.Adornee = head
	bill.Size = UDim2.new(0, 160, 0, 52)
	bill.StudsOffset = Vector3.new(0, 3.5, 0)
	bill.AlwaysOnTop = true
	bill.MaxDistance = 5000
	bill.LightInfluence = 0
	ProtectInstance(bill)
	pcall(function()
		if gethui then bill.Parent = gethui() else bill.Parent = CoreGui end
	end)

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1, 0, 0, 14)
	name.BackgroundTransparency = 1
	name.Text = plr.Name
	name.TextColor3 = Theme.Accent
	name.TextStrokeTransparency = 0.1
	name.Font = Enum.Font.GothamBold
	name.TextSize = 11
	name.Parent = bill

	local dist = Instance.new("TextLabel")
	dist.Size = UDim2.new(1, 0, 0, 11)
	dist.Position = UDim2.new(0, 0, 0, 13)
	dist.BackgroundTransparency = 1
	dist.Text = ""
	dist.TextColor3 = Theme.TextDim
	dist.Font = Enum.Font.Gotham
	dist.TextSize = 9
	dist.Parent = bill

	local hpText = Instance.new("TextLabel")
	hpText.Size = UDim2.new(1, 0, 0, 11)
	hpText.Position = UDim2.new(0, 0, 0, 24)
	hpText.BackgroundTransparency = 1
	hpText.Text = ""
	hpText.TextColor3 = Theme.Success
	hpText.Font = Enum.Font.GothamBold
	hpText.TextSize = 9
	hpText.Parent = bill

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0.8, 0, 0, 4)
	bg.Position = UDim2.new(0.1, 0, 0, 36)
	bg.BackgroundColor3 = Color3.fromRGB(20, 5, 30)
	bg.BorderSizePixel = 0
	bg.Parent = bill
	Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = Theme.Success
	fill.BorderSizePixel = 0
	fill.Parent = bg
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	ESPObjects[plr] = {Bill = bill, Name = name, Dist = dist, HPText = hpText, Fill = fill, LastUpdate = 0}
end

local function RemoveESP(plr)
	local data = ESPObjects[plr]
	if data then
		pcall(function() if data.Bill then data.Bill:Destroy() end end)
		ESPObjects[plr] = nil
	end
end

local function UpdateESP()
	if not Config.ESP then
		for plr in pairs(ESPObjects) do RemoveESP(plr) end
		return
	end

	local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	local myPos = myHRP and myHRP.Position or Vector3.zero
	local now = tick_func()

	for _, plr in ipairs(LocalPlayers:GetPlayers()) do
		if plr == LocalPlayer or not IsEnemy(plr) then
			RemoveESP(plr)
			continue
		end

		local char = plr.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		local head = char and char:FindFirstChild("Head")
		local hrp = char and char:FindFirstChild("HumanoidRootPart")

		if not (char and hum and head and hum.Health > 0) then
			RemoveESP(plr)
			continue
		end

		if not ESPObjects[plr] then CreateESP(plr) end
		local data = ESPObjects[plr]
		if not data then continue end
		if now - data.LastUpdate < 0.05 then continue end
		data.LastUpdate = now

		if Config.ESPName then
			data.Name.Text = plr.Name
			data.Name.TextColor3 = (Config.ESPTeamColor and plr.Team) and plr.TeamColor.Color or Theme.Accent
		else
			data.Name.Text = ""
		end

		if Config.ESPDistance and hrp then
			local distance = (hrp.Position - myPos).Magnitude
			data.Dist.Text = math_floor(distance) .. "m"
		else
			data.Dist.Text = ""
		end

		if Config.ESPHealth then
			local hp = math_floor(hum.Health)
			local maxHp = math.max(hum.MaxHealth, 1)
			local pct = math_clamp(hp / maxHp, 0, 1)
			data.HPText.Text = hp .. " HP"
			data.Fill.Size = UDim2.new(pct, 0, 1, 0)
		else
			data.HPText.Text = ""
			data.Fill.Size = UDim2.new(0, 0, 1, 0)
		end
	end
end

local function ApplyNoHands()
	local char = LocalPlayer.Character
	if not char then return end
	if Config.NoHands then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				local n = part.Name:lower()
				if n:find("arm") or n:find("hand") or n:find("brazo") then
					part.LocalTransparencyModifier = 1
				end
			end
		end
		HandsHidden = true
	elseif HandsHidden then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				local n = part.Name:lower()
				if n:find("arm") or n:find("hand") or n:find("brazo") then
					part.LocalTransparencyModifier = 0
				end
			end
		end
		HandsHidden = false
	end
end

local function InitMainHub()
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "APOCALYPSE_LOL"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.DisplayOrder = 100
	ProtectInstance(ScreenGui)
	pcall(function()
		if gethui then ScreenGui.Parent = gethui() else ScreenGui.Parent = CoreGui end
	end)
	if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local MenuBtn = Instance.new("TextButton")
	MenuBtn.Size = UDim2.new(0, 130, 0, 26)
	MenuBtn.Position = UDim2.new(0, 14, 0, 12)
	MenuBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MenuBtn.BorderSizePixel = 0
	MenuBtn.Text = "APOCALYPSE.LOL"
	MenuBtn.TextColor3 = Theme.Accent
	MenuBtn.Font = Enum.Font.GothamBold
	MenuBtn.TextSize = 11
	MenuBtn.AutoButtonColor = false
	MenuBtn.Parent = ScreenGui
	Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(0, 4)
	local menuStroke = Instance.new("UIStroke", MenuBtn)
	menuStroke.Color = Theme.Accent
	menuStroke.Thickness = 1.5

	local draggingMenu, menuDragStart, menuStartPos, menuMoved = false, nil, nil, false
	MenuBtn.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingMenu = true
			menuMoved = false
			menuDragStart = input.Position
			menuStartPos = MenuBtn.Position
		end
	end)
	MenuBtn.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			draggingMenu = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if draggingMenu and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - menuDragStart
			if math_abs(delta.X) > 4 or math_abs(delta.Y) > 4 then menuMoved = true end
			MenuBtn.Position = UDim2.new(0, menuStartPos.X.Offset + delta.X, 0, menuStartPos.Y.Offset + delta.Y)
		end
	end)

	local Watermark = Instance.new("Frame")
	Watermark.Size = UDim2.new(0, 380, 0, 18)
	Watermark.Position = UDim2.new(0, 14, 0, 42)
	Watermark.BackgroundColor3 = Theme.Panel
	Watermark.BorderSizePixel = 0
	Watermark.Parent = ScreenGui
	Instance.new("UICorner", Watermark).CornerRadius = UDim.new(0, 3)
	local wmStroke = Instance.new("UIStroke", Watermark)
	wmStroke.Color = Theme.Accent
	wmStroke.Thickness = 1.2
	local wm = Instance.new("TextLabel")
	wm.Size = UDim2.new(1, -6, 1, 0)
	wm.Position = UDim2.new(0, 6, 0, 0)
	wm.BackgroundTransparency = 1
	wm.Text = LocalPlayer.Name .. "  •  APOCALYPSE.LOL BUILD " .. CurrentVersion
	wm.TextColor3 = Theme.Accent
	wm.Font = Enum.Font.GothamBold
	wm.TextSize = 9
	wm.TextXAlignment = Enum.TextXAlignment.Left
	wm.Parent = Watermark

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 460, 0, 520)
	Main.Position = UDim2.new(0, 14, 0, 68)
	Main.BackgroundColor3 = Theme.Bg
	Main.BorderSizePixel = 0
	Main.Visible = false
	Main.ClipsDescendants = true
	Main.Parent = ScreenGui
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)
	local mainStroke = Instance.new("UIStroke", Main)
	mainStroke.Color = Theme.Accent
	mainStroke.Thickness = 1.5

	local UIScale = Instance.new("UIScale")
	UIScale.Scale = 1
	UIScale.Parent = Main

	local TitleBar = Instance.new("Frame")
	TitleBar.Size = UDim2.new(1, 0, 0, 32)
	TitleBar.BackgroundColor3 = Theme.Panel
	TitleBar.BorderSizePixel = 0
	TitleBar.Parent = Main
	Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 6)

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, -34, 1, 0)
	Title.Position = UDim2.new(0, 10, 0, 0)
	Title.BackgroundTransparency = 1
	Title.Text = "APOCALYPSE.LOL BUILD " .. CurrentVersion
	Title.TextColor3 = Theme.Accent
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 12
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = TitleBar

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.Size = UDim2.new(0, 22, 0, 22)
	CloseBtn.Position = UDim2.new(1, -27, 0.5, -11)
	CloseBtn.BackgroundColor3 = Theme.AccentDark
	CloseBtn.Text = "×"
	CloseBtn.TextColor3 = Color3.new(1,1,1)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.TextSize = 13
	CloseBtn.Parent = TitleBar
	Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 3)

	local function OpenUI()
		if UIAnimating or UIOpen then return end
		UIAnimating = true
		UIOpen = true
		Main.Visible = true
		UIScale.Scale = 0.75
		local t1 = TweenService:Create(UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
		t1:Play()
		t1.Completed:Wait()
		UIAnimating = false
	end

	local function CloseUI()
		if UIAnimating or not UIOpen then return end
		UIAnimating = true
		UIOpen = false
		local t1 = TweenService:Create(UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Scale = 0.75})
		t1:Play()
		t1.Completed:Wait()
		Main.Visible = false
		UIAnimating = false
	end

	CloseBtn.MouseButton1Click:Connect(CloseUI)
	MenuBtn.MouseButton1Click:Connect(function()
		if not menuMoved then if UIOpen then CloseUI() else OpenUI() end end
	end)

	do
		local drag, start, pos
		TitleBar.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true; start = i.Position; pos = Main.Position end
		end)
		TitleBar.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end
		end)
		UserInputService.InputChanged:Connect(function(i)
			if drag and i.UserInputType == Enum.UserInputType.MouseMovement then
				local d = i.Position - start
				Main.Position = UDim2.new(pos.X.Scale, pos.X.Offset + d.X, pos.Y.Scale, pos.Y.Offset + d.Y)
			end
		end)
	end

	local TabBar = Instance.new("Frame")
	TabBar.Size = UDim2.new(1, -10, 0, 24)
	TabBar.Position = UDim2.new(0, 5, 0, 38)
	TabBar.BackgroundTransparency = 1
	TabBar.Parent = Main
	local TabLayout = Instance.new("UIListLayout", TabBar)
	TabLayout.FillDirection = Enum.FillDirection.Horizontal
	TabLayout.Padding = UDim.new(0, 3)

	local Pages, TabBtns = {}, {}

	local function SwitchTab(n)
		for k, p in pairs(Pages) do p.Visible = (k == n) end
		for k, b in pairs(TabBtns) do
			if k == n then
				b.BackgroundColor3 = Theme.Accent
				b.TextColor3 = Color3.new(1,1,1)
			else
				b.BackgroundColor3 = Theme.Card
				b.TextColor3 = Theme.TextDim
			end
		end
	end

	local function CreateTab(name)
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0, 86, 1, 0)
		btn.BackgroundColor3 = Theme.Card
		btn.Text = name
		btn.TextColor3 = Theme.TextDim
		btn.Font = Enum.Font.GothamBold
		btn.TextSize = 10
		btn.Parent = TabBar
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 3)
		TabBtns[name] = btn

		local page = Instance.new("ScrollingFrame")
		page.Size = UDim2.new(1, -10, 1, -68)
		page.Position = UDim2.new(0, 5, 0, 66)
		page.BackgroundTransparency = 1
		page.BorderSizePixel = 0
		page.ScrollBarThickness = 4
		page.ScrollBarImageColor3 = Theme.Accent
		page.CanvasSize = UDim2.new(0, 0, 0, 1200)
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.Visible = false
		page.Parent = Main
		Pages[name] = page

		local list = Instance.new("UIListLayout", page)
		list.Padding = UDim.new(0, 3)
		list.SortOrder = Enum.SortOrder.LayoutOrder

		local pad = Instance.new("UIPadding", page)
		pad.PaddingBottom = UDim.new(0, 180)
		pad.PaddingTop = UDim.new(0, 4)

		btn.MouseButton1Click:Connect(function() SwitchTab(name) end)
		return page
	end

	local ragePage = CreateTab("Rage")
	local movePage = CreateTab("Move")
	local espPage = CreateTab("Visuals")
	local miscPage = CreateTab("Misc")
	local settingsPage = CreateTab("Configs")
	SwitchTab("Rage")

	local function CreateSection(parent, text)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 16)
		f.BackgroundTransparency = 1
		f.Parent = parent
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, 0, 1, 0)
		l.BackgroundTransparency = 1
		l.Text = text
		l.TextColor3 = Theme.Accent
		l.Font = Enum.Font.GothamBold
		l.TextSize = 10
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.Parent = f
	end

	local function CreateToggle(parent, text, key, cb)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 26)
		f.BackgroundColor3 = Theme.Card
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
		local accent = Instance.new("Frame")
		accent.Size = UDim2.new(0, 2, 1, -5)
		accent.Position = UDim2.new(0, 3, 0, 2.5)
		accent.BackgroundColor3 = Config[key] and Theme.Success or Theme.Accent
		accent.BorderSizePixel = 0
		accent.Parent = f
		Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(0.7, 0, 1, 0)
		l.Position = UDim2.new(0, 10, 0, 0)
		l.BackgroundTransparency = 1
		l.Text = text
		l.TextColor3 = Theme.Text
		l.Font = Enum.Font.GothamMedium
		l.TextSize = 10
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.Parent = f
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0, 32, 0, 14)
		b.Position = UDim2.new(1, -38, 0.5, -7)
		b.BackgroundColor3 = Config[key] and Theme.Success or Color3.fromRGB(45, 20, 60)
		b.Text = ""
		b.Parent = f
		Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
		local c = Instance.new("Frame")
		c.Size = UDim2.new(0, 10, 0, 10)
		c.Position = Config[key] and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)
		c.BackgroundColor3 = Color3.new(1,1,1)
		c.Parent = b
		Instance.new("UICorner", c).CornerRadius = UDim.new(1, 0)
		b.MouseButton1Click:Connect(function()
			Config[key] = not Config[key]
			local on = Config[key]
			TweenService:Create(b, TweenInfo.new(0.05), {BackgroundColor3 = on and Theme.Success or Color3.fromRGB(45, 20, 60)}):Play()
			TweenService:Create(c, TweenInfo.new(0.05), {Position = on and UDim2.new(1, -12, 0.5, -5) or UDim2.new(0, 2, 0.5, -5)}):Play()
			accent.BackgroundColor3 = on and Theme.Success or Theme.Accent
			if cb then cb(on) end
		end)
	end

	local function CreateSlider(parent, text, key, min, max, def)
		local f = Instance.new("Frame")
		f.Size = UDim2.new(1, 0, 0, 36)
		f.BackgroundColor3 = Theme.Card
		f.BorderSizePixel = 0
		f.Parent = parent
		Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
		local l = Instance.new("TextLabel")
		l.Size = UDim2.new(1, -8, 0, 12)
		l.Position = UDim2.new(0, 6, 0, 3)
		l.BackgroundTransparency = 1
		l.Text = text .. "  •  " .. tostring(def)
		l.TextColor3 = Theme.Text
		l.Font = Enum.Font.Gotham
		l.TextSize = 10
		l.TextXAlignment = Enum.TextXAlignment.Left
		l.Parent = f
		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(1, -12, 0, 4)
		bar.Position = UDim2.new(0, 6, 0, 21)
		bar.BackgroundColor3 = Color3.fromRGB(35, 15, 45)
		bar.BorderSizePixel = 0
		bar.Parent = f
		Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
		local fill = Instance.new("Frame")
		fill.Size = UDim2.new(math_clamp((def - min)/(max - min), 0, 1), 0, 1, 0)
		fill.BackgroundColor3 = Theme.Accent
		fill.BorderSizePixel = 0
		fill.Parent = bar
		Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
		local sliding = false
		bar.InputBegan:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 then sliding = true end
		end)
		UserInputService.InputEnded:Connect(function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
		end)
		UserInputService.InputChanged:Connect(function(i)
			if sliding and i.UserInputType == Enum.UserInputType.MouseMovement then
				local r = math_clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
				local v = math_floor(min + (max - min) * r + 0.5)
				Config[key] = v
				fill.Size = UDim2.new(r, 0, 1, 0)
				l.Text = text .. "  •  " .. v
			end
		end)
	end

	CreateSection(ragePage, "RAGEBOT OMEGA & AIMBOT BRUTAL")
	CreateToggle(ragePage, "Ragebot + Aimbot Extremo Activo", "Ragebot")
	CreateToggle(ragePage, "Wallbang Absoluto Total", "Wallbang")
	CreateToggle(ragePage, "Instant Hit Kill", "InstantHit")
	CreateToggle(ragePage, "Auto Shoot Brutal", "AutoShoot")

	CreateSection(ragePage, "ARMAS & BALAS OMEGA")
	CreateToggle(ragePage, "No Spread", "NoSpread")
	CreateToggle(ragePage, "No Recoil", "NoRecoil")
	CreateToggle(ragePage, "Rapid Fire Mega", "RapidFire")
	CreateToggle(ragePage, "Infinite Ammo", "InfiniteAmmo")
	CreateToggle(ragePage, "Auto Reload", "AutoReload")
	CreateToggle(ragePage, "Extended Range", "ExtendedRange")

	CreateSection(ragePage, "ANTI-AIM & GODMODE")
	CreateToggle(ragePage, "Anti-Aim GodSpin", "AntiAim")

	CreateSection(movePage, "MOVIMIENTO ULTRA VELOZ")
	CreateToggle(movePage, "Speed Hack God", "Speed")
	CreateToggle(movePage, "Noclip", "Noclip")
	CreateToggle(movePage, "Infinite Jump", "InfiniteJump")
	CreateToggle(movePage, "Bunny Hop", "Bhop")
	CreateSlider(movePage, "WalkSpeed", "SpeedValue", 16, 350, Config.SpeedValue)
	CreateSlider(movePage, "JumpPower", "JumpPower", 50, 500, Config.JumpPower)

	CreateSection(espPage, "ESP & OVERLAYS")
	CreateToggle(espPage, "ESP Enabled", "ESP")
	CreateToggle(espPage, "Names", "ESPName")
	CreateToggle(espPage, "Distance", "ESPDistance")
	CreateToggle(espPage, "Health Bars", "ESPHealth")
	CreateToggle(espPage, "Team Color", "ESPTeamColor")
	CreateToggle(espPage, "Trajectory Lines", "TrajectoryLines")
	CreateToggle(espPage, "Crosshair OMEGA", "Crosshair")
	CreateToggle(espPage, "No Hands (FPS)", "NoHands")
	CreateToggle(espPage, "Fullbright", "Fullbright")
	CreateSlider(espPage, "Crosshair Size", "CrosshairSize", 10, 80, Config.CrosshairSize)

	CreateSection(miscPage, "MISC & BYPASS")
	CreateToggle(miscPage, "Anti Detection Safe", "AntiDetection")
	CreateToggle(miscPage, "FPS Boost", "FPSBoost")
	CreateToggle(miscPage, "Custom Sky OMEGA", "SkyEnabled")

	CreateSection(settingsPage, "CONFIGURACIONES")
	local configNameBox = Instance.new("TextBox")
	configNameBox.Size = UDim2.new(1, 0, 0, 28)
	configNameBox.BackgroundColor3 = Theme.Card
	configNameBox.Text = ""
	configNameBox.PlaceholderText = "Nombre de config..."
	configNameBox.TextColor3 = Theme.Text
	configNameBox.PlaceholderColor3 = Theme.TextDim
	configNameBox.Font = Enum.Font.Gotham
	configNameBox.TextSize = 11
	configNameBox.ClearTextOnFocus = false
	configNameBox.Parent = settingsPage
	Instance.new("UICorner", configNameBox).CornerRadius = UDim.new(0, 3)

	local function CreateButton(parent, text, color, callback)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1, 0, 0, 28)
		b.BackgroundColor3 = color or Theme.Card
		b.Text = text
		b.TextColor3 = Color3.new(1,1,1)
		b.Font = Enum.Font.GothamBold
		b.TextSize = 11
		b.Parent = parent
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
		b.MouseButton1Click:Connect(callback)
		return b
	end

	CreateButton(settingsPage, "Crear Config", Color3.fromRGB(150, 20, 80), function()
		local name = configNameBox.Text:gsub("%s+", "")
		if name == "" then Notify("Escribe un nombre") return end
		if pcall(function() writefile(CONFIG_FOLDER .. "/" .. name .. ".json", HttpService:JSONEncode(Config)) end) then
			Notify("Config guardada: " .. name)
		end
	end)

	local CrossGui = Instance.new("ScreenGui")
	CrossGui.Name = "APOCALYPSE_CROSS"
	CrossGui.ResetOnSpawn = false
	CrossGui.IgnoreGuiInset = true
	ProtectInstance(CrossGui)
	pcall(function()
		if gethui then CrossGui.Parent = gethui() else CrossGui.Parent = CoreGui end
	end)
	if not CrossGui.Parent then CrossGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local CrossCenter = Instance.new("Frame")
	CrossCenter.Size = UDim2.fromOffset(2, 2)
	CrossCenter.Position = UDim2.fromScale(0.5, 0.5)
	CrossCenter.AnchorPoint = Vector2.new(0.5, 0.5)
	CrossCenter.BackgroundTransparency = 1
	CrossCenter.Visible = false
	CrossCenter.Parent = CrossGui

	local UILines = {}
	for i = 1, 4 do
		local line = Instance.new("Frame")
		line.BorderSizePixel = 0
		line.AnchorPoint = Vector2.new(0.5, 0.5)
		line.Parent = CrossCenter
		UILines[i] = line
	end

	Connections[#Connections+1] = RunService.RenderStepped:Connect(function(dt)
		fpsFrames += 1
		if tick_func() - fpsLast >= 1 then
			CurrentFPS = fpsFrames
			fpsFrames = 0
			fpsLast = tick_func()
			wm.Text = LocalPlayer.Name .. "  •  APOCALYPSE.LOL BUILD " .. CurrentVersion .. "  •  " .. CurrentFPS .. " FPS"
		end

		if Config.SkyEnabled then
			local col = Color3.fromRGB(Config.SkyR, Config.SkyG, Config.SkyB)
			Lighting.Ambient = col
			Lighting.OutdoorAmbient = col
			Lighting.FogColor = col
		end

		if Config.Fullbright then
			Lighting.Brightness = 2
			Lighting.ClockTime = 14
			Lighting.GlobalShadows = false
		end

		RainbowHue = (RainbowHue + dt * 2) % 1
		if Config.Crosshair then
			CrossCenter.Visible = true
			local s = Config.CrosshairSize
			CrossAngle += 15 * dt * 4
			local rainbow = Color3.fromHSV(RainbowHue, 1, 1)
			local angles = {CrossAngle, CrossAngle + 1.5708, CrossAngle + 3.1416, CrossAngle + 4.7124}
			for i = 1, 4 do
				local a = angles[i]
				local line = UILines[i]
				line.Size = UDim2.fromOffset(s * 0.4, 2)
				line.BackgroundColor3 = rainbow
				line.Position = UDim2.fromOffset(math.cos(a) * (s * 0.6), math.sin(a) * (s * 0.6))
				line.Rotation = math.deg(a)
			end
		else
			CrossCenter.Visible = false
		end

		ApplyNoHands()
	end)

	Connections[#Connections+1] = RunService.Heartbeat:Connect(function()
		if not Loaded then return end
		local char, hrp, hum = GetChar()
		if not char then
			CurrentTarget = nil
			return
		end

		if Config.Ragebot then
			local plr, part, eHrp, eHum = GetBestRageTarget()
			if plr and part and eHrp then
				CurrentTarget = plr
				AimAt(part)
			else
				CurrentTarget = nil
			end
		else
			CurrentTarget = nil
		end

		if Config.AntiAim then
			MegaSpinCounter = (MegaSpinCounter + 90) % 360
			pcall(function()
				if hrp then
					hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(MegaSpinCounter), 0)
				end
			end)
		end

		if Config.Speed then
			hum.WalkSpeed = Config.SpeedValue
		end

		if Config.Bhop and hum.FloorMaterial ~= Enum.Material.Air and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end

		pcall(function()
			if hum.UseJumpPower ~= nil then
				hum.UseJumpPower = true
				hum.JumpPower = Config.InfiniteJump and Config.JumpPower or OriginalJumpPower
			end
		end)

		if Config.Noclip then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
		end
	end)

	task.spawn(function()
		while ScreenGui and ScreenGui.Parent do
			if Loaded and Config.ESP then
				UpdateESP()
			else
				for plr in pairs(ESPObjects) do RemoveESP(plr) end
			end
			task.wait(0.08)
		end
	end)

	UserInputService.InputBegan:Connect(function(input, gp)
		if input.KeyCode == Config.UIKey then if UIOpen then CloseUI() else OpenUI() end
		elseif input.KeyCode == Config.RageKey then
			Config.Ragebot = not Config.Ragebot
			Notify("Ragebot OMEGA BRUTAL: " + (Config.Ragebot and "ON" or "OFF"))
		elseif input.KeyCode == Config.ESPKey then Config.ESP = not Config.ESP
		elseif input.KeyCode == Config.NoclipKey then Config.Noclip = not Config.Noclip
		end
	end)

	local function OnChar(c)
		task.wait(0.05)
		local hum = c:FindFirstChildOfClass("Humanoid")
		if hum then
			OriginalWalkSpeed = hum.WalkSpeed
			pcall(function() if hum.UseJumpPower ~= nil then OriginalJumpPower = hum.JumpPower end end)
		end
		HandsHidden = false
		CurrentTarget = nil
	end

	if LocalPlayer.Character then OnChar(LocalPlayer.Character) end
	LocalPlayer.CharacterAdded:Connect(OnChar)

	LocalPlayers.PlayerRemoving:Connect(function(plr) RemoveESP(plr) end)

	Loaded = true
	Notify("¡APOCALYPSE.LOL V3 ACTIVADO!", 1.5)
end

InitKeySystem(InitMainHub)

