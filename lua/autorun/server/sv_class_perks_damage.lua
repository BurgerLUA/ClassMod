function ScaleClassDamage( ply, hitgroup, dmginfo )

	local DamageScale = 1
 
	if dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() ~= ply then 

		if TableSearcher(ply.ClassNumber,"Evasion") == true && math.random(0,100) >= 90 then
			DamageScale = 0
			ply:EmitSound("ui/freeze_cam.wav",100,math.Rand(90,110))
			dmginfo:ScaleDamage(0)
		return end
		
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"Splash") == true then
			local result = ents.FindInSphere(ply:GetPos(),1000)
			local resultCount = table.Count(result)
			print(result)
			DamageScale = 0.9
			for i=1, resultCount do
				if result[i]:IsPlayer() == true then
					print(result[i]:Nick())
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
			if ply:IsFrozen() == false then
				ply:Freeze(true)
				timer.Simple(0.5,function() 
					ply:Freeze( false ) 
				end)
			end	
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
							--print("debug" ..debugnum)
							debugnum = rand+1
						elseif rand-1 >= 1 then 
							debugnum = rand-1
							--print("debug" .. debugnum)
							toSwap = Players[rand-1]
						else
							print("weird")
						end
					end
					
					local pos1 = ply:GetPos()
					local pos2 = toSwap:GetPos()
					
					ply:SetPos(pos2)
					toSwap:SetPos(pos1)
					
					ply:EmitSound("ambient/machines/teleport4.wav",100,100)
					toSwap:EmitSound("ambient/machines/teleport4.wav",100,100)
				end
			end
		end

		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"LifeSteal") == true then
			if dmginfo:GetAttacker():Health() + math.max(0,dmginfo:GetDamage()*0.1) >= 200 then
				dmginfo:GetAttacker():SetHealth(200)
			else
				dmginfo:GetAttacker():SetHealth(dmginfo:GetAttacker():Health() + math.max(0,dmginfo:GetDamage()*0.1) )
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
			if ply.ItemDurability > 0 then 
				ply.ItemDurablity = ply.ItemDurability - 1
				DamageBlock = math.Rand(1,5*(ply.ItemDurability/100))	
				dmginfo:SubtractDamage(DamageBlock)
				ply:EmitSound("player/bhit_helmet-1.wav",100,math.Rand(90,110))
			end
		end
	
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"AP") == true then
			if ply:Armor() > 0 then
				DamageScale = DamageScale + (ply:Armor()*0.005) - 0.25
				ply:EmitSound("mvm/physics/robo_impact_bullet0"..math.random(1,4)..".wav",100,math.Rand(90,110))
			end
		end

		
		if TableSearcher(ply.ClassNumber,"BrainDamage") == true then
			if hitgroup == HITGROUP_HEAD then
				DamageScale = DamageScale*3
				ply:EmitSound("player/headshot"..math.random(1,2)..".wav",100,100)
			else
				DamageScale = DamageScale*0.85
			end
		end
		
		
		if TableSearcher(dmginfo:GetAttacker().ClassNumber,"HeadshotHunter") == true then
			if hitgroup == HITGROUP_HEAD then
				DamageScale = DamageScale*2
				ply:EmitSound("player/headshot"..math.random(1,2)..".wav",100,100)
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
				if math.random(1,100) >= 80 and dmginfo:GetBaseDamage() > 30 then
					dmginfo:GetAttacker():TakeDamage(dmginfo:GetBaseDamage() - 30, ply, dmginfo:GetAttacker():GetActiveWeapon())
				end
			end
		end
		
		if TableSearcher(ply.ClassNumber,"FlakJacketMinor") == true then
			if dmginfo:GetDamageType() == DMG_BLAST then
				DamageScale = DamageScale*0.85
			end
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

		dmginfo:ScaleDamage(DamageScale)
		
		if hitgroup == HITGROUP_HEAD then
			HiddenScale = 2
		else
			HiddenScale = 1
		end
		
		
		
		ply:SetNWInt(dmginfo:GetAttacker():EntIndex(), ply:GetNWInt(dmginfo:GetAttacker():EntIndex()) + (HiddenScale * DamageScale * dmginfo:GetBaseDamage()))
		
		
	
		
		
		
		
	end
	
		--print(dmginfo:GetInflictor():GetClass())
		--print(dmginfo:GetAttacker():GetClass())
		
		
end

hook.Add("ScalePlayerDamage","Scale Class Damage",ScaleClassDamage)


