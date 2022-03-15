
if myChat and IsValid(mychat) then myChat:Remove() end
if god and IsValid(god) then god:Remove() end


god = vgui.Create("DFrame")
god:SetSize(500, 200)
god:SetPos(100, 100)
--god:Dock(RIGHT)
god:SetSizable( true )
god:SetDraggable( true )
god:SetTitle("Chat and History")
god:SetDeleteOnClose(false)
god.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 255, 255, 255, 20 ) )
	
	draw.RoundedBox( 0, 0, 0, w, 25, Color( 80, 80, 80, 20 ) )
end
god:Close()


--local LeftPanel = vgui.Create( "DPanel", god ) -- Can be any panel, it will be stretched
--local RightPanel = vgui.Create( "DPanel", god )

local frame = vgui.Create("DPanel", god)
--frame:SetSize(32, 0)
frame:Dock(FILL)
--frame:SetSizable( true )
--frame:SetDraggable( true )
--frame:MakePopup()
--frame:ShowCloseButton(false)
--frame:SetTitle("")
--frame:SetDeleteOnClose(false)

--[[local div = vgui.Create( "DVerticalDivider", god )
div:Dock( FILL ) -- Make the divider fill the space of the DFrame
div:SetTop( LeftPanel ) -- Set what panel is in left side of the divider
div:SetBottom( frame )
div:SetDividerHeight( 8 ) -- Set the divider width. Default is 8
div:SetTopMin( 20 ) -- Set the Minimum width of left side
div:SetBottomMin( 20 )
div:SetTopHeight( ScrH()/2.5 ) -- Set the default left side width]]

local deebug = [[
<h1 class='alert'>Central Command Report</h1>
<br><h2 class='alert body'>Nanotrasen Update</h2>
<br><span class="alert">not a fan of the Cyberiad</span>
<br>
<br><span class='userdanger'>The light burns you!</span>
<br><span class='danger'>You don't feel like yourself.</span>
<br><span class='userdanger'>Unknown has punched [target]!</span>
<br><span class='notice'>You hear something squeezing through the ducts...</span>
<br><span class='notice'>You hear a distant scream.</span>
<br><span class='notice'>You feel invincible, nothing can hurt you!</span>
<br><span class='warning'>You feel a tiny prick!</span>
<br><B>[target]</B> sneezes.
<br><span class='warning'>You feel faint.</span>
<br><span class='noticealien'>You hear a strange, alien voice in your head...</span> [pick("Hiss","Ssss")]
<br><span class='notice'>You can see...everything!</span>
<br>
]]
local preview = ""
local ehtml = vgui.Create( "DHTML", frame )
ehtml:Dock( FILL )
function ehtml:Updoot()
	ehtml:SetHTML( (dark and s_dark or s_light) .. deebug .. preview )
end
ehtml:Updoot()

local textentry = vgui.Create( "DTextEntry", frame )
textentry:Dock( BOTTOM )
textentry:SetPlaceholderText( "To chat click here or press the \"/\" key" )
textentry:SetUpdateOnType(true)
textentry.OnEnter = function( self )
	local channel	= GetBetaChannel("Nonexistant")
	local job		= GetBetaJob("Nonexistant")
	chat.AddText(
		{"IDK_b"}, channel.color, "[" .. (channel.name or "Truly Unknown Channel") .. "]" .. " ",
		{"IDK_b"}, job.color, "(" .. (job.name or "Truly Unknown Job") .. ")", {"IDK_b"}, job.color, " " .. LocalPlayer():Nick() .. " ",
		{"IDK"}, channel.color, "says" .. ", "
		.. "\"" .. self:GetText() .. "\""
	)
	--RunConsoleCommand( "say", self:GetValue() )
end

-- Chat implementation

myChat = {}

myChat.dFrame = frame
myChat.dTextEntry = textentry
myChat.dRichText = ehtml

god:MakePopup()
myChat.dTextEntry:RequestFocus()

function GM:OnContextMenuOpen()
	god:Show()
end

hook.Add( "PlayerBindPress", "overrideChatbind", function( ply, bind, pressed )
    local bTeam = false
    if bind == "messagemode" then
    elseif bind == "messagemode2" then
        bTeam = true
    else
        return
    end

    myChat.openChatbox( bTeam )

    return true -- Doesn't allow any functions to be called for this bind
end )

hook.Add( "ChatText", "serverNotifications", function( index, name, text, type )
    if type == "joinleave" or type == "none" then
        --myChat.dRichText:AppendText( text .. "\n" )
    end
end )

local BetaChannels =
{
	["common"] = {
		name = "Common",
		color = Color(64, 128, 16),
		style = "radio",
	},
	["security"] = {
		name = "Security",
		color = Color(64, 128, 16),
		style = "secradio",
	},
}

local BetaColors = {
	["service"] = {
		name = "Common",
		color = Color(64, 128, 16),
	},
}

local BetaJobs =
{
	["assistant"] = {
		name = "Assistant",
		color = Color(64, 128, 16),
		style = "radio",
	},
	["ai"] = {
		name = "AI",
		color = Color(255, 0, 255),
		style = "airadio",
	},
}

function GetBetaChannel( item )
	if !BetaChannels[ item ] then
		return {
			name = "Undefined Channel",
			color = BetaColors["service"].color,
			style = "radio"
		}
	else
		return BetaChannels[ item ]
	end
end

function GetBetaJob( item )
	if !BetaJobs[ item ] then
		return {
			name = "Undefined Job",
			color = BetaColors["service"].color,
			style = "radio"
		}
	else
		return BetaJobs[ item ]
	end
end

local FontsToCreate =
{
	["IDK"] = {
		font = "Verdana",
		size = 18
	},
}

for i, v in pairs(FontsToCreate) do
	surface.CreateFont( i, v )
	--print("[fonts] created " .. i)

	local ip = i .. "_b"
	v.weight = 1000
	surface.CreateFont( ip, v )
	--print("[fonts] created " .. ip)

	ip = i .. "_i"
	v.weight = 0
	v.italic = true
	surface.CreateFont( ip, v )
	--print("[fonts] created " .. ip)

	ip = i .. "_bi"
	v.weight = 1000
	v.italic = true
	surface.CreateFont( ip, v )
	--print("[fonts] created " .. ip)
end


local we = { ["!"] = {"exclaims", "shouts", "yells"}, ["?"] = {"asks"} }
myChat.dTextEntry.OnValueChange = function( self, code )
	--[[if code == KEY_ESCAPE then
		myChat.closeChatbox()
		gui.HideGameUI()
	elseif code == KEY_ENTER then
		if string.Trim( self:GetText() ) != "" then


			chat.AddText(
				{"IDK_b"}, d["color"], "[" .. (d["name"] or "IDK BRU") .. "]" .. "\t ",
				{"IDK_b"}, u["color"], "(" .. (u["name"] or "missing") .. ")", {"IDK_b"}, u["color"], " " .. LocalPlayer():Nick() .. "\t ",
				{"IDK"}, d["color"], "says" .. ", "
				.. "\"" .. self:GetText() .. "\""
			)

		end
		myChat.closeChatbox()
	end]]
	local chan = GetBetaChannel()
	local u = GetBetaJob()

	-- Job
	local spoinks = string.Right(self:GetText(), 1)
	--print(spoinks)
	preview = "<span class='" .. chan.style .. "'>[<b>" .. chan.name .. "</b>]</span>"
	preview = preview .. " <span class='" .. u.style .. "'>[" .. u.name .. "] <span class='name'>" .. LocalPlayer().dna.name .. "</span></span>"
	preview = preview .. "<span class='" .. chan.style .. "'>"
	preview = preview .. " " .. (we[spoinks] and table.Random(we[spoinks]) or "says") .. ", "
	preview = preview .. "\"" .. self:GetText() .. "\""
	preview = preview .. "</span><br>"

	myChat.dRichText:Updoot()
	myChat.dRichText:GotoTextEnd()
end

function myChat.openChatbox()
	-- Stuff

	-- MakePopup calls the input functions so we don't need to call those
	--myChat.dFrame:Show()
	--myChat.dRichText:GotoTextEnd()

	hook.Run( "StartChat" )

	-- More stuff
end

function myChat.closeChatbox()
	-- Stuff

	-- Give the player control again
	--god:SetMouseInputEnabled( false )
	--god:SetKeyboardInputEnabled( false )
	--gui.EnableScreenClicker( false )
	--myChat.dFrame:Hide()
	
	-- We are done chatting
	hook.Run( "FinishChat" )
	
	-- Clear the text entry
	myChat.dTextEntry:SetText( "" )
	hook.Run( "ChatTextChanged", "" )

	-- More stuff
end

if !oldAddText then oldAddText = chat.AddText end
function chat.AddText( ... )
	local args = {...} -- Create a table of varargs

	--[[for _, obj in ipairs( args ) do
		if type( obj ) == "table" then -- We were passed a color object
			if type(obj[1]) == "string" then
				myChat.dRichText:InsertFontChange( obj[1] )
			else
				myChat.dRichText:InsertColorChange( obj.r, obj.g, obj.b, 255 )
			end
		elseif type( obj ) == "string"  then -- This is just a string
			myChat.dRichText:AppendText( obj )
		elseif obj:IsPlayer() then
			myChat.dRichText:AppendText( obj:Nick() )
		end
	end

	-- Gotta end our line for this message
	myChat.dRichText:AppendText( "\n" )]]

	-- Call the original function
	oldAddText( ... )
end