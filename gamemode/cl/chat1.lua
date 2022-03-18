


BetaChannelsInfo =
{
	radio_min = 1200,
	radio_max = 1600,
	public_min = 1441,
	public_max = 1489,
}

local function hex2rgb(hex)
	hex = hex:gsub("#","")
	return Color( tonumber( "0x" .. hex:sub(1, 2) ), tonumber( "0x" .. hex:sub(3, 4) ), tonumber( "0x" .. hex:sub(5, 6) ) )
end
local colorlookup =
{
	["radio"]			=	hex2rgb("408010"),
	["deptradio"]		=	hex2rgb("993399"),
	["comradio"]		=	hex2rgb("204090"),
	["syndradio"]		=	hex2rgb("6D3F40"),
	["dsquadradio"]		=	hex2rgb("686868"),
	["resteamradio"]	=	hex2rgb("18BC46"),
	["airadio"]			=	hex2rgb("FF00FF"),
	["centradio"]		=	hex2rgb("5C5C7C"),
	["secradio"]		=	hex2rgb("A30000"),
	["engradio"]		=	hex2rgb("A66300"),
	["medradio"]		=	hex2rgb("009190"),
	["sciradio"]		=	hex2rgb("993399"),
	["supradio"]		=	hex2rgb("7F6539"),
	["srvradio"]		=	hex2rgb("80A000"),
	["proradio"]		=	hex2rgb("E3027A"),
}

BetaChannels =
{
	["common"] = {
		name = "Common",
		color = colorlookup["radio"],
		style = "radio",
		freq = 1459,
	},
	["security"] = {
		name = "Security",
		color = colorlookup["secradio"],
		style = "secradio",
		freq = 1359,
	},
		["security_internal"] = {
			name = "Security Internal",
			color = colorlookup["secradio"],
			style = "secradio",
			freq = 1475,
		},
	["command"] = {
		name = "Command",
		color = colorlookup["comradio"],
		style = "comradio",
		freq = 1353,
	},
	["ai"] = {
		name = "AI Private",
		color = colorlookup["airadio"],
		style = "airadio",
		freq = 1343,
	},
	["engineering"] = {
		name = "Engineering",
		color = colorlookup["engradio"],
		style = "engradio",
		freq = 1357,
	},
	["science"] = {
		name = "Science",
		color = colorlookup["sciradio"],
		style = "sciradio",
		freq = 1351,
	},
	["medical"] = {
		name = "Medical",
		color = colorlookup["medradio"],
		style = "medradio",
		freq = 1355,
	},
		["medical_internal"] = {
			name = "Medical Internal",
			color = colorlookup["medradio"],
			style = "medradio",
			freq = 1485,
		},
	["supply"] = {
		name = "Supply",
		color = colorlookup["supradio"],
		style = "supradio",
		freq = 1347,
	},
	["service"] = {
		name = "Service",
		color = colorlookup["srvradio"],
		style = "srvradio",
		freq = 1349,
	},
	["procedure"] = {
		name = "Procedure",
		color = colorlookup["proradio"],
		style = "proradio",
		freq = 1339,
	},
	["ert"] = {
		name = "Response Team",
		color = colorlookup["centradio"],
		style = "centradio",
		freq = 1345,
	},
	["dth"] = {
		name = "Special Ops",
		color = colorlookup["centradio"],
		style = "centradio",
		freq = 1341,
	},
	["synd"] = {
		name = "Syndicate",
		color = colorlookup["syndradio"],
		style = "syndradio",
		freq = 1213,
	},
	["syndteam"] = {
		name = "Syndicate Team",
		color = colorlookup["syndradio"],
		style = "syndradio",
		freq = 1244,
	},
}


BetaJobs =
{
	["command_captain"] = {
		name = "Captain",
		color = colorlookup["comradio"],
		style = "comradio",
	},
	["command_personnel"] = {
		name = "Head of Personnel",
		color = colorlookup["comradio"],
		style = "comradio",
	},
	["command_blueshield"] = {
		name = "Blueshield",
		color = colorlookup["comradio"],
		style = "comradio",
	},
	["command_representative"] = {
		name = "Nanotrasen Representative",
		color = colorlookup["comradio"],
		style = "comradio",
	},
	["assistant"] = {
		name = "Assistant",
		color = colorlookup["radio"],
		style = "radio",
	},
	["service_librarian"] = {
		name = "Librarian",
		color = colorlookup["srvradio"],
		style = "srvradio",
	},
	["ai"] = {
		name = "AI",
		color = colorlookup["airadio"],
		style = "airadio",
	},
	["security_officer"] = {
		name = "Security Officer",
		color = colorlookup["secradio"],
		style = "secradio",
	},
	["security_head"] = {
		name = "Head of Security",
		color = colorlookup["secradio"],
		style = "secradio",
	},
	["security_warden"] = {
		name = "Warden",
		color = colorlookup["secradio"],
		style = "secradio",
	},
}

JK_Command = {
	["command_captain"]				= true,
	["command_personnel"]			= true,
	["command_representative"]		= true,
	["command_blueshield"]			= true,
	["engineering_head"]			= true,
	["medical_head"]				= true,
	["security_magistrate"]			= true,
	["security_head"]				= true,
	["ai"]							= true,
}

JK_ERT = {
	["ert_officer"]					= true,
	["ert_engineer"]				= true,
	["ert_medic"]					= true,
	["ert_leader"]					= true,
	["ert_member"]					= true,
}

function GetBetaChannel( item )
	if isnumber(item) then
		for i, v in pairs( BetaChannels ) do
			if v.freq == item then
				print("Channel frequency lookup completed successfully")
				return v
			else
				continue
			end
		end
	elseif !BetaChannels[ item ] then
		return {
			name = "Undefined Channel",
			color = color_white,
			style = "radio",
			freq = 6969
		}
	else
		return BetaChannels[ item ]
	end
end

function GetBetaJob( item )
	if !BetaJobs[ item ] then
		return {
			name = "Undefined Job",
			color = color_white,
			style = "radio"
		}
	else
		return BetaJobs[ item ]
	end
end







if myChat and IsValid(mychat) then myChat:Remove() end
if god and IsValid(god) then god:Remove() end


god = vgui.Create("DFrame")
god:SetSize(500, 200)
god:SetPos(100, 100)
god:Dock(RIGHT)
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


local we = { ["!"] = {"exclaims", "shouts", "yells"}, ["?"] = {"asks"} }
if !ChatHistory then ChatHistory = {} end
-- table.Empty(ChatHistory)

function ehtml:Updoot()
	local OneString = ""
	for i, v in ipairs( ChatHistory ) do
		OneString = OneString .. v
	end
	ehtml:SetHTML( "<body onLoad=\"window.scroll(0, 99999999999)\">" .. (dark and s_dark or s_light) .. deebug .. OneString .. preview )
end
ehtml:Updoot()

local textentry = vgui.Create( "DTextEntry", frame )
textentry:Dock( BOTTOM )
textentry:SetPlaceholderText( "To chat click here or press the \"/\" key" )
textentry:SetUpdateOnType(true)
textentry.OnEnter = function( self )
	local channel	= GetBetaChannel("Nonexistant")
	local job		= GetBetaJob("Nonexistant")
	--[[chat.AddText(
		{"IDK_b"}, channel.color, "[" .. (channel.name or "Truly Unknown Channel") .. "]" .. " ",
		{"IDK_b"}, job.color, "(" .. (job.name or "Truly Unknown Job") .. ")", {"IDK_b"}, job.color, " " .. LocalPlayer():Nick() .. " ",
		{"IDK"}, channel.color, "says" .. ", "
		.. "\"" .. self:GetText() .. "\""
	)]]

	local forbiddenknowledge = ""

	local chan = GetBetaChannel()
	local u = GetBetaJob()

	-- Job
	local spoinks = string.Right(self:GetText(), 1)
	--print(spoinks)
	forbiddenknowledge = forbiddenknowledge .. "<span class='" .. chan.style .. "'>[<b>" .. chan.name .. "</b>]</span>"
	forbiddenknowledge = forbiddenknowledge .. " <span class='" .. u.style .. "'>[" .. u.name .. "] <span class='name'>" .. LocalPlayer():Nick() .. "</span></span>"
	forbiddenknowledge = forbiddenknowledge .. "<span class='" .. chan.style .. "'>"
	forbiddenknowledge = forbiddenknowledge .. " " .. (we[spoinks] and table.Random(we[spoinks]) or "says") .. ", "
	forbiddenknowledge = forbiddenknowledge .. "\"" .. self:GetText() .. "\""
	forbiddenknowledge = forbiddenknowledge .. "</span><br>"

	table.insert(ChatHistory, forbiddenknowledge)

	self:SetText("")
	preview = ""
	ehtml:Updoot()


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
	myChat.dTextEntry:RequestFocus()
end

bTeam = false
hook.Add( "PlayerBindPress", "overrideChatbind", function( ply, bind, pressed )
    if bind == "messagemode" then
        bTeam = false
    --elseif bind == "messagemode2" then
    --    bTeam = true
    else
        return
    end

	if pressed then
		Baam = vgui.Create( "DFrame" )
		Baam:SetPos( 10, 30 ) -- Set the position of the panel
		Baam:SetSize( 300, 87 ) -- Set the size of the panel
		Baam:SetTitle( bTeam and "Emote" or "Say")
		Baam:SetDeleteOnClose( true )
		Baam:Center()
		Baam:MakePopup()

		Baam:SetY( Baam:GetY() - 100 )

		BChat = vgui.Create( "DTextEntry", Baam )
		BChat:Dock( TOP )
		BChat:DockMargin(5, 3, 5, 5)
		function BChat:OnEnter()
			SendAMessage( BChannel:GetOptionData( BChannel:GetSelectedID() ), BChat:GetValue(), BChannel2:GetOptionData( BChannel2:GetSelectedID() ) )
			BChat:SetValue("")
			BChannel:Clear()
			BChannel2:Clear()
			Baam:Remove()
		end
		
		BChannel = vgui.Create( "DComboBox", Baam )
		BChannel:Dock( LEFT )
		BChannel:SetValue( "Channels" )
		BChannel:SetSortItems( false )
		BChannel:AddChoice( "Locally", "local" )
		BChannel:AddChoice( "Left Hand", "left hand" )
		BChannel:AddChoice( "Right Hand", "right hand" )
		BChannel:AddSpacer()
		for i, inf in SortedPairsByMemberValue( BetaChannels, "freq" ) do
			BChannel:AddChoice( inf.freq/10 .. " - " .. inf.name, inf.freq )
		end

		function BChannel:OnSelect(index, value, data)
			chat.AddText("Set channel to " .. ( data or "unknown" ) )
			BChat:SetPlaceholderText( ( bTeam and "Emoting " or "Speaking " ) .. ( BChannel:GetValue() and ( "over " .. ( data or "unknown" ) ) or "locally" ) )
		end
		
		BChannel2 = vgui.Create( "DComboBox", Baam )
		BChannel2:Dock( RIGHT )
		BChannel2:SetValue( "Jobs" )
		BChannel2:SetSortItems( true )
		for i, inf in pairs( BetaJobs ) do
			BChannel2:AddChoice( i .. " - " .. inf.name, i )
		end

		function BChannel2:OnSelect(index, value, data)
			chat.AddText("Set job to " .. ( data or "unknown" ) )
			BChat:SetPlaceholderText( "Job is "  .. ( BChannel2:GetValue() and ( data or "unknown" ) or "locally" ) )
		end

		BButtOK = vgui.Create( "DButton", Baam )
		BButtOK:SetSize( 80, 5 )
		BButtOK:Dock( LEFT )
		BButtOK:DockMargin(15, 2, 10, 5)
		BButtOK:SetText("OK")
		function BButtOK:DoClick()
			SendAMessage( BChannel:GetOptionData( BChannel:GetSelectedID() ), BChat:GetValue(), BChannel2:GetOptionData( BChannel2:GetSelectedID() ) )
			BChat:SetValue("")
			BChannel:Clear()
			BChannel2:Clear()
			Baam:Remove()
		end

		BButtCN = vgui.Create( "DButton", Baam )
		BButtCN:SetSize( 80, 5 )
		BButtCN:Dock( RIGHT )
		BButtCN:DockMargin(10, 2, 15, 5)
		BButtCN:SetText("Cancel")
		function BButtCN:DoClick()
			BChat:SetValue("")
			BChannel:Clear()
			BChannel2:Clear()
			Baam:Remove()
		end
	end

    --myChat.openChatbox( bTeam )

    return true -- Doesn't allow any functions to be called for this bind
end )

function SendAMessage( freq, text, debugjob )
	if freq and !isnumber(freq) then chat.AddText("Non-frequency messages are a WIP.") return end
	net.Start( "ES13_ChatRecieve" )
		net.WriteUInt(freq or 1459, 12)
		net.WriteString(text or "No message.")
		net.WriteString(debugjob or "assistant")
	net.SendToServer()
end


hook.Add( "ChatText", "serverNotifications", function( index, name, text, type )
    --if type == "joinleave" or type == "none" then
        myChat.dRichText:AppendText( text .. "\n" )
		myChat.dRichText:Updoot()
    --end
end )

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
	preview = "<i><span class='" .. chan.style .. "'>[<b>" .. chan.name .. "</b>]</span>"
	preview = preview .. " <span class='" .. u.style .. "'>[" .. u.name .. "] <span class='name'>" .. LocalPlayer().dna.name .. "</span></span>"
	preview = preview .. "<span class='" .. chan.style .. "'>"
	preview = preview .. " " .. (we[spoinks] and table.Random(we[spoinks]) or "says") .. ", "
	preview = preview .. "\"" .. self:GetText() .. "\""
	preview = preview .. "</span></i><br>"

	myChat.dRichText:Updoot()
	--myChat.dRichText:GotoTextEnd()
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