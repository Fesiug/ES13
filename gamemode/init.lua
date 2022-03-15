AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )


DEFINE_BASECLASS( "gamemode_base" )

function GM:PlayerSpawn( pl, transiton )
	player_manager.SetPlayerClass( pl, "player_es13" )
	BaseClass.PlayerSpawn( self, pl, transiton )
	pl:SetModel("models/es13/player/player.mdl")
	pl:SprintDisable()
	pl:SetWEPRH("none")
	pl:SetWEPLH("none")
	pl:Give("es_weaponhandler")
	pl:SetCanZoom(false)
	pl:SetSlowWalkSpeed(1)
end