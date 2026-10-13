local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- ============================================
-- PARTE 2: ATAQUE REORGANIZADO ✅
-- + ESP ARMAS (pistola=azul, cuchillo=rojo)
-- + AIMBOT CAMERA LOCK + FOV
-- + ANTI FLING (integrable desde toggle)
-- + ATAQUE AUTOMÁTICO (antes TP JUGADOR)
-- ============================================

-- CARGA PARTE 1
loadstring(game:HttpGet("https://pastebin.com/raw/pkk2QY2J"))()

local t = 0
while not _G.YatoHubLoaded and t < 15 do
    task.wait(0.1)
    t = t + 0.1
end

if not _G.YatoHubLoaded then
    warn("[Yato Mods] ❌ Error: Parte 1 no cargó")
    return
end
print("[Yato Mods] ✅ Parte 1 detectada — cargando funciones...")

local UI = _G.YatoHubUI
local MC, TC, EC, AC, VC, CC, DC = UI.MC, UI.TC, UI.EC, UI.AC, UI.VC, UI.CC, UI.DC
local JC = UI.JC
local TS, tog, State, AData = UI.TS, UI.tog, UI.State, UI.AData
local P, pl, RS, Cam, UIS = UI.P, UI.pl, UI.RS, UI.Cam, UI.UIS

UI.OriginalTexts = {
    Tabs = {}, Toggles = {}, Buttons = {}, Placeholders = {}
}

-- ============================================
-- ✅ COLOR RGB ANIMADO
-- ============================================
local HUE_ACTUAL = 0
local VELOCIDAD_RGB = 0.5

task.spawn(function()
    while task.wait(0.03) do
        HUE_ACTUAL = (HUE_ACTUAL + VELOCIDAD_RGB * 0.03) % 1
    end
end)

local function obtenerColorRGB()
    return Color3.fromHSV(HUE_ACTUAL, 1, 1)
end

local function obtenerColorRGBOscuro()
    local c = obtenerColorRGB()
    return Color3.new(c.R * 0.7, c.G * 0.7, c.B * 0.7)
end

-- ============================================
-- ✅ EFECTO RGB BLANCO ↔ NEGRO
-- ============================================
local uiElementsBN = {}

local function applyRGBEffectBN(instance)
    local stroke = instance:FindFirstChildOfClass("UIStroke")
    if not stroke then
        stroke = Instance.new("UIStroke", instance)
        stroke.Thickness = 1
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    end
    stroke.Color = Color3.fromRGB(255, 255, 255)
    table.insert(uiElementsBN, stroke)
    return stroke
end

task.spawn(function()
    while task.wait(0.08) do
        local tiempo = tick() * 1.5
        local v = (math.sin(tiempo) + 1) / 2
        local c = Color3.new(v, v, v)
        for _, s in pairs(uiElementsBN) do
            if s and s.Parent and not s:GetAttribute("ColorFijo") then
                s.Color = c
            end
        end
    end
end)

-- ============================================
-- ✅ EFECTO MORADO
-- ============================================
local uiElements = {}

local function applyRGBEffect(instance, colorOverride)
    local stroke = instance:FindFirstChildOfClass("UIStroke")
    if not stroke then
        stroke = Instance.new("UIStroke", instance)
        stroke.Thickness = 2
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    end
    local color = colorOverride or Color3.fromRGB(138, 43, 226)
    stroke.Color = color
    if colorOverride then
        stroke:SetAttribute("ColorFijo", true)
    end
    table.insert(uiElements, stroke)
    return stroke
end

task.spawn(function()
    while task.wait(0.1) do
        local c = Color3.fromRGB(138, 43, 226)
        for _, s in pairs(uiElements) do
            if s and s.Parent then
                if not s:GetAttribute("ColorFijo") then
                    s.Color = c
                end
            end
        end
    end
end)

-- ============================================
-- ✅ SISTEMA DE 2 COLUMNAS
-- ============================================
local contadores = {}

local function crearToggle(par, txt, def, isLoadstring, cb)
    if not contadores[par] then contadores[par] = 0 end
    local idx = contadores[par]
    contadores[par] = idx + 1
    local col = idx % 2
    local fila = math.floor(idx / 2)
    local posX = (col == 0) and 0.02 or 0.51
    local posY = 8 + fila * 32

    if State[txt] == nil then State[txt] = def end
    local currentStatus = State[txt]

    local b = Instance.new("TextButton", par)
    b.Size = UDim2.new(0.47, 0, 0, 26)
    b.Position = UDim2.new(posX, 0, 0, posY)
    b.BackgroundTransparency = 1
    b.Text = "  " .. txt
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 9
    b.Font = Enum.Font.Fantasy
    b.TextXAlignment = Enum.TextXAlignment.Left
    b.ZIndex = 4
    b.Name = "Toggle_" .. txt:gsub(" ", "_")
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    local bs = Instance.new("UIStroke", b)
    bs.Color = Color3.new(1, 1, 1)
    bs.Thickness = 1
    bs.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    table.insert(uiElementsBN, bs)

    if not isLoadstring then
        local sw = Instance.new("Frame", b)
        sw.Size = UDim2.new(0, 22, 0, 13)
        sw.Position = UDim2.new(1, -26, 0.5, -6)
        sw.BackgroundColor3 = currentStatus and Color3.fromRGB(80, 80, 90) or Color3.fromRGB(70, 70, 80)
        sw.ZIndex = 4
        Instance.new("UICorner", sw).CornerRadius = UDim.new(1, 0)

        local ci = Instance.new("Frame", sw)
        ci.Size = UDim2.new(0, 10, 0, 10)
        ci.BackgroundColor3 = Color3.new(1, 1, 1)
        ci.ZIndex = 4
        Instance.new("UICorner", ci).CornerRadius = UDim.new(1, 0)

        if currentStatus then
            ci.Position = UDim2.new(1, -12, 0.5, -5)
        else
            ci.Position = UDim2.new(0, 2, 0.5, -5)
        end

        b:SetAttribute("HasSwitch", true)
        sw.Name = "SwitchFrame"
        ci.Name = "SwitchCircle"
    end

    b.MouseButton1Click:Connect(function()
        currentStatus = not currentStatus
        State[txt] = currentStatus

        if b:GetAttribute("HasSwitch") then
            local sw = b:FindFirstChild("SwitchFrame")
            local ci = sw and sw:FindFirstChild("SwitchCircle")
            if sw and ci then
                sw.BackgroundColor3 = currentStatus and Color3.fromRGB(80, 80, 90) or Color3.fromRGB(70, 70, 80)
                local destino = currentStatus 
                    and UDim2.new(1, -12, 0.5, -5)
                    or UDim2.new(0, 2, 0.5, -5)
                ci:TweenPosition(destino, Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
            end
        end

        task.spawn(function() cb(currentStatus) end)
    end)

    if currentStatus and (not isLoadstring or txt == "EMOTES") then
        task.spawn(function() cb(true) end)
    end

    return b
end

tog = function(par, yp, txt, def, isLoadstring, cb)
    local cleanTxt = txt:gsub("^%s+", "")
    UI.OriginalTexts.Toggles[cleanTxt] = cleanTxt
    return crearToggle(par, txt, def, isLoadstring, cb)
end

-- ============================================
-- PESTAÑA: INICIO
-- ============================================
tog(MC, 8, "XRAY", false, false, function(s) State["XRAY"] = s end)

tog(MC, 8, "ESCUDO", false, false, function(s)
    local ch = pl.Character
    if not ch then return end
    if s then Instance.new("ForceField", ch)
    else local ff = ch:FindFirstChildOfClass("ForceField"); if ff then ff:Destroy() end end
end)

tog(MC, 8, "SALTO INFINITO", false, false, function(s) State["INFINITE JUMP"] = s end)
tog(MC, 8, "TRASPASAR PAREDES", false, false, function(s) State.NOCLIP = s end)

tog(MC, 8, "VOLAR", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Homelander-script-242112"))() end
end)

tog(MC, 8, "FLY V3 YATO", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/Whv7pR0x"))() end
end)

tog(MC, 8, "SUPER VELOCIDAD", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FE-Ultimate-Flash-Script-217588"))() end
end)

tog(MC, 8, "INMORTAL", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/5KEBKGuz"))() end
end)

tog(MC, 8, "DOMINIO", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/gWEz2vJj"))() end
end)

tog(MC, 8, "DESTRUIR", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/t8Qq4Bpr"))() end
end)

contadores[MC] = 12

local TBox = Instance.new("TextBox", MC)
TBox.Size = UDim2.new(0.45, 0, 0, 22)
TBox.Position = UDim2.new(0.02, 0, 0, 168)
TBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
TBox.Text = tostring(State.speedVal)
TBox.PlaceholderText = "Velocidad..."
TBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TBox.Font = Enum.Font.Fantasy; TBox.TextSize = 10; TBox.ZIndex = 10
Instance.new("UICorner", TBox).CornerRadius = UDim.new(0, 6)
applyRGBEffectBN(TBox)
UI.OriginalTexts.Placeholders.Speed = TBox.PlaceholderText
TBox:GetPropertyChangedSignal("Text"):Connect(function()
    local n = tonumber(TBox.Text); if n then State.speedVal = math.clamp(n, 1, 500) end
end)

local JBox = Instance.new("TextBox", MC)
JBox.Size = UDim2.new(0.45, 0, 0, 22)
JBox.Position = UDim2.new(0.51, 0, 0, 168)
JBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
JBox.Text = tostring(State.jumpVal)
JBox.PlaceholderText = "Salto..."
JBox.TextColor3 = Color3.fromRGB(255, 255, 255)
JBox.Font = Enum.Font.Fantasy; JBox.TextSize = 10; JBox.ZIndex = 10
Instance.new("UICorner", JBox).CornerRadius = UDim.new(0, 6)
applyRGBEffectBN(JBox)
UI.OriginalTexts.Placeholders.Jump = JBox.PlaceholderText
JBox:GetPropertyChangedSignal("Text"):Connect(function()
    local n = tonumber(JBox.Text); if n then State.jumpVal = math.clamp(n, 1, 500) end
end)

tog(MC, 8, "VELOCIDAD", false, false, function(s) State["SPEED BOOST"] = s end)
tog(MC, 8, "SALTO MEJORADO", false, false, function(s) State["JUMP BOOST"] = s end)

-- ============================================
-- PESTAÑA: TP
-- ============================================
tog(TC, 8, "TP PLAYER", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/8RpBVd98"))() end
end)

tog(TC, 8, "TP CLIC", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Marts-teleport-tool-80005"))() end
end)

tog(TC, 8, "INVISIBLE", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/PZ39Z5f6"))() end
end)

tog(TC, 8, "GUARDAR POSICIÓN", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/ruqnZWhG"))() end
end)

tog(TC, 8, "ANTI CAÍDA", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/3Geh2VuW"))() end
end)

tog(TC, 8, "LANZAR TOCANDO", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/ZDFgNyVp"))() end
end)

-- ✅ ANTI FLING
tog(TC, 8, "ANTI FLING", false, false, function(s)
    State["ANTI FLING"] = s
    if _G.YatoAntiFling then
        _G.YatoAntiFling.Toggle(s)
    end
end)

-- ============================================
-- PESTAÑA: ATAQUE
-- ============================================
-- ✅ RENOMBRADO: "TP JUGADOR" → "ATAQUE AUTOMÁTICO"
tog(AC, 8, "ATAQUE AUTOMÁTICO", false, true, function(s)
    if s then
        if not _G.TPVictim then
            loadstring(game:HttpGet("https://pastebin.com/raw/q76yFcjz"))()
            local w=0; while not _G.TPVictim and w<5 do task.wait(0.1); w=w+0.1 end
        end
        if _G.TPVictim then _G.TPVictim:Toggle(true) end
    else
        if _G.TPVictim then _G.TPVictim:Toggle(false) end
    end
end)

tog(AC, 8, "ATAQUE EN ÁREA", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/R2Hby0Hm"))() end
end)

tog(AC, 8, "FAKE LAG", false, true, function(s)
    if s then loadstring(game:HttpGet("https://pastebin.com/raw/ixSuGhU8"))() end
end)

-- ============================================
-- PESTAÑA: ESP / AIMBOT
-- ============================================
tog(EC, 8, "AIMBOT", false, false, function(s)
    State["AIMBOT"] = s
end)

tog(EC, 8, "AIMBOT SILENT", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Universal-Shooter-Hub-137311"))() end
end)

State["FOV"] = false
tog(EC, 8, "VER ZONA", false, false, function(s) State["FOV"] = s end)

contadores[EC] = 6

local FOVCircle = nil
local useDrawing = false
pcall(function()
    local test = Drawing.new("Circle")
    if test then
        test:Remove()
        useDrawing = true
    end
end)

if useDrawing then
    FOVCircle = Drawing.new("Circle")
    FOVCircle.Thickness    = 1.5
    FOVCircle.NumSides     = 64
    FOVCircle.Radius       = 200
    FOVCircle.Filled       = false
    FOVCircle.Transparency = 0.9
    FOVCircle.Color        = Color3.fromRGB(138, 43, 226)
    FOVCircle.Visible      = false
end

local fB = Instance.new("TextBox", EC)
fB.Size = UDim2.new(0.45, 0, 0, 22)
fB.Position = UDim2.new(0.02, 0, 0, 72)
fB.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
fB.Text = "200"
fB.PlaceholderText = "FOV..."
fB.TextColor3 = Color3.fromRGB(255, 255, 255)
fB.Font = Enum.Font.Fantasy; fB.TextSize = 10; fB.ZIndex = 4
Instance.new("UICorner", fB).CornerRadius = UDim.new(0, 6)
applyRGBEffectBN(fB)
UI.OriginalTexts.Placeholders.FOV = fB.PlaceholderText

_G.YatoFOVRadius = 200

local fA = Instance.new("TextButton", EC)
fA.Size = UDim2.new(0.45, 0, 0, 22)
fA.Position = UDim2.new(0.51, 0, 0, 72)
fA.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
fA.Text = "AJUSTAR"
fA.TextColor3 = Color3.fromRGB(255, 255, 255)
fA.Font = Enum.Font.Fantasy; fA.TextSize = 10; fA.ZIndex = 4
Instance.new("UICorner", fA).CornerRadius = UDim.new(0, 6)
applyRGBEffectBN(fA)
UI.OriginalTexts.Buttons[fA.Text] = fA.Text
fA.MouseButton1Click:Connect(function()
    local n = tonumber(fB.Text)
    if n then
        _G.YatoFOVRadius = math.clamp(n, 10, 1000)
        if FOVCircle then FOVCircle.Radius = _G.YatoFOVRadius end
    end
end)

tog(EC, 8, "LÍNEAS JUGADORES", false, false, function(s)
    State["ESP LINEAS"] = s
    if not s then
        for _, h in pairs(UI.espHL or {}) do h:Destroy() end
        UI.espHL = {}
    end
end)

tog(EC, 8, "VER A TRAVÉS", false, false, function(s) State["ESP AUTÓNOMO"] = s end)

tog(EC, 8, "ESP ARMAS", false, false, function(s)
    State["ESP ARMAS"] = s
    if not s then
        for _, h in pairs(UI.espWeaponHL or {}) do pcall(function() h:Destroy() end) end
        UI.espWeaponHL = {}
    end
end)

-- ============================================
-- PESTAÑA: VISUAL
-- ============================================
tog(VC, 8, "GRÁFICOS MEJORADOS", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Shaders-4k-48907"))() end
end)

local function cargarEmotes()
    task.wait(0.3)
    print("[Yato Mods] 🎭 Cargando Emotes automáticamente...")
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-emotes-136121"))()
    end)
end

tog(VC, 8, "EMOTES", true, true, function(s)
    if s then pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fe-emotes-136121"))() end) end
end)

task.spawn(cargarEmotes)

local function getAnimator()
    local c = pl.Character or pl.CharacterAdded:Wait()
    return c:WaitForChild("Humanoid"):WaitForChild("Animator")
end

local cabezaAnim = Instance.new("Animation")
cabezaAnim.AnimationId = "rbxassetid://102325931762962"
local cabezaTrack
tog(VC, 8, "ANIM CABEZA", false, false, function(s)
    State["CABEZA ANIM"] = s
    if s then cabezaTrack = getAnimator():LoadAnimation(cabezaAnim); cabezaTrack:Play()
    elseif cabezaTrack then cabezaTrack:Stop() end
end)

local headlessAnim = Instance.new("Animation")
headlessAnim.AnimationId = "rbxassetid://102316572910864"
local headlessTrack
tog(VC, 8, "ANIM SIN CABEZA", false, false, function(s)
    State["HEADLESS ANIM"] = s
    if s then
        if headlessTrack then headlessTrack:Stop() end
        headlessTrack = getAnimator():LoadAnimation(headlessAnim)
        headlessTrack:Play()
    elseif headlessTrack then headlessTrack:Stop() end
end)

tog(VC, 8, "SIN CABEZA", false, false, function(s)
    State["SIN CABEZA"] = s
    local ch = pl.Character; if not ch then return end
    local h = ch:FindFirstChild("Head"); if not h then return end
    if s then
        if not State._headOriginal then
            State._headOriginal = {Size = h.Size, Transparency = h.Transparency, CanCollide = h.CanCollide}
        end
        h.Size = Vector3.zero; h.Transparency = 1; h.CanCollide = false
    else
        if State._headOriginal then
            h.Size = State._headOriginal.Size
            h.Transparency = State._headOriginal.Transparency
            h.CanCollide = State._headOriginal.CanCollide
        end
    end
end)

tog(VC, 8, "KORBLOX", false, false, function(s)
    State["KORBLOX"] = s
    local ch = pl.Character; if not ch then return end
    local leg = ch:FindFirstChild("Right Leg") or ch:FindFirstChild("RightLowerLeg")
    if not leg then return end
    if s then
        if not State._korbloxOriginal then
            State._korbloxOriginal = {Size = leg.Size, Transparency = leg.Transparency}
        end
        leg.Size = Vector3.new(0.5, 0.5, 0.5); leg.Transparency = 1
    else
        if State._korbloxOriginal then
            leg.Size = State._korbloxOriginal.Size
            leg.Transparency = 0
        end
    end
end)

tog(VC, 8, "REANIMAR", false, true, function(s)
    if s then loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Reanimation-Script-9268"))() end
end)

tog(VC, 8, "RESPAWN", false, true, function(s)
    if s then local ch = pl.Character; if ch and ch:FindFirstChild("Humanoid") then ch.Humanoid.Health = 0 end end
end)

tog(VC, 8, "REINICIAR", false, true, function(s) if s then pl:LoadCharacter() end end)

tog(VC, 8, "BRILLO MÁXIMO", false, false, function(s)
    State["BRILLO MÁXIMO"] = s
    if s then
        game.Lighting.Brightness = 10
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.new(1, 1, 1)
    else
        game.Lighting.Brightness = 2
        game.Lighting.GlobalShadows = true
        game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
    end
end)

tog(VC, 8, "SIN NIEBLA", false, false, function(s)
    State["SIN NIEBLA"] = s
    if s then game.Lighting.FogEnd = 100000 else game.Lighting.FogEnd = 1000 end
end)

tog(VC, 8, "FPS", false, true, function(s)
    if s then
        pcall(function() loadstring(game:HttpGet("https://pastebin.com/raw/fjaKjtdH"))() end)
    end
end)

-- ============================================
-- PESTAÑA: JUEGOS — STEAL AN EGG
-- ============================================
tog(JC, 8, "STEAL AN EGG", false, true, function(s)
    if s then
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/Chilli-Hub-Script/refs/heads/main/StealAnEgg"))()
        end)
        print("[Yato Mods] 🥚 Steal An Egg ACTIVADO")
    else
        print("[Yato Mods] 🥚 Steal An Egg DESACTIVADO")
    end
end)

-- ============================================
-- PESTAÑA: TECLADO
-- ============================================
local contadoresMkB = {}

local function mkB(p, t, fn, customColor)
    if not contadoresMkB[p] then contadoresMkB[p] = 0 end
    local idx = contadoresMkB[p]
    contadoresMkB[p] = idx + 1
    local col = idx % 2
    local fila = math.floor(idx / 2)
    local posX = (col == 0) and 0.02 or 0.51
    local posY = 8 + fila * 32

    local b = Instance.new("TextButton", p)
    b.Size = UDim2.new(0.47, 0, 0, 28)
    b.Position = UDim2.new(posX, 0, 0, posY)
    b.BackgroundTransparency = 0.6
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
    b.Text = t
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.Fantasy
    b.TextSize = 10
    b.ZIndex = 4
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)

    if customColor then
        applyRGBEffect(b, customColor)
    else
        applyRGBEffectBN(b)
    end

    UI.OriginalTexts.Buttons[t] = t
    b.MouseButton1Click:Connect(fn)
    return b
end

mkB(DC, "BORRAR TECLADO", function()
    local kb = game.CoreGui:FindFirstChild("KayKeyboard") or pl.PlayerGui:FindFirstChild("KayKeyboard")
    if kb then kb:Destroy(); TS.Text = "TECLADO ELIMINADO ✅" end
end)

mkB(DC, "CARGAR TECLADO", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/UQXtYC4D"))()
    TS.Text = "TECLADO CARGADO ✅"
end)

-- ============================================
-- PESTAÑA: CONTACTO
-- ============================================
mkB(CC, "TIKTOK", function()
    setclipboard("tiktok.com/@ren._yato")
    TS.Text = "TIKTOK COPIADO ✅"
end, Color3.fromRGB(255, 50, 50))

mkB(CC, "DISCORD", function()
    setclipboard("https://discord.gg/8YUQZwNyF")
    TS.Text = "DISCORD COPIADO ✅"
end, Color3.fromRGB(138, 43, 226))

mkB(CC, "WHATSAPP", function()
    setclipboard("@Ren_yato18")
    TS.Text = "WHATSAPP COPIADO ✅"
end, Color3.fromRGB(37, 211, 102))

-- ============================================
-- ✅ PROTECCIÓN AL VACÍO
-- ============================================
local PROTECCION_VACIO = false
local ULTIMA_POS_SEGURA = nil
local ULTIMA_VIDA = nil

tog(MC, 8, "PROTECCIÓN AL VACÍO", false, false, function(s)
    PROTECCION_VACIO = s
    if s then
        if pl.Character then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hrp then ULTIMA_POS_SEGURA = hrp.CFrame end
            if hum then ULTIMA_VIDA = hum.Health end
        end
        print("[Yato Mods] 🛡️ Protección al vacío ACTIVADA")
    else
        print("[Yato Mods] 🛡️ Protección al vacío DESACTIVADA")
    end
end)

local function teletransportarASeguro(motivo)
    if not ULTIMA_POS_SEGURA then return end
    local char = pl.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = ULTIMA_POS_SEGURA + Vector3.new(0, 5, 0)
    hrp.Velocity = Vector3.new(0, 0, 0)
    print("[Yato Mods] 🛡️ ¡Te salvaste! Motivo: " .. motivo)
end

task.spawn(function()
    while task.wait(0.1) do
        if PROTECCION_VACIO and pl.Character then
            local hrp = pl.Character:FindFirstChild("HumanoidRootPart")
            local hum = pl.Character:FindFirstChildOfClass("Humanoid")
            if hrp and hum then
                local accionTomada = false
                if hrp.Position.Y < -50 then
                    teletransportarASeguro("Caída al vacío")
                    accionTomada = true
                    task.wait(0.5)
                    ULTIMA_VIDA = hum.Health
                end
                if not accionTomada and ULTIMA_VIDA then
                    local perdidaVida = ULTIMA_VIDA - hum.Health
                    if perdidaVida > (hum.MaxHealth * 0.5) and hum.Health > 0 then
                        teletransportarASeguro("Trampa detectada")
                        accionTomada = true
                        task.wait(0.3)
                        hum.Health = ULTIMA_VIDA
                        ULTIMA_VIDA = hum.Health
                    end
                end
                if not accionTomada and hum.Health <= 0 and ULTIMA_VIDA and ULTIMA_VIDA > 0 then
                    teletransportarASeguro("Muerte instantánea")
                    accionTomada = true
                    task.wait(0.3)
                    hum.Health = ULTIMA_VIDA
                    ULTIMA_VIDA = hum.Health
                end
                if not accionTomada and hum.FloorMaterial ~= Enum.Material.Air then
                    ULTIMA_POS_SEGURA = hrp.CFrame
                end
                if not accionTomada and hum.Health > 0 then
                    ULTIMA_VIDA = hum.Health
                end
            end
        end
    end
end)

pl.CharacterAdded:Connect(function(char)
    task.wait(1)
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then ULTIMA_VIDA = hum.Health end
end)

-- ============================================
-- SALTO INFINITO
-- ============================================
UIS.JumpRequest:Connect(function()
    if not State["INFINITE JUMP"] then return end
    local ch = pl.Character
    if not ch then return end
    local hrp = ch:FindFirstChild("HumanoidRootPart")
    local hum = ch:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    hrp.Velocity = Vector3.new(hrp.Velocity.X, hum.JumpPower, hrp.Velocity.Z)
end)

-- ============================================
-- ✅ SISTEMA DE ARMAS
-- ============================================
local KEYWORDS = {
    {tipo = "knife",  palabras = {"Knife", "knife", "Cuchillo", "cuchillo", "Blade", "blade"}},
    {tipo = "pistol", palabras = {"Pistol", "pistol", "Pistola", "pistola", "Gun", "gun",
        "Revolver", "revolver", "Handgun", "handgun", "Deagle", "Deagle", "Colt", "colt"}},
}

local function detectarCategoria(nombre)
    if not nombre then return nil end
    for _, grupo in ipairs(KEYWORDS) do
        for _, kw in ipairs(grupo.palabras) do
            if string.find(nombre, kw, 1, true) then
                return grupo.tipo
            end
        end
    end
    return nil
end

local function escanearCategoriaJugador(player)
    if not player then return nil end
    local tieneCuchillo = false
    local tienePistola  = false

    if player.Character then
        for _, obj in ipairs(player.Character:GetChildren()) do
            if obj:IsA("Tool") then
                local cat = detectarCategoria(obj.Name)
                if cat == "knife" then tieneCuchillo = true end
                if cat == "pistol" then tienePistola = true end
            end
        end
    end

    local backpack = player:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, obj in ipairs(backpack:GetChildren()) do
            if obj:IsA("Tool") then
                local cat = detectarCategoria(obj.Name)
                if cat == "knife" then tieneCuchillo = true end
                if cat == "pistol" then tienePistola = true end
            end
        end
    end

    local starterGear = player:FindFirstChildOfClass("StarterGear")
    if starterGear then
        for _, obj in ipairs(starterGear:GetChildren()) do
            if obj:IsA("Tool") then
                local cat = detectarCategoria(obj.Name)
                if cat == "knife" then tieneCuchillo = true end
                if cat == "pistol" then tienePistola = true end
            end
        end
    end

    if tienePistola then return "pistol" end
    if tieneCuchillo then return "knife" end
    return nil
end

-- ============================================
-- ESP COMPLETO
-- ============================================
local espHL = {}
local espDrawings = {}
local espWeaponHL = {}

RS.RenderStepped:Connect(function()
    for _, d in pairs(espDrawings) do if d then d:Remove() end end
    espDrawings = {}

    local colorActual = obtenerColorRGB()
    local colorActualOscuro = obtenerColorRGBOscuro()

    for _, h in pairs(espHL) do
        if h and h.Parent then
            h.FillColor = colorActual
            h.OutlineColor = colorActualOscuro
        end
    end

    if pl.Character and pl.Character:FindFirstChild("Humanoid") then
        local hum = pl.Character.Humanoid
        if State["SPEED BOOST"] then hum.WalkSpeed = State.speedVal end
        if State["JUMP BOOST"] then hum.UseJumpPower = true; hum.JumpPower = State.jumpVal end
    end

    -- ESP NORMAL
    if State["ESP LINEAS"] or State["ESP AUTÓNOMO"] then
        local myRoot = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        for _, p in pairs(P:GetPlayers()) do
            if p ~= pl and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if root and hum and hum.Health > 0 then
                    local h = espHL[p]
                    if not h or not h.Parent or h.Adornee ~= p.Character then
                        if h then h:Destroy() end
                        h = Instance.new("Highlight")
                        h.Adornee = p.Character
                        h.Parent = UI.M
                        espHL[p] = h
                    end
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

                    if State["ESP AUTÓNOMO"] then
                        local pos, on = Cam:WorldToViewportPoint(root.Position)
                        if on and myRoot then
                            local dist = math.floor((root.Position - myRoot.Position).Magnitude)
                            local ln = Drawing.new("Line")
                            ln.From = Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y)
                            ln.To = Vector2.new(pos.X, pos.Y)
                            ln.Color = colorActual
                            ln.Thickness = 2
                            ln.Visible = true
                            table.insert(espDrawings, ln)

                            local tx = Drawing.new("Text")
                            tx.Text = p.Name
                            tx.Position = Vector2.new(pos.X, pos.Y - 28)
                            tx.Color = colorActual
                            tx.Size = 24
                            tx.Center = true
                            tx.Outline = true
                            tx.OutlineColor = Color3.fromRGB(0,0,0)
                            tx.Visible = true
                            table.insert(espDrawings, tx)

                            local dt = Drawing.new("Text")
                            dt.Text = "["..dist.."m]"
                            dt.Position = Vector2.new(pos.X, pos.Y - 52)
                            dt.Color = colorActual
                            dt.Size = 16
                            dt.Center = true
                            dt.Outline = true
                            dt.OutlineColor = Color3.fromRGB(0,0,0)
                            dt.Visible = true
                            table.insert(espDrawings, dt)
                        end
                    end
                else
                    if espHL[p] then
                        espHL[p]:Destroy()
                        espHL[p] = nil
                    end
                end
            end
        end
        for p, h in pairs(espHL) do
            if not p.Character or not p.Character:FindFirstChildOfClass("Humanoid") or p.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
                h:Destroy()
                espHL[p] = nil
            end
        end
    else
        for _, h in pairs(espHL) do h:Destroy() end
        espHL = {}
    end

    -- ESP ARMAS
    if State["ESP ARMAS"] then
        local myRoot = pl.Character and pl.Character:FindFirstChild("HumanoidRootPart")
        for _, p in pairs(P:GetPlayers()) do
            if p ~= pl and p.Character then
                local root = p.Character:FindFirstChild("HumanoidRootPart")
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                if root and hum and hum.Health > 0 then
                    local categoria = escanearCategoriaJugador(p)

                    if categoria == "pistol" or categoria == "knife" then
                        local fillColor, outlineColor
                        if categoria == "pistol" then
                            fillColor    = Color3.fromRGB(0, 120, 255)
                            outlineColor = Color3.fromRGB(0, 60, 180)
                        else
                            fillColor    = Color3.fromRGB(255, 40, 40)
                            outlineColor = Color3.fromRGB(180, 0, 0)
                        end

                        local h = espWeaponHL[p]
                        if not h or not h.Parent or h.Adornee ~= p.Character then
                            if h then h:Destroy() end
                            h = Instance.new("Highlight")
                            h.Adornee = p.Character
                            h.Parent = UI.M
                            h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            espWeaponHL[p] = h
                        end
                        h.FillColor = fillColor
                        h.OutlineColor = outlineColor
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 0

                        if myRoot then
                            local pos, on = Cam:WorldToViewportPoint(root.Position)
                            if on then
                                local dist = math.floor((root.Position - myRoot.Position).Magnitude)

                                local ln = Drawing.new("Line")
                                ln.From = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y)
                                ln.To = Vector2.new(pos.X, pos.Y)
                                ln.Color = fillColor
                                ln.Thickness = 2
                                ln.Transparency = 1
                                ln.Visible = true
                                table.insert(espDrawings, ln)

                                local tx = Drawing.new("Text")
                                tx.Text = p.Name
                                tx.Position = Vector2.new(pos.X, pos.Y - 40)
                                tx.Color = fillColor
                                tx.Size = 22
                                tx.Center = true
                                tx.Outline = true
                                tx.OutlineColor = Color3.fromRGB(0, 0, 0)
                                tx.Visible = true
                                table.insert(espDrawings, tx)

                                local dt = Drawing.new("Text")
                                dt.Text = "[" .. dist .. "m]"
                                dt.Position = Vector2.new(pos.X, pos.Y - 62)
                                dt.Color = fillColor
                                dt.Size = 16
                                dt.Center = true
                                dt.Outline = true
                                dt.OutlineColor = Color3.fromRGB(0, 0, 0)
                                dt.Visible = true
                                table.insert(espDrawings, dt)
                            end
                        end
                    else
                        if espWeaponHL[p] then
                            espWeaponHL[p]:Destroy()
                            espWeaponHL[p] = nil
                        end
                    end
                else
                    if espWeaponHL[p] then
                        espWeaponHL[p]:Destroy()
                        espWeaponHL[p] = nil
                    end
                end
            end
        end
        for p, h in pairs(espWeaponHL) do
            if not p.Parent or not p.Character then
                h:Destroy()
                espWeaponHL[p] = nil
            end
        end
    else
        for _, h in pairs(espWeaponHL) do pcall(function() h:Destroy() end) end
        espWeaponHL = {}
    end

    -- AIMBOT CAMERA LOCK
    if State["AIMBOT"] then
        local best, bestD = nil, _G.YatoFOVRadius or 200
        for _, p in pairs(P:GetPlayers()) do
            if p ~= pl and p.Character and p.Character:FindFirstChild("Head") then
                local head = p.Character.Head
                local sp, vis = Cam:WorldToViewportPoint(head.Position)
                if vis then
                    local d2 = (Vector2.new(sp.X, sp.Y) - Vector2.new(Cam.ViewportSize.X/2, Cam.ViewportSize.Y/2)).Magnitude
                    if d2 < bestD then
                        bestD = d2
                        best = p
                    end
                end
            end
        end
        if best then
            Cam.CFrame = CFrame.new(Cam.CFrame.Position, best.Character.Head.Position)
        end
    end

    -- FOV CIRCLE
    if FOVCircle then
        FOVCircle.Position = Vector2.new(Cam.ViewportSize.X / 2, Cam.ViewportSize.Y / 2)
        FOVCircle.Radius   = _G.YatoFOVRadius or 200
        FOVCircle.Visible  = State["FOV"] == true
    end
end)

P.PlayerAdded:Connect(function(p)
    if p ~= pl then
        task.wait(1)
        if State["ESP LINEAS"] or State["ESP AUTÓNOMO"] then
            if p.Character and p.Character:FindFirstChildOfClass("Humanoid") and p.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                local h = espHL[p]
                if not h or not h.Parent then
                    h = Instance.new("Highlight")
                    h.Adornee = p.Character
                    h.Parent = UI.M
                    espHL[p] = h
                end
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end
end)

for _, p in ipairs(P:GetPlayers()) do
    if p ~= pl then
        p.CharacterAdded:Connect(function(char)
            task.wait(0.5)
            if (State["ESP LINEAS"] or State["ESP AUTÓNOMO"]) then
                local h = espHL[p]
                if h then h:Destroy() end
                h = Instance.new("Highlight")
                h.Adornee = char
                h.Parent = UI.M
                h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                espHL[p] = h
            end
        end)
    end
end

-- NOCLIP
RS.Stepped:Connect(function()
    if State["NOCLIP"] and pl.Character then
        for _, p in pairs(pl.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- ============================================
-- XRAY
-- ============================================
local XRAY_ALPHA = 0.7
local RADIO_ALCANCE = 200
local INTERVALO = 1.5
local DISTANCIA_MINIMA = 30

local transparenciasOriginales = {}
local ultimaPosicionXRay = Vector3.zero
local xrayHighlights = {}

local function crearHighlightPara(p)
    if not p or not p.Parent then return end
    if not p.Character then return end
    if xrayHighlights[p] and xrayHighlights[p].Parent then
        if xrayHighlights[p].Adornee ~= p.Character then
            xrayHighlights[p].Adornee = p.Character
        end
        return
    end
    local h = Instance.new("Highlight")
    h.Name = "XRayPlayerHighlight"
    h.Adornee = p.Character
    h.FillColor = Color3.fromRGB(0, 200, 255)
    h.FillTransparency = 0.4
    h.OutlineColor = Color3.fromRGB(0, 255, 255)
    h.OutlineTransparency = 0
    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    h.Parent = UI.M
    xrayHighlights[p] = h
end

local function quitarHighlightDe(p)
    if xrayHighlights[p] then
        pcall(function() xrayHighlights[p]:Destroy() end)
        xrayHighlights[p] = nil
    end
end

local function quitarTodosLosHighlights()
    for p, h in pairs(xrayHighlights) do
        pcall(function() h:Destroy() end)
    end
    xrayHighlights = {}
end

local function actualizarTodosLosHighlights()
    for _, p in ipairs(P:GetPlayers()) do
        if p ~= pl and p.Character then crearHighlightPara(p) end
    end
    for p, h in pairs(xrayHighlights) do
        if not p.Parent or not p.Character then quitarHighlightDe(p) end
    end
end

local function conectarJugador(p)
    if p == pl then return end
    p.CharacterAdded:Connect(function()
        if State["XRAY"] then
            task.wait(0.3)
            crearHighlightPara(p)
        end
    end)
    p.CharacterRemoving:Connect(function()
        quitarHighlightDe(p)
    end)
end

for _, p in ipairs(P:GetPlayers()) do conectarJugador(p) end
P.PlayerAdded:Connect(function(p) conectarJugador(p) end)

local function esParteDePersonaje(obj)
    for _, p in ipairs(P:GetPlayers()) do
        if p.Character and p.Character:IsAncestorOf(obj) then return true end
    end
    local parent = obj.Parent
    while parent and parent ~= workspace do
        if parent:IsA("Model") and parent:FindFirstChildOfClass("Humanoid") then return true end
        parent = parent.Parent
    end
    return false
end

local function aplicarXRay()
    local ch = pl.Character
    local hrp = ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local myPos = hrp.Position
    if (myPos - ultimaPosicionXRay).Magnitude < DISTANCIA_MINIMA then return end
    ultimaPosicionXRay = myPos

    local params = OverlapParams.new()
    params.FilterType = Enum.RaycastFilterType.Include
    params.FilterDescendantsInstances = {workspace}

    local parts
    local ok = pcall(function()
        parts = workspace:GetPartBoundsInRadius(myPos, RADIO_ALCANCE, params)
    end)
    if not ok or not parts then return end

    for _, obj in ipairs(parts) do
        if obj and obj.Transparency < 1 then
            if not esParteDePersonaje(obj) then
                if transparenciasOriginales[obj] == nil then
                    transparenciasOriginales[obj] = obj.Transparency
                end
                pcall(function() obj.Transparency = XRAY_ALPHA end)
            end
        end
    end
end

local function quitarXRay()
    for obj, tOriginal in pairs(transparenciasOriginales) do
        if obj and obj.Parent then
            pcall(function() obj.Transparency = tOriginal end)
        end
    end
    transparenciasOriginales = {}
    ultimaPosicionXRay = Vector3.zero
end

local ultimoEstado = false
task.spawn(function()
    while task.wait(INTERVALO) do
        local activo = State["XRAY"] == true
        if activo then
            aplicarXRay()
            actualizarTodosLosHighlights()
            ultimoEstado = true
        elseif ultimoEstado then
            quitarXRay()
            quitarTodosLosHighlights()
            ultimoEstado = false
        end
    end
end)

-- ============================================
-- 🛡️ SISTEMA ANTI FLING
-- ============================================
local AF_MAX_HORIZONTAL_SPEED = 120
local AF_MAX_ANGULAR_SPEED    = 40
local AF_MAX_SAFE_STEP        = 60

local af_enabled = false
local af_lastSafeCF = nil
local af_lastPos    = nil
local af_conns      = {}
local af_characterConn = nil

local function af_getParts(char)
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    return hum, hrp
end

local function af_hardenHumanoid(char)
    local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 5)
    if not hum then return end
    pcall(function()
        hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
        hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
    end)
end

local function af_onCharacter(char)
    af_lastSafeCF, af_lastPos = nil, nil
    af_hardenHumanoid(char)
end

local function af_start()
    if af_enabled then return end
    af_enabled = true
    af_lastSafeCF, af_lastPos = nil, nil

    af_characterConn = pl.CharacterAdded:Connect(af_onCharacter)
    table.insert(af_conns, af_characterConn)
    if pl.Character then task.spawn(af_onCharacter, pl.Character) end

    -- Sin colisión con otros jugadores
    table.insert(af_conns, RS.Stepped:Connect(function()
        if not af_enabled then return end
        for _, other in ipairs(P:GetPlayers()) do
            if other ~= pl and other.Character then
                for _, part in ipairs(other.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
    end))

    -- Límite de velocidades + última posición segura
    table.insert(af_conns, RS.Heartbeat:Connect(function()
        if not af_enabled then return end
        local char = pl.Character
        local hum, hrp = af_getParts(char)
        if not hum or not hrp or hum.Health <= 0 then return end

        local vel   = hrp.AssemblyLinearVelocity
        local horiz = Vector3.new(vel.X, 0, vel.Z).Magnitude
        local spin  = hrp.AssemblyAngularVelocity.Magnitude
        local moved = af_lastPos and (hrp.Position - af_lastPos).Magnitude or 0

        if horiz > AF_MAX_HORIZONTAL_SPEED or spin > AF_MAX_ANGULAR_SPEED or moved > AF_MAX_SAFE_STEP then
            hrp.AssemblyLinearVelocity  = Vector3.new(0, math.min(vel.Y, 0), 0)
            hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            if af_lastSafeCF then
                hrp.CFrame = af_lastSafeCF
            end
        else
            af_lastSafeCF = hrp.CFrame
            af_lastPos    = hrp.Position
        end
    end))

    print("[Yato Mods] 🛡️ Anti Fling ACTIVADO")
end

local function af_stop()
    if not af_enabled then return end
    af_enabled = false
    for _, c in ipairs(af_conns) do
        pcall(function() c:Disconnect() end)
    end
    af_conns = {}
    af_characterConn = nil
    print("[Yato Mods] 🛡️ Anti Fling DESACTIVADO")
end

_G.YatoAntiFling = {
    Toggle = function(estado)
        if estado then af_start() else af_stop() end
    end,
    EstaActivo = function() return af_enabled end,
}

if State["ANTI FLING"] == true then
    task.spawn(function()
        task.wait(0.5)
        af_start()
    end)
end

UI.TBox = TBox; UI.JBox = JBox; UI.fB = fB; UI.fA = fA
UI.espHL = espHL
UI.espWeaponHL = espWeaponHL
_G.YatoHubPart2Loaded = true
print("[Yato Mods] ✅ Parte 2 lista — AIMBOT + FOV + ESP ARMAS + ANTI FLING + ATAQUE AUTOMÁTICO 🎯🛡️")
