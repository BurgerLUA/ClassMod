function CheckPerks()
	for k,v in pairs(player.GetAll()) do 
		local ply = v
		
		if ply:Alive() == false or ply.HasChangedClass == true then
			ply.first = false
			ply.HasChangedClass = false
		else
		
			--print("UPDATE")
			if TableSearcher(ply.ClassNumber,"LifeRegen") == true then
			
				 
				
				if ply.first == false then 
					ply.LifeRegenTick = 0
					
					ply.first = true
				end
				
				if ply.LifeRegenTick <= CurTime() then
					ply.LifeRegenTick = CurTime()+1
					if ply:Health() < ply:GetMaxHealth() then
						ply:SetHealth(ply:Health() + 1)
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"DeadLife") == true then
				
				
				
				if ply.first == false then
					ply.DeadLifeTick = 0
				
				
					ply.first = true
				end
				
				if ply.DeadLifeTick <= CurTime() then
					ply.DeadLifeTick = CurTime() + 3
				
					if ply:Health() < 50 then
						ply:SetHealth(ply:Health() + 1)
					end
					
					if ply:Armor() < 50 then
						ply:SetArmor(ply:Armor() + 1)
					end

				end
			end

			if TableSearcher(ply.ClassNumber,"ArcLight") == true then
			
				
				
				if ply.first == false then
					ply.ArcLightTick = 0
				
					ply.first = true
				end
				
				if ply.ArcLightTick <= CurTime() then
					ply.ArcLightTick = CurTime() + 1
					
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
				end
			end

			if TableSearcher(ply.ClassNumber,"Medic") == true then
			
				
				
				if ply.first == false then
					ply.HealTick = 0
					ply.first = true
				end
			
				if ply.HealTick <= CurTime() then
					ply.HealTick = CurTime() + 1
					
					local Team =  team.GetPlayers(ply:Team())
					local TeamCount = table.Count(Team)
					
					if ply:Health() < ply:GetMaxHealth() then
						ply:SetHealth(ply:Health()+2)
					end
					
					for i=1, TeamCount do
						if Team[i]:Alive() == false then return end
						if Team[i]:Team() == 1001 then return end
						if Team[i]:Health() < Team[i]:GetMaxHealth() then
							Team[i]:SetHealth(Team[i]:Health() + 1)
						end
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"AuraLeech") == true then
			
				
				
				if ply.first == false then
					ply.LeechTick = 0
						
					ply.first = true
				end
					
				if ply.LeechTick <= CurTime() then
					ply.LeechTick = CurTime() + 0.75
					local result = ents.FindInSphere(ply:GetPos(),500)
					local resultCount = table.Count(result)

					for i=1, resultCount do
						if result[i]:IsPlayer() == true then
							if result[i] ~= ply then
								if result[i]:Alive() == true then 
									result[i]:TakeDamage(1,ply,ply)

									if ply:Health() < 200 then
										ply:SetHealth(ply:Health() + 1)
									else
										ply:SetHealth(200)
									end
								end
							end
						end
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"LifeSteal") == true then	
			
				
				
				if ply.first == false then
					ply.LifeStealTick = 0
					
					ply.first = true
				end
				
				if ply.LifeStealTick <= CurTime() then
					ply.LifeStealTick = CurTime()+1
					if ply:Health() > 1 then
						ply:SetHealth(ply:Health() - 1)
					else
						ply:Kill()
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"Mystical") == true then
				for i =1, table.Count(player.GetAll()) do
					local players =  player.GetAll()
					if players[i]:GetEyeTrace().Entity == ply then
						players[i]:SendLua("if SERVER then return end LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles() + Angle(math.Rand(-0.5,0.5),math.Rand(-0.5,0.5),0))")
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"Bleedout") == true then
				
				
				
				if ply.first == false then
					ply.HealthTick=0
					
					--ParticleEffectAttach("unusual_zap_yellow", PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("chest"))
					--ParticleEffectAttach("unusual_robot_orbiting_sparks", PATTACH_POINT_FOLLOW, ply, ply:LookupAttachment("chest"))
					
					ply.first = true
				end
				
				if ply:GetVelocity():Length() > 0 then
					if ply:IsOnGround() then
						ply:TakeDamage(ply:GetVelocity():Length()/1000,ply,ply)
					end
				else
					if ply.HealthTick <= CurTime() then
						if ply:Health() < 100 then
							ply:SetHealth(ply:Health() + 1)
						else
							ply:SetHealth(100)
						end
						ply.HealthTick = CurTime() + 1
					end
				end
			end
			
			
			if TableSearcher(ply.ClassNumber,"Slayer") == true then
			
				--
				
				if ply.first == false then
					ply.FragTick = 0
					ply.first = true
				end
			
				ply.LastFrags = ply:Frags()
				
				if ply:Frags() > ply.LastFrags then
					ply.LastFrags = ply:Frags()
					if ply:Health() + 20 <= 300 then
						ply:SetHealth(ply:Health()+20)
					else
						ply:SetHealth(300)
					end
				elseif ply.FragTick <= CurTime() then
					ply.FragTick = CurTime() + 0.5
					if ply:Health() > 1 then
						ply:SetHealth(ply:Health()-1)
					else
						ply:Kill()
					end
				end
		
			end
			
			
			if TableSearcher(ply.ClassNumber,"Snackbar") == true then	
				
				
				local effectdata
				
				if ply.first == false then
					ply.ExplodeMe = false
					effectdata = EffectData()
					effectdata:SetScale( 1 )
					
					ply.first = true
				end
			
				if ply:Alive() == false and ply.ExplodeMe == false then
					ply.ExplodeMe = true

					effectdata:SetStart( ply:GetPos() )
					effectdata:SetOrigin( ply:GetPos() )
						
					util.Effect( "Explosion", effectdata )	
					util.BlastDamage(ply, ply, ply:GetPos(), 250, 100)
					util.Decal("Scorch", ply:GetPos(), ply:GetPos())

					if table.Count(ents.FindInSphere(ply:GetPos(),250)) > 0 then
						for k,v in pairs(ents.FindInSphere(ply:GetPos(),250)) do
							if v:GetClass() == "prop_physics" then
								if math.Rand(0,100) >= 70 then
									v:Ignite(250/20 - v:GetPos():Distance( ply:GetPos() )/20,0)
								end
								if v:IsValid() then
									constraint.RemoveAll(v)
									v:GetPhysicsObject():EnableMotion(true)
									v:GetPhysicsObject():Wake()
								end
							end
						end
					end
				end
			end
			
			
			if TableSearcher(ply.ClassNumber,"Cloak") == true then	
			
				
				
				if ply.first == false then 
					ply.ArmorDrainTick = 0
					
					ply.first = true
				end
				
				if ply:Armor() > 0 then 
					ply.MoveSpeed = ply:GetVelocity():Length()
			
					if ply.MoveSpeed < 10 then
						if ply:GetMaterial() ~= "models/shadertest/predator" then
							ply:SetMaterial("models/shadertest/predator")
						end
					elseif ply.MoveSpeed < 70 then
						if ply:GetMaterial() ~= "models/shadertest/predator" then
							ply:SetMaterial("models/shadertest/predator")
						end
					else
						if ply:GetMaterial() ~= "" then
							ply:SetMaterial("")
						end
					end
						
					if ply.ArmorDrainTick <= CurTime() then
						ply:SetArmor(ply:Armor() - 1) 
						ply.ArmorDrainTick = CurTime() + 1
					end

				else
					if ply:GetMaterial() ~= "" then
						ply:SetMaterial("")
					end
				end
			end
			
			if TableSearcher(ply.ClassNumber,"Necro") then
				if ply:GetMaxHealth() ~= 1 then 
					ply:SetMaxHealth(1)
				end
			end
			
			if TableSearcher(ply.ClassNumber,"Poop") then
						
				
				local ent
						
				if ply.first == false then
					ent = ents.Create("prop_physics")
					ent:SetModel("models/Gibs/HGIBS_spine.mdl")
					ent:SetMaterial("models/props_pipes/pipeset_metal.vmt")
					ent:SetOwner(ply)
					ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
						
					ply.first = true
				end

							
				if ply.PoopTick <= CurTime() then
					ply.PoopTick = CurTime() + 5
					ent:SetPos(ply:GetPos() + Vector(0,0,30))	
					ent:SetAngles(ply:GetAngles())
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
					else
						if (ply:Health() + amount) > 0 then
							ply:SetHealth(ply:Health() + amount)
						else
							ply:Kill()
						end
					end
				end
				
				
			end

			if TableSearcher(ply.ClassNumber,"ArmorRegen") == true then
				
				
				
				if ply.first == false then
					regensound = CreateSound(ply, "weapons/gauss/chargeloop.wav" )
					ply.ArmorRegenTime = 0
					ply.BeepArmorTick = 0
					ply.IsRegening = false
					ply.RegenSound = false
					
					ply.first = true
				end
				

				
				if ply.IsRegening == true then
					regensound:ChangePitch(50+ply:Armor(),0)
					if ply.RegenSound == false then
						regensound:Play()
						regensound:ChangeVolume(0.75,0)
						ply.RegenSound = true
					end
				else
					if ply.RegenSound == true then
						regensound:Stop()
						ply.RegenSound = false
					end
				end
					
				if ply:Armor() <= 0 then
					if ply.BeepArmorTick <= CurTime() then
						ply.BeepArmorTick = CurTime() + 0.1
						ply:EmitSound("buttons/button17.wav",50,100)
					end
				elseif ply:Armor() <= 25 then
					if ply.BeepArmorTick <= CurTime() then
						ply.BeepArmorTick = CurTime() + 0.25
						ply:EmitSound("buttons/button17.wav",50,125)
					end
				end

				if ply:Armor() < 100 then 
					if ply.ArmorRegenTime >= CurTime() then
						ply.IsRegening = false
					else
						ply:SetArmor(ply:Armor() + 1)
						if ply.IsRegening == false then
							ply.IsRegening = true
						end
					end
				end	
			end    
			
			
			
			if TableSearcher(ply.ClassNumber,"SoulAbsorb") then
			
				
				
				if ply.first == false then
					ply.SoulTick1 = 0
					ply.SoulsDelivered = 100
					ply.SoulCount = 0
					ply.SmallSoulsWarning = true
					ply.ZeroSoulsWarning = true
					ply.PissedOffDemons = false
					
					ply.first = true
					
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
				
				if ply.SoulTick1 <= CurTime() then
				
					if ply.SoulCount > 0 and ply:Armor() < ply.SoulCount*0.25 then	
						ply:SetArmor(ply:Armor() + 1)
					elseif ply.PissedOffDemons == true then
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
					
					ply.SoulsDelivered = ply.SoulsDelivered - 1
					ply.SoulTick1 = CurTime() + 1
					
				end
			end	
		end
	end
end

hook.Add("Think", "Check Perks Think", CheckPerks)

print("sv_class_perks_passive loaded")