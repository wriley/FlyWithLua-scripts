dataref("xp_com1", "sim/cockpit2/radios/actuators/com1_power", "writable")
dataref("xp_nav1", "sim/cockpit2/radios/actuators/nav1_power", "writable")
dataref("xp_com2", "sim/cockpit2/radios/actuators/com2_power", "writable")
dataref("xp_nav2", "sim/cockpit2/radios/actuators/nav2_power", "writable")

function switch_panel()
	-- generator
	if button(644) then
		xp_com2 = 1
	else
		xp_com2 = 0
	end
	
	-- battery
	if button(645) then
		xp_nav2 = 1
	else
		xp_nav2 = 0
	end
	
	if button(652) then
		xp_com1 = 1
	else
		xp_com1 = 0
	end
	XPLMSetDatavi(xp_fuel_pump_ref, xp_fuel_pump_array, 0, 8)
	
	-- beacon
	if button(651) then
		xp_nav1 = 1
	else
		xp_nav2 = 0
	end
end

do_every_frame("switch_panel()")
