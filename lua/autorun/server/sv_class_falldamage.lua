function ScaleFallDamage(ply, speed)
	--print("you fell gg")
	

		--print(Class[ply.ClassNumber]["fallmul"])
		
		
	
	
	if GetConVarNumber("mp_falldamage") == 1 then
		speed = speed - 580
		local punch = math.max(0,speed/10) * Class[ply.ClassNumber]["fallmul"]
		--print(punch)
		ply:ViewPunch(Angle(punch,0,0))
		
		return speed * (100/(1024-580)) * Class[ply.ClassNumber]["fallmul"]
	end
	return 10 * Class[ply.ClassNumber]["fallmul"]
	

	
end

hook.Add("GetFallDamage","ScaleFallDamage",ScaleFallDamage)