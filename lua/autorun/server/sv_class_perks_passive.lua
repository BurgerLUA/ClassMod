function CheckPerks(ply)

	if TableSearcher(ply.ClassNumber,"LifeRegen") == true then
		timer.Create( "LifeGainPerkTick" .. ply:EntIndex(), 1, 0, function()

			if ply:IsValid() == false then timer.Destroy("LifeGainPerkTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("LifeGainPerkTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"LifeRegen") == false then timer.Destroy("LifeGainPerkTick" .. ply:EntIndex()) return end
			if ply:Health() >= ply:GetMaxHealth() then return end
			

			
			ply:SetHealth(ply:Health() + 1)

		end)
	end
	
	if TableSearcher(ply.ClassNumber,"DeadLife") == true then
		timer.Create( "DeadLifeTick" .. ply:EntIndex(), 3, 0, function()

			if ply:IsValid() == false then timer.Destroy("DeadLifeTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("DeadLifeTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"DeadLife") == false then timer.Destroy("DeadLifeTick" .. ply:EntIndex()) return end
	
			if ply:Health() < 60 then
				ply:SetHealth(ply:Health() + 1)
			end
			
			if ply:Armor() < 60 then
				ply:SetArmor(ply:Armor() + 1)
			end

		end)
	end

	if TableSearcher(ply.ClassNumber,"ArcLight") == true then
		timer.Create( "ArcLightTick" .. ply:EntIndex(), 0.5, 0, function()

			if ply:IsValid() == false then timer.Destroy("ArcLightTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("ArcLightTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"ArcLight") == false then timer.Destroy("ArcLightTick" .. ply:EntIndex()) return end

			local result = ents.FindInSphere(ply:GetPos(),300)
			local resultCount = table.Count(result)

			for i=1, resultCount do
				if result[i]:IsPlayer() == true then
					if result[i] ~= ply then
						if result[i]:Team() == ply:Team() and ply:Team() ~= 1001 then return end
						local damage = (300 - ply:GetPos():Distance(result[i]:GetPos()))/200
						result[i]:TakeDamage(damage, ply, ply)
					end
				end
			end
		end)
	end
	
	
	if TableSearcher(ply.ClassNumber,"Medic") == true then
		timer.Create( "MedicAura" .. ply:EntIndex(), 1, 0, function()
			if ply:IsValid() == false then timer.Destroy("MedicAura" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("MedicAura" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Medic") == false then timer.Destroy("MedicAura" .. ply:EntIndex()) return end
			
			local Team =  team.GetPlayers(ply:Team())
			local TeamCount = table.Count(Team)
			
			for i=1, TeamCount do
				if Team[i]:Alive() == false then return end
				if Team[i]:Team() == 1001 then return end
				if Team[i]:Health() < Team[i]:GetMaxHealth() then
					Team[i]:SetHealth(Team[i]:Health() + 1)
				end
			end
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"AuraLeech") == true then
		timer.Create( "AuraLeech" .. ply:EntIndex(), 3, 0, function()
			if ply:IsValid() == false then timer.Destroy("AuraLeech" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("AuraLeech" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"AuraLeech") == false then timer.Destroy("AuraLeech" .. ply:EntIndex()) return end
			
			
			local result = ents.FindInSphere(ply:GetPos(),500)
			local resultCount = table.Count(result)

			for i=1, resultCount do
				if result[i]:IsPlayer() == true then
					if result[i] ~= ply then
						result[i]:TakeDamage(1,ply,ply)

						if ply:Health() < 200 then
							ply:SetHealth(ply:Health() + 1)
						else
							ply:SetHealth(200)
						end
					end
				end
			end
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"LifeSteal") == true then	
		timer.Create( "HealthDecay" .. ply:EntIndex(), 3, 0, function()
			if ply:IsValid() == false then timer.Destroy("HealthDecay" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("HealthDecay" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"LifeSteal") == false then timer.Destroy("HealthDecay" .. ply:EntIndex()) return end
			if ply:Health() <= ply:GetMaxHealth() then return end
			ply:SetHealth(ply:Health() - 1)
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"Mystical") == true then
		timer.Create( "MysticalTick" .. ply:EntIndex(), 0.1, 0, function()
			if ply:IsValid() == false then timer.Destroy("MysticalTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("MysticalTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Mystical") == false then timer.Destroy("MysticalTick" .. ply:EntIndex()) return end
			
			for i =1, table.Count(player.GetAll()) do
				local players =  player.GetAll()
				
				if players[i]:GetEyeTrace().Entity == ply then
					players[i]:SendLua("if SERVER then return end LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles() + Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),0))")
				end
			end
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"Bleedout") == true then
		ply.HealthTick=0
		
		--ParticleEffectAttach("unusual_zap_yellow", PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("chest"))
		--ParticleEffectAttach("unusual_robot_orbiting_sparks", PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("chest"))

		
		
		timer.Create( "BleedoutTick" .. ply:EntIndex(), 0.25, 0, function()
			if ply:IsValid() == false then ply:StopParticles(); timer.Destroy("BleedoutTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then ply:StopParticles();  timer.Destroy("BleedoutTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Bleedout") == false then ply:StopParticles(); timer.Destroy("BleedoutTick" .. ply:EntIndex()) return end
			if ply:GetVelocity():Length() > 0 then
				ply:TakeDamage(ply:GetVelocity():Length()/1000,ply,ply)
			else
				if ply.HealthTick >= 3 then
					if ply:Health() < 100 then
						ply:SetHealth(ply:Health() +1)
					else
						ply:SetHealth(100)
					end
					ply.HealthTick = 0
				else
					ply.HealthTick = ply.HealthTick + 1
				end
			end
		end)
	end
	
	
	
	
	if TableSearcher(ply.ClassNumber,"Slayer") == true then
	
		ply.LastFrags = ply:Frags()
	
		timer.Create( "SlayerTick" .. ply:EntIndex(), 0.5, 0, function()
			if ply:IsValid() == false then timer.Destroy("SlayerTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Slayer") == false then timer.Destroy("SlayerTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("SlayerTick" .. ply:EntIndex()) return end
			
			
			if ply:Frags() > ply.LastFrags then
				ply.LastFrags = ply:Frags()
				
				if ply:Health() + 20 <= 300 then
					ply:SetHealth(ply:Health()+20)
				else
					ply:SetHealth(300)
				end
			else
				if ply:Health() > 1 then
					ply:SetHealth(ply:Health()-1)
				else
					ply:Kill()
				end
			end
		end)
	end
	
	
	
	
	if TableSearcher(ply.ClassNumber,"Snackbar") == true then	
		timer.Create( "ExplodeCheck" .. ply:EntIndex(), 0.1, 0, function()
			if ply:IsValid() == false then timer.Destroy("ExplodeCheck" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Snackbar") == false then timer.Destroy("ExplodeCheck" .. ply:EntIndex()) return end
			if ply:Alive() == false then
				timer.Destroy("ExplodeCheck" .. ply:EntIndex())
				

				
				local effectdata = EffectData()
				effectdata:SetStart( ply:GetPos() )
				effectdata:SetOrigin( ply:GetPos() )
				effectdata:SetScale( 1 )
				util.Effect( "Explosion", effectdata )	
				util.BlastDamage(ply, ply, ply:GetPos(), 250, 100)
				

				util.Decal("Scorch", ply:GetPos(), ply:GetPos())

	
				if table.Count(ents.FindInSphere(ply:GetPos(),250)) > 0 then
					for k,v in pairs(ents.FindInSphere(ply:GetPos(),250)) do
						if v:GetClass() == "prop_physics" then
							if math.Rand(0,100) >= 70 then
								v:Ignite(250/20 - v:GetPos():Distance( ply:GetPos() )/20,0)
							end
			
							timer.Simple(0,function() 
								if v:IsValid() == false then return end
								constraint.RemoveAll(v)
								v:GetPhysicsObject():EnableMotion(true)
								v:GetPhysicsObject():Wake()
							end)

						end
			
						if v:GetClass() == "prop_door_rotating" then
							v:Fire( "Unlock", 0 )
							v:Fire( "Open", 0.1 )
						end
					end
				end
			end
		end)
	end
	
	
	if TableSearcher(ply.ClassNumber,"Cloak") == true then	
	
		ply.ArmorDrainCount = 0
	
		timer.Create( "CloakCheckTick" .. ply:EntIndex(), 0.1, 0, function()
			if ply:IsValid() == false then timer.Destroy("CloakCheckTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("CloakCheckTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Cloak") == false then timer.Destroy("CloakCheckTick" .. ply:EntIndex()) return end
			
			if ply:Armor() > 0 then 
				
			--	ply:SetColor(255,255,255,255)
				
				ply.MoveSpeed = ply:GetVelocity():Length()
				
				
				if ply.MoveSpeed < 10 then
					ply:SetMaterial("models/effects/vol_light001")
					ply:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
				elseif ply.MoveSpeed < 70 then
					ply:SetMaterial("models/shadertest/predator")
					ply:GetActiveWeapon():SetMaterial("models/shadertest/predator")
				else
					ply:SetMaterial("")
					ply:GetActiveWeapon():SetMaterial("")
				end
				
				
				ply.ArmorDrainCount = ply.ArmorDrainCount + 1
				
				
				if ply.ArmorDrainCount >= 30 then
					ply.ArmorDrainCount = 0
					ply:SetArmor(ply:Armor() - 1) 
				end
			else
				ply:SetMaterial("")
			end
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"Necro") then
		timer.Create( "NecroTick" .. ply:EntIndex(), 1, 0, function()
			if ply:IsValid() == false then timer.Destroy("NecroTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("NecroTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Necro") == false then timer.Destroy("NecroTick" .. ply:EntIndex()) return end
			ply:SetMaxHealth(1)
		end)
	end
	
	if TableSearcher(ply.ClassNumber,"Poop") then
		timer.Create( "PoopTick" .. ply:EntIndex(), 5, 0, function()
			if ply:IsValid() == false then timer.Destroy("PoopTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("PoopTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"Poop") == false then timer.Destroy("PoopTick" .. ply:EntIndex()) return end

			
			
			ent = ents.Create("prop_physics")
				ent:SetModel("models/Gibs/HGIBS_spine.mdl")
				ent:SetMaterial("models/props_pipes/pipeset_metal.vmt")
				ent:SetPos(ply:GetPos() + Vector(0,0,30))
				ent:SetAngles(ply:GetAngles())
				ent:SetOwner(ply)
				ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
				ent:Spawn()
				ent:Activate()
			
			for i = 1, 5 do
				timer.Simple(i+math.Rand(1,14), function() ent:EmitSound("ambient/creatures/flies"..i..".wav") end)
			end
				
			
			SafeRemoveEntityDelayed(ent, 20 )
			ParticleEffectAttach("superrare_flies", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
			ParticleEffectAttach("drg_pipe_smoke", PATTACH_ABSORIGIN_FOLLOW, ent, 0)
		
			local amount = math.Rand(-3,3)
			
			ply:EmitSound("garrysmod/balloon_pop_cute.wav",100,50 + amount*3)
	
			if amount > 0 then
				if ply:Health() + amount < 100 then
					ply:SetHealth(ply:Health() + amount)
				else
					ply:SetHealth(100)
				end
			elseif amount < 0 then
				if (ply:Health() + amount) > 0 then
					ply:SetHealth(ply:Health() + amount)
				else
					ply:Kill()
				end
			else
			
			end
			
		end)
	end

	if TableSearcher(ply.ClassNumber,"ArmorRegen") == true then

		ply.ArmorRegenTime = 0
 
		timer.Create( "ArmRegenPerkTick" .. ply:EntIndex(), 1, 0, function()
 
			if ply:IsValid() == false then timer.Destroy("ArmRegenPerkTick" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("ArmRegenPerkTick" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"ArmorRegen") == false then timer.Destroy("ArmRegenPerkTick" .. ply:EntIndex()) return end
			if ply:Armor() >= 30 then return end
			if ply.ArmorRegenTime >= CurTime() then return end
			ply:SetArmor(ply:Armor() + 1)
 
		end)
	end    
	
	
	
	if TableSearcher(ply.ClassNumber,"SoulAbsorb") then
	
		ply.SoulsDelivered = 100
		ply.SoulCount = 0
		ply.CountTick = 0
		ply.SmallSoulsWarning = true
		ply.ZeroSoulsWarning = true
		ply.PissedOffDemons = false
		
		timer.Create( "SoulRegen" .. ply:EntIndex(), 1, 0, function()
			if ply:IsValid() == false then timer.Destroy("SoulRegen" .. ply:EntIndex()) return end
			if ply:Alive() == false then timer.Destroy("SoulRegen" .. ply:EntIndex()) return end
			if TableSearcher(ply.ClassNumber,"SoulAbsorb") == false then timer.Destroy("SoulRegen" .. ply:EntIndex()) return end
			
			ply.SoulsDelivered = ply.SoulsDelivered - 1
			
			--print(ply.SoulsDelivered)
			
			if ply.SoulCount > 0 and ply:Armor() < ply.SoulCount*0.1 then	
				ply:SetArmor(ply:Armor() + 1)
			end
			
			if ply.SoulsDelivered <= 20 and ply.SmallSoulsWarning == true then
				ply.SmallSoulsWarning = false
				ply:ChatPrint("The keepers of oblivion are getting angry for your lack of souls.")
				ply:EmitSound("npc/stalker/breathing3.wav",100,50)
			end
			
			if ply.SoulsDelivered < 0 and ply.ZeroSoulsWarning == true and ply.PissedOffDemons == false then
				ply.ZeroSoulsWarning = false
				ply.PissedOffDemons = true
				ply:ChatPrint("The keepers of oblivion is absorbing your very soul for your lack of commitment.")
				ply:ConCommand("pp_mat_overlay effects/invuln_overlay_red ")
				ply:ConCommand("pp_mat_overlay_refractamount 1")
			end
			
			if ply.SoulsDelivered > 100 and ply.PissedOffDemons == true then
				ply.PissedOffDemons = false
				ply:ChatPrint("The keepers of oblivion have been appeased, but they have left a mark on your max health.")
				ply.SmallSoulsWarning = true
				ply.ZeroSoulsWarning = true
				ply:ConCommand("pp_mat_overlay \"\" ")
				ply:ConCommand("pp_mat_overlay_refractamount 0")
			end

			if ply.PissedOffDemons == true then
				ply.CountTick = ply.CountTick + 1
			else
				ply.CountTick = 0
			end

		
			if ply.CountTick == 3 then 
				ply.CountTick = 0
				if ply:Health() > 7 then
					ply:SetHealth(ply:Health() - 7)
					ply:SetMaxHealth(ply:GetMaxHealth() - 5)
					ply:EmitSound("npc/headcrab_poison/ph_hiss1.wav", 100, 50)
					ply:ViewPunch(Angle(math.random(-5,5),math.random(-5,5),math.random(-5,5)))
				else
					ply:Kill()
					ply:EmitSound("npc/vort/vort_dispell.wav", 100, 50)
					ply:ConCommand("pp_mat_overlay \"\" ")
					ply:ConCommand("pp_mat_overlay_refractamount 0")
				end
			end
			
		end)
	end
	
end