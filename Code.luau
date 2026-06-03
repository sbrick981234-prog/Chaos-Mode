-----/Settings/-----
local Settings = {
	["ChaosInterval"] = 15;
	["ChaosHard"] = 1;
}

-----/Services/-----
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

-----/Variables/-----
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Backpack = Player:WaitForChild("Backpack")

local Camera = Workspace.CurrentCamera
local Mouse = Player:GetMouse()

local ChaosTimer = Settings["ChaosInterval"]

-----/GUI/-----
local LoadedScreenGui = nil

local LoadedTimer = nil
local LoadedEvent = nil

function GiveGUI(Player)
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "ChaosGui"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.IgnoreGuiInset = true
	ScreenGui.DisplayOrder = 999999999999999
	ScreenGui.Parent = Player.PlayerGui

	LoadedScreenGui = ScreenGui

	local MainFrame = Instance.new("Frame")
	MainFrame.Size = UDim2.fromOffset(250, 90)
	MainFrame.Position = UDim2.new(0.5, -125, 0.05, 0)
	MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	MainFrame.BorderSizePixel = 0
	MainFrame.ZIndex = 999999999999999
	MainFrame.Parent = ScreenGui

	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 8)
	UICorner.Parent = MainFrame

	local UIStroke = Instance.new("UIStroke")
	UIStroke.Color = Color3.fromRGB(255, 50, 50)
	UIStroke.Thickness = 2
	UIStroke.Parent = MainFrame

	local Title = Instance.new("TextLabel")
	Title.Size = UDim2.new(1, 0, 0, 25)
	Title.BackgroundTransparency = 1
	Title.Text = "-=[CHAOS MODE]=-"
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextScaled = true
	Title.Font = Enum.Font.GothamBold
	Title.Parent = MainFrame

	local Timer = Instance.new("TextLabel")
	Timer.Name = "Timer"
	Timer.Size = UDim2.new(1, 0, 0, 35)
	Timer.Position = UDim2.new(0, 0, 0, 25)
	Timer.BackgroundTransparency = 1
	Timer.Text = "00:00"
	Timer.TextColor3 = Color3.fromRGB(255, 80, 80)
	Timer.TextScaled = true
	Timer.Font = Enum.Font.GothamBlack
	Timer.Parent = MainFrame

	LoadedTimer = Timer

	local EventName = Instance.new("TextLabel")
	EventName.Name = "EventName"
	EventName.Size = UDim2.new(1, 0, 0, 20)
	EventName.Position = UDim2.new(0, 0, 0, 65)
	EventName.BackgroundTransparency = 1
	EventName.Text = "[NONE]"
	EventName.TextColor3 = Color3.fromRGB(200, 200, 200)
	EventName.TextScaled = true
	EventName.Font = Enum.Font.Gotham
	EventName.Parent = MainFrame

	LoadedEvent = EventName
end

-----/Functions/-----

function EventChaos(EventName)
	spawn(function()
		print("Started : [" .. EventName .. "]")

		LoadedEvent.Text = "[" .. EventName .. "]"

		task.wait(3)

		LoadedEvent.Text = "[NONE]"
	end)
end

-----/Main/-----
function Chaos(Character)
	spawn(function()
		print("-=[CHAOS MODE ACTIVATED]=-")

		spawn(function()
			while ChaosTimer > 0 do
				if LoadedTimer then
					ChaosTimer = ChaosTimer - 1
				else
					ChaosTimer = Settings["ChaosInterval"]

					break
				end

				task.wait(1)

				if LoadedTimer then
					LoadedTimer.Text = ChaosTimer
				end

				if ChaosTimer == 0 then
					ChaosTimer = Settings["ChaosInterval"]

					local Character = Player.Character

					local Humanoid = Character:WaitForChild("Humanoid")
					local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

					local RandomEvent = math.random(1, 6)

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
							local RandomSpeed = math.random(100, 250) * Settings["ChaosHard"]

							Humanoid.WalkSpeed = RandomSpeed
						end
					end)

					spawn(function()
						if RandomEvent == 3 then EventChaos("Drunk")	
							RunService.RenderStepped:Connect(function()
								local Character = Player.Character
								
								if not Character then return end

								local Humanoid = Character:FindFirstChildOfClass("Humanoid")
								
								if not Humanoid then return end

								local X = 0
								local Z = 0

								if UserInputService:IsKeyDown(Enum.KeyCode.W) then
									Z += 1
								end

								if UserInputService:IsKeyDown(Enum.KeyCode.S) then
									Z -= 1
								end

								if UserInputService:IsKeyDown(Enum.KeyCode.A) then
									X += 1
								end

								if UserInputService:IsKeyDown(Enum.KeyCode.D) then
									X -= 1
								end

								Humanoid:Move(Vector3.new(X, 0, Z), true)
							end)
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
					
					spawn(function()
						if RandomEvent == 6 then EventChaos("White-Black")
							local ColorCorrection = Instance.new("ColorCorrectionEffect")
							
							ColorCorrection.Name = "ChaosBlackWhite"
							ColorCorrection.Saturation = -1
							ColorCorrection.Parent = Lighting
						end
					end)
				end
			end
		end)
	end)
end

spawn(function()
	Chaos(Player.Character)

	GiveGUI(Player)
end)
