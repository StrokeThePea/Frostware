local IsCFrameEnabled
if not getgenv().FrostwareConfig then 
	getgenv().FrostwareConfig = {
		["TableOfEvents"] = {},
		["ScriptStopped"] = false,
		["FlingSupport"] = false,
		["AnimationsDisabled"] = false,
		["StablerReanimate"] = false,
		["CFrameReanimate"] = false,
		["EnableNetBypass"] = false, 
		["DisableAudio"] = false,
		["AnimationRunning"] = false,
		["DisconnectPartFromCFrame"] = false
	} 
end
	
if not game:GetService("ReplicatedStorage"):FindFirstChild("FrostwareData") then
	local Folder = Instance.new("Folder")
	Folder.Name = "FrostwareData"
	Folder.Parent = game:GetService("ReplicatedStorage")
	local Clone = game:GetObjects("rbxassetid://8440552086")[1]
	Clone.Name = "R6FakeRig"
	Clone.Parent = Folder
	task.wait(0.55)
end
    

local ReanimateAPI = {}

function ReanimateAPI.PlaySound(ID)
    local Sound = Instance.new("Sound")
    Sound.Parent = game:FindFirstChild("CoreGui")
    Sound.SoundId = "rbxassetid://"..tostring(ID)
    Sound:Play()
    task.spawn(function()
        task.wait(5)
        Sound:Destroy()
    end)
end
function ReanimateAPI.Notification(Texto)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Frostware Reanimation",
        Text = Texto
    })
end
function ReanimateAPI.ScriptCheck()
	local PartCheck = Instance.new("Part", workspace)
	PartCheck.Name = "ScriptCheck"
	PartCheck.CanCollide = false
	PartCheck.Transparency = 1
	PartCheck.Anchored = true
	PartCheck.Position = Vector3.new(0,1000,0)
end
function ReanimateAPI.ReCreateAccessoryWelds(Model,Accessory) -- Inspiration from DevForum Post made by admin.
	if not Accessory:IsA("Accessory") then return end

	local Handle = Accessory:FindFirstChild("Handle")
	pcall(function() Handle:FindFirstChild("AccessoryWeld"):Destroy() end)

	local NewWeld = Instance.new("Weld")
	NewWeld.Parent = Accessory.Handle
	NewWeld.Name = "AccessoryWeld"
	NewWeld.Part0 = Handle

	local Attachment = Handle:FindFirstChildOfClass("Attachment")

	if Attachment then
		NewWeld.C0 = Attachment.CFrame
		NewWeld.C1 = Model:FindFirstChild(tostring(Attachment), true).CFrame
		NewWeld.Part1 = Model:FindFirstChild(tostring(Attachment), true).Parent
	else
		NewWeld.Part1 = Model:FindFirstChild("Head")
		NewWeld.C1 = CFrame.new(0,Model:FindFirstChild("Head").Size.Y / 2,0) * Accessory.AttachmentPoint:Inverse()
	end

	Handle.CFrame = NewWeld.Part1.CFrame * NewWeld.C1 * NewWeld.C0:Inverse()
end

function ReanimateAPI.Align(Part0,Part1,Position,Orientation)
    local AlignPosition = Instance.new("AlignPosition")
    AlignPosition.Parent = Part0
    AlignPosition.MaxForce = math.huge
    AlignPosition.Responsiveness = 200
    AlignPosition.Name = "FrostWareAP1"

    local AlignOrientation = Instance.new("AlignOrientation")
    AlignOrientation.Parent = Part0
    AlignOrientation.MaxTorque = 15e9
    AlignOrientation.Responsiveness = 200
    AlignOrientation.Name = "FrostWareAO"

    local Attachment1 = Instance.new("Attachment")  
    Attachment1.Parent = Part0
    Attachment1.Position = Position or Vector3.new(0,0,0)
    Attachment1.Orientation = Orientation or Vector3.new(0,0,0)
    Attachment1.Name = "FrostWareAtt1"

    local Attachment2 = Instance.new("Attachment")
    Attachment2.Parent = Part1
    Attachment2.Name = "FrostWareAtt2"

    AlignPosition.Attachment0 = Attachment1
    AlignPosition.Attachment1 = Attachment2
    task.spawn(function()
        task.wait(1) -- To avoid network losing this should fix it.
        -- Basically Weak Align then stronger align
        local AlignPosition2 = Instance.new("AlignPosition")
        AlignPosition2.Parent = Part0
        AlignPosition2.Name = "FrostWareAP2"
        AlignPosition2.RigidityEnabled = true
        
        AlignPosition2.Attachment0 = Attachment1
        AlignPosition2.Attachment1 = Attachment2
    end)
    AlignOrientation.Attachment0 = Attachment1
    AlignOrientation.Attachment1 = Attachment2
end
function ReanimateAPI.CFrameAlign(Part0,Part1,OffSetPos,OffsetAngles)
	local Pos = OffSetPos or CFrame.new(0,0,0)
	local Angles = OffsetAngles or CFrame.Angles(0,0,0)
	pcall(function()
		if isnetworkowner(Part0) == true then
			Part0.CFrame = Part1.CFrame * Pos * Angles
		end
	end)
end
function ReanimateAPI.RandomString()
	local Result = ""
	local UPKey = "QWERTYUIOPASDFGHJKLZXCVNM"
	local LOWKey = "qwertyuiopasdfghjklzxcvbnm"
	local Numbers = "1234567890"
	local Symbols = "{}:<>?!@#$%&*()-_=+`^"
	local Together = UPKey..LOWKey..Numbers..Symbols
	for Index = 1, 25 do
		local RandomKey = math.random(#Together)
		Result = Result .. string.sub(Together, RandomKey, RandomKey)
	end
	return Result--.. "madebygelatek"
end

function ReanimateAPI.StopScript()
	if not workspace:FindFirstChild("Raw") then
		ReanimateAPI.Notification("Reanimation already running! Reset to change")
		ReanimateAPI.PlaySound(8499261098)
		task.wait(99e9)
		return
	end
	getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
	getgenv().FrostwareConfig.ScriptStopped = true
	getgenv().FrostwareConfig.AnimationRunning = false
	
	local CloneChar = workspace["Raw"]
	local RealChar = getgenv().OGChar
	CloneChar.Humanoid.WalkSpeed = 16
	CloneChar.Humanoid.JumpPower = 50
	CloneChar.Humanoid.AutoRotate = true
	local Head,Torso,Root,RA,LA,RL,LL = CloneChar.Head, CloneChar.Torso, CloneChar.HumanoidRootPart, CloneChar["Right Arm"], CloneChar["Left Arm"], CloneChar["Right Leg"], CloneChar["Left Leg"]
	Root.RootJoint:Destroy()
	Root.Anchored = true
	pcall(function()
		CloneChar.FrostwareAnimationPlayer:Destroy()  
		CloneChar.FrostwareAnimationMusic:Destroy()
		workspace.AntiScriptRun:Destroy()   
		workspace.ScriptCheck:Destroy() 
	end)
	for Index,Objects in pairs(Torso:GetDescendants()) do
		if Objects:IsA("Motor6D") then
			Objects:Destroy()
		end
		if Objects:IsA("PointLight") then
			Objects:Destroy()
		end
		if Objects:IsA("Weld") then
			Objects:Destroy()
		end
	end
	for Index,Parts in pairs(CloneChar:GetChildren()) do
		if Parts.Name ~= game.Players.LocalPlayer.Name and Parts.Name ~= "PDEATH DETECT" and Parts.Name ~= "Head" and Parts.Name ~= "Torso" and Parts.Name ~= "Right Arm" and Parts.Name ~= "Left Arm" and Parts.Name ~= "Right Leg" and Parts.Name ~= "Left Leg" and Parts.Name ~= "HumanoidRootPart" and Parts.Name ~= "Humanoid" and Parts.Name ~= "Animate" and Parts.Name ~= "BodyColors" and Parts.Name ~= "Pants" and Parts.Name ~= "Shirt" then
			Parts:Destroy()
		end
	end
	for Index,Objects in pairs(RealChar.FakeHats:GetDescendants()) do
		if Objects:IsA("Accessory") then
			local FakeAccessory = Objects:Clone()
			FakeAccessory.Parent = CloneChar
			FakeAccessory.Handle.Transparency = 1
			ReanimateAPI.ReCreateAccessoryWelds(CloneChar, FakeAccessory)
			if IsCFrameEnabled == false then
				ReanimateAPI.Align(RealChar[FakeAccessory.Name].Handle,CloneChar[FakeAccessory.Name].Handle)		
			end
		end
	end
	for Index,Objects in pairs(CloneChar.Humanoid:GetChildren()) do
		if Objects:IsA("Animator") then
			Objects:Destroy()
		end
		local NewAnimator = Instance.new("Animator", CloneChar.Humanoid)
	end
	local function CreateJoint(Name,Part0,Part1,C0,C1)
		local Joint = Instance.new("Motor6D")
		Joint.Parent = Part0
		Joint.Name = Name
		Joint.Part0 = Part0
		Joint.Part1 = Part1
		Joint.C0 = C0
		Joint.C1 = C1
	end
	CreateJoint("Neck",Torso,Head,CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0))
	CreateJoint("RootJoint",Root,Torso,CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0))
	CreateJoint("Right Shoulder",Torso,RA,CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0))
	CreateJoint("Left Shoulder",Torso,LA,CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	CreateJoint("Right Hip",Torso,RL,CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0))
	CreateJoint("Left Hip",Torso,LL,CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0))
	if RealChar:FindFirstChild("Bullet") then
		RealChar:FindFirstChild("Bullet"):ClearAllChildren()
		if RealChar:FindFirstChild("Bullet"):FindFirstChild("BodyPosition") then
			RealChar:FindFirstChild("Bullet"):FindFirstChild("BodyPosition"):Destroy()	
		end
		if RealChar.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			RealChar:FindFirstChild("Bullet").Transparency = 0
			local Hat = RealChar:FindFirstChild("SniperShoulderL")
			Hat.Handle:ClearAllChildren()
			ReanimateAPI.Align(RealChar:FindFirstChild("Bullet"), CloneChar:FindFirstChild("Left Arm"), Vector3.new(0,-0.4085,0), Vector3.new(0,0,0))
			ReanimateAPI.Align(Hat.Handle, CloneChar:FindFirstChild("Left Arm"), Vector3.new(0,-0.52,0), Vector3.new(0,0,0))
		else
			if not CloneChar:FindFirstChild("PDEATH DETECT") then
				RealChar:FindFirstChild("Bullet").Transparency = 0
				local Hat = RealChar:FindFirstChild("Robloxclassicred")
				Hat.Handle:ClearAllChildren()
				ReanimateAPI.Align(RealChar:FindFirstChild("Bullet"), CloneChar:FindFirstChild("Left Leg"))
				ReanimateAPI.Align(Hat.Handle, CloneChar:FindFirstChild("Left Leg"), Vector3.new(0,0,0), Vector3.new(90,0,0))
			else
				RealChar:FindFirstChild("Bullet").Transparency = 1
				ReanimateAPI.Align(RealChar:FindFirstChild("Bullet"), CloneChar:FindFirstChild("HumanoidRootPart"))
			end
		end
	end
	Root.Anchored = false
	getgenv().FrostwareConfig.ScriptStopped = false
end

function ReanimateAPI.SimpleReanimate()
	if workspace:FindFirstChild("Raw") then
		ReanimateAPI.Notification("Reanimation already running! Reset to change")
		ReanimateAPI.PlaySound(8499261098)
		task.wait(99e9)
		return
	end
	local IsFlingEnabled = getgenv().FrostwareConfig.FlingSupport or false -- R6 Torso Fling Only
	local AreAnimationsDisabled = getgenv().FrostwareConfig.AnimationsDisabled or false -- Enable basic animations (Idle, Walk)
	local IsReanimStabler = getgenv().FrostwareConfig.StablerReanimate or false -- Increases stability for the reanimate (Side effect: More Jitter)
	IsCFrameEnabled = getgenv().FrostwareConfig.CFrameReanimate or false -- Checks if the reanimate should be CFrame or Align Based
	local IsNetEnabled = getgenv().FrostwareConfig.Net or false -- Increases SimulationRadius (Looped)
	local HiddenProp = sethiddenproperty or set_hidden_property or function() end -- Checks if the exploit player has sethiddenproperty function
	local SimulationRadius = setsimulationradius or set_simulation_radius or function() end -- Checks if the exploit player has setsimulationradius function
	local SetScript = setscriptable or function() end -- Access hidden properties
	local IsPlayerDead,Events,PlayerRigType = false,{},"" -- Self Explainatory
	local R15Offsets = { -- R15 Offsets used to make the character look R6'ish.
		-- [1] Is for CFrame Part, [2] Is for align.
		["UpperTorso"] = { CFrame.new(0,0.194,0), Vector3.new(0,-0.194,0) },
		["LowerTorso"] = { CFrame.new(0,-0.79,0), Vector3.new(0,0.79,0) },
		["Root"] = { CFrame.new(0,-0.1125,0), Vector3.new(0,-0.025,0) },
		
		["UpperArm"] = { CFrame.new(0,0.4085,0), Vector3.new(0,-0.4085,0) },
		["LowerArm"] = { CFrame.new(0,-0.184,0), Vector3.new(0,0.184,0) },
		["Hand"] = { CFrame.new(0,-0.83,0), Vector3.new(0,0.83,0) },
		
		["UpperLeg"] = { CFrame.new(0,0.575,0), Vector3.new(0,-0.575,0) },
		["LowerLeg"] = { CFrame.new(0,-0.199,0), Vector3.new(0,0.199,0) },
		["Foot"] = { CFrame.new(0,-0.849,0), Vector3.new(0,0.849,0) }
	}
	local Player = game:GetService("Players").LocalPlayer
	local Character = Player["Character"]
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	Character.Archivable = true -- Allows to modify the character model.
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	for Index,Object in pairs(Humanoid:GetChildren()) do
		if Object:IsA("NumberValue") then -- (R15 Only) Destroys numbervalues in humanoid to reset body size. 
			Object:Destroy()
			task.wait(0.025) -- Cooldown so it does not trigger in games
		end
	end
	if Humanoid.RigType == Enum.HumanoidRigType.R15 then -- Checks player RigType
		PlayerRigType = "R15"
		Humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Removes Torso Collisions, Giving it to Limbs.
	else
		Character:FindFirstChild("HumanoidRootPart"):Destroy()
		PlayerRigType = "R6"
		if not IsFlingEnabled then
			Humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Removes Torso Collisions, Giving it to Limbs.
		end
	end
	local FakeHats = Instance.new("Folder") -- Stores fake hats, needed for stop script.
	FakeHats.Name = "FakeHats"
	FakeHats.Parent = Character
	local Clone = game:GetService("ReplicatedStorage"):FindFirstChild("FrostwareData").R6FakeRig:Clone() 
	-- The Clone, It's needed because if the animations are played on clone, we can just CFrame/Align it to replicate the animations
	-- Also I put the clone in replicatedstorage to avoid lag spikes
	Clone.Name = "Raw"--ReanimateAPI.RandomString()
	Clone.Parent = workspace
	Clone:MoveTo(Character.Head.Position + Vector3.new(0,0,0))
	local CloneHumanoid = Clone:FindFirstChildWhichIsA("Humanoid")
	CloneHumanoid.BreakJointsOnDeath = false
	for Index,Object in pairs(Clone:GetDescendants()) do
		if Object:IsA("BasePart") or Object:IsA("Decal") then
			Object.Transparency = 1
		end
	end
	-- Allowed to use (I asked for permission) Original Creator: Mizt
	-- Hat renamer to avoid hat bugs
	local HatsNameTable = {}
	for Index, Accessory in next, Character:GetChildren() do
		if Accessory:IsA("Accessory") then
			if HatsNameTable[Accessory.Name] then
				if HatsNameTable[Accessory.Name] == "s" then
					HatsNameTable[Accessory.Name] = {}
				end
				table.insert(HatsNameTable[Accessory.Name], Accessory)
			else
				HatsNameTable[Accessory.Name] = "s"
			end	
		end
	end
	for Index, Strings in pairs(HatsNameTable) do
		if type(Strings) == "table" then
			local Number = 1
			for Index2, Names in pairs(Strings) do
				Names.Name = Names.Name .. Number
				Number = Number + 1
			end
		end
	end
	table.clear(HatsNameTable)
	Character.Parent = Clone
	-- Tables
	local Anims = Humanoid:GetPlayingAnimationTracks()
	Character.Animate.Disabled = true
	local CharChildren = Character:GetChildren()
	local CharDescendants = Character:GetDescendants()

	local CloneChildren = Clone:GetChildren()
	local CloneDescendants = Clone:GetDescendants()

	for Index,Tool in pairs(Player.Backpack:GetChildren()) do
		if Tool:IsA("Tool") then 
			Tool:Destroy() 
		end
	end
	-- Yandere Dev Code (Refresh Tables)
	table.insert(Events, Character.ChildAdded:Connect(function(g)
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
		if g:IsA("Tool") then
			g:Remove()
			Player.Backpack[g.Name]:Destroy()
		end
	end))
	
	table.insert(Events, Character.ChildRemoved:Connect(function()
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
	end))

	table.insert(Events, Clone.ChildAdded:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	table.insert(Events, Clone.ChildRemoved:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	for Index,Joint in pairs(CharDescendants) do
		if Joint:IsA("Motor6D") and Joint.Name ~= "Neck" then
			Joint:Destroy()
		elseif Joint:IsA("Accessory") then
			Joint.Handle:BreakJoints()
		end
	end

	for Index,Object in pairs(CharChildren) do
		if Object:IsA("Accessory") then
			local CloneHats1 = Object:Clone() -- Hats into fakehats folder
			CloneHats1.Parent = FakeHats
			CloneHats1.Handle.Transparency = 1
			ReanimateAPI.ReCreateAccessoryWelds(Clone, CloneHats1)
			local CloneHats2 = CloneHats1:Clone() -- Hats into clone rig
			CloneHats2.Parent = Clone
		end
	end

	table.insert(Events, game:GetService("RunService").Stepped:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
				Object.CanQuery = false
				Object.RootPriority = 127
				HiddenProp(Object, 'NetworkOwnershipRule', Enum.NetworkOwnership.Manual)
			end
		end
		for Index,Object in pairs(CloneDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
		-- Network
		HiddenProp(workspace, 'HumanoidOnlySetCollisionsOnStateChange', Enum.HumanoidOnlySetCollisionsOnStateChange.Disabled)
		HiddenProp(workspace, 'InterpolationThrottling', Enum.InterpolationThrottlingMode.Disabled)
		SetScript(Player, "NetworkIsSleeping", true)
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		settings().Physics.AllowSleep = false
		settings().Physics.ForceCSGv2 = false
		settings().Physics.DisableCSGv2 = true
		settings().Physics.UseCSGv2 = false
		settings().Physics.ThrottleAdjustTime = math.huge
		Player.ReplicationFocus = workspace
		Player.MaximumSimulationRadius = 2763
		if IsNetEnabled == true then
			SimulationRadius(2763)
		end
		for Index,Track in pairs(Anims) do
			Track:Stop()
		end
		CloneHumanoid:Move(Humanoid.MoveDirection,false)
	end))
	table.insert(Events, game:GetService("UserInputService").JumpRequest:Connect(function()
		CloneHumanoid.Jump = true
		CloneHumanoid.Sit = false
	end))
	table.insert(Events, game:GetService("RunService").Heartbeat:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") and Object.Name ~= "Torso" then
				if IsReanimStabler == true then
					Object:ApplyImpulse(Vector3.new(32.5,0,0))
					Object.Velocity = Vector3.new(32.5,0,0)
				else
					Object.Velocity = ( getgenv().Jitteryness or Vector3.new(32.5,0,0) ) + Clone["HumanoidRootPart"].CFrame.LookVector * 4.5
				end
				if PlayerRigType == "R6" then
					if IsFlingEnabled then
						Character.Torso:ApplyImpulse(Vector3.new(32.5,0,0))
						Character.Torso.Velocity = Vector3.new(2500,2500,2500)
						Character["Torso"].CFrame = Clone["Torso"].CFrame
					else
						Character.Torso:ApplyImpulse(Vector3.new(32.5,0,0))
						Character.Torso.Velocity = Vector3.new(32.5,0,0)
					end
				end
			end
		end
		if IsCFrameEnabled then
			if PlayerRigType == "R6" then
				pcall(function()
					ReanimateAPI.CFrameAlign(Character["Torso"],Clone["Torso"])
					ReanimateAPI.CFrameAlign(Character["Right Arm"],Clone["Right Arm"])
					ReanimateAPI.CFrameAlign(Character["Left Arm"],Clone["Left Arm"])
					ReanimateAPI.CFrameAlign(Character["Right Leg"],Clone["Right Leg"])
					ReanimateAPI.CFrameAlign(Character["Left Leg"],Clone["Left Leg"])
				end)
			elseif PlayerRigType == "R15" then
				pcall(function()
					ReanimateAPI.CFrameAlign(Character["UpperTorso"], Clone["Torso"], R15Offsets.UpperTorso[1])
					ReanimateAPI.CFrameAlign(Character["LowerTorso"], Clone["Torso"], R15Offsets.LowerTorso[1])
					ReanimateAPI.CFrameAlign(Character["HumanoidRootPart"], Character["UpperTorso"], R15Offsets.Root[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperArm"], Clone["Right Arm"], R15Offsets.UpperArm[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerArm"], Clone["Right Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["RightHand"], Clone["Right Arm"], R15Offsets.Hand[1])

					ReanimateAPI.CFrameAlign(Character["LeftUpperArm"], Clone["Left Arm"], R15Offsets.UpperArm[1])
					ReanimateAPI.CFrameAlign(Character["LeftLowerArm"], Clone["Left Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["LeftHand"], Clone["Left Arm"], R15Offsets.Hand[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperLeg"], Clone["Right Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerLeg"], Clone["Right Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightFoot"], Clone["Right Leg"], R15Offsets.Foot[1])
								
					ReanimateAPI.CFrameAlign(Character["LeftUpperLeg"], Clone["Left Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftLowerLeg"], Clone["Left Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftFoot"], Clone["Left Leg"], R15Offsets.Foot[1])
				end)
			end
			
			for Index,Object in pairs(CharChildren) do
				if Object:IsA("Accessory") then
					pcall(function()
						ReanimateAPI.CFrameAlign(Object.Handle, Clone[Object.Name].Handle)
					end)
				end
			end
		end
	end))
	if IsCFrameEnabled == false then
		if PlayerRigType == "R6" then
			ReanimateAPI.Align(Character["Torso"],Clone["Torso"])
			ReanimateAPI.Align(Character["Right Arm"],Clone["Right Arm"])
			ReanimateAPI.Align(Character["Left Arm"],Clone["Left Arm"])
			ReanimateAPI.Align(Character["Right Leg"],Clone["Right Leg"])
			ReanimateAPI.Align(Character["Left Leg"],Clone["Left Leg"])
		elseif PlayerRigType == "R15" then
			ReanimateAPI.Align(Character["UpperTorso"],Clone["Torso"],R15Offsets.UpperTorso[2])
			ReanimateAPI.Align(Character["LowerTorso"],Clone["Torso"],R15Offsets.LowerTorso[2])
			ReanimateAPI.Align(Character["HumanoidRootPart"],Character["UpperTorso"],R15Offsets.Root[2])
			
			ReanimateAPI.Align(Character["RightUpperArm"],Clone["Right Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["RightLowerArm"],Clone["Right Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["RightHand"],Clone["Right Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(Character["LeftUpperArm"],Clone["Left Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["LeftLowerArm"],Clone["Left Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["LeftHand"],Clone["Left Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(Character["RightUpperLeg"],Clone["Right Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["RightLowerLeg"],Clone["Right Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["RightFoot"],Clone["Right Leg"],R15Offsets.Foot[2])
			
			ReanimateAPI.Align(Character["LeftUpperLeg"],Clone["Left Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["LeftLowerLeg"],Clone["Left Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["LeftFoot"],Clone["Left Leg"],R15Offsets.Foot[2])
		end
		for Index,Object in pairs(CharChildren) do
			if Object:IsA("Accessory") then
				ReanimateAPI.Align(Object.Handle,Clone[Object.Name].Handle)
			end
		end
	end
	workspace:FindFirstChildWhichIsA("Camera").CameraSubject = CloneHumanoid
	Player.Character = Clone
	getgenv().OGChar = Character
	table.insert(Events, CloneHumanoid.Died:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		IsPlayerDead = true
		Character.Parent = workspace
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	table.insert(Events, Player.CharacterAdded:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		IsPlayerDead = true
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	if AreAnimationsDisabled == false then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/Animations.lua"))()
	end
	ReanimateAPI.PlaySound(5949365181)
end



function ReanimateAPI.BulletReanimate()
	if workspace:FindFirstChild("Raw") then
		ReanimateAPI.Notification("Reanimation already running! Reset to change")
		ReanimateAPI.PlaySound(8499261098)
		task.wait(99e9)
		return
	end
	local AreAnimationsDisabled = getgenv().FrostwareConfig.AnimationsDisabled or false -- Enable basic animations (Idle, Walk)
	local IsReanimStabler = getgenv().FrostwareConfig.StablerReanimate or false -- Increases stability for the reanimate (Side effect: More Jitter)
	IsCFrameEnabled = getgenv().FrostwareConfig.CFrameReanimate or false -- Checks if the reanimate should be CFrame or Align Based
	local IsNetEnabled = getgenv().FrostwareConfig.Net or false -- Increases SimulationRadius (Looped)
	local HiddenProp = sethiddenproperty or set_hidden_property or function() end -- Checks if the exploit player has sethiddenproperty function
	local SimulationRadius = setsimulationradius or set_simulation_radius or function() end -- Checks if the exploit player has setsimulationradius function
	local PartReplica,BulletPart -- idk how to explain this
	local SetScript = setscriptable or function() end -- Access hidden properties
	local IsPlayerDead,Events,PlayerRigType = false,{},"" -- Self Explainatory
	local R15Offsets = { -- R15 Offsets used to make the character look R6'ish.
		-- [1] Is for CFrame Part, [2] Is for align.
		["UpperTorso"] = { CFrame.new(0,0.194,0), Vector3.new(0,-0.194,0) },
		["LowerTorso"] = { CFrame.new(0,-0.79,0), Vector3.new(0,0.79,0) },
		["Root"] = { CFrame.new(0,-0.1125,0), Vector3.new(0,0.025,0) },
		
		["UpperArm"] = { CFrame.new(0,0.4085,0), Vector3.new(0,-0.4085,0) },
		["LowerArm"] = { CFrame.new(0,-0.184,0), Vector3.new(0,0.184,0) },
		["Hand"] = { CFrame.new(0,-0.83,0), Vector3.new(0,0.83,0) },
		
		["UpperLeg"] = { CFrame.new(0,0.575,0), Vector3.new(0,-0.575,0) },
		["LowerLeg"] = { CFrame.new(0,-0.199,0), Vector3.new(0,0.199,0) },
		["Foot"] = { CFrame.new(0,-0.849,0), Vector3.new(0,0.849,0) }
	}
	local Player = game:GetService("Players").LocalPlayer
	local Character = Player["Character"]
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	BulletPart = Character:FindFirstChild("Left Leg") or Character:FindFirstChild("LeftUpperArm")
	BulletPart.Name = "Bullet"
	Character.Archivable = true -- Allows to modify the character model.
	Humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Removes Torso Collisions, Giving it to Limbs.
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	for Index,Object in pairs(Humanoid:GetChildren()) do
		if Object:IsA("NumberValue") then -- (R15 Only) Destroys numbervalues in humanoid to reset body size. 
			Object:Destroy()
			task.wait(0.025) -- Cooldown so it does not trigger in games
		end
	end
	if Humanoid.RigType == Enum.HumanoidRigType.R15 then -- Checks player RigType
		PlayerRigType = "R15"
		PartReplica = "SniperShoulderL"
	else
		Character:FindFirstChild("HumanoidRootPart"):Destroy()
		PlayerRigType = "R6"
		PartReplica = "Robloxclassicred"
	end
	local FakeHats = Instance.new("Folder") -- Stores fake hats, needed for stop script.
	FakeHats.Name = "FakeHats"
	FakeHats.Parent = Character
	local Clone = game:GetService("ReplicatedStorage"):FindFirstChild("FrostwareData").R6FakeRig:Clone() 
	-- The Clone, It's needed because if the animations are played on clone, we can just CFrame/Align it to replicate the animations
	-- Also I put the clone in replicatedstorage to avoid lag spikes
	Clone.Name = "Raw"--ReanimateAPI.RandomString()
	Clone.Parent = workspace
	Clone:MoveTo(Character.Head.Position + Vector3.new(0,0,0))
	local CloneHumanoid = Clone:FindFirstChildWhichIsA("Humanoid")
	CloneHumanoid.BreakJointsOnDeath = false
	for Index,Object in pairs(Clone:GetDescendants()) do
		if Object:IsA("BasePart") or Object:IsA("Decal") then
			Object.Transparency = 1
		end
	end
	-- Allowed to use (I asked for permission) Original Creator: Mizt
	-- Hat renamer to avoid hat bugs
	local HatsNameTable = {}
	for Index, Accessory in next, Character:GetChildren() do
		if Accessory:IsA("Accessory") then
			if HatsNameTable[Accessory.Name] then
				if HatsNameTable[Accessory.Name] == "s" then
					HatsNameTable[Accessory.Name] = {}
				end
				table.insert(HatsNameTable[Accessory.Name], Accessory)
			else
				HatsNameTable[Accessory.Name] = "s"
			end	
		end
	end
	for Index, Strings in pairs(HatsNameTable) do
		if type(Strings) == "table" then
			local Number = 1
			for Index2, Names in pairs(Strings) do
				Names.Name = Names.Name .. Number
				Number = Number + 1
			end
		end
	end
	table.clear(HatsNameTable)
	Character.Parent = Clone
	-- Tables
	local Anims = Humanoid:GetPlayingAnimationTracks()
	Character.Animate.Disabled = true
	local CharChildren = Character:GetChildren()
	local CharDescendants = Character:GetDescendants()

	local CloneChildren = Clone:GetChildren()
	local CloneDescendants = Clone:GetDescendants()
	for Index,Tool in pairs(Player.Backpack:GetChildren()) do
		if Tool:IsA("Tool") then 
			Tool:Destroy() 
		end
	end
	-- Yandere Dev Code (Refresh Tables)
	table.insert(Events, Character.ChildAdded:Connect(function(g)
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
		if g:IsA("Tool") then
			g:Remove()
			Player.Backpack[g.Name]:Destroy()
		end
	end))

	table.insert(Events, Character.ChildRemoved:Connect(function()
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
	end))

	table.insert(Events, Clone.ChildAdded:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	table.insert(Events, Clone.ChildRemoved:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	for Index,Joint in pairs(CharDescendants) do
		if Joint:IsA("Motor6D") and Joint.Name ~= "Neck" then
			Joint:Destroy()
		elseif Joint:IsA("Accessory") then
			Joint.Handle:BreakJoints()
		elseif Joint.Name == PartReplica then
			Joint.Handle:ClearAllChildren()
		end
	end

	for Index,Object in pairs(CharChildren) do
		if Object:IsA("Accessory") then
			local CloneHats1 = Object:Clone() -- Hats into fakehats folder
			CloneHats1.Parent = FakeHats
			CloneHats1.Handle.Transparency = 1
			ReanimateAPI.ReCreateAccessoryWelds(Clone, CloneHats1)
			local CloneHats2 = CloneHats1:Clone() -- Hats into clone rig
			CloneHats2.Parent = Clone
		end
	end
	if Character:FindFirstChild(PartReplica) then
		Character:FindFirstChild(PartReplica).Handle:ClearAllChildren()
	end
	table.insert(Events, game:GetService("RunService").Stepped:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
				Object.CanQuery = false
				Object.RootPriority = 127
				HiddenProp(Object, 'NetworkOwnershipRule', Enum.NetworkOwnership.Manual)
			end
		end
		for Index,Object in pairs(CloneDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
		-- Network
		HiddenProp(workspace, 'HumanoidOnlySetCollisionsOnStateChange', Enum.HumanoidOnlySetCollisionsOnStateChange.Disabled)
		HiddenProp(workspace, 'InterpolationThrottling', Enum.InterpolationThrottlingMode.Disabled)
		SetScript(Player, "NetworkIsSleeping", true)
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		settings().Physics.AllowSleep = false
		settings().Physics.ForceCSGv2 = false
		settings().Physics.DisableCSGv2 = true
		settings().Physics.UseCSGv2 = false
		settings().Physics.ThrottleAdjustTime = math.huge
		Player.ReplicationFocus = workspace
		Player.MaximumSimulationRadius = 2763
		if IsNetEnabled == true then
			SimulationRadius(2763)
		end
		for Index,Track in pairs(Anims) do
			Track:Stop()
		end
		CloneHumanoid:Move(Humanoid.MoveDirection,false)
	end))
	table.insert(Events, game:GetService("UserInputService").JumpRequest:Connect(function()
		CloneHumanoid.Jump = true
		CloneHumanoid.Sit = false
	end))
	table.insert(Events, game:GetService("RunService").Heartbeat:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") then
				if IsReanimStabler == true then
					Object:ApplyImpulse(Vector3.new(32.5,0,0))
					Object.Velocity = Vector3.new(32.5,0,0)
				else
					Object.Velocity =  ( getgenv().Jitteryness or Vector3.new(32.5,0,0) ) + Clone["HumanoidRootPart"].CFrame.LookVector * 4.5
				end
			end
		end
		if IsCFrameEnabled then
			if PlayerRigType == "R6" then
				pcall(function()
					Character["Torso"].CFrame = Clone["Torso"].CFrame
					Character["Right Arm"].CFrame = Clone["Right Arm"].CFrame
					Character["Left Arm"].CFrame = Clone["Left Arm"].CFrame
					Character["Right Leg"].CFrame = Clone["Right Leg"].CFrame
					if getgenv().FrostwareConfig.DisconnectPartFromCFrame == false then
						BulletPart.CFrame = Clone["Left Leg"].CFrame
					end
					if Character:FindFirstChild(PartReplica) then
						Character:FindFirstChild(PartReplica).Handle.CFrame = Clone["Left Leg"].CFrame * CFrame.Angles(math.rad(90),0,0)
					end
					for Index,Object in pairs(CharChildren) do
						if Object:IsA("Accessory") then
							if Object.Name ~= PartReplica then
								ReanimateAPI.CFrameAlign(Object.Handle, Clone[Object.Name].Handle)
							end
						end
					end
				end)
			elseif PlayerRigType == "R15" then
				pcall(function()
					ReanimateAPI.CFrameAlign(Character["UpperTorso"], Clone["Torso"], R15Offsets.UpperTorso[1])
					ReanimateAPI.CFrameAlign(Character["LowerTorso"], Clone["Torso"], R15Offsets.LowerTorso[1])
					ReanimateAPI.CFrameAlign(Character["HumanoidRootPart"], Character["UpperTorso"], R15Offsets.Root[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperArm"], Clone["Right Arm"], R15Offsets.UpperArm[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerArm"], Clone["Right Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["RightHand"], Clone["Right Arm"], R15Offsets.Hand[1])
					if getgenv().FrostwareConfig.DisconnectPartFromCFrame == false then
						ReanimateAPI.CFrameAlign(BulletPart, Clone["Left Arm"], R15Offsets.UpperArm[1])
					end
					if Character:FindFirstChild(PartReplica) then
						Character:FindFirstChild(PartReplica).Handle.CFrame = Clone["Left Arm"].CFrame * CFrame.new(0,0.52,0)
					end
					ReanimateAPI.CFrameAlign(Character["LeftLowerArm"], Clone["Left Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["LeftHand"], Clone["Left Arm"], R15Offsets.Hand[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperLeg"], Clone["Right Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerLeg"], Clone["Right Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightFoot"], Clone["Right Leg"], R15Offsets.Foot[1])
								
					ReanimateAPI.CFrameAlign(Character["LeftUpperLeg"], Clone["Left Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftLowerLeg"], Clone["Left Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftFoot"], Clone["Left Leg"], R15Offsets.Foot[1])

					for Index,Object in pairs(CharChildren) do
						if Object:IsA("Accessory") then
							if Object.Name ~= PartReplica then
								ReanimateAPI.CFrameAlign(Object.Handle, Clone[Object.Name].Handle)
							end
						end
					end
				end)
			end
		end
	end))
	if IsCFrameEnabled == false then
		if PlayerRigType == "R6" then
			ReanimateAPI.Align(Character["Torso"],Clone["Torso"])
			ReanimateAPI.Align(Character["Right Arm"],Clone["Right Arm"])
			ReanimateAPI.Align(Character["Left Arm"],Clone["Left Arm"])
			ReanimateAPI.Align(Character["Right Leg"],Clone["Right Leg"])
			ReanimateAPI.Align(BulletPart,Clone["Left Leg"])
			if Character:FindFirstChild(PartReplica) then
				ReanimateAPI.Align(Character:FindFirstChild(PartReplica).Handle,Clone["Left Leg"],Vector3.new(0,0,0),Vector3.new(90,0,0))
			end
			for Index,Object in pairs(CharChildren) do
				if Object:IsA("Accessory") then
					if Object.Name ~= PartReplica then
						ReanimateAPI.Align(Object.Handle,Clone[Object.Name].Handle)
					end
				end
			end
		elseif PlayerRigType == "R15" then
			ReanimateAPI.Align(Character["UpperTorso"],Clone["Torso"],R15Offsets.UpperTorso[2])
			ReanimateAPI.Align(Character["LowerTorso"],Clone["Torso"],R15Offsets.LowerTorso[2])
			ReanimateAPI.Align(Character["HumanoidRootPart"],Character["UpperTorso"],R15Offsets.Root[2])
			
			ReanimateAPI.Align(Character["RightUpperArm"],Clone["Right Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["RightLowerArm"],Clone["Right Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["RightHand"],Clone["Right Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(BulletPart,Clone["Left Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["LeftLowerArm"],Clone["Left Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["LeftHand"],Clone["Left Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(Character["RightUpperLeg"],Clone["Right Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["RightLowerLeg"],Clone["Right Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["RightFoot"],Clone["Right Leg"],R15Offsets.Foot[2])
			if Character:FindFirstChild(PartReplica) then
				ReanimateAPI.Align(Character:FindFirstChild(PartReplica).Handle,Clone["Left Arm"],Vector3.new(0,-0.55,0))
			end
			ReanimateAPI.Align(Character["LeftUpperLeg"],Clone["Left Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["LeftLowerLeg"],Clone["Left Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["LeftFoot"],Clone["Left Leg"],R15Offsets.Foot[2])
			for Index,Object in pairs(CharChildren) do
				if Object:IsA("Accessory") then
					if Object.Name ~= PartReplica then
						ReanimateAPI.Align(Object.Handle,Clone[Object.Name].Handle)
					end
				end
			end
		end
	end
	workspace:FindFirstChildWhichIsA("Camera").CameraSubject = CloneHumanoid
	Player.Character = Clone
	getgenv().OGChar = Character
	table.insert(Events, CloneHumanoid.Died:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
		IsPlayerDead = true
		Character.Parent = workspace
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	table.insert(Events, Player.CharacterAdded:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
		IsPlayerDead = true
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	if AreAnimationsDisabled == false then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/Animations.lua"))()
	end
	ReanimateAPI.PlaySound(5949365181)
end









-- PDEATH

function ReanimateAPI.PermaDeathReanimate()
	if workspace:FindFirstChild("Raw") then
		ReanimateAPI.Notification("Reanimation already running! Reset to change")
		ReanimateAPI.PlaySound(8499261098)
		task.wait(99e9)
		return
	end
	local AreAnimationsDisabled = getgenv().FrostwareConfig.AnimationsDisabled or false -- Enable basic animations (Idle, Walk)
	local IsReanimStabler = getgenv().FrostwareConfig.StablerReanimate or false -- Increases stability for the reanimate (Side effect: More Jitter)
	IsCFrameEnabled = getgenv().FrostwareConfig.CFrameReanimate or false -- Checks if the reanimate should be CFrame or Align Based
	local IsNetEnabled = getgenv().FrostwareConfig.Net or false -- Increases SimulationRadius (Looped)
	local HiddenProp = sethiddenproperty or set_hidden_property or function() end -- Checks if the exploit player has sethiddenproperty function
	local SimulationRadius = setsimulationradius or set_simulation_radius or function() end -- Checks if the exploit player has setsimulationradius function
	local PartReplica,BulletPart -- idk how to explain this
	local SetScript = setscriptable or function() end -- Access hidden properties
	local IsPlayerDead,Events,PlayerRigType = false,{},"" -- Self Explainatory
	local R15Offsets = { -- R15 Offsets used to make the character look R6'ish.
		-- [1] Is for CFrame Part, [2] Is for align.
		["UpperTorso"] = { CFrame.new(0,0.194,0), Vector3.new(0,-0.194,0) },
		["LowerTorso"] = { CFrame.new(0,-0.79,0), Vector3.new(0,0.79,0) },
		["Root"] = { CFrame.new(0,-0.1125,0), Vector3.new(0,0.025,0) },
		
		["UpperArm"] = { CFrame.new(0,0.4085,0), Vector3.new(0,-0.4085,0) },
		["LowerArm"] = { CFrame.new(0,-0.184,0), Vector3.new(0,0.184,0) },
		["Hand"] = { CFrame.new(0,-0.83,0), Vector3.new(0,0.83,0) },
		
		["UpperLeg"] = { CFrame.new(0,0.575,0), Vector3.new(0,-0.575,0) },
		["LowerLeg"] = { CFrame.new(0,-0.199,0), Vector3.new(0,0.199,0) },
		["Foot"] = { CFrame.new(0,-0.849,0), Vector3.new(0,0.849,0) }
	}
	local Player = game:GetService("Players").LocalPlayer
	local Character = Player["Character"]
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	BulletPart = Character:FindFirstChild("LeftUpperArm") or Character:FindFirstChild("HumanoidRootPart")
	BulletPart.Name = "Bullet"
	Character.Archivable = true -- Allows to modify the character model.
	Humanoid:ChangeState(Enum.HumanoidStateType.Physics) -- Removes Torso Collisions, Giving it to Limbs.
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
	for Index,Object in pairs(Humanoid:GetChildren()) do
		if Object:IsA("NumberValue") then -- (R15 Only) Destroys numbervalues in humanoid to reset body size. 
			Object:Destroy()
			task.wait(0.025) -- Cooldown so it does not trigger in games
		end
	end
	if Humanoid.RigType == Enum.HumanoidRigType.R15 then -- Checks player RigType
		PlayerRigType = "R15"
		Character.HumanoidRootPart.Transparency = 0.5
	else
		PlayerRigType = "R6"
	end
	local FakeHats = Instance.new("Folder") -- Stores fake hats, needed for stop script.
	FakeHats.Name = "FakeHats"
	FakeHats.Parent = Character
	local Clone = game:GetService("ReplicatedStorage"):FindFirstChild("FrostwareData").R6FakeRig:Clone() 
	-- The Clone, It's needed because if the animations are played on clone, we can just CFrame/Align it to replicate the animations
	-- Also I put the clone in replicatedstorage to avoid lag spikes
	Clone.Name = "Raw"--ReanimateAPI.RandomString()
	Clone.Parent = workspace
	Clone:MoveTo(Character.Head.Position + Vector3.new(0,0,0))
	local CloneHumanoid = Clone:FindFirstChildWhichIsA("Humanoid")
	CloneHumanoid.BreakJointsOnDeath = false
	for Index,Object in pairs(Clone:GetDescendants()) do
		if Object:IsA("BasePart") or Object:IsA("Decal") then
			Object.Transparency = 1
		end
	end
	-- Allowed to use (I asked for permission) Original Creator: Mizt
	-- Hat renamer to avoid hat bugs
	local HatsNameTable = {}
	for Index, Accessory in next, Character:GetChildren() do
		if Accessory:IsA("Accessory") then
			if HatsNameTable[Accessory.Name] then
				if HatsNameTable[Accessory.Name] == "s" then
					HatsNameTable[Accessory.Name] = {}
				end
				table.insert(HatsNameTable[Accessory.Name], Accessory)
			else
				HatsNameTable[Accessory.Name] = "s"
			end	
		end
	end
	for Index, Strings in pairs(HatsNameTable) do
		if type(Strings) == "table" then
			local Number = 1
			for Index2, Names in pairs(Strings) do
				Names.Name = Names.Name .. Number
				Number = Number + 1
			end
		end
	end
	table.clear(HatsNameTable)
	Character.Parent = Clone
	-- Tables
	local aeiou = Instance.new("Part")
	aeiou.Parent = Clone
	aeiou.Name = "PDEATH DETECT"
	aeiou.Anchored = true
	aeiou.Transparency = 1
	local Anims = Humanoid:GetPlayingAnimationTracks()
	Character.Animate.Disabled = true
	local CharChildren = Character:GetChildren()
	local CharDescendants = Character:GetDescendants()

	local CloneChildren = Clone:GetChildren()
	local CloneDescendants = Clone:GetDescendants()
	for Index,Tool in pairs(Player.Backpack:GetChildren()) do
		if Tool:IsA("Tool") then 
			Tool:Destroy() 
		end
	end
	-- Yandere Dev Code (Refresh Tables)
	table.insert(Events, Character.ChildAdded:Connect(function(g)
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
		if g:IsA("Tool") then
			g:Remove()
			Player.Backpack[g.Name]:Destroy()
		end
	end))

	table.insert(Events, Character.ChildRemoved:Connect(function()
		CharChildren = Character:GetChildren()
		CharDescendants = Character:GetDescendants()
	end))

	table.insert(Events, Clone.ChildAdded:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	table.insert(Events, Clone.ChildRemoved:Connect(function()
		CloneChildren = Clone:GetChildren()
		CloneDescendants = Clone:GetDescendants()
	end))

	for Index,Joint in pairs(CharDescendants) do
		if Joint:IsA("Motor6D") and Joint.Name ~= "Neck" then
			Joint:Destroy()
		elseif Joint:IsA("Accessory") then
			Joint.Handle:BreakJoints()
		elseif Joint.Name == PartReplica then
			Joint.Handle:ClearAllChildren()
		end
	end

	for Index,Object in pairs(CharChildren) do
		if Object:IsA("Accessory") then
			local CloneHats1 = Object:Clone() -- Hats into fakehats folder
			CloneHats1.Parent = FakeHats
			CloneHats1.Handle.Transparency = 1
			ReanimateAPI.ReCreateAccessoryWelds(Clone, CloneHats1)
			local CloneHats2 = CloneHats1:Clone() -- Hats into clone rig
			CloneHats2.Parent = Clone
		end
	end
	table.insert(Events, game:GetService("RunService").Stepped:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
				Object.CanQuery = false
				Object.RootPriority = 127
				HiddenProp(Object, 'NetworkOwnershipRule', Enum.NetworkOwnership.Manual)
			end
		end
		for Index,Object in pairs(CloneDescendants) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
		-- Network
		HiddenProp(workspace, 'HumanoidOnlySetCollisionsOnStateChange', Enum.HumanoidOnlySetCollisionsOnStateChange.Disabled)
		HiddenProp(workspace, 'InterpolationThrottling', Enum.InterpolationThrottlingMode.Disabled)
		SetScript(Player, "NetworkIsSleeping", true)
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		settings().Physics.AllowSleep = false
		settings().Physics.ForceCSGv2 = false
		settings().Physics.DisableCSGv2 = true
		settings().Physics.UseCSGv2 = false
		settings().Physics.ThrottleAdjustTime = math.huge
		Player.ReplicationFocus = workspace
		Player.MaximumSimulationRadius = 2763
		if IsNetEnabled == true then
			SimulationRadius(2763)
		end
		for Index,Track in pairs(Anims) do
			Track:Stop()
		end
		CloneHumanoid:Move(Humanoid.MoveDirection,false)
	end))
	table.insert(Events, game:GetService("UserInputService").JumpRequest:Connect(function()
		CloneHumanoid.Jump = true
		CloneHumanoid.Sit = false
	end))
	table.insert(Events, game:GetService("RunService").Heartbeat:Connect(function()
		for Index,Object in pairs(CharDescendants) do
			if Object:IsA("BasePart") then
				if IsReanimStabler == true then
					Object:ApplyImpulse(Vector3.new(32.5,0,0))
					Object.Velocity = Vector3.new(32.5,0,0)
				else
					Object.Velocity =  ( getgenv().Jitteryness or Vector3.new(32.5,0,0) ) + Clone["HumanoidRootPart"].CFrame.LookVector * 4.5
				end
			end
		end
		if IsCFrameEnabled then
			if PlayerRigType == "R6" then
				pcall(function()
					ReanimateAPI.CFrameAlign(Character["Head"],Clone["Head"])
					ReanimateAPI.CFrameAlign(Character["Torso"],Clone["Torso"])
					ReanimateAPI.CFrameAlign(Character["Right Arm"],Clone["Right Arm"])
					ReanimateAPI.CFrameAlign(Character["Left Arm"],Clone["Left Arm"])
					ReanimateAPI.CFrameAlign(Character["Right Leg"],Clone["Right Leg"])
					ReanimateAPI.CFrameAlign(Character["Left Leg"],Clone["Left Leg"])
					if getgenv().FrostwareConfig.DisconnectPartFromCFrame == false then
						ReanimateAPI.CFrameAlign(BulletPart, Clone["HumanoidRootPart"])
					end
					for Index,Object in pairs(CharChildren) do
						if Object:IsA("Accessory") then
							ReanimateAPI.CFrameAlign(Object.Handle, Clone[Object.Name].Handle)
						end
					end
				end)
			elseif PlayerRigType == "R15" then
				pcall(function()
					ReanimateAPI.CFrameAlign(Character["Head"], Clone["Head"])
					ReanimateAPI.CFrameAlign(Character["UpperTorso"], Clone["Torso"], R15Offsets.UpperTorso[1])
					ReanimateAPI.CFrameAlign(Character["LowerTorso"], Clone["Torso"], R15Offsets.LowerTorso[1])
					ReanimateAPI.CFrameAlign(Character["HumanoidRootPart"], Character["UpperTorso"], R15Offsets.Root[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperArm"], Clone["Right Arm"], R15Offsets.UpperArm[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerArm"], Clone["Right Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["RightHand"], Clone["Right Arm"], R15Offsets.Hand[1])
					if getgenv().FrostwareConfig.DisconnectPartFromCFrame == false then
						ReanimateAPI.CFrameAlign(BulletPart, Clone["Left Arm"], R15Offsets.UpperArm[1])
					end
					if Character:FindFirstChild("SniperShoulderL") then
						ReanimateAPI.CFrameAlign(Character["SniperShoulderL"].Handle,Clone["Left Arm"],CFrame.new(0,0.52,0))
					end
					ReanimateAPI.CFrameAlign(Character["LeftLowerArm"], Clone["Left Arm"], R15Offsets.LowerArm[1])
					ReanimateAPI.CFrameAlign(Character["LeftHand"], Clone["Left Arm"], R15Offsets.Hand[1])
					
					ReanimateAPI.CFrameAlign(Character["RightUpperLeg"], Clone["Right Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightLowerLeg"], Clone["Right Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["RightFoot"], Clone["Right Leg"], R15Offsets.Foot[1])
								
					ReanimateAPI.CFrameAlign(Character["LeftUpperLeg"], Clone["Left Leg"], R15Offsets.UpperLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftLowerLeg"], Clone["Left Leg"], R15Offsets.LowerLeg[1])
					ReanimateAPI.CFrameAlign(Character["LeftFoot"], Clone["Left Leg"], R15Offsets.Foot[1])

					for Index,Object in pairs(CharChildren) do
						if Object:IsA("Accessory") then
							if Object.Name ~= PartReplica then
								ReanimateAPI.CFrameAlign(Object.Handle, Clone[Object.Name].Handle)
							end
						end
					end
				end)
			end
		end
	end))
	if IsCFrameEnabled == false then
		if PlayerRigType == "R6" then
			ReanimateAPI.Align(Character["Head"], Clone["Head"])
			ReanimateAPI.Align(Character["Torso"],Clone["Torso"])
			ReanimateAPI.Align(Character["Right Arm"],Clone["Right Arm"])
			ReanimateAPI.Align(Character["Left Arm"],Clone["Left Arm"])
			ReanimateAPI.Align(Character["Right Leg"],Clone["Right Leg"])
			ReanimateAPI.Align(Character["Left Leg"],Clone["Left Leg"])
			ReanimateAPI.Align(BulletPart, Clone["HumanoidRootPart"])
			for Index,Object in pairs(CharChildren) do
				if Object:IsA("Accessory") then
					ReanimateAPI.Align(Object.Handle,Clone[Object.Name].Handle)
				end
			end
		elseif PlayerRigType == "R15" then
			ReanimateAPI.Align(Character["Head"],Clone["Head"])
			ReanimateAPI.Align(Character["UpperTorso"],Clone["Torso"],R15Offsets.UpperTorso[2])
			ReanimateAPI.Align(Character["LowerTorso"],Clone["Torso"],R15Offsets.LowerTorso[2])
			ReanimateAPI.Align(Character["HumanoidRootPart"],Character["UpperTorso"],R15Offsets.Root[2])
			
			ReanimateAPI.Align(Character["RightUpperArm"],Clone["Right Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["RightLowerArm"],Clone["Right Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["RightHand"],Clone["Right Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(BulletPart,Clone["Left Arm"],R15Offsets.UpperArm[2])
			ReanimateAPI.Align(Character["LeftLowerArm"],Clone["Left Arm"],R15Offsets.LowerArm[2])
			ReanimateAPI.Align(Character["LeftHand"],Clone["Left Arm"],R15Offsets.Hand[2])
			
			ReanimateAPI.Align(Character["RightUpperLeg"],Clone["Right Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["RightLowerLeg"],Clone["Right Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["RightFoot"],Clone["Right Leg"],R15Offsets.Foot[2])
			
			if Character:FindFirstChild("SniperShoulderL") then
				ReanimateAPI.Align(Character:FindFirstChild("SniperShoulderL").Handle,Clone["Left Arm"],Vector3.new(0,-0.55,0))
			end
			
			ReanimateAPI.Align(Character["LeftUpperLeg"],Clone["Left Leg"],R15Offsets.UpperLeg[2])
			ReanimateAPI.Align(Character["LeftLowerLeg"],Clone["Left Leg"],R15Offsets.LowerLeg[2])
			ReanimateAPI.Align(Character["LeftFoot"],Clone["Left Leg"],R15Offsets.Foot[2])
			for Index,Object in pairs(CharChildren) do
				if Object:IsA("Accessory") then
					if Object.Name ~= PartReplica then
						ReanimateAPI.Align(Object.Handle,Clone[Object.Name].Handle)
					end
				end
			end
		end
	end
	workspace:FindFirstChildWhichIsA("Camera").CameraSubject = CloneHumanoid
	Player.Character = Clone
	task.spawn(function()
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
		task.wait(game.Players.RespawnTime + 0.35)
		Character.Head:BreakJoints()
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
    end)
	getgenv().OGChar = Character
	table.insert(Events, CloneHumanoid.Died:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
		IsPlayerDead = true
		Character.Parent = workspace
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	table.insert(Events, Player.CharacterAdded:Connect(function()
		for Index,RBXSignalEvent in pairs(Events) do
			RBXSignalEvent:Disconnect()
		end
		getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
		IsPlayerDead = true
		Clone:Destroy()
		Player.Character = workspace[Player.Name]
		Character:BreakJoints()
		getgenv().OGChar = nil
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end))
	if AreAnimationsDisabled == false then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/Animations.lua"))()
	end
	ReanimateAPI.PlaySound(5949365181)
end
function ReanimateAPI.SetupFolder()
	-- To Finish
	if not makefolder then
		ReanimateAPI.Notification("Missing Function (makefolder).")
		ReanimateAPI.PlaySound(9074670249)
		return
	end
	if not isfolder then
		ReanimateAPI.Notification("Missing Function (isfolder).")
		ReanimateAPI.PlaySound(9074670249)
		return
	end
	if not writefile then
		ReanimateAPI.Notification("Missing Function (writefile).")
		ReanimateAPI.PlaySound(9074670249)
		return
	end
	if not isfolder("FrostwareSongs") then
		makefolder("FrostwareSongs")
	end
	if not isfile("FrostwareSongs/NeptunianV.mp3") then
		writefile("FrostwareSongs/NeptunianV.mp3", game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Music/Under%20Night%20In-Birth%20ost%20-%20Beat%20Eat%20Nest%20%5BExtended%5D.mp3"))
	end
	if not isfile("FrostwareSongs/ANIMSmoothMoves.mp3") then
		writefile("FrostwareSongs/ANIMSmoothMoves.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Smooth%20Moves.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMOrangeJustice.mp3") then
		writefile("FrostwareSongs/ANIMOrangeJustice.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Orange%20Justice.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMFloss.mp3") then
		writefile("FrostwareSongs/ANIMFloss.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Floss.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMFreestylin'.mp3") then
		writefile("FrostwareSongs/ANIMFreestylin'.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Freestylin'.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMBreakDown.mp3") then
		writefile("FrostwareSongs/ANIMBreakDown.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Breakdown.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMElectroSwing.mp3") then
		writefile("FrostwareSongs/ANIMElectroSwing.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Electro%20Swing.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMParrot.mp3") then
		writefile("FrostwareSongs/ANIMParrot.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Parrot.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMCaramellDansen.mp3") then
		writefile("FrostwareSongs/ANIMCaramellDansen.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Carma.mp3?raw=true"))
	end
	if not isfile("FrostwareSongs/ANIMBoing.mp3") then
		writefile("FrostwareSongs/ANIMBoing.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Boing.mp3?raw=true"))
	end
end
function ReanimateAPI.LoadMusicFromFiles(AudioInstance,Path)
	local CustomAssetFunction = getcustomasset or getsynasset or function() end
	if getgenv().FrostwareConfig.DisableAudio == false then
		AudioInstance.SoundId = CustomAssetFunction(Path,true)
	end
end
function ReanimateAPI.PlayAnimation(ID,SpeedOffset,AudioWanted,AudioPath)
	if not getgenv().OGChar and not workspace:FindFirstChild("Raw") then 
		ReanimateAPI.SimpleReanimate()
		task.wait(1)
	end
	if workspace:FindFirstChild("ScriptCheck") then
		ReanimateAPI.StopScript()
		task.wait(0.1)
	end
	ReanimateAPI.ScriptCheck()
	local Character = game.Players.LocalPlayer.Character
	local CurrentID = ID
	local Sexys = game:GetObjects("rbxassetid://"..tostring(CurrentID))[1]
	local sexy = Sexys
	getgenv().FrostwareConfig.AnimationRunning = true
	sexy.Parent = Character
	sexy.Name = "FrostwareAnimationPlayer"
	local Torso = Character:WaitForChild("Torso")
	local N,RJ = Torso["Neck"],Character["HumanoidRootPart"]["RootJoint"] -- Neck/RootJoint
	local RS,LS = Torso["Right Shoulder"],Torso["Left Shoulder"]-- Shoulders
	local RH,LH = Torso["Right Hip"],Torso["Left Hip"]-- Hips
	local Frames,Positions = {},{}
	local Sound = Instance.new("Sound")
	Sound.Parent = Character
	Sound.Looped = true
	Sound.Name = "FrostwareAnimationMusic"
	task.wait(1)
	if AudioWanted then
		ReanimateAPI.LoadMusicFromFiles(Sound, AudioPath)
		Sound:Play()
	end
	for i,v in pairs(sexy:GetChildren()) do
		table.insert(Frames, v.Time)
		Positions[v.Time] = {}
		for _,g in pairs(v:GetDescendants()) do 
			g.Parent = v; table.insert(Positions[v.Time],g)
		end
	end
	if Character.Humanoid:FindFirstChild("Animator") then
		Character.Humanoid.Animator:Destroy()
	end
	coroutine.wrap(function()
		while true do
			if getgenv().FrostwareConfig.AnimationRunning == false then
				table.clear(Frames)
				table.clear(Positions)
				Sound:Destroy()
				break
			end
			for i,v in pairs(Frames) do
				if getgenv().FrostwareConfig.AnimationRunning == false then
					return
				end
				task.wait(1/SpeedOffset)
				for _,g in pairs(Positions[v]) do
					if getgenv().FrostwareConfig.AnimationRunning == false then
						return
					end
					if g.Name == "Right Arm" then
						RS.Transform = g.CFrame
					end
					if g.Name == "Left Arm" then
						LS.Transform = g.CFrame
					end
					if g.Name == "Right Leg" then
						RH.Transform = g.CFrame
					end
					if g.Name == "Left Leg" then
						LH.Transform = g.CFrame
					end
					if g.Name == "Torso" then
						RJ.Transform = g.CFrame
					end
					if g.Name == "Head" then
						N.Transform = g.CFrame
					end
				end
			end
		end
	end)()
end
function ReanimateAPI.LoadLibrary()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/LoadLibrary.lua"))()
end
return ReanimateAPI
