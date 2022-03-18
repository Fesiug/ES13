

surface.CreateFont( "ES13_TargetID", {
	font = "Verdana",
	size = ScreenScale(16),
	bold = true
} )

surface.CreateFont( "ES13_TargetIDSmall", {
	font = "Verdana",
	size = ScreenScale(12)
} )

function GM:HUDDrawTargetID()

	local ss = ScreenScale(1)

	local tr = util.GetPlayerTrace( LocalPlayer() )
	local trace = util.TraceLine( tr )
	if ( !trace.Hit ) then return end
	if ( !trace.HitNonWorld ) then return end
	
	local text = "ERROR"
	local font = "ES13_TargetID"
	
	if ( trace.Entity:IsPlayer() ) then
		text = trace.Entity:Nick()
	elseif trace.Entity.GetPrintName then
		text = trace.Entity:GetPrintName()
	elseif trace.Entity.PrintName then
		text = trace.Entity.PrintName
	else
		text = trace.Entity:GetClass()
	end
	
	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )
	
	local MouseX, MouseY = ScrW()/2, ss*20
	
	local x = MouseX
	local y = MouseY
	
	x = x - w / 2
	--y = y + ScreenScale(30)
	
	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, color_white )
	
	--y = y + h + (ss*0)

	--[[if trace.Entity.Health and trace.Entity:Health() > 0 then
	
		local text = trace.Entity:Health() .. "%"
		local font = "ES13_TargetIDSmall"
		
		surface.SetFont( font )
		local w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
		
		draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, color_white )

	end]]

	y = y + h + (ss*0)
	if trace.Entity.GetHP_Brute then
		local text = math.Round(trace.Entity:GetHP_Brute(), 1) .. "%"
		local font = "ES13_TargetIDSmall"
		
		surface.SetFont( font )
		w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
		
		draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, Color(255, 200, 200, 255) )
	end

	y = y + h + (ss*0)
	if trace.Entity.GetHP_Burn then
		local text = math.Round(trace.Entity:GetHP_Burn(), 1) .. "%"
		local font = "ES13_TargetIDSmall"
		
		surface.SetFont( font )
		w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
		
		draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, Color(255, 255, 200, 255) )
	end

	y = y + h + (ss*0)
	if trace.Entity.GetHP_Toxins then
		local text = math.Round(trace.Entity:GetHP_Toxins(), 1) .. "%"
		local font = "ES13_TargetIDSmall"
		
		surface.SetFont( font )
		w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
		
		draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, Color(200, 255, 200, 255) )
	end

	y = y + h + (ss*0)
	if trace.Entity.GetHP_Oxygen then
		local text = math.Round(trace.Entity:GetHP_Oxygen(), 1) .. "%"
		local font = "ES13_TargetIDSmall"
		
		surface.SetFont( font )
		w, h = surface.GetTextSize( text )
		local x = MouseX - w / 2
		
		draw.SimpleText( text, font, x + (ss*1), y + (ss*1), Color( 0, 0, 0, 120 ) )
		draw.SimpleText( text, font, x + (ss*2), y + (ss*2), Color( 0, 0, 0, 50 ) )
		draw.SimpleText( text, font, x, y, Color(200, 200, 255, 255) )
	end

end
