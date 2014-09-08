
include("sv_class_falldamage.lua")
include("sv_class_perks_damage.lua")
include("sv_class_perks_passive.lua")
include("sv_class_spawning.lua")
include("sv_class_sprint.lua")
include("sv_class_tablesearcher.lua")


--AddCSLuaFile( "autorun/client/cl_classmod.lua" )


CreateConVar("bur_class_walkspeed", "200", FCVAR_REPLICATED + FCVAR_NOTIFY + FCVAR_ARCHIVE , "Changes the walkspeed. Default walkspeed is 250." )
CreateConVar("bur_class_runspeed", "400", FCVAR_REPLICATED + FCVAR_NOTIFY + FCVAR_ARCHIVE , "Changes the runspeed. Default walkspeed is 500." )
CreateConVar("bur_class_jumppower", "200", FCVAR_REPLICATED + FCVAR_NOTIFY + FCVAR_ARCHIVE , "Changes the jumping power. Default jumppower is 200." )


function ChangeClass( ply, cmd, args )

	local num = tonumber(args[1])

	if type(num) ~= "number" then return end
	
	if num <= table.Count(Class) then

		ply.ClassNumberTo = num
	
		ply.ClassName = Class[num]["name"]
		ply.ClassDescription = Class[num]["description"]
		
		ply:ChatPrint("Your class will change to "..Class[num]["name"]..".")
		--ply.ClassChanged = true
		ply:Spawn()

	else
		ply:ChatPrint("INVALID CLASS")
	return end
	
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint(ply:Nick().." has changed his class to " .. Class[num]["name"] )
	end
	
end

concommand.Add("changeclass", ChangeClass)

function ForceClass(ply,cmd,args)
	if ply:IsAdmin() == true or ply:IsSuperAdmin() == true then
		local victim = tonumber(args[1])
		local num = tonumber(args[2])

		if type(num) ~= "number" then return end
	
		if num <= table.Count(Class) then

			Entity(victim).ClassNumberTo = num
	
			Entity(victim).ClassName = Class[num]["name"]
			Entity(victim).ClassDescription = Class[num]["description"]
		
			--Entity(victim):ChatPrint("Your class will change to "..Class[num]["name"]..".")
			--Entity(victim).ClassChanged = true
			Entity(victim):Spawn()
			
			print(Entity(victim):Nick() .. " is now a " .. Class[num]["name"])

		else
			ply:ChatPrint("INVALID CLASS")
		return end
	end
end

concommand.Add("forceclass", ForceClass)



function SelectClassMenu( ply )
	--ply:ConCommand("selectweapon")
	ply:ConCommand("selectclass")
end

function SelectWeaponMenu( ply )
	ply:ConCommand("selectweapon")
	--ply:ConCommand("selectclass")
end

hook.Add("ShowSpare1", "Select Class Menu", SelectClassMenu)
hook.Add("ShowSpare2", "Select Weapon Menu", SelectWeaponMenu)

print("sv_class_perks_base loaded")



