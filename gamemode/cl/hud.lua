
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
		size = ESS(18),
		weight = 0,
		antialias = true,
	},
	["ES_C44"] = {
		font = "Consolas",
		size = ESS(38),
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
	ES:dText(((CamStyle == 2) and "God-cam" or (CamStyle == 1) and "Third-person" or "First-person"), vi.x+vi.w/2, vi.y+(vi.h/2), {w=2, h=2})

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

			local rhi = { x = 0, y = ScrH(), w = ESS(18), h = ESS(50) }
			if !st["Weapon"] then rhi.h = ESS(30) end
			--rhi.x = rhi.x - rhi.w - g1
			rhi.x = (ScrW()/2) + ESS(70)
			rhi.y = rhi.y - rhi.h - g1
			
			surface.SetFont("ES_C22")
			local siz = surface.GetTextSize(st["Print Name"] or "???")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(rhi.x + ESS(9), rhi.y + ESS(4))
			
			if !p:GetHand() then draw.RoundedBox(ESS(11), rhi.x - (g2), rhi.y - (g2), rhi.w + siz + (g2*2), rhi.h + (g2*2), Color(255, 255, 255, 32)) end
			draw.RoundedBox(ESS(10), rhi.x, rhi.y, rhi.w +siz, rhi.h, Color(0, 0, 0, 128))
			surface.DrawText(st["Print Name"] or "???")

			if st["Weapon"] then
				surface.SetFont("ES_C44")
				surface.SetTextColor(255, 255, 255, 255)
				surface.SetTextPos(rhi.x + ESS(8), rhi.y + ESS(12))
				surface.DrawText(w:Clip1())
			end
		end

		if p.GetWEPLH and p:GetWEPLH() and ES:GetWeaponInfo(p:GetWEPLH()) then
			-- TODO: cache this
			local st = ES:GetWeaponInfo(p:GetWEPLH())

			local lhi = { x = 0, y = ScrH(), w = ESS(18), h = ESS(50) }
			if !st["Weapon"] then lhi.h = ESS(25) end
			lhi.x = (ScrW()/2) - ESS(70) - lhi.w
			lhi.y = lhi.y - lhi.h - g1

			surface.SetFont("ES_C22")
			local siz = surface.GetTextSize(st["Print Name"] or "???")
			surface.SetTextColor(255, 255, 255, 255)
			surface.SetTextPos(lhi.x + ESS(9) - siz, lhi.y + ESS(4))

			if p:GetHand() then draw.RoundedBox(ESS(11), lhi.x - siz - (g2), lhi.y - (g2), lhi.w + siz + (g2*2), lhi.h + (g2*2), Color(255, 255, 255, 32)) end
			draw.RoundedBox(ESS(10), lhi.x - siz, lhi.y, lhi.w + siz, lhi.h, Color(0, 0, 0, 128))
			surface.DrawText(st["Print Name"] or "???")

			if st["Weapon"] then
				surface.SetFont("ES_C44")
				local siz = surface.GetTextSize(w:Clip2())

				surface.SetTextColor(255, 255, 255, 255)
				surface.SetTextPos(lhi.x + lhi.w - ESS(8) - siz, lhi.y + ESS(12))
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

	local w, h = 1600, 900
	if false and (CamStyle == 2) and (w > h)  then -- Make sure you aren't playing the iOS version, of course
		local thing = (w - h) / 2

		surface.SetDrawColor(0, 0, 0, 255)
		surface.DrawRect(0, 0, thing, h)

		surface.DrawRect(ScrW()-thing, 0, thing, h)
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

hook.Add( "HUDShouldDraw", "ES13_HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )


hook.Add( "SetupWorldFog", "ES13_Blindness", function()
	if false then--(CamStyle != 2) then
		render.FogStart(0)
		render.FogEnd(32*15) -- 3x3
		render.SetFogZ(32*3)
		render.FogColor(0, 0, 0)
		render.FogMaxDensity(1)
		render.FogMode(MATERIAL_FOG_LINEAR)
		return true
	end
end)