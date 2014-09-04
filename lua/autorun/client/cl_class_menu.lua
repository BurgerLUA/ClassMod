function ClassSelectorDerma()

	LocalPlayer().SelectedClass = LocalPlayer():GetNWInt("classnum")
	

	local MenuBase = vgui.Create("DFrame")
		MenuBase:SetSize(800,ScrH())
		MenuBase:SetPos(0,0)
		MenuBase:SetTitle("Class Selection")
		MenuBase:SetDeleteOnClose(false)
		MenuBase:SetDraggable( false )
		MenuBase:SetBackgroundBlur(false)
		MenuBase:Center(true)
		MenuBase:SetVisible( true )
		MenuBase.Paint = function()
			draw.RoundedBox( 8, 0, 0, MenuBase:GetWide(), MenuBase:GetTall(), Color( 0, 0, 0, 150 ) )
		end
		MenuBase:MakePopup()


	local MenuBar = vgui.Create( "DMenuBar")
		MenuBar:SetParent(MenuBase)
		MenuBar:DockMargin( -3,-6,-3,0 ) --corrects MenuBar pos

	local M1 = MenuBar:AddMenu( "File" )
		M1:AddOption( "Save", function() RunConsoleCommand("changeclass",LocalPlayer().SelectedClass) end ):SetIcon( "icon16/page_white_go.png" )
		M1:AddOption( "Exit", function() MenuBase:Close() end ):SetIcon( "icon16/folder_go.png" )

	local M2 = MenuBar:AddMenu( "Help" )
		M2:AddOption( "Filler", function() end )
		
		
		
		
	local Scroll = vgui.Create( "DScrollPanel", MenuBase )
		Scroll:SetSize( 700,ScrH() - 150 )
		Scroll:SetPos( 50, 100 )
		
	checkbox = {}
		
	for i = 1, table.Count(Class) do 
		local ListItem = vgui.Create( "DPanel" )
			ListItem:SetSize( 650, 200 ) 
			ListItem:SetPos(0,i*210 - 200)
			ListItem:SetText(i)
			ListItem:SetParent(Scroll)
			ListItem.Paint = function()
				draw.RoundedBox( 8, 0, 0, ListItem:GetWide(), ListItem:GetTall(), Class[i]["color"] )
			end
			
		local icon = vgui.Create( "SpawnIcon", ListItem )
			icon:SetSize( 50,50 )
			icon:SetPos(5,5)
			icon:SetModel( Class[i]["icon"] )	
			
		checkbox[i] = vgui.Create( "DCheckBox", ListItem )
		checkbox[i]:SetPos(175,12.5)
		checkbox[i].OnChange = function(chkBox)
			--print("changed")
			if checkbox[i]:GetChecked() == true then
				LocalPlayer().SelectedClass = i
				for k=1, table.Count(Class) do 
					if k~=i then
						checkbox[k]:SetChecked(false)
					end
				end
			end
		end
		
		if LocalPlayer().SelectedClass == i then
			checkbox[i]:SetChecked(true)
		end
			
		
		
			
		local NameText = vgui.Create( "DLabel", ListItem )
			NameText:SetPos( 50, 10 )
			NameText:SetText( Class[i]["name"] )
			NameText:SetFont( "Trebuchet24" )
			NameText:SizeToContents()
			NameText:SetDark(true)
			
		local TagBase = vgui.Create("DPanel",ListItem)
			TagBase:SetPos(0,50)
			TagBase:SetSize( 650, 200)
			TagBase.Paint = function()
				draw.TexturedQuad{
					texture = surface.GetTextureID "vgui/hsv-brightness",
					color = Class[i]["color"] ,
					x = 0,
					y = 0,
					w = TagBase:GetWide(),
					h = TagBase:GetTall(),
				}
			end
			
		local Scroll2 = vgui.Create( "DScrollPanel", ListItem )
			Scroll2:SetSize( 200,200 )
			Scroll2:SetPos( 0, 50 )	

			
		
			
			
			
		
		local ClassStats = {}
		
		if Class[i]["health"]-100 ~= 0 then
			if Class[i]["health"]-100 > 0 then 
				table.insert(ClassStats,"+" .. tostring(Class[i]["health"]-100) .. "% Health")
			else
				table.insert(ClassStats,tostring(Class[i]["health"]-100) .. "% Health")
			end	
		end
		
		if Class[i]["armor"] ~= 0 then
			table.insert(ClassStats,"+" .. tostring(Class[i]["armor"]) .. "% Armor")
		end
		
		if Class[i]["stamina"]*5 ~= 100 then
			if Class[i]["stamina"]*5 > 100 then
				table.insert(ClassStats,"+" .. tostring(math.abs((Class[i]["stamina"]*5)-100)) .. "% Stamina")
			else
				table.insert(ClassStats,tostring((Class[i]["stamina"]*5)-100) .. "% Stamina")
			end	
		end
		

		
		if Class[i]["walkspeedmul"] ~= 1 then
			if Class[i]["walkspeedmul"] > 1 then
				table.insert(ClassStats,"+" .. tostring(math.abs((1-Class[i]["walkspeedmul"])*100)) .. "% Walkspeed")
			else
				table.insert(ClassStats,"-" .. tostring((1-Class[i]["walkspeedmul"])*100) .. "% Walkspeed")
			end
			
		end
		
		if Class[i]["walkspeedmul"] ~= 1 then
			if Class[i]["runspeedmul"] > 1 then
				table.insert(ClassStats,"+" .. tostring(math.abs((1-Class[i]["runspeedmul"])*100)) .. "% Runspeed")
			else
				table.insert(ClassStats,"-" .. tostring((1-Class[i]["runspeedmul"])*100) .. "% Runspeed")
			end
		end
		
		if Class[i]["crouchmul"] ~= 1 then
			if Class[i]["crouchmul"] > 1 then
				table.insert(ClassStats,"+" .. tostring(math.abs((1-Class[i]["crouchmul"])*100)) .. "% Crouchspeed")
			else
				table.insert(ClassStats,"-" .. tostring((1-Class[i]["crouchmul"])*100) .. "% Crouchspeed")
			end
		end
		
		if Class[i]["fallmul"] ~= 1 then
			if Class[i]["fallmul"] > 1 then
				table.insert(ClassStats,"+" .. tostring(math.abs((1-Class[i]["fallmul"])*100)) .. "% Fall Damage")
			else
				table.insert(ClassStats,"-" .. tostring((1-Class[i]["fallmul"])*100) .. "% Fall Damage")
			end
		end	
			
		local Tag = {}
		local x = 0
		local y = 0
		for i=1, table.Count(ClassStats) do
			Tag[i] = vgui.Create( "DLabel" )
			Tag[i]:SetParent(ListItem)
			
			if i <= 3 then
				x = 0
				y = i
			elseif i <= 6 then
				x = 1
				y = i-3
			elseif i <= 9 then
				x = 2
				y = i-6
			end
			
			Tag[i]:SetPos( 200 + x*150, 2 + 15*y - 15)
			Tag[i]:SetSize(0,0)
			Tag[i]:SetText( ClassStats[i])
			Tag[i]:SetFont( "Trebuchet18" )
			Tag[i]:SetDark(true)
			Tag[i]:SizeToContents(true)
		end
		
		local Desc = vgui.Create("DLabel")
			Desc:SetParent(TagBase)
			Desc:SetPos(5,5)
			Desc:SetSize(TagBase:GetWide(),TagBase:GetTall())
			Desc:SetText( Class[i]["description"] )
			Desc:SetAutoStretchVertical(true)
			--Desc:SizeToContents(true)
			Desc:SetDark(true)
			
			Desc:SetWrap(true)
			
			
		
		
		
		
	end
	

	
end



concommand.Add("selectclass", ClassSelectorDerma)


function ClSprintThink()
	if LocalPlayer():KeyDown(IN_SPEED) then
		--print("run nigga")
		LocalPlayer():SetNWBool("IsSprinting", true) 
	elseif LocalPlayer():KeyReleased(IN_SPEED) then
		LocalPlayer():SetNWBool("IsSprinting", false) 
	end
end


hook.Add("Think", "Clientside Sprint Think", ClSprintThink)









function ClassChat( ply, strText, bTeamOnly, bPlayerIsDead )

	local tab = {}
	
	local classnum = ply:GetNWInt("classnum")
 
	if ( bPlayerIsDead ) then
		table.insert( tab, Color( 255, 30, 40 ) )
		table.insert( tab, "*DEAD* " )
	end
 
	if ( bTeamOnly ) then
		table.insert( tab, Color( 30, 160, 40 ) )
		table.insert( tab, "(TEAM) " )
	end

	table.insert( tab, Class[classnum]["color"] )
	table.insert( tab, "["..Class[classnum]["name"].."]" )
	
	
	if ( IsValid( ply ) ) then
		table.insert( tab, team.GetColor(ply:Team()) )
		table.insert( tab, ply:GetName() )
	else
		table.insert( tab, "Console" )
	end
 
	table.insert( tab, Color( 255, 255, 255 ) )
	table.insert( tab, ": "..strText )
 
	chat.AddText( unpack(tab) )
	
	
 
	return true
 
end

hook.Add("OnPlayerChat", "Player Chat", ClassChat)