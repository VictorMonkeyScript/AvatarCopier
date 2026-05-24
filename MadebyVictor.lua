--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local lastUsername = nil

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MonkeyChangerUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

--// MAIN FRAME
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 340, 0, 190)
Frame.Position = UDim2.new(0.5, -170, 0.5, -95)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Frame.Active = true

Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,12)

local Stroke = Instance.new("UIStroke")
Stroke.Parent = Frame
Stroke.Color = Color3.fromRGB(0,255,170)
Stroke.Thickness = 2

--// GLOW EFFECT
task.spawn(function()
	while true do

		TweenService:Create(
			Stroke,
			TweenInfo.new(1),
			{Transparency = 0.15}
		):Play()

		task.wait(1)

		TweenService:Create(
			Stroke,
			TweenInfo.new(1),
			{Transparency = 0.65}
		):Play()

		task.wait(1)
	end
end)

--// TITLE
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.Size = UDim2.new(1,-90,0,45)
Title.Position = UDim2.new(0,10,0,0)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Text = "Mönkey Script Changer"
Title.Font = Enum.Font.GothamBlack
Title.TextScaled = true
Title.TextColor3 = Color3.new(1,1,1)

local TitleStroke = Instance.new("UIStroke")
TitleStroke.Parent = Title
TitleStroke.Color = Color3.fromRGB(0,255,170)
TitleStroke.Thickness = 2

--// FLOATING TITLE
task.spawn(function()
	while true do

		TweenService:Create(
			Title,
			TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
			{Position = UDim2.new(0,10,0,2)}
		):Play()

		task.wait(1.5)

		TweenService:Create(
			Title,
			TweenInfo.new(1.5,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),
			{Position = UDim2.new(0,10,0,-2)}
		):Play()

		task.wait(1.5)
	end
end)

--// USERNAME BOX
local UsernameBox = Instance.new("TextBox")
UsernameBox.Parent = Frame
UsernameBox.Size = UDim2.new(0.84,0,0,42)
UsernameBox.Position = UDim2.new(0.08,0,0.36,0)
UsernameBox.PlaceholderText = "Enter Username..."
UsernameBox.Text = ""
UsernameBox.Font = Enum.Font.GothamBold
UsernameBox.TextSize = 18
UsernameBox.TextColor3 = Color3.new(1,1,1)
UsernameBox.PlaceholderColor3 = Color3.fromRGB(180,180,180)
UsernameBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
UsernameBox.BorderSizePixel = 0

Instance.new("UICorner", UsernameBox).CornerRadius = UDim.new(0,8)

--// COPY BUTTON
local CopyButton = Instance.new("TextButton")
CopyButton.Parent = Frame
CopyButton.Size = UDim2.new(0.84,0,0,42)
CopyButton.Position = UDim2.new(0.08,0,0.67,0)
CopyButton.Text = "COPY AVATAR"
CopyButton.Font = Enum.Font.GothamBlack
CopyButton.TextSize = 18
CopyButton.TextColor3 = Color3.new(1,1,1)
CopyButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
CopyButton.BorderSizePixel = 0

Instance.new("UICorner", CopyButton).CornerRadius = UDim.new(0,8)

--// CLOSE BUTTON
local CloseBtn = Instance.new("TextButton")
CloseBtn.Parent = Frame
CloseBtn.Size = UDim2.new(0,28,0,28)
CloseBtn.Position = UDim2.new(1,-35,0,8)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBlack
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.new(1,1,1)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255,70,70)
CloseBtn.BorderSizePixel = 0

Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(1,0)

--// HIDE BUTTON
local HideBtn = Instance.new("TextButton")
HideBtn.Parent = Frame
HideBtn.Size = UDim2.new(0,28,0,28)
HideBtn.Position = UDim2.new(1,-70,0,8)
HideBtn.Text = "-"
HideBtn.Font = Enum.Font.GothamBlack
HideBtn.TextSize = 22
HideBtn.TextColor3 = Color3.new(1,1,1)
HideBtn.BackgroundColor3 = Color3.fromRGB(255,170,0)
HideBtn.BorderSizePixel = 0

Instance.new("UICorner", HideBtn).CornerRadius = UDim.new(1,0)

--// MINI BUTTON
local MiniButton = Instance.new("TextButton")
MiniButton.Parent = ScreenGui
MiniButton.Visible = false
MiniButton.Size = UDim2.new(0,95,0,35)
MiniButton.Position = UDim2.new(0,100,0,100)
MiniButton.Text = "OPEN UI"
MiniButton.Font = Enum.Font.GothamBlack
MiniButton.TextSize = 14
MiniButton.TextColor3 = Color3.new(1,1,1)
MiniButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
MiniButton.BorderSizePixel = 0
MiniButton.Active = true

Instance.new("UICorner", MiniButton).CornerRadius = UDim.new(0,8)

--// HIDE UI
HideBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
	MiniButton.Visible = true
end)

--// OPEN UI
MiniButton.MouseButton1Click:Connect(function()
	Frame.Visible = true
	MiniButton.Visible = false
end)

--// CLOSE UI
CloseBtn.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

--// MOVABLE MAIN UI
local dragging = false
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - dragStart

		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false
	end
end)

--// MOVABLE MINI BUTTON
local miniDragging = false
local miniDragStart
local miniStartPos

MiniButton.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		miniDragging = true
		miniDragStart = input.Position
		miniStartPos = MiniButton.Position
	end
end)

UIS.InputChanged:Connect(function(input)

	if miniDragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then

		local delta = input.Position - miniDragStart

		MiniButton.Position = UDim2.new(
			miniStartPos.X.Scale,
			miniStartPos.X.Offset + delta.X,
			miniStartPos.Y.Scale,
			miniStartPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then

		miniDragging = false
	end
end)

--// AVATAR CHANGER
local function apply_avatar(username)

	task.spawn(function()

		local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
		local hum = char:WaitForChild("Humanoid",10)

		if not hum then
			return
		end

		local targetPlayer = nil

		for _,p in ipairs(Players:GetPlayers()) do
			if p.Name:lower() == username:lower() then
				targetPlayer = p
				break
			end
		end

		local desc

		if targetPlayer and targetPlayer.Character then
			local targetHum = targetPlayer.Character:FindFirstChildOfClass("Humanoid")

			if targetHum then
				desc = targetHum:GetAppliedDescription()
			end
		end

		if not desc then

			local ok,userId = pcall(function()
				return Players:GetUserIdFromNameAsync(username)
			end)

			if not ok then
				warn("User not found")
				return
			end

			local ok2,d = pcall(function()
				return Players:GetHumanoidDescriptionFromUserId(userId)
			end)

			if not ok2 then
				warn("Failed getting avatar")
				return
			end

			desc = d
		end

		for _,c in ipairs(char:GetChildren()) do

			if c:IsA("Accessory")
			or c:IsA("Hat")
			or c:IsA("BodyColors")
			or c:IsA("CharacterMesh")
			or c:IsA("Shirt")
			or c:IsA("Pants")
			or c:IsA("ShirtGraphic") then

				c:Destroy()
			end
		end

		pcall(function()

			if hum.ApplyDescriptionClientServer then
				hum:ApplyDescriptionClientServer(desc)
			else
				hum:ApplyDescription(desc)
			end
		end)

		local bc = char:FindFirstChildOfClass("BodyColors") or Instance.new("BodyColors")

		bc.Parent = char
		bc.HeadColor3 = desc.HeadColor
		bc.TorsoColor3 = desc.TorsoColor
		bc.LeftArmColor3 = desc.LeftArmColor
		bc.RightArmColor3 = desc.RightArmColor
		bc.LeftLegColor3 = desc.LeftLegColor
		bc.RightLegColor3 = desc.RightLegColor
	end)
end

LocalPlayer.CharacterAdded:Connect(function()

	if lastUsername then
		task.wait(0.65)
		apply_avatar(lastUsername)
	end
end)

local function start(username)
	lastUsername = username
	apply_avatar(username)
end

CopyButton.MouseButton1Click:Connect(function()

	local username = UsernameBox.Text

	if username ~= "" then

		start(username)

		CopyButton.Text = "COPIED!"

		task.wait(1)

		CopyButton.Text = "COPY AVATAR"
	end
end)
