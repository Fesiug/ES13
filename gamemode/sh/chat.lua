
-- ES13 chat system

if SERVER then

	util.AddNetworkString("ES13_ChatRecieve")
	util.AddNetworkString("ES13_ChatBroadcast")

	net.Receive( "ES13_ChatRecieve", function( len, ply )
		local m_freq	= net.ReadUInt(12)
		local m_text	= net.ReadString()

		net.Start( "ES13_ChatBroadcast" )
			-- Frequency
			net.WriteUInt( m_freq, 12 )

			-- Name and job
			net.WriteString( ply:Nick() )
			net.WriteString( "librarian" )

			-- Text
			net.WriteString( m_text )
		net.Broadcast()
	end )

elseif CLIENT then

	local we = { ["!"] = {"exclaims", "shouts", "yells"}, ["?"] = {"asks"} }
	net.Receive( "ES13_ChatBroadcast", function( len, ply )

		local m_chan	= net.ReadUInt(12)
		local m_sender	= net.ReadString()
		local m_senderjob	= net.ReadString()
		local m_text	= net.ReadString()
		
		local channel = GetBetaChannel( m_chan )
		local job = GetBetaJob( m_senderjob )

		chat.AddText(
			{"IDK_b"}, channel.color, "[" .. (channel.name or "Truly Unknown Channel") .. "]" .. " ",
			{"IDK_b"}, job.color, "(" .. (job.name or "Truly Unknown Job") .. ")", {"IDK_b"}, job.color, " " .. m_sender .. " ",
			{"IDK"}, channel.color, ( we[spoinks] and table.Random(we[spoinks]) or "says" ) .. ", "
			.. "\"" .. m_text .. "\""
		)

	end )

end