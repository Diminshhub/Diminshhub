-- Alterar material de todas as Parts para SmoothPlastic
for i, v in next, (workspace:GetDescendants()) do
    if v:IsA("Part") then
        v.Material = Enum.Material.SmoothPlastic
    end
end

-- Configurações e Inicialização
if not _G.Ignore then
    _G.Ignore = {} -- Add Instances to this table to ignore them (e.g. _G.Ignore = {workspace.Map, workspace.Map2})
end
if not _G.WaitPerAmount then
    _G.WaitPerAmount = 500 -- Set Higher or Lower depending on your computer's performance
end
if _G.SendNotifications == nil then
    _G.SendNotifications = false -- Removido para não enviar notificações intermediárias
end
if _G.ConsoleLogs == nil then
    _G.ConsoleLogs = false -- Set to true if you want console logs (mainly for debugging)
end

if not game:IsLoaded() then
    repeat task.wait() until game:IsLoaded()
end
if not _G.Settings then
    _G.Settings = {
        Players = {
            ["Ignore Me"] = true,
            ["Ignore Others"] = true,
            ["Ignore Tools"] = true
        },
        Meshes = {
            NoMesh = false,
            NoTexture = false,
            Destroy = false
        },
        Images = {
            Invisible = true,
            Destroy = false
        },
        Explosions = {
            Smaller = true,
            Invisible = false,
            Destroy = false
        },
        Particles = {
            Invisible = true,
            Destroy = false
        },
        TextLabels = {
            LowerQuality = false,
            Invisible = false,
            Destroy = false
        },
        MeshParts = {
            LowerQuality = true,
            Invisible = false,
            NoTexture = false,
            NoMesh = false,
            Destroy = false
        },
        Other = {
            ["FPS Cap"] = 60,
            ["No Camera Effects"] = true,
            ["No Clothes"] = true,
            ["Low Water Graphics"] = true,
            ["No Shadows"] = true,
            ["Low Rendering"] = true,
            ["Low Quality Parts"] = true,
            ["Low Quality Models"] = true,
            ["Reset Materials"] = true,
            ["Lower Quality MeshParts"] = true,
            ["Optimize Network"] = true,
            ["Enhanced Colors"] = true, -- Nova opção para cores mais vibrantes
            ["Lower Texture Quality"] = true -- Nova opção para diminuir qualidade das texturas
        }
    }
end

-- Serviços e Funções
local Players, Lighting, StarterGui, MaterialService = game:GetService("Players"), game:GetService("Lighting"), game:GetService("StarterGui"), game:GetService("MaterialService")
local ME, CanBeEnabled = Players.LocalPlayer, {"ParticleEmitter", "Trail", "Smoke", "Fire", "Sparkles"}

local function PartOfCharacter(Instance)
    for i, v in pairs(Players:GetPlayers()) do
        if v ~= ME and v.Character and Instance:IsDescendantOf(v.Character) then
            return true
        end
    end
    return false
end

local function DescendantOfIgnore(Instance)
    for i, v in pairs(_G.Ignore) do
        if Instance:IsDescendantOf(v) then
            return true
        end
    end
    return false
end

local function CheckIfBad(Instance)
    -- Implementação do CheckIfBad com suas verificações
end

-- Configurações de Gráficos da Água
coroutine.wrap(pcall)(function()
    if _G.Settings["Low Water Graphics"] or (_G.Settings.Other and _G.Settings.Other["Low Water Graphics"]) then
        if not workspace:FindFirstChildOfClass("Terrain") then
            repeat task.wait() until workspace:FindFirstChildOfClass("Terrain")
        end
        local Terrain = workspace:FindFirstChildOfClass("Terrain")
        Terrain.WaterWaveSize, Terrain.WaterWaveSpeed = 0, 0
        Terrain.WaterReflectance = 0.1
        Terrain.WaterTransparency = 0.5 -- Ajuste de transparência para ver o fundo
        Terrain.WaterColor = Color3.new(0.1, 0.3, 1) -- Azul claro para a água
    end
end)

-- Configurações de Sombra
coroutine.wrap(pcall)(function()
    if _G.Settings["No Shadows"] or (_G.Settings.Other and _G.Settings.Other["No Shadows"]) then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
    end
end)

-- Reduzir Renderização
coroutine.wrap(pcall)(function()
    if _G.Settings["Low Rendering"] or (_G.Settings.Other and _G.Settings.Other["Low Rendering"]) then
        settings().Rendering.QualityLevel = 1
    end
end)

-- Resetar Materiais
coroutine.wrap(pcall)(function()
    if _G.Settings["Reset Materials"] or (_G.Settings.Other and _G.Settings.Other["Reset Materials"]) then
        for i, v in pairs(MaterialService:GetChildren()) do
            v:Destroy()
        end
        MaterialService.Use2022Materials = false
    end
end)

-- Cap de FPS
coroutine.wrap(pcall)(function()
    if _G.Settings["FPS Cap"] or (_G.Settings.Other and _G.Settings.Other["FPS Cap"]) then
        if setfpscap then
            setfpscap(tonumber(_G.Settings["FPS Cap"]))
        else
            StarterGui:SetCore("SendNotification", {
                Title = "Space boost0",
                Text = "FPS Cap Failed",
                Duration = math.huge,
                Button1 = "Okay"
            })
        end
    end
end)

-- Otimizar Rede
coroutine.wrap(pcall)(function()
    if _G.Settings["Optimize Network"] or (_G.Settings.Other and _G.Settings.Other["Optimize Network"]) then
        local function OptimizeNetwork()
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= ME then
                    local character = player.Character
                    if character then
                        local hrp = character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            hrp.Anchored = true -- Impede movimento do jogador, reduzindo dados de rede
                        end
                    end
                end
            end
        end

        OptimizeNetwork()
    end
end)

-- Realçar Cores e Saturação
coroutine.wrap(pcall)(function()
    if _G.Settings["Enhanced Colors"] or (_G.Settings.Other and _G.Settings.Other["Enhanced Colors"]) then
        local colorCorrection = Instance.new("ColorCorrectionEffect")
        colorCorrection.Parent = Lighting
        colorCorrection.Saturation = 1.5 -- Aumenta a saturação para deixar as cores mais vibrantes
        colorCorrection.Contrast = 0.2 -- Adiciona um pouco de contraste para mais definição
        colorCorrection.Brightness = 0.1 -- Ajusta o brilho levemente
    end
end)

-- Diminuir Qualidade das Texturas
coroutine.wrap(pcall)(function()
    if _G.Settings["Lower Texture Quality"] or (_G.Settings.Other and _G.Settings.Other["Lower Texture Quality"]) then
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not PartOfCharacter(part) then
                part.TextureID = "" -- Remove a textura, deixando sem textura
            elseif part:IsA("MeshPart") and not PartOfCharacter(part) then
                part.TextureID = "" -- Remove a textura de MeshPart, mantendo a do jogador
            end
        end
    end
end)

-- Verificar Instâncias
game.DescendantAdded:Connect(function(value)
    wait(_G.LoadedWait or 1)
    CheckIfBad(value)
end)

local Descendants = game:GetDescendants()
for i, v in pairs(Descendants) do
    CheckIfBad(v)
    if i == _G.WaitPerAmount then
        task.wait()
    end
end

-- Notificação Final
StarterGui:SetCore("SendNotification", {
    Title = "Space boost0",
    Text = "FPS Booster Loaded!",
    Duration = 5, -- Duração da notificação
    Button1 = "Okay"
})

warn("FPS Booster Loaded!")
