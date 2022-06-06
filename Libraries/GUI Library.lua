local Library = {}


function confirm()
	local sound = Instance.new("Sound", game.StarterGui)
	sound.Archivable = true
	sound.SoundId = "rbxassetid://537744814"
	sound:Play()
	wait(2)
	sound:Destroy()
end

function Library:UI(name)
   if game.CoreGui:FindFirstChild("Blueify") then
    game.CoreGui.Blueify:Destroy()
  end
	local Nacreous = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TabsFramePart = Instance.new("Frame")
	local UICornerScrollTab = Instance.new("UICorner")
	local KEEPTHIS = Instance.new("Frame")
	local ListLayoutScrollTab = Instance.new("UIListLayout")
	local TopBar = Instance.new("Frame")
	local TopBarUICorner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local Containers = Instance.new("Folder")
	
	local Shadow = Instance.new("ImageLabel")

	Nacreous.Name = "Blueify"
	Nacreous.Parent = game.CoreGui

	Main.Name = "Main"
	Main.Parent = Nacreous
	Main.BackgroundColor3 = Color3.fromRGB(36, 37, 43)
	Main.Position = UDim2.new(0.315237522, 0, 0.261349678, 0)
	Main.Size = UDim2.new(0, 645, 0, 388)

	UICorner.CornerRadius = UDim.new(0.00999999978, 1)
	UICorner.Parent = Main

	TabsFramePart.Name = "TabsFramePart"
	TabsFramePart.Parent = Main
	TabsFramePart.BackgroundColor3 = Color3.fromRGB(27, 28, 31)
	TabsFramePart.Position = UDim2.new(0.793895364, 0, 0.0154639175, 0)
	TabsFramePart.Size = UDim2.new(0, 124, 0, 371)

	UICornerScrollTab.CornerRadius = UDim.new(0.0250000004, 1)
	UICornerScrollTab.Name = "UICornerScrollTab"
	UICornerScrollTab.Parent = TabsFramePart

	KEEPTHIS.Name = "KEEPTHIS!"
	KEEPTHIS.Parent = TabsFramePart
	KEEPTHIS.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	KEEPTHIS.BackgroundTransparency = 1.000
	KEEPTHIS.Size = UDim2.new(0, 124, 0, 6)

	ListLayoutScrollTab.Name = "ListLayoutScrollTab"
	ListLayoutScrollTab.Parent = TabsFramePart
	ListLayoutScrollTab.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListLayoutScrollTab.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayoutScrollTab.Padding = UDim.new(0, 2)



	TopBar.Name = "TopBar"
	TopBar.Parent = Main
	TopBar.BackgroundColor3 = Color3.fromRGB(27, 28, 31)
	TopBar.Position = UDim2.new(0.00930232555, 0, 0.0154639175, 0)
	TopBar.Size = UDim2.new(0, 498, 0, 36)

	TopBarUICorner.CornerRadius = UDim.new(0.100000001, 1)
	TopBarUICorner.Name = "TopBarUICorner"
	TopBarUICorner.Parent = TopBar

	Title.Name = "Title"
	Title.Parent = TopBar
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.Position = UDim2.new(0.0220000297, 0, 0, 0)
	Title.Size = UDim2.new(0, 442, 0, 36)
	Title.Font = Enum.Font.Gotham
	Title.Text = name
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	Containers.Name = "Containers"
	Containers.Parent = Main
	

	Shadow.Name = "Shadow"
	Shadow.Parent = Main
	Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Shadow.BackgroundTransparency = 1.000
	Shadow.Position = UDim2.new(-0.0558139533, 0, -0.0567010306, 0)
	Shadow.Rotation = 0.000
	Shadow.Size = UDim2.new(0, 716, 0, 432)
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5554236805"
	Shadow.ImageColor3 = Color3.fromRGB(19, 27, 36)
	
	pcall(function()
		function dragify(Frame)
			dragToggle = nil
			dragSpeed = .1 -- You can edit this.
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
	end)
	dragify(Main)
	local Things = {}
		function Things:Tab(name)
		local ButtonForTab = Instance.new("TextButton")
		local ButtonForTabUICorneer = Instance.new("UICorner")
		local Tab = Instance.new("Frame")
		local ContainerUICorner = Instance.new("UICorner")
		local ScrollingFrame = Instance.new("ScrollingFrame")
		local ScrollingFrameList = Instance.new("UIListLayout")
		local KEEPTHIStab = Instance.new("Frame")
		
		ButtonForTab.Name = "ButtonForTab"
		ButtonForTab.Parent = TabsFramePart
		ButtonForTab.BackgroundColor3 = Color3.fromRGB(73, 100, 134)
		ButtonForTab.Position = UDim2.new(0.0927419364, 0, 0.0161725059, 0)
		ButtonForTab.Size = UDim2.new(0, 112, 0, 24)
		ButtonForTab.Font = Enum.Font.Gotham
		ButtonForTab.TextColor3 = Color3.fromRGB(255, 255, 255)
		ButtonForTab.TextSize = 14.000
		ButtonForTab.Text = name
		ButtonForTabUICorneer.CornerRadius = UDim.new(0.100000001, 1)
		ButtonForTabUICorneer.Name = "ButtonForTabUICorneer"
		ButtonForTabUICorneer.Parent = ButtonForTab
		Tab.Name = "Tab"
		Tab.Parent = Containers
		Tab.BackgroundColor3 = Color3.fromRGB(27, 28, 31)
		Tab.Position = UDim2.new(0.00930232555, 0, 0.126288652, 0)
		Tab.Size = UDim2.new(0, 498, 0, 328)
		Tab.Visible = false

		ContainerUICorner.CornerRadius = UDim.new(0.00999999978, 1)
		ContainerUICorner.Name = "ContainerUICorner"
		ContainerUICorner.Parent = Tab

		ScrollingFrame.Parent = Tab
		ScrollingFrame.Active = true
		ScrollingFrame.BackgroundColor3 = Color3.fromRGB(27, 28, 31)
		ScrollingFrame.BackgroundTransparency = 0.900
		ScrollingFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
		ScrollingFrame.BorderSizePixel = 0
		ScrollingFrame.Position = UDim2.new(0.00930234604, 0, 0, 0)
		ScrollingFrame.Size = UDim2.new(0, 487, 0, 327)
		ScrollingFrame.ScrollBarThickness = 5

		ScrollingFrameList.Name = "ScrollingFrameList"
		ScrollingFrameList.Parent = ScrollingFrame
		ScrollingFrameList.SortOrder = Enum.SortOrder.LayoutOrder
		ScrollingFrameList.Padding = UDim.new(0, 4)

		KEEPTHIStab.Name = "KEEPTHIS!tab"
		KEEPTHIStab.Parent = ScrollingFrame
		KEEPTHIStab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		KEEPTHIStab.BackgroundTransparency = 1.000
		KEEPTHIStab.Size = UDim2.new(0, 129, 0, 1)
		ButtonForTab.MouseButton1Click:Connect(function()
			
			for i,v in next, Containers:GetChildren() do
				v.Visible = false
			end
			Tab.Visible = true
			confirm()
		end)
	local Things = {}
		function Things:HatScript(name,hatid,callback)
			local HatScript = Instance.new("Frame")
			local HatScriptUICorner = Instance.new("UICorner")
			local TextLabel = Instance.new("TextLabel")
			local HatScriptButton = Instance.new("TextButton")
			local HatScriptUICorner_2 = Instance.new("UICorner")
			local GetHats = Instance.new("TextButton")
			local GetHatsUIcorner = Instance.new("UICorner")


			HatScript.Name = "HatScript"
			HatScript.Parent = ScrollingFrame
			HatScript.BackgroundColor3 = Color3.fromRGB(41, 42, 47)
			HatScript.Size = UDim2.new(0, 471, 0, 30)

			HatScriptUICorner.CornerRadius = UDim.new(0.100000001, 1)
			HatScriptUICorner.Name = "HatScriptUICorner"
			HatScriptUICorner.Parent = HatScript

			TextLabel.Parent = HatScript
			TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.BackgroundTransparency = 1.000
			TextLabel.Position = UDim2.new(0.0135074295, 0, 0, 0)
			TextLabel.Size = UDim2.new(0, 295, 0, 30)
			TextLabel.Font = Enum.Font.Gotham
			TextLabel.Text = name
			TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextLabel.TextSize = 14.000
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left

			HatScriptButton.Name = "HatScriptButton"
			HatScriptButton.Parent = HatScript
			HatScriptButton.BackgroundColor3 = Color3.fromRGB(48, 161, 74)
			HatScriptButton.BorderSizePixel = 0
			HatScriptButton.Position = UDim2.new(0.821615636, 0, 0.124096677, 0)
			HatScriptButton.Size = UDim2.new(0, 78, 0, 22)
			HatScriptButton.Font = Enum.Font.Gotham
			HatScriptButton.Text = "Execute"
			HatScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			HatScriptButton.TextSize = 13.000
			HatScriptButton.MouseButton1Click:Connect(callback) -- this
			HatScriptButton.MouseButton1Click:Connect(function()
				confirm()
			end)
			HatScriptUICorner_2.CornerRadius = UDim.new(0.100000001, 1)
			HatScriptUICorner_2.Name = "HatScriptUICorner"
			HatScriptUICorner_2.Parent = HatScriptButton

			GetHats.Name = "GetHats"
			GetHats.Parent = HatScript
			GetHats.BackgroundColor3 = Color3.fromRGB(73, 100, 134)
			GetHats.BorderSizePixel = 0
			GetHats.Position = UDim2.new(0.641148567, 0, 0.124096677, 0)
			GetHats.Size = UDim2.new(0, 78, 0, 22)
			GetHats.Font = Enum.Font.Gotham
			GetHats.Text = "Get Hats"
			GetHats.TextColor3 = Color3.fromRGB(255, 255, 255)
			GetHats.TextSize = 13.000
			GetHats.MouseButton1Click:Connect(function()
				pcall(function()
					setclipboard(hatid)
					confirm()
				end)
			end)
			GetHatsUIcorner.CornerRadius = UDim.new(0.100000001, 1)
			GetHatsUIcorner.Name = "GetHatsUIcorner"
			GetHatsUIcorner.Parent = GetHats
		end
		function Things:Script(name,callback)

			local Script = Instance.new("Frame")
			local ScriptUICorner = Instance.new("UICorner")
			local ScriptLabel = Instance.new("TextLabel")
			local ScriptButton = Instance.new("TextButton")
			local ScriptButtonUICorner = Instance.new("UICorner")

			Script.Name = "Script"
			Script.Parent = ScrollingFrame
			Script.BackgroundColor3 = Color3.fromRGB(41, 42, 47)
			Script.Size = UDim2.new(0, 471, 0, 30)

			ScriptUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ScriptUICorner.Name = "ScriptUICorner"
			ScriptUICorner.Parent = Script

			ScriptLabel.Name = "ScriptLabel"
			ScriptLabel.Parent = Script
			ScriptLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScriptLabel.BackgroundTransparency = 1.000
			ScriptLabel.Position = UDim2.new(0.0135074295, 0, 0, 0)
			ScriptLabel.Size = UDim2.new(0, 295, 0, 30)
			ScriptLabel.Font = Enum.Font.Gotham
			ScriptLabel.Text = name
			
			ScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ScriptLabel.TextSize = 14.000
			ScriptLabel.TextXAlignment = Enum.TextXAlignment.Left

			ScriptButton.Name = "ScriptButton"
			ScriptButton.Parent = Script
			ScriptButton.BackgroundColor3 = Color3.fromRGB(48, 161, 74)
			ScriptButton.BorderSizePixel = 0
			ScriptButton.Position = UDim2.new(0.821615636, 0, 0.124096677, 0)
			ScriptButton.Size = UDim2.new(0, 78, 0, 22)
			ScriptButton.Font = Enum.Font.Gotham
			ScriptButton.Text = "Execute"
			ScriptButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ScriptButton.TextSize = 13.000
			ScriptButton.MouseButton1Click:Connect(callback)
			ScriptButton.MouseButton1Click:Connect(function()
				confirm()
			end)
			ScriptButtonUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ScriptButtonUICorner.Name = "ScriptButtonUICorner"
			ScriptButtonUICorner.Parent = ScriptButton
			
		end
		function Things:Button(name,callback)
			local Button = Instance.new("Frame")
			local ButtonUICorner = Instance.new("UICorner")
			local ButtonText = Instance.new("TextLabel")
			local ButtonButton = Instance.new("TextButton")
			local ButtonButtonUICorner = Instance.new("UICorner")
			
			Button.Name = "Button"
			Button.Parent = ScrollingFrame
			Button.BackgroundColor3 = Color3.fromRGB(41, 42, 47)
			Button.Size = UDim2.new(0, 471, 0, 30)

			ButtonUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ButtonUICorner.Name = "ButtonUICorner"
			ButtonUICorner.Parent = Button
			


			ButtonText.Name = "ButtonText"
			ButtonText.Parent = Button
			ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.BackgroundTransparency = 1.000
			ButtonText.Position = UDim2.new(0.0135074295, 0, 0, 0)
			ButtonText.Size = UDim2.new(0, 295, 0, 30)
			ButtonText.Font = Enum.Font.Gotham
			ButtonText.Text = name
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.TextSize = 14.000
			ButtonText.TextXAlignment = Enum.TextXAlignment.Left

			ButtonButton.Name = "ButtonButton"
			ButtonButton.Parent = Button
			ButtonButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
			ButtonButton.BorderSizePixel = 0
			ButtonButton.Position = UDim2.new(0.821615636, 0, 0.124096677, 0)
			ButtonButton.Size = UDim2.new(0, 78, 0, 22)
			ButtonButton.Font = Enum.Font.Gotham
			ButtonButton.Text = "Run"
			ButtonButton.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonButton.TextSize = 13.000
			ButtonButton.MouseButton1Click:Connect(callback)
			ButtonButton.MouseButton1Click:Connect(function()
				confirm()
			end)
			ButtonButtonUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ButtonButtonUICorner.Name = "ButtonButtonUICorner"
			ButtonButtonUICorner.Parent = ButtonButton
		end
		function Things:Label(name)
			local Label = Instance.new("Frame")
			local LabelCorner = Instance.new("UICorner")
			local LabelText = Instance.new("TextLabel")
			Label.Name = "Label"
			Label.Parent = ScrollingFrame
			Label.BackgroundColor3 = Color3.fromRGB(41, 42, 47)
			Label.Size = UDim2.new(0, 471, 0, 30)

			LabelCorner.CornerRadius = UDim.new(0.100000001, 1)
			LabelCorner.Name = "LabelCorner"
			LabelCorner.Parent = Label

			LabelText.Name = "LabelText"
			LabelText.Parent = Label
			LabelText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1.000
			LabelText.Position = UDim2.new(0.0135074295, 0, 0, 0)
			LabelText.Size = UDim2.new(0, 458, 0, 30)
			LabelText.Font = Enum.Font.Gotham
			LabelText.Text = name or "Boyfriend is a young, light-skinned man with spiky cyan hair. "
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.TextSize = 14.000
			LabelText.TextXAlignment = Enum.TextXAlignment.Left
		end
		function Things:Toggle(name,callback)
			local Toggle = Instance.new("Frame")
			local ToggleUICorner = Instance.new("UICorner")
			local ToggleText = Instance.new("TextLabel")
			local ToggleSwitch = Instance.new("TextButton")
			local ToggleSwitchUICorner = Instance.new("UICorner")
			


			Toggle.Name = "Toggle"
			Toggle.Parent = ScrollingFrame
			Toggle.BackgroundColor3 = Color3.fromRGB(41, 42, 47)
			Toggle.Size = UDim2.new(0, 471, 0, 30)

			ToggleUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ToggleUICorner.Name = "ToggleUICorner"
			ToggleUICorner.Parent = Toggle

			ToggleText.Name = "ToggleText"
			ToggleText.Parent = Toggle
			ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.BackgroundTransparency = 1.000
			ToggleText.Position = UDim2.new(0.0135074295, 0, 0, 0)
			ToggleText.Size = UDim2.new(0, 295, 0, 30)
			ToggleText.Font = Enum.Font.Gotham
			ToggleText.Text = name
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.TextSize = 14.000
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left

			ToggleSwitch.Name = "ToggleSwitch"
			ToggleSwitch.Parent = Toggle
			ToggleSwitch.BackgroundColor3 = Color3.fromRGB(161, 45, 34)
			ToggleSwitch.BorderSizePixel = 0
			ToggleSwitch.Position = UDim2.new(0.821615636, 0, 0.124096677, 0)
			ToggleSwitch.Size = UDim2.new(0, 78, 0, 22)
			ToggleSwitch.Font = Enum.Font.Gotham
			ToggleSwitch.Text = "False"
			ToggleSwitch.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleSwitch.TextSize = 13.000

			ToggleSwitchUICorner.CornerRadius = UDim.new(0.100000001, 1)
			ToggleSwitchUICorner.Name = "ToggleSwitchUICorner"
			ToggleSwitchUICorner.Parent = ToggleSwitch
			-- rain thing
			local TweenService = game:GetService("TweenService")
			local function TweenColor(Object, Property)
				local Tween = TweenService:Create(Object, TweenInfo.new(Property["Time"]), {BackgroundColor3= Property["BackgroundColor3"]}):Play()

				return Tween
			end
			ToggleSwitch.MouseButton1Click:Connect(function()
			state = not state
			callback(state) 
			if state then
					ToggleSwitch.Text = "True"
				TweenColor(ToggleSwitch, {
					["Time"] = 0.35,
					["BackgroundColor3"] = Color3.fromRGB(34, 161, 74)
				})
				confirm()
				else
					ToggleSwitch.Text = "False"
				TweenColor(ToggleSwitch, {
					["Time"] = 0.35,
						["BackgroundColor3"] = Color3.fromRGB(161, 45, 34)
					})
					confirm()
				end
				end)
		end
		return Things
	end
	return Things
end
return Library
