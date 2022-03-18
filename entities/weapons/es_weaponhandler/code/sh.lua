--

SWEP.PrintName = "aye aye aye aye"
SWEP.Base = "weapon_base"

SWEP.ESH = {}
SWEP.ViewModelFOV = 54
SWEP.VMFOV = 54
SWEP.DrawCrosshair = false

SWEP.ViewModel = nil
SWEP.WorldModel = nil

SWEP.DrawWorldModel = false

-- right hand
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"

-- left hand
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.LinkedCLMDLS = {}

SWEP.t_WEPRH = nil
SWEP.t_WEPLH = nil

SWEP.FUCKOW = true

SWEP.DTL = {
	["Int"] = {
		"PrimaryBurstCount",
		"SecondaryBurstCount"
	},
	["Float"] = {
		"PrimaryDelay",
		"SecondaryDelay"
	},
}

SWEP.EventTable = {}


function SWEP:Initialize()
	self.VMT = {
		[1] = NULL,
		[2] = NULL,
		[3] = NULL
	}
	self:SetClip1(0)
	self:SetClip2(0)
end

function SWEP:CustomAmmoDisplay()
	self.AmmoDisplay = self.AmmoDisplay or {} 
 
	self.AmmoDisplay.Draw = true

	local p = LocalPlayer()
	local h = p:GetHand()

	if !h then
		self.AmmoDisplay.PrimaryClip = self:Clip1()
		self.AmmoDisplay.PrimaryAmmo = self:Ammo1()
		self.AmmoDisplay.SecondaryAmmo = self:Clip2()
	else
		self.AmmoDisplay.PrimaryClip = self:Clip2()
		self.AmmoDisplay.PrimaryAmmo = self:Ammo2()
		self.AmmoDisplay.SecondaryAmmo = self:Clip1()
	end

	--self.AmmoDisplay.SecondaryAmmo = self:Ammo2()		

	return self.AmmoDisplay
end


function SWEP:SetupTables()
	local p = self:GetOwner()
	if !p:IsPlayer() then return false end

	if p:GetWEPRH() then
		self.t_WEPRH = ES:GetWeaponInfo(p:GetWEPRH())
	end
	if p:GetWEPLH() then
		self.t_WEPLH = ES:GetWeaponInfo(p:GetWEPLH())
	end
end

function SWEP:Deploy( real )
	local vm = self:GetOwner():GetViewModel(0)
	vm:SetWeaponModel( "models/weapons/v_pistol.mdl", nil )

	if CLIENT then
		self:SetupTables()
		self:VMRefresh()
		self.FUCKOW = false

		for i=1, 3 do
			local tent = self.VMT[i]
			if IsValid(tent) then
				local ta = (i==2 and self.t_WEPLH or self.t_WEPRH)
				if ta and ta["ViewmodelAnims"]["draw"] then
					self:SendVMAnim(i, ta["ViewmodelAnims"]["draw"])
				end
			end
		end
	end

	if SERVER then
		self:SetupTables()
	end
	
	return true
end

function SWEP:Holster()
	if CLIENT then self:VMWipe() end
	return true
end

function SWEP:OnReloaded()
	self:SetupTables()
	if CLIENT then self:VMRefresh() end
end

function SWEP:OnRemove()
	if CLIENT then self:VMWipe() end
end

function SWEP:OwnerChanged()
	self:SetupTables()
	if CLIENT then self:VMWipe() self.FUCKOW = true end
end

function SWEP:SetupDataTables()
	for i, v in pairs(self.DTL) do
		for n, t in ipairs(v) do
			self:NetworkVar(i, n-1, t)
		end

	end

end

concommand.Add("es13_selwep", function(ply, cmd, args)
	if ply:GetWeapon("es_weaponhandler") then
		local wep = ply:GetWeapon("es_weaponhandler")
		if !IsValid(wep) then return end
		
		if string.lower(args[1]) == "l" then
			ply:SetWEPLH(args[2])
			wep:SetClip2(0)
		else
			ply:SetWEPRH(args[2])
			wep:SetClip1(0)
		end
		wep:Deploy()
		timer.Simple(0.25, function() wep:CallOnClient("Deploy") end)
	end
end, nil, nil, FCVAR_REPLICATED)

-- adata format
--[[
	NAME
		name of sequence

	LENGTH
		animation length

	EVENTS
		table which contains events to play

	MISC
		table of shit idk
]]

--[[
	index 1 is right hand
	index 2 is left hand
	index 3 is spare
]]

function SWEP:SendVMAnim(index, adata)
	if SERVER then return end

	local tent = self.VMT[index]
	if !IsValid(tent) then ES:Error("WTF NO TENT", index, tent) return end

	if istable(adata.NAME) then adata.NAME = table.Random(adata.NAME) end
	local animmult = (adata["MISC"] and adata["MISC"]["AnimMult"]) or 1
	local lksq, lktm = tent:LookupSequence(adata.NAME)
	lktm = lktm * animmult
	if !lksq then return false end
	tent:SetCycle(0)
	tent:ResetSequence(lksq)
	tent:SetPlaybackRate(animmult)
	tent.LastAnimTime = CurTime()
	tent.NextAnimTime = CurTime() + lktm
	tent.AnimLength = lktm

	if adata.EVENTS then
		for time, tab in pairs(adata.EVENTS) do
			if time == "MISC" then continue end
			self.EventTable[CurTime() + time] = tab
		end
	end

end

if CLIENT then
	function SWEP:ProcessEvents()
		for i, v in pairs( self.EventTable ) do
			if i <= CurTime() then
				self:RunEvent(v)
				self.EventTable[i] = nil
			end
		end
	end

	function SWEP:RunEvent( event )
		if event.snd then
			self:SoundEngine(event.snd)
		end
	end
end

function SWEP:Think()
	if CLIENT then
		self:ProcessEvents()
		if self.FUCKOW then
			self:Deploy()
		end
		for i=1, 2 do
			local tent = self.VMT[i]
			if IsValid(tent) then
				local ta = (i==2 and self.t_WEPLH or self.t_WEPRH)
				if !ta then return end

				if tent.NextAnimTime <= CurTime() then
					local adata = ta["ViewmodelAnims"]["idle"]
					if self:ClipH((i == 2)) <= 0 and ta["ViewmodelAnims"]["empty_idle"] then adata = ta["ViewmodelAnims"]["empty_idle"] end
					if adata then self:SendVMAnim(i, adata) end
				end
				tent:SetCycle( math.Clamp( 1 - (tent.NextAnimTime - CurTime())/tent.AnimLength, 0, 1) )
			end
		end
	end

	if IsValid(self:GetOwner()) then
		local ht = "normal"
		if self:GetOwner():EyeAngles().x < -45 then
			-- look at god. in anger.
			ht = "knife"
		elseif self:GetOwner():EyeAngles().x > 45 then
			-- point downward better i guess
			ht = "slam"
		else
			if self.t_WEPLH and self.t_WEPRH then
				ht = "duel"
			elseif self.t_WEPRH then
				ht = "revolver"
			end
		end
		self:SetHoldType( ht )
	end

	if !self:GetOwner():KeyDown(IN_ATTACK) and self:GetPrimaryBurstCount() > 0 then
		self:SetPrimaryBurstCount(0)
	end
	if !self:GetOwner():KeyDown(IN_ATTACK) and self:GetSecondaryBurstCount() > 0 then
		self:SetSecondaryBurstCount(0)
	end
end

function SWEP:CanPrimaryAttack()
	if self:GetPrimaryDelay() > CurTime() then
		return false
	end

	if self:Clip1() == 0 then
		return false
	end

	return true
end

function SWEP:CanSecondaryAttack()
	if self:GetSecondaryDelay() > CurTime() then
		return false
	end

	if self:Clip2() == 0 then
		return false
	end

	return true
end

function SWEP:ClipH(h)
	if h then
		return self:Clip2()	
	else
		return self:Clip1()
	end
end

function SWEP:GetHDelay(h)
	if h then
		return self:GetSecondaryDelay()
	else
		return self:GetPrimaryDelay()
	end
end

function SWEP:SetHDelay(h, v)
	if h then
		self:SetSecondaryDelay(v)
	else
		self:SetPrimaryDelay(v)
	end
end

function SWEP:SetClipH(h, v)
	if h then
		self:SetClip2(v)	
	else
		self:SetClip1(v)
	end
end

function SWEP:SetNextHandDelay(v)
end

--[[ local function BulletCallback( atk, tr, dmg )
	-- Thank you Arctic, very cool
	local ent = tr.Entity

	dmg:SetDamage( self.Stats["Projectiles"]["Damage"]:GetMax() )
	dmg:SetDamageType(DMG_BULLET)

	if IsValid(ent) then
		local d = dmg:GetDamage()
		local min, max = self.Stats["Projectiles"]["Air Damage Range"]:GetMin(), self.Stats["Projectiles"]["Air Damage Range"]:GetMax()
		local range = atk:GetPos():Distance(ent:GetPos())
		local XD = 0
		if range < min then
			XD = 0
		else
			XD = math.Clamp((range - min) / (max - min), 0, 1)
		end

		dmg:SetDamage( self.Stats["Projectiles"]["Damage"]:Lerp(1-XD) )
	end

	if ent:IsPlayer() then
		local d = dmg:GetDamage()
		dmg:SetDamage(0)
		if SERVER then ent:SetHP_Brute(ent:GetHP_Brute() - d) end
	end
	return
end]]

local function BulletCallback( atk, bullet )
	return
end



function SWEP:ShootBullets(bullet)
	bullet.Src = self.Owner:GetShootPos()
	bullet.Dir = self.Owner:GetAimVector()
	bullet.Callback = function( atk, tr, dmg )
		-- Thank you Arctic, very cool
		local ent = tr.Entity

		dmg:SetDamage( bullet.Damage )
		dmg:SetDamageType(DMG_BULLET)

		if IsValid(ent) then
			local d = dmg:GetDamage()
			local min, max = bullet.RangeMin, bullet.Range
			local range = atk:GetPos():Distance(ent:GetPos())
			local XD = 0
			if range < min then
				XD = 0
			else
				XD = math.Clamp((range - min) / (max - min), 0, 1)
			end

			dmg:SetDamage( Lerp( 1-XD, bullet.DamageMin, bullet.Damage ) )
		end

		if ent:IsPlayer() then
			local d = dmg:GetDamage()
			dmg:SetDamage(0)
			if SERVER then ent:SetHP_Brute(ent:GetHP_Brute() + d) end
		end
		return
	end
	
	self:GetOwner():FireBullets( bullet )
end


function SWEP:Weapon_Attack(tabl, index)
	-- use item currently selected
	local ta = tabl
	local h = self:GetOwner():GetHand()

	if !h then
		if !self.t_WEPRH then return false end
		self:SetPrimaryDelay(CurTime() + ta["Fire Delay"])
		self:SetPrimaryBurstCount(self:GetPrimaryBurstCount()+1)
	else
		if !self.t_WEPLH then return false end
		self:SetSecondaryDelay(CurTime() + ta["Fire Delay"])
		self:SetSecondaryBurstCount(self:GetSecondaryBurstCount()+1)
	end

	self:SetClipH(h, self:ClipH(h) - 1)

	if CLIENT then
		local adata = ta["ViewmodelAnims"]["shoot"]
		if ta["ViewmodelAnims"]["empty_shoot"] and self:ClipH(h) <= 0 then adata = ta["ViewmodelAnims"]["empty_shoot"] end
		self:SendVMAnim(index, adata)
	end
	self:SoundEngine(ta["Fire Sound"])

	self:ShootBullets(ta["BulletInfo"])

	return true
end

function SWEP:PrimaryAttack()
	local p = self:GetOwner()
	local h = p:GetHand()

	if !h then
		if !self:CanPrimaryAttack() then return false end
		if self.t_WEPRH and self.t_WEPRH["Weapon"] then
			if self.t_WEPRH["Fire Max Burst"] and self:GetPrimaryBurstCount() >= self.t_WEPRH["Fire Max Burst"] then return false end
			self:Weapon_Attack(self.t_WEPRH, 1)
		end
	else
		if !self:CanSecondaryAttack() then return false end
		if self.t_WEPLH and self.t_WEPLH["Weapon"] then
			if self.t_WEPLH["Fire Max Burst"] and self:GetSecondaryBurstCount() >= self.t_WEPLH["Fire Max Burst"] then return false end
			self:Weapon_Attack(self.t_WEPLH, 2)
		end
	end
end

function SWEP:SecondaryAttack()
	--[[local ta = self.t_WEPLH
	if !ta then return end
	local p = self:GetOwner()
	local h = p:GetHand()

	if h == 2 then
		self:Weapon_Attack(self.t_WEPRH, 1)
	else
		self:Weapon_Attack(self.t_WEPLH, 2)
	end]]
end

function SWEP:Reload()
	local p = self:GetOwner()
	local h = p:GetHand()
	if self:GetHDelay(h) > CurTime() then return false end

	local ta = nil
	if !h then
		ta = self.t_WEPRH
	else
		ta = self.t_WEPLH
	end
	if !ta then return false end
	if !ta["Weapon"] then return false end

	if self:ClipH(h) >= ta["Clip Max"] then return false end

	if ta then
		local adata = ta["ViewmodelAnims"]["reload"]
		if ta["ViewmodelAnims"]["empty_reload"] and self:ClipH(h) <= 0 then adata = ta["ViewmodelAnims"]["empty_reload"] end
		if CLIENT then self:SendVMAnim((h and 2 or 1), adata) end
		self:SetHDelay(h, CurTime() + adata["MISC"]["HandDelay"])
	end

	if ta then self:SetClipH( h, math.min(ta["Clip Reloaded"], ta["Clip Max"]) ) end

	return true
end

-- not an engine, just like a
function SWEP:SoundEngine( snde )
	for i, v in ipairs(snde) do
		self:EmitSound(v.s, v.l, v.p, v.v, v.c)
	end
end





--[[]

function SWEP:SendViewModelAnim( act , index , rate )
	if !game.SinglePlayer() and !IsFirstTimePredicted() then
		return
	end
	
	local vm = self.Owner:GetViewModel( index )
	if !IsValid( vm ) then
		return
	end
	local seq = vm:SelectWeightedSequence( act )
	if ( seq == -1 ) then
		return
	end
	
	vm:SendViewModelMatchingSequence( seq )
	vm:SetPlaybackRate( rate or 1 )
end]]