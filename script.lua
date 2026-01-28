-- SCRIPT AUTO-SLAP & DIAMOND (Version Delta Stable)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SlapBtn = Instance.new("TextButton")
local DiamBtn = Instance.new("TextButton")

-- Configuration de l'interface
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "DeltaHub"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -50)
MainFrame.Size = UDim2.new(0, 150, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Tu peux le déplacer sur ton écran

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BRAINROT HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

-- BOUTON SLAP
SlapBtn.Parent = MainFrame
SlapBtn.Position = UDim2.new(0, 10, 0, 50)
SlapBtn.Size = UDim2.new(0, 130, 0, 40)
SlapBtn.Text = "Auto-Slap: OFF"
SlapBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local slapping = false
SlapBtn.MouseButton1Click:Connect(function()
    slapping = not slapping
    SlapBtn.Text = slapping and "Auto-Slap: ON" or "Auto-Slap: OFF"
    SlapBtn.BackgroundColor3 = slapping and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    
    task.spawn(function()
        while slapping do
            local p = game.Players.LocalPlayer
            local tool = p.Character and p.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate() -- Tape même avec un objet
            end
            task.wait(0.1)
        end
    end)
end)

-- BOUTON DIAMANTS
DiamBtn.Parent = MainFrame
DiamBtn.Position = UDim2.new(0, 10, 0, 110)
DiamBtn.Size = UDim2.new(0, 130, 0, 40)
DiamBtn.Text = "Auto-Diamond: OFF"
DiamBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

local farming = false
DiamBtn.MouseButton1Click:Connect(function()
    farming = not farming
    DiamBtn.Text = farming and "Auto-Diamond: ON" or "Auto-Diamond: OFF"
    DiamBtn.BackgroundColor3 = farming and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    
    task.spawn(function()
        while farming do
            for _, v in pairs(workspace:GetChildren()) do
                if v.Name:lower():find("diamond") and v:IsA("BasePart") then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            task.wait(1)
        end
    end)
end)
