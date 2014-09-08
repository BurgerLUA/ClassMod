function ClassDisables()

	local players = player.GetAll()

	for i=1, table.Count(players) do
		local ply = players[i]
		if not ply.Stun then 
			ply.Stun = 0
		end
		
		if not ply.StunUpdate then
			ply.StunUpdate = 0
		end
	
		if not ply.Slow then 
			ply.Slow = 0
		end
		
		if not ply.SlowUpdate then
			ply.SlowUpdate = 0
		end
		
		if not ply.DOT then 
			ply.DOT = 0
		end
		
		if not ply.DOTT then 
			ply.DOTT = 0
		end
		
		if not ply.DOTUpdate then
			ply.DOTUpdate = 0
		end
		

		--STUN
	
		if ply.Stun > 0 then
	
			if ply.StunUpdate > CurTime() then
				ply.StunUpdate = ply.StunUpdate + ply.Stun
			else
				ply.StunUpdate = CurTime() + ply.Stun
			end
	
			if ply.StunUpdate > CurTime() then
				ply:Freeze(true)
				ply.IsStunned = true
				--print("FREEZE")
			end

			print(ply:Nick() .. " has been stunned for "..ply.StunUpdate - CurTime().." seconds!")

			
			ply.Stun = 0
		
		end
		
		if ply.IsStunned == true then
			if ply.StunUpdate - CurTime() <= 0 then
				--print("UNFREEZE")
				ply:Freeze(false)
				ply.IsStunned = false
			end
		end
	end




end

hook.Add("Think","Class Disables",ClassDisables)

print("sv_class_disables loaded")
