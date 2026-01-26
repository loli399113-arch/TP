-- [[ DELTA TP HUB - VERSION AMÉLIORÉE ]] --
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local TPButton = Instance.new("TextButton")
local AntiButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Name = "DeltaTPHub_V2"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "DELTA TP HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

TPButton.Parent = MainFrame
TPButton.Position = UDim2.new(0.1, 0, 0.35, 0)
TPButton.Size = UDim2.new(0.8, 0, 0, 35)
TPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TPButton.Text = "TP TO BASE"
TPButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TPButton)

AntiButton.Parent = MainFrame
AntiButton.Position = UDim2.new(0.1, 0, 0.7, 0)
AntiButton.Size = UDim2.new(0.8, 0, 0, 35)
AntiButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
AntiButton.Text = "ANTI-SCRIPT: OFF"
AntiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", AntiButton)

-- FONCTION TP ULTRA DÉTECTION
TPButton.MouseButton1Click:Connect(function()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end

    local foundBase = nil

    -- Méthode 1 : Cherche par valeur d'Owner (Propriétaire)
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if (v:IsA("StringValue") or v:IsA("ObjectValue")) and v.Value == player.Name then
            foundBase = v.Parent
            break
        end
    end

    -- Méthode 2 : Cherche par nom de dossier (Ex: "Taco Base")
    if not foundBase then
        for _, v in pairs(game.Workspace:GetChildren()) do
            if v.Name:find(player.Name) or (v:FindFirstChild("Owner") and v.Owner.Value == player.Name) then
                foundBase = v
                break
            end
        end
    end

    if foundBase then
        -- Téléporte au centre de la base ou sur un objet spécifique
        local targetPos = foundBase:GetModelCFrame() or foundBase.CFrame
        root.CFrame = targetPos + Vector3.new(0, 10, 0)
    else
        print("Erreur : Ta base n'a pas été trouvée. Réessaie près de ta base.")
    end
end)

-- ANTI-SCRIPT
local antiActive = false
AntiButton.MouseButton1Click:Connect(function()
    antiActive = not antiActive
    AntiButton.Text = antiActive and "ANTI-SCRIPT: ON" or "ANTI-SCRIPT: OFF"
    AntiButton.BackgroundColor3 = antiActive and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
end)

game:GetService("RunService").Heartbeat:Connect(function()
    if antiActive then
        for _, obj in pairs(game.Workspace:GetChildren()) do
            if obj:IsA("Explosion") then obj:Destroy() end
        end
    end
end)
