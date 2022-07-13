logMsg("GA_Switch_Panel: script loaded")

usbSimInput = false
for i = 1,NUMBER_OF_HID_DEVICES,1 do
    if ALL_HID_DEVICES[i].vendor_id == 0x16c0 and ALL_HID_DEVICES[i].product_id == 0x27dc then
        usbSimInput = true
    end
end

if not usbSimInput then
    logMsg("GA_Switch_Panel: usbSimInput not found")
else
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

    isREP = false
    if string.match(AIRCRAFT_PATH, "REP") then
        isREP = true
    end
    
    isMultiEngine = false
    dataref("num_engines", "sim/aircraft/engine/acf_num_engines")
    if num_engines > 1 then
        isMultiEngine = true
    end
    
    -- ignition key
    xp_ignition_ref = XPLMFindDataRef("sim/cockpit2/engine/actuators/ignition_key")
    xp_ignition_array = XPLMGetDatavi(xp_ignition_ref, 0, 8)

    -- generator
    xp_generator_ref = XPLMFindDataRef("sim/cockpit2/electrical/generator_on")
    xp_generator_array = XPLMGetDatavi(xp_generator_ref, 0, 8)

    -- battery
    xp_battery_ref = XPLMFindDataRef("sim/cockpit2/electrical/battery_on")
    xp_battery_array = XPLMGetDatavi(xp_battery_ref, 0, 8)

    -- fuel pump
    xp_fuel_pump_ref = XPLMFindDataRef("sim/cockpit2/engine/actuators/fuel_pump_on")
    xp_fuel_pump_array = XPLMGetDatavi(xp_fuel_pump_ref, 0, 8)

    -- beacon
    dataref("xp_beacon", "sim/cockpit2/switches/beacon_on", "writable")

    -- landing
    dataref("xp_landing", "sim/cockpit2/switches/landing_lights_on", "writable")
    xp_landing_ref = XPLMFindDataRef("sim/cockpit2/switches/landing_lights_switch")
    xp_landing_array = XPLMGetDatavf(xp_landing_ref, 0, 16)

    -- taxi
    dataref("xp_taxi", "sim/cockpit2/switches/taxi_light_on", "writable")

    -- nav
    dataref("xp_nav", "sim/cockpit2/switches/navigation_lights_on", "writable")

    -- strobe
    dataref("xp_strobe", "sim/cockpit2/switches/strobe_lights_on", "writable")

    -- pitot
    dataref("xp_pitot", "sim/cockpit2/ice/ice_pitot_heat_on_pilot", "writable")
    dataref("xp_pitot2", "sim/cockpit2/ice/ice_pitot_heat_on_copilot", "writable")

    -- avionics
    dataref("xp_avionics", "sim/cockpit2/switches/avionics_power_on", "writable")
    if isREP then
        dataref("xp_avionics2", "simcoders/rep/cockpit2/switches/avionics_power_on", "writable")
    end
    dataref("xp_avionics3", "sim/cockpit2/electrical/cross_tie", "writable")

    -- parkbrake
    dataref("xp_parkbrake", "sim/flightmodel/controls/parkbrake", "writable")

    -- landing gear
    dataref("xp_gear", "sim/cockpit2/controls/gear_handle_down", "writable")

    function switch_panel()
        -- ignition key
        if not isMultiEngine then
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
                for i = 0,7,1 do
                    xp_ignition_array[i] = 4
                end
            else
                for i = 0,7,1 do
                    xp_ignition_array[i] = xp_ignition_set
                end
            end
            XPLMSetDatavi(xp_ignition_ref, xp_ignition_array, 0, 8)
        end
        
        -- generator
        if button(btn_generator) then
            for i = 0,7,1 do
                xp_generator_array[i] = 1
            end
        else
            for i = 0,7,1 do
                xp_generator_array[i] = 0
            end
        end
        XPLMSetDatavi(xp_generator_ref, xp_generator_array, 0, 8)
        
        -- battery
        if button(btn_battery) then
            for i = 0,7,1 do
                xp_battery_array[i] = 1
            end
            
        else
            for i = 0,7,1 do
                xp_battery_array[i] = 0
            end
        end
        XPLMSetDatavi(xp_battery_ref, xp_battery_array, 0, 8)
        
        -- fuel pump
        if button(btn_fuel_pump) then
            for i = 0,7,1 do
                xp_fuel_pump_array[i] = 1
            end
        else
            for i = 0,7,1 do
                xp_fuel_pump_array[i] = 0
            end
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
            for i = 0,15,1 do
                xp_landing_array[i] = 1
            end
            xp_landing = 1
        else
            for i = 0,15,1 do
                xp_landing_array[i] = 0
            end
            xp_landing = 0
        end
        XPLMSetDatavf(xp_landing_ref, xp_landing_array, 0, 16)
        
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
            xp_pitot2 = 1
        else
            xp_pitot = 0
            xp_pitot2 = 0
        end
        
        -- avionics
        if button(btn_avionics) then
            xp_avionics = 1
            if isREP then
                xp_avionics2 = 1
            end
            xp_avionics3 = 1
        else
            xp_avionics = 0
            if isREP then
                xp_avionics2 = 0
            end
            xp_avionics3 = 0
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
end