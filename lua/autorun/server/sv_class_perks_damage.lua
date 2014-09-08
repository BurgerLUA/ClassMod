function ScaleClassDamage( ply, hitgroup, dmginfo )

	local DamageScale = 1
 
	if dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() ~= ply then 

		if TableSearcher(ply.ClassNumber,"Evasion") == true && math.random(0,100) >= 90 then
			DamageScale = 0
			ply:EmitSound("weapons/fx/nearmiss/bulletltor"..math.Rand(10,14)..".wav",100,math.Rand(90,110))
			dmginfo:ScaleDamage(0)
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Splash") == true then
			local result = ents.FindInSphere(ply:GetPos(),1000)
			local resultCount = table.Count(result)
			print(result)
			DamageScale = 0.9
			for i=1, resultCount do
				if result[i]:IsPlayer() == true then
					--print(result[i]:Nick())
					if result[i] ~= ply and result[i] ~= dmginfo:GetAttacker() then		
						if result[i]:Team() == dmginfo:GetAttacker():Team() and ply:Team() == 1001 then
							damage = dmginfo:GetBaseDamage()*0.1
							result[i]:TakeDamage(damage,  dmginfo:GetAttacker(), dmginfo:GetAttacker():GetActiveWeapon())
						elseif result[i]:Team() ~= dmginfo:GetAttacker():Team() and ply:Team() ~= 1001 then
							damage = dmginfo:GetBaseDamage()*0.1
							result[i]:TakeDamage(damage,  dmginfo:GetAttacker(), dmginfo:GetAttacker():GetActiveWeapon())
						end
					end
				end
			end
		end

		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Stunner") == true && math.Rand(0,100) >= 100 - (dmginfo:GetBaseDamage()/2) then
			DamageScale = 2
			ply:EmitSound("player/crit_received1.wav",100,100)
			dmginfo:GetAttacker():EmitSound("player/crit_hit.wav",100,100)
			ply.Stun = 0.25
		end
		
		if TableSearcher(ply.ClassNumber,"DamageTrade") == true then
			DamageScale = DamageScale*1.3
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"DamageTrade") == true then
			DamageScale = DamageScale*1.1
		end

		if TableSearcher(ply.ClassNumber,"Swap") == true then
			--print("Swap")
			if ply:Health() < 50 then 
				--print("Swaping")
				if ply:Alive() == false then return end
				if ply.NextSwapTime <= CurTime() then
					ply.NextSwapTime = CurTime() + 60
					local Players = player.GetAll()
					local rand = math.random(1,table.Count(Players))
					local toSwap = Players[rand]
					if toSwap == ply then
						if rand+1<= table.Count(Players) then
							toSwap = Players[rand+1]
							debugnum = rand+1
						elseif rand-1 >= 1 then 
							debugnum = rand-1
							toSwap = Players[rand-1]
						else
							print("weird")
						end
					end
					local pos1 = ply:GetPos()
					local pos2 = toSwap:GetPos()
					ply:SetPos(pos2)
					toSwap:SetPos(pos1)
					ply.Stun = 0.5
					toSwap.Stun = 0.5
					ply:EmitSound("ambient/machines/teleport4.wav",100,100)
					toSwap:EmitSound("ambient/machines/teleport4.wav",100,100)
				end
			end
		end

		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"LifeSteal") == true then
			if dmginfo:GetAttacker():Health() + math.max(0,dmginfo:GetDamage()*0.2) >= 200 then
				dmginfo:GetAttacker():SetHealth(200)
			else
				dmginfo:GetAttacker():SetHealth(dmginfo:GetAttacker():Health() + math.max(0,dmginfo:GetDamage()*0.2) )
			end
		end	
		
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Survivor") == true then
			DamageScale = 1 + math.abs(dmginfo:GetAttacker():Health()-dmginfo:GetAttacker():GetMaxHealth())/1000
		end	
		
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"ArmorSteal") == true then
			if dmginfo:GetDamage()*0.15 < ply:Armor() then 
				if dmginfo:GetAttacker():Armor() + dmginfo:GetDamage()*0.15 >= 200 then
					dmginfo:GetAttacker():SetArmor(200)
				else
					dmginfo:GetAttacker():SetArmor(dmginfo:GetAttacker():Armor() + dmginfo:GetDamage()*0.15 )
				end
			end
		end	

		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"SoulAbsorb") == true then
			dmginfo:GetAttacker().SoulCount = dmginfo:GetAttacker().SoulCount + math.floor(dmginfo:GetDamage())
			dmginfo:GetAttacker().SoulsDelivered = dmginfo:GetAttacker().SoulCount + math.floor(dmginfo:GetDamage())
		end
		
		
		if TableSearcher(ply.ClassNumber,"Helmet") == true then
			if hitgroup == HITGROUP_HEAD then
				ply:EmitSound("player/kevlar"..math.random(1,5)".wav",100,100)
				DamageScale = DamageScale*0.9
			else
				DamageScale = DamageScale*1
			 end
		end
		

		if TableSearcher(ply.ClassNumber,"Kevlar") == true then
			if hitgroup == HITGROUP_HEAD then
				DamageScale = DamageScale*1
			else
				DamageScale = DamageScale*0.85
				ply:EmitSound("player/kevlar"..math.random(1,5)".wav",100,100)
			end
		end
		
		
		if TableSearcher(ply.ClassNumber,"Shield") == true and math.random(0,100) >= 40 then
			DamageBlock = math.Rand(1,5)	
			if dmginfo:GetBaseDamage() - DamageBlock <= 0 then
				ply:EmitSound("weapons/fx/rics/ric"..math.Rand(1,5)..".wav",50,100)
			else
				ply:EmitSound("weapons/spy_assassin_knife_impact_02.wav",50,math.Rand(90,110))
			end
			dmginfo:SubtractDamage(DamageBlock)
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"AP") == true then
			DamageScale = DamageScale + (ply:Armor()*0.01) - 0.25
			print(DamageScale)
			if DamageScale > 1 then
				ply:EmitSound("mvm/melee_impacts/arrow_impact_robo0"..math.random(1,3)..".wav",100,100)
			else
				ply:EmitSound("mvm/melee_impacts/blade_hit_robo0"..math.random(1,3)..".wav",100,100)
			end
		end

		if TableSearcher(ply.ClassNumber,"BrainDamage") == true then
			if hitgroup == HITGROUP_HEAD then
				DamageScale = DamageScale*3
				ply:EmitSound("player/headshot"..math.random(1,2)..".wav",50,100)
			else
				DamageScale = DamageScale*0.85
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"HeadshotHunter") == true then
			if hitgroup == HITGROUP_HEAD then
				DamageScale = DamageScale*2
				ply:EmitSound("player/headshot"..math.random(1,2)..".wav",50,100)
			else
				DamageScale = DamageScale*0.5
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"ReflectDamage") == true then
			DamageScale = DamageScale*0.75
		end
	
		if TableSearcher(ply.ClassNumber,"ReflectDamage") == true then
			DamageScale = DamageScale*0.9
			if TableSearcher(dmginfo:GetAttacker().ClassNumber,"ReflectDamage") == false then
				dmginfo:GetAttacker():TakeDamage(dmginfo:GetBaseDamage()*DamageScale*0.1, ply, dmginfo:GetAttacker():GetActiveWeapon())
			end
		end
		
		if TableSearcher(ply.ClassNumber,"FlakJacketMajor") == true then
			if dmginfo:GetDamageType() == DMG_BLAST then
				DamageScale = DamageScale*0.75
				dmginfo:GetAttacker():TakeDamage(dmginfo:GetBaseDamage()*0.1), ply, dmginfo:GetAttacker():GetActiveWeapon())
				ply:EmitSound("player/pl_scout_jump"..math.Rand(1,4)..".wav",50,100)
			end
		end
		
		if TableSearcher(ply.ClassNumber,"FlakJacketMinor") == true then
			if dmginfo:GetDamageType() == DMG_BLAST then
				DamageScale = DamageScale*0.85
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Explosive") == true then
			if dmginfo:GetDamageType() == DMG_BLAST then
				DamageScale = DamageScale*1.1
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Drain") == true and math.random(0,100) >= 60 then
			if ply.Energy - dmginfo:GetBaseDamage()*DamageScale*0.1 > 0 then
				ply.Energy = ply.Energy - dmginfo:GetBaseDamage()*DamageScale*0.1
				--print(ply.Energy - dmginfo:GetBaseDamage()*DamageScale)
				ply:EmitSound("player/spy_shield_break.wav",50,100)
			else
				ply.Energy = 0
			end
			DamageScale = DamageScale*1.1
		end

		if TableSearcher(ply.ClassNumber,"Reversal") == true and math.random(0,100) >= 93 then
			ply:EmitSound("items/smallmedkit1.wav",100,100)
			if (ply:Health() + DamageScale * dmginfo:GetBaseDamage()) >= ply:GetMaxHealth() then 
				ply:SetHealth(ply:GetMaxHealth())
			else
				ply:SetHealth(ply:Health() + DamageScale * dmginfo:GetBaseDamage() )
			end
			DamageScale = DamageScale*0
		end

		if TableSearcher(ply.ClassNumber,"FakeDeath") == true then --MUST BE LAST
		
			if CurTime() < ply.HealthCoolDown then
				DamageScale = DamageScale*0
			end
		
			if hitgroup == HITGROUP_HEAD then
				secretmul = 3
			else
				secretmul = 1
			end
			if dmginfo:GetBaseDamage()*DamageScale*secretmul > ply:Health() - 10 then	
				if ply.FakeDeathCoolDown < CurTime() then
					ply.FakeDeathCoolDown = CurTime() + 10
					ply.HealthCoolDown = CurTime() + 1
					DamageScale=0
					ply:CreateRagdoll()
					net.Start( "PlayerKilledByPlayer" )
						net.WriteEntity( ply )
						net.WriteString( dmginfo:GetAttacker():GetActiveWeapon():GetClass() )
						net.WriteEntity( dmginfo:GetAttacker() )
					net.Broadcast()
					timer.Simple(0.01,function()
						ply:SetMaterial("models/effects/vol_light001")
					end)
					ply:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
					ply.Cloaked = true
				end
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"FakeDeath") == true then
			if dmginfo:GetAttacker().Cloaked == true then 
				dmginfo:GetAttacker():SetMaterial("")
				dmginfo:GetAttacker():GetActiveWeapon():SetMaterial("")
				DamageScale = DamageScale*2
				ply:EmitSound("player/crit_received1.wav",50,100)
				dmginfo:GetAttacker():EmitSound("player/crit_hit.wav",50,100)
				dmginfo:GetAttacker().Cloaked = false
			end
		end
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Trap") == true then
			if dmginfo:GetDamageType() == DMG_BLAST then
				ply.Stun = dmginfo:GetBaseDamage()*0.01
				DamageScale = 0
			end
		end
		
		if TableSearcher(ply.ClassNumber,"ArmorRegen") == true then
			ply.ArmorRegenTime = CurTime() + 5
        end	
		
		
		if TableSearcher(ply.ClassNumber,"Shatter") == true then
		
			if not ply.Immunity then 
				ply.Immunity = false
			end
			
			
			if ply.Immunity == true then
				DamageScale = DamageScale*0
			else
				DamageScale = DamageScale*1.5
			end

			print(dmginfo:GetDamageType())
			
			if ply:Armor() > 0 then
				if ply.Immunity == false then
					ply.Immunity = true
					ply.Stun = 1
					ply:SetMaterial("brick/brick_model.vmf")
					ply:EmitSound("weapons/demo_charge_hit_world"..math.random(1,3)..".wav")
					timer.Simple(1,function() 
						ply.Immunity = false 
						ply:SetMaterial("")
					end)
				end
			end
        end	
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Bargain") == true then
			if dmginfo:GetBaseDamage() - 10 < 0 then
				dmginfo:SetDamage(1)
			else
				dmginfo:SubtractDamage(10)
				DamagScale = DamageScale*2
			end
		end
		
		
		if TableSearcher(ply.ClassNumber,"BackDoor") == true and math.random(1,100) > 40 then
			ang1 = ply:GetAngles().y
			ang2 = dmginfo:GetAttacker():GetAngles().y
			damageblock = math.random(10,30)
			if ang1 - ang2 < 45 and ang1 - ang2 > -45 then
				ply:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
				dmginfo:GetAttacker():EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
				dmginfo:SubtractDamage(damageblock)	
			end
		end
		
		dmginfo:ScaleDamage(DamageScale)
		
		if hitgroup == HITGROUP_HEAD then
			HiddenScale = 2
		else
			HiddenScale = 1
		end

		ply:SetNWInt(dmginfo:GetAttacker():EntIndex(), ply:GetNWInt(dmginfo:GetAttacker():EntIndex()) + (HiddenScale * DamageScale * dmginfo:GetBaseDamage()))

	end	
end

hook.Add("ScalePlayerDamage","Scale Class Damage",ScaleClassDamage)



