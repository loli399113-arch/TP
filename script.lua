-- GUI Configuration
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local TPButton = Instance.new("TextButton")
local AntiButton = Instance.new("TextButton")

-- Setup principal
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "DeltaTP_Hub"

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true -- Support pour Delta Mobile

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "GEMINI HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

-- Bouton TP TO BASE
TPButton.Parent = MainFrame
TPButton.Position = UDim2.new(0.1, 0, 0.35, 0)
TPButton.Size = UDim2.new(0.8, 0, 0, 35)
TPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TPButton.Text = "TP TO BASE"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TPButton)

-- Bouton ANTI-SCRIPT
AntiButton.Parent = MainFrame
AntiButton.Position = UDim2.new(0.1, 0, 0.65, 0)
AntiButton.Size = UDim2.new(0.8, 0, 0, 35)
AntiButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AntiButton.Text = "ANTI-SCRIPT: OFF"
AntiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AntiButton)

-- LOGIQUE TP
TPButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local base = nil
        -- Recherche automatique du Tycoon/Base
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name == "Owner" or v.Name == "OwnerName") and v.Value == player.Name then
                base = v.Parent
                break
            end
        end
        
        if base then
            char.HumanoidRootPart.CFrame = base:GetModelCFrame() + Vector3.new(0, 5, 0)
        else
            -- Position par défaut si la base n'est pas trouvée
            print("Base non trouvée !")
        end
    end
end)

-- LOGIQUE ANTI-SCRIPT (Anti-Lag)
local antiActive = false
AntiButton.MouseButton1Click:Connect(function()
    antiActive = not antiActive
    if antiActive then
        AntiButton.Text = "ANTI-SCRIPT: ON"
        AntiButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        AntiButton.Text = "ANTI-SCRIPT: OFF"
        AntiButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

game:GetService("RunService").Stepped:Connect(function()
    if antiActive then
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v:IsA("Explosion") or (v:IsA("Sound") and v.Volume > 10) then
                v:Destroy()
            end
        end
    end
end)
