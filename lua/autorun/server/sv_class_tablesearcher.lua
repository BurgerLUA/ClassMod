function TableSearcher(num,tofind)
	local found = false

	
	if Class[num] == nil then return false end
	--if Class[num]["perks"][1] == "none" then return false end

	--print("Trying to find " .. tofind)
	
	for i=1, table.Count(Class[num]["perks"]) do 
		--print(Class[num]["perks"][i])
		if table.HasValue(Class[num]["perks"],tofind) then
			found = true
		end
		
		if found == true then
			--print ( tofind )
		end
	end
	
return found end

print("sv_class_tablesearcher loaded")