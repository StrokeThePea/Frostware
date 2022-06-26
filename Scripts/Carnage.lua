
--[[
    Put the API loader at the top of the script
]]
local ReanimateAPI = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/Libraries/ReanimateAPI.lua"))()
if not workspace:FindFirstChild("Raw") then
	ReanimateAPI.Notification("Not Reanimated!")
    return
end

if workspace:FindFirstChild("ScriptCheck") then
	ReanimateAPI.Notification("Script Already Running! Stop script to continue.")
    return
end
ReanimateAPI.ScriptCheck()
--[[
local HatName = "Hat1"
local HatName2 = "Hat2"
if not game.Players.LocalPlayer.Character:FindFirstChild(HatName) then
    ReanimateAPI.Notification("Missing Hat: "..HatName)
    return
end
if not game.Players.LocalPlayer.Character:FindFirstChild(HatName2) then
    ReanimateAPI.Notification("Missing Hat: "..HatName2)
    return
end
]]

local script = game:GetObjects("rbxassetid://10014432016")[1]
local function swait(dur)
	if(dur == 0 or typeof(dur) ~= 'number')then
		task.wait()
	else
		for i = 1, dur*30 do
			task.wait()
		end
	end
end


local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player.PlayerGui
local Cam = workspace.CurrentCamera
local Backpack = Player.Backpack
local Character = Player.Character
local Humanoid = Character.Humanoid
local Mouse = Player:GetMouse()
local RootPart = Character["HumanoidRootPart"]
local Torso = Character["Torso"]
local Head = Character["Head"]
local RightArm = Character["Right Arm"]
local LeftArm = Character["Left Arm"]
local RightLeg = Character["Right Leg"]
local LeftLeg = Character["Left Leg"]
local RootJoint = RootPart["RootJoint"]
local Neck = Torso["Neck"]
local RightShoulder = Torso["Right Shoulder"]
local LeftShoulder = Torso["Left Shoulder"]
local RightHip = Torso["Right Hip"]
local LeftHip = Torso["Left Hip"]
local sick = Instance.new("Sound",Torso)

IT = Instance.new
CF = CFrame.new
VT = Vector3.new
RAD = math.rad
C3 = Color3.new
UD2 = UDim2.new
BRICKC = BrickColor.new
ANGLES = CFrame.Angles
EULER = CFrame.fromEulerAnglesXYZ
COS = math.cos
ACOS = math.acos
SIN = math.sin
ASIN = math.asin
ABS = math.abs
MRANDOM = math.random
FLOOR = math.floor


Animation_Speed = 3
Frame_Speed = 1 / 60 -- (1 / 30) OR (1 / 60)
local Speed = 45
local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))
local DAMAGEMULTIPLIER = 1
local ANIM = "Idle"
local ATTACK = false
local EQUIPPED = false
local actualshot = false
local HOLD = false
local COMBO = 1
local Rooted = false
local SINE = 0
local KEYHOLD = false
local CHANGE = 2 / Animation_Speed
local WALKINGANIM = false
local VALUE1 = false
local VALUE2 = false
local ROBLOXIDLEANIMATION = IT("Animation")
ROBLOXIDLEANIMATION.Name = "Roblox Idle Animation"
ROBLOXIDLEANIMATION.AnimationId = "http://www.roblox.com/asset/?id=180435571"
--ROBLOXIDLEANIMATION.Parent = Humanoid
local WEAPONGUI = IT("ScreenGui", PlayerGui)
WEAPONGUI.Name = "Weapon GUI"
local Effects = IT("Folder", Character)
Effects.Name = "Effects"
local ANIMATOR = Humanoid.Animator
local ANIMATE = Character:FindFirstChild("Animate")
pcall(function() ANIMATE.Disabled = true end)
local UNANCHOR = true
local HITPLAYERSOUNDS = {--[["199149137", "199149186", "199149221", "199149235", "199149269", "199149297"--]]"263032172", "263032182", "263032200", "263032221", "263032252", "263033191"}



local ArtificialHB = Instance.new("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"
script:WaitForChild("ArtificialHB")

local frame = Frame_Speed
local tf = 0
local allowframeloss = false
local tossremainder = false
local lastframe = tick()
script.ArtificialHB:Fire()

if getgenv().OGChar and getgenv().OGChar:FindFirstChild("Bullet") then
	getgenv().FrostwareConfig.DisconnectPartFromCFrame = true
	local OnHold = false
	local Players = game.Players
	local Reanim = game.Players.LocalPlayer.Character
	local Bullet = getgenv().OGChar:FindFirstChild("Bullet")
	local Mouse = game.Players.LocalPlayer:GetMouse()
	Bullet:ClearAllChildren()
	Bullet.Transparency = 1
	local Highlight = Instance.new("SelectionBox")
	Highlight.Adornee = Bullet
	Highlight.Parent = Bullet
	Highlight.Color3 = Color3.fromRGB(13, 105, 172)
	local BP = Instance.new("BodyPosition")
	BP.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
	BP.P = 22500
	BP.D = 125
	BP.Position = Bullet.Position
	BP.Parent = Bullet
	local Thrust = Instance.new("BodyThrust")
	Thrust.Force = Vector3.new(200,200,200)
	Thrust.Parent = Bullet
	table.insert(getgenv().FrostwareConfig.TableOfEvents, Mouse.Button1Down:Connect(function()
		OnHold = true
	end))
		
	table.insert(getgenv().FrostwareConfig.TableOfEvents, Mouse.Button1Up:Connect(function()
		OnHold = false
	end))
		
	table.insert(getgenv().FrostwareConfig.TableOfEvents, game:GetService("RunService").RenderStepped:Connect(function()
		pcall(function()
			if OnHold and ATTACK then
				if Players:GetPlayerFromCharacter(Mouse.Target.Parent) then
					if Mouse.Target.Parent.Name ~= Players.LocalPlayer.Name then
						if Mouse.Target ~= nil then
							BP.Position = Mouse.Target.Parent:FindFirstChild("Head").CFrame.p + Vector3.new(0,-2,0)
						end
					end
				elseif Players:GetPlayerFromCharacter(Mouse.Target.Parent.Parent) then
					if Mouse.Target.Parent.Parent.Name ~= Players.LocalPlayer.Name then
						if Mouse.Target ~= nil then
							BP.Position = Mouse.Target.Parent.Parent:FindFirstChild("Head").CFrame.p + Vector3.new(0,-2,0)
						end
					end
				else
					BP.Position = Mouse.Hit.p
				end
			else
				BP.Position = Reanim:FindFirstChild("Torso").Position 
			end
			Thrust.Location = BP.Position
		end)
	end))
end

table.insert(getgenv().FrostwareConfig.TableOfEvents, game:GetService("RunService").Heartbeat:connect(function(s, p)
	pcall(function()
		tf = tf + s
		if tf >= frame then
			if allowframeloss then
				script.ArtificialHB:Fire()
				lastframe = tick()
			else
				for i = 1, math.floor(tf / frame) do
					script.ArtificialHB:Fire()
				end
			lastframe = tick()
			end
			if tossremainder then
				tf = 0
			else
				tf = tf - frame * math.floor(tf / frame)
			end
		end
	end)
end))


local function Raycast(POSITION, DIRECTION, RANGE, IGNOREDECENDANTS)
	return workspace:FindPartOnRay(Ray.new(POSITION, DIRECTION.unit * RANGE), IGNOREDECENDANTS)
end

local function PositiveAngle(NUMBER)
	if NUMBER >= 0 then
		NUMBER = 0
	end
	return NUMBER
end

local function NegativeAngle(NUMBER)
	if NUMBER <= 0 then
		NUMBER = 0
	end
	return NUMBER
end

local function Swait(NUMBER)
	if NUMBER == 0 or NUMBER == nil then
		task.wait()
	else
		for i = 1, NUMBER do
			task.wait()
		end
	end
end

local function CreateMesh(MESH, PARENT, MESHTYPE, MESHID, TEXTUREID, SCALE, OFFSET)
	local NEWMESH = IT(MESH)
	if MESH == "SpecialMesh" then
		NEWMESH.MeshType = MESHTYPE
		if MESHID ~= "nil" and MESHID ~= "" then
			NEWMESH.MeshId = "http://www.roblox.com/asset/?id="..MESHID
		end
		if TEXTUREID ~= "nil" and TEXTUREID ~= "" then
			NEWMESH.TextureId = "http://www.roblox.com/asset/?id="..TEXTUREID
		end
	end
	NEWMESH.Offset = OFFSET or VT(0, 0, 0)
	NEWMESH.Scale = SCALE
	NEWMESH.Parent = PARENT
	return NEWMESH
end

local function CreatePart(FORMFACTOR, PARENT, MATERIAL, REFLECTANCE, TRANSPARENCY, BRICKCOLOR, NAME, SIZE, ANCHOR)
	local NEWPART = IT("Part")
	NEWPART.formFactor = FORMFACTOR
	NEWPART.Reflectance = REFLECTANCE
	NEWPART.Transparency = TRANSPARENCY
	NEWPART.CanCollide = false
	NEWPART.Locked = true
	NEWPART.Anchored = true
	if ANCHOR == false then
		NEWPART.Anchored = false
	end
	NEWPART.BrickColor = BRICKC(tostring(BRICKCOLOR))
	NEWPART.Name = NAME
	NEWPART.Size = SIZE
	NEWPART.Position = Torso.Position
	NEWPART.Material = MATERIAL
	NEWPART:BreakJoints()
	NEWPART.Parent = PARENT
	return NEWPART
end

	local function weldBetween(a, b)
	    local weldd = Instance.new("ManualWeld")
	    weldd.Part0 = a
	    weldd.Part1 = b
	    weldd.C0 = CFrame.new()
	    weldd.C1 = b.CFrame:inverse() * a.CFrame
	    weldd.Parent = a
	    return weldd
	end


function Clerp(a, b, t)
    return a:lerp(b,t)
end


local function CreateFrame(PARENT, TRANSPARENCY, BORDERSIZEPIXEL, POSITION, SIZE, COLOR, BORDERCOLOR, NAME)
	local frame = IT("Frame")
	frame.BackgroundTransparency = TRANSPARENCY
	frame.BorderSizePixel = BORDERSIZEPIXEL
	frame.Position = POSITION
	frame.Size = SIZE
	frame.BackgroundColor3 = COLOR
	frame.BorderColor3 = BORDERCOLOR
	frame.Name = NAME
	frame.Parent = PARENT
	return frame
end

local function CreateLabel(PARENT, TEXT, TEXTCOLOR, TEXTFONTSIZE, TEXTFONT, TRANSPARENCY, BORDERSIZEPIXEL, STROKETRANSPARENCY, NAME)
	local label = IT("TextLabel")
	label.BackgroundTransparency = 1
	label.Size = UD2(1, 0, 1, 0)
	label.Position = UD2(0, 0, 0, 0)
	label.TextColor3 = TEXTCOLOR
	label.TextStrokeTransparency = STROKETRANSPARENCY
	label.TextTransparency = TRANSPARENCY
	label.FontSize = TEXTFONTSIZE
	label.Font = TEXTFONT
	label.BorderSizePixel = BORDERSIZEPIXEL
	label.TextScaled = false
	label.Text = TEXT
	label.Name = NAME
	label.Parent = PARENT
	return label
end

local function NoOutlines(PART)
	PART.TopSurface, PART.BottomSurface, PART.LeftSurface, PART.RightSurface, PART.FrontSurface, PART.BackSurface = 10, 10, 10, 10, 10, 10
end

local function CreateWeldOrSnapOrMotor(TYPE, PARENT, PART0, PART1, C0, C1)
	local NEWWELD = IT(TYPE)
	NEWWELD.Part0 = PART0
	NEWWELD.Part1 = PART1
	NEWWELD.C0 = C0
	NEWWELD.C1 = C1
	NEWWELD.Parent = PARENT
	return NEWWELD
end

local S = IT("Sound")
local function CreateSound(ID, PARENT, VOLUME, PITCH, DOESLOOP)
	local NEWSOUND = nil
	coroutine.resume(coroutine.create(function()
		NEWSOUND = S:Clone()
		NEWSOUND.EmitterSize = 5*VOLUME
		NEWSOUND.Parent = PARENT
		NEWSOUND.Volume = VOLUME
		NEWSOUND.Pitch = PITCH
		NEWSOUND.SoundId = "http://www.roblox.com/asset/?id="..ID
		NEWSOUND:play()
		if DOESLOOP == true then
			NEWSOUND.Looped = true
		else
			repeat wait(1) until NEWSOUND.Playing == false
			NEWSOUND:remove()
		end
	end))
	return NEWSOUND
end

function CFrameFromTopBack(at, top, back)
	local right = top:Cross(back)
	return CF(at.x, at.y, at.z, right.x, top.x, back.x, right.y, top.y, back.y, right.z, top.z, back.z)
end

--WACKYEFFECT({EffectType = "", Size = VT(1,1,1), Size2 = VT(0,0,0), Transparency = 0, Transparency2 = 1, CFrame = CF(), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,1,1), SoundID = nil, SoundPitch = nil, SoundVolume = nil})
local function WACKYEFFECT(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = VT(SIZE.X,SIZE.X,SIZE.X)
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME+1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH/TIME
				if TYPE == "Wave" then
					MSH.Offset = VT(0,0,-MSH.Scale.X/8)
				end
				EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				else
					EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation
					EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:Destroy()
			else
				repeat Swait() until SOUND.Playing == false
				EFFECT:Destroy()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:Destroy()
			else
				repeat Swait() until SOUND.Playing == false
				EFFECT:Destroy()
			end
		end
	end))
end

local function WACKYEFFECT2(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = (Table.Time or 45)
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	local ISCHAOS = (Table.Chaos or false)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC"a", "Effect", VT(1,1,1), true)
		EFFECT.Color = COLOR
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "1051557", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				MOVESPEED = (CFRAME.p - MOVEDIRECTION).Magnitude/TIME
			end
			local GROWTH = SIZE - ENDSIZE
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			for LOOP = 1, TIME+1 do
				Swait()
				MSH.Scale = MSH.Scale - GROWTH/TIME
				if ISCHAOS == true then
				EFFECT.Color = BrickColor.Random().Color
				end
				if TYPE == "Wave" then
					MSH.Offset = VT(0,0,-MSH.Scale.X/8)
				end
				EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
				
				if TYPE == "Block" then
					EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
				else
					EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
				end
				if MOVEDIRECTION ~= nil then
					local ORI = EFFECT.Orientation
					EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
					EFFECT.Orientation = ORI
				end
			end
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end

local function WACKYEFFECT2(Table)
	local TYPE = (Table.EffectType or "Sphere")
	local SIZE = (Table.Size or VT(1,1,1))
	local ENDSIZE = (Table.Size2 or VT(0,0,0))
	local TRANSPARENCY = (Table.Transparency or 0)
	local ENDTRANSPARENCY = (Table.Transparency2 or 1)
	local CFRAME = (Table.CFrame or Torso.CFrame)
	local MOVEDIRECTION = (Table.MoveToPos or nil)
	local ROTATION1 = (Table.RotationX or 0)
	local ROTATION2 = (Table.RotationY or 0)
	local ROTATION3 = (Table.RotationZ or 0)
	local MATERIAL = (Table.Material or "Neon")
	local COLOR = (Table.Color or C3(1,1,1))
	local TIME = 10
	local SOUNDID = (Table.SoundID or nil)
	local SOUNDPITCH = (Table.SoundPitch or nil)
	local SOUNDVOLUME = (Table.SoundVolume or nil)
	local USEBOOMERANGMATH = (Table.UseBoomerangMath or false)
	local BOOMERANG = (Table.Boomerang or 0)
	local SIZEBOOMERANG = (Table.SizeBoomerang or 0)
	coroutine.resume(coroutine.create(function()
		local PLAYSSOUND = false
		local SOUND = nil
		local EFFECT = CreatePart(3, Effects, MATERIAL, 0, TRANSPARENCY, BRICKC("Pearl"), "Effect", VT(1,1,1), true)
		if SOUNDID ~= nil and SOUNDPITCH ~= nil and SOUNDVOLUME ~= nil then
			PLAYSSOUND = true
			SOUND = CreateSound(SOUNDID, EFFECT, SOUNDVOLUME, SOUNDPITCH, false)
		end
		EFFECT.Color = COLOR
		local MSH = nil
		if TYPE == "Sphere" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "Sphere", "", "", SIZE, VT(0,0,0))
		elseif TYPE == "Block" or TYPE == "Box" then
			MSH = IT("BlockMesh",EFFECT)
			MSH.Scale = SIZE
		elseif TYPE == "Wave" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "20329976", "", SIZE, VT(0,0,-SIZE.X/8))
		elseif TYPE == "Ring" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "559831844", "", VT(SIZE.X,SIZE.X,0.1), VT(0,0,0))
		elseif TYPE == "Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662586858", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Round Slash" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "662585058", "", VT(SIZE.X/10,0,SIZE.X/10), VT(0,0,0))
		elseif TYPE == "Swirl" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "168892432", "", SIZE, VT(0,0,0))
		elseif TYPE == "Skull" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "4770583", "", SIZE, VT(0,0,0))
		elseif TYPE == "Crystal" then
			MSH = CreateMesh("SpecialMesh", EFFECT, "FileMesh", "9756362", "", SIZE, VT(0,0,0))
		end
		if MSH ~= nil then
			local BOOMR1 = 1+BOOMERANG/50
			local BOOMR2 = 1+SIZEBOOMERANG/50
			local MOVESPEED = nil
			if MOVEDIRECTION ~= nil then
				if USEBOOMERANGMATH == true then
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)*BOOMR1
				else
					MOVESPEED = ((CFRAME.p - MOVEDIRECTION).Magnitude/TIME)
				end
			end
			local GROWTH = nil
			if USEBOOMERANGMATH == true then
				GROWTH = (SIZE - ENDSIZE)*(BOOMR2+1)
			else
				GROWTH = (SIZE - ENDSIZE)
			end
			local TRANS = TRANSPARENCY - ENDTRANSPARENCY
			if TYPE == "Block" then
				EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
			else
				EFFECT.CFrame = CFRAME
			end
			if USEBOOMERANGMATH == true then
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - (VT((GROWTH.X)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Y)*((1 - (LOOP/TIME)*BOOMR2)),(GROWTH.Z)*((1 - (LOOP/TIME)*BOOMR2)))*BOOMR2)/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-(MOVESPEED)*((1 - (LOOP/TIME)*BOOMR1)))
						EFFECT.Orientation = ORI
					end
				end
			else
				for LOOP = 1, TIME+1 do
					Swait()
					MSH.Scale = MSH.Scale - GROWTH/TIME
					if TYPE == "Wave" then
						MSH.Offset = VT(0,0,-MSH.Scale.Z/8)
					end
					EFFECT.Transparency = EFFECT.Transparency - TRANS/TIME
					if TYPE == "Block" then
						EFFECT.CFrame = CFRAME*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))
					else
						EFFECT.CFrame = EFFECT.CFrame*ANGLES(RAD(ROTATION1),RAD(ROTATION2),RAD(ROTATION3))
					end
					if MOVEDIRECTION ~= nil then
						local ORI = EFFECT.Orientation
						EFFECT.CFrame = CF(EFFECT.Position,MOVEDIRECTION)*CF(0,0,-MOVESPEED)
						EFFECT.Orientation = ORI
					end
				end
			end
			EFFECT.Transparency = 1
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		else
			if PLAYSSOUND == false then
				EFFECT:remove()
			else
				repeat Swait() until EFFECT:FindFirstChildOfClass("Sound") == nil
				EFFECT:remove()
			end
		end
	end))
end


local function MakeForm(PART,TYPE)
	if TYPE == "Cyl" then
		local MSH = IT("CylinderMesh",PART)
	elseif TYPE == "Ball" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Sphere"
	elseif TYPE == "Wedge" then
		local MSH = IT("SpecialMesh",PART)
		MSH.MeshType = "Wedge"
	end
end

Debris = game:GetService("Debris")

local function CastProperRay(StartPos, EndPos, Distance, Ignore)
	local DIRECTION = CF(StartPos,EndPos).lookVector
	return Raycast(StartPos, DIRECTION, Distance, Ignore)
end

local function Gyro(PARENT)
	local GYRO = IT("BodyGyro",PARENT)
	GYRO.D = 750
	GYRO.P = 20000
	GYRO.MaxTorque = VT(0,40000000,0)
	return GYRO
end

local function POSITION(PARENT)
	local grav = Instance.new("BodyPosition",PARENT)
	grav.D = 15
	grav.P = 20000
	grav.maxForce = Vector3.new(math.huge,math.huge,math.huge)
	return grav
end

local function FacialShadow()
	local SHADOWS = {}
	for i = 1, 16 do
		local FACE = CreatePart(3, Effects, "Fabric", 0, 0+(i-1)/16.2, "Dark stone grey", "FaceGradient", VT(1.01,0.65,1.01),false)
		FACE.Color = C3(0,0,0)
		Head:FindFirstChildOfClass("SpecialMesh"):Clone().Parent = FACE
		CreateWeldOrSnapOrMotor("Weld", Head, Head, FACE, CF(0,0.35-(i-1)/25,0), CF(0, 0, 0))
		table.insert(SHADOWS,FACE)
	end
	local UNDO = function()
		for i = 1, #SHADOWS do
			SHADOWS[i]:remove()
		end
	end
	return UNDO
end

local function GetRoot(MODEL,ROOT)
	if ROOT == true then
		return MODEL:FindFirstChild("HumanoidRootPart") or MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	else
		return MODEL:FindFirstChild("Torso") or MODEL:FindFirstChild("UpperTorso")
	end
end

local function CreateFlyingDebree(FLOOR,POSITION,AMOUNT,BLOCKSIZE,SWAIT,STRENGTH)
	if FLOOR ~= nil then
		for i = 1, AMOUNT do
			local DEBREE = CreatePart(3, Effects, "Neon", FLOOR.Reflectance, FLOOR.Transparency, "Peal", "Debree", BLOCKSIZE, false)
			DEBREE.Material = FLOOR.Material
			DEBREE.Color = FLOOR.Color
			DEBREE.CFrame = POSITION * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
			DEBREE.Velocity = VT(MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH),MRANDOM(-STRENGTH,STRENGTH))
			coroutine.resume(coroutine.create(function()
				Swait(15)
				DEBREE.Parent = workspace
				DEBREE.CanCollide = true
				Debris:AddItem(DEBREE,SWAIT)
			end))
		end
	end
end

local function SHAKECAM(POSITION,RANGE,INTENSITY,TIME)
	local CHILDREN = workspace:GetDescendants()
	for index, CHILD in pairs(CHILDREN) do
		if CHILD.ClassName == "Model" then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						local CAMSHAKER = script.CamShake:Clone()
						CAMSHAKER.Shake.Value = INTENSITY
						CAMSHAKER.Timer.Value = TIME
						CAMSHAKER.Parent = CHILD
						CAMSHAKER.Disabled = false
					end
				end
			end
		end
	end
end

--Lightning({Material = "Neon", FadeIn = false, Color = C3(1,1,1), Start = Torso.Position, End = Mouse.Hit.p, SegmentL = 2, Thickness = 0.1, DoesFade = false, Ignore = Character, MaxDist = 400, Branches = false, FadeTime = 15, Thicken = false})
local function Lightning(Table)
	local Color = Table.Color or C3(1,1,1)
	local StartPos = Table.Start or Torso.Position
	local EndPos = Table.End or Mouse.Hit.p
	local SegmentLength = Table.SegmentL or 2
	local Thickness = Table.Thickness or 0.1
	local Dissapear = Table.DoesFade or false
	local Parent = Table.Ignore or Character
	local MaxDist = Table.MaxDist or 400
	local Branches = Table.Branches or false
	local Thicken = Table.Thicken or false
	local FadeTime = Table.FadeTime or 15
	local FadeIn = Table.FadeIn or false
	local Material = Table.Material or "Neon"
	local HIT,HITPOS = CastProperRay(StartPos, EndPos, MaxDist, Parent)
	local DISTANCE = math.ceil((StartPos - HITPOS).Magnitude/((SegmentLength/SegmentLength)/1.5))
	local LIGHTNINGMODEL = IT("Model",Effects)
	LIGHTNINGMODEL.Name = "Lightning"
	local LastBolt = nil
	for E = 1, DISTANCE do
		local ExtraSize = 0
		if Thicken == true then
			ExtraSize = (DISTANCE-E)/15
		end
		local TRANSPARENCY = 0
		if FadeIn == true then
			TRANSPARENCY = 1-(E/(DISTANCE/1.5))
			if TRANSPARENCY < 0 then
				TRANSPARENCY = 0
			end
		end
		local PART = CreatePart(3, LIGHTNINGMODEL, Material, 0, TRANSPARENCY, BRICKC("Pearl"), "LightningPart"..E, VT(Thickness+ExtraSize,SegmentLength,Thickness+ExtraSize))
		PART.Color = Color
		--MakeForm(PART,"Cyl")
		if LastBolt == nil then
			PART.CFrame = CF(StartPos,HITPOS)*ANGLES(RAD(90),RAD(0),RAD(0))*CF(0,-PART.Size.Y/2,0)
		else
			PART.CFrame = CF(LastBolt.CFrame*CF(0,-LastBolt.Size.Y/2,0).p,CF(HITPOS)*ANGLES(RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)),RAD(MRANDOM(0,360)))*CF(0,0,DISTANCE-E).p)*ANGLES(RAD(90),RAD(0),RAD(0))*CF(0,-PART.Size.Y/2,0)
		end
		LastBolt = PART
		if Branches == true and E < (DISTANCE-5) then
			local CHOICE = MRANDOM(1,7+((DISTANCE-E)*2))
			if CHOICE == 1 then
				local LASTBRANCH = nil
				for i = 1, MRANDOM(2,5) do
					local ExtraSize2 = 0
					if Thicken == true then
						ExtraSize = ((DISTANCE-E)/25)/i
					end
					local PART = CreatePart(3, LIGHTNINGMODEL, Material, 0, TRANSPARENCY, BRICKC("Pearl"), "Branch"..E.."-"..i, VT(Thickness+ExtraSize2,SegmentLength,Thickness+ExtraSize2))
					PART.Color = Color
					MakeForm(PART,"Cyl")
					if LASTBRANCH == nil then
						PART.CFrame = CF(LastBolt.CFrame*CF(0,-LastBolt.Size.Y/2,0).p,LastBolt.CFrame*CF(0,-LastBolt.Size.Y/2,0)*ANGLES(RAD(0),RAD(0),RAD(MRANDOM(0,360)))*CF(0,Thickness*7,0)*CF(0,0,-1).p)*ANGLES(RAD(90),RAD(0),RAD(0))*CF(0,-PART.Size.Y/2,0)
					else
						PART.CFrame = CF(LASTBRANCH.CFrame*CF(0,-LASTBRANCH.Size.Y/2,0).p,LASTBRANCH.CFrame*CF(0,-LASTBRANCH.Size.Y/2,0)*ANGLES(RAD(0),RAD(0),RAD(MRANDOM(0,360)))*CF(0,Thickness*3,0)*CF(0,0,-1).p)*ANGLES(RAD(90),RAD(0),RAD(0))*CF(0,-PART.Size.Y/2,0)
					end
					LASTBRANCH = PART
				end
			end
		end
	end
	if Dissapear == true then
		coroutine.resume(coroutine.create(function()
			for i = 1, FadeTime do
				Swait()
				for _, c in pairs(LIGHTNINGMODEL:GetChildren()) do
					if c.ClassName == "Part" then
						c.Transparency = c.Transparency + (i/FadeTime)/10
					end
				end
			end
			LIGHTNINGMODEL:remove()
		end))
	elseif Dissapear == false then
		Debris:AddItem(LIGHTNINGMODEL,0.1)
	end
	return {Hit = HIT,Pos = HITPOS,End = LastBolt.CFrame*CF(0,0,-LastBolt.Size.Z).p,LastBolt = LastBolt,Model = LIGHTNINGMODEL}
end


--weap
local SONG = 590141342

local Hat1 = "METALXLIGHTSEER77Accessory"
local Hat2 = "Red Sci-Fi Scattergun"
Character[Hat1].Handle.AccessoryWeld:Destroy()
Character[Hat2].Handle.AccessoryWeld:Destroy()
local shotgunact = false
local gunact = true

--[[
ReanimateAPI.Align(Character[Hat1], gun)

Revolver Unequipped: FakeGun / Variable: fgun
Shotgun Unequipped: FShot / Variable: fshot

Revolver Equipped: Gun / Variable: gun
Shotgun Equipped: BShot / Variable: shotgun
All of them have handle part.

META: When Parent Changes, The Hat Changes the Part0 Align
]]
local function DestroyThingies(Part)
	for i,v in pairs(Part:GetChildren()) do
		if v.Name ~= "FrostWareAtt2" and v.Name ~= "SpecialMesh" then
			v:Destroy()
		end
	end
end -- Last Line
local gun = script.Gun
for i,v in pairs(gun:GetChildren()) do
	v.Anchored = false
end
local hole = gun.Hole 
local gunw = CreateWeldOrSnapOrMotor("Weld",LeftArm,gun.Handle,LeftArm,CF(0,0,.5) * ANGLES(RAD(90),0,0),CF(0,0,0))
gun.Parent = Character
ReanimateAPI.Align(Character[Hat1].Handle, gun.Handle,Vector3.new(1.2,0.1,0),Vector3.new(-40,90,0))
local shotgun = script.BShot
for i,v in pairs(shotgun:GetChildren()) do
	v.Anchored = false
end
local sgw = CreateWeldOrSnapOrMotor("Weld",RightArm,shotgun.Main,RightArm,CF(0,.4,0),CF(0,0,0))
shotgun.Parent = nil

local fshot = script.FShot
for i,v in pairs(fshot:GetChildren()) do
	v.Anchored = false
end
local fsw = CreateWeldOrSnapOrMotor("Weld",Torso,fshot.Main,Torso,CF(0,0,0),CF(0,0,0))
fshot.Parent = Character
ReanimateAPI.Align(Character[Hat2].Handle, fshot.Handle,Vector3.new(1,1,0),Vector3.new(0,180,215))

local mascc = script.Mask
for i,v in pairs(mascc:GetChildren()) do
	v.Anchored = false
end
local mw = CreateWeldOrSnapOrMotor("Weld",Head,mascc.Middle,Head,CF(0,0,0),CF(0,0,0))
mascc.Parent = Character

local fgun = script.FakeGun
for i,v in pairs(fgun:GetChildren()) do
	v.Anchored = false
end
local fgunw = CreateWeldOrSnapOrMotor("Weld",Torso,fgun.Main,Torso,CF(0,0,0),CF(0,0,0))
fgun.Parent = nil

local hole2 = shotgun.Hole
for i,v in pairs(gun:GetDescendants()) do
	if v:IsA("BasePart") then v.Transparency = 1 end
end
for i,v in pairs(fshot:GetDescendants()) do
	if v:IsA("BasePart") then v.Transparency = 1 end
end
for i,v in pairs(mascc:GetDescendants()) do
	if v:IsA("BasePart") then v.Transparency = 1 end
end
table.insert(getgenv().FrostwareConfig.TableOfEvents, Character.ChildAdded:Connect(function(e)
	if e.Name == "Gun" then
		for i,v in pairs(gun:GetDescendants()) do
			if v:IsA("BasePart") then v.Transparency = 1 end
		end
		DestroyThingies(Character[Hat1].Handle)
		ReanimateAPI.Align(Character[Hat1].Handle, gun.Handle,Vector3.new(1.2,0.1,0),Vector3.new(-40,90,0))
	elseif e.Name == "FakeGun" then
		for i,v in pairs(fgun:GetDescendants()) do
			if v:IsA("BasePart") then v.Transparency = 1 end
		end
		DestroyThingies(Character[Hat1].Handle)
		ReanimateAPI.Align(Character[Hat1].Handle, fgun.Handle,Vector3.new(1,0.5,0),Vector3.new(-50,90,0))
	elseif e.Name == "FShot" then
		for i,v in pairs(fshot:GetDescendants()) do
			if v:IsA("BasePart") then v.Transparency = 1 end
		end
		DestroyThingies(Character[Hat2].Handle)
		ReanimateAPI.Align(Character[Hat2].Handle, fshot.Handle,Vector3.new(1,1,0),Vector3.new(0,180,215))
	elseif e.Name == "BShot" then
		for i,v in pairs(shotgun:GetDescendants()) do
			if v:IsA("BasePart") then v.Transparency = 1 end
		end
		DestroyThingies(Character[Hat2].Handle)
		ReanimateAPI.Align(Character[Hat2].Handle, shotgun.Handle,Vector3.new(1,1.3,0),Vector3.new(0,180,-150))
	end
end))



--dmg

local function poop(MODEL)

end

local function ApplyDamage(Humanoid,Damage)
	Damage = Damage * DAMAGEMULTIPLIER
	local Thing = Humanoid.Parent -- TODO THIS LINE
end

local function ApplyAoE(POSITION,RANGE,MINDMG,MAXDMG,FLING,INSTAKILL)
	for index, CHILD in pairs(workspace:GetDescendants()) do
		if CHILD.ClassName == "Model" and CHILD ~= Character then
			local HUM = CHILD:FindFirstChildOfClass("Humanoid")
			if HUM then
				local TORSO = CHILD:FindFirstChild("Torso") or CHILD:FindFirstChild("UpperTorso")
				if TORSO then
					if (TORSO.Position - POSITION).Magnitude <= RANGE then
						if INSTAKILL == true then
							poop(CHILD)
						else
							local DMG = MRANDOM(MINDMG,MAXDMG)
							ApplyDamage(HUM,DMG)
						end
						if FLING > 0 then
							for _, c in pairs(CHILD:GetChildren()) do
								if c:IsA("BasePart") then
									local bv = Instance.new("BodyVelocity") 
									bv.maxForce = Vector3.new(1e9, 1e9, 1e9)
									bv.velocity = CF(POSITION,TORSO.Position).lookVector*FLING
									bv.Parent = c
									Debris:AddItem(bv,0.05)
								end
							end
						end
					end
				end
			end
		end
	end
end

--attacks

local function cs()
if SONG == 590141342 then
SONG = 212377035
elseif SONG == 212377035 then
SONG = 589973177
elseif SONG == 589973177 then
SONG = 1833183591
elseif SONG == 1833183591 then
SONG = 2982966292
elseif SONG == 2982966292 then
SONG = 	616388964
elseif SONG == 616388964 then
SONG = 	1342763538
elseif SONG == 1342763538 then
SONG = 886085413
elseif SONG == 886085413 then
SONG = 3704092097
elseif SONG == 3704092097 then
SONG = 1589396874
elseif SONG == 1589396874 then
SONG = 168159280
elseif SONG == 168159280 then
SONG = 296659202
elseif SONG == 296659202 then
SONG = 608671887
elseif SONG == 608671887 then
SONG = 270719635
elseif SONG == 270719635 then
SONG = 3206925146
elseif SONG == 3206925146 then
SONG = 383141805
elseif SONG == 383141805 then
SONG = 590141342			
end
end

local function swshotg()
ATTACK = true
if shotgunact == false then
for i = 0,20 do
local Alpha = .1
Swait()
actualshot = true
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-12.2),RAD(-73.3 ),RAD(-4.7)),.1);end
RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.5,0.8,0.6)*ANGLES(RAD(57.3),RAD(56.6),RAD(-61.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-104.3- 4 * SIN(SINE/35)),RAD(5.3),RAD(124.5)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
end	
actualshot = false
shotgunact = true
else
for i = 0,20 do
local Alpha = .1
Swait()
actualshot = true
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-12.2),RAD(-73.3 ),RAD(-4.7)),.1);end
RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.5,0.8,0.6)*ANGLES(RAD(57.3),RAD(56.6),RAD(-61.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-104.3- 4 * SIN(SINE/35)),RAD(5.3),RAD(124.5)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
end	
actualshot = false
shotgunact = false
end
ATTACK = false
end

local function swgun()
ATTACK = true
if gunact == true then
for i = 0,20 do	
local Alpha = .1
Swait()
actualshot = true
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.8,-0.2)*ANGLES(RAD(-20.1),RAD(-30),RAD(44.7)),Alpha)
RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-139.4)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
end
actualshot = false
gunact = false
else
for i = 0,20 do
local Alpha = .1
Swait()
actualshot = true
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.8,-0.2)*ANGLES(RAD(-20.1),RAD(-30),RAD(44.7)),Alpha)
RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-139.4)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
end	
actualshot = false
gunact = true
end
ATTACK = false	
end

local function gunsh()
ATTACK = true
for i = 0,25 do
Swait()
local Alpha = .1
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.3,0)*ANGLES(RAD(-130.8),RAD(-85.3),RAD(151.3)),Alpha)
RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
end
	repeat
		for i=0, 0.25, 0.1 / Animation_Speed do
			Swait()
			  	local Alpha = .1
  	  	local Alpha = .1
  	  	actualshot = true
	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.1,0)*ANGLES(RAD(-130.8),RAD(-85.3),RAD(103)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
		end
		--coroutine.resume(coroutine.create(function()
		local HIT,POS = CastProperRay(hole.Position,  Mouse.Hit.p, 500, Character)
		local DISTANCE = (POS - hole.Position).Magnitude
		if HIT then	
		WACKYEFFECT2({Time = MRANDOM(90,110), EffectType = "Sphere", Size = Vector3.new(0,0,0), Size2 = Vector3.new(7,7,7), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 1,Chaos = false,UseBoomerangMath = true, SizeBoomerang = 25})	
		end
		for i = 1,2 do
		WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Round Slash", Size = Vector3.new(0.01,0.01,0.01) * MRANDOM(.5,1.5), Size2 = Vector3.new(0,0,0), Transparency = 0.3, Transparency2 = 1, CFrame = hole.CFrame * ANGLES(RAD(MRANDOM(0,360)), RAD(0), RAD(MRANDOM(60,120))) * CF(0,0,0), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Glass", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = MRANDOM(7,8)/10, SoundVolume = 8,UseBoomerangMath = true, SizeBoomerang = 15})
		end
		WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Sphere", Size = Vector3.new(0,0,0), Size2 = Vector3.new(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = CF(hole.Position), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 1,Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
		WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Box", Size = Vector3.new(0,0,DISTANCE), Size2 = Vector3.new(.6,.6,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CF(hole.Position,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Color3.new(1,0,0), SoundID = 419268760, SoundPitch = MRANDOM(9,11)/10, SoundVolume = 8, Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
		--Lightning({Material = "Neon", FadeIn = false, Color = C3(1,0,0), Start = hole.Position, End = POS, SegmentL = 2, Thickness = .5, DoesFade = true, Ignore = Character, MaxDist = 5, Branches = true, FadeTime = 150, Thicken = false})
		for i=0, 0.2, 0.1 / Animation_Speed do
		Swait()
		  local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-130.8),RAD(-85.3),RAD(160)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)
	end
	
	if shotgunact == true then break end
	until HOLD ==  false
ATTACK = false	
actualshot = true
end
		
local function shotgunsh()
ATTACK = true
CreateSound(1498950813,RightArm,5,0.8,false)
for i = 0,26 do
Swait()
actualshot = true
local Alpha = .1
sgw.C1 = sgw.C1:lerp(CF(0,-1,.3)*ANGLES(RAD(90),RAD(0),RAD(0)),.1)
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-12.2),RAD(-73.3 ),RAD(-4.7)),.1);end
RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.9,0.4,-0.2)*ANGLES(RAD(-169.7),RAD(83.4),RAD(-105.4)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
end
actualshot = false
CreateSound(1835530642,RightArm,7,.7,false)
for i = 1,6 do
local p1 = CF(hole2.Position,Mouse.Hit.p)*CF(0,0,-45).p
local ap = CF(hole2.Position,p1) * CF(0,0,-45) * ANGLES(RAD(MRANDOM(0,360)), RAD(MRANDOM(0,360)), RAD(MRANDOM(0,360)))*CF(0,0,MRANDOM(5,75)/10).p
local HIT,POS = CastProperRay(hole2.Position,ap,1000,Character)
local DISTANCE = (POS - hole2.Position).Magnitude
if HIT then	
WACKYEFFECT2({Time = MRANDOM(90,110), EffectType = "Sphere", Size = Vector3.new(0,0,0), Size2 = Vector3.new(7,7,7), Transparency = 0, Transparency2 = 1, CFrame = CF(POS), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 1,Chaos = false,UseBoomerangMath = true, SizeBoomerang = 25})		
end
for i = 1,2 do
WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Round Slash", Size = Vector3.new(0.01,0.01,0.01) * MRANDOM(.5,1.5), Size2 = Vector3.new(0,0,0), Transparency = 0.3, Transparency2 = 1, CFrame = hole2.CFrame * ANGLES(RAD(MRANDOM(0,360)), RAD(0), RAD(MRANDOM(60,120))) * CF(0,0,0), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Glass", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = MRANDOM(7,8)/10, SoundVolume = 8,UseBoomerangMath = true, SizeBoomerang = 15})
end
WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Sphere", Size = Vector3.new(0,0,0), Size2 = Vector3.new(1,1,1), Transparency = 0, Transparency2 = 1, CFrame = CF(hole2.Position), MoveToPos = nil, RotationX = nil, RotationY = nil, RotationZ = nil, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 1,Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
WACKYEFFECT2({Time = MRANDOM(60,70), EffectType = "Box", Size = Vector3.new(0,0,DISTANCE), Size2 = Vector3.new(.6,.6,DISTANCE), Transparency = 0, Transparency2 = 1, CFrame = CF(hole2.Position,POS)*CF(0,0,-DISTANCE/2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = Color3.new(1,0,0), SoundID = nil, SoundPitch = MRANDOM(9,11)/10, SoundVolume = 8, Chaos = false,UseBoomerangMath = true, SizeBoomerang = 15})
end
for i = 0,35 do
local Alpha = .2
Swait()
sgw.C1 = sgw.C1:lerp(CF(0,-1,.3)*ANGLES(RAD(90),RAD(0),RAD(0)),.1)
RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-12.2),RAD(-73.3 ),RAD(-4.7)),.1);end
RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.1,0.3,-0.1)*ANGLES(RAD(-169.7),RAD(83.4),RAD(-55.3)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
end
ATTACK = false	
end

local function magic1()
ATTACK = true
local a = false
for i = 0,35 do
Swait()
local Alpha = .1
RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,1.2+ 0.5 * COS(SINE/35),0)*ANGLES(RAD(-83.2+ 7 * SIN(SINE/35)),RAD(8.3),RAD(-129.6)),Alpha)
LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0)*ANGLES(RAD(-8.3),RAD(-74.4),RAD(-175.8)),Alpha)
RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
Neck.C0 =Neck.C0:lerp(CF(-0.2,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(129.1)),Alpha)
LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
end
local sp = CreatePart(3,Effects,"Neon",0,0,"Really red","magic lol",VT(7.5,7.5,7.5),true)
MakeForm(sp,"Ball")
sp.CFrame = LeftArm.CFrame * CF(0,-3,0)
WACKYEFFECT2({Time = 90, EffectType = "Sphere", Size = VT(.2,.2,.2)*sp.Size.Magnitude, Size2 = VT(15,15,15), Transparency = 0.6, Transparency2 = 1, CFrame = CF(sp.Position) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 203691785, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
coroutine.resume(coroutine.create(function()
repeat
Swait()

until a == true
end))
--swait(.5)
coroutine.resume(coroutine.create(function()	
sp.CFrame = CF(sp.Position,Mouse.Hit.p)
for i = 1,250 do
Swait()
sp.CFrame = sp.CFrame * CF(0,0,-2)
local hit,pos = Raycast(sp.Position,sp.CFrame.lookVector,5,Character)
if hit then break end	
end
ApplyAoE(sp.Position,12,0,0,0,true)
for i = 1,2 do
WACKYEFFECT2({Time = MRANDOM(80,90), EffectType = "Sphere", Size = VT(1,10,1), Size2 = VT(5.5,55,5.5), Transparency = 0, Transparency2 = 1, CFrame = CF(sp.Position) * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})	
end
WACKYEFFECT2({Time = 60, EffectType = "Sphere", Size = VT(.2,.2,.2)*sp.Size.Magnitude, Size2 = VT(5,5,5)*sp.Size.Magnitude, Transparency = 0.6, Transparency2 = 1, CFrame = CF(sp.Position) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 231917970, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
sp:Destroy()
a = true 
end))
for i = 0,20 do
Swait()
  	local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0.1,1.2+ 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-82.1+ 7 * SIN(SINE/35)),RAD(-7.2),RAD(137.8)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.5,0.6,-0.9)*ANGLES(RAD(97.5),RAD(-35.9),RAD(60.9)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(2.7)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0.1,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-137.3)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
end
ATTACK = false
end

local function magic2()
ATTACK = true
local first = false
local stuck = false
coroutine.resume(coroutine.create(function()
repeat
	Swait()
  	local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1.3,-0.2,0.3)*ANGLES(RAD(-101.3),RAD(-1.8),RAD(-84.9)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.4,-0.2,0.2)*ANGLES(RAD(-97.5),RAD(-1.2),RAD(92.2)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
until	 first == true
end))
local sp1 = CreatePart(3,nil,"Neon",0,0,"Really red","magic lol",VT(2.89, 2.89, 2.89),true)
MakeForm(sp1,"Ball")
local sp2 = CreatePart(3,nil,"Neon",0,0,"Really red","magic lol",VT(2.89, 2.89, 2.89),true)
MakeForm(sp2,"Ball")
sp1.CFrame = LeftArm.CFrame * CF(0,-1,0)
sp2.CFrame = RightArm.CFrame * CF(0,-1,0)
WACKYEFFECT2({Time = 90, EffectType = "Sphere", Size = VT(.2,.2,.2)*sp1.Size.Magnitude, Size2 = VT(10,10,10), Transparency = 0.6, Transparency2 = 1, CFrame = CF(sp1.Position) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 203691785, SoundPitch = 1, SoundVolume = 10, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
WACKYEFFECT2({Time = 90, EffectType = "Sphere", Size = VT(.2,.2,.2)*sp2.Size.Magnitude, Size2 = VT(10,10,10), Transparency = 0.6, Transparency2 = 1, CFrame = CF(sp2.Position) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
swait(.3)
coroutine.resume(coroutine.create(function()
repeat
Swait()
pcall(function()
sp1.Parent = Effects
sp2.Parent = Effects
end)
sp1.CFrame = LeftArm.CFrame * CF(0,-1,0)
sp2.CFrame = RightArm.CFrame * CF(0,-1,0)
until stuck == true
end))
first = true
for i = 0,20 do
Swait()
  	local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.3)*ANGLES(RAD(-64.9+ 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1.3,-0.2,0.3)*ANGLES(RAD(-101.3),RAD(-1.8),RAD(-68.5)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.4,-0.2,0.3)*ANGLES(RAD(-97.5),RAD(-1.2),RAD(71.5)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1.1,-0.1)*ANGLES(RAD(-24.6),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,-0.2,-0.8)*ANGLES(RAD(-22.1),RAD(84.7),RAD(0)),Alpha)	
end
for i = 1,2 do
WACKYEFFECT2({Time = MRANDOM(80,90), EffectType = "Sphere", Size = VT(1,10,1), Size2 = VT(1.5,15,1.5), Transparency = 0, Transparency2 = 1, CFrame = CF(RootPart.Position) * CF(0,0,-2) * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})		
end
WACKYEFFECT2({Time = 120, EffectType = "Sphere", Size = VT(.2,.2,.2)*Torso.Size.Magnitude, Size2 = VT(12,12,12), Transparency = 0.6, Transparency2 = 1, CFrame = CF(RootPart.Position) * CF(0,0,-2), MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 231917970, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})
ApplyAoE(sp1.Position,14,0,0,0,true)
sp1:Destroy()
sp2:Destroy()
stuck = true
for i = 0,26 do
Swait()
  	local Alpha = .2
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.1 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-84.9+ 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1.4,-0.3,-0.3)*ANGLES(RAD(-101.3),RAD(-1.8),RAD(117.1)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.5,-0.2,-0.2)*ANGLES(RAD(-97.5),RAD(-1.2),RAD(-120.2)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7- 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-0.9,-0.3)*ANGLES(RAD(-4.5),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,0.2,-0.6)*ANGLES(RAD(-2),RAD(84.7),RAD(0)),Alpha)	
end
ATTACK = false	
end	

local function magic3()
ATTACK = true
local b = false
for i = 0,20 do
	Swait()
  	local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,1.2 + 0.5 * COS(SINE/35),0)*ANGLES(RAD(-82.9+ 7 * SIN(SINE/35)),RAD(8),RAD(-131.9)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.5,0)*ANGLES(RAD(-3.9),RAD(-78.7),RAD(3.4)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(0.9,0.8,0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(170.3)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(-0.2,1,0.1)*ANGLES(RAD(-100.7),RAD(0),RAD(131.4)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7),RAD(84.7),RAD(0)),Alpha)	
end
local sph = CreatePart(3,Effects,"Neon",0,0,"Really red","magic lol",VT(2.31, 2.31, 2.31)*2,true)
MakeForm(sph,"Ball")
sph.CFrame = RightArm.CFrame * CF(0,-3,0)
WACKYEFFECT2({Time = 90, EffectType = "Sphere", Size = VT(.2,.2,.2)*sph.Size.Magnitude, Size2 = VT(5,5,5)*2, Transparency = 0.6, Transparency2 = 1, CFrame = CF(sph.Position) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 203691785, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
coroutine.resume(coroutine.create(function()
repeat
Swait()
sph.CFrame = RightArm.CFrame * CF(0,-3,0)
WACKYEFFECT2({Time = 30, EffectType = "Ring", Size = Vector3.new(.5,.5,.5), Size2 = Vector3.new(.5,.5,.5), Transparency = 0.3, Transparency2 = 1, CFrame = sph.CFrame * ANGLES(RAD(90), RAD(0), RAD(0)) * CF(0,0,0), MoveToPos = nil, RotationX = MRANDOM(-60, 60), RotationY = MRANDOM(-50, 50), RotationZ = MRANDOM(-60, 60), Material = "Neon", Color = Color3.fromRGB(255, 0, 0), SoundID = nil, SoundPitch = 1, SoundVolume = 5, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 80})
until b == true
end))
for i = 0,20 do
	Swait()
  	local Alpha = .1
  	RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,1.2 + 0.5 * COS(SINE/35),0.2)*ANGLES(RAD(-67.2+ 7 * SIN(SINE/35)),RAD(8),RAD(-131.9)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.5,0)*ANGLES(RAD(-3.9),RAD(-78.7),RAD(3.4)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.8,-0.2)*ANGLES(RAD(-8.7),RAD(71.8),RAD(-167.5)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(-0.2,1,0.1)*ANGLES(RAD(-100.7),RAD(0),RAD(131.4)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1.1,-0.9,-0.1)*ANGLES(RAD(-88.8),RAD(-77.4),RAD(-68.6)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1.1,-0.4,-0.6)*ANGLES(RAD(49.1),RAD(77.3),RAD(-67.7)),Alpha)	
end
for i = 1,2 do
WACKYEFFECT2({Time = MRANDOM(40,50), EffectType = "Sphere", Size = VT(1,10,1), Size2 = VT(1.5,15,1.5), Transparency = 0, Transparency2 = 1, CFrame = RootPart.CFrame * CF(1,-3,0) * ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360))) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = true, Boomerang = 0, SizeBoomerang = 35})		
end
WACKYEFFECT2({Time = 40, EffectType = "Sphere", Size = VT(.2,.01,.2)*sph.Size.Magnitude, Size2 = VT(3.5,0.1,3.5)*sph.Size.Magnitude, Transparency = 0.6, Transparency2 = 1, CFrame = RootPart.CFrame * CF(1,-3,0) * ANGLES(RAD(0),RAD(0),RAD(0)) --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 231917970, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
sph:Destroy()
b = true
local hf,hp = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 3.7, Character)
if hf then
coroutine.resume(coroutine.create(function()
for i = 0,6 do
local po = RootPart.CFrame*CF(0,0,-i*22)
local hf2,hp2 = Raycast(po.p+VT(0,1,0), (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 3.7, Character)
if hf then
local ab = CF(hp2) * ANGLES(RAD(0), RAD(MRANDOM(0,360)), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0))
WACKYEFFECT2({Time = 120, EffectType = "Sphere", Size = VT(5,10,5), Size2 = VT(30,50,30), Transparency = 0.6, Transparency2 = 1, CFrame = ab --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(1,0,0), SoundID = 231917970, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
WACKYEFFECT2({Time = 120, EffectType = "Sphere", Size = VT(5,10,5), Size2 = VT(15,35,15), Transparency = 0.6, Transparency2 = 1, CFrame = ab --[[* CF(2,-15.3,-3)]], MoveToPos = nil, RotationX = 0, RotationY = 0, RotationZ = 0, Material = "Neon", Color = C3(.7,0,0), SoundID = nil, SoundPitch = 1, SoundVolume = 8, UseBoomerangMath = false, Boomerang = 0, SizeBoomerang = 35})
WACKYEFFECT2({Time = 50, EffectType = "Wave", Size = VT(5,5,5), Size2 = VT(20.5,2,20.5), Transparency = 0.25, Transparency2 = 1, CFrame = ab, MoveToPos = nil, RotationX = 0, RotationY = 15, RotationZ = 0, Material = "Neon", Color = BRICKC"Really red".Color, SoundID = nil, SoundPitch = MRANDOM(9,11)/12, SoundVolume = 2})
ApplyAoE(ab.p,15,0,0,0,true)
swait(.1)
end
end		
end))
end
for i = 0,26 do
Swait()
  	local Alpha = .2
  	RootJoint.C0 = RootJoint.C0:lerp(CF(-0.1,-1.2,0.3)*ANGLES(RAD(-108.9),RAD(8),RAD(-131.9)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-0.9,0.1,0.2)*ANGLES(RAD(-84.3),RAD(-48.5),RAD(-59.8)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1.2,0.1,-0.1)*ANGLES(RAD(-144.2),RAD(53.2),RAD(165.1)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(-0.1,1,0.1)*ANGLES(RAD(-100.7),RAD(0),RAD(144.5)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,0.1,-0.6)*ANGLES(RAD(-10.2),RAD(-86.3),RAD(-9.5)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,-1,-0.9)*ANGLES(RAD(-7.7),RAD(84.7),RAD(-85.1)),Alpha)	
end
ATTACK = false	
end

local function tuant()
ATTACK = true
CreateSound(3724749130,Head,8,1,false)
for i = 0,75 do
Swait()
  	local Alpha = .4
  	RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.07 * COS(SINE/5) + 0.5 * COS(SINE/35),0.3)*ANGLES(RAD(-59.8),RAD(0),RAD(-180)),Alpha)
  	LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.4 + 0.1 * SIN(SINE/5),0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(33.8)),Alpha)
  	RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5+ 0.1 * SIN(SINE/5),0)*ANGLES(RAD(-11.3),RAD(74.8),RAD(-20.1)),Alpha)
  	Neck.C0 =Neck.C0:lerp(CF(0,1,-0.1)*ANGLES(RAD(-81),RAD(0),RAD(-180)),Alpha)
  	LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1.2,0.1)*ANGLES(RAD(-29.6),RAD(-86.3),RAD(0)),Alpha)
  	RightHip.C0 = RightHip.C0:lerp(CF(1,-0.4,-0.7)*ANGLES(RAD(-27.1),RAD(84.7),RAD(0)),Alpha)
end
ATTACK = false	
end


--keys
local function MouseDown(Mouse)
	HOLD = true
	if ATTACK == false then
	if shotgunact == true and gunact == true then
	if COMBO == 1 then
	gunsh()
	COMBO = 2
	elseif COMBO == 2 then
	shotgunsh()
	COMBO = 1		
	end
	elseif shotgunact == true and gunact == false then
	shotgunsh()
	elseif shotgunact == false and gunact == true then
	gunsh()		
	end
	end
end

local function MouseUp(Mouse)
HOLD = false
end

local function KeyDown(Key)
	KEYHOLD = true
	if Key == "q" and ATTACK == false then
		swshotg()
	end
	
	if Key == "e" and ATTACK == false then
		swgun()
	end

	if Key == "z" and ATTACK == false and shotgunact == false and gunact == false then
	magic1()	
	end
	
	if Key == "x" and ATTACK == false and shotgunact == false and gunact == false then
	magic2()	
	end
	
	if Key == "c" and ATTACK == false and shotgunact == false and gunact == false then
		magic3()	
	end
	
	if Key == "t" and ATTACK == false then
		tuant()
	end
	
	if Key == "m" then
		cs()
	end

	if Key == "]" and ATTACK == false then
		if sick.Parent ~= Character then
			sick = IT("Sound",Torso)
			sick.SoundId = "rbxassetid://"..SONG
		end
	end
end

local function KeyUp(Key)
	KEYHOLD = false
end

	table.insert(getgenv().FrostwareConfig.TableOfEvents,Mouse.Button1Down:connect(function(NEWKEY)
		MouseDown(NEWKEY)
	end))
	table.insert(getgenv().FrostwareConfig.TableOfEvents,Mouse.Button1Up:connect(function(NEWKEY)
		MouseUp(NEWKEY)
	end))
	table.insert(getgenv().FrostwareConfig.TableOfEvents,Mouse.KeyDown:connect(function(NEWKEY)
		KeyDown(NEWKEY)
	end))
	table.insert(getgenv().FrostwareConfig.TableOfEvents,Mouse.KeyUp:connect(function(NEWKEY)
		KeyUp(NEWKEY)
	end))

local function unanchor()
	for _, c in pairs(Character:GetChildren()) do
		if c:IsA("BasePart") and c ~= RootPart then
			c.Anchored = false
		end
	end
	if UNANCHOR == true then
		RootPart.Anchored = false
	else
		RootPart.Anchored = true
	end
end

--if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(0.2),RAD(-84.8),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6,0.1)*ANGLES(RAD(-12.2),RAD(-73.3 ),RAD(-4.7)),.1);end

if getgenv().FrostwareConfig.DisableAudio == false then
	ReanimateAPI.LoadMusicFromFiles(sick,"FrostwareSongs/Carnage.mp3")
end
sick.Looped = true
--loop stuff

table.insert(getgenv().FrostwareConfig.TableOfEvents,Humanoid.Changed:connect(function(Jump)
	if Jump == "Jump" and (Disable_Jump == true) then
		Humanoid.Jump = false
	end
end))

while true do
    if getgenv().FrostwareConfig.ScriptStopped == true then
    	WEAPONGUI:Destroy()
        break
    end
	for i,v in pairs(Humanoid:GetPlayingAnimationTracks()) do
		v:Stop()
	end
	Swait()
	script.Parent = WEAPONGUI
	for _,v in next, Humanoid:GetPlayingAnimationTracks() do
	    v:Stop();
	end
	SINE = SINE + CHANGE*2
	local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
	local TORSOVERTICALVELOCITY = RootPart.Velocity.y
	local HITFLOOR,HITPOS,NORMAL = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4+Humanoid.HipHeight, Character)
	local WALKSPEEDVALUE = 12 / (Humanoid.WalkSpeed / 16)
	if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
		ANIM = "Jump"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(-5), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(-25), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(25 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-35), RAD(0), RAD(-25 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.4, -0.6) * ANGLES(RAD(1), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-85), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
		ANIM = "Fall"
		if ATTACK == false then
			RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 ) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0 , 0 + ((1) - 1)) * ANGLES(RAD(15), RAD(0), RAD(0)), 1 / Animation_Speed)
			RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(45 + 10 * COS(SINE / 12))) * RIGHTSHOULDERC0, 1 / Animation_Speed)
			LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(35 - 4 * COS(SINE / 6)), RAD(0), RAD(-45 - 10 * COS(SINE / 12))) * LEFTSHOULDERC0, 1 / Animation_Speed)
			RightHip.C0 = Clerp(RightHip.C0, CF(1, -0.3, -0.7) * ANGLES(RAD(-25 + 5 * SIN(SINE / 12)), RAD(90), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
			LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -0.8, -0.3) * ANGLES(RAD(-10), RAD(-80), RAD(0)) * ANGLES(RAD(-1 * SIN(SINE / 6)), RAD(0), RAD(0)), 1 / Animation_Speed)
		end
	elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
		ANIM = "Idle"
		if ATTACK == false then
		local Alpha = .1
  		RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-79.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  		if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6 + 0.07 * SIN(SINE/35),0.1)*ANGLES(RAD(0.2 + 5 * COS(SINE/35)),RAD(-84.8 + 2 * SIN(SINE/35)),RAD(-167.4)),Alpha);else LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6 + 0.07 * SIN(SINE/35),0.1)*ANGLES(RAD(-12.2 + 5 * COS(SINE/35)),RAD(-73.3 + 2 * SIN(SINE/35)),RAD(-4.7)),.1);end
  		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5 + 0.07 * SIN(SINE/35),0)*ANGLES(RAD(-11.3 + 5 * COS(SINE/35)),RAD(74.8 - 2 * SIN(SINE/35)),RAD(2.7)),Alpha)
  		Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-100.7 - 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2 - 4 * COS(SINE/35)),RAD(-86.3),RAD(0)),Alpha)
  		RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7 - 4 * COS(SINE/35)),RAD(84.7),RAD(0)),Alpha)
		end
	elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
		ANIM = "Walk"
		if ATTACK == false then
		local Alpha = .1
  		RootJoint.C0 = RootJoint.C0:lerp(CF(0,1.2 + 0.5 * COS(SINE/35),0.1)*ANGLES(RAD(-149.3 + 7 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  		if gunact == true then LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6 + 0.07 * SIN(SINE/35),0.1)*ANGLES(RAD(0.2 + 5 * COS(SINE/35)),RAD(-84.8 + 2 * SIN(SINE/35)),RAD(-167.4)),Alpha)
		else
		LeftShoulder.C0 = LeftShoulder.C0:lerp(CF(-1,0.6 + 0.07 * SIN(SINE/35),0.1)*ANGLES(RAD(-12.2 + 5 * COS(SINE/35)),RAD(-73.3 + 2 * SIN(SINE/35)),RAD(-4.7)),.1)
		end
  		RightShoulder.C0 = RightShoulder.C0:lerp(CF(1,0.5 + 0.07 * SIN(SINE/35),0)*ANGLES(RAD(-11.3 + 5 * COS(SINE/35)),RAD(74.8 - 2 * SIN(SINE/35)),RAD(2.7)),Alpha)
  		Neck.C0 =Neck.C0:lerp(CF(0,1,0.1)*ANGLES(RAD(-30.7 - 4 * SIN(SINE/35)),RAD(0),RAD(-180)),Alpha)
  		LeftHip.C0 = LeftHip.C0:lerp(CF(-1,-1,-0.1)*ANGLES(RAD(-10.2 - 4 * COS(SINE/35)),RAD(-86.3),RAD(0)),Alpha)
  		RightHip.C0 = RightHip.C0:lerp(CF(1,0,-0.6)*ANGLES(RAD(-7.7 - 4 * COS(SINE/35)),RAD(84.7),RAD(0)),Alpha)
		end
	end
	if shotgunact == false then
	shotgun.Parent = nil
	fshot.Parent = Character
	else
	shotgun.Parent = Character
	fshot.Parent = nil
	end
	
	if gunact == false then
	gun.Parent = nil
	fgun.Parent = Character
	else
	gun.Parent = Character
	fgun.Parent = nil	
	end
	if ATTACK == false then
	sgw.C1 = sgw.C1:lerp(CF(0,0,0),.1)
	gunw.C1 = gunw.C1:lerp(CF(0,0,0),.1)
	end
	
	local CFRAME2 = CF(RootPart.Position) * ANGLES(RAD(MRANDOM(0,360)), RAD(MRANDOM(0,360)), RAD(0)) * CF(0, MRANDOM(2,6), MRANDOM(6,10))
	local POSITION = CF(HITPOS)*ANGLES(RAD(0),RAD(MRANDOM(0,360)),RAD(0))*CF(MRANDOM(3,6),-.6,0).p
	local SPHEREFLOOR,SPHEREPOS = Raycast(POSITION+VT(0,1,0), (CF(POSITION, POSITION + VT(0, -5, 0))).lookVector, 25, Character)


	
	unanchor()
	Humanoid.MaxHealth = 1e4
	Humanoid.Health = 1e4
	if Rooted == false then
		Disable_Jump = false
		Humanoid.WalkSpeed = Speed
	elseif Rooted == true then
		Disable_Jump = true
		Humanoid.WalkSpeed = 0
	end
	if SONG == 383141805 then
	sick.Pitch = .88
	else
	sick.Pitch = 1
	end
	sick.Volume = 3
	sick.Playing = true
end

--//=================================\\
--\\=================================//





--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--
