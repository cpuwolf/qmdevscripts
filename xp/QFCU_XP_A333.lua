-- **********************************************************************************************************--
-- QFCU Driver for JD330
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2021-08-22  last modified:2022-03-16  test with JarDesign A330 v3,Xplane 11.53
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2021-04-25
-- modified by Wei Shuai <cpuwolf@gmail.com> 2022-09-18 for X-Plane 12 stock A333
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBrightness = 60      -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- ###############################################################################################
if PLANE_ICAO ~= "A333" then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

local qfcu_a330_xp_new = false
if uluaFind("laminar/A333/adirs/on_bat_status") then
    -- X-Plane 12.40 is here
    qfcu_a330_xp_new = true
end

-- fcu
local dr_qfcu_airspeed = iDataRef:New("sim/cockpit2/autopilot/airspeed_dial_kts_mach")
local dr_qfcu_is_mach = iDataRef:New("sim/cockpit2/autopilot/airspeed_is_mach")
local dr_qfcu_heading = iDataRef:New("sim/cockpit/autopilot/heading_mag")
local dr_qfcu_hdgtrkmode = iDataRef:New("sim/cockpit2/autopilot/trk_fpa")
local dr_qfcu_altitude = iDataRef:New("sim/cockpit/autopilot/altitude")
local dr_qfcu_vs = iDataRef:New("sim/cockpit/autopilot/vertical_velocity")
local dr_qfcu_spddashed = iDataRef:New("sim/cockpit2/autopilot/vnav_speed_window_open")
local dr_qfcu_hdgdashed = iDataRef:New("laminar/A333/autopilot/knobs/heading_push_pos")
local dr_qfcu_vsdashed = iDataRef:New("laminar/A333/autopilot/vvi_fpa_window_open")
local dr_qfcu_heading_trk = iDataRef:New("sim/cockpit/autopilot/heading_mag")
local dr_qfcu_vs_fpa = iDataRef:New("sim/cockpit2/autopilot/trk_fpa")
local dr_qfcu_altmanaged = iDataRef:New("sim/cockpit2/autopilot/altitude_mode")

local dr_qfcu_ap1 = iDataRef:New("laminar/A333/annun/autopilot/ap1_mode")
local dr_qfcu_ap2 = iDataRef:New("laminar/A333/annun/autopilot/ap2_mode")
local dr_qfcu_athr = iDataRef:New("sim/cockpit2/autopilot/autothrottle_arm")
local dr_qfcu_loc = iDataRef:New("laminar/A333/annun/autopilot/loc_mode")
-- local dr_qfcu_exped = iDataRef:New("AirbusFBW/APVerticalMode")
local dr_qfcu_appr = iDataRef:New("laminar/A333/annun/autopilot/appr_mode")

-- efis capt
local dr_qfcu_c_cstr = iDataRef:New("laminar/A333/annun/EFIS_capt_cstr")
local dr_qfcu_c_wpt = iDataRef:New("laminar/A333/annun/EFIS_capt_fix")
local dr_qfcu_c_vord = iDataRef:New("laminar/A333/annun/EFIS_capt_vor")
local dr_qfcu_c_ndb = iDataRef:New("laminar/A333/annun/EFIS_capt_ndb")
local dr_qfcu_c_arpt = iDataRef:New("laminar/A333/annun/EFIS_capt_arpt")
local dr_qfcu_c_fd = iDataRef:New("laminar/A333/PFD/FMAs/flight_dir_12_status")
local dr_qfcu_c_ils = iDataRef:New("laminar/A333/annun/captain_ls_bars_on")

-- sim/custom/xap/ind_baro_hpa  value disp in hpa mode
local dr_qfcu_c_baro = iDataRef:New("sim/cockpit/misc/barometer_setting")
local dr_qfcu_c_baro_hpa = iDataRef:New("laminar/A333/barometer/capt_inHg_hPa_pos")
local dr_qfcu_c_barounit = iDataRef:New("laminar/A333/barometer/capt_inHg_hPa_pos")
-- 0:in  1:hpa
local dr_qfcu_c_barostd = iDataRef:New("sim/cockpit2/gauges/actuators/barometer_setting_is_std_pilot") -- -- 0:normal 1:std

-- EFIS FO
local dr_qfcu_f_cstr = iDataRef:New("laminar/A333/annun/EFIS_fo_cstr")
local dr_qfcu_f_wpt = iDataRef:New("laminar/A333/annun/EFIS_fo_fix")
local dr_qfcu_f_vord = iDataRef:New("laminar/A333/annun/EFIS_fo_vor")
local dr_qfcu_f_ndb = iDataRef:New("laminar/A333/annun/EFIS_fo_ndb")
local dr_qfcu_f_arpt = iDataRef:New("laminar/A333/annun/EFIS_fo_arpt")
local dr_qfcu_f_fd = iDataRef:New("laminar/A333/annun/fo_flight_director_on")
local dr_qfcu_f_ils = iDataRef:New("laminar/A333/annun/fo_ls_bars_on")

-- sim/custom/xap/ind_baro_hpa  value disp in hpa mode
local dr_qfcu_f_baro = iDataRef:New("sim/cockpit/misc/barometer_setting2")
local dr_qfcu_f_baro_hpa = iDataRef:New("laminar/A333/barometer/fo_inHg_hPa_pos")
local dr_qfcu_f_barounit = iDataRef:New("laminar/A333/barometer/fo_inHg_hPa_pos")
-- 0:in  1:hpa
local dr_qfcu_f_barostd = iDataRef:New("sim/cockpit2/gauges/actuators/barometer_setting_is_std_copilot") -- -- 0:normal 1:std

-- brightness  AirbusFBW/ALT100_1000
local dr_qfcu_fcu_lightDisp = iDataRef:New("sim/cockpit2/electrical/instrument_brightness_ratio[10]") -- 0~0.2
local dr_qfcu_fcu_light = iDataRef:New("laminar/a333/rheostats/integ_glare_brightness")               -- 0~1
local dr_qfcu_fcu_power_b = iDataRef:New("laminar/A333/ecam/hyd/elec_blue_status")                    -- 0: ON  1：OFF
local dr_qfcu_fcu_power_g = iDataRef:New("laminar/A333/ecam/hyd/elec_green_status")                   -- 0: ON  1：OFF
local dr_qfcu_fcu_power_y = iDataRef:New("laminar/A333/ecam/hyd/elec_yellow_status")                  -- 0: ON  1：OFF
local dr_qfcu_fcu_test = iDataRef:New("laminar/a333/switches/ann_light_pos")
local qfcu_cmd_vs_dec = uluaFind("sim/autopilot/vertical_speed_down")
local qfcu_cmd_vs_inc = uluaFind("sim/autopilot/vertical_speed_up")
local qfcu_cmd_hdg_dec = uluaFind("sim/autopilot/heading_down")
local qfcu_cmd_hdg_inc = uluaFind("sim/autopilot/heading_up")
----------------------------  Display Dataref Set End ------------------------------------

qfcu:CfgCmd(0, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_down")
qfcu:CfgCmd(1, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_up")
qfcu:CfgCmd(2, "laminar/A333/autopilot/speed_knob_push")
qfcu:CfgCmd(3, "laminar/A333/autopilot/speed_knob_pull")
qfcu:CfgCmd(4, "sim/autopilot/heading_down")
qfcu:CfgCmd(5, "sim/autopilot/heading_up")
qfcu:CfgCmd(6, "laminar/A333/autopilot/heading_knob_push")
qfcu:CfgCmd(7, "laminar/A333/autopilot/heading_knob_pull")
qfcu:CfgValT(8, "sim/custom/xap/fcu/loc_bat")
qfcu:CfgValT(9, "sim/custom/xap/fcu/ap2")
qfcu:CfgValT(10, "sim/custom/xap/fcu/ap1")
qfcu:CfgValT(11, "sim/custom/xap/ap/athr_mode")
qfcu:CfgValT(12, "sim/custom/xap/fcu/push_alt")
qfcu:CfgValT(13, "sim/custom/xap/fcu/appr_bat")
qfcu:CfgValT(14, "sim/custom/xap/fcu/metric_alt")
qfcu:CfgCmd(15, "laminar/A333/autopilot/alt_step_left", "laminar/A333/autopilot/alt_step_right")
qfcu:CfgCmd(16, "sim/autopilot/altitude_down")
qfcu:CfgCmd(17, "sim/autopilot/altitude_up")
qfcu:CfgCmd(18, "laminar/A333/autopilot/altitude_knob_push")
qfcu:CfgCmd(19, "laminar/A333/autopilot/altitude_knob_pull")
qfcu:CfgCmd(20, "sim/autopilot/vertical_speed_down")
qfcu:CfgCmd(21, "sim/autopilot/vertical_speed_up")
qfcu:CfgCmd(22, "laminar/A333/autopilot/vertical_knob_push")
qfcu:CfgCmd(23, "laminar/A333/autopilot/vertical_knob_pull")


local pswh24 = QmdevPosSwitchInit("laminar/A333/knobs/EFIS_mode_pos_capt", 1, "laminar/A333/knobs/capt_EFIS_knob_right",
    "laminar/A333/knobs/capt_EFIS_knob_left")
qfcu:CfgPSw(24, pswh24, 0)
qfcu:CfgPSw(25, pswh24, 1)
qfcu:CfgPSw(26, pswh24, 2)
qfcu:CfgPSw(27, pswh24, 3)
qfcu:CfgPSw(28, pswh24, 4)

qfcu:CfgVal(29, "sim/cockpit2/EFIS/map_range", 0, nil)
qfcu:CfgVal(30, "sim/cockpit2/EFIS/map_range", 1, nil)
qfcu:CfgVal(31, "sim/cockpit2/EFIS/map_range", 2, nil)
qfcu:CfgVal(32, "sim/cockpit2/EFIS/map_range", 3, nil)
qfcu:CfgVal(33, "sim/cockpit2/EFIS/map_range", 4, nil)
qfcu:CfgVal(34, "sim/cockpit2/EFIS/map_range", 5, nil)
qfcu:CfgCmd(35, "laminar/A333/buttons/capt_EFIS_CSTR")
qfcu:CfgCmd(36, "sim/instruments/EFIS_fix")
qfcu:CfgCmd(37, "sim/instruments/EFIS_vor")
qfcu:CfgCmd(38, "sim/instruments/EFIS_ndb")
qfcu:CfgCmd(39, "sim/instruments/EFIS_apt")
qfcu:CfgValT(40, "sim/custom/xap/fcu/fd")
qfcu:CfgValT(41, "sim/custom/xap/fcu/ils")
qfcu:CfgVal(42, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 0, 1)
qfcu:CfgVal(43, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 2, 1)
qfcu:CfgVal(44, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 0, 1)
qfcu:CfgVal(45, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 2, 1)
qfcu:CfgCmd(46, "sim/GPS/g430n2_msg", "sim/instruments/barometer_down")
qfcu:CfgCmd(47, "sim/GPS/g430n2_msg", "sim/instruments/barometer_up")
if qfcu_a330_xp_new then
    qfcu:CfgVal(48, "sim/cockpit2/gauges/actuators/barometer_setting_is_std_pilot", 0, nil)
    qfcu:CfgVal(49, "sim/cockpit2/gauges/actuators/barometer_setting_is_std_pilot", 1, nil)
    qfcu:CfgCmd(50, "laminar/A333/knob/baro/capt_inHg", "laminar/A333/knob/baro/capt_hPa")
    qfcu:CfgVal(51, "sim/cockpit2/gauges/actuators/barometer_setting_is_std_copilot", 1, nil)
    qfcu:CfgVal(52, "sim/cockpit2/gauges/actuators/barometer_setting_is_std_copilot", 0, nil)
    qfcu:CfgCmd(53, "laminar/A333/knob/baro/fo_inHg", "laminar/A333/knob/baro/fo_hPa")
    qfcu:CfgCmd(54, "sim/autopilot/trkfpa")
else
    qfcu:CfgVal(48, "sim/custom/xap/fcu/baro_push_bat", 1, nil)
    qfcu:CfgVal(49, "sim/custom/xap/fcu/baro_pull_bat", 1, nil)
    qfcu:CfgVal(50, "sim/custom/xap/fcu/baro_ishpa", 0, 1)
    qfcu:CfgVal(51, "sim/custom/xap/fcu/baro_pull_bat", 1, nil)
    qfcu:CfgVal(52, "sim/custom/xap/fcu/baro_push_bat", 1, nil)
    qfcu:CfgVal(53, "sim/custom/xap/fcu/baro_ishpa", 0, 1)
    qfcu:CfgValT(54, "sim/custom/xap/fcu/hdgtrk")
end
qfcu:CfgCmd(55, "sim/autopilot/knots_mach_toggle")

local pswh56 = QmdevPosSwitchInit("laminar/A333/knobs/EFIS_mode_pos_fo", 1, "laminar/A333/knobs/fo_EFIS_knob_right",
    "laminar/A333/knobs/fo_EFIS_knob_left")
qfcu:CfgPSw(56, pswh56, 0)
qfcu:CfgPSw(57, pswh56, 1)
qfcu:CfgPSw(58, pswh56, 2)
qfcu:CfgPSw(59, pswh56, 3)
qfcu:CfgPSw(60, pswh56, 4)

qfcu:CfgVal(61, "sim/cockpit2/EFIS/map_range_copilot", 0, nil)
qfcu:CfgVal(62, "sim/cockpit2/EFIS/map_range_copilot", 1, nil)
qfcu:CfgVal(63, "sim/cockpit2/EFIS/map_range_copilot", 2, nil)
qfcu:CfgVal(64, "sim/cockpit2/EFIS/map_range_copilot", 3, nil)
qfcu:CfgVal(65, "sim/cockpit2/EFIS/map_range_copilot", 4, nil)
qfcu:CfgVal(66, "sim/cockpit2/EFIS/map_range_copilot", 5, nil)
qfcu:CfgCmd(67, "laminar/A333/buttons/fo_EFIS_CSTR")
qfcu:CfgCmd(68, "sim/instruments/EFIS_copilot_fix")
qfcu:CfgCmd(69, "sim/instruments/EFIS_copilot_vor")
qfcu:CfgCmd(70, "sim/instruments/EFIS_copilot_ndb")
qfcu:CfgCmd(71, "sim/instruments/EFIS_copilot_apt")
qfcu:CfgValT(72, "sim/custom/xap/fcu/fd")
qfcu:CfgValT(73, "sim/custom/xap/fcu/ils")
qfcu:CfgVal(74, "sim/cockpit2/EFIS/EFIS_1_selection_copilot", 0, 1)
qfcu:CfgVal(75, "sim/cockpit2/EFIS/EFIS_1_selection_copilot", 2, 1)
qfcu:CfgVal(76, "sim/cockpit2/EFIS/EFIS_2_selection_copilot", 0, 1)
qfcu:CfgVal(77, "sim/cockpit2/EFIS/EFIS_2_selection_copilot", 2, 1)
qfcu:CfgCmd(78, "sim/GPS/g430n2_msg", "sim/instruments/barometer_copilot_down")
qfcu:CfgCmd(79, "sim/GPS/g430n2_msg", "sim/instruments/barometer_copilot_up")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function sel(vari)
    if vari == true then
        return 1
    else
        return 0
    end
end

function digi_disp_set_LEDS_fcu()
    local qfcu_ap1 = dr_qfcu_ap1:Get()
    local qfcu_ap2 = dr_qfcu_ap2:Get()
    local qfcu_athr = dr_qfcu_athr:Get()
    local qfcu_loc = dr_qfcu_loc:Get()
    local qfcu_appr = dr_qfcu_appr:Get()
    --    local qfcu_exped = dr_qfcu_exped:Get()
    if dr_qfcu_ap1:Changed() or dr_qfcu_athr:Changed() or dr_qfcu_loc:Changed() or dr_qfcu_appr:Changed() then
        dr_qfcu_ap1:Update()
        -- dr_qfcu_ap2:Update()
        dr_qfcu_athr:Update()
        dr_qfcu_loc:Update()
        dr_qfcu_appr:Update()
        -- dr_qfcu_exped:Update()
        ------------------------------------fcu light -------------------
        uluaSet(idr_qfcu_hid_ledsap1, sel(qfcu_ap1 == 1))               -- ap1)
        uluaSet(idr_qfcu_hid_ledsap2, sel(qfcu_ap1 == 2))               -- ap2) no real ap2 data
        uluaSet(idr_qfcu_hid_ledsap2, ilua_bool_ternary(qfcu_ap2, 0))   -- athr)
        uluaSet(idr_qfcu_hid_ledsathr, ilua_bool_ternary(qfcu_athr, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsloc, ilua_bool_ternary(qfcu_loc, 0))   -- qfcu_loc)
        uluaSet(idr_qfcu_hid_ledsappr, ilua_bool_ternary(qfcu_appr, 0)) -- qfcu_appr)
        -- uluaSet(idr_qfcu_hid_ledsexped, ilua_bool_ternary(qfcu_exped, 110)) --qfcu_exped)
    end
end

function digi_disp_set_LEDS_l_efis()
    local qfcu_c_cstr = dr_qfcu_c_cstr:Get()
    local qfcu_c_wpt = dr_qfcu_c_wpt:Get()
    local qfcu_c_vord = dr_qfcu_c_vord:Get()
    local qfcu_c_ndb = dr_qfcu_c_ndb:Get()
    local qfcu_c_arpt = dr_qfcu_c_arpt:Get()
    local qfcu_c_fd = dr_qfcu_c_fd:Get()
    local qfcu_c_ils = dr_qfcu_c_ils:Get()
    local qfcu_c_barostd = dr_qfcu_c_barostd:Get()
    if dr_qfcu_c_cstr:Changed() or dr_qfcu_c_wpt:Changed() or dr_qfcu_c_vord:Changed() or dr_qfcu_c_ndb:Changed() or
        dr_qfcu_c_arpt:Changed() or dr_qfcu_c_fd:Changed() or dr_qfcu_c_ils:Changed() or dr_qfcu_c_barostd:Changed() then
        dr_qfcu_c_cstr:Update()
        dr_qfcu_c_wpt:Update()
        dr_qfcu_c_vord:Update()
        dr_qfcu_c_ndb:Update()
        dr_qfcu_c_arpt:Update()
        dr_qfcu_c_fd:Update()
        dr_qfcu_c_ils:Update()
        ---------------------------------------Efis leds capt
        uluaSet(idr_qfcu_hid_ledslcstr, ilua_bool_ternary(qfcu_c_cstr, 0)) -- cstr)
        uluaSet(idr_qfcu_hid_ledslwpt, ilua_bool_ternary(qfcu_c_wpt, 0))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledslvord, ilua_bool_ternary(qfcu_c_vord, 0)) -- vord)
        uluaSet(idr_qfcu_hid_ledslndb, ilua_bool_ternary(qfcu_c_ndb, 0))   -- ndb)
        uluaSet(idr_qfcu_hid_ledslaprt, ilua_bool_ternary(qfcu_c_arpt, 0)) -- aprt)
        uluaSet(idr_qfcu_hid_ledslfd, ilua_bool_ternary(qfcu_c_fd, 2))     -- fd)
        uluaSet(idr_qfcu_hid_ledslls, ilua_bool_ternary(qfcu_c_ils, 0))    -- ls)

        if qfcu_c_barostd == 0 then
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 1) -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
        end
    end
end

function digi_disp_set_LEDS_r_efis()
    local qfcu_f_cstr = dr_qfcu_f_cstr:Get()
    local qfcu_f_wpt = dr_qfcu_f_wpt:Get()
    local qfcu_f_vord = dr_qfcu_f_vord:Get()
    local qfcu_f_ndb = dr_qfcu_f_ndb:Get()
    local qfcu_f_arpt = dr_qfcu_f_arpt:Get()
    local qfcu_f_fd = dr_qfcu_f_fd:Get()
    local qfcu_f_ils = dr_qfcu_f_ils:Get()
    local qfcu_f_barostd = dr_qfcu_f_barostd:Get()

    if dr_qfcu_f_cstr:Changed() or dr_qfcu_f_wpt:Changed() or dr_qfcu_f_vord:Changed() or dr_qfcu_f_ndb:Changed() or
        dr_qfcu_f_arpt:Changed() or dr_qfcu_f_fd:Changed() or dr_qfcu_f_ils:Changed() or dr_qfcu_f_barostd:Changed() then
        dr_qfcu_f_cstr:Update()
        dr_qfcu_f_wpt:Update()
        dr_qfcu_f_vord:Update()
        dr_qfcu_f_ndb:Update()
        dr_qfcu_f_arpt:Update()
        dr_qfcu_f_fd:Update()
        dr_qfcu_f_ils:Update()
        ---------------------------------------Efis leds FO---------
        uluaSet(idr_qfcu_hid_ledsrcstr, ilua_bool_ternary(qfcu_f_cstr, 0)) -- cstr)
        uluaSet(idr_qfcu_hid_ledsrwpt, ilua_bool_ternary(qfcu_f_wpt, 0))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledsrvord, ilua_bool_ternary(qfcu_f_vord, 0)) -- vord)
        uluaSet(idr_qfcu_hid_ledsrndb, ilua_bool_ternary(qfcu_f_ndb, 0))   -- ndb)
        uluaSet(idr_qfcu_hid_ledsraprt, ilua_bool_ternary(qfcu_f_arpt, 0)) -- aprt)
        uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_f_fd, 0))     -- fd)
        uluaSet(idr_qfcu_hid_ledsrls, ilua_bool_ternary(qfcu_f_ils, 0))    -- ls)
        if qfcu_f_barostd == 0 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 0)                              -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 1)                              -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledsrqfe, 0)                              -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 0)                              -- qhn)
        end                                                                -- qhn)
    end
end

function digi_disp_set_LEDS()
    digi_disp_set_LEDS_fcu()
    digi_disp_set_LEDS_l_efis()
    digi_disp_set_LEDS_r_efis()
end

function digi_disp_set_SPD()
    local qfcu_airspeed = dr_qfcu_airspeed:Get()
    local qfcu_spddashed = dr_qfcu_spddashed:Get()
    local qfcu_is_mach = dr_qfcu_is_mach:Get()

    if dr_qfcu_airspeed:Changed() or dr_qfcu_spddashed:Changed() or dr_qfcu_is_mach:Changed() then
        dr_qfcu_airspeed:Update()
        dr_qfcu_spddashed:Update()
        dr_qfcu_is_mach:Update()

        if qfcu_spddashed == 0 then
            uluaSet(idr_qfcu_hid_iasmode, 2)
        else
            if qfcu_is_mach == 1 then
                c_spd = math.floor(qfcu_airspeed * 100 + 0.5)
                uluaSet(idr_qfcu_hid_iasval_f, c_spd / 100)
                uluaSet(idr_qfcu_hid_iasmode, 3)
            else
                c_spd = math.floor(qfcu_airspeed + 0.5)
                uluaSet(idr_qfcu_hid_iasmode, 1)
                uluaSet(idr_qfcu_hid_iasval_i, c_spd)
            end
        end
    end
end

function digi_disp_set_HDG()
    local qfcu_heading = dr_qfcu_heading:Get()
    local qfcu_hdgdashed = dr_qfcu_hdgdashed:Get()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:Get()
    local qfcu_heading_trk = dr_qfcu_heading_trk:Get()

    if dr_qfcu_heading:Changed() or dr_qfcu_hdgdashed:Changed() or dr_qfcu_heading_trk:Changed() then
        dr_qfcu_hdgdashed:Update()
        dr_qfcu_heading_trk:Update()
        dr_qfcu_heading:Update()
        -- real code
        if qfcu_hdgdashed == 1 then
            uluaSet(idr_qfcu_hid_hdgmode, 2)
        else
            if qfcu_hdgtrkmode == 1 then -- trk mode
                uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading_trk)
            else
                uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading)
            end
            uluaSet(idr_qfcu_hid_hdgmode, 1)
        end
    end
end

function digi_disp_set_ALT()
    local qfcu_altmanaged = dr_qfcu_altmanaged:Get()
    local qfcu_altitude = dr_qfcu_altitude:Get()

    if dr_qfcu_altitude:Changed() or dr_qfcu_altmanaged:Changed() then
        dr_qfcu_altitude:Update()
        dr_qfcu_altmanaged:Update()
        -- real code
        uluaSet(idr_qfcu_hid_altval_i, qfcu_altitude)
        if qfcu_altmanaged == 3 then
            uluaSet(idr_qfcu_hid_altmode, 2)
        elseif qfcu_altmanaged == 5 then
            uluaSet(idr_qfcu_hid_altmode, 1)
        end
    end
end

function digi_disp_set_VS()
    local qfcu_vs = dr_qfcu_vs:Get()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:Get()
    local qfcu_vsdashed = dr_qfcu_vsdashed:Get()
    local qfcu_vs_fpa = dr_qfcu_vs_fpa:Get()
    if dr_qfcu_vs:Changed() or dr_qfcu_hdgtrkmode:Changed() or dr_qfcu_vsdashed:Changed() or dr_qfcu_vs_fpa:Changed() then
        dr_qfcu_vs:Update()
        dr_qfcu_hdgtrkmode:Update()
        dr_qfcu_vsdashed:Update()
        dr_qfcu_vs_fpa:Update()
        dr_qfcu_heading:Invalid(-1)
        dr_qfcu_heading_trk:Invalid(-1)

        -- real code
        if qfcu_vsdashed == 0 then
            if qfcu_hdgtrkmode == 1 then -- TRK mode
                uluaSet(idr_qfcu_hid_vs_trkmode, 2)
                uluaSet(idr_qfcu_hid_invalid, 4)
            else
                uluaSet(idr_qfcu_hid_vsmode, 2)
                uluaSet(idr_qfcu_hid_invalid, 3)
            end
        else
            if qfcu_hdgtrkmode == 1 then
                if (qfcu_vs_fpa > 99) then -- fix display bug in fpa mode
                    qfcu_vs_fpa = qfcu_vs_fpa % 100
                end
                uluaSet(idr_qfcu_hid_vs_trkval_i, math.abs(qfcu_vs_fpa * 100))
                if qfcu_vs_fpa < 0 then
                    uluaSet(idr_qfcu_hid_vs_trkmode, 3)
                else
                    uluaSet(idr_qfcu_hid_vs_trkmode, 1)
                end
                uluaSet(idr_qfcu_hid_invalid, 4)
            else
                uluaSet(idr_qfcu_hid_vsval_i, math.abs(qfcu_vs))
                if qfcu_vs < 0 then
                    uluaSet(idr_qfcu_hid_vsmode, 3)
                else
                    uluaSet(idr_qfcu_hid_vsmode, 1)
                end
                uluaSet(idr_qfcu_hid_invalid, 3)
            end
        end
    end
end

-----------EFIS Capt-------------

function digi_disp_set_L_EFIS()
    local qfcu_c_baro = dr_qfcu_c_baro:Get()
    local qfcu_c_barounit = dr_qfcu_c_barounit:Get()
    local qfcu_c_barostd = dr_qfcu_c_barostd:Get()
    local qfcu_c_baro_hpa = dr_qfcu_c_baro_hpa:Get()
    if dr_qfcu_c_baro:Changed() or dr_qfcu_c_barounit:Changed() or dr_qfcu_c_barostd:Changed() then
        dr_qfcu_c_baro:Update()
        dr_qfcu_c_barounit:Update()
        dr_qfcu_c_barostd:Update()
        -- real code
        if qfcu_c_barostd == 1 then -- std
            uluaSet(idr_qfcu_hid_lefismode, 3)
        else
            if qfcu_c_barounit == 1 then -- hpa mode
                c_baro = math.floor(qfcu_c_baro * 33.863 + 0.5)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 2)
            else
                c_baro = math.floor(qfcu_c_baro * 100)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 1)
            end
        end
    end
end

---------------------EFIS FO-------------

function digi_disp_set_R_EFIS()
    local qfcu_f_baro = dr_qfcu_f_baro:Get()
    local qfcu_f_barounit = dr_qfcu_f_barounit:Get()
    local qfcu_f_barostd = dr_qfcu_f_barostd:Get()
    if dr_qfcu_f_baro:Changed() or dr_qfcu_f_barounit:Changed() or dr_qfcu_f_barostd:Changed() then
        dr_qfcu_f_baro:Update()
        dr_qfcu_f_barounit:Update()
        dr_qfcu_f_barostd:Update()
        -- real code
        if qfcu_f_barostd == 1 then -- std
            uluaSet(idr_qfcu_hid_refismode, 3)
        else
            if qfcu_f_barounit == 1 then -- hpa mode
                f_baro = math.floor(qfcu_f_baro * 33.863 + 0.5)
                uluaSet(idr_qfcu_hid_refisval_i, f_baro)
                uluaSet(idr_qfcu_hid_refismode, 2)
            else
                f_baro = math.floor(qfcu_f_baro * 100 + 0.5)
                uluaSet(idr_qfcu_hid_refisval_i, f_baro)
                uluaSet(idr_qfcu_hid_refismode, 1)
            end
        end
    end
end

function invalid_buffer_digi()
    -- update cache
    dr_qfcu_airspeed:Invalid(-1)
    dr_qfcu_heading:Invalid(-1)
    dr_qfcu_altitude:Invalid(-1000000)
    dr_qfcu_vsdashed:Invalid(11)
    dr_qfcu_c_baro:Invalid(-1)
    dr_qfcu_f_baro:Invalid(-1)
end

-- Backlight

function digi_disp_set_Bright()
    local qfcu_fcu_light = dr_qfcu_fcu_light:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_fcu_lightDisp = dr_qfcu_fcu_lightDisp:Get()

    qfcu_fcu_light = math.floor(qfcu_fcu_light * MaxBrightness)
    qfcu_fcu_lightDisp = math.floor(qfcu_fcu_lightDisp * 15 + 1)

    if dr_qfcu_fcu_light:Changed() or dr_qfcu_fcu_lightDisp:Changed() then
        dr_qfcu_fcu_light:Update()
        dr_qfcu_fcu_lightDisp:Update()
        -- real code
        -- uluaLog("当前值: " .. tostring(qfcu_fcu_lightDisp))
        -------------------------------------------------------------
        uluaSet(idr_qfcu_hid_brightval_i, qfcu_fcu_light)
        uluaSet(idr_qfcu_hid_dispbrightval_i, qfcu_fcu_lightDisp)
    end

    if dr_qfcu_fcu_test:Changed() then
        dr_qfcu_fcu_test:Update()
        uluaSet(idr_qfcu_hid_indbrightval_i, qfcu_fcu_test + 1)
        if qfcu_fcu_test ~= 2 then
            uluaSet(idr_qfcu_hid_invalid, -1)
            -- else
            invalid_buffer_digi()
        end
    end
end

-------------------------------------------------------------
function digi_disp_set_BrightOff()
    dr_qfcu_fcu_light:Invalid(-1)
    dr_qfcu_fcu_lightDisp:Invalid(-1)
    uluaSet(idr_qfcu_hid_brightval_i, 0)
    uluaSet(idr_qfcu_hid_indbrightval_i, 0)
    -- uluaSet(idr_qfcu_hid_dispbrightval_i, 0)
end

function digi_disp_powoff_leds()
    -- update cache
    dr_qfcu_ap1:Invalid(-1)
    dr_qfcu_c_cstr:Invalid(-1)
    dr_qfcu_f_cstr:Invalid(-1)
    -- real code
    uluaSet(idr_qfcu_hid_ledsval_i, 0)
    uluaSet(idr_qfcu_hid_ledslval_i, 0)
    uluaSet(idr_qfcu_hid_ledsrval_i, 0)
end

function digi_disp_powoff_mcp()
    invalid_buffer_digi()
    -- real code
    uluaSet(idr_qfcu_hid_iasmode, 0)
    uluaSet(idr_qfcu_hid_hdgmode, 0)
    uluaSet(idr_qfcu_hid_altmode, 0)
    uluaSet(idr_qfcu_hid_vsmode, 0)
    uluaSet(idr_qfcu_hid_refismode, 0)
    uluaSet(idr_qfcu_hid_lefismode, 0)
end

-----end sub functions
local digi_disp_fcu_func_table = { digi_disp_set_SPD, digi_disp_set_HDG, digi_disp_set_ALT, digi_disp_set_VS,
    digi_disp_set_L_EFIS, digi_disp_set_R_EFIS }

local digi_disp_rr_func_idx = 0

function digi_disp_mcp_rr()
    for i = 1, 6 do
        -- Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx + 1
        if digi_disp_rr_func_idx > 6 then
            digi_disp_rr_func_idx = 1
        end
        digi_disp_fcu_func_table[digi_disp_rr_func_idx]()
    end
end

function XP330_is_power_on()
    local qfcu_fcu_power_b = dr_qfcu_fcu_power_b:Get()
    local qfcu_fcu_power_g = dr_qfcu_fcu_power_g:Get()
    local qfcu_fcu_power_y = dr_qfcu_fcu_power_y:Get()
    if qfcu_fcu_power_y == 0 or qfcu_fcu_power_g == 0 or qfcu_fcu_power_b == 0 then
        return true
    else
        return false
    end
end

local is_load = 0
local start_time = os.clock()
function JD330_boot()
    if is_load == 0 then
        if os.clock() > (start_time + 10) or XP330_is_power_on() then
            is_load = 1
            uluaAddDoLoop("JD330_digi_disp_every_frame()")
        end
    end
end

local qfcu_fcu_power_last = false
function JD330_digi_disp_every_frame()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:Get()
    local qfcu_vs_fpa = dr_qfcu_vs_fpa:Get()
    local qfcu_heading_trk = dr_qfcu_heading_trk:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_val_condbtn_4 = idr_qfcu_hid_condbtn_4:Get()
    local qfcu_val_condbtn_5 = idr_qfcu_hid_condbtn_5:Get()
    local qfcu_val_condbtn_16 = idr_qfcu_hid_condbtn_16:Get()
    local qfcu_val_condbtn_17 = idr_qfcu_hid_condbtn_17:Get()
    local qfcu_val_condbtn_20 = idr_qfcu_hid_condbtn_20:Get()
    local qfcu_val_condbtn_21 = idr_qfcu_hid_condbtn_21:Get()

    if qfcu_fcu_power_last ~= XP330_is_power_on() then
        if XP330_is_power_on() then
            uluaSet(idr_qfcu_hid_indbrightval_i, qfcu_fcu_test + 1)
            uluaSet(idr_qfcu_hid_invalid, -1)
        end
        qfcu_fcu_power_last = XP330_is_power_on()
    end

    -------------------
    if XP330_is_power_on() then
        digi_disp_set_Bright()
        digi_disp_set_LEDS()
        digi_disp_mcp_rr()
    else
        -- digi_disp_powoff_leds()
        -- digi_disp_powoff_mcp()
        digi_disp_set_BrightOff()
    end
end

uluaAddDoLoop("JD330_boot()")
