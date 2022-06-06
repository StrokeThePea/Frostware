if not getgenv().EventTables then
    getgenv().EventTables = {}
end 
if not getgenv().ScriptStop then
    getgenv().ScriptStop = false
end 
if not getgenv().AnimationRunning then
    getgenv().AnimationRunning = false
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
function ReanimateAPI.Align(Part0,Part1,Position,Orientation)
    local AlignPosition = Instance.new("AlignPosition")
    AlignPosition.Parent = Part0
    AlignPosition.MaxForce = math.huge
    AlignPosition.Responsiveness = 200
    AlignPosition.Name = "FrostWareAP1"

    local AlignOrientation = Instance.new("AlignOrientation")
    AlignOrientation.Parent = Part0
    AlignOrientation.MaxTorque = 13e9
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

function ReanimateAPI.SimpleReanimate()
    if workspace:FindFirstChild("Raw") then
        ReanimateAPI.Notification("Already Reanimated! Reset to stop.")
        ReanimateAPI.PlaySound(9074670249)
        return
    end
      
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if not ReplicatedStorage:FindFirstChild("FrostwareData") then
        local Folder = Instance.new("Folder")
        Folder.Name = "FrostwareData"
        Folder.Parent = ReplicatedStorage
        local Clone = game:GetObjects("rbxassetid://8440552086")[1]
        Clone.Name = "R6FakeRig"
        Clone.Parent = Folder
        task.wait(0.55)
    end
    
    local Libraries = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/OpenSourceStuff/API.lua"))()
    local Data = ReplicatedStorage:FindFirstChild("FrostwareData")
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player["Character"]
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    Humanoid.BreakJointsOnDeath = false
    Character.Archivable = true
    local Camera = workspace:FindFirstChildWhichIsA("Camera")
    local HiddenProps = sethiddenproperty or set_hidden_property or sethiddenprop or function() end
    local Events, IsDead, Rig = {}, false, nil
    local FakeHats = Instance.new("Folder")
    FakeHats.Parent = Character
    FakeHats.Name = "FakeHats"
    if Humanoid.RigType == Enum.HumanoidRigType.R15 then
        Rig = "R15"
        for Index,Value in pairs(Humanoid:GetChildren()) do
            if Value:IsA("NumberValue") then 
                Value:Destroy()
            end
        end
        task.wait(0.05)
    elseif Humanoid.RigType == Enum.HumanoidRigType.R6 then
        Rig = "R6"
    end
    -- Allowed to use (I asked for permission) Original Creator: Mizt
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
    HatsNameTable = nil
    Libraries.Properties()
    local Clone = Data.R6FakeRig:Clone()
    Clone.Parent = workspace
    Clone.Name = "Raw"
    Clone.HumanoidRootPart.CFrame = Character.Head.CFrame
    for Index, Object in pairs(Character:GetDescendants()) do
        if Object:IsA("Accessory") then
            local FakeHat = Object:Clone()
            FakeHat.Parent = FakeHats
            FakeHat.Handle.Transparency = 1
            Libraries.ReCreateAccessoryWelds(Clone, FakeHat)
    
            local FakeHat2 = FakeHat:Clone()
            FakeHat2.Parent = Clone
            Libraries.ReCreateAccessoryWelds(Clone, FakeHat2)
        end
    end
    for Index, Object in pairs(Clone:GetDescendants()) do
        if Object:IsA("BasePart") or Object:IsA("Decal") then
            Object.Transparency = 1
        end
    end
    Character.Parent = Clone
    if Rig == "R6" then
        Character.HumanoidRootPart:Destroy()
    else
        Character.HumanoidRootPart.Transparency = 1
    end
    Humanoid:ChangeState(16)
    Character.Animate.Disabled = true
    
    local CharDescendants,CharChildren = Character:GetDescendants(),Character:GetChildren()
    local ClnDescendants = Clone:GetDescendants()
    local ClnHumanoid = Clone:FindFirstChildWhichIsA("Humanoid")
    local HumanoidTracks = Humanoid:GetPlayingAnimationTracks()
    table.insert(
        Events,
        game:GetService("RunService").Stepped:Connect(
            function()
                for Index, Part in pairs(CharDescendants) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                        Part.RootPriority = 127
                    end
                end
                for Index, Track in pairs(HumanoidTracks) do
                    Track:Stop()
                end
                for Index, Part in pairs(ClnDescendants) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                    end
                end
                ClnHumanoid:Move(Humanoid.MoveDirection, false)
            end
        )
    )
    for Index, Object in pairs(CharDescendants) do
        if Object:IsA("Motor6D") and Object.Name ~= "Neck" then
            Object:Destroy()
        end
    end
    for Index, Accessory in pairs(Character:GetChildren()) do
        if Accessory:IsA("Accessory") then
            Accessory.Handle:BreakJoints()
        end
    end
    
    coroutine.wrap(
        function()
            while task.wait() do
                if IsDead then
                    break
                end
                for Index, Part in pairs(CharChildren) do
                    if Part:IsA("BasePart") then
                        if (Part and Part.Parent) then
                            HiddenProps(Part, "NetworkIsSleeping", false)
                            Part.Velocity = Vector3.new(30,0,0) + Clone["HumanoidRootPart"].CFrame.LookVector * 4
                        end
                    elseif Part:IsA("Accessory") then
                        if (Part and Part.Parent) then
                        HiddenProps(Part.Handle, "NetworkIsSleeping", false)
                        Part.Handle.Velocity = Vector3.new(30,0,0) + Clone["HumanoidRootPart"].CFrame.LookVector * 4
                        end
                    end
                end
            end
        end
    )()
    if Rig == "R6" then
        ReanimateAPI.Align(Character:FindFirstChild("Torso"), Clone:FindFirstChild("Torso"))
        ReanimateAPI.Align(Character:FindFirstChild("Right Arm"), Clone:FindFirstChild("Right Arm"))
        ReanimateAPI.Align(Character:FindFirstChild("Left Arm"), Clone:FindFirstChild("Left Arm"))
        ReanimateAPI.Align(Character:FindFirstChild("Right Leg"), Clone:FindFirstChild("Right Leg"))
        ReanimateAPI.Align(Character:FindFirstChild("Left Leg"), Clone:FindFirstChild("Left Leg"))
    elseif Rig == "R15" then
        ReanimateAPI.Align(Character:FindFirstChild("HumanoidRootPart"),Character:FindFirstChild("UpperTorso"),Vector3.new(0,0.09,0))
        ReanimateAPI.Align(Character:FindFirstChild("UpperTorso"),Clone:FindFirstChild("Torso"),Vector3.new(0,-0.19,0))
        ReanimateAPI.Align(Character:FindFirstChild("LowerTorso"),Clone:FindFirstChild("Torso"),Vector3.new(0,0.8,0))
        
        ReanimateAPI.Align(Character:FindFirstChild("RightUpperArm"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,-0.4,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightLowerArm"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,0.2-0.015,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightHand"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,0.85,0))
    
        ReanimateAPI.Align(Character:FindFirstChild("LeftUpperArm"),Clone:FindFirstChild("Left Arm"),Vector3.new(0,-0.4,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftLowerArm"),Clone:FindFirstChild("Left Arm"),Vector3.new(0,0.2-0.015,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftHand"),Clone:FindFirstChild("Left Arm"),Vector3.new(0,0.85,0))
    
        ReanimateAPI.Align(Character:FindFirstChild("RightUpperLeg"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,-0.5,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightLowerLeg"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,0.2,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightFoot"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,0.85,0))
    
        ReanimateAPI.Align(Character:FindFirstChild("LeftUpperLeg"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,-0.5,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftLowerLeg"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,0.2,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftFoot"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,0.85,0))
    end
    
    for Index,Accessory in pairs(Character:GetChildren()) do
        if Accessory:IsA("Accessory") then
            ReanimateAPI.Align(Accessory.Handle, Clone[Accessory.Name].Handle)
        end
    end
    Camera.CameraSubject = ClnHumanoid
    Player.Character = Clone
    
    table.insert(
        Events,
        Humanoid.Died:Connect(
            function()
                IsDead = true
                Character.Parent = workspace
                for Index, Loop in pairs(Events) do
                    Loop:Disconnect()
                end
                for Index, Loop in pairs(getgenv().EventTables) do
                    Loop:Disconnect()
                end
                getgenv().StopScript = true
                getgenv().ReanimationClone = nil
                getgenv().OriginalCharacter = nil
                Clone:Destroy()
                Player.Character = workspace[Player.Name]
                if workspace:FindFirstChildOfClass("Camera") then
                    workspace:FindFirstChildOfClass("Camera").CameraSubject = Humanoid
                end
                Humanoid:ChangeState(15)
                task.wait()
                getgenv().StopScript = false
            end
        )
    )
    
    table.insert(
        Events,
        Player.CharacterAdded:Connect(
            function()
                IsDead = true
                for Index, Loop in pairs(Events) do
                    Loop:Disconnect()
                end
                for Index, Loop in pairs(getgenv().EventTables) do
                    Loop:Disconnect()
                end
                getgenv().StopScript = true
                getgenv().ReanimationClone = nil
                getgenv().OriginalCharacter = nil
                Clone:Destroy()
                task.wait()
                getgenv().StopScript = false
            end
        )
    )
    
    game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
    getgenv().ReanimationClone = Clone
    getgenv().OriginalCharacter = Character
    ReanimateAPI.Notification("Reanimated With Simple Reanimate! Reset to change reanimate or stop.")
    ReanimateAPI.PlaySound(452267918)
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/StrokeThePea/CatwareReanimate/main/src/Animations.lua"))()    
end




function ReanimateAPI.BulletReanimate()
    if workspace:FindFirstChild("Raw") then
        ReanimateAPI.Notification("Already Reanimated! Reset to stop.")
        ReanimateAPI.PlaySound(9074670249)
        return
    end


    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    if not ReplicatedStorage:FindFirstChild("FrostwareData") then
        local Folder = Instance.new("Folder")
        Folder.Name = "FrostwareData"
        Folder.Parent = ReplicatedStorage
        local Clone = game:GetObjects("rbxassetid://8440552086")[1]
        Clone.Name = "R6FakeRig"
        Clone.Parent = Folder
        task.wait(0.55)
    end

    local Libraries = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/OpenSourceStuff/API.lua"))()
    local Data = ReplicatedStorage:FindFirstChild("FrostwareData")
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player["Character"]
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local BulletPart,PartReplica = Character:FindFirstChild("Left Arm") or Character:FindFirstChild("LeftUpperArm"),nil
    local BulletHighlighter = Instance.new("SelectionBox") --VTanReference
    BulletHighlighter.Parent = Character
    BulletHighlighter.Name = "BulletHighlighter"
    BulletHighlighter.Adornee = BulletPart
    BulletHighlighter.LineThickness = 0.05
    BulletHighlighter.Color3 = Color3.fromRGB(136, 3, 252)
    BulletPart.Name = "Bullet"
    Humanoid.BreakJointsOnDeath = false
    Character.Archivable = true
    local Camera = workspace:FindFirstChildWhichIsA("Camera")
    local HiddenProps = sethiddenproperty or set_hidden_property or sethiddenprop or function() end
    local Events, IsDead, Rig = {}, false, nil
    local FakeHats = Instance.new("Folder")
    FakeHats.Parent = Character
    FakeHats.Name = "FakeHats"
    if Humanoid.RigType == Enum.HumanoidRigType.R15 then
        Rig = "R15"
        for Index,Value in pairs(Humanoid:GetChildren()) do
            if Value:IsA("NumberValue") then 
                Value:Destroy()
            end
        end
        task.wait(0.05)
    elseif Humanoid.RigType == Enum.HumanoidRigType.R6 then
        Rig = "R6"
    end
    if game.GameId == 1768079756 then
        if Rig == "R6" then
            if not Character:FindFirstChild("Robloxclassicred") then
                game:GetService("Players"):Chat("-gh 48474313")
                task.wait(1)
            end
        elseif Rig == "R15" then
            if not Character:FindFirstChild("SniperShoulderL") then
                game:GetService("Players"):Chat("-gh 5973840187")
                task.wait(1)
            end
        end
    end
    -- Allowed to use (I asked for permission) Original Creator: Mizt
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
    HatsNameTable = nil
    Libraries.Properties()
    local Clone = Data.R6FakeRig:Clone()
    Clone.Parent = workspace
    Clone.Name = "Raw"
    Clone.HumanoidRootPart.CFrame = Character.Head.CFrame
    for Index, Object in pairs(Character:GetDescendants()) do
        if Object:IsA("Accessory") then
            local FakeHat = Object:Clone()
            FakeHat.Parent = FakeHats
            FakeHat.Handle.Transparency = 1
            Libraries.ReCreateAccessoryWelds(Clone, FakeHat)

            local FakeHat2 = FakeHat:Clone()
            FakeHat2.Parent = Clone
            Libraries.ReCreateAccessoryWelds(Clone, FakeHat2)
        end
    end
    for Index, Object in pairs(Clone:GetDescendants()) do
        if Object:IsA("BasePart") or Object:IsA("Decal") then
            Object.Transparency = 1
        end
    end
    Character.Parent = Clone
    if Rig == "R6" then
        Character.HumanoidRootPart:Destroy()
        PartReplica = "Robloxclassicred"
    else
        PartReplica = "SniperShoulderL"
    end
    Humanoid:ChangeState(16)
    Character.Animate.Disabled = true

    local CharDescendants,CharChildren = Character:GetDescendants(),Character:GetChildren()
    local ClnDescendants = Clone:GetDescendants()
    local ClnHumanoid = Clone:FindFirstChildWhichIsA("Humanoid")
    local HumanoidTracks = Humanoid:GetPlayingAnimationTracks()
    table.insert(
        Events,
        game:GetService("RunService").Stepped:Connect(
            function()
                for Index, Part in pairs(CharDescendants) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                        Part.RootPriority = 127
                    end
                end
                for Index, Track in pairs(HumanoidTracks) do
                    Track:Stop()
                end
                for Index, Part in pairs(ClnDescendants) do
                    if Part:IsA("BasePart") then
                        Part.CanCollide = false
                    end
                end
                ClnHumanoid:Move(Humanoid.MoveDirection, false)
            end
        )
    )
    for Index, Object in pairs(CharDescendants) do
        if Object:IsA("Motor6D") and Object.Name ~= "Neck" then
            Object:Destroy()
        end
    end
    for Index, Accessory in pairs(Character:GetChildren()) do
        if Accessory:IsA("Accessory") then
            Accessory.Handle:BreakJoints()
        end
    end
    local function CFrameAlign(Part1, Part2, OffSetPos, OffsetAngles)
        local Pos = OffSetPos or CFrame.new(0, 0, 0)
        local Angles = OffsetAngles or CFrame.new(math.rad(0), math.rad(0), math.rad(0))
        if Part1 and Part1.Parent and isnetworkowner(Part1) == true then
            pcall(function()
                Part1.CFrame = Part2.CFrame * Pos * Angles
            end)
        end
    end
    coroutine.wrap(
        function()
            while task.wait() do
                if IsDead then
                    break
                end
                for Index, Part in pairs(CharChildren) do
                    if Part:IsA("BasePart") then
                        if (Part and Part.Parent) then
                            HiddenProps(Part, "NetworkIsSleeping", false)
                            Part.Velocity = Vector3.new(30,0,0) + Clone["HumanoidRootPart"].CFrame.LookVector * 4
                        end
                    elseif Part:IsA("Accessory") then
                        if (Part and Part.Parent) then
                        HiddenProps(Part.Handle, "NetworkIsSleeping", false)
                        Part.Handle.Velocity = Vector3.new(30,0,0) + Clone["HumanoidRootPart"].CFrame.LookVector * 4
                        end
                    end
                end
            end
        end
    )()

    if Rig == "R6" then
        ReanimateAPI.Align(Character:FindFirstChild("Torso"), Clone:FindFirstChild("Torso"))
        ReanimateAPI.Align(Character:FindFirstChild("Right Arm"), Clone:FindFirstChild("Right Arm"))
        ReanimateAPI.Align(BulletPart, Clone:FindFirstChild("Left Arm"))
        ReanimateAPI.Align(Character:FindFirstChild("Right Leg"), Clone:FindFirstChild("Right Leg"))
        ReanimateAPI.Align(Character:FindFirstChild("Left Leg"), Clone:FindFirstChild("Left Leg"))
        if PartReplica and PartReplica == "Robloxclassicred" then
            task.spawn(function() task.wait(0.1) 
                Character:FindFirstChild(PartReplica).Handle:ClearAllChildren()
                ReanimateAPI.Align(Character:FindFirstChild(PartReplica).Handle, Clone:FindFirstChild("Left Arm"), Vector3.new(0,0,0), Vector3.new(90,0,0))
            end)
        end
    elseif Rig == "R15" then
        if PartReplica and PartReplica == "SniperShoulderL" then
            task.spawn(function() task.wait(0.1) 
                for Index,Stuff in pairs(Character:FindFirstChild(PartReplica).Handle:GetChildren()) do
                    if not Stuff:IsA("SpecialMesh") then
                        Stuff:Destroy()
                    end
                end
                ReanimateAPI.Align(Character:FindFirstChild(PartReplica).Handle, Clone:FindFirstChild("Left Arm"), Vector3.new(0,-0.5,0), Vector3.new(0,0,0))
            end)
        end
        ReanimateAPI.Align(Character:FindFirstChild("HumanoidRootPart"),Character:FindFirstChild("UpperTorso"),Vector3.new(0,0.09,0))
        ReanimateAPI.Align(Character:FindFirstChild("UpperTorso"),Clone:FindFirstChild("Torso"),Vector3.new(0,-0.19,0))
        ReanimateAPI.Align(Character:FindFirstChild("LowerTorso"),Clone:FindFirstChild("Torso"),Vector3.new(0,0.8,0))
        
        ReanimateAPI.Align(Character:FindFirstChild("RightUpperArm"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,-0.4,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightLowerArm"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,0.2-0.015,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightHand"),Clone:FindFirstChild("Right Arm"),Vector3.new(0,0.85,0))

        ReanimateAPI.Align(BulletPart,Clone:FindFirstChild("Left Arm"),Vector3.new(0,-0.4,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftLowerArm"),Clone:FindFirstChild("Left Arm"),Vector3.new(0,0.2-0.015,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftHand"),Clone:FindFirstChild("Left Arm"),Vector3.new(0,0.85,0))

        ReanimateAPI.Align(Character:FindFirstChild("RightUpperLeg"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,-0.5,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightLowerLeg"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,0.2,0))
        ReanimateAPI.Align(Character:FindFirstChild("RightFoot"),Clone:FindFirstChild("Right Leg"),Vector3.new(0,0.85,0))

        ReanimateAPI.Align(Character:FindFirstChild("LeftUpperLeg"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,-0.5,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftLowerLeg"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,0.2,0))
        ReanimateAPI.Align(Character:FindFirstChild("LeftFoot"),Clone:FindFirstChild("Left Leg"),Vector3.new(0,0.85,0))
    end

    for Index,Accessory in pairs(Character:GetChildren()) do
        if Accessory:IsA("Accessory") then
            ReanimateAPI.Align(Accessory.Handle, Clone[Accessory.Name].Handle)
        end
    end
    Camera.CameraSubject = ClnHumanoid
    Player.Character = Clone

    table.insert(
        Events,
        Humanoid.Died:Connect(
            function()
                IsDead = true
                Character.Parent = workspace
                for Index, Loop in pairs(Events) do
                    Loop:Disconnect()
                end
                for Index, Loop in pairs(getgenv().EventTables) do
                    Loop:Disconnect()
                end
                getgenv().StopScript = true
                getgenv().ReanimationClone = nil
                getgenv().OriginalCharacter = nil
                Clone:Destroy()
                Player.Character = workspace[Player.Name]
                if workspace:FindFirstChildOfClass("Camera") then
                    workspace:FindFirstChildOfClass("Camera").CameraSubject = Humanoid
                end
                Humanoid:ChangeState(15)
                task.wait()
                getgenv().StopScript = false
            end
        )
    )

    table.insert(
        Events,
        Player.CharacterAdded:Connect(
            function()
                IsDead = true
                getgenv().StopScript = true
                for Index, Loop in pairs(Events) do
                    Loop:Disconnect()
                end
                for Index, Loop in pairs(getgenv().EventTables) do
                    Loop:Disconnect()
                end
                getgenv().ReanimationClone = nil
                getgenv().OriginalCharacter = nil
                Clone:Destroy()
                task.wait()
                getgenv().StopScript = false
            end
        )
    )

    game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
    getgenv().ReanimationClone = Clone
    getgenv().OriginalCharacter = Character
    ReanimateAPI.Notification("Reanimated With Bullet Reanimate! Reset to change reanimate or stop.")
    ReanimateAPI.PlaySound(452267918)
    loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/StrokeThePea/CatwareReanimate/main/src/Animations.lua"))()
end



function ReanimateAPI.StopScript()
    if not workspace:FindFirstChild("Raw") then
        ReanimateAPI.Notification("Not Reanimated!")
        ReanimateAPI.PlaySound(9074670249)
        return
    end
    getgenv().ScriptStop = true
    getgenv().AnimationRunning = false
    local Libraries = loadstring(game:HttpGet("https://raw.githubusercontent.com/StrokeThePea/Frostware/main/OpenSourceStuff/API.lua"))()
    for i,v in pairs(getgenv().EventTables) do
        v:Disconnect()
    end
    local Character = game.Players.LocalPlayer.Character
    local OGChar = getgenv().OriginalCharacter
    local Torso = Character.Torso
    local Head = Character.Head
    local Root = Character.HumanoidRootPart
    local RA = Character["Right Arm"]
    local LA = Character["Left Arm"]
    local RL = Character["Right Leg"]
    local LL = Character["Left Leg"]
    local IN = Instance.new
    Root.RootJoint:Destroy()
    Character.Humanoid.WalkSpeed = 16
    Character.Humanoid.JumpPower = 50
    for i,v in pairs(Torso:GetDescendants()) do
        if v:IsA("Motor6D") then
            v:Destroy()
        end
    end
    for i,v in pairs(Torso:GetDescendants()) do
        if v:IsA("ManualWeld") then
            v:Destroy()
        end
    end
    for i,v in pairs(Torso:GetDescendants()) do
        if v:IsA("Weld") then
            v:Destroy()
        end
    end
    for i,v in pairs(Torso:GetDescendants()) do
        if v:IsA("PointLight") then
            v:Destroy()
        end
    end
    for i,v in pairs(Character:GetChildren()) do
        if v.Name ~= game.Players.LocalPlayer.Name and v.Name ~= "Head" and v.Name ~= "Torso" and v.Name ~= "Right Arm" and v.Name ~= "Left Arm" and v.Name ~= "Right Leg" and v.Name ~= "Left Leg" and v.Name ~= "HumanoidRootPart" and v.Name ~= "Humanoid" and v.Name ~= "Animate" and v.Name ~= "Animator" and v.Name ~= "BodyColors" and v.Name ~= "Pants" and v.Name ~= "Shirt" then
            v:Destroy()
        end
    end
    if workspace:FindFirstChild("AntiScriptRun") then
        workspace:FindFirstChild("AntiScriptRun"):Destroy()
    end
    for Index,Accessory in pairs(OGChar.FakeHats:GetChildren()) do
        if Accessory:IsA("Accessory") then
            local FakeAccessory = Accessory:Clone()
            FakeAccessory.Parent = Character
            FakeAccessory.Handle.Transparency = 1
            Libraries.ReCreateAccessoryWelds(Character, FakeAccessory)
            ReanimateAPI.Align(OGChar[FakeAccessory.Name].Handle, FakeAccessory.Handle)
        end
    end
	for i,v in pairs(Character.Humanoid:GetChildren()) do
		if v:IsA("Animator") then
			v:Destroy()
		end
		local newanim = IN("Animator", v.Parent)
	end
    if Character:FindFirstChild("FrostwareAnimationPlayer") then
        Character:FindFirstChild("FrostwareAnimationPlayer"):Destroy()    
    end
    if Character:FindFirstChild("FrostwareAnimationMusic") then
        Character:FindFirstChild("FrostwareAnimationMusic"):Destroy()    
    end
    if OGChar:FindFirstChild("Bullet") then
        OGChar:FindFirstChild("Bullet"):ClearAllChildren()
        OGChar:FindFirstChild("Bullet").Transparency = 0
        task.spawn(function()
        	task.wait(0.06)
        	local BulletHighlighter = Instance.new("SelectionBox") --VTanReference
			BulletHighlighter.Parent = Character
			BulletHighlighter.Name = "BulletHighlighter"
			BulletHighlighter.Adornee = OGChar:FindFirstChild("Bullet")
			BulletHighlighter.LineThickness = 0.05
            BulletHighlighter.Color3 = Color3.fromRGB(136, 3, 252)
			if OGChar.Humanoid.RigType == Enum.HumanoidRigType.R15 then
				ReanimateAPI.Align(OGChar:FindFirstChild("Bullet"),Character:FindFirstChild("Left Arm"),Vector3.new(0,-0.4,0))
				if OGChar:FindFirstChild("SniperShoulderL") then
					local Hat = OGChar:FindFirstChild("SniperShoulderL")
					Hat.Handle:ClearAllChildren()
					ReanimateAPI.Align(Hat.Handle, Character:FindFirstChild("Left Arm"), Vector3.new(0,-0.5,0), Vector3.new(0,0,0))
				end
			else
			    ReanimateAPI.Align(OGChar:FindFirstChild("Bullet"),Character:FindFirstChild("Left Arm"))
				if OGChar:FindFirstChild("Robloxclassicred") then
					local Hat = OGChar:FindFirstChild("Robloxclassicred")
					Hat.Handle:ClearAllChildren()
					ReanimateAPI.Align(Hat.Handle, Character:FindFirstChild("Left Arm"), Vector3.new(0,0,0), Vector3.new(90,0,0))
				end
			end
		end)
		
    end
    local Script = IN("LocalScript", Character)
    
    Script.Name = "Animate"
    
    local N = IN("Motor6D", Torso)
    N.Name = "Neck"
    N.Part0 = Torso
    N.Part1 = Head
    N.C0 = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
    N.C1 = CFrame.new(0, -0.5, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
    
    local RJ = IN("Motor6D", Root)
    RJ.Name = "RootJoint"
    RJ.Part0 = Root
    RJ.Part1 = Torso
    RJ.C0 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
    RJ.C1 = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0)
    local RS = IN("Motor6D", Torso)
    RS.Name = "Right Shoulder"
    RS.Part0 = Torso
    RS.Part1 = RA
    RS.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    RS.C1 = CFrame.new(-0.5, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    
    local LS = IN("Motor6D", Torso)
    LS.Name = "Left Shoulder"
    LS.Part0 = Torso
    LS.Part1 = LA
    LS.C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    LS.C1 = CFrame.new(0.5, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    
    local RH = IN("Motor6D", Torso)
    RH.Name = "Right Hip"
    RH.Part0 = Torso
    RH.Part1 = RL
    RH.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    RH.C1 = CFrame.new(0.5, 1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0)
    
    local LH = IN("Motor6D", Torso)
    LH.Name = "Left Hip"
    LH.Part0 = Torso
    LH.Part1 = LL
    LH.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    LH.C1 = CFrame.new(-0.5, 1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
    getgenv().ScriptStop = false
end
function ReanimateAPI.CreateAntiRunPart()
	local Part = Instance.new("Part")
	Part.Parent = workspace
	Part.Anchored = true
	Part.Transparency = 1
	Part.CanCollide = false
	Part.Name = "AntiScriptRun"
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
    if not isfile("FrostwareSongs/ANIMFloss.mp3") then
        writefile("FrostwareSongs/ANIMFloss.mp3", game:HttpGet("https://github.com/StrokeThePea/Frostware/blob/main/Music/Animations/Floss.mp3?raw=true"))
    end
end

function ReanimateAPI.LoadMusicFromFiles(AudioInstance,Path)
    local CustomAssetFunction = getcustomasset or getsynasset or function() end
    AudioInstance.SoundId = CustomAssetFunction(Path,true)
end

function ReanimateAPI.PlayAnimation(ID,SpeedOffset,AudioWanted,AudioPath)
    -- THANK YOU PARE FOR HELP!!!!!!!!
    if not getgenv().OriginalCharacter and not workspace:FindFirstChild("Raw") then 
        ReanimateAPI.SimpleReanimate()
        task.wait(0.5)
    end
    if game.Players.LocalPlayer.Character:FindFirstChild("FrostwareAnimationPlayer") then
        ReanimateAPI.StopScript()
        task.wait(0.5)
    end

    local Character = game.Players.LocalPlayer.Character
    local CurrentID = ID
    local Sexys = game:GetObjects("rbxassetid://"..tostring(CurrentID))[1]
    local sexy = Sexys
    getgenv().AnimationRunning = true
    sexy.Parent = Character
    sexy.Name = "FrostwareAnimationPlayer"
    task.wait(0.5)
    local Torso = Character:WaitForChild("Torso")
    local N,RJ = Torso["Neck"],Character["HumanoidRootPart"]["RootJoint"] -- Neck/RootJoint
    local RS,LS = Torso["Right Shoulder"],Torso["Left Shoulder"]-- Shoulders
    local RH,LH = Torso["Right Hip"],Torso["Left Hip"]-- Hips
    local Frames = {}
    local Positions = {}
    local Sound = Instance.new("Sound")
    Sound.Parent = Character
    Sound.Looped = true
    Sound.Name = "FrostwareAnimationMusic"
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
    while true do
        if getgenv().AnimationRunning == false then
            table.clear(Frames)
            table.clear(Positions)
            Sound:Destroy()
            break
        end
        for i,v in pairs(Frames) do
            if getgenv().AnimationRunning == false then
                return
            end
            task.wait(1/SpeedOffset)
            for _,g in pairs(Positions[v]) do
                if getgenv().AnimationRunning == false then
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
end

return ReanimateAPI
