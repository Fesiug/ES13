
-- ES13 chat system

if SERVER then

	util.AddNetworkString("ES13_ChatRecieve")
	util.AddNetworkString("ES13_ChatBroadcast")

	net.Receive( "ES13_ChatRecieve", function( len, ply )

	end )

	if false then
		net.Start( "ES13_ChatBroadcast" )
			net.WriteString("Chat broadcast test")
		-- Probably check if they own the headset necessary
		-- net.Send( {} )
		net.Broadcast()
	end

elseif CLIENT then

	net.Receive( "ES13_ChatBroadcast", function( len, ply )

	end )

end