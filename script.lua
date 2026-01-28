--[[
    STEAL A BRAINROT - VERSION DIAMOND SLAP ULTRA
    - Frappe sans équiper le gant
    - Frappe même en portant un objet (Brainrot)
    - GUI inclus (Pas de liens externes)
]]

-- Supprimer l'ancien GUI s'il existe
if game.CoreGui:FindFirstChild("DiamondHub") then
    game.CoreGui.DiamondHub:Destroy()
end

-- --- CRÉATION DU GUI ---
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Name = "DiamondHub"
ScreenGui.Parent = game.CoreGui

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, -100, 0.5, -60)
Main.Size = UDim2.new(0, 200, 0, 120)
Main.Active = true
Main.Draggable = true -- Tu peux le déplacer sur ton écran

Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Text = "Diamond Slap Helper"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold

ToggleBtn.Parent = Main
ToggleBtn.Position = UDim2.new(0, 10, 0, 50)
ToggleBtn.Size = UDim2.new(0, 180, 0, 50)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleBtn.Text = "Auto-Slap: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Font = Enum.Font.Gotham

-- --- LOGIQUE DE FRAPPE ---
local autoSlap = false

ToggleBtn.MouseButton1Click:Connect(function()
    autoSlap = not autoSlap
    ToggleBtn.Text = autoSlap and "Auto-Slap: ON" or "Auto-Slap: OFF"
    ToggleBtn.BackgroundColor3 = autoSlap and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(200, 50, 50)
    
    task.spawn(function()
        while autoSlap do
            local player = game.Players.LocalPlayer
            -- On cherche le gant Diamond Slap dans ton sac à dos ou sur toi
            local tool = player.Backpack:FindFirstChild("Diamond Slap") or (player.Character and player.Character:FindFirstChild("Diamond Slap"))
            
            if tool then
                -- On cherche l'événement "Remote" qui dit au serveur de frapper
                -- Cette méthode ne nécessite PAS d'avoir le gant dans les mains
                local remote = tool:FindFirstChildOfClass("RemoteEvent") or tool:FindFirstChild("Remote") or tool:FindFirstChild("Event")
                
                if remote then
                    remote:FireServer()
                end
            end
            task.wait(0.1) -- Vitesse de frappe (0.1 seconde)
        end
    end)
end)

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Script Chargé",
    Text = "Diamond Slap Auto prêt !",
    Duration = 5
})
