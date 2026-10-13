-- ============================================
-- PARTE 3: TRADUCCIÓN + SELECTOR DE IDIOMA ✅
-- ✅ CARGA PARTE 2 (GitHub) DESPUÉS DE ELEGIR IDIOMA
-- ✅ TRADUCCIÓN ROBUSTA CON REINTENTOS
-- ✅ TRADUCE TODAS LAS GUIs ENCONTRADAS
-- ============================================

local Players = game:GetService("Players")
local pl = Players.LocalPlayer

-- ============================================
-- LIMPIEZA DEL SELECTOR
-- ============================================
local function limpiarSelector()
    pcall(function()
        for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if gui.Name == "YatoLangSelector" then gui:Destroy() end
        end
    end)
    pcall(function()
        for _, gui in ipairs(pl.PlayerGui:GetChildren()) do
            if gui.Name == "YatoLangSelector" then gui:Destroy() end
        end
    end)
    if gethui then
        pcall(function()
            for _, gui in ipairs(gethui():GetChildren()) do
                if gui.Name == "YatoLangSelector" then gui:Destroy() end
            end
        end)
    end
end

limpiarSelector()

-- ============================================
-- TABLA DE TRADUCCIONES
-- ============================================
local Translations = {
    ES = {
        ["INICIO"] = "INICIO", ["TP"] = "TP", ["ESP"] = "ESP",
        ["ATAQUE"] = "ATAQUE", ["VISUAL"] = "VISUAL", ["JUEGOS"] = "JUEGOS",
        ["CONTACT"] = "CONTACTO", ["KEYBOARD"] = "TECLADO",
        ["ESCUDO"] = "ESCUDO", ["SALTO INFINITO"] = "SALTO INFINITO",
        ["TRASPASAR PAREDES"] = "TRASPASAR PAREDES", ["VOLAR"] = "VOLAR",
        ["FLY V3 YATO"] = "VOLAR V3", ["VELOCIDAD"] = "VELOCIDAD",
        ["SALTO MEJORADO"] = "SALTO MEJORADO", ["SUPER VELOCIDAD"] = "SUPER VELOCIDAD",
        ["INMORTAL"] = "INMORTAL", ["DOMINIO"] = "DOMINIO", ["DESTRUIR"] = "DESTRUIR",
        ["ATAQUE EN ÁREA"] = "ATAQUE EN ÁREA", ["FAKE LAG"] = "LAG FALSO",
        ["XRAY"] = "XRAY", ["AIMBOT SILENT"] = "AIMBOT SILENCIOSO",
        ["ROBA UN HUEVO"] = "ROBA UN HUEVO", ["STEAL AN EGG"] = "ROBA UN HUEVO",
        ["PROTECCIÓN AL VACÍO"] = "PROTECCIÓN AL VACÍO",
        ["Velocidad..."] = "VELOCIDAD...", ["Salto..."] = "SALTO...", ["FOV..."] = "FOV...",
        ["TP JUGADOR"] = "ATAQUE AUTOMÁTICO", ["ATAQUE AUTOMÁTICO"] = "ATAQUE AUTOMÁTICO",
        ["TP PLAYER"] = "TP JUGADOR",
        ["TP CLIC"] = "TP CLIC", ["INVISIBLE"] = "INVISIBLE",
        ["GUARDAR POSICIÓN"] = "GUARDAR POSICIÓN", ["ANTI CAÍDA"] = "ANTI CAÍDA",
        ["LANZAR TOCANDO"] = "LANZAR TOCANDO", ["AIMBOT"] = "AIMBOT",
        ["VER ZONA"] = "VER ZONA", ["AJUSTAR"] = "AJUSTAR",
        ["LÍNEAS JUGADORES"] = "LÍNEAS JUGADORES", ["VER A TRAVÉS"] = "VER A TRAVÉS",
        ["GRÁFICOS MEJORADOS"] = "GRÁFICOS MEJORADOS", ["EMOTES"] = "EMOTES",
        ["ANIM CABEZA"] = "ANIM CABEZA", ["ANIM SIN CABEZA"] = "ANIM SIN CABEZA",
        ["SIN CABEZA"] = "SIN CABEZA", ["KORBLOX"] = "KORBLOX",
        ["REANIMAR"] = "REANIMAR", ["RESPAWN"] = "REAPARECER",
        ["REINICIAR"] = "REINICIAR", ["BRILLO MÁXIMO"] = "BRILLO MÁXIMO",
        ["SIN NIEBLA"] = "SIN NIEBLA", ["BORRAR TECLADO"] = "BORRAR TECLADO",
        ["CARGAR TECLADO"] = "CARGAR TECLADO",
        ["TECLADO ELIMINADO ✅"] = "TECLADO ELIMINADO ✅",
        ["TECLADO CARGADO ✅"] = "TECLADO CARGADO ✅",
        ["TIKTOK"] = "TIKTOK", ["DISCORD"] = "DISCORD", ["WHATSAPP"] = "WHATSAPP",
        ["TIKTOK COPIADO ✅"] = "TIKTOK COPIADO ✅",
        ["DISCORD COPIADO ✅"] = "DISCORD COPIADO ✅",
        ["WHATSAPP COPIADO ✅"] = "WHATSAPP COPIADO ✅",
        ["SELECT LANGUAGE"] = "SELECCIONAR IDIOMA",
        ["ANTI FLING"] = "ANTI LANZAMIENTO",
        ["ESP ARMAS"] = "ESP ARMAS",
        ["FPS"] = "FPS",
        ["Principal"] = "Principal", ["Servers"] = "Servidores", ["Baneados"] = "Baneados",
        ["Protección: OFF"] = "Protección: OFF", ["Protección: ON"] = "Protección: ON",
        ["Volar"] = "Volar", ["Detener"] = "Detener",
        ["Banear"] = "Banear", ["Reinicio"] = "Reinicio",
        ["Congelar"] = "Congelar", ["Descongelar"] = "Descongelar",
        ["Screamer"] = "Screamer", ["Deseleccionar todo"] = "Deseleccionar todo",
        ["Join"] = "Unirse", ["Desbanear"] = "Desbanear",
        ["Templo Japonés"] = "Templo Japonés", ["Destruir Templo"] = "Destruir Templo"
    },
    EN = {
        ["INICIO"] = "HOME", ["TP"] = "TP", ["ESP"] = "ESP",
        ["ATAQUE"] = "ATTACK", ["VISUAL"] = "VISUAL", ["JUEGOS"] = "GAMES",
        ["CONTACT"] = "CONTACT", ["KEYBOARD"] = "KEYBOARD",
        ["ESCUDO"] = "SHIELD", ["SALTO INFINITO"] = "INFINITE JUMP",
        ["TRASPASAR PAREDES"] = "NOCLIP", ["VOLAR"] = "FLY",
        ["FLY V3 YATO"] = "FLY V3", ["VELOCIDAD"] = "SPEED BOOST",
        ["SALTO MEJORADO"] = "JUMP BOOST", ["SUPER VELOCIDAD"] = "FLASH",
        ["INMORTAL"] = "GOD MODE", ["DOMINIO"] = "DOMAIN", ["DESTRUIR"] = "DESTROY",
        ["ATAQUE EN ÁREA"] = "AREA ATTACK", ["FAKE LAG"] = "FAKE LAG",
        ["XRAY"] = "XRAY", ["AIMBOT SILENT"] = "AIMBOT SILENT",
        ["ROBA UN HUEVO"] = "STEAL AN EGG", ["STEAL AN EGG"] = "STEAL AN EGG",
        ["PROTECCIÓN AL VACÍO"] = "VOID PROTECTION",
        ["Velocidad..."] = "SPEED...", ["Salto..."] = "JUMP...", ["FOV..."] = "FOV...",
        ["TP JUGADOR"] = "AUTO ATTACK", ["ATAQUE AUTOMÁTICO"] = "AUTO ATTACK",
        ["TP PLAYER"] = "TP PLAYER",
        ["TP CLIC"] = "CLICK TP", ["INVISIBLE"] = "INVISIBLE",
        ["GUARDAR POSICIÓN"] = "SAVE POSITION", ["ANTI CAÍDA"] = "ANTI KNOCKBACK",
        ["LANZAR TOCANDO"] = "TOUCH FLING", ["AIMBOT"] = "AIMBOT",
        ["VER ZONA"] = "SHOW ZONE", ["AJUSTAR"] = "SET FOV",
        ["LÍNEAS JUGADORES"] = "PLAYER LINES", ["VER A TRAVÉS"] = "SEE THROUGH WALLS",
        ["GRÁFICOS MEJORADOS"] = "BETTER GRAPHICS", ["EMOTES"] = "EMOTES FE",
        ["ANIM CABEZA"] = "HEAD ANIM", ["ANIM SIN CABEZA"] = "HEADLESS ANIM",
        ["SIN CABEZA"] = "HEADLESS", ["KORBLOX"] = "KORBLOX",
        ["REANIMAR"] = "REANIMATE", ["RESPAWN"] = "RESPAWN",
        ["REINICIAR"] = "RESET", ["BRILLO MÁXIMO"] = "FULLBRIGHT",
        ["SIN NIEBLA"] = "NO FOG", ["BORRAR TECLADO"] = "DELETE KEYBOARD",
        ["CARGAR TECLADO"] = "LOAD KEYBOARD",
        ["TECLADO ELIMINADO ✅"] = "KEYBOARD DELETED ✅",
        ["TECLADO CARGADO ✅"] = "KEYBOARD LOADED ✅",
        ["TIKTOK"] = "TIKTOK", ["DISCORD"] = "DISCORD", ["WHATSAPP"] = "WHATSAPP",
        ["TIKTOK COPIADO ✅"] = "TIKTOK COPIED ✅",
        ["DISCORD COPIADO ✅"] = "DISCORD COPIED ✅",
        ["WHATSAPP COPIADO ✅"] = "WHATSAPP COPIED ✅",
        ["SELECT LANGUAGE"] = "SELECT LANGUAGE",
        ["ANTI FLING"] = "ANTI FLING",
        ["ESP ARMAS"] = "ESP WEAPONS",
        ["FPS"] = "FPS",
        ["Principal"] = "Main", ["Servers"] = "Servers", ["Baneados"] = "Banned",
        ["Protección: OFF"] = "Protection: OFF", ["Protección: ON"] = "Protection: ON",
        ["Volar"] = "Fly", ["Detener"] = "Stop",
        ["Banear"] = "Ban", ["Reinicio"] = "Reset",
        ["Congelar"] = "Freeze", ["Descongelar"] = "Unfreeze",
        ["Screamer"] = "Screamer", ["Deseleccionar todo"] = "Deselect all",
        ["Join"] = "Join", ["Desbanear"] = "Unban",
        ["Templo Japonés"] = "Japanese Temple", ["Destruir Templo"] = "Destroy Temple"
    },
    RU = {
        ["INICIO"] = "ГЛАВНАЯ", ["TP"] = "ТП", ["ESP"] = "ЕСП",
        ["ATAQUE"] = "АТАКА", ["VISUAL"] = "ВИЗУАЛ", ["JUEGOS"] = "ИГРЫ",
        ["CONTACT"] = "КОНТАКТ", ["KEYBOARD"] = "КЛАВИАТУРА",
        ["ESCUDO"] = "ЩИТ", ["SALTO INFINITO"] = "БЕСКОНЕЧНЫЙ ПРЫЖОК",
        ["TRASPASAR PAREDES"] = "СКВОЗЬ СТЕНЫ", ["VOLAR"] = "ЛЕТАТЬ",
        ["FLY V3 YATO"] = "ЛЕТАТЬ V3", ["VELOCIDAD"] = "СКОРОСТЬ",
        ["SALTO MEJORADO"] = "УСИЛ. ПРЫЖОК", ["SUPER VELOCIDAD"] = "СУПЕР СКОРОСТЬ",
        ["INMORTAL"] = "БЕССМЕРТИЕ", ["DOMINIO"] = "ДОМЕН", ["DESTRUIR"] = "РАЗРУШИТЬ",
        ["ATAQUE EN ÁREA"] = "АТАКА ПО ОБЛАСТИ", ["FAKE LAG"] = "ФЕЙКОВЫЙ ЛАГ",
        ["XRAY"] = "РЕНТГЕН", ["AIMBOT SILENT"] = "ТИХИЙ АИМБОТ",
        ["ROBA UN HUEVO"] = "УКРАСТЬ ЯЙЦО", ["STEAL AN EGG"] = "УКРАСТЬ ЯЙЦО",
        ["PROTECCIÓN AL VACÍO"] = "ЗАЩИТА ОТ ПУСТОТЫ",
        ["Velocidad..."] = "СКОРОСТЬ...", ["Salto..."] = "ПРЫЖОК...", ["FOV..."] = "УГОЛ...",
        ["TP JUGADOR"] = "АВТО-АТАКА", ["ATAQUE AUTOMÁTICO"] = "АВТО-АТАКА",
        ["TP PLAYER"] = "ТП К ИГРОКУ",
        ["TP CLIC"] = "ТП КЛИК", ["INVISIBLE"] = "НЕВИДИМОСТЬ",
        ["GUARDAR POSICIÓN"] = "СОХР. ПОЗИЦИЮ", ["ANTI CAÍDA"] = "АНТИ ОТБРОС",
        ["LANZAR TOCANDO"] = "БРОСОК ПРИ КАСАНИИ", ["AIMBOT"] = "АИМБОТ",
        ["VER ZONA"] = "ПОКАЗАТЬ ЗОНУ", ["AJUSTAR"] = "УСТАНОВИТЬ",
        ["LÍNEAS JUGADORES"] = "ЛИНИИ ИГРОКОВ", ["VER A TRAVÉS"] = "ВИДЕТЬ СКВОЗЬ СТЕНЫ",
        ["GRÁFICOS MEJORADOS"] = "УЛУЧШ. ГРАФИКА", ["EMOTES"] = "ЭМОЦИИ",
        ["ANIM CABEZA"] = "АНИМ. ГОЛОВЫ", ["ANIM SIN CABEZA"] = "АНИМ. БЕЗ ГОЛОВЫ",
        ["SIN CABEZA"] = "БЕЗ ГОЛОВЫ", ["KORBLOX"] = "КОРБЛОКС",
        ["REANIMAR"] = "ПЕРЕЗАРЯДКА", ["RESPAWN"] = "ВОЗРОЖДЕНИЕ",
        ["REINICIAR"] = "СБРОС", ["BRILLO MÁXIMO"] = "МАКС. ЯРКОСТЬ",
        ["SIN NIEBLA"] = "БЕЗ ТУМАНА", ["BORRAR TECLADO"] = "УДАЛИТЬ КЛАВУ",
        ["CARGAR TECLADO"] = "ЗАГРУЗИТЬ КЛАВУ",
        ["TECLADO ELIMINADO ✅"] = "КЛАВА УДАЛЕНА ✅",
        ["TECLADO CARGADO ✅"] = "КЛАВА ЗАГРУЖЕНА ✅",
        ["TIKTOK"] = "ТИКТОК", ["DISCORD"] = "ДИСКОРД", ["WHATSAPP"] = "ВАТСАП",
        ["TIKTOK COPIADO ✅"] = "ТИКТОК СКОПИРОВАН ✅",
        ["DISCORD COPIADO ✅"] = "ДИСКОРД СКОПИРОВАН ✅",
        ["WHATSAPP COPIADO ✅"] = "ВАТСАП СКОПИРОВАН ✅",
        ["SELECT LANGUAGE"] = "ВЫБРАТЬ ЯЗЫК",
        ["ANTI FLING"] = "АНТИ-БРОСОК",
        ["ESP ARMAS"] = "ЕСП ОРУЖИЕ",
        ["FPS"] = "ФПС",
        ["Principal"] = "Главная", ["Servers"] = "Сервера", ["Baneados"] = "Забанены",
        ["Protección: OFF"] = "Защита: ВЫКЛ", ["Protección: ON"] = "Защита: ВКЛ",
        ["Volar"] = "Летать", ["Detener"] = "Стоп",
        ["Banear"] = "Бан", ["Reinicio"] = "Сброс",
        ["Congelar"] = "Заморозить", ["Descongelar"] = "Разморозить",
        ["Screamer"] = "Скример", ["Deseleccionar todo"] = "Снять всё",
        ["Join"] = "Войти", ["Desbanear"] = "Разбан",
        ["Templo Japonés"] = "Японский храм", ["Destruir Templo"] = "Уничтожить храм"
    }
}

-- ============================================
-- VENTANA DE SELECCIÓN DE IDIOMA
-- ============================================
local LangGui = Instance.new("ScreenGui")
LangGui.Name = "YatoLangSelector"
LangGui.ResetOnSpawn = false
LangGui.DisplayOrder = 100000
LangGui.IgnoreGuiInset = true
LangGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
if syn and syn.protect_gui then
    syn.protect_gui(LangGui)
    LangGui.Parent = game:GetService("CoreGui")
elseif gethui then
    LangGui.Parent = gethui()
else
    LangGui.Parent = pl.PlayerGui
end

local Marco = Instance.new("Frame", LangGui)
Marco.Size = UDim2.new(0, 220, 0, 190)
Marco.Position = UDim2.new(0.5, -110, 0.5, -95)
Marco.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
Marco.ZIndex = 100
Instance.new("UICorner", Marco).CornerRadius = UDim.new(0, 16)

local Borde = Instance.new("UIStroke", Marco)
Borde.Thickness = 3
Borde.Color = Color3.fromRGB(255, 255, 255)

local Titulo = Instance.new("TextLabel", Marco)
Titulo.Size = UDim2.new(0.9, 0, 0, 30)
Titulo.Position = UDim2.new(0.05, 0, 0, 12)
Titulo.Text = "SELECT LANGUAGE"
Titulo.TextColor3 = Color3.fromRGB(255, 255, 255)
Titulo.BackgroundTransparency = 1
Titulo.Font = Enum.Font.Fantasy
Titulo.TextSize = 14
Titulo.ZIndex = 101

local IdiomaElegido = nil

local function CrearBoton(y, bandera, texto, codigoIdioma)
    local btn = Instance.new("TextButton", Marco)
    btn.Size = UDim2.new(0.8, 0, 0, 34)
    btn.Position = UDim2.new(0.1, 0, 0, y)
    btn.Text = bandera .. "  " .. texto
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    btn.Font = Enum.Font.Fantasy
    btn.TextSize = 13
    btn.ZIndex = 101
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        IdiomaElegido = codigoIdioma
        _G.YatoSelectedLang = codigoIdioma
        Titulo.Text = Translations[codigoIdioma]["SELECT LANGUAGE"] or "SELECT LANGUAGE"
        task.wait(0.2)
        LangGui:Destroy()
    end)
    return btn
end

CrearBoton(50, "🇺🇸", "English", "EN")
CrearBoton(90, "🇪🇸", "Español", "ES")
CrearBoton(130, "🇷🇺", "Русский", "RU")

-- BORDE RGB
task.spawn(function()
    while LangGui and LangGui.Parent do
        for i = 255, 0, -4 do
            if not Borde or not Borde.Parent then break end
            Borde.Color = Color3.fromRGB(i, i, i)
            task.wait(0.02)
        end
        for i = 0, 255, 4 do
            if not Borde or not Borde.Parent then break end
            Borde.Color = Color3.fromRGB(i, i, i)
            task.wait(0.02)
        end
    end
end)

-- ============================================
-- ESPERAR SELECCIÓN Y CARGAR PARTE 2 (GITHUB)
-- ============================================
while not IdiomaElegido do
    task.wait(0.1)
end

print("[Yato Mods] ✅ Idioma seleccionado: " .. IdiomaElegido)

-- ✅ CARGAR PARTE 2 DESPUÉS DE ELEGIR IDIOMA
print("[Yato Mods] ⏳ Cargando Parte 2...")
local ok, err = pcall(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/wordalastor04-dotcom/Yato-1/refs/heads/main/Parte2.lua"))()
end)

if not ok then
    warn("[Yato Mods] ❌ Error al cargar Parte 2: " .. tostring(err))
    return
end

-- Esperar a que la UI se construya completamente
task.wait(8)

-- ============================================
-- SISTEMA DE TRADUCCIÓN ROBUSTO
-- ============================================
local function obtenerTodasLasGuis()
    local lista = {}
    pcall(function()
        for _, gui in ipairs(pl.PlayerGui:GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "YatoLangSelector" then table.insert(lista, gui) end
        end
    end)
    pcall(function()
        for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
            if gui:IsA("ScreenGui") and gui.Name ~= "YatoLangSelector" then table.insert(lista, gui) end
        end
    end)
    if gethui then
        pcall(function()
            for _, gui in ipairs(gethui():GetChildren()) do
                if gui:IsA("ScreenGui") and gui.Name ~= "YatoLangSelector" then table.insert(lista, gui) end
            end
        end)
    end
    return lista
end

local function traducirTexto(texto, T)
    if not texto or texto == "" then return texto end
    local espaciosIni = texto:match("^(%s*)") or ""
    local espaciosFin = texto:match("(%s*)$") or ""
    local limpio = texto:gsub("^%s+", ""):gsub("%s+$", "")
    local traducido = T[limpio]
    if traducido then
        return espaciosIni .. traducido .. espaciosFin
    end
    return texto
end

local function traducirGui(gui, T)
    if not gui or not gui.Parent then return 0 end
    local contador = 0
    for _, hijo in ipairs(gui:GetDescendants()) do
        pcall(function()
            if hijo:IsA("TextButton") or hijo:IsA("TextLabel") then
                local original = hijo.Text
                local nuevo = traducirTexto(original, T)
                if nuevo ~= original then
                    hijo.Text = nuevo
                    contador = contador + 1
                end
            end
        end)
    end
    return contador
end

task.spawn(function()
    local T = Translations[IdiomaElegido]
    if not T then 
        warn("[Yato Mods] ⚠️ Idioma no reconocido: " .. tostring(IdiomaElegido))
        return 
    end

    -- Hacer 10 pasadas con 1 segundo de intervalo
    for pasada = 1, 10 do
        local totalTraducidos = 0
        local guis = obtenerTodasLasGuis()
        for _, gui in ipairs(guis) do
            local n = traducirGui(gui, T)
            totalTraducidos = totalTraducidos + n
        end
        print("[Yato Mods] 🌐 Pasada " .. pasada .. ": " .. totalTraducidos .. " textos traducidos")
        task.wait(1)
    end

    print("[Yato Mods] ✅ Traducción completa aplicada para idioma: " .. IdiomaElegido)
end)
