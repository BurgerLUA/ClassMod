function ScaleClassDamage( ply, hitgroup, dmginfo )

	if dmginfo:GetAttacker():IsPlayer() and dmginfo:GetAttacker() ~= ply then 
	
		if not ply:HasGodMode() and GetConVarNumber("sbox_godmode") == 0 then
	
			local DamageData = {}
			DamageData.Victim = ply
			DamageData.Attacker = dmginfo:GetAttacker()
			DamageData.Damage = dmginfo:GetDamage()
			DamageData.HitGroup = hitgroup
			DamageData.DamageType = dmginfo:GetDamageType()
			
			local OldDamage = dmginfo:GetDamage()

			--HARD DAMAGE PREVETION
			DamageData = DMGPERK_Evasion(DamageData)
			
			--DAMAGE SUBTRACTION
			DamageData = DMGPERK_Shield(DamageData)
			DamageData = DMGPERK_FrontDoor(DamageData)
			DamageData = DMGPERK_BackDoor(DamageData)
			DamageData = DMGPERK_Bargain(DamageData)
			DamageData = DMGPERK_Forced(DamageData)
			
			--DAMAGE MULTIFPLICATION
			DamageData = DMGPERK_Trap(DamageData)
			DamageData = DMGPERK_Shatter(DamageData)
			DamageData = DMGPERK_AP(DamageData)
			DamageData = DMGPERK_BrainDamage(DamageData)
			DamageData = DMGPERK_FlakJacketMajor(DamageData)
			DamageData = DMGPERK_FlakJacketMinor(DamageData)
			DamageData = DMGPERK_Explosive(DamageData)
			DamageData = DMGPERK_HeadshotHunter(DamageData)
			DamageData = DMGPERK_Helmet(DamageData)
			DamageData = DMGPERK_Kevlar(DamageData)
			DamageData = DMGPERK_Survivor(DamageData)
			DamageData = DMGPERK_DamageTrade1(DamageData)
			DamageData = DMGPERK_DamageTrade2(DamageData)
			DamageData = DMGPERK_ReflectDamage1(DamageData) -- Damage Reduction
			
			--DAMAGE AVOIDANCE
			DamageData = DMGPERK_FakeDeath1(DamageData)
			DamageData = DMGPERK_FakeDeath2(DamageData)
			DamageData = DMGPERK_Swap(DamageData)
			DamageData = DMGPERK_ArmorDependant(DamageData)
			
			--DAMAGE THEIVERY
			DamageData = DMGPERK_LifeSteal(DamageData)
			DamageData = DMGPERK_ArmorSteal(DamageData)
			
			--DAMAGE TRANSFER
			DamageData = DMGPERK_Splash(DamageData)
			DamageData = DMGPERK_ReflectDamage2(DamageData) -- Damage Reflect
			DamageData = DMGPERK_Reversal(DamageData)
			DamageData = DMGPERK_SoulAbsorb(DamageData)
			DamageData = DMGPERK_Stunner(DamageData)
			
			--MISC
			DamageData = DMGPERK_ArmorRegen(DamageData)
			DamageData = DMGPERK_Drain(DamageData) -- USELESS
			--DamageData = DMGPERK_Slayer(DamageData)
			
			
			
			
			
			
			
			
			
			
			--ply:SetNWInt(attacker:EntIndex(), ply:GetNWInt(attacker:EntIndex()) + (HiddenScale * DamageScale * dmginfo:GetBaseDamage()))
			
			if OldDamage ~= DamageData.Damage then
				print(OldDamage .. "=>" .. DamageData.Damage)
			end
			
			if DamageData.Damage then
				dmginfo:SetDamage(DamageData.Damage)
			end
			
		end
		
	end	
	

	
end

hook.Add("ScalePlayerDamage","Scale Class Damage",ScaleClassDamage)

function DMGPERK_AP(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"AP") == true then
	
		if DamageData.Victim:Armor() > 0 then
			DamageScale = DamageData.Victim:Armor()*0.01
		else
			DamageScale = -0.5
		end
		
		if DamageScale > 1 then
			DamageData.Victim:EmitSound("mvm/melee_impacts/arrow_impact_robo0"..math.random(1,3)..".wav",100,100)
		else
			DamageData.Victim:EmitSound("mvm/melee_impacts/blade_hit_robo0"..math.random(1,3)..".wav",100,100)
		end
		
		DamageData.Damage = DamageData.Damage + (DamageData.Damage * DamageScale)

	end
	
	return DamageData
	
end

function DMGPERK_ArmorDependant(DamageData)

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

function DMGPERK_ArmorRegen(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"ArmorRegen") == true then
		DamageData.Victim.ArmorRegenTime = CurTime() + 5
    end	
	
	return DamageData
	
end

function DMGPERK_ArmorSteal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"ArmorSteal") == true then
		if DamageData.Damage*0.15 < DamageData.Victim:Armor() then 
		
			DamageData.Attacker:SetArmor(math.Clamp(DamageData.Attacker:Armor() + DamageData.Damage*0.30,0,200))
		
		end
	end	
	
	return DamageData
	
end

function DMGPERK_BackDoor(DamageData)

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

function DMGPERK_Bargain(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"Bargain") == true then

		DamageData.Damage = math.max(1,(DamageData.Damage - 5) * 2)
		
		if DamageData.Damage == 1 then
			DamageData.Victim:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
			DamageData.Attacker:EmitSound("weapons/fx/rics/ric"..math.random(1,5)..".wav",50,100)
		end
		
	end
	
	return DamageData
	
end

function DMGPERK_BrainDamage(DamageData)

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

function DMGPERK_DamageTrade1(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"DamageTrade") == true then
		DamageData.Damage = DamageData.Damage * 1.3
	end
	
	return DamageData
	
end
	
function DMGPERK_DamageTrade2(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"DamageTrade") == true then
		DamageData.Damage = DamageData.Damage * 1.3
	end
	
	return DamageData
	
end


function DMGPERK_Drain(DamageData) --Useless 

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

function DMGPERK_Evasion(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Evasion") == true and math.random(0,100) >= 80 then
	
		DamageData.Damage = 0
		DamageData.Victim:EmitSound("weapons/barret_arm_shot.wav",100,math.random(90,110))
		DamageData.Attacker:EmitSound("weapons/barret_arm_shot.wav",100,math.random(90,110))
		
	end
	
	return DamageData
	
end

function DMGPERK_Explosive(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Explosive") == true then
		if DamageData.DamageType == DMG_BLAST then
			DamageData.Damage = DamageData.Damage * 1.1
		end
	end
	
	return DamageData
	
end

function DMGPERK_FakeDeath1(DamageData)

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
					if DamageData.Victim:Armor() > 0 and DamageData.Victim:Alive() then
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
					
					local weapon = "weapon_cs_flashbang"
					
					if IsValid(DamageData.Attacker:GetActiveWeapon()) then
						weapon = DamageData.Attacker:GetActiveWeapon():GetClass()
					end
					
					net.WriteString( DamageData.Attacker:GetActiveWeapon():GetClass() )
					net.WriteEntity( DamageData.Attacker )
				net.Broadcast()
				
				timer.Simple(0.01,function()
					DamageData.Victim:SetMaterial("models/effects/vol_light001")
				end)

				
				--DamageData.Victim:GetActiveWeapon():SetMaterial("models/effects/vol_light001")
				DamageData.Victim.Cloaked = true
			end
		end
		
	end
	
	return DamageData
	
end

function DMGPERK_FakeDeath2(DamageData)

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

function DMGPERK_FlakJacketMajor(DamageData)

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

function DMGPERK_FlakJacketMinor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"FlakJacketMinor") == true then
		if DamageData.DamageType == DMG_BLAST then
			DamageData.Damage = DamageData.Damage * 0.85
		end
	end
	
	return DamageData
	
end

function DMGPERK_Forced(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Forced") == true then
	
		DamageData.Damage = math.max(1,DamageData.Damage - 50) * 3
	
	end
	
	return DamageData
end


function DMGPERK_FrontDoor(DamageData)

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

function DMGPERK_HeadshotHunter(DamageData)

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

function DMGPERK_Helmet(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Helmet") == true then
		if DamageData.HitGroup == HITGROUP_HEAD then
		
			DamageData.Victim:EmitSound("player/kevlar"..math.random(1,5)".wav",100,100)
			DamageData.Damage = DamageData.Damage * 0.8
			
		end
	end
	
	return DamageData
	
end

function DMGPERK_Kevlar(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Victim.ClassNumber,"Kevlar") == true then
		if DamageData.HitGroup ~= HITGROUP_HEAD then

			DamageData.Victim:EmitSound("player/kevlar"..math.random(1,5)..".wav",100,100)
			DamageData.Damage = DamageData.Damage * 0.75
			
		end
	end
	
	return DamageData
	
end

function DMGPERK_LifeSteal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"LifeSteal") == true then
		
		DamageData.Attacker:SetHealth(math.Clamp( DamageData.Attacker:Health() + DamageData.Damage*0.2 , 1 , 200 ) )
		
	end	
	
	return DamageData
	
end
	
function DMGPERK_ReflectDamage1(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"ReflectDamage") == true then
		DamageData.Damage = DamageData.Damage * 0.25
	end
	
	return DamageData
	
end
	
function DMGPERK_ReflectDamage2(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"ReflectDamage") == true then
		if TableSearcher(DamageData.Attacker.ClassNumber,"ReflectDamage") == false then
			DamageData.Attacker:TakeDamage(DamageData.Damage*0.75, DamageData.Victim, DamageData.Attacker:GetActiveWeapon())
			
			DamageData.Victim:EmitSound("weapons/cow_mangler_reload_final.wav",50,100)
			DamageData.Attacker:EmitSound("weapons/cow_mangler_reload_final.wav",50,100)
			
			
		end
	end
	
	return DamageData
	
end		

function DMGPERK_Reversal(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Reversal") == true and math.random(0,100) >= 90 then
	
		DamageData.Victim:EmitSound("items/smallmedkit1.wav",100,100)
		DamageData.Victim:SetHealth(math.Clamp(DamageData.Victim:Health() + DamageData.Damage,1,200))
		
		DamageData.Damage = 0
	end
	
	return DamageData
	
end



function DMGPERK_Shatter(DamageData)

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

function DMGPERK_Shield(DamageData)

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

function DMGPERK_SoulAbsorb(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"SoulAbsorb") == true then
		DamageData.Attacker.SoulCount = DamageData.Attacker.SoulCount + math.floor(DamageData.Damage)
		DamageData.Attacker.SoulsDelivered = DamageData.Attacker.SoulCount + math.floor(DamageData.Damage)
	end
	
	return DamageData
	
end

function DMGPERK_Splash(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end
	
	if TableSearcher(DamageData.Attacker.ClassNumber,"Splash") == true then

		for k,v in pairs (player.GetAll()) do
			
			if v ~= DamageData.Victim and v ~= DamageData.Attacker then		
				if (v:Team() == DamageData.Attacker:Team() and DamageData.Victim:Team() == 1001) or (result[i]:Team() ~= DamageData.Attacker:Team() and DamageData.Victim:Team() ~= 1001) then
					v:TakeDamage(DamageData.Damage*0.03,  DamageData.Attacker, DamageData.Attacker:GetActiveWeapon())
					
					v:EmitSound("weapons/fist_hit_world1.wav",50,math.random(90,110))
					
				end
			end
				
		end
	end
	
	return DamageData
	
end

function DMGPERK_Stunner(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Attacker.ClassNumber,"Stunner") == true && math.random(0,100) >= 100 - (DamageData.Damage/2) then
		DamageData.Damage = DamageData.Damage * 2
		DamageData.Victim:EmitSound("player/crit_received1.wav",100,100)
		DamageData.Attacker:EmitSound("player/crit_hit.wav",100,100)
		DamageData.Victim.Stun = 0.25
	end
	
	return DamageData
	
end

function DMGPERK_Survivor(DamageData)

	if DamageChecker(DamageData) == false then return DamageData end

	if TableSearcher(DamageData.Victim.ClassNumber,"Survivor") == true then
		DamageData.Damage = DamageData.Damage * ( 1 - math.Clamp(DamageData.Attacker:GetMaxHealth()-DamageData.Attacker:Health(),0,50)/100 )
	end	
	
	return DamageData
	
end

function DMGPERK_Swap(DamageData)

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

function DMGPERK_Trap(DamageData)

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