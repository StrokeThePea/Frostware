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
	-- Check if you want to permamentally keep looping your parts
	local Checking
	if getgenv().FrostwarePersonalConfig.DisablePartChecking == true then
		Checking = false
	else
		Checking = true
	end
	if not isnetworkowner then Checking = false end
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

function API.StopScript()
	if not workspace:FindFirstChild("GelatekReanimate") then
		API.Notification("Reanimation already running! Reset to change")
		API.PlaySound(8499261098)
		task.wait(99e9)
		return
	end
	getgenv().FrostwareConfig.DisconnectPartFromCFrame = false
	getgenv().FrostwareConfig.ScriptStopped = true
	getgenv().FrostwareConfig.AnimationRunning = false
	for Index,Loop in pairs(getgenv().FrostwareConfig.TableOfEvents) do
		Loop:Disconnect()
	end
	local CloneChar = workspace["GelatekReanimate"]
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
	end)
	if game:GetService("Workspace"):FindFirstChild("ScriptCheck") then
		game:GetService("Workspace").ScriptCheck:Destroy() -- i fucking hate this fix
	end
	
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
		if Objects:IsA("Sound") then
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
			API.ReCreateAccessoryWelds(CloneChar, FakeAccessory)
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
	end
	Root.Anchored = false
	getgenv().FrostwareConfig.ScriptStopped = false
end

return API
