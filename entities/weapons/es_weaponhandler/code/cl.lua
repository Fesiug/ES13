--
	
function SWEP:VMAssign(index, model)
	if self.VMT[index] and IsValid(self.VMT[index]) then
		self:VMCleanRemove(self.VMT[index])
	end
	local clmdl = ClientsideModel(model, RENDERGROUP_OTHER)
	clmdl:SetNoDraw(true)
	clmdl:UseClientSideAnimation()
	clmdl.LastAnimTime = 0
	clmdl.NextAnimTime = 0
	clmdl.AnimLength = 0
	clmdl.NextIdle = 0
	clmdl:Spawn()
	self.VMT[index] = clmdl

	--print("Created a CLMDL at index " .. index .. ": ", clmdl)
end

function SWEP:VMCleanRemove(en)
	if en and IsValid(en) then
		--print("REMOVED CLMDL", en)
		en:Remove()
	end
end

function SWEP:VMRefresh()
	self:VMWipe()
	if self.t_WEPRH and (self.t_WEPLH and self.t_WEPRH["Viewmodel_Right"] or self.t_WEPRH["Viewmodel"]) then
		self:VMAssign(1, (self.t_WEPLH and self.t_WEPRH["Viewmodel_Right"] or self.t_WEPRH["Viewmodel"]))
	end
	if self.t_WEPLH and (self.t_WEPLH["Viewmodel_Left"] or self.t_WEPLH["Viewmodel"]) then
		self:VMAssign(2, (self.t_WEPLH["Viewmodel_Left"] or self.t_WEPLH["Viewmodel"]))
	end
end

function SWEP:VMWipe()
	self:VMCleanRemove(self.VMT[1])
	self:VMCleanRemove(self.VMT[2])
	self:VMCleanRemove(self.VMT[3])
end

function SWEP:DrawHUD()
	--surface.SetFont("ES_C16")
	--surface.SetTextColor(255, 255, 255, 255)
end

function SWEP:GetTracerOrigin()
	return EyePos()
end
