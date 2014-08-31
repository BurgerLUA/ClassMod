surface.CreateFont( "BurgerFont", {
	font = "Roboto-Black",
	size = 50,
	weight = 500,
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

function HUDHide( myhud )
	if SERVER then return end
		for k, v in pairs{"CHudHealth","CHudBattery","CHudAmmo","CHudSecondaryAmmo"} do
			if myhud == v then return false end
		end
end
hook.Add( "HUDShouldDraw", "HUDHide", HUDHide )

print("Updated")

if CLIENT then
	squaremat = Material("vgui/gradient_down")
	circlemat = Material("widgets/disc.png")
end


local function BurgerBulletHUD()
	if SERVER then return end
	
	local ply = LocalPlayer()

	if ply:Alive() then
		HP = ply:Health()
		ARM = ply:Armor()
		
		
		if ply:GetActiveWeapon():IsValid() == false then return end
		
		ammo = ply:GetActiveWeapon():Clip1()
		
		if ply:GetActiveWeapon():IsScripted() then
			maxammo=ply:GetActiveWeapon():GetTable().Primary.ClipSize 
		else
			maxammo=ply:GetActiveWeapon():Clip1()
		end
	
		extraammo = ply:GetAmmoCount(ply:GetActiveWeapon():GetPrimaryAmmoType()) 
		secondaryammo = ply:GetAmmoCount(ply:GetActiveWeapon():GetSecondaryAmmoType())
		wep = ply:GetActiveWeapon()
	end
	
	if ScrW() == 640 then Scale = 0.5
	elseif ScrW() == 800 then Scale = 0.75
	elseif ScrW() == 1024 then Scale = 1
	elseif ScrW() == 1280 then Scale = 1
	else Scale = 1 end

	Basefade = 255

	BaseTrig = 2
	ConVert = math.pi/180
	Size = (ScrH()/8)*Scale

	BarWidth=25*Scale
	BarHeight=25*Scale
	
	CenterX = ScrW()*0 + BarWidth*7
	CenterX2 = ScrW() - BarWidth*7
	CenterY = ScrH() - BarHeight*7

	surface.SetFont( "BurgerFont" )
	surface.SetTextColor( 255 - 2.25*HP,2.25*HP,(HP-100)*3,Basefade )
	surface.SetTextPos( CenterX-(1/3)*100, CenterY-25)
	surface.DrawText( HP )

	if ARM >= 1 then
		surface.SetFont( "BurgerFont" )
		surface.SetTextColor( ARM-100,100,ARM*2.55,Basefade )
		surface.SetTextPos( CenterX-(1/3)*100, CenterY+25)
		surface.DrawText( ARM )
	end

	if extraammo >= 1 then
		surface.SetFont( "BurgerFont" )
		surface.SetTextColor( 255, 255, 0, 255 )
		surface.SetTextPos( CenterX2-25 , CenterY-25)
		surface.DrawText( extraammo )
	
	end

	for i = 1, math.min(HP,100) do 

		healthmod = 0.3

		if ARM==0 then
			PosSet= 0 ; SizeMul=1 ; fixer= 0
		else 
			PosSet= 0 ; SizeMul=1; fixer = 0
		end

		local RingX = math.sin(-(PosSet+i+fixer)*BaseTrig*ConVert*healthmod*2)*Size + CenterX - BarWidth/2
		local RingY = math.cos(-(PosSet+i+fixer)*BaseTrig*ConVert*healthmod*2)*Size + CenterY 
	
		surface.SetMaterial( squaremat )
		surface.SetDrawColor(255 - 2.25*HP,2.25*HP,(HP-100)*3,Basefade)
		surface.DrawTexturedRectRotated(RingX,RingY,BarWidth,(BarHeight+(i*SizeMul))*(Size/500), -(fixer+i+PosSet)*1.2)
	end

	if ARM >=1 then
		for i = 1, math.min(ARM,100) do 
			local healthmod = 0.3
			local RingX = math.sin(i*BaseTrig*ConVert*healthmod*2)*Size + CenterX + BarWidth/2
			local RingY = math.cos(i*BaseTrig*ConVert*healthmod*2)*Size + CenterY
			surface.SetMaterial( squaremat )
			surface.SetDrawColor((ARM-100),100,ARM*2.55,Basefade)
			surface.DrawTexturedRectRotated(RingX,RingY,BarWidth,(BarHeight+(i*SizeMul))*(Size/500),i*1.2)
		end
	end

	if ammo >= 1 then
		for i = 1, ammo do 
			local clipmod = 180/maxammo
			local RingX = math.sin(-i*BaseTrig*ConVert*clipmod)*Size + CenterX2
			local RingY = math.cos(-i*BaseTrig*ConVert*clipmod)*Size + CenterY
			surface.SetMaterial( circlemat )
			surface.SetDrawColor(255,255,0,Basefade)
			--surface.DrawCircle( RingX, RingY, BarWidth*math.Clamp(clipmod/2,1,10)/50, Color(255,255,0,255) ) 
			surface.DrawTexturedRectRotated(RingX,RingY,BarWidth*math.Clamp(clipmod/2,1,10)/4,BarHeight*math.Clamp(clipmod/2,1,10)/4,0)
			--surface.DrawTexturedRectRotated(RingX,RingY,BarWidth,BarHeight,i*1.2)
		end
	end
	
	local energy = ply:GetNWInt("Energy",0)
	local maxenergy = ply:GetNWInt("stamina",0)
	

	

	if energy > 0 then
		
		local OPercent = 5/maxenergy
		local Percent = energy/maxenergy
		local SizeScale = 1
		
		
		local XPos = ScrW()/2
		local YPos = ScrH() - BarHeight*2
		local XSize = BarWidth*10
		local YSize = BarHeight
		

		
		
			
			
		local Mod = maxenergy
			
		surface.SetMaterial( squaremat )
		surface.SetDrawColor(0,0,0,Basefade)
		surface.DrawTexturedRectRotated(XPos,YPos,XSize,YSize,0)
			
		surface.SetMaterial( squaremat )
		surface.SetDrawColor(Mod,255 - (Mod),0,Basefade)
		surface.DrawTexturedRectRotated(XPos,YPos,XSize*0.9*Percent,YSize*0.5,0)


			
		--surface.SetFont( "BurgerFont" )
		--surface.SetTextColor( 255,255,255,255 )
		--surface.SetTextPos( XPos, YPos)
		--surface.DrawText( "STAMINA" )
			
	end
			



			



end
hook.Add("HUDPaint", "BB_HUDPAINT", BurgerBulletHUD)

