-- Services
local TweenService = game:GetService("TweenService")
local Players = game.Players
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Création du ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomMenu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Cadre Principal (Main Frame)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 120)
mainFrame.Position = UDim2.new(0.5, -110, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Permet de déplacer le menu
mainFrame.Parent = screenGui

-- Arrondir les coins
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Titre
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundTransparency = 1
title.Text = "MENU PREMIUM"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Bouton Toggle
local toggleBtn = Instance.new("TextButton")
toggleBtn.Name = "ToggleBtn"
toggleBtn.Size = UDim2.new(0, 180, 0, 45)
toggleBtn.Position = UDim2.new(0, 20, 0, 50)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Rouge de base
toggleBtn.Text = "GOD MODE: OFF"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.Font = Enum.Font.GothamSemibold
toggleBtn.TextSize = 14
toggleBtn.AutoButtonColor = false
toggleBtn.Parent = mainFrame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = toggleBtn

-- Logique de fonctionnement
local isActive = false

toggleBtn.MouseButton1Click:Connect(function()
	isActive = not isActive
	
	-- Animation de couleur
	local targetColor = isActive and Color3.fromRGB(50, 200, 100) or Color3.fromRGB(200, 50, 50)
	local targetText = isActive and "GOD MODE: ON" or "GOD MODE: OFF"
	
	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	local tween = TweenService:Create(toggleBtn, tweenInfo, {BackgroundColor3 = targetColor})
	
	tween:Play()
	toggleBtn.Text = targetText
	
	-- Action ici
	if isActive then
		print("Mode activé : Tu as maintenant le contrôle.")
	else
		print("Mode désactivé.")
	end
end)
