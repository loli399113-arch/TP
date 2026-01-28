--[[
    AUTEUR: Delta User
    JEU: Steal a Brainrot
    FONCTION: Auto-Slap (Keep slapping while holding), Diamond Farm, GUI
]]

-- Nettoyage des anciens lancements
if _G.Executed then _G.Executed = false task.wait(0.5) end
_G.Executed = true

-- Importation de la Librairie GUI (Venyx UI est très fluide sur Mobile/Delta)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/StepBroFurious/Script/main/VenyxLib.lua"))()
local Window = Library.new("Delta Brainrot Hub", 5013109572)

-- Thèmes
local Themes = {
    Background = Color3.fromRGB(24, 24, 24),
    Accent = Color3.fromRGB(0, 255, 120)
}

-- Pages
local Main = Window:Page("Main")
local Settings = Window:Page("Settings")

-- Section Combat
local Combat = Main:Section("Combat & Slap")

local autoSlap = false
Combat:Toggle("Auto Slap (Always On)", function(state)
    autoSlap = state
    task.spawn(function()
        while autoSlap and _G.Executed do
            local player = game.Players.LocalPlayer
            local char = player.Character
            
            if char then
                -- Cherche l'outil dans la main ou le sac
                local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
                
                if tool then
                    -- Force l'activation même si on porte un Brainrot
                    tool:Activate()
                    -- Optionnel : Simule un clic pour certains jeux qui ignorent Activate()
                    local remote = tool:FindFirstChild("Remote") or tool:FindFirstChild("Event")
                    if remote and remote:IsA("RemoteEvent") then
                        remote:FireServer()
                    end
                end
            end
            task.wait(0.05) -- Vitesse ultra rapide
        end
    end)
end)

-- Section Farm
local Farm = Main:Section("Farm Diamants")

local autoDiamond = false
Farm:Toggle("Auto-Collect Diamonds", function(state)
    autoDiamond = state
    task.spawn(function()
        while autoDiamond and _G.Executed do
            -- Recherche des diamants dans le Workspace
            for _, obj in pairs(game.Workspace:GetChildren()) do
                if obj.Name:lower():find("diamond") or obj.Name:lower():find("gem") then
                    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp and obj:IsA("BasePart") then
                        -- Téléporte le diamant à toi ou toi au diamant
                        obj.CFrame = hrp.CFrame
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- Section Système
local Misc = Settings:Section("Système")

Misc:Button("Anti-AFK", function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
    print("Anti-AFK activé !")
end)

Misc:Button("Destroy UI", function()
    _G.Executed = false
    game.CoreGui:FindFirstChild("Delta Brainrot Hub"):Destroy()
end)

-- Notification de succès
game.StarterGui:SetCore("SendNotification", {
    Title = "Delta Hub",
    Text = "Script chargé avec succès !",
    Duration = 5
})
