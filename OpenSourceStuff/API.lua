local API = {}
API.ReCreateAccessoryWelds = function(Model,Accessory) -- Inspiration from DevForum Post made by admin.
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
API.Properties = function()
    local HiddenProps = sethiddenproperty or set_hidden_property or function() end
    settings().Physics.AllowSleep = false
    settings().Physics.ForceCSGv2 = false
    settings().Physics.DisableCSGv2 = true
    settings().Physics.UseCSGv2 = false
    settings().Rendering.EagerBulkExecution = true
    settings().Physics.ThrottleAdjustTime = math.huge
    settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled
    HiddenProps(workspace, "HumanoidOnlySetCollisionsOnStateChange", Enum.HumanoidOnlySetCollisionsOnStateChange.Disabled)
    HiddenProps(workspace, "InterpolationThrottling", Enum.InterpolationThrottlingMode.Disabled)
    game.Players.LocalPlayer.ReplicationFocus = workspace
end
return API
