-- [[ TP BASE & ANTI-SCRIPT FOR DELTA ]] --

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Création de l'interface
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TPButton = Instance.new("TextButton")
local AntiButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "GeminiHub_Delta"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true -- Support Mobile/Delta

local corner = Instance.new("UICorner", MainFrame)
corner.CornerRadius = UDim.new(0, 10)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "DELTA TP HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

-- BOUTON TP TO BASE
TPButton.Parent = MainFrame
TPButton.Position = UDim2.new(0.1, 0, 0.35, 0)
TPButton.Size = UDim2.new(0.8, 0, 0, 35)
TPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TPButton.Text = "TP TO BASE"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TPButton)

-- BOUTON ANTI-SCRIPT
AntiButton.Parent = MainFrame
AntiButton.Position = UDim2.new(0.1, 0, 0.7, 0)
AntiButton.Size = UDim2.new(0.8, 0, 0, 35)
AntiButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AntiButton.Text = "ANTI-SCRIPT: OFF"
AntiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AntiButton)

-- 1. FONCTION TÉLÉPORTATION BASE
TPButton.MouseButton1Click:Connect(function()
    local root = player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        -- Cherche le Tycoon appartenant au joueur
        local baseFound = nil
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name == "Owner" or v.Name == "OwnerName") and v.Value == player.Name then
                baseFound = v.Parent
                break
            end
        end

        if baseFound then
            root.CFrame = baseFound:GetModelCFrame() + Vector3.new(0, 5, 0)
        else
            -- Si pas de Tycoon, cherche un point de Spawn ou objet "Base"
            local backup = game.Workspace:FindFirstChild("Base") or game.Workspace:FindFirstChild(player.Name.."'s Base")
            if backup then
                root.CFrame = backup.CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)

-- 2. FONCTION ANTI-SCRIPT (ANTI-LAG)
local antiEnabled = false
AntiButton.MouseButton1Click:Connect(function()
    antiEnabled = not antiEnabled
    if antiEnabled then
        AntiButton.Text = "ANTI-SCRIPT: ON"
        AntiButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        AntiButton.Text = "ANTI-SCRIPT: OFF"
        AntiButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- Boucle de protection
game:GetService("RunService").Heartbeat:Connect(function()
    if antiEnabled then
        for _, obj in pairs(game.Workspace:GetChildren()) do
            if obj:IsA("Explosion") or (obj:IsA("Sound") and obj.Volume > 10) then
                obj:Destroy()
            end
        end
    end
end)
