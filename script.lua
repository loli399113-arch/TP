--[[
    SCRIPT: Steal a Brainrot - Ultimate Hub
    STATUS: Stable for Delta Executor
]]

-- Sécurité pour éviter les exécutions multiples
if _G.MainLoaded then return end
_G.MainLoaded = true

-- Initialisation de la Librairie (Kavo UI - Très stable sur Delta)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Delta Brainrot V2", "DarkScene")

-- --- VARIABLES ---
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local config = {
    slap = false,
    farm = false,
    speed = 0.1
}

-- --- FONCTIONS ---
local function getTool()
    return LocalPlayer.Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
end

-- --- PAGES ---
local MainTab = Window:NewTab("Main")
local Section = MainTab:NewSection("Auto Farm")

-- Toggle Auto Slap
Section:NewToggle("Auto Slap (Même avec Brainrot)", "Tape en boucle", function(state)
    config.slap = state
    task.spawn(function()
        while config.slap do
            local tool = getTool()
            if tool then
                tool:Activate() -- Action de base
                -- Force l'attaque même si l'animation est bloquée
                local remote = tool:FindFirstChildOfClass("RemoteEvent")
                if remote then
                    remote:FireServer()
                end
            end
            task.wait(config.speed)
        end
    end)
end)

-- Toggle Auto Diamants
Section:NewToggle("Auto Diamonds", "Récupère les diamants proches", function(state)
    config.farm = state
    task.spawn(function()
        while config.farm do
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:lower():find("diamond") or obj.Name:lower():find("gem") then
                    if obj:IsA("BasePart") and LocalPlayer.Character then
                        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            obj.CFrame = hrp.CFrame
                        end
                    end
                end
            end
            task.wait(1)
        end
    end)
end)

-- Paramètres
local SettingsTab = Window:NewTab("Paramètres")
local SetSection = SettingsTab:NewSection("Réglages")

SetSection:NewSlider("Vitesse de frappe", "Plus bas = Plus rapide", 0.5, 0.01, function(s)
    config.speed = s
end)

SetSection:NewButton("Anti-AFK (Anti-Kick)", "Évite d'être viré du jeu", function()
    local vu = game:GetService("VirtualUser")
    LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Notif de fin de chargement
Library:Notify("Script Ready", "Le menu Delta est prêt !")
