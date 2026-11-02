-- =============================================================================
-- 🌌 UNIVERSE HUB V.1.2.09 🌌 | 100% COMPLETE & VERIFIED DELTA VERSION
-- =============================================================================

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")
local camera = game.Workspace.CurrentCamera

-- Alte Benutzeroberflächen löschen, um Datenmüll zu vermeiden
if localPlayer:WaitForChild("PlayerGui"):FindFirstChild("UniverseEclipseHub") then
	localPlayer.PlayerGui.UniverseEclipseHub:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "UniverseEclipseHub"
sg.ResetOnSpawn = false
sg.Parent = localPlayer.PlayerGui

-- =============================================================================
-- 🛑 STUFE 1: DER REINE "LOAD" BUTTON (Launcher)
-- =============================================================================
local loadBtn = Instance.new("TextButton")
loadBtn.Name = "LoadButton"
loadBtn.Size = UDim2.new(0, 260, 0, 55)
loadBtn.Position = UDim2.new(0.5, -130, 0.45, -27)
loadBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
loadBtn.TextColor3 = Color3.fromRGB(255, 100, 255)
loadBtn.Font = Enum.Font.SourceSansBold
loadBtn.TextSize = 16
loadBtn.Text = "🌌 LOAD UNIVERSE HUB V.1.2.09 🌌"
loadBtn.Parent = sg

-- =============================================================================
-- 🔓 STUFE 2: DAS HAUPTMENÜ (Wird erst nach dem Klicken aufgebaut)
-- =============================================================================
loadBtn.MouseButton1Click:Connect(function()
	loadBtn:Destroy() -- Entfernt den Startknopf
	
	-------------------------------------------------------------
	-- 🚀 VISUALS: ULTRA GRAPHICS SCHÄRFE
	-------------------------------------------------------------
	local lighting = game:GetService("Lighting")
	lighting.GlobalShadows = true
	lighting.EnvironmentSpecularScale = 1
	lighting.EnvironmentDiffuseScale = 1

	local bloom = lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", lighting)
	bloom.Intensity = 1.2; bloom.Size = 24; bloom.Threshold = 0.8

	local colorCorrection = lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", lighting)
	colorCorrection.Brightness = 0.05; colorCorrection.Contrast = 0.2; colorCorrection.Saturation = 0.15

	-- Das Hauptfenster
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(0, 260, 0, 500)
	frame.Position = UDim2.new(0, 10, 0, 120)
	frame.BackgroundColor3 = Color3.fromRGB(10, 5, 20)
	frame.BorderSizePixel = 2
	frame.BorderColor3 = Color3.fromRGB(180, 50, 255)
	frame.Active = true
	frame.Parent = sg

	-- Mobiles Touch-Verschiebe-System
	local dragging, dragInput, dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = frame.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
	runService.RenderStepped:Connect(function() if dragging and dragInput then local delta = dragInput.Position - dragStart frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)

	-- Titel-Anzeige
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 0, 35)
	label.BackgroundColor3 = Color3.fromRGB(24, 12, 40)
	label.Text = "🌌 UNIVERSE V.1.2.09 | FIXED ✅"
	label.TextColor3 = Color3.fromRGB(255, 100, 255)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 14
	label.Parent = frame

	-- Ein- und Ausblendknopf
	local tog = Instance.new("TextButton")
	tog.Size = UDim2.new(0, 110, 0, 30)
	tog.Position = UDim2.new(0, 10, 0, 75)
	tog.BackgroundColor3 = Color3.fromRGB(24, 12, 40)
	tog.Text = "🔮 SHOW/HIDE"
	tog.TextColor3 = Color3.fromRGB(255, 255, 255)
	tog.Font = Enum.Font.SourceSansBold
	tog.Parent = sg
	tog.MouseButton1Click:Connect(function() frame.Visible = not frame.Visible end)

	-- Speed-Anzeige Text
	local speedLabel = Instance.new("TextLabel")
	speedLabel.Size = UDim2.new(1, -20, 0, 20)
	speedLabel.Position = UDim2.new(0, 10, 0, 42)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Text = "SELECT WALKSPEED:"
	speedLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
	speedLabel.Font = Enum.Font.SourceSansBold
	speedLabel.TextSize = 11
	speedLabel.TextXAlignment = Enum.TextXAlignment.Left
	speedLabel.Parent = frame

	-- Geschwindigkeits-Steuerung (Loop-Absicherung)
	local activeSpeed = 16
	local function setSpeed(value)
		activeSpeed = value
		if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then 
			localPlayer.Character.Humanoid.WalkSpeed = value 
		end
	end

	task.spawn(function() 
		while true do 
			if localPlayer.Character and localPlayer.Character:FindFirstChild("Humanoid") then 
				if localPlayer.Character.Humanoid.WalkSpeed ~= activeSpeed then 
					localPlayer.Character.Humanoid.WalkSpeed = activeSpeed 
				end 
			end 
			task.wait(0.2) 
		end 
	end)

	-- Erstellung der Speed-Stufen Knöpfe
	local function makeSpeedBtn(txt, posX, speedVal)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(0, 52, 0, 23)
		b.Position = UDim2.new(0, posX, 0, 62)
		b.BackgroundColor3 = Color3.fromRGB(35, 25, 55)
		b.TextColor3 = Color3.fromRGB(255, 255, 255)
		b.Font = Enum.Font.SourceSansBold
		b.TextSize = 10
		b.Text = txt
		b.Parent = frame
		b.MouseButton1Click:Connect(function() setSpeed(speedVal) speedLabel.Text = "SELECT WALKSPEED: [ " .. speedVal .. " ]" end)
	end
	makeSpeedBtn("16 (Norm)", 10, 16)
	makeSpeedBtn("45 (Fast)", 67, 45)
	makeSpeedBtn("75 (God)", 124, 75)
	makeSpeedBtn("150 (Tele)", 181, 150)

	-- Automatischer Button-Generierer mit korrekter Status-Lampe
	local function createCommand(txt, y, callback)
		local b = Instance.new("TextButton")
		b.Size = UDim2.new(1, -20, 0, 30)
		b.Position = UDim2.new(0, 10, 0, y)
		b.BackgroundColor3 = Color3.fromRGB(150, 30, 30)
		b.TextColor3 = Color3.fromRGB(255, 255, 255)
		b.Font = Enum.Font.SourceSansBold
		b.TextSize = 12
		b.Text = txt .. " [ OFF ] 🔴"
		b.Parent = frame
		
		local active = false
		b.MouseButton1Click:Connect(function()
			active = not active
			b.Text = active and txt .. " [ ON ] 🟢" or txt .. " [ OFF ] 🔴"
			b.BackgroundColor3 = active and Color3.fromRGB(30, 140, 60) or Color3.fromRGB(150, 30, 30)
			callback(active)
		end)
		return b
	end

	-- =============================================================================
	-- DIE ECLIPSE CHEATS
	-- =============================================================================

	-- 1. Silent Aim
	local silentAimActive = false
	createCommand("🎯 Eclipse Silent Aim", 95, function(state)
		silentAimActive = state
		task.spawn(function()
			while silentAimActive do
				local target = nil
				for _, p in pairs(players:GetPlayers()) do
					if p ~= localPlayer and p.Character and (p.Character:FindFirstChild("Knife") or p.Backpack:FindFirstChild("Knife")) then target = p break end
				end
				if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
					local gun = localPlayer.Character and localPlayer.Character:FindFirstChild("Gun")
					if gun then
						camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.HumanoidRootPart.Position)
						if gun:FindFirstChild("Activate") then gun.Activate:FireServer() else gun:Activate() end
						task.wait(0.2)
					end
				end
				runService.RenderStepped:Wait()
			end
		end)
	end)

	-- 2. Knife Kill Aura
	local knifeAuraActive = false
	createCommand("⚔️ Eclipse Knife Aura", 135, function(state)
		knifeAuraActive = state
		task.spawn(function()
			while knifeAuraActive do
				local knife = localPlayer.Character and localPlayer.Character:FindFirstChild("Knife")
				if knife then
					for _, p in pairs(players:GetPlayers()) do
						if p ~= localPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
							local dist = (localPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
							if dist < 15 then 
								knife:Activate()
								if knife:FindFirstChild("Stab") then knife.Stab:FireServer(p.Character.HumanoidRootPart.Position) end
							end
						end
					end
				end
				task.wait(0.1)
			end
		end)
	end)

	-- 3. Gun Drop ESP
	local gunEspActive = false
	createCommand("🔫 Gun & Drop ESP", 175, function(state)
		gunEspActive = state
		task.spawn(function()
			while gunEspActive do
				local gunDrop = game.Workspace:FindFirstChild("GunDrop") or game.Workspace:FindFirstChild("WeaponDrop")
				if gunDrop and gunEspActive then
					local hl = gunDrop:FindFirstChild("GunESP") or Instance.new("Highlight", gunDrop)
					hl.Name = "GunESP"
					hl.FillColor = Color3.fromRGB(255, 255, 0) 
					hl.FillTransparency = 0.2
				end
				task.wait(1)
			end
			local oldDrop = game.Workspace:FindFirstChild("GunDrop") or game.Workspace:FindFirstChild("WeaponDrop")
			if oldDrop and oldDrop:FindFirstChild("GunESP") then oldDrop.GunESP:Destroy() end
		end)
	end)

	-- 4. Full Player ESP
	local espActive = false
	createCommand("🔴 Player & Role ESP", 215, function(state)
		espActive = state
		task.spawn(function()
			while espActive do
				for _, p in pairs(players:GetPlayers()) do
					if p ~= localPlayer and p.Character then
						local box = p.Character:FindFirstChild("UniESP")
						if espActive then
							if not box then box = Instance.new("Highlight", p.Character) box.Name = "UniESP" box.FillTransparency = 0.4 end
                    
