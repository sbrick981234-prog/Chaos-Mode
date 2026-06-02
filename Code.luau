-----/Settings/-----
local Settings = {
	["ChaosInterval"] = 15;
	["ChaosHard"] = 1;
}

-----/Services/-----
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-----/Variables/-----
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")

local Camera = Workspace.CurrentCamera
local Mouse = Player:GetMouse()

local ChaosTimer = 15

-----/GUI/-----
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChaosGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = Player.PlayerGui

local GUIMainFrame = Instance.new("Frame")
GUIMainFrame.Size = UDim2.fromOffset(250, 90)
GUIMainFrame.Position = UDim2.new(0.5, -125, 0.05, 0)
GUIMainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
GUIMainFrame.BorderSizePixel = 0
GUIMainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = GUIMainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 50, 50)
UIStroke.Thickness = 2
UIStroke.Parent = GUIMainFrame

local GUITitle = Instance.new("TextLabel")
GUITitle.Size = UDim2.new(1, 0, 0, 25)
GUITitle.BackgroundTransparency = 1
GUITitle.Text = "-=[CHAOS MODE]=-"
GUITitle.TextColor3 = Color3.fromRGB(255, 255, 255)
GUITitle.TextScaled = true
GUITitle.Font = Enum.Font.GothamBold
GUITitle.Parent = GUIMainFrame

local GUITimer = Instance.new("TextLabel")
GUITimer.Name = "Timer"
GUITimer.Size = UDim2.new(1, 0, 0, 35)
GUITimer.Position = UDim2.new(0, 0, 0, 25)
GUITimer.BackgroundTransparency = 1
GUITimer.Text = "00:00"
GUITimer.TextColor3 = Color3.fromRGB(255, 80, 80)
GUITimer.TextScaled = true
GUITimer.Font = Enum.Font.GothamBlack
GUITimer.Parent = GUIMainFrame

local GUIEventName = Instance.new("TextLabel")
GUIEventName.Name = "EventName"
GUIEventName.Size = UDim2.new(1, 0, 0, 20)
GUIEventName.Position = UDim2.new(0, 0, 0, 65)
GUIEventName.BackgroundTransparency = 1
GUIEventName.Text = "[NONE]"
GUIEventName.TextColor3 = Color3.fromRGB(200, 200, 200)
GUIEventName.TextScaled = true
GUIEventName.Font = Enum.Font.Gotham
GUIEventName.Parent = GUIMainFrame

-----/Functions/-----

function EventChaos(EventName)
	spawn(function()
		print("Started : [" .. EventName .. "]")

		GUIEventName.Text = "[" .. EventName .. "]"

		task.wait(3)

		GUIEventName.Text = "[NONE]"
	end)
end

-----/Main/-----
function Chaos(Character)
	spawn(function()
		print("-=[CHAOS MODE ACTIVATED]=-")

		local Humanoid = Character:WaitForChild("Humanoid")
		local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

		while true do
			spawn(function()
				while ChaosTimer > 0 do
					ChaosTimer = ChaosTimer - 1

					GUITimer.Text = ChaosTimer

					task.wait(1)

					if ChaosTimer == 0 then
						ChaosTimer = Settings["ChaosInterval"]
					end
				end
			end)
			
			task.wait(Settings["ChaosInterval"])

			if not Character then
				break
			end

			local RandomEvent = math.random(1, 5)

			spawn(function()
				if RandomEvent == 1 then EventChaos("Flip")
					local NewOrientation = CFrame.Angles(0, 0, math.rad(180))

					Humanoid.PlatformStand = true

					HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * NewOrientation

					task.wait(0.1)

					Humanoid.PlatformStand = false
				end
			end)

			spawn(function()
				if RandomEvent == 2 then EventChaos("Random speed")	
					local RandomSpeed = math.random(0, 100) * Settings["ChaosHard"]

					Humanoid.WalkSpeed = RandomSpeed
				end
			end)

			spawn(function()
				if RandomEvent == 3 then EventChaos("Random jump")	
					local RandomJumpPower = math.random(0, 100) * Settings["ChaosHard"]
					local RandomJumpHeight = math.random(0, 100) * Settings["ChaosHard"]

					Humanoid.JumpPower = RandomJumpPower
					Humanoid.JumpHeight = RandomJumpHeight
				end
			end)

			spawn(function()
				if RandomEvent == 4 then EventChaos("Fling")
					local Velocity = Vector3.new(math.random(-100, 100), math.random(0, 200), math.random(-100, 100)) * Settings["ChaosHard"]

					local BodyVelocity = Instance.new("BodyVelocity")
					BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
					BodyVelocity.Velocity = Velocity
					BodyVelocity.Parent = HumanoidRootPart

					Debris:AddItem(BodyVelocity, 0.1)
				end
			end)

			spawn(function()
				if RandomEvent == 5 then EventChaos("Sit")
					Humanoid.Sit = true
				end
			end)
		end
	end)
end

Player.CharacterAdded:Connect(function(Character)
	Chaos(Character)
end)

spawn(function()
	Chaos(Player.Character)
end)
