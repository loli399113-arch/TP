--[[
    Script: Steal a Brainrot - Slap & Diamonds
    Logic: Auto-Slap, Diamond Collector, Anti-AFK
]]

-- Libération de la mémoire si le script tourne déjà
if _G.Running then _G.Running = false task.wait(0.5) end
_G.Running = true

-- Initialisation de la Librairie (Interface)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/7Yuro/Vape-V4-Roblox/main/CustomModules/KavoGUILibrary.lua"))()
local Window = Library.CreateLib("Delta Executor - Steal a Brainrot", "Midnight")

-- Variables de contrôle
local config = {
    autoSlap = false,
    autoCollect = false,
    antiAfk = true,
    slapSpeed = 0.1
}

-- Section Principale
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Combat & Farm")

-- Toggle pour le Slap Automatique
Section:NewToggle("Auto Slap (Frapper)", "Frappe en boucle même avec un objet", function(state)
    config.autoSlap = state
    task.spawn(function()
        while config.autoSlap and _G.Running do
            -- On simule l'activation de l'outil de Slap
            local char = game.Players.LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate() -- Tape même si tu tiens un brainrot
                end
            end
            task.wait(config.slapSpeed)
        end
    end)
end)

-- Toggle pour les Diamants
Section:NewToggle("Auto Diamond", "Ramasse les diamants automatiquement", function(state)
    config.autoCollect = state
    task.spawn(function()
        while config.autoCollect and _G.Running do
            -- Logique pour trouver les diamants (Parties nommées 'Diamond' ou 'Gem')
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v.Name == "Diamond" or v:FindFirstChild("Diamond") then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        v.CFrame = char.HumanoidRootPart.CFrame -- Téléporte le diamant sur toi
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- Section Paramètres
local Settings = Window:NewTab("Paramètres")
local SetSection = Settings:NewSection("Système")

SetSection:NewButton("Anti-AFK", "Empêche d'être kické", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    print("Anti-AFK activé")
end)

SetSection:NewSlider("Vitesse Slap", "Ajuste la vitesse de frappe", 0.5, 0.1, function(s)
    config.slapSpeed = s
end)

-- Notification de chargement
game.StarterGui:SetCore("SendNotification", {
    Title = "Delta Script Loaded",
    Text = "Steal a Brainrot prêt !",
    Duration = 5
})
