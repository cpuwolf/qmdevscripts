-- **********************************************************************************************************--
-- QFCU Driver for JD330
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2021-08-22  last modified:2022-03-16  test with JarDesign A330 v3,Xplane 11.53
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2021-04-25
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBrightness = 60 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- ###############################################################################################
if PLANE_ICAO ~= "A330" then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

-- fcu
local dr_qfcu_airspeed = iDataRef:New("jd/fadec/airspd_dial_ind")
local dr_qfcu_is_mach = iDataRef:New("sim/cockpit2/autopilot/airspeed_is_mach")
local dr_qfcu_heading = iDataRef:New("sim/cockpit/autopilot/heading_mag")
local dr_qfcu_hdgtrkmode = iDataRef:New("sim/custom/xap/fcu/hdgtrk")
local dr_qfcu_altitude = iDataRef:New("sim/cockpit/autopilot/altitude")
local dr_qfcu_vs = iDataRef:New("sim/cockpit/autopilot/vertical_velocity")
local dr_qfcu_spddashed = iDataRef:New("sim/custom/xap/ap/spdmanaged")
local dr_qfcu_hdgdashed = iDataRef:New("sim/custom/xap/fcu/hdgtrk/hdg_dash")
local dr_qfcu_vsdashed = iDataRef:New("sim/custom/xap/fcu/vvi_dash_view")
local dr_qfcu_heading_trk = iDataRef:New("sim/custom/xap/trk_dial")
local dr_qfcu_alt1000 = iDataRef:New("sim/custom/xap/fcu/alt1000x")
local dr_qfcu_alt100 = iDataRef:New("sim/custom/xap/fcu/alt100x")
local dr_qfcu_vs_fpa = iDataRef:New("sim/custom/xap/fcu/fpa_set_mult10")
local dr_qfcu_altmanaged = iDataRef:New("sim/custom/xap/fcu/lvlch_dot")

local dr_qfcu_ap1 = iDataRef:New("sim/custom/xap/fcu/ap_summ")
-- local dr_qfcu_ap2 = iDataRef:New("AirbusFBW/AP2Engage")
local dr_qfcu_athr = iDataRef:New("sim/custom/xap/ap/athr_mode")
local dr_qfcu_loc = iDataRef:New("sim/custom/xap/fcu/loc_bat")
-- local dr_qfcu_exped = iDataRef:New("AirbusFBW/APVerticalMode")
local dr_qfcu_appr = iDataRef:New("sim/custom/xap/fcu/appr_bat")

-- efis capt
-- sim/custom/xap/nd/efis_opt_pb  1:cstr 2:wpt 3:vord 4:wpt 5:cstr
local dr_qfcu_c_efis = iDataRef:New("sim/custom/xap/nd/efis_opt_pb") -- 1:cstr 2:wpt 3:vord 4:wpt 5:cstr
local dr_qfcu_c_fd = iDataRef:New("sim/custom/xap/fcu/fd")
local dr_qfcu_c_ils = iDataRef:New("sim/custom/xap/fcu/ils")

-- sim/custom/xap/ind_baro_hpa  value disp in hpa mode
local dr_qfcu_c_baro = iDataRef:New("sim/cockpit/misc/barometer_setting")
local dr_qfcu_c_baro_hpa = iDataRef:New("sim/custom/xap/ind_baro_hpa")
local dr_qfcu_f_baro = iDataRef:New("sim/cockpit/misc/barometer_setting")
local dr_qfcu_c_barounit = iDataRef:New("sim/custom/xap/fcu/baro_ishpa")
-- 0:in  1:hpa
local dr_qfcu_c_barostd = iDataRef:New("sim/custom/xap/baro_man_sel") -- 0:std 1:normal

-- EFIS FO
-- DataRef('qfcu_f_cstr', 'AirbusFBW/NDShowCSTRFO')
-- DataRef('qfcu_f_wpt', 'AirbusFBW/NDShowWPTFO')
-- DataRef('qfcu_f_vord', 'AirbusFBW/NDShowVORDFO')
-- DataRef('qfcu_f_ndb', 'AirbusFBW/NDShowNDBFO')
-- DataRef('qfcu_f_arpt', 'AirbusFBW/NDShowARPTFO')
-- DataRef('qfcu_f_fd', 'AirbusFBW/FD2Engage')
-- DataRef('qfcu_f_ils', 'AirbusFBW/ILSonFO')

-- DataRef('qfcu_f_baro', 'sim/cockpit/misc/barometer_setting2')
-- DataRef('qfcu_f_barounit', 'AirbusFBW/BaroUnitFO')
-- DataRef('qfcu_f_barostd', 'AirbusFBW/BaroStdFO')

-- DataRef('qfcu_ap1', 'sim/custom/xap/fcu/ap_summ')
-- DataRef('qfcu_ap2', 'AirbusFBW/AP2Engage')
-- DataRef('qfcu_athr', 'sim/custom/xap/ap/athr_mode')
-- DataRef('qfcu_loc', 'sim/custom/xap/fcu/loc_bat')
-- DataRef('qfcu_exped', 'AirbusFBW/APVerticalMode')
-- DataRef('qfcu_appr', 'sim/custom/xap/fcu/appr_bat')

-- brightness  AirbusFBW/ALT100_1000
local dr_qfcu_fcu_lightDisp = iDataRef:New('sim/custom/xap/intlight/FCU_led_lt')
local dr_qfcu_fcu_light = iDataRef:New("sim/custom/xap/intlight/int_pan_ped_kn") -- 0~1
local dr_qfcu_fcu_power = iDataRef:New("sim/custom/xap/elec/acess") -- 0: OFF  1：ON
local dr_qfcu_alt_unit = iDataRef:New("sim/custom/xap/fcu/100_1000") -- 0: 100  1：1000
local dr_qfcu_fcu_test = iDataRef:New("sim/custom/xap/intlight/ann_lt")
local qfcu_cmd_vs_dec = uluaFind("sim/autopilot/vertical_speed_down")
local qfcu_cmd_vs_inc = uluaFind("sim/autopilot/vertical_speed_up")
local qfcu_cmd_hdg_dec = uluaFind("sim/autopilot/heading_down")
local qfcu_cmd_hdg_inc = uluaFind("sim/autopilot/heading_up")
----------------------------  Display Dataref Set End ------------------------------------

qfcu:CfgEncFull(4, 5, "cpuwolf/qmdev/QFCU/condbtn[4]" , 10, 1, 0, -39500, 39500)
qfcu:CfgEncFull(16, 17, "cpuwolf/qmdev/QFCU/condbtn[16]" , 10, 1, 0, -39500, 39500)
qfcu:CfgEncFull(46, 47, "cpuwolf/qmdev/QFCU/condbtn[46]" , 10, 1, 0, -39500, 39500)
qfcu:CfgEncFull(78, 79, "cpuwolf/qmdev/QFCU/condbtn[46]" , 10, 1, 0, -39500, 39500)

qfcu:CfgCmd(0, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_down")
qfcu:CfgCmd(1, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_up")
qfcu:CfgVal(2, "sim/custom/xap/fcu/spd_push_bat", 1, nil)
qfcu:CfgVal(3, "sim/custom/xap/fcu/spd_pull_bat", 1, nil)
qfcu:CfgVal(6, "sim/custom/xap/fcu/hdg_push_bat", 1, nil)
qfcu:CfgVal(7, "sim/custom/xap/fcu/hdg_pull_bat", 1, nil)
qfcu:CfgValT(8, "sim/custom/xap/fcu/loc_bat")
qfcu:CfgValT(9, "sim/custom/xap/fcu/ap2")
qfcu:CfgValT(10, "sim/custom/xap/fcu/ap1")
qfcu:CfgValT(11, "sim/custom/xap/ap/athr_mode")
qfcu:CfgValT(12, "sim/custom/xap/fcu/push_alt")
qfcu:CfgValT(13, "sim/custom/xap/fcu/appr_bat")
qfcu:CfgValT(14, "sim/custom/xap/fcu/metric_alt")
qfcu:CfgVal(15, "sim/custom/xap/fcu/100_1000", 0, 1)
qfcu:CfgVal(18, "sim/custom/xap/fcu/alt_push_bat", 1, nil)
qfcu:CfgVal(19, "sim/custom/xap/fcu/alt_pull_bat", 1, nil)
qfcu:CfgVal(20, "cpuwolf/qmdev/QFCU/condbtn[20]", 1, 0)
qfcu:CfgVal(21, "cpuwolf/qmdev/QFCU/condbtn[21]", 1, 0)
qfcu:CfgVal(22, "sim/custom/xap/fcu/vvi_push_bat", 1, nil)
qfcu:CfgVal(23, "sim/custom/xap/fcu/vvi_pull_bat", 1, nil)
qfcu:CfgVal(24, "sim/custom/xap/fcu/nd_mode", 0, nil)
qfcu:CfgVal(25, "sim/custom/xap/fcu/nd_mode", 1, nil)
qfcu:CfgVal(26, "sim/custom/xap/fcu/nd_mode", 2, nil)
qfcu:CfgVal(27, "sim/custom/xap/fcu/nd_mode", 3, nil)
qfcu:CfgVal(28, "sim/custom/xap/fcu/nd_mode", 4, nil)
qfcu:CfgVal(29, "sim/cockpit2/EFIS/map_range", 2, nil)
qfcu:CfgVal(30, "sim/cockpit2/EFIS/map_range", 3, nil)
qfcu:CfgVal(31, "sim/cockpit2/EFIS/map_range", 4, nil)
qfcu:CfgVal(32, "sim/cockpit2/EFIS/map_range", 5, nil)
qfcu:CfgVal(33, "sim/cockpit2/EFIS/map_range", 6, nil)
qfcu:CfgVal(34, "sim/cockpit2/EFIS/map_range", 7, nil)
qfcu:CfgVal(35, "sim/custom/xap/nd/efis_opt_pb", 1, nil)
qfcu:CfgVal(36, "sim/custom/xap/nd/efis_opt_pb", 2, nil)
qfcu:CfgVal(37, "sim/custom/xap/nd/efis_opt_pb", 3, nil)
qfcu:CfgVal(38, "sim/custom/xap/nd/efis_opt_pb", 4, nil)
qfcu:CfgVal(39, "sim/custom/xap/nd/efis_opt_pb", 5, nil)
qfcu:CfgValT(40, "sim/custom/xap/fcu/fd")
qfcu:CfgValT(41, "sim/custom/xap/fcu/ils")
qfcu:CfgVal(42, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 0, 1)
qfcu:CfgVal(43, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 2, 1)
qfcu:CfgVal(44, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 0, 1)
qfcu:CfgVal(45, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 2, 1)
-- qfcu:CfgCmd(46, "sim/GPS/g430n2_msg", "sim/instruments/barometer_down")
-- qfcu:CfgCmd(47, "sim/GPS/g430n2_msg", "sim/instruments/barometer_up")
qfcu:CfgVal(48, "sim/custom/xap/fcu/baro_push_bat", 1, nil)
qfcu:CfgVal(49, "sim/custom/xap/fcu/baro_pull_bat", 1, nil)
qfcu:CfgVal(50, "sim/custom/xap/fcu/baro_ishpa", 0, 1)
qfcu:CfgVal(51, "sim/custom/xap/fcu/baro_pull_bat", 1, nil)
qfcu:CfgVal(52, "sim/custom/xap/fcu/baro_push_bat", 1, nil)
qfcu:CfgVal(53, "sim/custom/xap/fcu/baro_ishpa", 0, 1)
qfcu:CfgValT(54, "sim/custom/xap/fcu/hdgtrk")
qfcu:CfgCmd(55, "sim/autopilot/knots_mach_toggle")
qfcu:CfgVal(56, "sim/custom/xap/fcu/nd_mode", 0, nil)
qfcu:CfgVal(57, "sim/custom/xap/fcu/nd_mode", 1, nil)
qfcu:CfgVal(58, "sim/custom/xap/fcu/nd_mode", 2, nil)
qfcu:CfgVal(59, "sim/custom/xap/fcu/nd_mode", 3, nil)
qfcu:CfgVal(60, "sim/custom/xap/fcu/nd_mode", 4, nil)
qfcu:CfgVal(61, "sim/cockpit2/EFIS/map_range", 2, nil)
qfcu:CfgVal(62, "sim/cockpit2/EFIS/map_range", 3, nil)
qfcu:CfgVal(63, "sim/cockpit2/EFIS/map_range", 4, nil)
qfcu:CfgVal(64, "sim/cockpit2/EFIS/map_range", 5, nil)
qfcu:CfgVal(65, "sim/cockpit2/EFIS/map_range", 6, nil)
qfcu:CfgVal(66, "sim/cockpit2/EFIS/map_range", 7, nil)
qfcu:CfgVal(67, "sim/custom/xap/nd/efis_opt_pb", 1, nil)
qfcu:CfgVal(68, "sim/custom/xap/nd/efis_opt_pb", 2, nil)
qfcu:CfgVal(69, "sim/custom/xap/nd/efis_opt_pb", 3, nil)
qfcu:CfgVal(70, "sim/custom/xap/nd/efis_opt_pb", 4, nil)
qfcu:CfgVal(71, "sim/custom/xap/nd/efis_opt_pb", 5, nil)
qfcu:CfgValT(72, "sim/custom/xap/fcu/fd")
qfcu:CfgValT(73, "sim/custom/xap/fcu/ils")
qfcu:CfgVal(74, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 0, 1)
qfcu:CfgVal(75, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 2, 1)
qfcu:CfgVal(76, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 0, 1)
qfcu:CfgVal(77, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 2, 1)
-- qfcu:CfgCmd(78, "sim/GPS/g430n2_msg", "sim/instruments/barometer_down")
-- qfcu:CfgCmd(79, "sim/GPS/g430n2_msg", "sim/instruments/barometer_up")

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
    --    local qfcu_ap2 = dr_qfcu_ap2:Get()
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
        uluaSet(idr_qfcu_hid_ledsap1, sel(qfcu_ap1 == 1)) -- ap1)
        uluaSet(idr_qfcu_hid_ledsap2, sel(qfcu_ap1 == 2)) -- ap2) no real ap2 data
        -- uluaSet(idr_qfcu_hid_ledsap2, ilua_bool_ternary(qfcu_ap2, 0)) --athr)
        uluaSet(idr_qfcu_hid_ledsathr, ilua_bool_ternary(qfcu_athr, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsloc, ilua_bool_ternary(qfcu_loc, 0)) -- qfcu_loc)
        uluaSet(idr_qfcu_hid_ledsappr, ilua_bool_ternary(qfcu_appr, 0)) -- qfcu_appr)
        -- uluaSet(idr_qfcu_hid_ledsexped, ilua_bool_ternary(qfcu_exped, 110)) --qfcu_exped)
    end
end

function digi_disp_set_LEDS_l_efis()
    local qfcu_c_efis = dr_qfcu_c_efis:Get()
    local qfcu_c_fd = dr_qfcu_c_fd:Get()
    local qfcu_c_ils = dr_qfcu_c_ils:Get()
    local qfcu_c_barostd = dr_qfcu_c_barostd:Get()
    if dr_qfcu_c_efis:Changed() or dr_qfcu_c_fd:Changed() or dr_qfcu_c_ils:Changed() or dr_qfcu_c_barostd:Changed() then
        dr_qfcu_c_efis:Update()
        dr_qfcu_c_fd:Update()
        dr_qfcu_c_ils:Update()
        ---------------------------------------Efis leds capt-------
        uluaSet(idr_qfcu_hid_ledslcstr, sel(qfcu_c_efis == 1)) -- cstr)
        uluaSet(idr_qfcu_hid_ledslwpt, sel(qfcu_c_efis == 2)) -- wpt)
        uluaSet(idr_qfcu_hid_ledslvord, sel(qfcu_c_efis == 3)) -- vord)
        uluaSet(idr_qfcu_hid_ledslndb, sel(qfcu_c_efis == 4)) -- ndb)
        uluaSet(idr_qfcu_hid_ledslaprt, sel(qfcu_c_efis == 5)) -- aprt)

        uluaSet(idr_qfcu_hid_ledslfd, ilua_bool_ternary(qfcu_c_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledslls, ilua_bool_ternary(qfcu_c_ils, 0)) -- ls)

        if qfcu_c_barostd ~= 0 then
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 1) -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
        end

        -- FO
        ------------------------not real FO data,same as capt-------
        uluaSet(idr_qfcu_hid_ledsrcstr, sel(qfcu_c_efis == 1)) -- cstr)
        uluaSet(idr_qfcu_hid_ledsrwpt, sel(qfcu_c_efis == 2))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledsrvord, sel(qfcu_c_efis == 3)) -- vord)
        uluaSet(idr_qfcu_hid_ledsrndb, sel(qfcu_c_efis == 4)) -- ndb)
        uluaSet(idr_qfcu_hid_ledsraprt, sel(qfcu_c_efis == 5)) -- aprt)
        uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_c_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledsrls, ilua_bool_ternary(qfcu_c_ils, 0)) -- ls)

        if qfcu_c_barostd ~= 0 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 1) -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
        end
    end
end

-- local
--
--
--
--
--
--
-- function digi_disp_set_LEDS_r_efis()
-- if
--     dr_qfcu_f_cstr:Changed() or dr_qfcu_f_wpt:Changed() or dr_qfcu_f_vord:Changed() or
--         dr_qfcu_f_ndb:Changed() or
--         dr_qfcu_f_arpt:Changed() or
--         dr_qfcu_f_fd:Changed() or
--         dr_qfcu_f_ils:Changed()
--  then
--     dr_qfcu_f_cstr:Update()
--     dr_qfcu_f_wpt:Update()
--     dr_qfcu_f_vord:Update()
--     dr_qfcu_f_ndb:Update()
--     dr_qfcu_f_arpt:Update()
--     dr_qfcu_f_fd:Update()
--     dr_qfcu_f_ils:Update()
--     ---------------------------------------Efis leds FO---------
--     uluaSet(idr_qfcu_hid_ledsrcstr, ilua_bool_ternary(qfcu_f_cstr, 0)) --cstr)
--     uluaSet(idr_qfcu_hid_ledsrwpt, ilua_bool_ternary(qfcu_f_wpt, 0))
--     --wpt)
--     uluaSet(idr_qfcu_hid_ledsrvord, ilua_bool_ternary(qfcu_f_vord, 0)) --vord)
--     uluaSet(idr_qfcu_hid_ledsrndb, ilua_bool_ternary(qfcu_f_ndb, 0)) --ndb)
--     uluaSet(idr_qfcu_hid_ledsraprt, ilua_bool_ternary(qfcu_f_arpt, 0)) --aprt)
--     uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_f_fd, 0)) --fd)
--     uluaSet(idr_qfcu_hid_ledsrls, ilua_bool_ternary(qfcu_f_ils, 0)) --ls)
--     --uluaSet(idr_qfcu_hid_ledsrqfe, ilua_bool_ternary(qfcu_f_mode, 1)) --qfe)
--     uluaSet(idr_qfcu_hid_ledsrqhn, 1) --qhn)
-- end
-- end

function digi_disp_set_LEDS()
    digi_disp_set_LEDS_fcu()
    digi_disp_set_LEDS_l_efis()
    -- digi_disp_set_LEDS_r_efis()  --not real EFIS FO data yet
end

function digi_disp_set_SPD()
    local qfcu_airspeed = dr_qfcu_airspeed:Get()
    local qfcu_spddashed = dr_qfcu_spddashed:Get()
    local qfcu_is_mach = dr_qfcu_is_mach:Get()

    if dr_qfcu_airspeed:Changed() or dr_qfcu_spddashed:Changed() or dr_qfcu_is_mach:Changed() then
        dr_qfcu_airspeed:Update()
        dr_qfcu_spddashed:Update()
        dr_qfcu_is_mach:Update()

        if qfcu_spddashed == 1 then
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
                uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading + 0.5))
            end
            uluaSet(idr_qfcu_hid_hdgmode, 1)
        end
    end
end

function digi_disp_set_ALT()
    local qfcu_alt100 = dr_qfcu_alt100:Get()
    local qfcu_altmanaged = dr_qfcu_altmanaged:Get()

    if dr_qfcu_alt100:Changed() or dr_qfcu_altmanaged:Changed() then
        dr_qfcu_alt100:Update()
        dr_qfcu_altmanaged:Update()
        -- real code
        uluaSet(idr_qfcu_hid_altval_i, qfcu_alt100 * 100)
        if qfcu_altmanaged == 1 then
            uluaSet(idr_qfcu_hid_altmode, 2)
        elseif qfcu_altmanaged == 0 then
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
        if qfcu_vsdashed == 1 then
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
        if qfcu_c_barostd == 0 then -- std
            uluaSet(idr_qfcu_hid_lefismode, 3)
        else
            if qfcu_c_barounit == 1 then -- hpa mode
                -- c_baro = math.floor(qfcu_c_baro * 33.863 + 0.5)
                uluaSet(idr_qfcu_hid_lefisval_i, qfcu_c_baro_hpa)
                uluaSet(idr_qfcu_hid_refisval_i, qfcu_c_baro_hpa)
                uluaSet(idr_qfcu_hid_lefismode, 2)
                uluaSet(idr_qfcu_hid_refismode, 2)
            else
                c_baro = math.floor(qfcu_c_baro * 100 + 0.5)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_refisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 1)
                uluaSet(idr_qfcu_hid_refismode, 1)
            end
        end
    end
end
---------------------EFIS FO  not real data yet -------------
-- local
function digi_disp_set_R_EFIS()
    -- if
    --     dr_qfcu_f_baro:Changed() or dr_qfcu_f_barounit:Changed() or
    --         dr_qfcu_f_barostd:Changed()
    --  then
    --     dr_qfcu_f_baro:Update()
    --     dr_qfcu_f_barounit:Update()
    --     dr_qfcu_f_barostd:Update()
    --     -- real code
    --     if qfcu_f_barostd == 1 then --std
    --         uluaSet(idr_qfcu_hid_refismode, 3)
    --     else
    --         if qfcu_f_barounit == 1 then --hpa mode
    --             f_baro = math.floor(qfcu_f_baro * 33.863 + 0.5)
    --             uluaSet(idr_qfcu_hid_refisval_i, f_baro)
    --             uluaSet(idr_qfcu_hid_refismode, 2)
    --         else
    --             f_baro = math.floor(qfcu_f_baro * 100 + 0.5)
    --             uluaSet(idr_qfcu_hid_refisval_i, f_baro)
    --             uluaSet(idr_qfcu_hid_refismode, 1)
    --         end
    --     end
    -- end
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

    if dr_qfcu_fcu_light:Changed() or dr_qfcu_fcu_lightDisp:Changed() then
        dr_qfcu_fcu_light:Update()
        dr_qfcu_fcu_lightDisp:Update()
        -- real code
        -------------------------------------------------------------
        uluaSet(idr_qfcu_hid_brightval_i, math.floor(qfcu_fcu_light * MaxBrightness))
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
local digi_disp_fcu_func_table = {digi_disp_set_SPD, digi_disp_set_HDG, digi_disp_set_ALT, digi_disp_set_VS,
                                  digi_disp_set_L_EFIS, digi_disp_set_R_EFIS}

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

local is_load = 0
local start_time = os.clock()
function JD330_boot()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    if is_load == 0 then
        if os.clock() > (start_time + 10) or qfcu_fcu_power > 0 then
            is_load = 1
            uluaAddDoLoop("JD330_digi_disp_every_frame()")
        end
    end
end

function JD330_digi_disp_every_frame()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    local qfcu_alt_unit = dr_qfcu_alt_unit:Get()
    local qfcu_alt100 = dr_qfcu_alt100:Get()
    local qfcu_alt1000 = dr_qfcu_alt1000:Get()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:Get()
    local qfcu_vs_fpa = dr_qfcu_vs_fpa:Get()
    local qfcu_heading_trk = dr_qfcu_heading_trk:Get()
    local qfcu_val_condbtn_4 = idr_qfcu_hid_condbtn_4:Get()
    local qfcu_val_condbtn_16 = idr_qfcu_hid_condbtn_16:Get()
    local qfcu_val_condbtn_20 = idr_qfcu_hid_condbtn_20:Get()
    local qfcu_val_condbtn_21 = idr_qfcu_hid_condbtn_21:Get()
    local qfcu_val_condbtn_46 = idr_qfcu_hid_condbtn_46:Get()

    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()

    local qfcu_c_baro = dr_qfcu_c_baro:Get()
    local qfcu_c_baro_hpa = dr_qfcu_c_baro_hpa:Get()
    local qfcu_c_barounit = dr_qfcu_c_barounit:Get()

    if is_load == 0 then
        return
    end

    if dr_qfcu_fcu_power:Changed() then
        if qfcu_fcu_power > 0 then
            uluaSet(idr_qfcu_hid_indbrightval_i, qfcu_fcu_test + 1)
            uluaSet(idr_qfcu_hid_invalid, -1)
        end
        dr_qfcu_fcu_power:Update()
    end

    -- process hdg knob
    if idr_qfcu_hid_condbtn_4:Changed() then
        local smallstep = idr_qfcu_hid_condbtn_4:Delta()
        -- uluaLog(string.format("small=%d  %d", smallstep, qfcu_val_condbtn_4))
        idr_qfcu_hid_condbtn_4:Update()

        if qfcu_hdgtrkmode == 1 then
            uluaSet(dr_qfcu_heading_trk, qfcu_heading_trk - smallstep)
        else
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    uluaCmdOnce(qfcu_cmd_hdg_dec)
                end
            else
                for i = 1, smallstep, 1 do
                    uluaCmdOnce(qfcu_cmd_hdg_inc)
                end
            end
        end
    end

    -- process alt knob
    if idr_qfcu_hid_condbtn_16:Changed() then
        local smallstep = idr_qfcu_hid_condbtn_16:Delta()
        -- uluaLog(string.format("small=%d  %d", smallstep, qfcu_val_condbtn_16))
        idr_qfcu_hid_condbtn_16:Update()

        if qfcu_alt_unit == 1 then
            dr_qfcu_alt1000:Set(qfcu_alt1000 + smallstep)
        else
            dr_qfcu_alt100:Set(qfcu_alt100 + smallstep)
        end
    end
    if qfcu_alt1000 < 0 then
        dr_qfcu_alt1000:Set(0)
    end
    if qfcu_alt100 < 0 then
        dr_qfcu_alt100:Set(0)
    end

    -- process Baro knob
    if idr_qfcu_hid_condbtn_46:Changed() then
        local smallstep = idr_qfcu_hid_condbtn_46:Delta()
        -- uluaLog(string.format("small=%d  %d", smallstep, qfcu_val_condbtn_46))
        idr_qfcu_hid_condbtn_46:Update()

        if qfcu_c_barounit == 0 then
            local inhg = qfcu_c_baro + smallstep * 0.01
            dr_qfcu_c_baro:Set(math.floor(inhg * 100 + 0.5) / 100)
            -- update HPA as well
            dr_qfcu_c_baro_hpa:Set(math.floor(inhg * 33.8638895 + 0.5))
        else
            local hpa = qfcu_c_baro_hpa + smallstep
            dr_qfcu_c_baro_hpa:Set(hpa)
            -- update inhg as well
            dr_qfcu_c_baro:Set(math.floor((hpa * 0.02952998057228486) * 100 + 0.5) / 100)
        end
    end

    -- process vs knob
    if qfcu_val_condbtn_20 == 1 then
        if (qfcu_hdgtrkmode == 1) then -- fpa/trk mode
            if qfcu_vs_fpa > 99 then
                qfcu_vs_fpa = qfcu_vs_fpa % 100
            end
            uluaSet(dr_qfcu_vs_fpa, qfcu_vs_fpa - 1)
        else
            uluaCmdOnce(qfcu_cmd_vs_dec)
        end
    end
    if qfcu_val_condbtn_21 == 1 then
        if (qfcu_hdgtrkmode == 1) then -- fpa/trk mode
            if qfcu_vs_fpa > 99 then
                qfcu_vs_fpa = qfcu_vs_fpa % 100
            end
            uluaSet(dr_qfcu_vs_fpa, qfcu_vs_fpa + 1)
        else
            uluaCmdOnce(qfcu_cmd_vs_inc)
        end
    end
    -------------------
    if qfcu_fcu_power > 0 then
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
