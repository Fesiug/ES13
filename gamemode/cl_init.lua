
include( "shared.lua" )


local loost = { -- 8 entries
	64,					-- 15x15
	56.783652106914,	-- 13x13
	49.15494147708,		-- 11x11
	41.113868110499,	-- 9x9
	32.454250638796,	-- 7x7
	23.382270430345,	-- 5x5
	14.10410885352,		-- 3x3
	4.8259472766951		-- 1x1
}

if CamStyle == nil then CamStyle = 0 end
-- 0 : First-person
-- 1 : Third-person
-- 2 : Top-down
-- 3 : Fixed, unimplemented
-- 4 : Orthographic, unimplemented
local wedrag = false
local wedist = 100
local welook = Angle(0, 0, 0)
local bonestoremove2 =
{
	"ValveBiped.Bip01_Head1",
	"ValveBiped.Bip01_L_Hand",
	"ValveBiped.Bip01_L_Forearm",
	"ValveBiped.Bip01_L_Upperarm",
	"ValveBiped.Bip01_L_Clavicle",
	"ValveBiped.Bip01_R_Hand",
	"ValveBiped.Bip01_R_Forearm",
	"ValveBiped.Bip01_R_Upperarm",
	"ValveBiped.Bip01_R_Clavicle",
	"ValveBiped.Bip01_L_Finger4",
	"ValveBiped.Bip01_L_Finger41",
	"ValveBiped.Bip01_L_Finger42",
	"ValveBiped.Bip01_L_Finger3",
	"ValveBiped.Bip01_L_Finger31",
	"ValveBiped.Bip01_L_Finger32",
	"ValveBiped.Bip01_L_Finger2",
	"ValveBiped.Bip01_L_Finger21",
	"ValveBiped.Bip01_L_Finger22",
	"ValveBiped.Bip01_L_Finger1",
	"ValveBiped.Bip01_L_Finger11",
	"ValveBiped.Bip01_L_Finger12",
	"ValveBiped.Bip01_L_Finger0",
	"ValveBiped.Bip01_L_Finger01",
	"ValveBiped.Bip01_L_Finger02",
	"ValveBiped.Bip01_R_Finger4",
	"ValveBiped.Bip01_R_Finger41",
	"ValveBiped.Bip01_R_Finger42",
	"ValveBiped.Bip01_R_Finger3",
	"ValveBiped.Bip01_R_Finger31",
	"ValveBiped.Bip01_R_Finger32",
	"ValveBiped.Bip01_R_Finger2",
	"ValveBiped.Bip01_R_Finger21",
	"ValveBiped.Bip01_R_Finger22",
	"ValveBiped.Bip01_R_Finger1",
	"ValveBiped.Bip01_R_Finger11",
	"ValveBiped.Bip01_R_Finger12",
	"ValveBiped.Bip01_R_Finger0",
	"ValveBiped.Bip01_R_Finger01",
	"ValveBiped.Bip01_R_Finger02",
	--"ValveBiped.Bip01_Spine4",
	--"ValveBiped.Bip01_Neck1",
	--"ValveBiped.Bip01_Spine2",
}
local bonestoremove =
{
	"ValveBiped.Bip01_Spine4",
}

function legscleanup()
	if GLOBALLEGSLIST then
		for i, v in ipairs(GLOBALLEGSLIST) do
			--print("bye bye ", v)
			v:Remove()
			GLOBALLEGSLIST[i] = nil
		end
	end
end
legscleanup()
GLOBALLEGSLIST = {}
local leg = GLOBALLEGSLIST[1]

function legsinit()
	if GLOBALLEGSLIST[1] then GLOBALLEGSLIST[1]:Remove() GLOBALLEGSLIST[1] = nil end
	table.insert(GLOBALLEGSLIST, ClientsideModel(LocalPlayer():GetModel()))
	leg = GLOBALLEGSLIST[1]
	leg:UseClientSideAnimation()
	leg:SetNoDraw(true)
	leg:SetIK(true)
	leg:DrawShadow(true)
end

hook.Add( "InitPostEntity", "legs", function()
	--legsinit()

	local pl = LocalPlayer()
	GiveDNA(pl)
	if SERVER then
		pl = Entity(1)
		net.Start("gimmedna")
		net.WriteEntity(pl)
		net.Send(pl)
	end
end )

hook.Add( "Think", "Togglestuff", function()
	if (CamStyle == 1) then
		if !input.IsMouseDown( MOUSE_RIGHT ) and !input.IsMouseDown( MOUSE_MIDDLE ) then
			wedrag = true
		else
			wedrag = false
		end
	end
end )

if SuperPanel then SuperPanel:Remove() end

function GM:OnSpawnMenuOpen()
	RestoreCursorPosition()
	gui.EnableScreenClicker(true)

	if CamStyle > 0 then
		SuperPanel = vgui.Create( "DButton" )
		SuperPanel:SetSize( ScrW(), ScrH() )
		SuperPanel:SetWorldClicker( false )
		SuperPanel:SetText( "" )
		function SuperPanel:Paint( w, h )
			local p = LocalPlayer()
			local h = p:GetHand()
			local w = p:GetActiveWeapon()

			local ta = nil
			if !h then
				ta = w.t_WEPRH
			else
				ta = w.t_WEPLH
			end
			if !ta then
				SuperPanel:SetCursor("arrow")
			elseif ta["Weapon"] then
				SuperPanel:SetCursor("crosshair")
			else
				SuperPanel:SetCursor("crosshair")
			end
		end
	end

end

function GM:OnSpawnMenuClose()
	RememberCursorPosition()
	gui.EnableScreenClicker(false)
	if SuperPanel then SuperPanel:Remove() end
end

local tiiik = CurTime()
hook.Add( "InputMouseApply", "wemodifythemouse", function( cmd, x, y, angle )
	if !(CamStyle == 2) and cmd:GetMouseWheel() != 0 then
		local whe = cmd:GetMouseWheel()
		if !LocalPlayer():KeyDown( IN_WALK ) then
			if whe < 0 and !(CamStyle == 1) then CamStyle = 1 welook = LocalPlayer():EyeAngles() end
			wedist = math.Clamp(wedist - (whe * 20), 0, 1000)
			if CurTime() > (tiiik + 0.006) then surface.PlaySound("es13/ui/SWITCH3.wav") end
			tiiik = CurTime()
			if whe > 0 and wedist == 0 then CamStyle = 0 end
		end
	end
	if (CamStyle == 1) and !wedrag then
		welook.x = welook.x + (y * 0.022)
		welook.y = welook.y + (x * -0.022)
		welook:Normalize()
		x = 0
		y = 0
		cmd:SetMouseX( 0 )
		cmd:SetMouseY( 0 )

		if !input.IsMouseDown( MOUSE_MIDDLE ) then
			return true
		end
	end
end )

hook.Add("PreDrawEffects", "ES_" .. "PreDrawEffects", function()
	local p = LocalPlayer()
	local w = p:GetActiveWeapon()

	if IsValid(w) and w:GetClass() == "es_weaponhandler" and (CamStyle == 0) then
		for i=1, 3 do
			local vm = w.VMT[i]

			if IsValid(vm) then
				cam.Start3D(nil, nil, nil)
					cam.IgnoreZ(true)
					
						vm:SetPos(EyePos())
						vm:SetAngles(EyeAngles())
						vm:DrawModel()

					cam.IgnoreZ(false)
				cam.End3D()
			end
		end
	end

	if false then -- !(CamStyle == 1) and p:Alive() then
		if IsValid(leg) then
			leg:SetSequence(p:GetSequence())
			leg:SetCycle(p:GetCycle())
			
			leg:SetPoseParameter("move_x",		p:GetPoseParameter("move_x"))
			leg:SetPoseParameter("move_y",		p:GetPoseParameter("move_y"))
			leg:SetPoseParameter("aim_yaw",		p:GetPoseParameter("aim_yaw"))
			leg:SetPoseParameter("aim_pitch",	p:GetPoseParameter("aim_pitch"))
			leg:SetPoseParameter("head_yaw",	p:GetPoseParameter("head_yaw"))
			leg:SetPoseParameter("head_pitch",	p:GetPoseParameter("head_pitch"))
			leg:SetPoseParameter("move_yaw",	p:GetPoseParameter("move_yaw"))
			leg:SetPoseParameter("body_yaw", 	p:GetPoseParameter("body_yaw"))
			leg:SetPoseParameter("spine_yaw",	p:GetPoseParameter("spine_yaw"))
			
			for i = 0, leg:GetBoneCount() do 
				leg:ManipulateBoneScale(i, Vector(1, 1, 1))
				leg:ManipulateBonePosition(i, Vector(0, 0, 0))
			end
			for k, v in pairs(bonestoremove) do
				local bone = leg:LookupBone(v)
				if (bone) then
					leg:ManipulateBoneScale(bone, Vector(0, 0, 0))
					leg:ManipulateBonePosition(bone, Vector(-100000000, -100000000, 0))
				end
			end
			for k, v in pairs(bonestoremove2) do
				local bone = leg:LookupBone(v)
				if (bone) then
					leg:ManipulateBoneScale(bone, Vector(0, 0, 0))
				end
			end

			cam.Start3D(EyePos(), EyeAngles(), 75)
				cam.IgnoreZ(true)
				
					local pos = p:GetPos()
					pos = pos + Vector(0, 0, -30)
					local ang = p:GetAngles()
					ang.p = 0

					leg:SetPos(pos)
					leg:SetAngles(ang)
					leg:DrawModel()
					leg:CreateShadow()
				cam.IgnoreZ(false)
			cam.End3D()
		else
			legsinit()
		end
	end
end)

local lasttimelanded = 0
function GM:OnPlayerHitGround( ply, inWater, onFloater, speed )
	lasttimelanded = CurTime()
end

function GM:CalcView( ply, pos, angles, fov )
	if ply:Alive() then
		local at = ply:GetAttachment(ply:LookupAttachment("eyes"))

		local hul = 3
		local tr = util.TraceHull({
			start = pos,
			endpos = at.Pos,
			mask = MASK_SOLID,
			filter = {ply},
			mins = Vector( -hul, -hul, -hul ),
			maxs = Vector( hul, hul, hul ),
		})
		
		local amt = math.abs(angles.p)/90
		local amt2 = 1-(math.abs(angles.p)/90)

		local timb = math.Clamp(CurTime() - lasttimelanded, 0, 0.5)*2

		local view = {
			origin = (pos*amt2)+(at.Pos*amt),
			angles = angles,--at.Ang,
			--fov = 90,
			drawviewer = false,
		}
		if !ply:OnGround() then
			view.origin = at.Pos
		end
		view.origin = (at.Pos*(1-timb)) + (view.origin*(timb))
		view.origin = (view.origin)*(tr.Fraction) + ((pos)*(1-tr.Fraction))

		if (CamStyle == 4) then
			
			-- Orthographic
			--[[ply:SetEyeAngles( Angle(0, ply:EyeAngles().y, 0) )
			view.angles = Angle( 90, 90, 0 )
			local posInQuotationMarks = Vector( ply:GetPos().x, ply:GetPos().y, 0 )
			view.origin = posInQuotationMarks + Vector( 0, 0, 1024 )

			local cx = (512-32) * (ScrW()/ScrH())
			local cy = 512-32

			view.ortho = { left = -cx, right = cx, top = -cy, bottom = cy }]]
			--view.origin = posInQuotationMarks + Vector( 1*1024, -1*1024, 1*900 )
			--view.angles = Angle( 30, 90+45, 0 )
		elseif (CamStyle == 3) then
		elseif (CamStyle == 2) then
			ply:SetEyeAngles( Angle(0, ply:EyeAngles().y, 0) )

			view.drawviewer = true
			view.angles = Angle( 90, 90, 0 )
			view.fov = 64--loost[1]
			--view.fov = 102
			--view.fov = Convert( 64, (9/16) ) -- Punish widescreen

			local posInQuotationMarks = ply:GetPos() - Vector( 0, 0, 0.031250 ) --Vector( ply:GetPos().x, ply:GetPos().y, 0 )
			view.origin = posInQuotationMarks + Vector( 0, 0, 1024 )
			--view.origin = posInQuotationMarks + Vector( 0, 0, 512 )
		elseif (CamStyle == 1) then
			view.drawviewer = true
			view.angles = welook

			local hul = 4
			local tr = util.TraceHull({
				start = pos,
				endpos = at.Pos - (welook:Forward()*wedist),
				mask = MASK_SOLID,
				filter = {ply},
				mins = Vector( -hul, -hul, -hul ),
				maxs = Vector( hul, hul, hul ),
			})

			view.origin = at.Pos - (welook:Forward()*wedist)
			if tr.Hit then
				view.origin = tr.HitPos
			end
		end

		return view
	end
end

-- translucent	2097152
-- additive		128
-- alphatest	256
local MatB = Material( "es13/shit/parallax.png" )
local FlagBase = MatB:GetInt("$flags")

-- Layer 1, Spacedust
local Mat1 = Material( "es13/shit/p1.png" )
Mat1:SetInt( "$flags", FlagBase + 128 )

-- Planet
local Mat2 = Material( "es13/shit/p2.png" )
Mat2:SetInt( "$flags", FlagBase + 2097152 )

-- Layer 2, Starfield
local Mat3 = Material( "es13/shit/p3.png" )
Mat3:SetInt( "$flags", FlagBase + 128 )

-- Asteroids
local Mat4 = Material( "es13/shit/p4.png" )
Mat4:SetInt( "$flags", FlagBase + 128 )

-- Space gas
local Mat5 = Material( "es13/shit/p5.png" )
Mat5:SetInt( "$flags", FlagBase + 128 )

-- Layer 3, Insane twinkles
local Mat6 = Material( "es13/shit/p6.png" )
Mat6:SetInt( "$flags", FlagBase + 128 )

local gascolor = {
	Color( 51, 204, 204 ),
	Color( 0, 255, 0 ),
	Color( 192, 192, 192 ),
	Color( 255, 255, 0 ),
	Color( 0, 255, 255 ),
	Color( 255, 153, 0 ),
	Color( 128, 0, 128 ),
}

gascolor = gascolor[math.random(1, #gascolor)]

hook.Add("PostDraw2DSkyBox", "ParallaxSpace", function()

	local ply = LocalPlayer()
	local mov = -Vector( ply:GetPos().x, ply:GetPos().y, 0 )

--    render.OverrideDepthEnable( true, false ) -- ignore Z to prevent drawing over 3D skybox

    -- Start 3D cam centered at the origin
    cam.Start3D( Vector( 0, 0, 0 ), EyeAngles() )

		local dist = Vector( -(1/64)*7*512, -(1/64)*7*512, -512 )
		local norm = Vector(0,0,1)
		local si

		-- Layer 1, Spacedust
		si = 1000
		render.SetMaterial( Mat1 )
		render.DrawQuadEasy( ( Vector( 0, 0, -6 ) + dist ) + (mov*(1/64))*0.6, norm, si, si, color_white, 90 )

		-- Layer 2, Starfield
		si = 1000
		render.SetMaterial( Mat3 )
		render.DrawQuadEasy( ( Vector( 0, 0, -5 ) + dist ) + (mov*(1/64))*1, norm, si, si, color_white, 90 )

		-- Layer 3, Insane twinkles
		si = 1000
		render.SetMaterial( Mat6 )
		render.DrawQuadEasy( ( Vector( 0, 0, -4 ) + dist ) + (mov*(1/64))*1.4, norm, si, si, color_white, 90 )
		
		-- Asteroids
		si = 1000
		render.SetMaterial( Mat4 )
		render.DrawQuadEasy( ( Vector( 0, 0, -3 ) + dist ) + (mov*(1/64))*3, norm, si, si, color_white, 90 )

		-- Space gas
		si = 1000
		render.SetMaterial( Mat5 )
		render.DrawQuadEasy( ( Vector( 0, 0, -2 ) + dist ) + (mov*(1/64))*3, norm, si, si, gascolor, 90 )

		-- Lavaland
		si = 500
		render.SetMaterial( Mat2 )
		render.DrawQuadEasy( ( Vector( 0, 0, -1 ) + dist ) + (mov*(1/64))*3, norm, si, si, color_white, 90 )
    cam.End3D()

	return true
 --   render.OverrideDepthEnable( false, false )
end)



--[[function GM:CalcView( ply, pos, angles, fov )
	pos.z = 3000 * (wedist/1000)
	local view = {
		origin = pos,
		angles = Angle(90, 90, 0),
		fov = 75,
		drawviewer = true,
	}

	return view
end]]

function Convert( fov, asp )
	local result
	local fovrad = math.rad(fov)
	result = 2 * math.atan( math.tan( fovrad / 2 ) * asp )

	return math.deg( result )
end

function ScaleFOVByWidthRatio( fovDegrees, ratio )
	local halfAngleRadians = fovDegrees * ( 0.5 * math.pi / 180 )
	local t = math.tan( halfAngleRadians )
	t = t * ratio
	local retDegrees = ( 180 / math.pi ) * math.atan( t )
	return retDegrees * 2
end

--[[

	16:9
		106
		74

	4:3
		90
		74

]]

if !true then
	local Boopity = vgui.Create("DFrame")
	Boopity:SetPos(100, 100)
	Boopity:SetSize(300, 200)
	Boopity:SetTitle("Inspecting <Your Item>")

	local left = vgui.Create( "SpawnIcon", Boopity )
	left:SetModel( "models/props_borealis/bluebarrel001.mdl" )
	left:SetPos( 4, 24 + 4 )
	left:SetSize( 128, 128 )

	local sdesc = vgui.Create( "DLabel", Boopity )
	sdesc:SetPos( 4 + 128 + 4, 24 )
	sdesc:SetSize( 128, 32 )
	sdesc:SetText( "Looks pretty dumb." )

	local desc = vgui.Create( "DLabel", Boopity )
	desc:SetPos( 4 + 4, 128 + 24 + 4 )
	desc:SetSize( 256, 32 )
	desc:SetText( "That is <Your Item>." )
end