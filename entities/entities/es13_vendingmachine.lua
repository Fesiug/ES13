
AddCSLuaFile()

ENT.Base		= "base_anim"
ENT.Type		= "anim"

ENT.Model			= "models/es13/props/devbox64/models/es13/props/devbox.mdl"

ENT.PrintName		= "Vending Machine"

function ENT:Initialize()
	self:SetModel( self.Model )

	if SERVER then
		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetUseType( SIMPLE_USE )
	end
end



ENT.Supply = {
	{
		name = "Water Soda",
		model = "models/props_junk/popcan01a.mdl",
		cost = 10,
		amount = 10
	}
}

function ENT:Use( activator, caller, usetype, value )
	if ( activator:IsPlayer() ) then 
		local prod = self.Supply[1]

		if activator:Crouching() then
			prod.amount = 10
			activator:ChatPrint( string.format("Restocked %s. %i left.", prod.name, prod.amount ) )
			return
		end

		if prod.amount == 0 then
		activator:ChatPrint( string.format("There is no more %s left. You have not been charged.", prod.name ) )
			return
		end

		local prop = ents.Create( "prop_physics" )
		if ( !IsValid(prop) ) then return end
		prop:SetModel( prod.model )
		
		prop:SetPos( self:GetPos() + ( self:GetAngles():Right() * (32+4) ) )
		prop:SetAngles( activator:EyeAngles() )
		prop:Spawn()

		prod.amount = prod.amount - 1
		activator:ChatPrint( string.format("Dispensed %s. You have been charged $%i. %i left.", prod.name, prod.cost, prod.amount ) )
	end
end