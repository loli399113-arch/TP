--[[
    STEAL A BRAINROT - ULTIMATE DELTA HUB
    Lien: https://raw.githubusercontent.com/loli399113-arch/TP/refs/heads/main/script.lua
]]

-- Sécurité pour ne pas lancer le script 2 fois
if game.CoreGui:FindFirstChild("BrainrotHub") then
    game.CoreGui.BrainrotHub:Destroy()
end

-- CRÉATION DU GUI (SANS LIBRAIRIE EXTERNE POUR ÉVITER LES CRASHS)
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "BrainrotHub"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Active = true
Main.Draggable = true -- Tu peux le bouger sur Mobile

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "BRAINROT V3 (DELTA)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

Container.Name = "Container"
Container.Parent = Main
Container.BackgroundTransparency = 1
Container.Position = UDim2.new(0, 5, 0, 40)
Container.Size = UDim2.new(0, 210, 0, 230)
Container.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Container.ScrollBarThickness = 4

UIListLayout.Parent = Container
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

-- FONCTION POUR CRÉER DES BOUTONS (TOGGLES)
local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    local enabled = false
    
    btn.Name = name
    btn.Parent = Container
    btn.Size = UDim2.new(0, 190, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.Gotham
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 180, 50) or Color3.fromRGB(50, 50, 50)
        btn.Text = name .. (enabled and ": ON" or ": OFF")
        callback(enabled)
    end)
end

-- --- LOGIQUE DES CHEATS ---

-- 1. AUTO SLAP (FONCTIONNE MÊME AVEC OBJET)
local slapLoop = nil
createToggle("Auto Slap Fast", function(state)
    if state then
        slapLoop = task.spawn(function()
            while true do
                local char = game.Players.LocalPlayer.Character
                -- On cherche l'outil dans le perso OU l'inventaire
                local tool = char:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate() -- Tape
                end
                task.wait(0.05) -- Vitesse Max
            end
        end)
    else
        if slapLoop then task.cancel(slapLoop) end
    end
end)

-- 2. AUTO DIAMONDS (TP LES DIAMANTS SUR TOI)
local diamLoop = nil
createToggle("Auto Diamonds", function(state)
    if state then
        diamLoop = task.spawn(function()
            while true do
                local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    for _, v in pairs(workspace:GetChildren()) do
                        if v.Name:lower():find("diamond") or v.Name:lower():find("gem") then
                            if v:IsA("BasePart") then
                                v.CFrame = hrp.CFrame
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    else
        if diamLoop then task.cancel(diamLoop) end
    end
end)

-- 3. ANTI-AFK
createToggle("Anti-AFK", function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

print("Script chargé !")
