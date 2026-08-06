local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CONFIG_FOLDER = "ApocalypseConfigs"
local AUTOLOAD_FILE = "ApocalypseConfigs/autoload.txt"

pcall(function()
	if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
end)

-- PANTALLA DE CARGA CON LINK DE DISCORD
do
	local loadGui = Instance.new("ScreenGui")
	loadGui.Name = tostring(math.random(100000,999999))
	loadGui.ResetOnSpawn = false
	loadGui.IgnoreGuiInset = true
	loadGui.DisplayOrder = 99999
	pcall(function()
		if gethui then loadGui.Parent = gethui() else loadGui.Parent = CoreGui end
	end)
	if not loadGui.Parent then loadGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(2, 2, 4)
	bg.BorderSizePixel = 0
	bg.Parent = loadGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.Position = UDim2.new(0, 0, 0.35, 0)
	title.BackgroundTransparency = 1
	title.Text = "APOCALYPSE.LOL"
	title.TextColor3 = Color3.fromRGB(255, 0, 18)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 34
	title.Parent = bg

	local discordText = Instance.new("TextLabel")
	discordText.Size = UDim2.new(1, 0, 0, 24)
	discordText.Position = UDim2.new(0, 0, 0.42, 0)
	discordText.BackgroundTransparency = 1
	discordText.Text = "discord.gg/tvYWHS2B8"
	discordText.TextColor3 = Color3.fromRGB(150, 150, 175)
	discordText.Font = Enum.Font.GothamMedium
	discordText.TextSize = 14
	discordText.Parent = bg

	local status = Instance.new("TextLabel")
	status.Size = UDim2.new(1, 0, 0, 28)
	status.Position = UDim2.new(0, 0, 0.49, 0)
	status.BackgroundTransparency = 1
	status.Text = "Cargando APOCALYPSE.LOL // RajeBot Brutal & Instantáneo..."
	status.TextColor3 = Color3.fromRGB(240, 240, 255)
	status.Font = Enum.Font.Gotham
	status.TextSize = 15
	status.Parent = bg

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(0, 280, 0, 8)
	barBg.Position = UDim2.new(0.5, -140, 0.57, 0)
	barBg.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	barBg.BorderSizePixel = 0
	barBg.Parent = bg
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.new(0, 0, 1, 0)
	barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 18)
	barFill.BorderSizePixel = 0
	barFill.Parent = barBg
	Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

	local percent = Instance.new("TextLabel")
	percent.Size = UDim2.new(1, 0, 0, 20)
	percent.Position = UDim2.new(0, 0, 0.61, 0)
	percent.BackgroundTransparency = 1
	percent.Text = "0%"
	percent.TextColor3 = Color3.fromRGB(170, 170, 185)
	percent.Font = Enum.Font.Gotham
	percent.TextSize = 13
	percent.Parent = bg

	local startTime = tick()
	local duration = 0.3
	local dots, lastDot = 0, 0

	while tick() - startTime < duration do
		local progress = math.clamp((tick() - startTime) / duration, 0, 1)
		barFill.Size = UDim2.new(progress, 0, 1, 0)
		percent.Text = math.floor(progress * 100) .. "%"
		if tick() - lastDot > 0.08 then
			dots = (dots + 1) % 4
			status.Text = "Cargando RajeBot Brutal" .. string.rep(".", dots)
			lastDot = tick()
		end
		task.wait()
	end
	loadGui:Destroy()
end

-- SISTEMA DE KEY (KEY SYSTEM)
local CorrectKey = "CC1-LQOEHQBENEPQSJWBSAKAKASB0QQNWA"
local KeyVerified = false

do
	local keyGui = Instance.new("ScreenGui")
	keyGui.Name = tostring(math.random(100000,999999))
	keyGui.ResetOnSpawn = false
	keyGui.IgnoreGuiInset = true
	keyGui.DisplayOrder = 99999
	pcall(function()
		if gethui then keyGui.Parent = gethui() else keyGui.Parent = CoreGui end
	end)
	if not keyGui.Parent then keyGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
	bg.BorderSizePixel = 0
	bg.Parent = keyGui

	local mainBox = Instance.new("Frame")
	mainBox.Size = UDim2.fromOffset(400, 260)
	mainBox.Position = UDim2.fromScale(0.5, 0.5)
	mainBox.AnchorPoint = Vector2.new(0.5, 0.5)
	mainBox.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
	mainBox.BorderSizePixel = 0
	mainBox.Parent = bg
	Instance.new("UICorner", mainBox).CornerRadius = UDim.new(0, 8)

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 40)
	title.Position = UDim2.new(0, 0, 0.05, 0)
	title.BackgroundTransparency = 1
	title.Text = "SEXUS HUB - KEY SYSTEM"
	title.TextColor3 = Color3.fromRGB(255, 0, 18)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 18
	title.Parent = mainBox

	local textBox = Instance.new("TextBox")
	textBox.Size = UDim2.new(0.85, 0, 0, 40)
	textBox.Position = UDim2.new(0.075, 0, 0.28, 0)
	textBox.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
	textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	textBox.PlaceholderText = "Ingresa tu llave aquí..."
	textBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 120)
	textBox.Font = Enum.Font.Gotham
	textBox.TextSize = 14
	textBox.ClearTextOnFocus = false
	textBox.Parent = mainBox
	Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

	local verifyBtn = Instance.new("TextButton")
	verifyBtn.Size = UDim2.new(0.41, 0, 0, 38)
	verifyBtn.Position = UDim2.new(0.075, 0, 0.58, 0)
	verifyBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 18)
	verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	verifyBtn.Text = "VERIFY KEY"
	verifyBtn.Font = Enum.Font.GothamBold
	verifyBtn.TextSize = 14
	verifyBtn.Parent = mainBox
	Instance.new("UICorner", verifyBtn).CornerRadius = UDim.new(0, 6)

	local getBtn = Instance.new("TextButton")
	getBtn.Size = UDim2.new(0.41, 0, 0, 38)
	getBtn.Position = UDim2.new(0.515, 0, 0.58, 0)
	getBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
	getBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	getBtn.Text = "GET KEY"
	getBtn.Font = Enum.Font.GothamBold
	getBtn.TextSize = 14
	getBtn.Parent = mainBox
	Instance.new("UICorner", getBtn).CornerRadius = UDim.new(0, 6)

	local feedback = Instance.new("TextLabel")
	feedback.Size = UDim2.new(1, 0, 0, 25)
	feedback.Position = UDim2.new(0, 0, 0.78, 0)
	feedback.BackgroundTransparency = 1
	feedback.Text = ""
	feedback.TextColor3 = Color3.fromRGB(255, 255, 255)
	feedback.Font = Enum.Font.GothamBold
	feedback.TextSize = 13
	feedback.Parent = mainBox

	getBtn.MouseButton1Click:Connect(function()
		pcall(function()
			setclipboard("discord.gg/tvYWHS2B8")
		end)
		feedback.TextColor3 = Color3.fromRGB(0, 240, 110)
		feedback.Text = "¡Link copiado al portapapeles!"
	end)

	verifyBtn.MouseButton1Click:Connect(function()
		feedback.TextColor3 = Color3.fromRGB(240, 240, 255)
		feedback.Text = "VALIDANDO..."
		task.wait(0.6)
		if textBox.Text == CorrectKey then
			feedback.TextColor3 = Color3.fromRGB(0, 240, 110)
			feedback.Text = "VALID KEY DISFRUTA"
			task.wait(1)
			KeyVerified = true
			keyGui:Destroy()
		else
			feedback.TextColor3 = Color3.fromRGB(255, 0, 18)
			feedback.Text = "PRUEBA DE NUEVO PORFA VOR"
		end
	end)

	repeat task.wait() until KeyVerified
end

local CurrentVersion = "v3 OMEGA"
local HubTitle = "SEXUS HUB"

local Config = {
	Aimbot = false,
	AimbotHold = false,
	Ragebot = false,
	TeleportRage = true,
	TeleportInterval = 0,
	TeleportOffsetY = 8,
	TeleportOffsetX = 0,
	TeleportOffsetZ = 3,
	RageMode = 10,
	NoSpread = true,
	NoRecoil = true,
	RapidFire = true,
	InfiniteAmmo = true,
	AutoReload = true,
	ExtendedRange = true,
	AntiAimbot = false,
	AimPartDynamic = true,
	FOV = 30000,
	Smoothness = 0,
	Prediction = 0,
	AutoPrediction = false,
	TeamCheck = true,
	VisibleCheck = false,
	ShowTargetLine = true,
	NearestLine = true,
	HitNotify = true,
	
	Speed = false,
	SpeedValue = 140,
	Fly = false,
	FlySpeed = 400,
	Noclip = false,
	InfiniteJump = false,
	JumpPower = 250,
	HumanMove = false,
	
	ESP = false,
	ESPName = true,
	ESPDistance = true,
	ESPHealth = true,
	ESPTeamColor = true,
	Chams = false,
	FOVCircle = true,
	Crosshair = false,
	CrosshairSize = 30,
	NoHands = false,
	
	AntiDetection = true,
	FPSBoost = false,
	SkyEnabled = false,
	SkyR = 0, SkyG = 0, SkyB = 0,
	
	UIKey = Enum.KeyCode.RightShift,
	AimKey = Enum.KeyCode.E,
	RageKey = Enum.KeyCode.R,
	FlyKey = Enum.KeyCode.F,
	ESPKey = Enum.KeyCode.V,
	NoclipKey = Enum.KeyCode.N,
}

local Connections = {}
local ESPObjects = {}
local HealthCache = {}
local Aiming = false
local Flying = false
local Noclipping = false
local OriginalWalkSpeed = 16
local OriginalJumpPower = 50
local FlyAtt, FlyVel = nil, nil
local Loaded = false
local CurrentTarget = nil
local NearestEnemy = nil
local RainbowHue = 0
local CrossAngle = 0
local fpsFrames, fpsLast, CurrentFPS = 0, tick(), 60
local StartTime = tick()
local SelectedConfig = nil
local HandsHidden = false

-- CARGAR RAYFIELD UI
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Sexus Hub",
	LoadingTitle = "SEXUS HUB OMEGA",
	LoadingSubtitle = "by Apocalypse.lol",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = CONFIG_FOLDER,
		FileName = "SexusHubConfig"
	},
	Discord = {
		Enabled = false,
		Invite = "noinvite",
		RememberJoins = true
	},
	KeySystem = false,
})

-- NUEVAS SECCIONES APARECIENDO ARRIBA
local MainTab = Window:CreateTab("Combate", 401)
local MoveTab = Window:CreateTab("Movimiento", 402)
local ESPTab = Window:CreateTab("ESP", 403)
local MiscTab = Window:CreateTab("Misc", 404)
local SettingsTab = Window:CreateTab("Settings", 405)

local function ProtectInstance(obj)
	pcall(function()
		if Config.AntiDetection then
			if syn and syn.protect_gui then syn.protect_gui(obj) end
			if gethui then obj.Parent = gethui()
			elseif get_hidden_gui then obj.Parent = get_hidden_gui() end
		end
	end)
end

local function SafeRandom(min, max)
	return min + (math.random() * (max - min))
end

local function Notify(text, t)
	Rayfield:Notify({
		Title = "Sexus Hub",
		Content = text,
		Duration = t or 1.5,
		Image = 4483362458,
	})
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
	if not Config.TeamCheck then return true end
	if not plr.Team or not LocalPlayer.Team then return true end
	return plr.Team ~= LocalPlayer.Team
end

local RaycastParamsCache = RaycastParams.new()
RaycastParamsCache.FilterType = Enum.RaycastFilterType.Exclude

local function GetAimPart(char)
	local head = char:FindFirstChild("Head")
	local upperTorso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
	local root = char:FindFirstChild("HumanoidRootPart")
	if Config.AimPartDynamic then
		if head then return head end
		if upperTorso then return upperTorso end
		if root then return root end
	end
	return head or upperTorso or root
end

local function GetBestTargetRage()
	local bestPlr, bestPart, bestScore = nil, nil, -math.huge
	local center = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
	local _, myHRP = GetChar()
	if not myHRP then return nil, nil end
	local myPos = myHRP.Position

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and IsEnemy(plr) then
			local char, hrp, hum = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				local part = GetAimPart(char)
				if part then
					local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
					local dist3D = (hrp.Position - myPos).Magnitude
					if dist3D <= 99999 then
						local dist2D = (Vector2.new(sp.X, sp.Y) - center).Magnitude
						local score = 5000000 - (dist3D * 1.0) - (dist2D * 0.05)
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

local function GetBestTargetLegit()
	local bestPlr, bestPart, bestDist = nil, nil, Config.FOV
	local center = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and IsEnemy(plr) then
			local char, hrp, hum = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				local part = GetAimPart(char)
				if not part then continue end
				local sp, onScreen = Camera:WorldToViewportPoint(part.Position)
				if onScreen then
					local dist2D = (Vector2.new(sp.X, sp.Y) - center).Magnitude
					if dist2D < bestDist then
						bestDist = dist2D
						bestPlr = plr
						bestPart = part
					end
				end
			end
		end
	end
	return bestPlr, bestPart
end

local function GetNearestEnemy()
	local bestPlr, bestDist = nil, math.huge
	local _, myHRP = GetChar()
	if not myHRP then return nil end
	local myPos = myHRP.Position
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and IsEnemy(plr) then
			local char, hrp, hum = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				local dist = (hrp.Position - myPos).Magnitude
				if dist < bestDist then
					bestDist = dist
					bestPlr = plr
				end
			end
		end
	end
	return bestPlr
end

local function CreateESP(plr)
	if ESPObjects[plr] then return end
	local char = plr.Character
	if not char then return end
	local head = char:FindFirstChild("Head")
	if not head then return end

	local bill = Instance.new("BillboardGui")
	bill.Name = "E" .. tostring(math.random(1000,9999))
	bill.Adornee = head
	bill.Size = UDim2.new(0, 150, 0, 48)
	bill.StudsOffset = Vector3.new(0, 3.3, 0)
	bill.AlwaysOnTop = true
	bill.MaxDistance = 5000
	bill.LightInfluence = 0
	ProtectInstance(bill)
	pcall(function()
		if gethui then bill.Parent = gethui() else bill.Parent = CoreGui end
	end)

	local name = Instance.new("TextLabel")
	name.Size = UDim2.new(1, 0, 0, 13)
	name.BackgroundTransparency = 1
	name.Text = plr.Name
	name.TextColor3 = Color3.fromRGB(255, 0, 18)
	name.TextStrokeTransparency = 0.2
	name.Font = Enum.Font.GothamBold
	name.TextSize = 11
	name.Parent = bill

	local dist = Instance.new("TextLabel")
	dist.Size = UDim2.new(1, 0, 0, 10)
	dist.Position = UDim2.new(0, 0, 0, 12)
	dist.BackgroundTransparency = 1
	dist.Text = ""
	dist.TextColor3 = Color3.fromRGB(120, 120, 140)
	dist.Font = Enum.Font.Gotham
	dist.TextSize = 9
	dist.Parent = bill

	local hpText = Instance.new("TextLabel")
	hpText.Size = UDim2.new(1, 0, 0, 10)
	hpText.Position = UDim2.new(0, 0, 0, 22)
	hpText.BackgroundTransparency = 1
	hpText.Text = ""
	hpText.TextColor3 = Color3.fromRGB(0, 240, 110)
	hpText.Font = Enum.Font.GothamBold
	hpText.TextSize = 9
	hpText.Parent = bill

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0.8, 0, 0, 4)
	bg.Position = UDim2.new(0.1, 0, 0, 34)
	bg.BackgroundColor3 = Color3.fromRGB(15, 15, 22)
	bg.BorderSizePixel = 0
	bg.Parent = bill
	Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 240, 110)
	fill.BorderSizePixel = 0
	fill.Parent = bg
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	ESPObjects[plr] = {
		Bill = bill,
		Name = name,
		Dist = dist,
		HPText = hpText,
		Fill = fill,
		LastUpdate = 0
	}
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

	local _, myHRP = GetChar()
	local myPos = myHRP and myHRP.Position or Vector3.zero
	local now = tick()

	for _, plr in ipairs(Players:GetPlayers()) do
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
		if now - data.LastUpdate < 0.08 then continue end
		data.LastUpdate = now

		if Config.ESPName then
			data.Name.Text = plr.Name
		else
			data.Name.Text = ""
		end

		if Config.ESPDistance and hrp then
			local distance = (hrp.Position - myPos).Magnitude
			data.Dist.Text = distance > 5000 and "" or (math.floor(distance) .. "m")
		else
			data.Dist.Text = ""
		end

		if Config.ESPHealth then
			local hp = math.floor(hum.Health)
			local maxHp = math.max(hum.MaxHealth, 1)
			local pct = math.clamp(hp / maxHp, 0, 1)
			data.HPText.Text = hp .. " HP"
			data.Fill.Size = UDim2.new(pct, 0, 1, 0)
			local r = 255 * (1 - pct)
			local g = 240 * pct
			data.Fill.BackgroundColor3 = Color3.fromRGB(r, g, 20)
		else
			data.HPText.Text = ""
			data.Fill.Size = UDim2.new(0, 0, 1, 0)
		end
	end
end

local function ApplyNoHands()
	local char = LocalPlayer.Character
	if not char then return end
	local isFirstPerson = false
	local head = char:FindFirstChild("Head")
	if head then
		isFirstPerson = (Camera.CFrame.Position - head.Position).Magnitude < 1.2
	end

	if Config.NoHands and isFirstPerson then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				local n = part.Name:lower()
				if n:find("arm") or n:find("hand") or n:find("brazo") or n:find("mano") then
					part.LocalTransparencyModifier = 1
				end
			end
		end
		HandsHidden = true
	elseif HandsHidden then
		for _, part in ipairs(char:GetDescendants()) do
			if part:IsA("BasePart") then
				local n = part.Name:lower()
				if n:find("arm") or n:find("hand") or n:find("brazo") or n:find("mano") then
					part.LocalTransparencyModifier = 0
				end
			end
		end
		HandsHidden = false
	end
end

local function ApplyFPS(state)
	pcall(function()
		if state then
			settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
			Lighting.GlobalShadows = false
			Lighting.FogEnd = 9e9
			for _, v in ipairs(Lighting:GetChildren()) do
				if v:IsA("PostEffect") then v.Enabled = false end
			end
		else
			settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
			Lighting.GlobalShadows = true
		end
	end)
end

-- SECCIÓN COMBATE (MAIN)
local CombatSection = MainTab:CreateSection("COMBATE - RAJEBOT BRUTAL OMEGA")

MainTab:CreateToggle({
	Name = "RajeBot Hiper-Agresivo Brutal",
	CurrentValue = Config.Ragebot,
	Flag = "Ragebot",
	Callback = function(Value)
		Config.Ragebot = Value
	end,
})

MainTab:CreateToggle({
	Name = "Teleport Instantáneo (Omega)",
	CurrentValue = Config.TeleportRage,
	Flag = "TeleportRage",
	Callback = function(Value)
		Config.TeleportRage = Value
	end,
})

MainTab:CreateSlider({
	Name = "Arriba (+) / Abajo (-) [Y]",
	Range = {-10, 10},
	Increment = 1,
	CurrentValue = Config.TeleportOffsetY,
	Flag = "TeleportOffsetY",
	Callback = function(Value)
		Config.TeleportOffsetY = Value
	end,
})

MainTab:CreateSlider({
	Name = "Derecha (+) / Izquierda (-) [X]",
	Range = {-10, 10},
	Increment = 1,
	CurrentValue = Config.TeleportOffsetX,
	Flag = "TeleportOffsetX",
	Callback = function(Value)
		Config.TeleportOffsetX = Value
	end,
})

MainTab:CreateSlider({
	Name = "Adelante (+) / Atrás (-) [Z]",
	Range = {-10, 10},
	Increment = 1,
	CurrentValue = Config.TeleportOffsetZ,
	Flag = "TeleportOffsetZ",
	Callback = function(Value)
		Config.TeleportOffsetZ = Value
	end,
})

MainTab:CreateToggle({
	Name = "Dynamic Part",
	CurrentValue = Config.AimPartDynamic,
	Flag = "AimPartDynamic",
	Callback = function(Value)
		Config.AimPartDynamic = Value
	end,
})

MainTab:CreateToggle({
	Name = "Visible Check",
	CurrentValue = Config.VisibleCheck,
	Flag = "VisibleCheck",
	Callback = function(Value)
		Config.VisibleCheck = Value
	end,
})

MainTab:CreateToggle({
	Name = "Team Check",
	CurrentValue = Config.TeamCheck,
	Flag = "TeamCheck",
	Callback = function(Value)
		Config.TeamCheck = Value
	end,
})

MainTab:CreateSlider({
	Name = "FOV Extremo",
	Range = {1000, 40000},
	Increment = 500,
	CurrentValue = Config.FOV,
	Flag = "FOV",
	Callback = function(Value)
		Config.FOV = Value
	end,
})

MainTab:CreateSection("COMBATE - APUNTADO LEGIT")

MainTab:CreateToggle({
	Name = "Aimbot",
	CurrentValue = Config.Aimbot,
	Flag = "Aimbot",
	Callback = function(Value)
		Config.Aimbot = Value
	end,
})

MainTab:CreateToggle({
	Name = "Hold to Aim",
	CurrentValue = Config.AimbotHold,
	Flag = "AimbotHold",
	Callback = function(Value)
		Config.AimbotHold = Value
	end,
})

MainTab:CreateSlider({
	Name = "Smoothness",
	Range = {0, 35},
	Increment = 1,
	CurrentValue = Config.Smoothness,
	Flag = "Smoothness",
	Callback = function(Value)
		Config.Smoothness = Value
	end,
})

MainTab:CreateSection("COMBATE - MECANICAS DE ARMAS")

MainTab:CreateToggle({
	Name = "Sin Dispersión (No Spread)",
	CurrentValue = Config.NoSpread,
	Flag = "NoSpread",
	Callback = function(Value)
		Config.NoSpread = Value
	end,
})

MainTab:CreateToggle({
	Name = "Sin Retroceso (No Recoil)",
	CurrentValue = Config.NoRecoil,
	Flag = "NoRecoil",
	Callback = function(Value)
		Config.NoRecoil = Value
	end,
})

MainTab:CreateToggle({
	Name = "Disparo Rápido (Rapid Fire)",
	CurrentValue = Config.RapidFire,
	Flag = "RapidFire",
	Callback = function(Value)
		Config.RapidFire = Value
	end,
})

MainTab:CreateToggle({
	Name = "Munición Infinita",
	CurrentValue = Config.InfiniteAmmo,
	Flag = "InfiniteAmmo",
	Callback = function(Value)
		Config.InfiniteAmmo = Value
	end,
})

MainTab:CreateToggle({
	Name = "Recarga Automática",
	CurrentValue = Config.AutoReload,
	Flag = "AutoReload",
	Callback = function(Value)
		Config.AutoReload = Value
	end,
})

MainTab:CreateToggle({
	Name = "Alcance Extendído",
	CurrentValue = Config.ExtendedRange,
	Flag = "ExtendedRange",
	Callback = function(Value)
		Config.ExtendedRange = Value
	end,
})

MainTab:CreateSection("COMBATE - PROTECCIÓN & VISUALES")

MainTab:CreateToggle({
	Name = "Target Line",
	CurrentValue = Config.ShowTargetLine,
	Flag = "ShowTargetLine",
	Callback = function(Value)
		Config.ShowTargetLine = Value
	end,
})

MainTab:CreateToggle({
	Name = "Nearest Enemy Line",
	CurrentValue = Config.NearestLine,
	Flag = "NearestLine",
	Callback = function(Value)
		Config.NearestLine = Value
	end,
})

MainTab:CreateToggle({
	Name = "Hit Notify",
	CurrentValue = Config.HitNotify,
	Flag = "HitNotify",
	Callback = function(Value)
		Config.HitNotify = Value
	end,
})

-- SECCIÓN MOVIMIENTO
MoveTab:CreateSection("MOVIMIENTO")

MoveTab:CreateToggle({
	Name = "Speed",
	CurrentValue = Config.Speed,
	Flag = "Speed",
	Callback = function(Value)
		Config.Speed = Value
	end,
})

MoveTab:CreateToggle({
	Name = "Fly",
	CurrentValue = Config.Fly,
	Flag = "Fly",
	Callback = function(Value)
		Config.Fly = Value
	end,
})

MoveTab:CreateToggle({
	Name = "Noclip",
	CurrentValue = Config.Noclip,
	Flag = "Noclip",
	Callback = function(Value)
		Config.Noclip = Value
	end,
})

MoveTab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = Config.InfiniteJump,
	Flag = "InfiniteJump",
	Callback = function(Value)
		Config.InfiniteJump = Value
	end,
})

MoveTab:CreateToggle({
	Name = "Human Movement",
	CurrentValue = Config.HumanMove,
	Flag = "HumanMove",
	Callback = function(Value)
		Config.HumanMove = Value
	end,
})

MoveTab:CreateSlider({
	Name = "Walk Speed",
	Range = {16, 400},
	Increment = 5,
	CurrentValue = Config.SpeedValue,
	Flag = "SpeedValue",
	Callback = function(Value)
		Config.SpeedValue = Value
	end,
})

MoveTab:CreateSlider({
	Name = "Fly Speed",
	Range = {30, 900},
	Increment = 10,
	CurrentValue = Config.FlySpeed,
	Flag = "FlySpeed",
	Callback = function(Value)
		Config.FlySpeed = Value
	end,
})

MoveTab:CreateSlider({
	Name = "Jump Power",
	Range = {40, 700},
	Increment = 10,
	CurrentValue = Config.JumpPower,
	Flag = "JumpPower",
	Callback = function(Value)
		Config.JumpPower = Value
	end,
})

-- SECCIÓN ESP
ESPTab:CreateSection("ESP / VISUALS")

ESPTab:CreateToggle({
	Name = "ESP",
	CurrentValue = Config.ESP,
	Flag = "ESP",
	Callback = function(Value)
		Config.ESP = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Name",
	CurrentValue = Config.ESPName,
	Flag = "ESPName",
	Callback = function(Value)
		Config.ESPName = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Distance",
	CurrentValue = Config.ESPDistance,
	Flag = "ESPDistance",
	Callback = function(Value)
		Config.ESPDistance = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Health + Vida",
	CurrentValue = Config.ESPHealth,
	Flag = "ESPHealth",
	Callback = function(Value)
		Config.ESPHealth = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Team Color",
	CurrentValue = Config.ESPTeamColor,
	Flag = "ESPTeamColor",
	Callback = function(Value)
		Config.ESPTeamColor = Value
	end,
})

ESPTab:CreateToggle({
	Name = "FOV Circle",
	CurrentValue = Config.FOVCircle,
	Flag = "FOVCircle",
	Callback = function(Value)
		Config.FOVCircle = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Crosshair",
	CurrentValue = Config.Crosshair,
	Flag = "Crosshair",
	Callback = function(Value)
		Config.Crosshair = Value
	end,
})

ESPTab:CreateToggle({
	Name = "No Hands / No Manos",
	CurrentValue = Config.NoHands,
	Flag = "NoHands",
	Callback = function(Value)
		Config.NoHands = Value
	end,
})

ESPTab:CreateSlider({
	Name = "Crosshair Size",
	Range = {10, 50},
	Increment = 2,
	CurrentValue = Config.CrosshairSize,
	Flag = "CrosshairSize",
	Callback = function(Value)
		Config.CrosshairSize = Value
	end,
})

-- SECCIÓN MISC
MiscTab:CreateSection("MISC")

MiscTab:CreateToggle({
	Name = "Anti Detection (Safe)",
	CurrentValue = Config.AntiDetection,
	Flag = "AntiDetection",
	Callback = function(Value)
		Config.AntiDetection = Value
	end,
})

MiscTab:CreateToggle({
	Name = "FPS Boost",
	CurrentValue = Config.FPSBoost,
	Flag = "FPSBoost",
	Callback = function(Value)
		Config.FPSBoost = Value
		ApplyFPS(Value)
	end,
})

MiscTab:CreateToggle({
	Name = "Custom Sky",
	CurrentValue = Config.SkyEnabled,
	Flag = "SkyEnabled",
	Callback = function(Value)
		Config.SkyEnabled = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Sky R",
	Range = {0, 255},
	Increment = 5,
	CurrentValue = Config.SkyR,
	Flag = "SkyR",
	Callback = function(Value)
		Config.SkyR = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Sky G",
	Range = {0, 255},
	Increment = 5,
	CurrentValue = Config.SkyG,
	Flag = "SkyG",
	Callback = function(Value)
		Config.SkyG = Value
	end,
})

MiscTab:CreateSlider({
	Name = "Sky B",
	Range = {0, 255},
	Increment = 5,
	CurrentValue = Config.SkyB,
	Flag = "SkyB",
	Callback = function(Value)
		Config.SkyB = Value
	end,
})

-- SECCIÓN SETTINGS
SettingsTab:CreateSection("CONTROLES")

SettingsTab:CreateParagraph({
	Title = "Atajos de Teclado",
	Content = "• RightShift → Toggle UI\n• E → Aimbot Hold\n• R → RajeBot Brutal Instantáneo\n• F → Fly\n• V → ESP\n• N → Noclip"
})

local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
	FOVCircle.Thickness = 1.1
	FOVCircle.NumSides = 64
	FOVCircle.Filled = false
	FOVCircle.Color = Color3.fromRGB(255, 0, 18)
	FOVCircle.Transparency = 0.4
	FOVCircle.Visible = false
end

local TargetLine = Drawing and Drawing.new("Line")
if TargetLine then
	TargetLine.Thickness = 1.2
	TargetLine.Color = Color3.fromRGB(255, 0, 18)
	TargetLine.Transparency = 0.25
	TargetLine.Visible = false
end

local NearestLineDraw = Drawing and Drawing.new("Line")
if NearestLineDraw then
	NearestLineDraw.Thickness = 1.4
	NearestLineDraw.Color = Color3.fromRGB(0, 240, 110)
	NearestLineDraw.Transparency = 0.2
	NearestLineDraw.Visible = false
end

local CrossGui = Instance.new("ScreenGui")
CrossGui.Name = "X" .. tostring(math.random(100,999))
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

-- TEXTO BAJO EL CROSSHAIR CUANDO EL RAGEBOT ESTÁ ACTIVO
local RageStatusGui = Instance.new("ScreenGui")
RageStatusGui.Name = "RageStatus"
RageStatusGui.ResetOnSpawn = false
RageStatusGui.IgnoreGuiInset = true
ProtectInstance(RageStatusGui)
pcall(function()
	if gethui then RageStatusGui.Parent = gethui() else RageStatusGui.Parent = CoreGui end
end)
if not RageStatusGui.Parent then RageStatusGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local RageStatusLabel = Instance.new("TextLabel")
RageStatusLabel.Size = UDim2.new(0, 300, 0, 30)
RageStatusLabel.Position = UDim2.new(0.5, -150, 0.5, 25)
RageStatusLabel.BackgroundTransparency = 1
RageStatusLabel.Text = ""
RageStatusLabel.Font = Enum.Font.GothamBold
RageStatusLabel.TextSize = 13
RageStatusLabel.TextStrokeTransparency = 0.2
RageStatusLabel.Visible = false
RageStatusLabel.Parent = RageStatusGui

Connections[#Connections+1] = RunService.RenderStepped:Connect(function(dt)
	fpsFrames += 1
	if tick() - fpsLast >= 1 then
		CurrentFPS = fpsFrames
		fpsFrames = 0
		fpsLast = tick()
	end

	RainbowHue = (RainbowHue + dt * 0.9) % 1
	local rainbowColor = Color3.fromHSV(RainbowHue, 1, 1)

	if Config.Ragebot and CurrentTarget then
		RageStatusLabel.Visible = true
		RageStatusLabel.TextColor3 = rainbowColor
		RageStatusLabel.Text = "rageboting: killing " .. CurrentTarget.Name
	else
		RageStatusLabel.Visible = false
	end

	if FOVCircle then
		FOVCircle.Visible = Config.FOVCircle and Loaded
		FOVCircle.Position = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
		FOVCircle.Radius = Config.FOV
	end

	if TargetLine and Config.ShowTargetLine and CurrentTarget then
		local _, _, _, head = GetChar(CurrentTarget)
		if head then
			local sp, on = Camera:WorldToViewportPoint(head.Position)
			if on then
				TargetLine.From = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
				TargetLine.To = Vector2.new(sp.X, sp.Y)
				TargetLine.Visible = true
			else
				TargetLine.Visible = false
			end
		else
			TargetLine.Visible = false
		end
	elseif TargetLine then
		TargetLine.Visible = false
	end

	if NearestLineDraw and Config.NearestLine and Loaded then
		NearestEnemy = GetNearestEnemy()
		if NearestEnemy then
			local _, _, _, head = GetChar(NearestEnemy)
			if head then
				local sp, on = Camera:WorldToViewportPoint(head.Position)
				if on then
					NearestLineDraw.From = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
					NearestLineDraw.To = Vector2.new(sp.X, sp.Y)
					NearestLineDraw.Visible = true
				else
					NearestLineDraw.Visible = false
				end
			else
				NearestLineDraw.Visible = false
			end
		else
			NearestLineDraw.Visible = false
		end
	elseif NearestLineDraw then
		NearestLineDraw.Visible = false
	end

	if Config.SkyEnabled then
		local col = Color3.fromRGB(Config.SkyR, Config.SkyG, Config.SkyB)
		Lighting.Ambient = col
		Lighting.OutdoorAmbient = col
		Lighting.FogColor = col
	end

	if Config.Crosshair then
		CrossCenter.Visible = true
		local s = Config.CrosshairSize
		CrossAngle += 7 * dt * 2.2
		local angles = {CrossAngle, CrossAngle + 1.5708, CrossAngle + 3.1416, CrossAngle + 4.7124}
		for i = 1, 4 do
			local a = angles[i]
			local line = UILines[i]
			line.Size = UDim2.fromOffset(s * 0.4, 2)
			line.BackgroundColor3 = rainbowColor
			line.Position = UDim2.fromOffset(math.cos(a) * (s * 0.62), math.sin(a) * (s * 0.62))
			line.Rotation = math.deg(a)
		end
	else
		CrossCenter.Visible = false
	end

	ApplyNoHands()
end)

-- BUCLE DE RAJEBOT HIPER-BRUTAL
Connections[#Connections+1] = RunService.Heartbeat:Connect(function()
	if not Loaded then return end
	local char, hrp, hum = GetChar()
	if not char then
		if Flying then
			if FlyVel then FlyVel:Destroy() end
			if FlyAtt then FlyAtt:Destroy() end
			Flying = false
		end
		CurrentTarget = nil
		return
	end

	if Config.Ragebot then
		local plr, part = GetBestTargetRage()
		if plr and part then
			local eChar, eHrp, eHum = GetChar(plr)
			if eHrp and eHum and eHum.Health > 0 then
				CurrentTarget = plr
				
				local targetCF = CFrame.lookAt(Camera.CFrame.Position, part.Position)
				Camera.CFrame = targetCF
				
				pcall(function()
					LocalPlayer:SetMouseIconEnabled(true)
				end)
				
				if Config.TeleportRage and hrp then
					local enemyCFrame = eHrp.CFrame
					local offsetPos = enemyCFrame.Position 
						+ (enemyCFrame.LookVector * Config.TeleportOffsetZ) 
						+ (enemyCFrame.RightVector * Config.TeleportOffsetX) 
						+ Vector3.new(0, Config.TeleportOffsetY, 0)
					hrp.CFrame = CFrame.new(offsetPos, enemyCFrame.Position)
				end
			end
		else
			CurrentTarget = nil
		end
	else
		local shouldAim = Config.Aimbot and (not Config.AimbotHold or Aiming)
		if shouldAim then
			local plr, part = GetBestTargetLegit()
			CurrentTarget = plr
			if plr and part then
				Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, part.Position)
			end
		else
			CurrentTarget = nil
		end
	end

	if Config.Fly then
		if not Flying then
			local att = Instance.new("Attachment")
			att.Parent = hrp
			local lv = Instance.new("LinearVelocity")
			lv.Attachment0 = att
			lv.MaxForce = 1e9
			lv.RelativeTo = Enum.ActuatorRelativeTo.World
			lv.Parent = hrp
			FlyAtt, FlyVel = att, lv
			Flying = true
		end
		if FlyVel then
			local move = Vector3.zero
			local cf = Camera.CFrame
			if UserInputService:IsKeyDown(Enum.KeyCode.W) then move += cf.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.S) then move -= cf.LookVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.A) then move -= cf.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.D) then move += cf.RightVector end
			if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.yAxis end
			if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.yAxis end
			local speed = Config.FlySpeed
			if Config.AntiDetection then speed = speed * SafeRandom(0.98, 1.02) end
			FlyVel.VectorVelocity = move.Magnitude > 0 and move.Unit * speed or Vector3.zero
		end
	else
		if Flying then
			if FlyVel then FlyVel:Destroy() end
			if FlyAtt then FlyAtt:Destroy() end
			Flying = false
		end
	end

	if Config.Speed then
		local spd = Config.SpeedValue
		if Config.HumanMove or Config.AntiDetection then
			spd = spd * SafeRandom(0.92, 1.05)
		end
		hum.WalkSpeed = spd
	else
		if hum.WalkSpeed ~= OriginalWalkSpeed then hum.WalkSpeed = OriginalWalkSpeed end
	end

	pcall(function()
		if hum.UseJumpPower ~= nil then
			hum.UseJumpPower = true
			hum.JumpPower = Config.InfiniteJump and Config.JumpPower or OriginalJumpPower
		end
	end)

	if Config.Noclip then
		if not Noclipping then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = false end
			end
			Noclipping = true
		end
	else
		if Noclipping then
			for _, p in ipairs(char:GetDescendants()) do
				if p:IsA("BasePart") then p.CanCollide = true end
			end
			Noclipping = false
		end
	end
end)

task.spawn(function()
	while true do
		if Loaded and Config.ESP then
			UpdateESP()
		elseif not Config.ESP then
			for plr in pairs(ESPObjects) do RemoveESP(plr) end
		end
		if Config.HitNotify then
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= LocalPlayer and IsEnemy(plr) then
					local _, _, hum = GetChar(plr)
					if hum then
						local uid = plr.UserId
						local prev = HealthCache[uid]
						local hp = hum.Health
						if prev and hp < prev and hp > 0 then
							local dmg = math.floor(prev - hp + 0.5)
							if dmg > 0 then Notify("discord.gg/tvYWHS2B8", 0.3) end
						end
						HealthCache[uid] = hp
					end
				end
			end
		end
		task.wait(Config.AntiDetection and 0.04 or 0.02)
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Config.AimKey then Aiming = true
	elseif input.KeyCode == Config.RageKey then
		Config.Ragebot = not Config.Ragebot
		Notify("RajeBot Hiper-Brutal " .. (Config.Ragebot and "ON" or "OFF"))
	elseif input.KeyCode == Config.FlyKey then Config.Fly = not Config.Fly
	elseif input.KeyCode == Config.ESPKey then Config.ESP = not Config.ESP
	elseif input.KeyCode == Config.NoclipKey then Config.Noclip = not Config.Noclip
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Config.AimKey then Aiming = false end
end)

local function OnChar(char)
	task.wait(0.05)
	local hum = char:FindFirstChildOfClass("Humanoid")
	if hum then
		OriginalWalkSpeed = hum.WalkSpeed
		pcall(function()
			if hum.UseJumpPower ~= nil then OriginalJumpPower = hum.JumpPower end
		end)
	end
	if Flying then
		if FlyVel then FlyVel:Destroy() end
		if FlyAtt then FlyAtt:Destroy() end
		Flying = false
	end
	Noclipping = false
	HandsHidden = false
	CurrentTarget = nil
end

if LocalPlayer.Character then OnChar(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(OnChar)

Players.PlayerRemoving:Connect(function(plr)
	RemoveESP(plr)
	HealthCache[plr.UserId] = nil
end)

Loaded = true

Rayfield:LoadConfiguration()
Notify("SEXUS HUB OMEGA // RAYFIELD INTERFACE LOADED", 1.5)

