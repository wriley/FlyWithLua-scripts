logMsg("GA_Switch_Panel script loaded")

-- Define buttons
btn_generator = 644
btn_battery = 645
btn_fuel_pump = 652
btn_beacon = 651
btn_landing = 650
btn_taxi = 649
btn_nav = 648
btn_strobe = 647
btn_pitot = 646
btn_avionics = 653
btn_parkbrake = 654

-- starter switch_panel
-- TODO

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
	-- starter switch_panel
	-- TODO
	
	-- generator
	if button(btn_generator) then
		xp_generator_array[0] = 1
		xp_generator_array[1] = 1
		xp_generator_array[2] = 1
		xp_generator_array[3] = 1
	else
		xp_generator_array[0] = 0
		xp_generator_array[1] = 0
		xp_generator_array[2] = 0
		xp_generator_array[3] = 0
	end
	XPLMSetDatavi(xp_generator_ref, xp_generator_array, 0, 8)
	
	-- battery
	if button(btn_battery) then
		xp_battery = 1
	else
		xp_battery = 0
	end
	
	-- fuel pump
	if button(btn_fuel_pump) then
		xp_fuel_pump_array[0] = 1
		xp_fuel_pump_array[1] = 1
		xp_fuel_pump_array[2] = 1
		xp_fuel_pump_array[3] = 1
	else
		xp_fuel_pump_array[0] = 0
		xp_fuel_pump_array[1] = 0
		xp_fuel_pump_array[2] = 0
		xp_fuel_pump_array[3] = 0
	end
	XPLMSetDatavi(xp_fuel_pump_ref, xp_fuel_pump_array, 0, 8)
	
	-- beacon
	if button(btn_beacon) then
		xp_beacon = 1
	else
		xp_beacon = 0
	end
	
	-- landing
	if button(btn_landing) then
		xp_landing = 1
	else
		xp_landing = 0
	end
	
	-- taxi
	if button(btn_taxi) then
		xp_taxi = 1
	else
		xp_taxi = 0
	end
	
	-- nav
	if button(btn_nav) then
		xp_nav = 1
	else
		xp_nav = 0
	end
	
	-- strobe
	if button(btn_strobe) then
		xp_strobe = 1
	else
		xp_strobe = 0
	end
	
	-- pitot
	if button(btn_pitot) then
		xp_pitot = 1
	else
		xp_pitot = 0
	end
	
	-- avionics
	if button(btn_avionics) then
		xp_avionics = 1
	else
		xp_avionics = 0
	end
	
	-- parkbrake
	if button(btn_parkbrake) then
		xp_parkbrake = 1
	else
		xp_parkbrake = 0
	end
end

do_every_frame("switch_panel()")