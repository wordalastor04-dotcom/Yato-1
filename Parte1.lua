-- ============================================
-- PARTE 1: GUI BASE — LIMPIEZA AGRESIVA ✅
-- UI POR ENCIMA DE TODO ✅
-- MENÚ MÁS PEQUEÑO ✅
-- MENÚ + BOLA BAJADOS ✅
-- SIN MULTIPLICACIÓN ✅
-- + SECCIÓN ATAQUE AGREGADA ✅
-- + SECCIÓN JUEGOS AGREGADA (VACÍA) ✅
-- + CONTADOR DE FPS Y PING (SOBRESALE EN 999) ✅
-- + PESTAÑAS BAJADAS PARA NO CHOCAR CON EL AVATAR ✅
-- + CARGA AUTOMÁTICA DE LA PARTE 0 (ADMIN PANEL) ✅
-- ============================================
local P = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local pl = P.LocalPlayer
local Cam = workspace.CurrentCamera

-- ============================================
-- ✅ LIMPIEZA AGRESIVA (busca en todas partes)
-- ============================================
local function limpiarGuis(nombre)
    pcall(function()
        for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if gui.Name == nombre then gui:Destroy() end
        end
    end)
    pcall(function()
        for _, gui in ipairs(pl.PlayerGui:GetChildren()) do
            if gui.Name == nombre then gui:Destroy() end
        end
    end)
    if gethui then
        pcall(function()
            for _, gui in ipairs(gethui():GetChildren()) do
                if gui.Name == nombre then gui:Destroy() end
            end
        end)
    end
    pcall(function()
        for _, gui in ipairs(game:GetDescendants()) do
            if gui:IsA("ScreenGui") and gui.Name == nombre then
                gui:Destroy()
            end
        end
    end)
end

limpiarGuis("YH")
limpiarGuis("YatoAchievement")
limpiarGuis("YatoFpsPing")

-- ESTADO GLOBAL
if not _G.YatoHubSharedState then
    _G.YatoHubSharedState = {
        SHIELD = false, ["INFINITE JUMP"] = false, NOCLIP = false, FLY = false,
        ["SPEED BOOST"] = false, speedVal = 16, ["JUMP BOOST"] = false, jumpVal = 50,
        FLASH = false, ["GOD MODE"] = false, ["TP Save"] = false, ["TP List"] = false,
        ["tptool"] = false, Invisible = false, ["ESP LINEAS"] = false, ["ESP AUTÓNOMO"] = false,
        SHADERS = false, ["EMOTES FE"] = true, ["CABEZA ANIM"] = false, ["HEADLESS ANIM"] = false,
        DOMINIO = false, HEADLESS = false, KORBLOX = false, FULLBRIGHT = false, ["NO FOG"] = false
    }
end
local State = _G.YatoHubSharedState

if not _G.YatoAimbotData then
    _G.YatoAimbotData = {Enabled = false, FOV = 5, ShowFOV = true}
end
local AData = _G.YatoAimbotData

-- NOTIFICACIÓN DE CARGA
local function showAchievementNotification()
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "YatoAchievement"
    notifGui.ResetOnSpawn = false
    notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notifGui.DisplayOrder = 998
    notifGui.IgnoreGuiInset = true
    if syn and syn.protect_gui then
        syn.protect_gui(notifGui)
        notifGui.Parent = game:GetService("CoreGui")
    elseif gethui then
        notifGui.Parent = gethui()
    else
        notifGui.Parent = pl.PlayerGui
    end
    
    local notifFrame = Instance.new("Frame", notifGui)
    notifFrame.Size = UDim2.new(0, 320, 0, 80)
    notifFrame.Position = UDim2.new(1, 20, 0.85, 0)
    notifFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    notifFrame.BackgroundTransparency = 0.1
    notifFrame.BorderSizePixel = 0
    Instance.new("UICorner", notifFrame).CornerRadius = UDim.new(0, 12)
    
    local notifStroke = Instance.new("UIStroke", notifFrame)
    notifStroke.Thickness = 2
    notifStroke.Color = Color3.fromRGB(180, 180, 190)
    notifStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    local trophyIcon = Instance.new("ImageLabel", notifFrame)
    trophyIcon.Size = UDim2.new(0, 50, 0, 50)
    trophyIcon.Position = UDim2.new(0, 15, 0.5, -25)
    trophyIcon.BackgroundTransparency = 1
    trophyIcon.Image = "rbxassetid://7733993311"
    trophyIcon.ImageColor3 = Color3.fromRGB(255, 215, 0)
    
    local titleLabel = Instance.new("TextLabel", notifFrame)
    titleLabel.Size = UDim2.new(0.7, 0, 0, 20)
    titleLabel.Position = UDim2.new(0, 75, 0, 12)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "LOGRO DESBLOQUEADO"
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.TextSize = 12
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    local msgLabel = Instance.new("TextLabel", notifFrame)
    msgLabel.Size = UDim2.new(0.7, 0, 0, 30)
    msgLabel.Position = UDim2.new(0, 75, 0, 32)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = "GRACIAS POR USAR\nNUESTROS SERVICIOS"
    msgLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    msgLabel.TextSize = 14
    msgLabel.Font = Enum.Font.GothamBold
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.TextYAlignment = Enum.TextYAlignment.Top
    
    notifFrame:TweenPosition(
        UDim2.new(1, -340, 0.85, 0),
        Enum.EasingDirection.Out,
        Enum.EasingStyle.Quart,
        0.6,
        true
    )
    
    task.delay(4, function()
        notifFrame:TweenPosition(
            UDim2.new(1, 20, 0.85, 0),
            Enum.EasingDirection.In,
            Enum.EasingStyle.Quart,
            0.5,
            true,
            function() notifGui:Destroy() end
        )
    end)
end

showAchievementNotification()

-- ✅ GUI PRINCIPAL
local M = Instance.new("ScreenGui")
M.Name = "YH"
M.ResetOnSpawn = false
M.DisplayOrder = 999
M.IgnoreGuiInset = true
M.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if syn and syn.protect_gui then
    syn.protect_gui(M)
    M.Parent = game:GetService("CoreGui")
elseif gethui then
    M.Parent = gethui()
else
    M.Parent = pl.PlayerGui
end

-- 📐 MARCO PRINCIPAL
local C = Instance.new("Frame")
C.Size = UDim2.new(0.55, 0, 0.68, 0)
C.Position = UDim2.new(0.225, 0, 0.16, 0)
C.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
C.BorderSizePixel = 0
C.Parent = M
C.ZIndex = 1
Instance.new("UICorner", C).CornerRadius = UDim.new(0, 14)

local US = Instance.new("UIStroke", C)
US.Thickness = 3
US.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- BARRA SUPERIOR
local BT = Instance.new("Frame", C)
BT.Size = UDim2.new(1, 0, 0.08, 0)
BT.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
BT.BackgroundTransparency = 0.5
BT.ZIndex = 3
Instance.new("UICorner", BT).CornerRadius = UDim.new(0, 14)

local TM = Instance.new("TextLabel", BT)
TM.Size = UDim2.new(0.78, 0, 0.6, 0)
TM.Position = UDim2.new(0.11, 0, 0.05, 0)
TM.BackgroundTransparency = 1
TM.Text = "Yato mods"
TM.TextScaled = true
TM.Font = Enum.Font.Fantasy
TM.TextColor3 = Color3.fromRGB(255, 255, 255)
TM.ZIndex = 4

local ST = Instance.new("TextLabel", BT)
ST.Size = UDim2.new(0.78, 0, 0.35, 0)
ST.Position = UDim2.new(0.11, 0, 0.62, 0)
ST.BackgroundTransparency = 1
ST.Text = "v2026.09.30 by Yato"
ST.TextColor3 = Color3.fromRGB(110, 110, 110)
ST.TextScaled = true
ST.Font = Enum.Font.Gotham
ST.ZIndex = 4

-- BOTONES CERRAR / MINIMIZAR
local BC = Instance.new("TextButton", BT)
BC.Size = UDim2.new(0.09, 0, 0.8, 0)
BC.Position = UDim2.new(0.01, 0, 0.1, 0)
BC.BackgroundTransparency = 1
BC.Text = "X"
BC.TextColor3 = Color3.new(1, 1, 1)
BC.Font = Enum.Font.Fantasy
BC.TextScaled = true
BC.ZIndex = 4
BC.Name = "CloseBtn"
Instance.new("UICorner", BC).CornerRadius = UDim.new(0, 6)

local BN = Instance.new("TextButton", BT)
BN.Size = UDim2.new(0.09, 0, 0.8, 0)
BN.Position = UDim2.new(0.9, 0, 0.1, 0)
BN.BackgroundTransparency = 1
BN.Text = "-"
BN.TextColor3 = Color3.new(1, 1, 1)
BN.Font = Enum.Font.Fantasy
BN.TextScaled = true
BN.ZIndex = 4
BN.Name = "MinimizeBtn"
Instance.new("UICorner", BN).CornerRadius = UDim.new(0, 6)

-- PANEL LATERAL
local BL = Instance.new("Frame", C)
BL.Size = UDim2.new(0.3, 0, 0.92, 0)
BL.Position = UDim2.new(0, 0, 0.08, 0)
BL.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
BL.BackgroundTransparency = 0.3
BL.BorderSizePixel = 0
BL.ClipsDescendants = true
BL.ZIndex = 1
BL.Name = "SidePanel"

local SideBgImg = Instance.new("ImageLabel", BL)
SideBgImg.Size = UDim2.new(1, 0, 1, 0)
SideBgImg.Image = "rbxassetid://12980029938"
SideBgImg.ScaleType = Enum.ScaleType.Crop
SideBgImg.BackgroundTransparency = 1
SideBgImg.ZIndex = 1

local ProfileImg = Instance.new("ImageLabel", BL)
ProfileImg.Size = UDim2.new(0.85, 0, 0.28, 0)
ProfileImg.Position = UDim2.new(0.075, 0, 0.03, 0)
ProfileImg.Image = "rbxassetid://17306766936"
ProfileImg.BackgroundTransparency = 1
ProfileImg.ScaleType = Enum.ScaleType.Fit
ProfileImg.ZIndex = 2
Instance.new("UICorner", ProfileImg).CornerRadius = UDim.new(0, 12)

-- ÁREA DE CONTENIDO
local AO = Instance.new("Frame", C)
AO.Size = UDim2.new(0.7, 0, 0.92, 0)
AO.Position = UDim2.new(0.3, 0, 0.08, 0)
AO.BackgroundTransparency = 1
AO.ZIndex = 2
AO.Name = "ContentArea"

local MainImg = Instance.new("ImageLabel", AO)
MainImg.Size = UDim2.new(1, 0, 1, 0)
MainImg.Position = UDim2.new(0, 0, 0, 0)
MainImg.Image = "rbxassetid://11878291121"
MainImg.ScaleType = Enum.ScaleType.Crop
MainImg.BackgroundTransparency = 1
MainImg.ZIndex = 1

local TS = Instance.new("TextLabel", AO)
TS.Size = UDim2.new(0.9, 0, 0.06, 0)
TS.Position = UDim2.new(0.05, 0, 0.01, 0)
TS.BackgroundTransparency = 1
TS.Text = "INICIO"
TS.TextScaled = true
TS.Font = Enum.Font.Fantasy
TS.TextColor3 = Color3.fromRGB(255, 255, 255)
TS.TextXAlignment = Enum.TextXAlignment.Left
TS.ZIndex = 3
TS.Name = "TitleLabel"

-- CREAR PESTAÑAS
local function mkS(v, h)
    local s = Instance.new("ScrollingFrame", AO)
    s.Size = UDim2.new(1, 0, 0.94, 0)
    s.Position = UDim2.new(0, 0, 0.06, 0)
    s.BackgroundTransparency = 1
    s.ScrollBarThickness = 4
    s.CanvasSize = UDim2.new(0, 0, 0, h or 560)
    s.Visible = v
    s.ZIndex = 3
    return s
end

local MC = mkS(true, 750) MC.Name = "MainContent"
local TC = mkS(false, 350) TC.Name = "TPContent"
local EC = mkS(false, 400) EC.Name = "ESPContent"
local VC = mkS(false, 450) VC.Name = "VisualContent"
local AC = mkS(false, 500) AC.Name = "AttackContent"
local JC = mkS(false, 600) JC.Name = "JuegosContent"
local CC = mkS(false, 200) CC.Name = "ContactContent"
local DC = mkS(false, 250) DC.Name = "KeyboardContent"

-- FUNCIÓN BOTONES TOGGLE
local function tog(par, yp, txt, def, isLoadstring, cb)
    if State[txt] == nil then State[txt] = def end
    local currentStatus = State[txt]
    
    local b = Instance.new("TextButton", par)
    b.Size = UDim2.new(0.92, 0, 0, 32)
    b.Position = UDim2.new(0.04, 0, 0, yp)
    b.BackgroundTransparency = 1
    b.Text = "  " .. txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 14
    b.Font = Enum.Font.Fantasy
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.ZIndex = 4
    b.Name = "Toggle_" .. txt:gsub(" ", "_")
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    
    local bs = Instance.new("UIStroke", b)
    bs.Color = Color3.new(1, 1, 1)
    bs.Thickness = 1
    bs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    local sw = Instance.new("Frame", b)
    sw.Size = UDim2.new(0, 34, 0, 18)
    sw.Position = UDim2.new(1, -45, 0.5, -9)
    sw.BackgroundColor3 = currentStatus and Color3.fromRGB(80, 80, 90) or Color3.fromRGB(70, 70, 80)
    sw.ZIndex = 4
    Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)
    
    local ci = Instance.new("Frame", sw)
    ci.Size = UDim2.new(0, 14, 0, 14)
    ci.Position = currentStatus and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    ci.BackgroundColor3 = Color3.new(1, 1, 1)
    ci.ZIndex = 4
    Instance.new("UICorner", ci).CornerRadius = UDim.new(1, 0)
    
    b.MouseButton1Click:Connect(function()
        currentStatus = not currentStatus
        State[txt] = currentStatus
        cb(currentStatus)
        sw.BackgroundColor3 = currentStatus and Color3.fromRGB(80, 80, 90) or Color3.fromRGB(70, 70, 80)
        ci:TweenPosition(currentStatus and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7), "Out", "Quad", 0.2, true)
    end)
    
    if currentStatus and (not isLoadstring or txt == "EMOTES FE") then
        task.spawn(function() cb(true) end)
    end
    
    return b
end

-- ============================================
-- ✅ PESTAÑAS LATERALES (BAJADAS)
-- ============================================
local secs = {"INICIO", "TP", "ESP", "ATAQUE", "VISUAL", "JUEGOS", "CONTACT", "KEYBOARD"}
local conts = {MC, TC, EC, AC, VC, JC, CC, DC}
local btns = {}

for i, n in ipairs(secs) do
    local b = Instance.new("TextButton", BL)
    b.Size = UDim2.new(0.86, 0, 0.055, 0)
    -- ✅ CAMBIO: Empezamos en 0.35 en vez de 0.28 para no chocar con el avatar
    b.Position = UDim2.new(0.07, 0, 0.35 + (i - 1) * 0.065, 0)
    b.BackgroundTransparency = 1
    b.Text = n
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.Font = Enum.Font.Fantasy
    b.TextScaled = true
    b.ZIndex = 2
    b.Name = "Tab_" .. n
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 7)
    Instance.new("UIPadding", b).PaddingLeft = UDim.new(0.1, 0)
    
    local s = Instance.new("UIStroke", b)
    s.Thickness = 1
    s.Color = Color3.new(1, 1, 1)
    s.Transparency = 0.8
    
    btns[i] = b
    b.MouseButton1Click:Connect(function()
        for j, cc in ipairs(conts) do cc.Visible = (j == i) end
        TS.Text = n
        for k, btn in ipairs(btns) do btn.BackgroundTransparency = 1 end
        b.BackgroundTransparency = 0.5
    end)
end

-- BOTÓN FLOTANTE MINIMIZADO
local PA = Instance.new("TextButton", M)
PA.Size = UDim2.new(0, 50, 0, 50)
PA.Position = UDim2.new(0.5, -25, 0.16, 0)
PA.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
PA.Text = ""
PA.Visible = false
PA.Name = "FloatButton"
PA.ZIndex = 100
Instance.new("UICorner", PA).CornerRadius = UDim.new(1, 0)

local PAIcon = Instance.new("ImageLabel", PA)
PAIcon.Size = UDim2.new(1, 0, 1, 0)
PAIcon.Image = "rbxassetid://10039648046"
PAIcon.BackgroundTransparency = 1
Instance.new("UICorner", PAIcon).CornerRadius = UDim.new(1, 0)

local PAS = Instance.new("UIStroke", PA)
PAS.Thickness = 3
PAS.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- EFECTO BRILLO
local bwValue = 0
local bwDirection = 1
RS.RenderStepped:Connect(function()
    bwValue = bwValue + (0.02 * bwDirection)
    if bwValue >= 1 then bwValue = 1 bwDirection = -1
    elseif bwValue <= 0 then bwValue = 0 bwDirection = 1 end
    local col = Color3.new(bwValue, bwValue, bwValue)
    US.Color = col
    PAS.Color = col
    TM.TextColor3 = col
    TS.TextColor3 = col
end)

-- FUNCIÓN ARRASTRAR
local function makeDraggable(gui, handle)
    local active, startInput, startPos = false, nil, nil
    handle.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            active = true
            startInput = i.Position
            startPos = gui.Position
        end
    end)
    UIS.InputChanged:Connect(function(i)
        if active and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
            local d = i.Position - startInput
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            active = false
        end
    end)
end

makeDraggable(C, BT)
makeDraggable(PA, PA)

-- ACCIONES BOTONES
BC.MouseButton1Click:Connect(function() M:Destroy() end)
BN.MouseButton1Click:Connect(function() C.Visible = false PA.Visible = true end)
PA.MouseButton1Click:Connect(function() PA.Visible = false C.Visible = true end)

-- ============================================
-- ✅ CONTADOR DE FPS Y PING FLOTANTE (SOBRESALE)
-- ============================================
local Stats = game:GetService("Stats")
local RunService = game:GetService("RunService")

local fpsPingGui = Instance.new("ScreenGui")
fpsPingGui.Name = "YatoFpsPing"
fpsPingGui.ResetOnSpawn = false
fpsPingGui.DisplayOrder = 999
fpsPingGui.IgnoreGuiInset = true
fpsPingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

if syn and syn.protect_gui then
    syn.protect_gui(fpsPingGui)
    fpsPingGui.Parent = game:GetService("CoreGui")
elseif gethui then
    fpsPingGui.Parent = gethui()
else
    fpsPingGui.Parent = pl.PlayerGui
end

local pingFrame = Instance.new("Frame", fpsPingGui)
pingFrame.Name = "PingFrame"
pingFrame.Size = UDim2.new(0, 110, 0, 32)
pingFrame.Position = UDim2.new(0, 10, 0, 10)
pingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
pingFrame.BackgroundTransparency = 0.3
pingFrame.BorderSizePixel = 0
pingFrame.Active = true
Instance.new("UICorner", pingFrame).CornerRadius = UDim.new(0, 8)

local pingStroke = Instance.new("UIStroke", pingFrame)
pingStroke.Thickness = 1
pingStroke.Color = Color3.fromRGB(255, 255, 255)

local fpsLabel = Instance.new("TextLabel", pingFrame)
fpsLabel.Size = UDim2.new(0.5, 0, 1, 0)
fpsLabel.Position = UDim2.new(0, 5, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "0 FPS"
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 11
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

local pingLabel = Instance.new("TextLabel", pingFrame)
pingLabel.Size = UDim2.new(0.5, 0, 1, 0)
pingLabel.Position = UDim2.new(0.5, -5, 0, 0)
pingLabel.BackgroundTransparency = 1
pingLabel.Text = "0 ms"
pingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextSize = 11
pingLabel.TextXAlignment = Enum.TextXAlignment.Right

local dragFps = false
local dragStartFps = nil
local startPosFps = nil

pingFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragFps = true
        dragStartFps = input.Position
        startPosFps = pingFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragFps = false
            end
        end)
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragFps and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStartFps
        pingFrame.Position = UDim2.new(startPosFps.X.Scale, startPosFps.X.Offset + delta.X, startPosFps.Y.Scale, startPosFps.Y.Offset + delta.Y)
    end
end)

local frames = 0
local timeElapsed = 0
RunService.RenderStepped:Connect(function(dt)
    frames = frames + 1
    timeElapsed = timeElapsed + dt
    if timeElapsed >= 0.5 then
        local fps = math.floor(frames / timeElapsed)
        fpsLabel.Text = fps .. " FPS"
        frames = 0
        timeElapsed = 0
    end
end)

task.spawn(function()
    while task.wait(1) do
        local ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        pingLabel.Text = math.floor(ping) .. " ms"
    end
end)

-- ============================================
-- COMPARTIR TODO CON PARTES SIGUIENTES
-- ============================================
_G.YatoHubUI = {
    M = M, C = C, AO = AO, 
    MC = MC, TC = TC, EC = EC, AC = AC, VC = VC, JC = JC, CC = CC, DC = DC,
    TS = TS, BL = BL, tog = tog, State = State, AData = AData,
    Cam = Cam, P = P, pl = pl, UIS = UIS, RS = RS,
    btns = btns, secs = secs, conts = conts,
    FpsPingGui = fpsPingGui
}
_G.YatoHubLoaded = true
print("[Yato Mods] ✅ Parte 1 cargada — Contador de FPS/Ping y pestañas bajadas")

-- ============================================
-- ✅ CARGA AUTOMÁTICA DE LA PARTE 0 (ADMIN PANEL)
-- ============================================
task.spawn(function()
    task.wait(3) -- Esperar a que la UI de la Parte 1 esté completamente lista
    print("[Yato Mods] ⏳ Cargando Parte 0 (Admin Panel)...")
    local ok, err = pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/2arY4pSm"))()
    end)
    if not ok then
        warn("[Yato Mods] ❌ Error al cargar Parte 0: " .. tostring(err))
    else
        print("[Yato Mods] ✅ Parte 0 cargada correctamente")
    end
end)
