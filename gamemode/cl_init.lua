
include( "shared.lua" )

if godcam == nil then godcam = false end

local rblxstyle = false
if CamStyle == nil then CamStyle = 0 end
-- 0 : First-person
-- 1 : Third-person
-- 2 : Top-down
-- 3 : Fixed, unimplemented
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
	--[[if LocalPlayer():IsValid() and ( LocalPlayer():KeyPressed( IN_WALK ) ) then
		rblxstyle = !rblxstyle
		welook = LocalPlayer():EyeAngles()
		--gui.EnableScreenClicker(rblxstyle)
	end]]
	if rblxstyle then
		if !input.IsMouseDown( MOUSE_RIGHT ) and !input.IsMouseDown( MOUSE_MIDDLE ) then
			wedrag = true
		else
			wedrag = false
		end
		--gui.EnableScreenClicker(wedrag)
	end
end )

function GM:OnSpawnMenuOpen()
	gui.EnableScreenClicker(true)
end

function GM:OnSpawnMenuClose()
	gui.EnableScreenClicker(false)
end

local tiiik = CurTime()
hook.Add( "InputMouseApply", "wemodifythemouse", function( cmd, x, y, angle )
	if !godcam and cmd:GetMouseWheel() != 0 then
		local whe = cmd:GetMouseWheel()
		if !LocalPlayer():KeyDown( IN_WALK ) then
			if whe < 0 and !rblxstyle then rblxstyle = true welook = LocalPlayer():EyeAngles() end
			wedist = math.Clamp(wedist - (whe * 20), 0, 1000)
			if CurTime() > (tiiik + 0.006) then surface.PlaySound("es13/ui/SWITCH3.wav") end
			tiiik = CurTime()
			if whe > 0 and wedist == 0 then rblxstyle = false end
		end
	end
	if rblxstyle and !wedrag then
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

	if IsValid(w) and w:GetClass() == "es_weaponhandler" and !rblxstyle then
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

	if false then -- !rblxstyle and p:Alive() then
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

		if godcam then
			
			-- Orthographic
			--[[ply:SetEyeAngles( Angle(0, ply:EyeAngles().y, 0) )
			view.angles = Angle( 90, 90, 0 )
			local posInQuotationMarks = Vector( ply:GetPos().x, ply:GetPos().y, 0 )
			view.origin = posInQuotationMarks + Vector( 0, 0, 1024 )

			local cx = (512-32) * (ScrW()/ScrH())
			local cy = 512-32

			view.ortho = { left = -cx, right = cx, top = -cy, bottom = cy }]]

			ply:SetEyeAngles( Angle(0, ply:EyeAngles().y, 0) )
			rblxstyle = false

			view.drawviewer = true
			view.angles = Angle( 90, 90, 0 )
			--view.angles = Angle( 30, 90+45, 0 )
			view.fov = 64--Convert( 64, (9/16) )

			local posInQuotationMarks = Vector( ply:GetPos().x, ply:GetPos().y, 0 )
			view.origin = posInQuotationMarks + Vector( 0, 0, 1024 )
			--view.origin = posInQuotationMarks + Vector( 1*1024, -1*1024, 1*900 )
		elseif rblxstyle then
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

function ESS( size )
	return size * ( math.min( ScrW(), ScrH() ) / 480 )	
end

local fonts = {
	["ES_C12"] = {
		font = "Consolas",
		size = ESS(12),
		weight = 0,
		antialias = true,
	},
	["ES_C16"] = {
		font = "Consolas",
		size = ESS(16),
		weight = 0,
		antialias = true,
	},
	["ES_C22"] = {
		font = "Consolas",
		size = ESS(22),
		weight = 0,
		antialias = true,
	},
	["ES_C44"] = {
		font = "Consolas",
		size = ESS(44),
		weight = 0,
		antialias = true,
	},
}

for i, v in pairs(fonts) do
	surface.CreateFont( i, v )
end

function ES:dText(text, x, y, align)
	local tw, th = surface.GetTextSize(text)
	local x, y = x, y

	if align then
		if align.w then
			if align.w == 1 then -- left
				-- lol
			elseif align.w == 2 then -- centered
				x = x - (tw/2)
			elseif align.w == 3 then -- right
				x = x - tw
			end
		end
		if align.h then
			if align.h == 1 then -- left
				-- lol
			elseif align.h == 2 then -- centered
				y = y - (th/2)
			elseif align.h == 3 then -- right
				y = y - th
			end
		end
	end
	surface.SetTextPos(x, y)

	surface.DrawText(text)
end

local cachedstats = {
	[1] = {},
	[2] = {},
}

local g1 = ESS(10)
local g2 = ESS(2)

hook.Add("HUDPaint", "ES_HUDPaint", function()
	surface.SetDrawColor(0, 0, 0, 63)

	local p = LocalPlayer()
	local w = p:GetActiveWeapon()

	--[[surface.SetFont("ES_C16")
	surface.SetTextColor(color_white)
	ES:dText(CurTime(), ScrW()/2, 16, {w=2, h=2})
	ES:dText(lasttimelanded, ScrW()/2, 64, {w=2, h=2})]]

	local vi = { x = ScrW()/2, y = ScrH(), w = ESS(128), h = ESS(16) }
	vi.x = vi.x - (vi.w/2)
	vi.y = vi.y - vi.h - g1
	draw.RoundedBox(ESS(10), vi.x, vi.y, vi.w, vi.h, Color(0, 0, 0, 127))
	surface.SetFont("ES_C16")
	surface.SetTextColor(color_white)
	ES:dText((godcam and "God-cam" or rblxstyle and "Third-person" or "First-person"), vi.x+vi.w/2, vi.y+(vi.h/2), {w=2, h=2})

	vi.w = (vi.w/2)
	vi.x = vi.x + (vi.w/2)
	vi.y = vi.y - ESS(18)
	draw.RoundedBox(ESS(10), vi.x, vi.y, vi.w, vi.h, Color(0, 0, 0, 127))
	ES:dText("+ " .. p:Health(), vi.x+vi.w/2, vi.y+(vi.h/2), {w=2, h=2})

	surface.SetFont("ES_C12")
	vi.w = (vi.w/2)
	vi.x = vi.x + (vi.w*2)
	draw.RoundedBox(ESS(10), vi.x, vi.y, vi.w, vi.h, Color(0, 0, 0, 127))
	ES:dText(p:Ping().."ms", vi.x+(vi.w/2), vi.y+(vi.h/2), {w=2, h=2})
	
	vi.x = vi.x - (vi.w*3)
	draw.RoundedBox(ESS(10), vi.x, vi.y, vi.w, vi.h, Color(0, 0, 0, 127))

	local amt = ""
	for i = 1, LocalPlayer():GetDesiredSpeed() do
		amt = amt .. "|"
	end
	for i = 1, 3-LocalPlayer():GetDesiredSpeed() do
		amt = amt .. "-"
	end
	ES:dText(amt, vi.x+(vi.w/2), vi.y+(vi.h/2), {w=2, h=2})

	if IsValid(w) and w:GetClass() == "es_weaponhandler" then

		if p.GetWEPRH and p:GetWEPRH() and ES:GetWeaponInfo(p:GetWEPRH()) then
			-- TODO: cache this
			local st = ES:GetWeaponInfo(p:GetWEPRH())

			local rhi = { x = ScrW(), y = 0, w = ESS(158), h = ESS(60) }
			if !st["Weapon"] then rhi.h = ESS(30) end
			rhi.x = rhi.x - rhi.w - g1
			rhi.y = g1
			if !p:GetHand() then draw.RoundedBox(ESS(11), rhi.x - (g2), rhi.y - (g2), rhi.w + (g2*2), rhi.h + (g2*2), Color(255, 255, 255, 32)) end
			draw.RoundedBox(ESS(10), rhi.x, rhi.y, rhi.w, rhi.h, Color(0, 0, 0, 128))

			surface.SetFont("ES_C22")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(rhi.x + ESS(9), rhi.y + ESS(4))

			surface.DrawText(st["Print Name"] or "???")

			if st["Weapon"] then
				surface.SetFont("ES_C44")
				surface.SetTextColor(255, 255, 255, 255)
				surface.SetTextPos(rhi.x + ESS(8), rhi.y + ESS(16))
				surface.DrawText(w:Clip1())
			end
		end

		if p.GetWEPLH and p:GetWEPLH() and ES:GetWeaponInfo(p:GetWEPLH()) then
			-- TODO: cache this
			local st = ES:GetWeaponInfo(p:GetWEPLH())

			local lhi = { x = 0, y = 0, w = ESS(158), h = ESS(60) }
			if !st["Weapon"] then lhi.h = ESS(30) end
			lhi.x = g1
			lhi.y = g1
			if p:GetHand() then draw.RoundedBox(ESS(11), lhi.x - (g2), lhi.y - (g2), lhi.w + (g2*2), lhi.h + (g2*2), Color(255, 255, 255, 32)) end
			draw.RoundedBox(ESS(10), lhi.x, lhi.y, lhi.w, lhi.h, Color(0, 0, 0, 128))

			surface.SetFont("ES_C22")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(lhi.x + ESS(9), lhi.y + ESS(4))

			surface.DrawText(st["Print Name"] or "???")

			if st["Weapon"] then
				surface.SetFont("ES_C44")
				surface.SetTextColor(255, 255, 255, 255)
				surface.SetTextPos(lhi.x + ESS(8), lhi.y + ESS(16))
				surface.DrawText(w:Clip2())
			end
		end
	else
		surface.SetFont("ES_C22")
		surface.SetTextColor(255, 255, 255, 255)
		surface.SetTextPos(ScrW()/2 - ESS(110), ESS(16))

		surface.DrawText("Weapon handler not found")
	end

	if !true then
		local E = 0
		local T = {}

		if w.LinkedCLMDLS then
			table.Merge(T, w.LinkedCLMDLS)
		end
		if w.t_WEPRH then
			table.Merge(T, w.t_WEPRH)
		end
		if w.GetWEPRH then
			T["H-l"] = w:GetWEPLH()
			T["H-r"] = w:GetWEPRH()
		end
		for i, v in pairs(T) do
			surface.SetFont("ES_C12")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(8, 8 + E)
			surface.DrawText(tostring(i))
			surface.SetTextPos(32, 24 + E)
			surface.DrawText(tostring(v))
			E = E + 40
		end
	end

	-- crosshair code
	local x, y = ScrW()/2, ScrH()/2
	local ts = p:GetEyeTrace().HitPos:ToScreen()
	x, y = ts.x, ts.y
	x, y = x + 2, y + 2

	local gap = 4
	local length = 3
	local thick = 2 
	local sg = 1

	surface.SetDrawColor(0, 0, 0, 127)

	x, y = x + sg, y + sg
	-- bottom
	surface.DrawRect(x - (thick/2), y + gap, thick, length)

	-- right
	surface.DrawRect(x + gap, y - (thick/2), length, thick)

	-- top
	surface.DrawRect(x - (thick/2), y - gap - length, thick, length)

	-- left
	surface.DrawRect(x - gap - length, y - (thick/2), length, thick)

	
	x, y = x - sg, y - sg
	surface.SetDrawColor(255, 255, 255, 255)

	-- bottom
	surface.DrawRect(x - (thick/2), y + gap, thick, length)

	-- right
	surface.DrawRect(x + gap, y - (thick/2), length, thick)

	-- top
	surface.DrawRect(x - (thick/2), y - gap - length, thick, length)

	-- left
	surface.DrawRect(x - gap - length, y - (thick/2), length, thick)

	
	-- crosshair code
	local x, y = ScrW()/2, ScrH()/2
	local tr = p:GetEyeTrace()

	

	local gap = 4
	local length = 3
	local thick = 2
	local sg = 1

	local tr2
	for i=1, 5 do
		tr2 = util.TraceLine({
			start = p:EyePos(),
			endpos = p:EyePos() + ( p:EyeAngles():Forward() * (tr.HitPos:Distance(tr.StartPos)/5)*(i-0.5) ),
			filter = p
		})

		local ts = tr2.HitPos:ToScreen()--((tr.HitPos:Distance(tr.StartPos)/2)*LocalPlayer():EyeAngles():Forward()):ToScreen()
		x, y = ts.x, ts.y
		x, y = x + 3, y + 3

		-- mid
		surface.SetDrawColor(0, 0, 0, 127*(i/5))
		surface.DrawRect(x - (thick/2), y - (thick/2), thick, thick)

		x, y = x - sg, y - sg
		surface.SetDrawColor(255, 255, 255, 255*(i/5))
		surface.DrawRect(x - (thick/2), y - (thick/2), thick, thick)
	end


	
end)

local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudAmmo"] = true,
	["CHudDamageIndicator"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudSquadStatus"] = true,
	["CHudVehicle"] = true,
	["CHudZoom"] = true,
	["CHUDQuickInfo"] = true,
	["CHudSuitPower"] = true,
	["CHudWeaponSelection"] = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )


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