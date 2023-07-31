GM.Name = "ES13"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"

AddCSLuaFile("player_class/player_es13.lua")
include("player_class/player_es13.lua")

ES = {}

-- Server
if SERVER then for i, fil in ipairs( file.Find( "es13/gamemode/sv/*.lua", "LUA" ) ) do
	include( "sv/" .. fil )
end end

-- Client
for i, fil in ipairs( file.Find( "es13/gamemode/cl/*.lua", "LUA" ) ) do
	if SERVER then
		AddCSLuaFile( "cl/" .. fil )
	elseif CLIENT then
		include( "cl/" .. fil )
	end
end

-- Shared
for i, fil in ipairs( file.Find( "es13/gamemode/sh/*.lua", "LUA" ) ) do
	if SERVER then
		AddCSLuaFile( "sh/" .. fil )
	end
	include( "sh/" .. fil )
end


function GM:Initialize()
	-- Do stuff
end

function GM:PlayerNoClip( ply, desiredState )
	if ( desiredState == false ) then -- the player wants to turn noclip off
		return true -- always allow
	elseif ( ply:IsAdmin() ) then
		return true -- allow administrators to enter noclip
	end
end

local speeds = {
	[1] = 64 * 1.5, --	64 * 1.796875,	-- 115,
	[2] = 64 * 2.25, --	64 * 2.34375,	-- 150,
	[3] = 64 * 3, --	64 * 3.125,		-- 200,
}

hook.Add( "CreateMove", "ES13_CreateMove", function( cmd )
	if IsValid(SuperPanel) then -- Stuff doesn't work with gui clicker
		if input.IsMouseDown( MOUSE_LEFT ) then
			cmd:AddKey( IN_ATTACK )
		elseif input.IsMouseDown( MOUSE_RIGHT ) then
			cmd:AddKey( IN_ATTACK2 )
		end
	end
end )

hook.Add( "Move", "testestst", function( ply, mv )
	if mv:KeyPressed( IN_SPEED ) then
		if (CamStyle == 2) then
			CamStyle = 0
		else
			CamStyle = 2
		end
	end
	
	local speed = speeds[ply:GetDesiredSpeed()]
	mv:SetMaxSpeed( speed )
	mv:SetMaxClientSpeed( speed )
end )

local lt = CurTime()
hook.Add( "StartCommand", "ES_StartCommand", function( ply, cmd )
	if !ply:OnGround() and cmd:KeyDown( IN_DUCK ) then
		cmd:RemoveKey( IN_DUCK )
	end
	if cmd:KeyDown( IN_WALK ) and cmd:GetMouseWheel() != 0 then
		local desired = ply:GetDesiredSpeed() + ( 1 * cmd:GetMouseWheel() )
		if desired <= 3 and desired >= 1 then
			if CLIENT and CurTime() > (lt + 0.006) then surface.PlaySound("es13/ui/switch.wav") end
			ply:SetDesiredSpeed(math.Clamp(desired, 1, 3))
		end
	end
	
	if CLIENT and (CamStyle == 2) and IsValid(SuperPanel) then
		local posInQuotationMarks = Vector( ply:GetPos().x, ply:GetPos().y, 0 ) + Vector( 0, 0, 1024 )
		local tr = util.QuickTrace(posInQuotationMarks, gui.ScreenToVector(gui.MousePos()),LocalPlayer())

		local meme = (tr.HitPos - posInQuotationMarks):Angle()
		meme.x = 0
		
		cmd:SetViewAngles( meme )
	end
end )

local walk = {
	[1] = ACT_MP_WALK,
	[2] = ACT_MP_RUN,
	[3] = ACT_MP_RUN,
}
local walk2 = {
	[1] = "walk",
	[2] = "walk",
	[3] = "run",
}
function GM:CalcMainActivity(ply, velocity)
	ply.CalcIdeal = ACT_MP_STAND_IDLE
	ply.CalcSeqOverride = -1

	local anii = "idle"

	--self:HandlePlayerLanding( ply, velocity, ply.m_bWasOnGround )
	--[[if !( self:HandlePlayerNoClipping( ply, velocity ) ||
		self:HandlePlayerDriving( ply ) ||
		self:HandlePlayerVaulting( ply, velocity ) ||
		self:HandlePlayerJumping( ply, velocity ) ||
		self:HandlePlayerSwimming( ply, velocity ) ||
		false ) then --self:HandlePlayerDucking( ply, velocity ) ) then
		--if ( len2d >= (140) ) then ply.CalcIdeal = ACT_MP_RUN elseif ( len2d > 0.25 ) then ply.CalcIdeal = ACT_MP_WALK end
	end]]

	local len2d = velocity:Length2DSqr()
	if len2d != 0 then anii = walk2[ply:GetDesiredSpeed()] end -- ply.CalcIdeal = walk[ply:GetDesiredSpeed()] end
	ply:SetSequence( anii )
	ply.m_bWasOnGround = ply:IsOnGround()
	ply.m_bWasNoclipping = ( ply:GetMoveType() == MOVETYPE_NOCLIP && !ply:InVehicle() )

	return ply.CalcIdeal, ply.CalcSeqOverride
end

hook.Add( "PlayerPostThink", "ES13_PlayerPostThink", function(ply)
	if true then
		ply:SetPoseParameter( "pp_es13_look_pitch", ply:EyeAngles().p / 90 )

		local yog = ply:EyeAngles().y
		local FUCK = (ply:GetRenderAngles().y - yog)/90
		if math.abs(FUCK) > 1 then yog = -yog FUCK = (yog - ply:GetRenderAngles().y)/90 end

		ply:SetPoseParameter( "pp_es13_look_yaw", FUCK )

		local p = ply
		local w = ply:GetActiveWeapon()
		if IsValid(w) and w:GetClass() == "es_weaponhandler" then
			local count = 0
			
			if p.GetWEPRH and p:GetWEPRH() and ES:GetWeaponInfo(p:GetWEPRH()) then count = count + 1 end
			if p.GetWEPLH and p:GetWEPLH() and ES:GetWeaponInfo(p:GetWEPLH()) then count = count + 1 end

			ply:SetPoseParameter( "pp_es13_wield", count )
		end
	end
end)

local lut = {
	[IN_ZOOM] = function( ply, key )
		ply:SetHand( !ply:GetHand() )
	end
}

hook.Add("KeyPress", "ES_KeyPress", function( ply, key )
	if lut[key] then lut[key](ply, key) end
end)

function ESWcontact()
	for i, v in ipairs(player.GetAll()) do
		local w = v:GetWeapon("es_weaponhandler")
		if w then
			w:OnReloaded()			
		end
	end
end

function GM:OnReloaded()
	ESWcontact()
end

function ES:Error( ... )
	local args = { ... }
	local str = args[1]

	ErrorNoHaltWithStack(str)
end

function ES:GetWeaponInfo( weapon )
	if !weapon then
		return
	end

	if !ES.WeaponList[ weapon ] then
		return
	end

	return ES.WeaponList[ weapon ]
end

-- Server
hook.Add( "PlayerSay", "CharCount", function( ply, text )
	if epicwin then
		local hand = 0
		text = string.lower( text )
		if ( string.Left(text, 3) == "/r " ) then
			text = string.sub(text, 4)
			hand = 1
		elseif ( string.Left(text, 3) == "/l " ) then
			text = string.sub(text, 4)
			hand = 2
		end

		if hand == 1 then
			ply:SetWEPRH(text)
			timer.Simple(0.15, function()
				ESWcontact()
				ply:SendLua("ESWcontact()")
			end)
		elseif hand == 2 then
			ply:SetWEPLH(text)
			timer.Simple(0.15, function()
				ESWcontact()
				ply:SendLua("ESWcontact()")
			end)
		else
		end
	else
		ply:ChatPrint( "You cannot use this type of chat!" )
		return ""
	end
end )

hook.Add( "PlayerCanHearPlayersVoice", "ES13_NoVoice", function( listener, talker )
	return false
end )

if SERVER then util.AddNetworkString("gimmedna") end
function GiveDNA(pl)
	local pl = net.ReadEntity() or pl
	pl.dna = {}
	local dna = pl.dna
	dna.name = "John Smith"
	print("got", pl, dna.name)
end
net.Receive("gimmedna", GiveDNA)