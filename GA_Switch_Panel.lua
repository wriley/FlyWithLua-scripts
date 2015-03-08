logMsg("GS_Switch_Panel script loaded")

-- generator
xp_generator_ref = XPLMFindDataRef("sim/cockpit/electrical/generator_on")
xp_generator_array = XPLMGetDatavi(xp_generator_ref, 0, 8)

-- battery
dataref("xp_battery", "sim/cockpit/electrical/battery_on", "writable")

-- fuel pump
xp_fuel_pump_ref = XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on")
xp_fuel_pump_array = XPLMGetDatavi(xp_fuel_pump_ref, 0, 8)

-- beacon
dataref("xp_beacon", "sim/cockpit/electrical/beacon_lights_on", "writable")

-- landing
dataref("xp_landing", "sim/cockpit/electrical/landing_lights_on", "writable")

-- taxi
dataref("xp_taxi", "sim/cockpit/electrical/taxi_light_on", "writable")

-- nav
dataref("xp_nav", "sim/cockpit/electrical/nav_lights_on", "writable")

-- strobe
dataref("xp_strobe", "sim/cockpit/electrical/strobe_lights_on", "writable")

-- pitot
dataref("xp_pitot", "sim/cockpit/switches/pitot_heat_on", "writable")

-- avionics
dataref("xp_avionics", "sim/cockpit/electrical/avionics_on", "writable")

-- parkbrake
dataref("xp_parkbrake", "sim/flightmodel/controls/parkbrake", "writable")

function switch_panel()
	-- generator
	if button(1124) then
		xp_generator_array[0] = 1
	else
		xp_generator_array[0] = 0
	end
	XPLMSetDatavi(xp_generator_ref, xp_generator_array, 0, 8)
	
	-- battery
	if button(1125) then
		xp_battery = 1
	else
		xp_battery = 0
	end
	
	-- fuel pump
	if button(1132) then
		xp_fuel_pump_array[0] = 1
	else
		xp_fuel_pump_array[0] = 0
	end
	XPLMSetDatavi(xp_fuel_pump_ref, xp_fuel_pump_array, 0, 8)
	
	-- beacon
	if button(1131) then
		xp_beacon = 1
	else
		xp_beacon = 0
	end
	
	-- landing
	if button(1130) then
		xp_landing = 1
	else
		xp_landing = 0
	end
	
	-- taxi
	if button(1129) then
		xp_taxi = 1
	else
		xp_taxi = 0
	end
	
	-- nav
	if button(1128) then
		xp_nav = 1
	else
		xp_nav = 0
	end
	
	-- strobe
	if button(1127) then
		xp_strobe = 1
	else
		xp_strobe = 0
	end
	
	-- pitot
	if button(1126) then
		xp_pitot = 1
	else
		xp_pitot = 0
	end
	
	-- avionics
	if button(1133) then
		xp_avionics = 1
	else
		xp_avionics = 0
	end
	
	-- parkbrake
	if button(1134) then
		xp_parkbrake = 1
	else
		xp_parkbrake = 0
	end
end

do_every_frame("switch_panel()")