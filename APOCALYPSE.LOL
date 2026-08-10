local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local CONFIG_FOLDER = "ApocalypseConfigs"
local AUTOLOAD_FILE = CONFIG_FOLDER .. "/autoload.json"

pcall(function()
	if not isfolder(CONFIG_FOLDER) then makefolder(CONFIG_FOLDER) end
end)

local function GetAutoloadConfig()
	local success, result = pcall(function()
		if isfile(AUTOLOAD_FILE) then
			return HttpService:JSONDecode(readfile(AUTOLOAD_FILE))
		end
	end)
	if success and type(result) == "table" then
		return result.Name
	end
	return nil
end

local function SaveAutoloadConfig(name)
	pcall(function()
		writefile(AUTOLOAD_FILE, HttpService:JSONEncode({Name = name}))
	end)
end

local function ClearAutoloadConfig()
	pcall(function()
		if isfile(AUTOLOAD_FILE) then
			delfile(AUTOLOAD_FILE)
		end
	end)
end

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
	bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	bg.BorderSizePixel = 0
	bg.Parent = loadGui

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 50)
	title.Position = UDim2.new(0, 0, 0.35, 0)
	title.BackgroundTransparency = 1
	title.Text = "APOCALYPSE.LOL [ULTRA-GODMODE OMNI-WALLBANG v10.5]"
	title.TextColor3 = Color3.fromRGB(255, 0, 0)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 28
	title.Parent = bg

	local discordText = Instance.new("TextLabel")
	discordText.Size = UDim2.new(1, 0, 0, 24)
	discordText.Position = UDim2.new(0, 0, 0.42, 0)
	discordText.BackgroundTransparency = 1
	discordText.Text = "discord.gg/tvYWHS2B8"
	discordText.TextColor3 = Color3.fromRGB(180, 180, 200)
	discordText.Font = Enum.Font.GothamMedium
	discordText.TextSize = 14
	discordText.Parent = bg

	local status = Instance.new("TextLabel")
	status.Size = UDim2.new(1, 0, 0, 28)
	status.Position = UDim2.new(0, 0, 0.49, 0)
	status.BackgroundTransparency = 1
	status.Text = "Inyectando Motor Hyper-Rage Extremo con Wallbang Absoluto..."
	status.TextColor3 = Color3.fromRGB(240, 240, 255)
	status.Font = Enum.Font.Gotham
	status.TextSize = 15
	status.Parent = bg

	local barBg = Instance.new("Frame")
	barBg.Size = UDim2.new(0, 280, 0, 8)
	barBg.Position = UDim2.new(0.5, -140, 0.57, 0)
	barBg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	barBg.BorderSizePixel = 0
	barBg.Parent = bg
	Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

	local barFill = Instance.new("Frame")
	barFill.Size = UDim2.new(0, 0, 1, 0)
	barFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	barFill.BorderSizePixel = 0
	barFill.Parent = barBg
	Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)

	local percent = Instance.new("TextLabel")
	percent.Size = UDim2.new(1, 0, 0, 20)
	percent.Position = UDim2.new(0, 0, 0.61, 0)
	percent.BackgroundTransparency = 1
	percent.Text = "0%"
	percent.TextColor3 = Color3.fromRGB(180, 180, 200)
	percent.Font = Enum.Font.Gotham
	percent.TextSize = 13
	percent.Parent = bg

	local startTime = tick()
	local duration = 0.015

	while tick() - startTime < duration do
		local progress = math.clamp((tick() - startTime) / duration, 0, 1)
		barFill.Size = UDim2.new(progress, 0, 1, 0)
		percent.Text = math.floor(progress * 100) .. "%"
		task.wait()
	end
	loadGui:Destroy()
end

local Config = {
	Wallbang = true,
	TeleportWallbang = true,
	SilentAim = true,
	FFAMode = false,
	TeleportOffsetY = 2,
	TeleportOffsetX = 0,
	TeleportOffsetZ = 2,
	TeleportSmoothing = 1.0,
	Prediction = true,
	PredictionFactor = 0.15,
	TargetPriority = "Distancia",
	NoSpread = true,
	NoRecoil = true,
	RapidFire = true,
	InfiniteAmmo = true,
	AutoReload = true,
	ExtendedRange = true,
	AimPartDynamic = true,
	FOV = 99999,
	TeamCheck = true,
	VisibleCheck = false,
	ShowTargetLine = true,
	NearestLine = true,
	HitNotify = true,
	
	VoidSpam = false,
	AntiKatana = false,
	AntiShield = false,
	
	Noclip = false,
	InfiniteJump = false,
	
	ESP = false,
	ESPName = true,
	ESPDistance = true,
	ESPHealth = true,
	ESPTeamColor = true,
	FOVCircle = true,
	Crosshair = false,
	CrosshairSize = 30,
	CrosshairSpeed = 2.2,
	CrosshairGap = 0.62,
	
	AntiDetection = false,
	SkyEnabled = false,
	SkyR = 0, SkyG = 0, SkyB = 0,
}

local Connections = {}
local ESPObjects = {}
local HealthCache = {}
local Noclipping = false
local Loaded = false
local CurrentTarget = nil
local NearestEnemy = nil
local RainbowHue = 0
local CrossAngle = 0
local fpsFrames, fpsLast, CurrentFPS = 0, tick(), 60

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
	Name = "Apocalypse.lol [ULTRA-GODMODE OMNI-WALLBANG]",
	LoadingTitle = "Apocalypse.lol",
	LoadingSubtitle = "Hyper-Aggressive God-Wallbang Ultimate Edition",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = CONFIG_FOLDER,
		FileName = "APOCALYPSEConfig"
	},
	Discord = {
		Enabled = false,
		Invite = "noinvite",
		RememberJoins = true
	},
	KeySystem = false,
})

local MainTab = Window:CreateTab("Combate", 401)
local MoveTab = Window:CreateTab("Movimiento", 402)
local ESPTab = Window:CreateTab("ESP", 403)
local MiscTab = Window:CreateTab("Misc", 404)
local SettingsTab = Window:CreateTab("Settings", 405)
local InfoTab = Window:CreateTab("Info Wallbang", 406)

local function ProtectInstance(obj)
	pcall(function()
		if Config.AntiDetection then
			if syn and syn.protect_gui then syn.protect_gui(obj) end
			if gethui then obj.Parent = gethui()
			elseif get_hidden_gui then obj.Parent = get_hidden_gui() end
		end
	end)
end

InfoTab:CreateSection("¿QUÉ ES UN RAGEBOT AGRESIVO CON WALLBANG?")

InfoTab:CreateParagraph({
	Title = "Conceptos Fundamentales",
	Content = "1. Un ragebot agresivo con wallbang es un sistema automatizado utilizado en videojuegos.\n2. Su objetivo es proporcionar una ventaja significativa al jugador.\n3. El término “ragebot” describe un sistema de apuntado y ejecución de acciones extremadamente agresivo.\n4. El término “wallbang” hace referencia a la capacidad de atacar a un objetivo a través de paredes u otros obstáculos.\n5. En otras palabras, el sistema puede tratar ciertos elementos del entorno como si no impidieran el ataque.\n6. Un ragebot de este tipo puede estar compuesto por varios módulos."
})

InfoTab:CreateParagraph({
	Title = "Módulos y Componentes",
	Content = "7. El primero es el detector de objetivos.\n8. Este módulo se encarga de identificar jugadores presentes en la partida.\n9. No se limita únicamente a los jugadores que están directamente a la vista.\n10. También puede considerar jugadores situados detrás de determinados obstáculos.\n11. A continuación se encuentra el selector de objetivos.\n12. Su función es determinar qué jugador debe recibir prioridad.\n13. Si existen múltiples objetivos, el sistema puede elegir uno en función de reglas predefinidas.\n14. También existe el sistema de apuntado.\n15. Este módulo dirige la mira hacia el objetivo seleccionado.\n16. En un ragebot agresivo, este proceso puede ejecutarse de forma extremadamente rápida."
})

InfoTab:CreateParagraph({
	Title = "Sistema de Wallbang y Suavizado Adaptativo",
	Content = "17. Otro componente relevante es el sistema de wallbang.\n18. Este módulo está relacionado con los objetivos que se encuentran detrás de obstáculos.\n19. Su función conceptual es determinar si un objetivo puede ser alcanzado a través de dichos obstáculos.\n20. No todos los objetos o superficies se comportan de la misma manera.\n21. Su comportamiento depende de las reglas del videojuego.\n22. Algunos elementos bloquean completamente la acción.\n23. Otros permiten que ciertas acciones los atraviesen.\n24. Por ello, el sistema debe analizar las condiciones del entorno del juego."
})

InfoTab:CreateParagraph({
	Title = "Verificación, Predicción y Operación",
	Content = "25. También puede incluirse una verificación de visibilidad.\n26. Esta evalúa si existe una línea directa entre el jugador y el objetivo.\n27. En un sistema con wallbang, esta verificación puede interpretarse de forma distinta.\n28. El sistema puede considerar objetivos incluso cuando existen obstáculos que normalmente bloquearían la visión.\n29. Otro componente puede encargarse del cálculo de distancia.\n30. Este determina qué tan lejos se encuentra el objetivo.\n31. También puede existir un sistema de priorización.\n32. Este define qué objetivo debe ser considerado primero.\n33. Puede combinar información como distancia, posición y estado del objetivo.\n34. Otro módulo puede ser la selección de zona.\n35. Este determina qué parte del personaje se toma como referencia para el objetivo.\n36. También puede existir un sistema de activación.\n37. Este define en qué momento el sistema debe reaccionar.\n38. La predicción puede ser otro componente.\n39. Su función conceptual es analizar el movimiento de los jugadores.\n40. Esto permite anticipar desplazamientos del objetivo."
})

InfoTab:CreateParagraph({
	Title = "Ejecución Conjunta y Comportamiento",
	Content = "41. Todos estos componentes pueden trabajar de manera conjunta.\n42. Primero se detectan los posibles objetivos.\n43. Posteriormente se analiza su ubicación.\n44. Luego se verifica si son objetivos válidos.\n45. Después se les asigna una prioridad.\n46. El sistema de apuntado selecciona el objetivo con mayor prioridad.\n47. Si existe un obstáculo, interviene el módulo de wallbang.\n48. Este determina si el objetivo puede ser considerado a través del obstáculo.\n49. Por ello, un ragebot con wallbang puede percibirse como más agresivo.\n50. No se limita a objetivos completamente expuestos.\n51. También puede considerar objetivos parcialmente ocultos o detrás de estructuras.\n52. El sistema no opera con razonamiento humano.\n53. Simplemente ejecuta las reglas programadas.\n54. Es comparable a un conjunto de instrucciones ejecutadas por un sistema informático.\n55. Si se cumplen determinadas condiciones, responde en consecuencia.\n56. Por esta razón, distintos ragebots pueden comportarse de manera diferente.\n57. Algunos pueden tener funcionalidades limitadas.\n58. Otros pueden integrar múltiples sistemas simultáneamente.\n59. Un sistema más avanzado puede analizar objetivos de forma continua.\n60. También puede cambiar de objetivo cuando las condiciones varían.\n61. Puede evaluar posiciones, distancias y obstáculos de forma constante.\n62. Todo esto puede realizarse de manera automatizada."
})

InfoTab:CreateParagraph({
	Title = "Consideraciones Finales y Resumen",
	Content = "63. Por este motivo se utiliza el término “agresivo”.\n64. Indica una respuesta rápida y una búsqueda constante de objetivos.\n65. El wallbang añade una funcionalidad adicional al sistema.\n66. Permite considerar situaciones en las que existen obstáculos entre los jugadores.\n67. Sin embargo, su funcionamiento exacto depende del videojuego.\n68. Cada juego implementa reglas distintas para colisiones y disparos.\n69. En entornos competitivos, este tipo de automatización suele considerarse una forma de trampa.\n70. Puede otorgar una ventaja injusta frente a otros jugadores.\n71. También puede conllevar sanciones si es detectado por sistemas antitrampas.\n72. En resumen, combina detección, selección, apuntado y análisis de obstáculos.\n73. El ragebot automatiza el comportamiento ofensivo del jugador.\n74. El wallbang se relaciona con la interacción a través de obstáculos.\n75. En pocas palabras: es un sistema que detecta objetivos, los selecciona y automatiza el apuntado, incluso en situaciones donde existen paredes u otros obstáculos entre el jugador y el objetivo, diseñado para operar de la forma más fluida, precisa y letal posible."
})

local function Notify(text, t)
	Rayfield:Notify({
		Title = "Apocalypse.lol",
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

local function HasProfileDisplay(char)
	if not char then return false end
	for _, desc in ipairs(char:GetDescendants()) do
		if desc:IsA("BillboardGui") or desc:IsA("ImageLabel") or desc:IsA("ImageButton") then
			if desc.Name ~= "E" then
				return true
			end
		end
	end
	local head = char:FindFirstChild("Head")
	if head then
		for _, child in ipairs(head:GetChildren()) do
			if child:IsA("BillboardGui") or child:IsA("SurfaceGui") then
				return true
			end
		end
	end
	return false
end

local function CanTeleportTo(plr)
	if plr == LocalPlayer then return false end
	local char = plr.Character
	if char and HasProfileDisplay(char) then
		return false
	end

	if Config.FFAMode then return true end
	if not Config.TeamCheck then return true end
	
	local myTeam = LocalPlayer.Team
	local targetTeam = plr.Team
	if not myTeam or not targetTeam then return true end

	local myColor = myTeam.TeamColor and myTeam.TeamColor.Name or ""
	local targetColor = targetTeam.TeamColor and targetTeam.TeamColor.Name or ""
	local myName = string.lower(myTeam.Name)
	local targetName = string.lower(targetTeam.Name)

	local isMyPurple = myColor:find("Purple") or myColor:find("Violet") or myName:find("morado") or myName:find("purple")
	local isMyYellow = myColor:find("Yellow") or myColor:find("amarillo") or myName:find("yellow")

	local isTargetPurple = targetColor:find("Purple") or targetColor:find("Violet") or targetName:find("morado") or targetName:find("purple")
	local isTargetYellow = targetColor:find("Yellow") or targetColor:find("amarillo") or targetName:find("yellow")

	if isMyPurple and isTargetYellow then return true end
	if isMyYellow and isTargetPurple then return true end

	if not (isMyPurple or isMyYellow) then
		return myTeam ~= targetTeam
	end

	return false
end

local function AI_DetectThreat(char)
	if not char then return false, false end
	
	local hasKatana = false
	local hasShield = false
	
	for _, item in ipairs(char:GetChildren()) do
		if item:IsA("Tool") or item:IsA("Model") then
			local name = string.lower(item.Name)
			if name:find("katana") or name:find("sword") or name:find("blade") or name:find("cuchillo") then
				hasKatana = true
			end
			if name:find("shield") or name:find("escudo") or name:find("riot") or name:find("barrier") then
				hasShield = true
			end
		end
	end
	
	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		for _, anim in ipairs(humanoid:GetPlayingAnimationTracks()) do
			local animName = string.lower(anim.Animation.AnimationId or "")
			if animName:find("katana") or animName:find("sword") then
				hasKatana = true
			end
			if animName:find("shield") or animName:find("escudo") then
				hasShield = true
			end
		end
	end
	
	return hasKatana, hasShield
end

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

-- Integración del nuevo Wallbang con Raycast
local WallbangSettings = {
    MaxDistance = 5000,
    VerticalOffset = 7,
}

local function getRaycastParams()
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    
    local excludeList = {LocalPlayer.Character}
    if LocalPlayer.Character then
        for _, child in ipairs(LocalPlayer.Character:GetChildren()) do
            if child:IsA("Accessory") or child:IsA("Tool") then
                table.insert(excludeList, child)
            end
        end
    end
    
    params.FilterDescendantsInstances = excludeList
    params.IgnoreWater = true
    return params
end

local function executeAggressiveWallbang()
    if not Config.Wallbang then return nil end
    
    local mouse = LocalPlayer:GetMouse()
    local origin = Camera.CFrame.Position
    local direction = (mouse.Hit.Position - origin).Unit * WallbangSettings.MaxDistance
    
    local raycastResult = workspace:Raycast(origin, direction, getRaycastParams())
    
    if raycastResult then
        local hitPart = raycastResult.Instance
        if hitPart and not hitPart.Parent:FindFirstChild("Humanoid") then
            local penetrationPoint = raycastResult.Position + (direction.Unit * WallbangSettings.VerticalOffset)
            return penetrationPoint
        end
    end
    
    return nil
end

local function GetBestTargetRage()
	local bestPlr, bestPart, bestScore = nil, nil, -math.huge
	local center = Vector2.new(Camera.ViewportSize.X * 0.5, Camera.ViewportSize.Y * 0.5)
	local _, myHRP = GetChar()
	if not myHRP then return nil, nil end
	local myPos = myHRP.Position

	for _, plr in ipairs(Players:GetPlayers()) do
		if CanTeleportTo(plr) then
			local char, hrp, hum = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				if not HasProfileDisplay(char) then
					local kDetect, sDetect = AI_DetectThreat(char)
					local blockedByThreat = false
					if Config.AntiKatana and kDetect then blockedByThreat = true end
					if Config.AntiShield and sDetect then blockedByThreat = true end
					
					if not blockedByThreat then
						local part = GetAimPart(char)
						if part then
							local sp = Camera:WorldToViewportPoint(part.Position)
							local dist3D = (hrp.Position - myPos).Magnitude
							local dist2D = (Vector2.new(sp.X, sp.Y) - center).Magnitude
							
							local score = 0
							if Config.TargetPriority == "Distancia" then
								score = 10000000 - dist3D
							elseif Config.TargetPriority == "Menos Vida" then
								score = 10000000 - (hum.Health * 1000)
							else
								score = 10000000 - dist2D
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
	end
	return bestPlr, bestPart
end

local function GetNearestEnemy()
	local bestPlr, bestDist = nil, math.huge
	local _, myHRP = GetChar()
	if not myHRP then return nil end
	local myPos = myHRP.Position
	for _, plr in ipairs(Players:GetPlayers()) do
		if CanTeleportTo(plr) then
			local char, hrp, hum = GetChar(plr)
			if char and hrp and hum and hum.Health > 0 then
				if not HasProfileDisplay(char) then
					local dist = (hrp.Position - myPos).Magnitude
					if dist < bestDist then
						bestDist = dist
						bestPlr = plr
					end
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
	name.TextColor3 = Color3.fromRGB(255, 0, 0)
	name.TextStrokeTransparency = 0.2
	name.Font = Enum.Font.GothamBold
	name.TextSize = 11
	name.Parent = bill

	local dist = Instance.new("TextLabel")
	dist.Size = UDim2.new(1, 0, 0, 10)
	dist.Position = UDim2.new(0, 0, 0, 12)
	dist.BackgroundTransparency = 1
	dist.Text = ""
	dist.TextColor3 = Color3.fromRGB(150, 150, 175)
	dist.Font = Enum.Font.Gotham
	dist.TextSize = 9
	dist.Parent = bill

	local hpText = Instance.new("TextLabel")
	hpText.Size = UDim2.new(1, 0, 0, 10)
	hpText.Position = UDim2.new(0, 0, 0, 22)
	hpText.BackgroundTransparency = 1
	hpText.Text = ""
	hpText.TextColor3 = Color3.fromRGB(0, 255, 100)
	hpText.Font = Enum.Font.GothamBold
	hpText.TextSize = 9
	hpText.Parent = bill

	local bg = Instance.new("Frame")
	bg.Size = UDim2.new(0.8, 0, 0, 4)
	bg.Position = UDim2.new(0.1, 0, 0, 34)
	bg.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	bg.BorderSizePixel = 0
	bg.Parent = bill
	Instance.new("UICorner", bg).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(1, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
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
		if not CanTeleportTo(plr) then
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
			local g = 255 * pct
			data.Fill.BackgroundColor3 = Color3.fromRGB(r, g, 0)
		else
			data.HPText.Text = ""
			data.Fill.Size = UDim2.new(0, 0, 1, 0)
		end
	end
end

MainTab:CreateSection("COMBATE")

MainTab:CreateToggle({
	Name = "Enabled",
	CurrentValue = Config.Wallbang,
	Flag = "Wallbang",
	Callback = function(Value)
		Config.Wallbang = Value
	end,
})

MainTab:CreateToggle({
	Name = "HYPER-VOID OMNI-WALLBANG (Bypass Absoluto Brutal)",
	CurrentValue = Config.TeleportWallbang,
	Flag = "TeleportWallbang",
	Callback = function(Value)
		Config.TeleportWallbang = Value
	end,
})

MainTab:CreateToggle({
	Name = "Silent Aim (Disparo Silencioso Letal)",
	CurrentValue = Config.SilentAim,
	Flag = "SilentAim",
	Callback = function(Value)
		Config.SilentAim = Value
	end,
})

MainTab:CreateToggle({
	Name = "ffa mode (free for all)",
	CurrentValue = Config.FFAMode,
	Flag = "FFAMode",
	Callback = function(Value)
		Config.FFAMode = Value
	end,
})

MainTab:CreateToggle({
	Name = "Void Spam",
	CurrentValue = Config.VoidSpam,
	Flag = "VoidSpam",
	Callback = function(Value)
		Config.VoidSpam = Value
	end,
})

MainTab:CreateToggle({
	Name = "Predicción de Movimiento",
	CurrentValue = Config.Prediction,
	Flag = "Prediction",
	Callback = function(Value)
		Config.Prediction = Value
	end,
})

MainTab:CreateSlider({
	Name = "Factor de Predicción",
	Range = {0.05, 0.4},
	Increment = 0.01,
	CurrentValue = Config.PredictionFactor,
	Flag = "PredictionFactor",
	Callback = function(Value)
		Config.PredictionFactor = Value
	end,
})

MainTab:CreateDropdown({
	Name = "Prioridad de Objetivo",
	Options = {"Distancia", "Menos Vida", "FOV"},
	CurrentOption = Config.TargetPriority,
	MultipleOptions = false,
	Flag = "TargetPriority",
	Callback = function(Option)
		if type(Option) == "table" then
			Config.TargetPriority = Option[1]
		else
			Config.TargetPriority = Option
		end
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

MainTab:CreateSlider({
	Name = "Velocidad de Posicionamiento TP",
	Range = {0.1, 1.0},
	Increment = 0.05,
	CurrentValue = Config.TeleportSmoothing,
	Flag = "TeleportSmoothing",
	Callback = function(Value)
		Config.TeleportSmoothing = Value
	end,
})

MainTab:CreateToggle({
	Name = "Anti Katana (IA Detect)",
	CurrentValue = Config.AntiKatana,
	Flag = "AntiKatana",
	Callback = function(Value)
		Config.AntiKatana = Value
	end,
})

MainTab:CreateToggle({
	Name = "Anti Escudo / Riot (IA Detect)",
	CurrentValue = Config.AntiShield,
	Flag = "AntiShield",
	Callback = function(Value)
		Config.AntiShield = Value
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
	Range = {1000, 99999},
	Increment = 500,
	CurrentValue = Config.FOV,
	Flag = "FOV",
	Callback = function(Value)
		Config.FOV = Value
	end,
})

MainTab:CreateSection("SCRIPTS EXTERNOS")

MainTab:CreateButton({
	Name = "Aimbot",
	Callback = function()
		pcall(function()
			loadstring(game:HttpGet("https://github.com/vianeyfijosamunoz-svg/APOCALYPSE-AIMBOT/raw/refs/heads/main/APOCALYPSE.LOLONLY-AIMBOT-SUPORTED-%20+250%20GAMES"))()
		end)
	end,
})

MainTab:CreateButton({
	Name = "SkinChanger",
	Callback = function()
		pcall(function()
			loadstring(game:HttpGet("https://rawscripts.net/raw/RIVALS-FREE-Roblox-Skin-Changer-Script-keyless-2026-208386"))()
		end)
	end,
})

MainTab:CreateSection("MECANICAS DE ARMAS")

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

MoveTab:CreateSection("MOVIMIENTO")

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

ESPTab:CreateSection("ESP")

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

ESPTab:CreateSlider({
	Name = "Crosshair Speed",
	Range = {0.1, 10},
	Increment = 0.1,
	CurrentValue = Config.CrosshairSpeed,
	Flag = "CrosshairSpeed",
	Callback = function(Value)
		Config.CrosshairSpeed = Value
	end,
})

ESPTab:CreateSlider({
	Name = "Crosshair Gap (Separación)",
	Range = {0.1, 2.0},
	Increment = 0.05,
	CurrentValue = Config.CrosshairGap,
	Flag = "CrosshairGap",
	Callback = function(Value)
		Config.CrosshairGap = Value
	end,
})

ESPTab:CreateSection("PROTECCIÓN & VISUALES")

ESPTab:CreateToggle({
	Name = "Target Line",
	CurrentValue = Config.ShowTargetLine,
	Flag = "ShowTargetLine",
	Callback = function(Value)
		Config.ShowTargetLine = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Nearest Enemy Line",
	CurrentValue = Config.NearestLine,
	Flag = "NearestLine",
	Callback = function(Value)
		Config.NearestLine = Value
	end,
})

ESPTab:CreateToggle({
	Name = "Hit Notify",
	CurrentValue = Config.HitNotify,
	Flag = "HitNotify",
	Callback = function(Value)
		Config.HitNotify = Value
	end,
})

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

SettingsTab:CreateSection("GESTIÓN DE CONFIGURACIONES")

local ConfigNameInput = ""
local SelectedConfigItem = "Ninguna"
local ConfigListDropdown = nil

local function GetConfigList()
	local list = {}
	pcall(function()
		if isfolder(CONFIG_FOLDER) then
			for _, file in ipairs(listfiles(CONFIG_FOLDER)) do
				local name = file:match("([^/]+)$")
				name = name:match("([^\]+)$") or name
				if name ~= "autoload.json" then
					name = name:gsub("%.json$", "")
					table.insert(list, name)
				end
			end
		end
	end)
	if #list == 0 then
		table.insert(list, "Ninguna")
	end
	return list
end

SettingsTab:CreateInput({
	Name = "Nombre de Config",
	PlaceholderText = "Escribe el nombre aquí...",
	NumbersOnly = false,
	CharacterLimit = 30,
	OnEnter = false,
	RemoveTextAfterFocusLost = false,
	Callback = function(Text)
		ConfigNameInput = Text
	end,
})

SettingsTab:CreateButton({
	Name = "Crear Config",
	Callback = function()
		if ConfigNameInput and ConfigNameInput ~= "" then
			local success, err = pcall(function()
				writefile(CONFIG_FOLDER .. "/" .. ConfigNameInput .. ".json", HttpService:JSONEncode(Config))
			end)
			if success then
				Notify("Config '" .. ConfigNameInput .. "' creada correctamente", 1.5)
				if ConfigListDropdown then
					ConfigListDropdown:Refresh(GetConfigList(), true)
				end
			else
				warn("Error creando config:", err)
				Notify("Error al crear la config", 1.5)
			end
		else
			Notify("Escribe un nombre válido", 1.5)
		end
	end,
})

ConfigListDropdown = SettingsTab:CreateDropdown({
	Name = "Lista de Configs",
	Options = GetConfigList(),
	CurrentOption = "Ninguna",
	MultipleOptions = false,
	Flag = "ConfigListDropdown",
	Callback = function(Option)
		if type(Option) == "table" then
			SelectedConfigItem = Option[1]
		else
			SelectedConfigItem = Option
		end
	end,
})

SettingsTab:CreateButton({
	Name = "Load Config",
	Callback = function()
		if SelectedConfigItem and SelectedConfigItem ~= "Ninguna" then
			local success = pcall(function()
				local path = CONFIG_FOLDER .. "/" .. SelectedConfigItem .. ".json"
				if isfile(path) then
					local data = HttpService:JSONDecode(readfile(path))
					for k, v in pairs(data) do
						Config[k] = v
					end
				end
			end)
			if success then
				Notify("Config '" .. SelectedConfigItem .. "' cargada", 1.5)
			else
				Notify("Error al cargar la config", 1.5)
			end
		else
			Notify("Selecciona una config válida", 1.5)
		end
	end,
})

SettingsTab:CreateButton({
	Name = "Delete Config",
	Callback = function()
		if SelectedConfigItem and SelectedConfigItem ~= "Ninguna" then
			pcall(function()
				local path = CONFIG_FOLDER .. "/" .. SelectedConfigItem .. ".json"
				if isfile(path) then
					delfile(path)
				end
			end)
			Notify("Config '" .. SelectedConfigItem .. "' eliminada", 1.5)
			SelectedConfigItem = "Ninguna"
			if ConfigListDropdown then
				ConfigListDropdown:Refresh(GetConfigList(), true)
			end
		else
			Notify("Selecciona una config válida", 1.5)
		end
	end,
})

SettingsTab:CreateButton({
	Name = "Autoload Config",
	Callback = function()
		SelectedConfigItem = SelectedConfigItem
		if SelectedConfigItem and SelectedConfigItem ~= "Ninguna" then
			SaveAutoloadConfig(SelectedConfigItem)
			Notify("Autoload establecido en: " .. SelectedConfigItem, 1.5)
		else
			Notify("Selecciona una config válida para autoload", 1.5)
		end
	end,
})

SettingsTab:CreateButton({
	Name = "Clear Autoload",
	Callback = function()
		ClearAutoloadConfig()
		Notify("Autoload limpiado / desactivado", 1.5)
	end,
})

local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
	FOVCircle.Thickness = 1.1
	FOVCircle.NumSides = 64
	FOVCircle.Filled = false
	FOVCircle.Color = Color3.fromRGB(255, 0, 0)
	FOVCircle.Transparency = 0.4
	FOVCircle.Visible = false
end

local TargetLine = Drawing and Drawing.new("Line")
if TargetLine then
	TargetLine.Thickness = 1.2
	TargetLine.Color = Color3.fromRGB(255, 0, 0)
	TargetLine.Transparency = 0.25
	TargetLine.Visible = false
end

local NearestLineDraw = Drawing and Drawing.new("Line")
if NearestLineDraw then
	NearestLineDraw.Thickness = 1.4
	NearestLineDraw.Color = Color3.fromRGB(0, 255, 100)
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

local WatermarkGui = Instance.new("ScreenGui")
WatermarkGui.Name = "WatermarkGui"
WatermarkGui.ResetOnSpawn = false
WatermarkGui.IgnoreGuiInset = true
ProtectInstance(WatermarkGui)
pcall(function()
	if gethui then WatermarkGui.Parent = gethui() else WatermarkGui.Parent = CoreGui end
end)
if not WatermarkGui.Parent then WatermarkGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local WatermarkLabel = Instance.new("TextLabel")
WatermarkLabel.Size = UDim2.new(0, 0, 0, 16)
WatermarkLabel.Position = UDim2.new(0, 2, 0, 2)
WatermarkLabel.BackgroundTransparency = 0.25
WatermarkLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
WatermarkLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
WatermarkLabel.Font = Enum.Font.GothamBold
WatermarkLabel.TextSize = 9
WatermarkLabel.TextStrokeTransparency = 0.3
WatermarkLabel.AutomaticSize = Enum.AutomaticSize.X
WatermarkLabel.Parent = WatermarkGui
Instance.new("UICorner", WatermarkLabel).CornerRadius = UDim.new(0, 3)

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
RageStatusLabel.Position = UDim2.new(0.5, -150,.5, 25)
RageStatusLabel.BackgroundTransparency = 1
RageStatusLabel.Text = ""
RageStatusLabel.Font = Enum.Font.GothamBold
RageStatusLabel.TextSize = 13
RageStatusLabel.TextStrokeTransparency = 0.2
RageStatusLabel.Visible = false
RageStatusLabel.Parent = RageStatusGui

pcall(function()
	local mt = getrawmetatable(game)
	setreadonly(mt, false)
	local oldIndex = mt.__index
	mt.__index = newcclosure(function(self, idx)
		if Config.Wallbang and Config.SilentAim and not checkcaller() then
			if self == mouse and (idx == "Hit" or idx == "Target") then
				local plr, part = GetBestTargetRage()
				if part then
					local eChar, eHrp = GetChar(plr)
					if eHrp then
						local tPos = part.Position
						if Config.Prediction then
							tPos = tPos + (eHrp.AssemblyLinearVelocity * Config.PredictionFactor)
						end
						if idx == "Hit" then
							return CFrame.new(tPos)
						elseif idx == "Target" then
							return part
						end
					end
				end
			end
		end
		return oldIndex(self, idx)
	end)
	setreadonly(mt, true)
end)

Connections[#Connections+1] = RunService.RenderStepped:Connect(function(dt)
	fpsFrames += 1
	if tick() - fpsLast >= 1 then
		CurrentFPS = fpsFrames
		fpsFrames = 0
		fpsLast = tick()
	end

	RainbowHue = (RainbowHue + dt * 0.9) % 1
	local rainbowColor = Color3.fromHSV(RainbowHue, 1, 1)

	WatermarkLabel.Text = "APOCALYPSE.LOL [ULTRA-GODMODE OMNI-WALLBANG] | " .. CurrentFPS + math.random(-1, 1) .. " FPS"

	if Config.Wallbang and CurrentTarget then
		RageStatusLabel.Visible = true
		RageStatusLabel.TextColor3 = rainbowColor
		RageStatusLabel.Text = "targeting: " .. CurrentTarget.Name
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
		CrossAngle += 7 * dt * Config.CrosshairSpeed
		local angles = {CrossAngle, CrossAngle + 1.5708, CrossAngle + 3.1416, CrossAngle + 4.7124}
		for i = 1, 4 do
			local a = angles[i]
			local line = UILines[i]
			line.Size = UDim2.fromOffset(s * 0.4, 2)
			line.BackgroundColor3 = rainbowColor
			line.Position = UDim2.fromOffset(math.cos(a) * (s * Config.CrosshairGap), math.sin(a) * (s * Config.CrosshairGap))
			line.Rotation = math.deg(a)
		end
	else
		CrossCenter.Visible = false
	end
end)

task.spawn(function()
	while true do
		task.wait(0)
		if Loaded and Config.VoidSpam then
			local enemiesAlive = false
			for _, plr in ipairs(Players:GetPlayers()) do
				if CanTeleportTo(plr) then
					local char, _, hum = GetChar(plr)
					if char and hum and hum.Health > 0 then
						if not HasProfileDisplay(char) then
							enemiesAlive = true
							break
						end
					end
				end
			end
			
			if not (Config.Wallbang and enemiesAlive) then
				local _, hrp = GetChar()
				if hrp then
					pcall(function()
						hrp.CFrame = CFrame.new(hrp.Position.X, -500, hrp.Position.Z)
						hrp.AssemblyLinearVelocity = Vector3.new(0, -100000000000, 0)
					end)
					task.wait(0)
					pcall(function()
						local _, currentHrp = GetChar()
						if currentHrp then
							currentHrp.CFrame = CFrame.new(currentHrp.Position.X, 500, currentHrp.Position.Z)
							currentHrp.AssemblyLinearVelocity = Vector3.new(0, 100000000000, 0)
						end
					end)
				end
			end
		end
	end
end)

RunService:BindToRenderStep("ApocalypseOmniWallbang", Enum.RenderPriority.First.Value + 999, function(dt)
	if not Loaded then return end
	local char, hrp, hum = GetChar()
	if not char then
		CurrentTarget = nil
		return
	end

	if Config.Wallbang then
		local targetPosOverride = executeAggressiveWallbang()
		local plr, part = GetBestTargetRage()
		if plr and part then
			local eChar, eHrp, eHum = GetChar(plr)
			if eHrp and eHum and eHum.Health > 0 then
				CurrentTarget = plr
				
				local targetPos = targetPosOverride or part.Position
				if Config.Prediction then
					targetPos = targetPos + (eHrp.AssemblyLinearVelocity * Config.PredictionFactor)
				end

				if not Config.SilentAim then
					local targetCF = CFrame.lookAt(Camera.CFrame.Position, targetPos)
					Camera.CFrame = targetCF
				end
				
				pcall(function()
					LocalPlayer:SetMouseIconEnabled(true)
				end)
				
				if Config.TeleportWallbang and hrp then
					local enemyCFrame = eHrp.CFrame
					local enemyVel = eHrp.AssemblyLinearVelocity
					local predictedPos = enemyCFrame.Position + (enemyVel * (Config.Prediction and Config.PredictionFactor or 0.15))
					
					local targetPosOffset = predictedPos 
						- (enemyCFrame.LookVector * Config.TeleportOffsetZ) 
						- (enemyCFrame.RightVector * Config.TeleportOffsetX) 
						+ Vector3.new(0, Config.TeleportOffsetY, 0)
					
					if Config.TeleportSmoothing >= 1.0 then
						hrp.CFrame = CFrame.new(targetPosOffset, predictedPos)
					else
						local smoothFactor = math.clamp(dt * (Config.TeleportSmoothing * 350), 0.8, 1)
						hrp.CFrame = hrp.CFrame:Lerp(CFrame.new(targetPosOffset, predictedPos), smoothFactor)
					end
					
					hrp.AssemblyLinearVelocity = enemyVel + Vector3.new(0, 45, 0)
					hrp.AssemblyAngularVelocity = Vector3.zero
					
					pcall(function()
						for _, child in ipairs(char:GetDescendants()) do
							if child:IsA("BasePart") then
								child.CanCollide = false
								child.AssemblyLinearVelocity = Vector3.zero
							end
						end
					end)
				end
			end
		else
			CurrentTarget = nil
		end
	else
		CurrentTarget = nil
	end
end)

Connections[#Connections+1] = RunService.Heartbeat:Connect(function()
	if not Loaded then return end
	local char, hrp, hum = GetChar()
	if not char then return end

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
				if CanTeleportTo(plr) then
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
		task.wait(0.01)
	end
end)

UserInputService.InputBegan:Connect(function(input, gp)
	if gp then return end
	if input.KeyCode == Enum.KeyCode.R then
		Config.Wallbang = not Config.Wallbang
		Notify("Wallbang " .. (Config.Wallbang and "ON" or "OFF"))
	elseif input.KeyCode == Enum.KeyCode.V then Config.ESP = not Config.ESP
	elseif input.KeyCode == Enum.KeyCode.N then Config.Noclip = not Config.Noclip
	end
end)

local function OnChar(char)
	task.wait(0.05)
	Noclipping = false
	CurrentTarget = nil
end

if LocalPlayer.Character then OnChar(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(OnChar)

Players.PlayerRemoving:Connect(function(plr)
	RemoveESP(plr)
	HealthCache[plr.UserId] = nil
end)

Loaded = true

local autoloadName = GetAutoloadConfig()
if autoloadName then
	pcall(function()
		local path = CONFIG_FOLDER .. "/" .. autoloadName .. ".json"
		if isfile(path) then
			local data = HttpService:JSONDecode(readfile(path))
			for k, v in pairs(data) do
				Config[k] = v
			end
		end
	end)
	Notify("Autoload cargado: " .. autoloadName, 2)
else
	Notify("Apocalypse.lol [ULTRA-GODMODE OMNI-WALLBANG] loaded successfully", 1.5)
end

