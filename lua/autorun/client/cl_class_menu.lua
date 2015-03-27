
surface.CreateFont( "TitleFont", {
	font = "roboto condensed", 
	size = 40, 
	weight = 100, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = true, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )



surface.CreateFont( "DescFont", {
	font = "roboto condensed", 
	size = 24, 
	weight = 0, 
	blursize = 0, 
	scanlines = 0, 
	antialias = true, 
	underline = false, 
	italic = false, 
	strikeout = false, 
	symbol = false, 
	rotary = false, 
	shadow = false, 
	additive = false, 
	outline = false, 
} )



function ClassSelectorDerma()

	LocalPlayer().SelectedClass = LocalPlayer():GetNWInt("classnum")
	

	local MenuBase = vgui.Create("DFrame")
		MenuBase:SetSize(ScrW(),ScrH())
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
		
	local Showoff = vgui.Create("DLabel")
		Showoff:SetParent(MenuBase)
		Showoff:SetPos(50,60)
		Showoff:SetFont("DermaLarge")
		Showoff:SetText("Class Count: " .. table.Count(Class))
		Showoff:SizeToContents(true)
		


	local MenuBar = vgui.Create( "DMenuBar")
		MenuBar:SetParent(MenuBase)
		MenuBar:DockMargin( -3,-6,-3,0 ) --corrects MenuBar pos

	local M1 = MenuBar:AddMenu( "File" )
		M1:AddOption( "Save", function() RunConsoleCommand("changeclass",LocalPlayer().SelectedClass) end ):SetIcon( "icon16/page_white_go.png" )
		M1:AddOption( "Exit", function() MenuBase:Close() end ):SetIcon( "icon16/folder_go.png" )

	local M2 = MenuBar:AddMenu( "Help" )
		M2:AddOption( "Filler", function() end )
		
		
		
		
	local Scroll = vgui.Create( "DScrollPanel", MenuBase )
		Scroll:SetSize( ScrW()*0.90 + 10 , ScrH()*0.8 )
		Scroll:SetPos( ScrW()*0.05, ScrH()*0.1 )
		
	checkbox = {}
		
	local List   = vgui.Create( "DIconLayout" )
		List:SetParent(Scroll)
		List:SetSize( ScrW()*0.90 , ScrH()*0.8 )
		List:SetPos( 0, 0 )
		List:SetSpaceX( ScrW()*0.005 )
		List:SetSpaceY( ScrW()*0.005 )
	
		
		
	for i = 1, table.Count(Class) do 
		local ListItem = vgui.Create( "DPanel" )
			ListItem:SetSize( ScrW()*0.25 - ScrW()*0.005 - ScrW()*0.1/4, ScrW()*0.25 - ScrW()*0.005 - ScrH()*0.2/4  )
			--ListItem:SetPos(0,i*210 - 200)
			ListItem:SetText(i)
			List:Add(ListItem)
			ListItem.Paint = function()
				draw.RoundedBox( 8, 0, 0, ListItem:GetWide(), ListItem:GetTall(), Class[i]["color"] )
			end
			
		local icon = vgui.Create( "SpawnIcon", ListItem )
			icon:SetSize( 50,50 )
			icon:SetPos(5,5)
			icon:SetModel( Class[i]["icon"] )	
			
		checkbox[i] = vgui.Create( "DCheckBox", ListItem )
		checkbox[i]:SetPos(ScrW()*0.25 - ScrW()*0.005 - ScrW()*0.1/4 - 20, 10)
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
			NameText:SetFont( "TitleFont" )
			NameText:SetSize( 1000, 50)
			NameText:SetDark(true)
			
		local TagBase = vgui.Create("DPanel",ListItem)
			TagBase:SetPos(0,50)
			TagBase:SetSize( ScrW()*0.25 - ScrW()*0.005 - ScrW()*0.1/4, ScrW()*0.25 - ScrW()*0.005 - ScrH()*0.2/4)
			TagBase.Paint = function()
				draw.TexturedQuad{
					texture = surface.GetTextureID "vgui/gradient_up",
					color = Color(0,0,0,255) ,
					x = 0,
					y = 0,
					w = TagBase:GetWide(),
					h = TagBase:GetTall(),
				}
			end
			
		local Scroll2 = vgui.Create( "DScrollPanel" )
			Scroll2:SetParent(TagBase)
			Scroll2:SetSize( ScrW()*0.25 - ScrW()*0.005 - ScrW()*0.1/4, (ScrW()*0.25 - ScrW()*0.005 - ScrH()*0.2/4 - 50)/3)
			Scroll2:SetPos( 0, 0 )	

			
		
			
			
			
		
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
		
		--[[
		if Class[i]["stamina"]*5 ~= 100 then
			if Class[i]["stamina"]*5 > 100 then
				table.insert(ClassStats,"+" .. tostring(math.abs((Class[i]["stamina"]*5)-100)) .. "% Stamina")
			else
				table.insert(ClassStats,tostring((Class[i]["stamina"]*5)-100) .. "% Stamina")
			end	
		end
		--]]

		
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

		local Desc = vgui.Create("DLabel")
			Desc:SetParent(Scroll2)
			Desc:SetPos(5,5)
			Desc:SetFont("DescFont")
			Desc:SetColor(Color(255,255,255,255))
			Desc:SetSize(TagBase:GetWide() - 5 - 20,TagBase:GetTall()*0.5)
			Desc:SetText( Class[i]["description"] )
			Desc:SetAutoStretchVertical(true)
			--Desc:SizeToContents(true)
			
			Desc:SetWrap(true)
			
			
		for i=1, table.Count(ClassStats) do

			Tag[i] = vgui.Create( "DLabel" )
			Tag[i]:SetParent(TagBase)

			Tag[i]:SetPos(5,Desc:GetTall()*0.5 + i*18)
			Tag[i]:SetFont("DescFont")
			Tag[i]:SetColor(Color(255,255,255,255))
			
			Tag[i]:SetSize(0,0)
			Tag[i]:SetText( ClassStats[i])
			


			Tag[i]:SizeToContents(true)
		end
		
		
		
	end
	

	
end



concommand.Add("selectclass", ClassSelectorDerma)



net.Receive("ClassModPlayerClassChange", function(len)
	
	local ply = net.ReadEntity()
	local classnum = net.ReadFloat()
	
	local teamcolor = team.GetColor(ply:Team())
	local classcolor = Class[classnum]["color"]
	local classname = Class[classnum]["name"]
	
	ply.ClientSideClassNumber = classnum
	
	chat.AddText(teamcolor,ply:Nick(),Color(255,255,255,255)," has changed their class to ",classcolor,classname)

end)