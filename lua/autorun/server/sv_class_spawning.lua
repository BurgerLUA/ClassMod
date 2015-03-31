


function FirstClassSpawn( ply )
	ply.ClassNumber = 1
	ply.ClassNumberTo = 1
	ply:SetNWInt("classnum",ply.ClassNumber)
	ply:SetNWInt("stamina",Class[ply.ClassNumber]["stamina"])
	ply.Energy = Class[ply.ClassNumber]["stamina"]
	
	
	ply:SendLua(
		[[chat.AddText(Color(255,255,255), "This server is running ClassMod BETA. Press",Color(0,255,0)," F3 ",Color(255,255,255),Color(255,255,255),"to access the class menu.")]]
	)
	
	
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
	ply.Energy = Class[ply.ClassNumber]["stamina"]
	
	ply:SetNWInt("classnum",ply.ClassNumber)
	
	local Players = player.GetAll()
	
	timer.Simple(0.01, function()
		ply:SetNWInt("classnum",ply.ClassNumber)
		ply:SetHealth(Class[ply.ClassNumber]["health"])
		ply:SetArmor(Class[ply.ClassNumber]["armor"])
		ply:SetMaxHealth(Class[ply.ClassNumber]["health"])
		ply:SetWalkSpeed(Class[ply.ClassNumber]["walkspeedmul"] * GetConVar("bur_class_walkspeed"):GetInt() )
		ply:SetRunSpeed(Class[ply.ClassNumber]["runspeedmul"] * GetConVar("bur_class_runspeed"):GetInt() )
		ply:SetJumpPower(Class[ply.ClassNumber]["jumpmul"] * GetConVar("bur_class_jumppower"):GetInt() )
		ply:SetCrouchedWalkSpeed(Class[ply.ClassNumber]["crouchmul"]*0.5)
		
		ply.Armed = true
	end)
	
end

hook.Add("PlayerSpawn", "Player Class Spawn", PlayerClassSpawn)

function AlertKill(victim,num,kill,killer,team)
	return "Victim", 0, "kill", "Killer", 1001
end

hook.Add("AddDeathNotice","Alert Kill",AlertKill)

print("sv_class_spawning loaded")
