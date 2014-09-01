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
		error("ERROR: CHANGECLASS DOESN'T EXIST")
	return end
	
end

concommand.Add("changeclass", ChangeClass)


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



