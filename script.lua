--[[
    ULTIMATE BRAINROT BYPASS - FORCE SLAP
    Ce script force l'envoi du signal de frappe au serveur.
]]

if game.CoreGui:FindFirstChild("BrainrotHub") then
    game.CoreGui.BrainrotHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "BrainrotHub"
ScreenGui.Parent = game.CoreGui
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Position = UDim2.new(0.3, 0, 0.3, 0)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Active = true
Main.Draggable = true

Title.Parent = Main
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "BRAINROT BYPASS V5"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold

Container.Parent = Main
Container.Position = UDim2.new(0, 5, 0, 40)
Container.Size = UDim2.new(0, 210, 0, 230)
Container.BackgroundTransparency = 1
UIListLayout.Parent = Container
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 8)

local function createToggle(name, callback)
    local btn = Instance.new("TextButton")
    local enabled = false
    btn.Parent = Container
    btn.Size = UDim2.new(0, 190, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = name .. ": OFF"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Gotham
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        btn.BackgroundColor3 = enabled and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(60, 60, 60)
        btn.Text = name .. (enabled and ": ON" or ": OFF")
        callback(enabled)
    end)
end

-- --- LA LOGIQUE DE BYPASS ---
local forceSlap = false
createToggle("Force Slap (Bypass)", function(state)
    forceSlap = state
    task.spawn(function()
        while forceSlap do
            local player = game.Players.LocalPlayer
            local char = player.Character
            
            -- On cherche le gant dans le sac ou sur le perso
            local tool = player.Backpack:FindFirstChild("Diamond Slap") or char:FindFirstChild("Diamond Slap") 
            or player.Backpack:FindFirstChildOfClass("Tool") or char:FindFirstChildOfClass("Tool")

            if tool then
                -- TECHNIQUE 1: Activation forcée
                tool:Activate()
                
                -- TECHNIQUE 2: Remote Bypass (C'est ça qui fait que ça tape quand tu portes un objet)
                -- On cherche l'événement qui dit au serveur "J'ai frappé"
                for _, v in pairs(tool:GetDescendants()) do
                    if v:IsA("RemoteEvent") or v:IsA("BindableEvent") then
                        -- On envoie le signal sans que l'animation ait besoin de se jouer
                        v:FireServer() 
                    end
                end
            end
            task.wait(0.01) -- Vitesse de frappe maximale
        end
    end)
end)

-- --- AUTO COLLECT DIAMONDS ---
local autoDiam = false
createToggle("Auto Collect Gems", function(state)
    autoDiam = state
    task.spawn(function()
        while autoDiam do
            local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, v in pairs(workspace:GetDescendants()) do
                    if (v.Name == "Diamond" or v.Name == "Gem") and v:IsA("BasePart") then
                        v.CFrame = hrp.CFrame
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end)
