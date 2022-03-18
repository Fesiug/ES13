
-- ES13 chat system

if SERVER then

	util.AddNetworkString("ES13_ChatRecieve")
	util.AddNetworkString("ES13_ChatBroadcast")

	net.Receive( "ES13_ChatRecieve", function( len, ply )
		local m_freq	= net.ReadUInt(12)
		local m_text	= net.ReadString()
		local m_debug_job	= net.ReadString()

		net.Start( "ES13_ChatBroadcast" )
			-- Frequency
			net.WriteUInt( m_freq, 12 )

			-- Name and job
			net.WriteString( ply:Nick() )
			net.WriteString( m_debug_job )

			-- Text
			net.WriteString( m_text )
		net.Broadcast()
	end )

elseif CLIENT then

	concommand.Add("es13_say", function( ply, cmd, args )
		SendAMessage( tonumber(args[1]), args[2], args[3] )
	end)

	function SendAMessage( freq, text, debugjob )
		print(freq, text, debugjob)
		if freq and !isnumber(freq) then chat.AddText("Non-frequency messages are a WIP.") return end
		net.Start( "ES13_ChatRecieve" )
			net.WriteUInt(freq or 1459, 12)
			net.WriteString(text or "No message.")
			net.WriteString( debugjob or "" )
		net.SendToServer()
	end

	local we = { ["!"] = {"exclaims", "shouts", "yells"}, ["?"] = {"asks"} }
	net.Receive( "ES13_ChatBroadcast", function( len, ply )

		local m_chan	= net.ReadUInt(12)
		local m_sender	= net.ReadString()
		local m_senderjob	= net.ReadString()
		local m_text	= net.ReadString()
		
		local channel = GetBetaChannel( m_chan )
		local job = GetBetaJob( m_senderjob )

		local spoinks = string.Right(m_text, 1)
		chat.AddText(
			{"IDK_b"}, channel.color, "[" .. (channel.name or "Truly Unknown Channel") .. "]" .. " ",
			{"IDK_b"}, job.color, "(" .. (job.name or "Truly Unknown Job") .. ")", {"IDK_b"}, job.color, " " .. m_sender .. " ",
			{"IDK"}, channel.color, ( we[spoinks] and table.Random(we[spoinks]) or "says" ) .. ", "
			.. "\"" .. m_text .. "\""
		)

	end )

end