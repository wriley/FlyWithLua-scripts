logMsg("GA_Switch_Panel script loaded")

-- Define buttons
btn_base = 480
btn_mag_left  = btn_base + 0
btn_mag_right = btn_base + 1
btn_generator = btn_base + 3
btn_battery   = btn_base + 4
btn_fuel_pump = btn_base + 5
btn_beacon    = btn_base + 6
btn_landing   = btn_base + 7
btn_taxi      = btn_base + 8
btn_nav       = btn_base + 9
btn_strobe    = btn_base + 10
btn_pitot     = btn_base + 11
btn_avionics  = btn_base + 12
btn_parkbrake = btn_base + 13
btn_gear      = btn_base + 14
btn_starter   = btn_base + 15

-- ignition key
dataref("xp_ignition", "sim/cockpit2/engine/actuators/ignition_key", "writable")

-- generator
dataref("xp_generator", "sim/cockpit2/electrical/generator_on", "writable")

-- battery
dataref("xp_battery", "sim/cockpit/electrical/battery_on", "writable")

-- fuel pump
xp_fuel_pump_ref = XPLMFindDataRef("sim/cockpit/engine/fuel_pump_on")
xp_fuel_pump_array = XPLMGetDatavi(xp_fuel_pump_ref, 0, 8)

-- beacon
dataref("xp_beacon", "sim/cockpit2/switches/beacon_on", "writable")

-- landing
dataref("xp_landing", "sim/cockpit2/switches/landing_lights_switch", "writable")

-- taxi
dataref("xp_taxi", "sim/cockpit2/switches/taxi_light_on", "writable")

-- nav
dataref("xp_nav", "sim/cockpit2/switches/navigation_lights_on", "writable")

-- strobe
dataref("xp_strobe", "sim/cockpit2/switches/strobe_lights_on", "writable")

-- pitot
dataref("xp_pitot", "sim/cockpit/switches/pitot_heat_on", "writable")

-- avionics
dataref("xp_avionics", "sim/cockpit2/switches/avionics_power_on", "writable")
dataref("xp_avionics2", "sim/cockpit2/electrical/cross_tie", "writable")

-- parkbrake
dataref("xp_parkbrake", "sim/flightmodel/controls/parkbrake", "writable")

-- landing gear
dataref("xp_gear", "sim/cockpit2/controls/gear_handle_down", "writable")

function switch_panel()
    -- ignition key
    xp_ignition_set = 0
    xp_starter_set = 0
    
    if button(btn_starter) then
        xp_starter_set = 1
    end
        
    mag_left = button(btn_mag_left)
    mag_right = button(btn_mag_right)
    
    if mag_left then
        xp_ignition_set = 1
    end
    
    if mag_right then
        xp_ignition_set = 2
    end
    
    if mag_left and mag_right then
        xp_ignition_set = 3
    end
    
    if xp_ignition_set == 3 and xp_starter_set == 1 then
        xp_ignition = 4
    else
        xp_ignition = xp_ignition_set
    end
    
    -- generator
    if button(btn_generator) then
        xp_generator = 1
    else
        xp_generator = 0
    end
    
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
        xp_avionics2 = 1
    else
        xp_avionics = 0
        xp_avionics2 = 0
    end
    
    -- parkbrake
    if button(btn_parkbrake) then
        xp_parkbrake = 1
    else
        xp_parkbrake = 0
    end
    
    -- landing gear
    if button(btn_gear) then
        xp_gear = 0
    else
        xp_gear = 1
    end
end

do_every_frame("switch_panel()")