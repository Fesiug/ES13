
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

PLAYER.DisplayName			= "Default Class"

PLAYER.WalkSpeed			= 1
PLAYER.RunSpeed				= 1
PLAYER.JumpPower			= 0--245
PLAYER.DuckSpeed			= 0.2
PLAYER.UnDuckSpeed			= 0.2

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

	self.Player:SetDesiredSpeed(3)

	--self.Player:SetWEPRH("usp")
end

function PLAYER:Loadout()
	--self.Player:Give( "es_weaponhandler" )
end

function PLAYER:Init()
	self.Player:SetHull( Vector(-16, -16, 0), Vector(16, 16, 40) )
	self.Player:SetHullDuck( Vector(-16, -16, 0), Vector(16, 16, 30) )

	self.Player:SetViewOffset(Vector(0, 0, 44))
	self.Player:SetViewOffsetDucked(Vector(0, 0, 30))
end

player_manager.RegisterClass( "player_es13", PLAYER, "player_default" )