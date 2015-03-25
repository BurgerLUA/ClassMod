function ScaleClassDamage( ply, hitgroup, dmginfo )

	if dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() ~= ply then 
	
		local DamageData = {}
		DamageData.Victim = ply
		DamageData.Attacker = dmginfo:GetAttacker()
		DamageData.Damage = dmginfo:GetDamage()
		DamageData.HitGroup = hitgroup
		DamageData.DamageType = dmginfo:GetDamageType()
		
		local OldDamage = dmginfo:GetDamage()

		DamageData = PERK_Forced(DamageData)
		DamageData = PERK_Evasion(DamageData)
		DamageData = PERK_Splash(DamageData)
		DamageData = PERK_Stunner(DamageData)
		DamageData = PERK_DamageTrade1(DamageData)
		DamageData = PERK_DamageTrade2(DamageData)
		DamageData = PERK_Swap(DamageData)
		DamageData = PERK_Survivor(DamageData)
		DamageData = PERK_SoulAbsorb(DamageData)
		DamageData = PERK_Helmet(DamageData)
		DamageData = PERK_Kevlar(DamageData)
		DamageData = PERK_Shield(DamageData)
		DamageData = PERK_AP(DamageData)
		DamageData = PERK_BrainDamage(DamageData)
		DamageData = PERK_HeadshotHunter(DamageData)
		DamageData = PERK_ReflectDamage1(DamageData)
		DamageData = PERK_ReflectDamage2(DamageData)
		DamageData = PERK_FlakJacketMajor(DamageData)
		DamageData = PERK_FlakJacketMinor(DamageData)
		DamageData = PERK_Explosive(DamageData)
		DamageData = PERK_Drain(DamageData)
		DamageData = PERK_Reversal(DamageData)
		DamageData = PERK_Trap(DamageData)
		DamageData = PERK_ArmorRegen(DamageData)
		DamageData = PERK_Shatter(DamageData)
		DamageData = PERK_Bargain(DamageData)
		DamageData = PERK_ArmorDependant(DamageData)
		DamageData = PERK_FrontDoor(DamageData)
		DamageData = PERK_BackDoor(DamageData)
		DamageData = PERK_FakeDeath1(DamageData)
		DamageData = PERK_FakeDeath2(DamageData)
		
		--ply:SetNWInt(attacker:EntIndex(), ply:GetNWInt(attacker:EntIndex()) + (HiddenScale * DamageScale * dmginfo:GetBaseDamage()))
		
		if OldDamage ~= DamageData.Damage then
			print(OldDamage .. "=>" .. DamageData.Damage)
		end
		
		if DamageData.Damage then
			dmginfo:SetDamage(DamageData.Damage)
		end
		
	end	
	

	
end

hook.Add("ScalePlayerDamage","Scale Class Damage",ScaleClassDamage)

function PERK_AP(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"AP") == true then
		DamageScale = math.Clamp( (DamageData.Victim:Armor()*0.01) - 0.25, 0.25, 1 )
		if DamageScale > 1 then
			DamageData.Victim:EmitSound("mvm/melee_impacts/arrow_impact_robo0"..math.random(1,3)..".wav",100,100)
		else
			DamageData.Victim:EmitSound("mvm/melee_impacts/blade_hit_robo0"..math.random(1,3)..".wav",100,100)
		end
		
		DamageData.Damage = DamageData.Damage * DamageScale

	end
	
	return DamageData
	
end

function PERK_ArmorDependant(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"ArmorDependant") == true then
	
		local DamageScale = 10
	
		if DamageData.Victim:Armor() - DamageData.Damage > 0 then
			DamageScale = 0
			DamageData.Victim:SetArmor(DamageData.Victim:Armor() - DamageData.Damage*2)
		end
		
		DamageData.Damage = DamageData.Damage * DamageScale
		
	end
	
	return DamageData
	
end

function PERK_ArmorRegen(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"ArmorRegen") == true then
		DamageData.Victim.ArmorRegenTime = CurTime() + 5
    end	
	
	return DamageData
	
end

function PERK_ArmorSteal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"ArmorSteal") == true then
		if DamageData.Damage*0.15 < DamageData.Victim:Armor() then 
		
			DamageData.Attacker:SetArmor(math.Clamp(DamageData.Attacker:Armor() + DamageData.Damage*0.30,0,200))
		
		end
	end	
	
	return DamageData
	
end

function PERK_BackDoor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"BackDoor") == true then
		ang1 = DamageData.Victim:GetAngles().y
		ang2 = DamageData.Attacker:GetAngles().y
		
		if ang1 - ang2 < 45 and ang1 - ang2 > -45 then
			local DamageBlock = math.random(10,30)
			DamageData.Victim:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			DamageData.Attacker:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			
			DamageData.Damage = math.max(0,DamageData.Damage - DamageBlock)
		end
		
	end
	
	return DamageData
	
end

function PERK_Bargain(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"Bargain") == true then

		DamageData.Damage = math.max(1,(DamageData.Damage - 10) * 2)
		
		if DamageData.Damage == 1 then
			DamageData.Victim:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			DamageData.Attacker:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
		end
		
	end
	
	return DamageData
	
end

function PERK_BrainDamage(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"BrainDamage") == true then
	
		local DamageScale = 0.85
	
		if DamageData.HitGroup == HITGROUP_HEAD then
			DamageScale = DamageScale*2
			DamageData.Victim:EmitSound("player/headshot"..math.random(1,2)..".wav",50,100)
		end
		
		DamageData.Damage = DamageData.Damage * DamageScale
		
	end
	
	return DamageData
	
end

function PERK_DamageTrade1(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"DamageTrade") == true then
		DamageData.Damage = DamageData.Damage * 1.3
	end
	
	return DamageData
	
end
	
function PERK_DamageTrade2(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"DamageTrade") == true then
		DamageData.Damage = DamageData.Damage * 1.3
	end
	
	return DamageData
	
end


function PERK_Drain(DamageData) --Useless 

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"Drain") == true then
	
		if DamageData.Victim.Energy - DamageData.Damage*0.5 > 0 then
			DamageData.Victim.Energy = DamageData.Victim.Energy - DamageData.Damage*0.5
		else
			DamageData.Victim.Energy = 0
		end
		
		
		
		DamageScale = DamageScale*1.1
		
		DamageData.Damage = DamageData.Damage * DamageScale
		
	end
	
	return DamageData
	
end

function PERK_Evasion(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Evasion") == true and math.random(0,100) >= 80 then
	
		DamageData.Damage = 0
		DamageData.Victim:EmitSound("weapons/fx/nearmiss/bulletltor"..math.random(10,14)..".wav",100,math.random(90,110))
		
	end
	
	return DamageData
	
end

function PERK_Explosive(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Explosive") == true then
		if DamageData.DamageType == DMG_BLAST then
			DamageData.Damage = DamageData.Damage * 1.1
		end
	end
	
	return DamageData
	
end

function PERK_FakeDeath1(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"FakeDeath") == true then --MUST BE LAST
	
		if not DamageData.Victim.FakeDeathCoolDown then
			DamageData.Victim.FakeDeathCoolDown = 0
		end
		
		if not DamageData.Victim.Cloaked then
			DamageData.Victim.Cloaked = false
		end
		
		if not DamageData.Victim.HealthCoolDown then
			DamageData.Victim.HealthCoolDown = 0
		end
	
		if CurTime() <= DamageData.Victim.HealthCoolDown then
			DamageData.Damage = 0
		end
	
		if DamageData.HitGroup == HITGROUP_HEAD then
			secretmul = 0 --basically headshots don't trigger it
		else
			secretmul = 1
		end
		
		if DamageData.Damage*secretmul > DamageData.Victim:Health() - 10 then	
			if DamageData.Victim.FakeDeathCoolDown < CurTime() then
				DamageData.Victim.FakeDeathCoolDown = CurTime() + 10
				DamageData.Victim.HealthCoolDown = CurTime() + 1
				DamageData.Damage = 0
				DamageData.Victim:CreateRagdoll()

				DamageData.Victim:SetArmor(100)
				
				timer.Create("cloakrunout"..DamageData.Victim:EntIndex(),0.05, 0, function()
					if DamageData.Victim:Armor() > 1 and DamageData.Victim:Alive() then
						DamageData.Victim:SetArmor(DamageData.Victim:Armor()-1)
					else
						DamageData.Victim.Cloaked = false
						DamageData.Attacker:SetMaterial("")
						if DamageData.Attacker:GetActiveWeapon():IsValid() then
							DamageData.Attacker:GetActiveWeapon():SetMaterial("")
						end
						timer.Destroy("cloakrunout" .. DamageData.Victim:EntIndex())
					end
				end)
				
				net.Start( "PlayerKilledByPlayer" )
					net.WriteEntity( DamageData.Victim )
					net.WriteString( DamageData.Attacker:GetActiveWeapon():GetClass() )
					net.WriteEntity( DamageData.Attacker )
				net.Broadcast()
				
				timer.Simple(0.01,function()
					DamageData.Victim:SetMaterial("models/effects/vol_light001")
				end)

				
				DamageData.Victim:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
				DamageData.Victim.Cloaked = true
			end
		end
		
	end
	
	return DamageData
	
end

function PERK_FakeDeath2(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"FakeDeath") == true then
	
		if not DamageData.Attacker.FakeDeathCoolDown then
			DamageData.Attacker.FakeDeathCoolDown = 0
		end
		
		if not DamageData.Attacker.Cloaked then
			DamageData.Attacker.Cloaked = false
		end
	
	
		DamageData.Attacker:SetMaterial("")
		DamageData.Attacker:GetActiveWeapon():SetMaterial("")
	
		if DamageData.Attacker.Cloaked == true then 
			DamageData.Damage = DamageData.Damage * 2
			DamageData.Victim:EmitSound("player/crit_received1.wav",50,100)
			DamageData.Attacker:EmitSound("player/crit_hit.wav",50,100)
			DamageData.Attacker.Cloaked = false
		end
		
		
		
	end
	
	return DamageData
	
end

function PERK_FlakJacketMajor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"FlakJacketMajor") == true then
		if DamageData.DamageType == DMG_BLAST then
		
			DamageData.Attacker:TakeDamage(DamageData.Damage*0.1, DamageData.Victim, DamageData.Attacker:GetActiveWeapon())
			DamageData.Damage = DamageData.Damage * 0.5
			DamageData.Victim:EmitSound("player/pl_scout_jump"..math.random(1,4)..".wav",50,100)
			
			DamageData.Damage = DamageData.Damage * DamageScale
			
		end
		
		
	end
	
	return DamageData
	
end

function PERK_FlakJacketMinor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"FlakJacketMinor") == true then
		if DamageData.DamageType == DMG_BLAST then
			DamageData.Damage = DamageData.Damage * 0.85
		end
	end
	
	return DamageData
	
end

function PERK_Forced(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Forced") == true then
	
		DamageData.Damage = math.max(1,DamageData.Damage - 50) * 3
	
	end
	
	return DamageData
end


function PERK_FrontDoor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"FrontDoor") == true then
		ang1 = DamageData.Victim:GetAngles().y
		ang2 = DamageData.Attacker:GetAngles().y
		local DamageBlock = math.random(10,30)
		if ang1 - ang2 > 45 and ang1 - ang2 < -45 then
			DamageData.Victim:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			DamageData.Attacker:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			
			DamageData.Damage = math.max(0,DamageData.Damage - DamageBlock)
			
		end
	end
	
	return DamageData
	
end

function PERK_HeadshotHunter(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"HeadshotHunter") == true then
	
		local DamageScale = 0.5
	
		if DamageData.HitGroup == HITGROUP_HEAD then
			DamageScale = 2
			DamageData.Victim:EmitSound("player/headshot"..math.random(1,2)..".wav",50,100)
		end
		
		DamageData.Damage = DamageData.Damage * DamageScale
		
	end
	
	return DamageData
	
end

function PERK_Helmet(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Helmet") == true then
		if DamageData.HitGroup == HITGROUP_HEAD then
		
			DamageData.Victim:EmitSound("player/kevlar"..math.random(1,5)".wav",100,100)
			DamageData.Damage = DamageData.Damage * 0.8
			
		end
	end
	
	return DamageData
	
end

function PERK_Kevlar(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"Kevlar") == true then
		if DamageData.HitGroup ~= HITGROUP_HEAD then

			DamageData.Victim:EmitSound("player/kevlar"..math.random(1,5)..".wav",100,100)
			DamageData.Damage = DamageData.Damage * 0.75
			
		end
	end
	
	return DamageData
	
end

function PERK_LifeSteal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"LifeSteal") == true then
		
		DamageData.Attacker:SetHealth(math.Clamp( DamageData.Attacker:Health() + math.max(0,DamageData.Damage*0.2) , 1 , 200 ) )
		
	end	
	
	return DamageData
	
end
	
function PERK_ReflectDamage1(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"ReflectDamage") == true then
		DamageData.Damage = DamageData.Damage * 0.75
	end
	
	return DamageData
	
end
	
function PERK_ReflectDamage2(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"ReflectDamage") == true then
		if TableSearcher(DamageData.Attacker.ClassNumber,"ReflectDamage") == false then
			DamageData.Attacker:TakeDamage(DamageData.Damage*0.25, DamageData.Victim, DamageData.Attacker:GetActiveWeapon())
		end
	end
	
	return DamageData
	
end		

function PERK_Reversal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Reversal") == true and math.random(0,100) >= 90 then
	
		DamageData.Victim:EmitSound("items/smallmedkit1.wav",100,100)
		
		if (DamageData.Victim:Health() + DamageData.Damage) >= DamageData.Victim:GetMaxHealth() then 
			DamageData.Victim:SetHealth(DamageData.Victim:GetMaxHealth())
		else
			DamageData.Victim:SetHealth(DamageData.Victim:Health() + DamageData.Damage )
		end
		
		DamageData.Damage = 0
	end
	
	return DamageData
	
end



function PERK_Shatter(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Shatter") == true then

		if not DamageData.Victim.Immunity then 
			DamageData.Victim.Immunity = 0
		end

		if DamageData.Victim:Armor() > 0 then
			if DamageData.Victim.Immunity == 0 then
				DamageData.Victim.Immunity = 1
				
				local actualdamage = DamageInfo()
				actualdamage:SetDamage(DamageData.Damage*1.5)
				actualdamage:SetAttacker(DamageData.Attacker)
				actualdamage:SetInflictor(DamageData.Attacker:GetActiveWeapon())
				actualdamage:SetDamageType(DMG_BULLET)
				
				DamageData.Victim:TakeDamageInfo( actualdamage )
				DamageData.Victim.Stun = 1
				DamageData.Victim:SetMaterial("brick/brick_model.vmf")
				DamageData.Victim:EmitSound("weapons/demo_charge_hit_world"..math.random(1,3)..".wav")
				timer.Simple(1,function() 
					DamageData.Victim.Immunity = 0
					DamageData.Victim:SetMaterial("")
				end)
			end
		end
		
		if DamageData.Victim.Immunity == 1 then
			DamageData.Damage = 0
		end

	end	
	
	return DamageData
	
end

function PERK_Shield(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"Shield") == true and math.random(0,100) >= 40 then
		--print("BLOCK")
		local DamageBlock = math.random(10,20)	
		if DamageData.Damage - DamageBlock <= 0 then
			DamageData.Victim:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
		else
			DamageData.Victim:EmitSound("weapons/spy_assassin_knife_impact_02.wav",50,math.random(90,110))
		end
		
		DamageData.Damage = math.max(0,DamageData.Damage - DamageBlock)
		
	end
	
	return DamageData
	
end

function PERK_SoulAbsorb(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"SoulAbsorb") == true then
		DamageData.Attacker.SoulCount = DamageData.Attacker.SoulCount + math.floor(DamageData.Damage)
		DamageData.Attacker.SoulsDelivered = DamageData.Attacker.SoulCount + math.floor(DamageData.Damage)
	end
	
	return DamageData
	
end

function PERK_Splash(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"Splash") == true then
		local result = ents.FindInSphere(DamageData.Victim:GetPos(),1000)
		local resultCount = table.Count(result)
		for i=1, resultCount do
			if result[i]:IsPlayer() == true then
			
				if result[i] ~= DamageData.Victim and result[i] ~= DamageData.Attacker then		
					if (result[i]:Team() == DamageData.Attacker:Team() and DamageData.Victim:Team() == 1001) or (result[i]:Team() ~= DamageData.Attacker:Team() and DamageData.Victim:Team() ~= 1001) then
						result[i]:TakeDamage(DamageData.Damage*0.25,  DamageData.Attacker, DamageData.Attacker:GetActiveWeapon())
					end
				end
				
			end
		end
	end
	
	return DamageData
	
end

function PERK_Stunner(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Stunner") == true && math.random(0,100) >= 100 - (DamageData.Damage/2) then
		DamageData.Damage = DamageData.Damage * 2
		DamageData.Victim:EmitSound("player/crit_received1.wav",100,100)
		DamageData.Attacker:EmitSound("player/crit_hit.wav",100,100)
		DamageData.Victim.Stun = 0.25
	end
	
	return DamageData
	
end

function PERK_Survivor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Survivor") == true then
		DamageData.Damage = DamageData.Damage * ( 1 - math.Clamp(DamageData.Attacker:GetMaxHealth()-DamageData.Attacker:Health(),0,50)/100 )
	end	
	
	return DamageData
	
end

function PERK_Swap(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Swap") == true then

		if not DamageData.Victim.NextSwapTime then
			DamageData.Victim.NextSwapTime = 0 
		end
	
		if DamageData.Victim:Health() < 50 then 
			if DamageData.Victim:Alive() == false then return end
			if DamageData.Victim.NextSwapTime <= CurTime() then
				DamageData.Damage = 0
				DamageData.Victim.NextSwapTime = CurTime() + 60
				local Players = player.GetAll()
				local rand = math.random(1,table.Count(Players))
				local toSwap = Players[rand]
				if toSwap == DamageData.Victim then
					if rand+1<= table.Count(Players) then
						toSwap = Players[rand+1]
						debugnum = rand+1
					else
						debugnum = rand-1
						toSwap = Players[rand-1]
					end
				end
				local pos1 = DamageData.Victim:GetPos()
				local pos2 = toSwap:GetPos()
				DamageData.Victim:SetPos(pos2)
				toSwap:SetPos(pos1)
				DamageData.Victim.Stun = 0.5
				toSwap.Stun = 0.5
				DamageData.Victim:EmitSound("ambient/machines/teleport4.wav",100,100)
				toSwap:EmitSound("ambient/machines/teleport4.wav",100,100)
			end
		end
	end
	
	return DamageData
	
end

function PERK_Trap(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Trap") == true then
		if DamageData.DamageType == DMG_BLAST then
			DamageData.Victim.Stun = DamageData.Damage*0.05
			DamageData.Damage = 0
		end
	end
	
	return DamageData
	
end

function DamageChecker(DamageData)

	--PrintTable(DamageData)

	if DamageData.Damage < 1 then 
		return false
	end

end

print("sv_class_perks_damage loaded")