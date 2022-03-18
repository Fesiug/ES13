
AddCSLuaFile()

ENT.Base		= "base_anim"
ENT.Type		= "anim"

ENT.Model			= "models/props_junk/popcan01a.mdl"

ENT.PrintName		= "Soda Item"

function ENT:Initialize()
	self:SetModel( self.Model )

	if SERVER then
		self:SetSolid( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
	end
end

ENT.ZVel = 0
ENT.Grounded = true
ENT.LastThink = CurTime()

function ENT:Think()
	if SERVER then
		local td = CurTime() - self.LastThink
		print(td)

		local trace = { start = self:GetPos(), endpos = self:GetPos() - ( vector_up * (math.max( td, 0, 0.3 )) * 64 * ( math.max( -self.ZVel, 4 ) ) ), filter = self }
		local tr = util.TraceEntity( trace, self )

		
		self:NextThink( CurTime() + 1 )

		if tr.Fraction == 0 then
			self.ZVel = 0
			self.Grounded = true
		elseif tr.Hit then
			self:SetPos( tr.HitPos )
			self.ZVel = 0
			self.Grounded = true
		else
			self.ZVel = self.ZVel + ( ( tr.HitPos.z - self:GetPos().z ) * 0.1 )
			self:SetPos( tr.HitPos )
			self.Grounded = false
			self:NextThink( CurTime() + 0.1 )
		end
		self.LastThink = CurTime()
	end
	return true
end

function ENT:HitGround()

	return
end

if SERVER then
	function ENT:Use( activator )
		self.LastThink = CurTime()
		self:SetPos( activator:GetPos() + ( vector_up * 64 ) )
		--self:Remove()
	end
end