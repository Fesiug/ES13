
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName			= "Default Class"

PLAYER.WalkSpeed			= 115
PLAYER.RunSpeed				= 115
PLAYER.JumpPower			= 0--245
PLAYER.DuckSpeed			= 0
PLAYER.UnDuckSpeed			= 0
PLAYER.CrouchedWalkSpeed	= 1

function PLAYER:SetupDataTables()
	self.Player:NetworkVar( "String", 0, "WEPRH" )
	self.Player:NetworkVar( "String", 1, "WEPLH" )

	self.Player:NetworkVar( "Bool", 0, "Hand" )

	self.Player:NetworkVar( "Int", 0, "DesiredSpeed" )

	self.Player:NetworkVar( "Float", 0, "HP_Chest" )
	self.Player:NetworkVar( "Float", 1, "HP_Groin" )
	self.Player:NetworkVar( "Float", 2, "HP_Head" )
	self.Player:NetworkVar( "Float", 3, "HP_LArm" )
	self.Player:NetworkVar( "Float", 4, "HP_RArm" )
	self.Player:NetworkVar( "Float", 5, "HP_LLeg" )
	self.Player:NetworkVar( "Float", 6, "HP_RLeg" )

	self.Player:NetworkVar( "Float", 7, "HP_Brute" )
	self.Player:NetworkVar( "Float", 8, "HP_Burn" )
	self.Player:NetworkVar( "Float", 9, "HP_Toxins" )
	self.Player:NetworkVar( "Float", 10, "HP_Oxygen" )

	self.Player:SetDesiredSpeed(3)

	--self.Player:SetWEPRH("usp")
end

function PLAYER:Loadout()
	--self.Player:Give( "es_weaponhandler" )
end

function PLAYER:Init()
	self.Player:SetHull( Vector(-16, -16, 0), Vector(16, 16, 40) )
	self.Player:SetViewOffset(Vector(0, 0, 44))

	self.Player:SetHullDuck( Vector(-16, -16, 0), Vector(16, 16, 40) )
	self.Player:SetViewOffsetDucked(Vector(0, 0, 44))

	--self.Player:SetHullDuck( Vector(-16, -16, 0), Vector(16, 16, 30) )
	--self.Player:SetViewOffsetDucked(Vector(0, 0, 30))

	if SERVER then self.Player:SetBloodColor( DONT_BLEED ) end
end

function PLAYER:Spawn()
	self.Player:SetHP_Brute(0)
	self.Player:SetHP_Burn(0)
	self.Player:SetHP_Toxins(0)
	self.Player:SetHP_Oxygen(0)
end

player_manager.RegisterClass( "player_es13", PLAYER, "player_default" )