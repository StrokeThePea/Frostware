--[[
Credits////
Gelatek - Dev
ProductionTakeOne - Help with reanimations
Mizt - Hat Renamer
]]

local API = {}

if not getgenv().FrostwareConfig then 
	getgenv().FrostwareConfig = {
		["TableOfEvents"] = {},
		["ScriptStopped"] = false,
		["AnimationRunning"] = false,
		["DisconnectPartFromCFrame"] = false
	} 
end

if not getgenv().FrostwarePersonalConfig then 
	getgenv().FrostwarePersonalConfig = {
		["FlingSupport"] = false,
		["AnimationsDisabled"] = false,
		["StablerReanimate"] = false,
		["CFrameReanimate"] = false,
		["EnableNetBypass"] = false, 
		["DisableAudio"] = false,
		["PermanentDeath"] = false,
		["BulletEnabled"] = false,
		["DisablePartChecking"] = false 
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


function API.PlaySound(ID)
    local Sound = Instance.new("Sound")
    Sound.Parent = game:FindFirstChild("CoreGui")
    Sound.SoundId = "rbxassetid://"..tostring(ID)
    Sound:Play()
    task.spawn(function()
        task.wait(5)
        Sound:Destroy()
    end)
end

function API.Notification(Texto)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Gelatek Reanimation (V7)",
        Text = Texto
    })
end

function API.ScriptCheck()
	local PartCheck = Instance.new("Part", workspace)
	PartCheck.Name = "ScriptCheck"
	PartCheck.CanCollide = false
	PartCheck.Transparency = 1
	PartCheck.Anchored = true
	PartCheck.Position = Vector3.new(0,1000,0)
end

function API.ReCreateAccessoryWelds(Model,Accessory) -- Inspiration from DevForum Post made by admin.
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

function API.Align(Part0,Part1,OffSetPos,OffsetAngles)
	if not isnetworkowner then Checking = false else Checking = true end
    local Pos = OffSetPos or CFrame.new(0,0,0)
	local Angles = OffsetAngles or CFrame.Angles(0,0,0)
	
	pcall(function()
		if Checking == true then
			if isnetworkowner(Part0) == true then
				Part0.CFrame = Part1.CFrame * Pos * Angles
			end
		else
			Part0.CFrame = Part1.CFrame * Pos * Angles
		end
	end)
end

if workspace:FindFirstChild("GelatekReanimate") then
	API.Notification("Reanimation Already Running! Reset to continue.")
	return
end

local IsFlingEnabled = getgenv().FrostwarePersonalConfig.FlingSupport or false

local AreAnimationsDisabled = getgenv().FrostwarePersonalConfig.AnimationsDisabled or false

local IsReanimStabler = getgenv().FrostwarePersonalConfig.StablerReanimate or false 

local IsNetEnabled = getgenv().FrostwarePersonalConfig.Net or false 

local IsPermaDeath = getgenv().FrostwarePersonalConfig.PermaDeath or false

local IsBulletEnabled = getgenv().FrostwarePersonalConfig.BulletReanimate or false

local PermaLoopCFrame = getgenv().FrostwarePersonalConfig.LoopCFrame or false
--// Functions
local HiddenProps = sethiddenproperty or set_hidden_property or function() end 
	
local SimulationRadius = setsimulationradius or set_simulation_radius or function() end 

local IsPlayerDead, Events, PlayerRigType, HatReplica, Bullet = false, {}, "", nil, nil
--// SimpleAPI
local Stuff = {
	Offsets = {
		["UpperTorso"] = CFrame.new(0,0.194,0),
		["LowerTorso"] = CFrame.new(0,-0.79,0), 
		["Root"] = CFrame.new(0,-0.0025,0),
			
		["UpperArm"] = CFrame.new(0,0.4085,0),
		["LowerArm"] = CFrame.new(0,-0.184,0),
		["Hand"] = CFrame.new(0,-0.83,0),
			
		["UpperLeg"] = CFrame.new(0,0.575,0),
		["LowerLeg"] = CFrame.new(0,-0.199,0),
		["Foot"] = CFrame.new(0,-0.849,0)
	},
	DestroyBodyResizers = function(HumanOid)
		for Index,Object in pairs(HumanOid:GetChildren()) do
			if Object:IsA("NumberValue") then -- (R15 Only) Destroys numbervalues in humanoid to reset body size. 
				Object:Destroy()
				task.wait(0.025) -- Cooldown so it does not trigger in games
			end
		end
	end,
	DisableCollisions = function(Table1, Table2)
		for i,v in pairs(Table1) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
		for i,v in pairs(Table2) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end,
	Movement = function(Humanoid1, Humanoid2)
		local Tracks = Humanoid1:GetPlayingAnimationTracks()
		for Index,Track in pairs(Tracks) do
			Track:Stop()
		end
		Humanoid2:Move(Humanoid1.MoveDirection,false)
	end,
	Jumping = function(Humanoid)
		Humanoid.Jump = true
		Humanoid.Sit = false
	end,
	DisableScripts = function(Model)
		for i,v in pairs(Model:GetChildren()) do
			if v:IsA("LocalScript") then
				v.Disabled = true
			end
		end
	end,
	Network = function()
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
		settings().Physics.AllowSleep = false
		game.Players.LocalPlayer.ReplicationFocus = workspace
		game.Players.LocalPlayer.MaximumSimulationRadius = math.huge
		if syn then
			if identifyexecutor then
				SimulationRadius(math.huge)	
			end
		else
			SimulationRadius(math.huge)
		end
	end,
	CreateSignal = function(DataModel,Name,Callback)
		local Service = game:GetService(DataModel)
		table.insert(Events,Service[Name]:Connect(Callback))
	end,
	CreateDummy = function(Name,Parent)
		local Dummy = game:GetService("ReplicatedStorage"):FindFirstChild("FrostwareData").R6FakeRig:Clone() 
		Dummy.Name = Name or "anus"
		for i,v in pairs(Dummy:GetDescendants()) do
			if v:IsA("BasePart") or v:IsA("Decal") then
				v.Transparency = 1
			end
		end
		Dummy.Parent = Parent or workspace
	end,
	Resetting = function(Model1,Model2)--to finish
		Model1.Parent = workspace
		game.Players.LocalPlayer.Character = workspace[Model1.Name]
		Model2:Destroy()
		Model1:BreakJoints()
		getgenv().OGChar = nil
		for i,v in pairs(Events) do
			v:Disconnect()
		end
		if workspace:FindFirstChild("ScriptCheck") then
			workspace:FindFirstChild("ScriptCheck"):Destroy()
		end
	end,	
	PermaDeath = function(Model)
		task.wait(game:GetService("Players").RespawnTime + 0.65)
		local Head = Model:FindFirstChild("Head")
		Head:BreakJoints() 
	end,
	BreakJoints = function(Table)
		for i,v in pairs(Table) do
			if v:IsA("Motor6D") and v.Name ~= "Neck" then
				v:Destroy()
			elseif v.Name == "AccessoryWeld" then
				v:Destroy()
			end
		end
	end,
	GetRig = function(Humanoid)
		if Humanoid.RigType == Enum.HumanoidRigType.R15 then
			return "R15"
		else
			return "R6"
		end
	end,
	MiztRenamer = function(Table)
		local HatsNameTable = {}
		for Index, Accessory in next, Table do
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
	end
}

--// Main
local Player = game:GetService("Players").LocalPlayer
local Character = Player["Character"]
local Humanoid = Character:FindFirstChildOfClass("Humanoid")
local HatsFolder = Instance.new("Folder")
HatsFolder.Name = "FakeHats"
HatsFolder.Parent = Character
Character.Archivable = true
Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
PlayerRigType = Stuff.GetRig(Humanoid)
if PlayerRigType == "R6" then Character.HumanoidRootPart:Destroy() end
Stuff.DestroyBodyResizers(Humanoid)
Stuff.CreateDummy("GelatekReanimate", workspace)
Stuff.DisableScripts(Character)
local Dummy = workspace:WaitForChild("GelatekReanimate")
local DummyHumanoid = Dummy:FindFirstChildOfClass("Humanoid")
DummyHumanoid.BreakJointsOnDeath = false
if workspace:FindFirstChildOfClass("Camera") then
	workspace:FindFirstChildOfClass("Camera").CameraSubject = DummyHumanoid
end
Dummy:MoveTo(Character.Head.Position + Vector3.new(0,-2,0))
if IsNetEnabled then
	CreateSignal("RunService", "RenderStepped", function()
		Stuff.Network()
	end)
end
--[[
TODO:
-- Perma Death/Bullet Stuff
-- Jitterless
]]

if IsBulletEnabled then
	if IsPermaDeath then
		
	else

	end
end
Character.Parent = Dummy
local CharChildren = Character:GetChildren()
local CharDescendants = Character:GetDescendants()
local DummyChildren = Dummy:GetChildren()
local DummyDescendants = Dummy:GetDescendants()
Stuff.BreakJoints(CharDescendants)
table.insert(Events, Character.ChildAdded:Connect(function(Tool)
	CharChildren = Character:GetChildren()
	CharDescendants = Character:GetDescendants()
	if Tool:IsA("Tool") then 
		pcall(function()
			Tool:Remove(); 
			Player.Backpack[Tool.Name]:Destroy() 
		end) 
	end
end))
table.insert(Events, Character.ChildRemoved:Connect(function()
	CharChildren = Character:GetChildren()
	CharDescendants = Character:GetDescendants()
end))
table.insert(Events, Dummy.ChildAdded:Connect(function()
	DummyChildren = Dummy:GetChildren()
	DummyDescendants = Dummy:GetDescendants()
end))
table.insert(Events, Dummy.ChildRemoved:Connect(function()
	DummyChildren = Dummy:GetChildren()
	DummyDescendants = Dummy:GetDescendants()
end))

Stuff.MiztRenamer(CharChildren)
for i,v in pairs(CharChildren) do
	if v:IsA("Accessory") then
		local FakeHats1 = v:Clone()
		FakeHats1.Handle.Transparency = 1
		FakeHats1.Parent = HatsFolder
		API.ReCreateAccessoryWelds(Dummy, FakeHats1)
		local FakeHats2 = FakeHats1:Clone()
		FakeHats2.Parent = Dummy
	end
end
-- Collisions
Stuff.CreateSignal("RunService", "Stepped", function()
	Stuff.DisableCollisions(CharDescendants, DummyDescendants)
	Stuff.Movement(Humanoid, DummyHumanoid)
end)

-- Jumping
Stuff.CreateSignal("UserInputService", "JumpRequest", function()
	Stuff.Jumping(DummyHumanoid)
end)


for i,v in pairs(CharDescendants) do
	if v:IsA("BasePart") then
		v.RootPriority = 127
	end
end
-- Velocity/MainPart
local POWPower = 6
Stuff.CreateSignal("RunService", "Heartbeat", function()
	for i,v in pairs(CharDescendants) do
		if v:IsA("BasePart") and v.Name ~= "Head" then
			if v and v.Parent then
				v.Velocity = Vector3.new(Dummy["Torso"].AssemblyLinearVelocity.X*2.5,Dummy["Torso"].AssemblyLinearVelocity.Y*2.5,-27.63)
			end
		end
		if v:IsA("Accessory") then
			if v and v.Parent then
				API.Align(v.Handle,Dummy[v.Name].Handle)
			end
		end
	end
	pcall(function()
		if PlayerRigType == "R6" then
			API.Align(Character["Torso"], Dummy["Torso"])
			API.Align(Character["Right Arm"], Dummy["Right Arm"])
			API.Align(Character["Left Arm"], Dummy["Left Arm"])
			API.Align(Character["Right Leg"], Dummy["Right Leg"])
			API.Align(Character["Left Leg"], Dummy["Left Leg"])
		else
			Character.PrimaryPart = Character["UpperTorso"]
			API.Align(Character["UpperTorso"], Dummy["Torso"], Stuff.Offsets.UpperTorso)
			Character["HumanoidRootPart"].Transparency = 0
			API.Align(Character["HumanoidRootPart"], Character["UpperTorso"], Stuff.Offsets.Root)
			API.Align(Character["LowerTorso"], Dummy["Torso"], Stuff.Offsets.LowerTorso)
			
			API.Align(Character["RightUpperArm"], Dummy["Right Arm"], Stuff.Offsets.UpperArm)
			API.Align(Character["RightLowerArm"], Dummy["Right Arm"], Stuff.Offsets.LowerArm)
			API.Align(Character["RightHand"], Dummy["Right Arm"], Stuff.Offsets.Hand)

			API.Align(Character["LeftUpperArm"], Dummy["Left Arm"], Stuff.Offsets.UpperArm)
			API.Align(Character["LeftLowerArm"], Dummy["Left Arm"], Stuff.Offsets.LowerArm)
			API.Align(Character["LeftHand"], Dummy["Left Arm"], Stuff.Offsets.Hand)
						
			API.Align(Character["RightUpperLeg"], Dummy["Right Leg"], Stuff.Offsets.UpperLeg)
			API.Align(Character["RightLowerLeg"], Dummy["Right Leg"], Stuff.Offsets.LowerLeg)
			API.Align(Character["RightFoot"], Dummy["Right Leg"], Stuff.Offsets.Foot)
									
			API.Align(Character["LeftUpperLeg"], Dummy["Left Leg"], Stuff.Offsets.UpperLeg)
			API.Align(Character["LeftLowerLeg"], Dummy["Left Leg"], Stuff.Offsets.LowerLeg)
			API.Align(Character["LeftFoot"], Dummy["Left Leg"], Stuff.Offsets.Foot)
		end
	end)
end)
getgenv().OGChar = Character
game.Players.LocalPlayer.Character = Dummy
table.insert(Events, DummyHumanoid.Died:Connect(function()
	Stuff.Resetting(Character, Dummy)
end))
table.insert(Events, game.Players.LocalPlayer.CharacterAdded:Connect(function()
	Stuff.Resetting(Character, Dummy)
end))
if AreAnimationsDisabled ~= true then
	loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/Animations.lua"))()
end
API.Notification("Loaded! Enjoy")
