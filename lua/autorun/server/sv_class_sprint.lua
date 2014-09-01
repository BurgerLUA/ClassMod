function SVSprintThink()

	local PlayerTable = player.GetAll()

	for i=1, table.Count(player.GetAll()) do
		local ply = PlayerTable[i]
		
		--print(ply:GetVelocity():Length())
		
		ply.Stamina = Class[ply.ClassNumber]["stamina"]
		local WalkSpeed = Class[ply.ClassNumber]["walkspeedmul"] * GetConVar("bur_class_walkspeed"):GetInt()
		local RunSpeed = Class[ply.ClassNumber]["runspeedmul"] * GetConVar("bur_class_runspeed"):GetInt()
		
		if ply:KeyDown(IN_SPEED) and ply:GetVelocity():Length() > 0 then
			if ply.Energy >= 0.2 then 
				if ply.NextTick < CurTime() then 
					ply.NextTick = CurTime() + 0.2
					ply.Energy = ply.Energy - 0.2
					ply:SetRunSpeed(RunSpeed)
				end
			else
				ply:SetRunSpeed(WalkSpeed)
			end
		else
			if ply.Energy < ply.Stamina then
				if ply.NextTick < CurTime() then 
					ply.NextTick = CurTime() + 0.25
					ply.Energy = ply.Energy + ply.Stamina*0.01
				end
			else
				ply.Energy = ply.Stamina
			end
		end
		
		ply:SetNWInt("Energy",ply.Energy)
		
	end
end

hook.Add("Think", "Serverside Sprint Think", SVSprintThink)

