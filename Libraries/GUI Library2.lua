local Library = {}
function Library:Create(text)
	if game.CoreGui:FindFirstChild("ProjectCatUI") then
		game.CoreGui:FindFirstChild("ProjectCatUI"):Destroy()	
	end
	local ProjectCatUI = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local TabButtons = Instance.new("Frame")
	local TabButtonsGrid = Instance.new("UIListLayout")
	local UICorner = Instance.new("UICorner")
	local Tabs = Instance.new("Folder")
	
	ProjectCatUI.Name = "ProjectCatUI"
	ProjectCatUI.Parent = game:WaitForChild("CoreGui")
	ProjectCatUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	Main.Name = "Main"
	Main.Parent = ProjectCatUI
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.672375262, -358, 0.199346408, 230)
	Main.Size = UDim2.new(0, 445, 0, 293)
	function dragify(Frame)
	dragToggle = nil
	dragSpeed = .25 -- You can edit this.
	dragInput = nil
	dragStart = nil
	dragPos = nil

	function updateInput(input)
	Delta = input.Position - dragStart
	Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	game:GetService("TweenService"):Create(Frame, TweenInfo.new(.25), {Position = Position}):Play()
	end

	Frame.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
	dragToggle = true
	dragStart = input.Position
	startPos = Frame.Position
	input.Changed:Connect(function()
	if (input.UserInputState == Enum.UserInputState.End) then
	dragToggle = false
	end
	end)
	end
	end)

	Frame.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
	dragInput = input
	end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input)
	if (input == dragInput and dragToggle) then
	updateInput(input)
	end
	end)
	end
	dragify(Main)
	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.0318017863, 0, 0.0242438726, 0)
	Title.Size = UDim2.new(0, 118, 0, 24)
	Title.Font = Enum.Font.GothamSemibold
	Title.Text = text or "Project: Cat"
	Title.TextColor3 = Color3.fromRGB(255, 87, 90)
	Title.TextSize = 15.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	TabButtons.Name = "TabButtons"
	TabButtons.Parent = Main
	TabButtons.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TabButtons.BackgroundTransparency = 1.000
	TabButtons.Position = UDim2.new(0.0339285508, 0, 0.130045921, 0)
	TabButtons.Size = UDim2.new(0, 107, 0, 247)

	TabButtonsGrid.Name = "TabButtonsGrid"
	TabButtonsGrid.Parent = TabButtons
	TabButtonsGrid.SortOrder = Enum.SortOrder.LayoutOrder
	TabButtonsGrid.Padding = UDim.new(0, 9)


	UICorner.CornerRadius = UDim.new(0.00999999978, 1)
	UICorner.Parent = Main



	Tabs.Name = "Tabs"
	Tabs.Parent = Main
	local Stuff = {}
	function Stuff:Tab(name)
		local TabButton = Instance.new("TextButton")
		local TabButtonText = Instance.new("TextLabel")
		local TabButtonUnderlay = Instance.new("Frame")
		local TabButtonUnderlayCorner = Instance.new("UICorner")
		local Tab = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")

		TabButton.Name = "TabButton"
		TabButton.Parent = TabButtons
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.BackgroundTransparency = 1.000
		TabButton.Position = UDim2.new(0, 0, 0.125506073, 0)
		TabButton.Size = UDim2.new(0, 107, 0, 22)
		TabButton.Font = Enum.Font.SourceSans
		TabButton.Text = " "
		TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		TabButton.TextSize = 14.000

		TabButtonText.Name = "TabButtonText"
		TabButtonText.Parent = TabButton
		TabButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButtonText.BackgroundTransparency = 1.000
		TabButtonText.Position = UDim2.new(0.0180615745, 0, 0, 0)
		TabButtonText.Size = UDim2.new(0, 95, 0, 16)
		TabButtonText.Text = name or "egg"		
		TabButtonText.Font = Enum.Font.Gotham
		TabButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButtonText.TextSize = 14.000
		TabButtonText.TextTransparency = 0.5
		TabButtonText.TextXAlignment = Enum.TextXAlignment.Left
		TabButtonText.TextYAlignment = Enum.TextYAlignment.Bottom

		TabButtonUnderlay.Name = "TabButtonUnderlay"
		TabButtonUnderlay.Parent = TabButton
		TabButtonUnderlay.BackgroundColor3 = Color3.fromRGB(255, 87, 90)
		TabButtonUnderlay.BorderSizePixel = 0
		TabButtonUnderlay.Position = UDim2.new(0, 0, 0.850000024, 0)
		TabButtonUnderlay.Size = UDim2.new(0, 0, 0, 1)

		TabButtonUnderlayCorner.Name = "TabButtonUnderlayCorner"
		TabButtonUnderlayCorner.Parent = TabButtonUnderlay

		Tab.Name = "Tab"
		Tab.Parent = Tabs
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.BackgroundTransparency = 1.000
		Tab.BorderSizePixel = 0
		Tab.Position = UDim2.new(0.2764045, 0, 0.0238907859, 0)
		Tab.Size = UDim2.new(0, 314, 0, 278)
		Tab.Visible = false
		Tab.ScrollBarThickness = 5

		UIListLayout.Parent = Tab
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)
		TabButton.MouseButton1Down:Connect(function()
			for i,v in pairs(Tabs:GetChildren()) do
				v.Visible = false
			end
			for i,v in pairs(TabButtons:GetDescendants()) do
				if v.Name == "TabButtonText" then
					v.TextTransparency = 0.5
				end
				if v ~= TabButtonUnderlay and v.Name == "TabButtonUnderlay" then
					v:TweenSize(UDim2.new(0, 0, 0, 1),Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.2,false)
				end
			end
			TabButtonText.TextTransparency = 0
			Tab.Visible = true
			TabButtonUnderlay:TweenSize(UDim2.new(0, 15, 0, 1),Enum.EasingDirection.In,Enum.EasingStyle.Quad,0.2,false)
		end)
		local Stuff = {}
		function Stuff:Line()
			local Line = Instance.new("Frame")
			local LineCorner = Instance.new("UICorner")
			
			Line.Name = "Label"
			Line.Parent = Tab
			Line.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			Line.Size = UDim2.new(0, 300, 0, 4)
			
			LineCorner.CornerRadius = UDim.new(0.100000001, 1)
			LineCorner.Name = "LabelCorner"
			LineCorner.Parent = Line
		end
		
		function Stuff:Label(nenene)
			local Label = Instance.new("Frame")
			local LabelText = Instance.new("TextLabel")
			local LabelCorner = Instance.new("UICorner")
			
			Label.Name = "Label"
			Label.Parent = Tab
			Label.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			Label.Size = UDim2.new(0, 300, 0, 31)

			LabelText.Name = "LabelText"
			LabelText.Parent = Label
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.Position = UDim2.new(0.0299999993, 0, 0.161290318, 0)
			LabelText.Size = UDim2.new(0, 291, 0, 21)
			LabelText.Font = Enum.Font.Gotham
			LabelText.Text = nenene or "There's around 21% of O2 in air"
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.TextSize = 14.000
			LabelText.TextXAlignment = Enum.TextXAlignment.Left

			LabelCorner.CornerRadius = UDim.new(0.100000001, 1)
			LabelCorner.Name = "LabelCorner"
			LabelCorner.Parent = Label
		end
		function Stuff:Button(nane, callback)
			local Button = Instance.new("TextButton")
			local ButtonCorner = Instance.new("UICorner")
			local ButtonText = Instance.new("TextLabel")

			Button.Name = "Button"
			Button.Parent = Tab
			Button.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			Button.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Button.Size = UDim2.new(0, 300, 0, 31)
			Button.Font = Enum.Font.SourceSans
			Button.Text = " "
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 14.000

			ButtonCorner.CornerRadius = UDim.new(0.100000001, 1)
			ButtonCorner.Name = "ButtonCorner"
			ButtonCorner.Parent = Button

			ButtonText.Name = "ButtonText"
			ButtonText.Parent = Button
			ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.BackgroundTransparency = 1.000
			ButtonText.Position = UDim2.new(0.0299999993, 0, 0.161290318, 0)
			ButtonText.Size = UDim2.new(0, 291, 0, 21)
			ButtonText.Font = Enum.Font.Gotham
			ButtonText.Text = nane or "Execute Fatal Error"
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.TextSize = 14.000
			ButtonText.TextXAlignment = Enum.TextXAlignment.Left
			Button.MouseButton1Down:Connect(callback)
		end
		function Stuff:Toggle(gjfdgkjfdglf,callback)
			local Toggle = Instance.new("TextButton")
			local ToggleCorner = Instance.new("UICorner")
			local ToggleText = Instance.new("TextLabel")
			local ToggleCheck = Instance.new("Frame")
			local ToggleCheckCorner = Instance.new("UICorner")

			Toggle.Name = "Toggle"
			Toggle.Parent = Tab
			Toggle.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			Toggle.Size = UDim2.new(0, 300, 0, 31)
			Toggle.Font = Enum.Font.SourceSans
			Toggle.Text = " "
			Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			Toggle.TextSize = 14.000

			ToggleCorner.CornerRadius = UDim.new(0.100000001, 1)
			ToggleCorner.Name = "ToggleCorner"
			ToggleCorner.Parent = Toggle

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = Toggle
			ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.BackgroundTransparency = 1.000
			ToggleText.Position = UDim2.new(0.0299999993, 0, 0.161290318, 0)
			ToggleText.Size = UDim2.new(0, 239, 0, 21)
			ToggleText.Font = Enum.Font.Gotham
			ToggleText.Text = gjfdgkjfdglf or "Joe mama is: False"
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.TextSize = 14.000
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left

			ToggleCheck.Name = "ToggleCheck"
			ToggleCheck.Parent = Toggle
			ToggleCheck.BackgroundColor3 = Color3.fromRGB(255, 56, 59)
			ToggleCheck.Position = UDim2.new(0.910000026, 0, 0.161290318, 0)
			ToggleCheck.Size = UDim2.new(0, 21, 0, 21)

			ToggleCheckCorner.CornerRadius = UDim.new(0.100000001, 1)
			ToggleCheckCorner.Name = "ToggleCheckCorner"
			ToggleCheckCorner.Parent = ToggleCheck
			-- rain thing
			local TweenService = game:GetService("TweenService")
			local function TweenColor(Object, Property)
				local Tween = TweenService:Create(Object, TweenInfo.new(Property["Time"]), {BackgroundColor3= Property["BackgroundColor3"]}):Play()

				return Tween
			end
			
			Toggle.MouseButton1Click:Connect(function()
				state = not state
				callback(state)
				if state then
					TweenColor(ToggleCheck, {
						["Time"] = 0.2,
						["BackgroundColor3"] = Color3.fromRGB(34, 161, 74)
					})
				else
					TweenColor(ToggleCheck, {
						["Time"] = 0.2,
						["BackgroundColor3"] = Color3.fromRGB(255, 56, 59)
					})
				end
			end)
		end
		function Stuff:TextBox(namegfrsjghf, callback)
			local TextBox = Instance.new("TextButton")
			local TextBoxCorner = Instance.new("UICorner")
			local TextBoxText = Instance.new("TextLabel")
			local TextBoxMain = Instance.new("TextBox")
			local TextBoxMainCorner = Instance.new("UICorner")

			TextBox.Name = "TextBox"
			TextBox.Parent = Tab
			TextBox.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			TextBox.Size = UDim2.new(0, 300, 0, 31)
			TextBox.Font = Enum.Font.SourceSans
			TextBox.Text = " "
			TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextBox.TextSize = 14.000

			TextBoxCorner.CornerRadius = UDim.new(0.100000001, 1)
			TextBoxCorner.Name = "TextBoxCorner"
			TextBoxCorner.Parent = TextBox

			TextBoxText.Name = "TextBoxText"
			TextBoxText.Parent = TextBox
			TextBoxText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextBoxText.BackgroundTransparency = 1.000
			TextBoxText.Position = UDim2.new(0.0299999993, 0, 0.161290318, 0)
			TextBoxText.Size = UDim2.new(0, 206, 0, 21)
			TextBoxText.Font = Enum.Font.Gotham
			TextBoxText.Text = namegfrsjghf
			TextBoxText.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBoxText.TextSize = 14.000
			TextBoxText.TextXAlignment = Enum.TextXAlignment.Left

			TextBoxMain.Name = "TextBoxMain"
			TextBoxMain.Parent = TextBox
			TextBoxMain.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			TextBoxMain.BorderSizePixel = 0
			TextBoxMain.Position = UDim2.new(0.716666639, 0, 0.161290318, 0)
			TextBoxMain.Size = UDim2.new(0, 79, 0, 21)
			TextBoxMain.Font = Enum.Font.Gotham
			TextBoxMain.PlaceholderText = "Input Here"
			TextBoxMain.Text = ""
			TextBoxMain.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextBoxMain.TextSize = 13.000

			TextBoxMainCorner.CornerRadius = UDim.new(0.100000001, 1)
			TextBoxMainCorner.Name = "TextBoxMainCorner"
			TextBoxMainCorner.Parent = TextBoxMain
			TextBoxMain.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					if callback then
						callback(TextBoxMain.Text)
					end
					TextBoxMain.Text = ""
				end
			end)
			
		end
		return Stuff
	end
	return Stuff
end
return Library
