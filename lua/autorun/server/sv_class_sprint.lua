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
					ply.NextTick = CurTime() + 0.1
					
					if ply:GetVelocity():Length() > 0 then
						ply.Energy = ply.Energy + ply.Stamina*0.005
					else
						ply.Energy = ply.Energy + ply.Stamina*0.01
					end

				end
			else
				ply.Energy = ply.Stamina
			end
		end
		
		ply:SetNWInt("Energy",ply.Energy)
		
		if ply.Energy < 2 then
			ply:SetJumpPower(0)
		else
			ply:SetJumpPower(Class[ply.ClassNumber]["jumpmul"] * GetConVar("bur_class_jumppower"):GetInt() )
		end
		
		
	end
end

hook.Add("Think", "Serverside Sprint Think", SVSprintThink)

--Code taken from _Kilburn
			hook.Add("KeyPress", "DoubleJump", function(pl, k)
			
				
			
			
				if not pl or not pl:IsValid() or k~=2 then
					return
				end
		
				if not pl.Jumps or pl:IsOnGround() then
					pl.Jumps=0
				end
	
				if pl.Jumps == 0 then
					if pl.Energy > 2 then
						pl.Energy = pl.Energy - 2
					end
				end
	
				if TableSearcher(pl.ClassNumber,"DoubleJump") == false then return end
	
				if pl.Jumps==2 then return end
				
		
				pl.Jumps = pl.Jumps + 1
				
				
				if pl.Jumps==2 then
				
					if pl.Energy < 5 then return end
				
					pl.Energy = pl.Energy - 5
				
				
					if math.random(1,100) > 80 then
						pl:EmitSound("vo/scout_apexofjump0"..math.random(1,4)..".wav",100,100)
					end
				
					local ang = pl:GetAngles()
					local forward, right = ang:Forward(), ang:Right()
		
					local vel = -1 * pl:GetVelocity() -- Nullify current velocity
					vel = vel + Vector(0, 0, 300) -- Add vertical force
		
					local spd = pl:GetMaxSpeed()
		
					if pl:KeyDown(IN_FORWARD) then
						vel = vel + forward * spd
					elseif pl:KeyDown(IN_BACK) then
						vel = vel - forward * spd
					end
		
					if pl:KeyDown(IN_MOVERIGHT) then
						vel = vel + right * spd
					elseif pl:KeyDown(IN_MOVELEFT) then
						vel = vel - right * spd
					end
		
					pl:SetVelocity(vel)
				end
			end)

print("sv_class_sprint loaded")