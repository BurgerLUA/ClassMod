


function FirstClassSpawn( ply )
	ply.ClassNumber = 1
	ply.ClassNumberTo = 1
	ply:SetNWInt("classnum",ply.ClassNumber)
	ply:SetNWInt("stamina",Class[ply.ClassNumber]["stamina"])
	ply.Energy = Class[ply.ClassNumber]["stamina"]
end

hook.Add( "PlayerInitialSpawn", "Initialize Class", FirstClassSpawn )


function PlayerClassSpawn(ply)

	ply.HasChangedClass = true
	
	if ply.ClassNumber == nil then
		ply.ClassNumber = 1
	end
	
	if ply.ClassNumberTo == nil then
		ply.ClassNumberTo = 1
	end

	ply.ClassNumber = ply.ClassNumberTo
	
	if ply:IsBot() then
		ply:StripWeapons()
		ply:ConCommand("cl_playermodel","css_riot")
		
		if ply.ClassNumber ~= 30 then
			ply.ClassNumber = 30
		end
		
		ply.HasChangedClass = true
		
		timer.Simple(2.5, function()
			ply:StripWeapons()
			ply:Give("weapon_cs_botgun")
			ply:SetModel("models/player/woody/woody.mdl")
			
	
			local ent = ply

			local FlexNum = ent:GetFlexNum() - 1
			if ( FlexNum <= 0 ) then return end
			
			
			for i=0, FlexNum - 1 do
	
				local Name = ent:GetFlexName( i )
	

				
				ent:SetFlexWeight( i, math.Rand(-1,1) )
				ent:SetFlexScale( 5 )
				
			end
		end)
		
	end
	
	ply.Energy = Class[ply.ClassNumber]["stamina"]
	ply:SetNWInt("stamina",Class[ply.ClassNumber]["stamina"])
	
	ply:SetNWInt("classnum",ply.ClassNumber)
	
	--if ply:IsValid() then 
	--	CheckPerks(ply)
	--end
	
	local Players = player.GetAll()
	
	

	
	--[[
	print("-----------------------------------")
	print("DAMAGE DEALT TO "..string.upper(ply:Nick()) .. ":")
	for i=1, table.Count(Players) do
		if ply:GetNWInt(i,0) > 0 then
			print(Entity(i):Nick() .. ": " .. ply:GetNWInt(i,0))
			ply:SetNWInt(i,0)
		end
		
	end
	print("-----------------------------------")
	--]]

	timer.Simple(0.01, function()
		--CheckPerks(ply)
		ply:SetNWInt("classnum",ply.ClassNumber)
		ply:SetHealth(Class[ply.ClassNumber]["health"])
		ply:SetArmor(Class[ply.ClassNumber]["armor"])
		ply:SetMaxHealth(Class[ply.ClassNumber]["health"])
		ply:SetWalkSpeed(Class[ply.ClassNumber]["walkspeedmul"] * GetConVar("bur_class_walkspeed"):GetInt() )
		ply:SetRunSpeed(Class[ply.ClassNumber]["runspeedmul"] * GetConVar("bur_class_runspeed"):GetInt() )
		ply:SetJumpPower(Class[ply.ClassNumber]["jumpmul"] * GetConVar("bur_class_jumppower"):GetInt() )
		ply:SetCrouchedWalkSpeed(Class[ply.ClassNumber]["crouchmul"]*0.5)
	end)
end

hook.Add("PlayerSpawn", "Player Class Spawn", PlayerClassSpawn)

function AlertKill(victim,num,kill,killer,team)
	return "Victim", 0, "kill", "Killer", 1001
end

hook.Add("AddDeathNotice","Alert Kill",AlertKill)

print("sv_class_spawning loaded")
