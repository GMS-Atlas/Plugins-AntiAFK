
AFK_TIME = 1800 // En secondes

AFK_WARN_TIME = 900 // En secondes


hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if ( ply:IsConnected() and ply:IsFullyAuthenticated() ) then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
		
			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_WARN_TIME) and (!ply.Warning) then
				ply:ChatPrint("Attention: Vous allez être kick pour AFK.")
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("Vous avez été Kick pour AFK > 30 minutes.\n")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	ply.Warning = false
end)