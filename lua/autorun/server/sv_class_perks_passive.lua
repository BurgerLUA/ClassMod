function CheckPerks()
	for k,v in pairs(player.GetAll()) do 
		local ply = v
		
		if ply:Alive() == false or ply.HasChangedClass == true then
			ply.first = false
			ply.HasChangedClass = false
		else

			PASPERK_Annoying(v)
			PASPERK_ArcLight(v)
			PASPERK_ArmorRegen(v)
			PASPERK_AuraLeech(v)
			PASPERK_Bleedout(v)
			PASPERK_Cloak(v)
			PASPERK_DeadLight(v)
			PASPERK_GlobalKS(v)
			PASPERK_LifeRegen(v)
			PASPERK_Medic(v)
			PASPERK_Mystical(v)
			PASPERK_Necro(v)
			PASPERK_Poop(v)
			PASPERK_Rambo(v)
			PASPERK_Slayer(v)
			PASPERK_SoulAbsorb(v)
			PASPERK_SpeedChange(v)
			PASPERK_SpeedShield(v)

		end

			
			
	end
end

hook.Add("Think", "Check Perks Think", CheckPerks)



function PASPERK_Annoying(ply)

	if TableSearcher(ply.ClassNumber,"Annoying") == true then	
	
		if ply.first == false then
			ply.LifeStealTick = 0
			
			ply.first = true
		end
		
		if ply.LifeStealTick <= CurTime() then
			ply.LifeStealTick = CurTime()+1.5
			if ply:Health() > 1 then
				ply:SetHealth(ply:Health() - 1)
			else
				ply:Kill()
			end
		end
		
	end

end

function PASPERK_ArcLight(ply)

	if TableSearcher(ply.ClassNumber,"ArcLight") == true then
		
		if not ply.ArcLightTick then
			ply.ArcLightTick = 1
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

end

function PASPERK_ArmorRegen(ply)
	if TableSearcher(ply.ClassNumber,"ArmorRegen") == true then
		
		if not regensound then
			regensound = CreateSound(ply, "weapons/gauss/chargeloop.wav" )
		end
		
		if not ply.ArmorRegenTime then
			ply.ArmorRegenTime = 0
		end
		
		if not ply.ArmorRegenTick then
			ply.ArmorRegenTick = 0
		end

		if not ply.IsRegening then
			ply.IsRegening = false
		end
		
		if not ply.RegenSound then
			ply.RegenSound = false
		end
		
		if not ply.BeepArmorTick then
			ply.BeepArmorTick = 0
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
				if ply.ArmorRegenTick <= CurTime() then
					ply:SetArmor(ply:Armor() + 1)
					ply.ArmorRegenTick = CurTime() + 0.04
				end
				if ply.IsRegening == false then
					ply.IsRegening = true
				end
			end
		else
			ply.IsRegening = false
			if ply.RegenSound == true then
				regensound:Stop()
				ply.RegenSound = false
			end
		end	   
	
	end


end

function PASPERK_AuraLeech(ply)

	if TableSearcher(ply.ClassNumber,"AuraLeech") == true then

		if not ply.LeechTick then 
			ply.LeechTick = 1
		end
			
		if ply.LeechTick <= CurTime() then
			ply.LeechTick = CurTime() + 1
			local result = ents.FindInSphere(ply:GetPos(),500)
			local resultCount = table.Count(result)

			for i=1, resultCount do
				if result[i]:IsPlayer() == true then
					if result[i] ~= ply then
						if result[i]:Alive() == true then 
							if (result[i]:Team() == ply:Team() and ply:Team() == 1001) or (result[i]:Team() ~= ply:Team() and ply:Team() ~= 1001) then

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
	end


end

function PASPERK_Bleedout(ply)
	if TableSearcher(ply.ClassNumber,"Bleedout") == true then
		
		if ply.first == false then
			ply.HealthTick=0
			
			ply.first = true
		end
		
		if ply:GetVelocity():Length() > 0 then
			if ply.HealthTick <= CurTime() then
				if ply:IsOnGround() then
					if ply:Health() > 1 then
						ply:SetHealth(ply:Health() - 1)
					else
						ply:TakeDamage(1000,ply,ply)
					end
				end
				ply.HealthTick = CurTime() + 0.1
			end
		else
			if ply.HealthTick <= CurTime() then
				if ply:Health() < 100 then
					ply:SetHealth(ply:Health() + 1)
				else
					ply:SetHealth(100)
				end
				ply.HealthTick = CurTime() + 0.75
			end
		end
		
		
	end
end

function PASPERK_Cloak(ply)
	if TableSearcher(ply.ClassNumber,"Cloak") == true then	

		if ply.first == false then 
			ply.ArmorDrainTick = 0
			
			ply.first = true
		end
		
		if ply:Armor() > 0 then 
			ply.MoveSpeed = ply:GetVelocity():Length()
	
			if ply.MoveSpeed < 10 then
				if ply:GetMaterial() ~= "Models/effects/vol_light001" then
					ply:SetMaterial("Models/effects/vol_light001")
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
				ply.ArmorDrainTick = CurTime() + 6
			end

		else
			if ply:GetMaterial() ~= "" then
				ply:SetMaterial("")
			end
		end
	end
	
end

function PASPERK_DeadLight(ply)

	if TableSearcher(ply.ClassNumber,"DeadLife") == true then

		if not ply.DeadLifeTick then 
			ply.DeadLifeTick = 1
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

end

function PASPERK_GlobalKS(ply)
	
	if TableSearcher(ply.ClassNumber,"GlobalKS") == true then
	
		for k,v in pairs(player.GetAll()) do
		
			if ply ~= v then		
				if (v:Team() == ply:Team() and ply:Team() == 1001) or (v:Team() ~= ply:Team() and ply:Team() ~= 1001) then
					if v:Health() <= 3 and v:Alive() then
						v:TakeDamage(8999,  ply, ply:GetActiveWeapon())
					end
				end
			end
		
		end

	
	end
end

function PASPERK_LifeRegen(ply)
	if TableSearcher(ply.ClassNumber,"LifeRegen") == true then
	
		 if ply:IsBot() then
			amount = 10
		else 
			amount = 1
		end
		
		if ply.first == false then 
			ply.LifeRegenTick = 0
			
			ply.first = true
		end
		
		if ply.LifeRegenTick <= CurTime() then
			ply.LifeRegenTick = CurTime()+1
			if ply:Health() + amount <= ply:GetMaxHealth() then
				ply:SetHealth(ply:Health() + amount)
			else
				ply:SetHealth(ply:GetMaxHealth())
			end
		end
		
	end
end

function PASPERK_Medic(ply)

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

end

function PASPERK_Mystical(ply)

	if TableSearcher(ply.ClassNumber,"Mystical") == true then
	
		for k,v in pairs(player.GetAll()) do
			if v:GetEyeTrace().Entity == ply then
				v:SendLua("if SERVER then return end LocalPlayer():SetEyeAngles(LocalPlayer():EyeAngles() + Angle(math.Rand(-9,9)*FrameTime(),math.Rand(-9,9)*FrameTime(),0))")
			end
		end

	end

end

function PASPERK_Necro(ply)
	if TableSearcher(ply.ClassNumber,"Necro") then
		if ply:GetMaxHealth() ~= 1 then 
			ply:SetMaxHealth(1)
		end
	end
end



function PASPERK_Poop(ply)

	if TableSearcher(ply.ClassNumber,"Poop") then
	
		if ply.first == false then	
			ply.first = true
			ply.PoopTick = 0
		end

					
		if ply.PoopTick <= CurTime() then
			ply.PoopTick = CurTime() + 5
			
			local ent = ents.Create("prop_physics")
			ent:SetModel("models/Gibs/HGIBS_spine.mdl")
			ent:SetMaterial("models/props_pipes/pipeset_metal.vmt")
			ent:SetOwner(ply)
			ent:SetCollisionGroup( COLLISION_GROUP_DEBRIS )
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

end

function PASPERK_Rambo(ply)

	if TableSearcher(ply.ClassNumber,"Rambo") == true then
	
		local Weapon = ply:GetActiveWeapon()
		
		if IsValid(Weapon) then
			
			if Weapon:IsScripted() then
				if Weapon.Primary.ClipSize then
					if Weapon.Primary.ClipSize > 0 then
						Weapon:SetClip1(Weapon.Primary.ClipSize)
					end
				end
			end
		
		end

	end
	
end


function PASPERK_Slayer(ply)

	if TableSearcher(ply.ClassNumber,"Slayer") == true then
		
		if ply.first == false then
			ply.FragTick = 0
			ply.first = true
			
			local Mul = math.Clamp(ply:Deaths() / math.max(0.1,ply:Frags()),1,3)
			ply:SetHealth(ply:Health() * Mul )
			
		end
		
		if ply.FragTick <= CurTime() then
			ply.FragTick = CurTime() + 0.5
			if ply:Health() > 25 then
				ply:SetHealth(ply:Health()-1)
			end
		end

	end
	
end

function PASPERK_SoulAbsorb(ply)

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

function PASPERK_SpeedChange(ply)

	if TableSearcher(ply.ClassNumber,"SpeedChange") then

		local ScaleFirst = ( ply:Health() + ply:Armor() ) / 200
		local ScaleSecond =  1.5 - ( ScaleFirst  )
		local ScaleLast = math.Clamp(ScaleSecond,0.1,2.0)
		
		--print(ScaleFirst)
		
		ply:SetWalkSpeed(ScaleLast * GetConVar("bur_class_walkspeed"):GetInt() )
		ply:SetRunSpeed(ScaleLast * GetConVar("bur_class_runspeed"):GetInt() )
		ply:SetJumpPower(ScaleLast * GetConVar("bur_class_jumppower"):GetInt() )
	
	
	end

end

function PASPERK_SpeedShield(ply)

	if TableSearcher(ply.ClassNumber,"SpeedShield") then
		local ArmorBonus = math.Clamp((ply:GetVelocity():Length() * 0.5),0,200)
		--print(ArmorBonus)
		ply:SetArmor(ArmorBonus)
	end

end



function SnackBarDeath(victim,inflictor,attacker)
	
	if TableSearcher(victim.ClassNumber,"Snackbar") == true then	
		
		if not victim.Armed then 
			victim.Armed = false
		end
		
		
		if victim.Armed == true then
			local effectdata = EffectData()
			effectdata:SetScale( 1 )
			effectdata:SetStart( victim:GetPos() )
			effectdata:SetOrigin( victim:GetPos() )
				
			local Sphere = ents.FindInSphere(victim:GetPos(),200)
			
			local dmginfo = DamageInfo()
			dmginfo:SetDamage(100)
			dmginfo:SetDamageType(DMG_BLAST)
			dmginfo:SetAttacker(victim)
			dmginfo:SetInflictor(victim)
			
			
				
			for k,v in pairs(Sphere) do
				if v ~= victim then
					if v:Health() > 0 then
						v:TakeDamageInfo(dmginfo)
					end
				end
			end
				
				
				
				
			util.Effect( "Explosion", effectdata )	
			util.Decal("Scorch", victim:GetPos(), victim:GetPos())
			victim.Armed = false
		end
		
	end
	
	
	if TableSearcher(attacker.ClassNumber,"Slayer") == true then
		attacker:SetHealth( math.min(attacker:Health() + 50, 300) )
	end
	
	victim:SetMaterial("")

end

hook.Add("PlayerDeath","ClassMod: On Player Death",SnackBarDeath)


print("sv_class_perks_passive loaded")
