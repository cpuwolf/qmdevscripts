-- **********************************************************************************************************--
-- QMCP737C Driver for  ZIBO737
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-10-29  last modified:2020-12-24  test with ZIBO 3_42-3_44 ,Xplane 11.50
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2019-06-12
-- modified by Wei Shuai <cpuwolf@gmail.com> 2022-03-27 for init.lua
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
-- 2021-12-30 ZIBO 3.51.7
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBightness = 30 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.
--
-- ########################################################
if ilua_is_acftitle_excluded("B73") or not ilua_is_acfpath_excluded("Laminar") then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for zibo 738")

-- Configuration for ZIBO 737 using Qmcp737c class
qmcp737c:CfgEncFull(0, 1, "laminar/B738/autopilot/course_pilot", 1, 5, 0, 0, 360)
qmcp737c:CfgEncFull(12, 13, "laminar/B738/autopilot/mcp_hdg_dial", 1, 5, 2, 0, 360)
qmcp737c:CfgEncFull(16, 17, "laminar/B738/autopilot/mcp_alt_dial", 100, 500, 1, 0, 41000)
qmcp737c:CfgEncFull(26, 27, "laminar/B738/autopilot/course_copilot", 1, 5, 0, 0, 360)

qmcp737c:BindVhf()
-- uluaQmdevConfig(2, 'ROTATE;"i";56;57;10;1;0;-39500;39500;"cpuwolf/qmdev/QMCP737C/condbtn[56]"')
-- uluaQmdevConfig(2, 'ROTATE;"i";58;59;1;1;0;-39500;39500;"cpuwolf/qmdev/QMCP737C/condbtn[58]"')
qmcp737c:CfgCmd(0, "sim/none/none")
qmcp737c:CfgCmd(1, "sim/none/none")
qmcp737c:CfgVal(2, "laminar/B738/switches/autopilot/fd_ca", 1, 0)
qmcp737c:CfgVal(3, "laminar/B738/switches/autopilot/at_arm", 1, 0)
qmcp737c:CfgCmd(4, "sim/autopilot/airspeed_down")
qmcp737c:CfgCmd(5, "sim/autopilot/airspeed_up")
qmcp737c:CfgCmd(6, "laminar/B738/autopilot/change_over_press")
qmcp737c:CfgCmd(7, "laminar/B738/autopilot/n1_press")
qmcp737c:CfgCmd(8, "laminar/B738/autopilot/speed_press")
qmcp737c:CfgCmd(9, "laminar/B738/autopilot/lvl_chg_press")
qmcp737c:CfgCmd(10, "laminar/B738/autopilot/spd_interv")
qmcp737c:CfgCmd(11, "laminar/B738/autopilot/vnav_press")
qmcp737c:CfgCmd(12, "sim/none/none")
qmcp737c:CfgCmd(13, "sim/none/none")
qmcp737c:CfgCmd(14, "sim/none/none")
qmcp737c:CfgCmd(15, "laminar/B738/autopilot/hdg_sel_press")
qmcp737c:CfgCmd(16, "sim/none/none")
qmcp737c:CfgCmd(17, "sim/none/none")
qmcp737c:CfgCmd(18, "sim/none/none")
qmcp737c:CfgCmd(19, "laminar/B738/autopilot/lnav_press")
qmcp737c:CfgCmd(20, "laminar/B738/autopilot/vorloc_press")
qmcp737c:CfgCmd(21, "laminar/B738/autopilot/app_press")
qmcp737c:CfgCmd(22, "laminar/B738/autopilot/alt_hld_press")
qmcp737c:CfgCmd(23, "laminar/B738/autopilot/vs_press")
qmcp737c:CfgCmd(24, "sim/autopilot/vertical_speed_down")
qmcp737c:CfgCmd(25, "sim/autopilot/vertical_speed_up")
qmcp737c:CfgCmd(26, "sim/none/none")
qmcp737c:CfgCmd(27, "sim/none/none")
qmcp737c:CfgCmd(28, "laminar/B738/autopilot/flight_director_fo_toggle")
qmcp737c:CfgCmd(29, "laminar/B738/autopilot/alt_interv")
qmcp737c:CfgCmd(30, "laminar/B738/autopilot/cmd_a_press")
qmcp737c:CfgCmd(31, "laminar/B738/autopilot/cmd_b_press")
-- uluaQmdevConfig(2, 'ASSIGN;32;"laminar/B738/pfd/dh_pilot_dn"')
-- uluaQmdevConfig(2, 'ASSIGN;33;"laminar/B738/pfd/dh_pilot_up"')
qmcp737c:CfgEncFull(32, 33, "laminar/B738/pfd/dh_pilot", 1, 10, 1, 0, 41000)

qmcp737c:CfgCmd(34, "laminar/B738/EFIS_control/capt/vor1_off_up", "laminar/B738/EFIS_control/capt/vor1_off_dn")
qmcp737c:CfgCmd(35, "laminar/B738/EFIS_control/capt/vor1_off_dn", "laminar/B738/EFIS_control/capt/vor1_off_up")

-- short press
local cmd_hsi_reset = uluaFind("laminar/B738/EFIS_control/capt/push_button/rst_press")
-- long press
local cmd_hsi_min_dec = uluaFind("laminar/B738/EFIS_control/cpt/minimums_dn")
local cmd_hsi_min_inc = uluaFind("laminar/B738/EFIS_control/cpt/minimums_up")
local drf_hsi_min_pos = iDataRef:New("laminar/B738/EFIS_control/cpt/minimums")

function key_36_init_func()
    drf_hsi_min_pos:Get()
end
function key_36_long_func()
    if drf_hsi_min_pos:Get() == 0 then
        uluaCmdOnce(cmd_hsi_min_dec)
    else
        uluaCmdOnce(cmd_hsi_min_inc)
    end
end

function key_36_short_func()
    uluaCmdOnce(cmd_hsi_reset)
end

qmcp737c:CfgLongFc(36, 1000, key_36_long_func, key_36_short_func, key_36_init_func)

qmcp737c:CfgCmd(37, "laminar/B738/EFIS_control/capt/push_button/fpv_press")
qmcp737c:CfgCmd(38, "laminar/B738/EFIS_control/capt/push_button/wxr_press")
qmcp737c:CfgCmd(39, "laminar/B738/EFIS_control/capt/push_button/sta_press")
qmcp737c:CfgCmd(40, "laminar/B738/EFIS_control/capt/push_button/ctr_press")
qmcp737c:CfgCmd(41, "laminar/B738/EFIS_control/capt/map_mode_up")
qmcp737c:CfgCmd(42, "laminar/B738/EFIS_control/capt/map_mode_dn")
qmcp737c:CfgCmd(43, "laminar/B738/EFIS_control/capt/push_button/mtrs_press")
qmcp737c:CfgCmd(44, "laminar/B738/EFIS_control/capt/push_button/wpt_press")
qmcp737c:CfgCmd(45, "laminar/B738/EFIS_control/capt/push_button/arpt_press")
qmcp737c:CfgCmd(46, "laminar/B738/EFIS_control/capt/push_button/data_press")
qmcp737c:CfgCmd(47, "laminar/B738/EFIS_control/capt/push_button/pos_press")
qmcp737c:CfgCmd(48, "laminar/B738/pilot/barometer_down")
qmcp737c:CfgCmd(49, "laminar/B738/pilot/barometer_up")

-- short press
local cmd_hsi_baro_reset = uluaFind("laminar/B738/EFIS_control/capt/push_button/std_press")
-- long press
local cmd_hsi_baro_mode_dec = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_dn")
local cmd_hsi_baro_mode_inc = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_up")
local drf_hsi_baro_mode_pos = iDataRef:New("laminar/B738/EFIS_control/capt/baro_in_hpa")

function key_50_init_func()
    drf_hsi_baro_mode_pos:Get()
end

function key_50_long_func()
    if drf_hsi_baro_mode_pos:Get() > 0 then
        uluaCmdOnce(cmd_hsi_baro_mode_dec)
    else
        uluaCmdOnce(cmd_hsi_baro_mode_inc)
    end
end

function key_50_short_func()
    uluaCmdOnce(cmd_hsi_baro_reset)
end

qmcp737c:CfgLongFc(50, 1000, key_50_long_func, key_50_short_func, key_50_init_func)

qmcp737c:CfgCmd(51, "laminar/B738/EFIS_control/capt/map_range_dn")
qmcp737c:CfgCmd(52, "laminar/B738/EFIS_control/capt/map_range_up")
qmcp737c:CfgCmd(53, "laminar/B738/EFIS_control/capt/push_button/tfc_press")
qmcp737c:CfgCmd(54, "laminar/B738/EFIS_control/capt/vor2_off_dn", "laminar/B738/EFIS_control/capt/vor2_off_up")
qmcp737c:CfgCmd(55, "laminar/B738/EFIS_control/capt/vor2_off_up", "laminar/B738/EFIS_control/capt/vor2_off_dn")

qmcp737c:CfgCmd(64, "sim/radios/stby_nav1_fine_down")
qmcp737c:CfgCmd(65, "sim/radios/stby_nav1_fine_up")
qmcp737c:CfgCmd(66, "sim/radios/stby_nav1_coarse_down")
qmcp737c:CfgCmd(67, "sim/radios/stby_nav1_coarse_up")
qmcp737c:CfgValT(68, "cpuwolf/qmdev/QMCP737C/condbtn[68]")
qmcp737c:CfgCmd(69, "laminar/B738/push_button/switch_freq_nav1_press")
qmcp737c:CfgCmd(70, "laminar/B738/EFIS_control/capt/push_button/terr_press")

local pswh71 = QmdevPosSwitchInit("laminar/B738/autopilot/disconnect_pos", 1, "laminar/B738/autopilot/disconnect_toggle",
    "laminar/B738/autopilot/disconnect_toggle", 500)
qmcp737c:CfgPSw(71, pswh71, 1, 0)

qmcp737c:CfgCmd(72, "laminar/B738/toggle_switch/taxi_light_brightness_on",
    "laminar/B738/toggle_switch/taxi_light_brightness_off")
qmcp737c:CfgVal(73, "laminar/B738/toggle_switch/rwy_light_right", 1, 0)
qmcp737c:CfgVal(74, "laminar/B738/toggle_switch/rwy_light_left", 1, 0)
qmcp737c:CfgVal(75, "laminar/B738/toggle_switch/wheel_light", 1, 0)
qmcp737c:CfgVal(76, "laminar/B738/toggle_switch/wing_light", 1, 0)
qmcp737c:CfgVal(77, "sim/cockpit/electrical/beacon_lights_on", 1, 0)
qmcp737c:CfgCmd(78, "laminar/B738/toggle_switch/position_light_steady", "laminar/B738/toggle_switch/position_light_off")
qmcp737c:CfgCmd(79, "laminar/B738/toggle_switch/position_light_strobe", "laminar/B738/toggle_switch/position_light_off")
qmcp737c:CfgVal(80, "laminar/B738/switch/land_lights_right_pos", 1, 0)
qmcp737c:CfgCmd(80, "laminar/B738/switch/land_lights_ret_right_on", "laminar/B738/switch/land_lights_ret_right_off")
qmcp737c:CfgVal(81, "laminar/B738/switch/land_lights_left_pos", 1, 0)
qmcp737c:CfgCmd(81, "laminar/B738/switch/land_lights_ret_left_on", "laminar/B738/switch/land_lights_ret_left_off")

qmcp737c:CfgVal(82, "laminar/B738/toggle_switch/logo_light", 1, 0)
qmcp737c:CfgVal(83, "laminar/B738/controls/gear_handle_down", 1, 0.5)
qmcp737c:CfgVal(84, "laminar/B738/controls/gear_handle_down", 0, 0.5)
qmcp737c:CfgCmd(85, "laminar/B738/knob/autobrake_rto")
qmcp737c:CfgCmd(86, "laminar/B738/knob/autobrake_off")
qmcp737c:CfgCmd(87, "laminar/B738/knob/autobrake_1")
qmcp737c:CfgCmd(88, "laminar/B738/knob/autobrake_2")
qmcp737c:CfgCmd(89, "laminar/B738/knob/autobrake_3")
qmcp737c:CfgCmd(90, "laminar/B738/knob/autobrake_max")
qmcp737c:CfgVal(91, "laminar/B738/flt_ctrls/flap_lever", 0, nil)
qmcp737c:CfgVal(92, "laminar/B738/flt_ctrls/flap_lever", 0.125, nil)
qmcp737c:CfgVal(93, "laminar/B738/flt_ctrls/flap_lever", 0.25, nil)
qmcp737c:CfgVal(94, "laminar/B738/flt_ctrls/flap_lever", 0.375, nil)
qmcp737c:CfgVal(95, "laminar/B738/flt_ctrls/flap_lever", 0.5, nil)
qmcp737c:CfgVal(96, "laminar/B738/flt_ctrls/flap_lever", 0.625, nil)
qmcp737c:CfgVal(97, "laminar/B738/flt_ctrls/flap_lever", 0.75, nil)
qmcp737c:CfgVal(98, "laminar/B738/flt_ctrls/flap_lever", 0.875, nil)
qmcp737c:CfgVal(99, "laminar/B738/flt_ctrls/flap_lever", 1, nil)
qmcp737c:CfgVal(100, "laminar/B738/flt_ctrls/speedbrake_lever", 0, nil)
qmcp737c:CfgVal(101, "laminar/B738/flt_ctrls/speedbrake_lever", 0.0889, nil)
qmcp737c:CfgVal(102, "laminar/B738/flt_ctrls/speedbrake_lever", 0.667, nil)
qmcp737c:CfgVal(103, "laminar/B738/flt_ctrls/speedbrake_lever", 1, nil)

-- switches

----------------------------  Display Dataref Set	 ------------------------------------
-- Display for Zibo 737
-- MCP Panel Digital Display
local dr_qmcp737c_bright_test = iDataRef:New("laminar/B738/dspl_light_test")
local qmcp737c_com1_power = uluaFind("sim/cockpit2/radios/actuators/com1_power")
local qmcp737c_nav1_power = uluaFind("laminar/B738/comm/nav1_status")
local qmcp737c_battery_on = uluaFind("sim/cockpit/electrical/avionics_on")
local qmcp737c_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")
-- CRS1
qmcp737c:GetCrs1('laminar/B738/autopilot/course_pilot')
-- IAS/MACH
qmcp737c:GetIas("laminar/B738/autopilot/mcp_speed_dial_kts_mach", "sim/cockpit/autopilot/airspeed_is_mach",
    'laminar/B738/autopilot/mcp_speed_dial_kts_mach', "laminar/B738/mcp/digit_8", "laminar/B738/mcp/digit_A",
    "laminar/B738/autopilot/show_ias")
-- HEADING
qmcp737c:GetHdg("laminar/B738/autopilot/mcp_hdg_dial")
-- ALITITUDE
qmcp737c:GetAlt("laminar/B738/autopilot/mcp_alt_dial", 0.5)
-- VERT SPEED
qmcp737c:GetVs("laminar/B738/autopilot/ap_vvi_pos", "laminar/B738/autopilot/vvi_dial_show")
-- CRS2
qmcp737c:GetCrs2("laminar/B738/autopilot/course_copilot")

-- VHF Panel Digital Display
qmcp737c:GetVhf("sim/cockpit2/radios/actuators/com1_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com2_frequency_hz_833", "sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")
-- NAV Panel Digital Display
qmcp737c:GetNav("sim/cockpit/radios/nav1_freq_hz", "sim/cockpit/radios/nav1_stdby_freq_hz",
    "sim/cockpit/radios/nav2_freq_hz", "sim/cockpit/radios/nav2_stdby_freq_hz")

-- LED Indicator light
qmcp737c:GetLed("laminar/B738/comm/rtp_L/vhf_1_status", "laminar/B738/comm/rtp_L/vhf_2_status",

    "laminar/B738/autopilot/master_capt_status", "laminar/B738/autopilot/autothrottle_arm_pos",

    "laminar/B738/autopilot/n1_status", "laminar/B738/autopilot/speed_status1", "laminar/B738/autopilot/lvl_chg_status",

    "laminar/B738/autopilot/vnav_status1", "laminar/B738/autopilot/hdg_sel_status",

    "laminar/B738/autopilot/lnav_status", "laminar/B738/autopilot/vorloc_status", "laminar/B738/autopilot/app_status",

    "laminar/B738/autopilot/alt_hld_status", "laminar/B738/autopilot/vs_status", "laminar/B738/autopilot/cmd_a_status",
    "laminar/B738/autopilot/cmd_b_status", "laminar/B738/annunciator/left_gear_safe",
    "laminar/B738/annunciator/nose_gear_safe", "laminar/B738/annunciator/right_gear_safe")

zibo_ap_disc_pos = uluaFind("laminar/B738/autopilot/disconnect_pos")
-- ap_state = uluaFind('sim/cockpit/autopilot/autopilot_state')

local brightness = uluaFind("laminar/B738/electric/panel_brightness")

----------------------------  Display Dataref Set End ------------------------------------

local zibo738_d_baro_hap = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa")
local zibo738_d_land_lpos = iDataRef:New("laminar/B738/switch/land_lights_left_pos")
local zibo738_d_land_rpos = iDataRef:New("laminar/B738/switch/land_lights_right_pos")

local zibo738_cmd_baro_hpa_u = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_up")
local zibo738_cmd_baro_hpa_d = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_dn")
local zibo738_cmd_land_l_off = uluaFind("laminar/B738/switch/land_lights_ret_left_off")
local zibo738_cmd_land_l_on = uluaFind("laminar/B738/switch/land_lights_ret_left_on")
local zibo738_cmd_land_r_off = uluaFind("laminar/B738/switch/land_lights_ret_right_off")
local zibo738_cmd_land_r_on = uluaFind("laminar/B738/switch/land_lights_ret_right_on")
local zibo738_cmd_disap = uluaFind("laminar/B738/autopilot/disconnect_toggle")

local cmd_vhf1_mode = uluaFind("laminar/B738/rtp_L/freq_txfr/sel_switch")
local cmd_vhf2_mode = uluaFind("laminar/B738/rtp_R/freq_txfr/sel_switch")

local cmd_vhf1_d_small = uluaFind("laminar/B738/rtp_L/freq_khz/sel_dial_dn")
local cmd_vhf1_u_small = uluaFind("laminar/B738/rtp_L/freq_khz/sel_dial_up")
local cmd_vhf1_d_big = uluaFind("laminar/B738/rtp_L/freq_MHz/sel_dial_dn")
local cmd_vhf1_u_big = uluaFind("laminar/B738/rtp_L/freq_MHz/sel_dial_up")

local cmd_vhf2_d_small = uluaFind("laminar/B738/rtp_R/freq_khz/sel_dial_dn")
local cmd_vhf2_u_small = uluaFind("laminar/B738/rtp_R/freq_khz/sel_dial_up")
local cmd_vhf2_d_big = uluaFind("laminar/B738/rtp_R/freq_MHz/sel_dial_dn")
local cmd_vhf2_u_big = uluaFind("laminar/B738/rtp_R/freq_MHz/sel_dial_up")

local function fcb_vhf1_d_small()
    uluaCmdOnce(cmd_vhf1_d_small)
end
local function fcb_vhf1_u_small()
    uluaCmdOnce(cmd_vhf1_u_small)
end
local function fcb_vhf2_d_small()
    uluaCmdOnce(cmd_vhf2_d_small)
end
local function fcb_vhf2_u_small()
    uluaCmdOnce(cmd_vhf2_u_small)
end
local function fcb_vhf1_d_big()
    uluaCmdOnce(cmd_vhf1_d_big)
end
local function fcb_vhf1_u_big()
    uluaCmdOnce(cmd_vhf1_u_big)
end
local function fcb_vhf2_d_big()
    uluaCmdOnce(cmd_vhf2_d_big)
end
local function fcb_vhf2_u_big()
    uluaCmdOnce(cmd_vhf2_u_big)
end
local function fcb_vhf1_mode()
    uluaCmdOnce(cmd_vhf1_mode)
end
local function fcb_vhf2_mode()
    uluaCmdOnce(cmd_vhf2_mode)
end

qmcp737c:RegLoopVhf(fcb_vhf1_d_small, fcb_vhf1_u_small, fcb_vhf1_d_big, fcb_vhf1_u_big, fcb_vhf2_d_small,
    fcb_vhf2_u_small, fcb_vhf2_d_big, fcb_vhf2_u_big, fcb_vhf1_mode, fcb_vhf2_mode)
--[=====[ 
--fix the ap_disconnect switch
function qmcp737c_zibo738_cmd_disconnect(ispress)
    local zibo_ap_disc_pos_val = uluaGet(zibo_ap_disc_pos)
    uluaLog(string.format("qmcp737c_zibo738_cmd_disconnect: %i %i", ispress, zibo_ap_disc_pos_val))
    if (ispress ~= zibo_ap_disc_pos_val) then
        uluaCmdOnce(zibo738_cmd_disap)
    end
end
uluaQmdevRegisterKey(2, 71, "qmcp737c_zibo738_cmd_disconnect(1)", "qmcp737c_zibo738_cmd_disconnect(0)")
--]=====]

-- ZIBO special handing

-- Backlight
local function digi_disp_set_Bright()
    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
    if uluaGet(qmcp737c_avionics_on) == 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, uluaGet(brightness) * MaxBightness)
    end

    if dr_qmcp737c_bright_test:Changed() then
        uluaSet(idr_qmcp737c_hid_brightmod, qmcp737c_bright_test_val) -- 1,2
    end

    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(uluaGet(brightness) * 2))

    if dr_qmcp737c_bright_test:Changed() then
        if qmcp737c_bright_test_val == 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        dr_qmcp737c_bright_test:Update()
    end
end

-----end sub functions
function qmcp737c_zibo_loop()
    qmcp737c:LoopVhf()

    digi_disp_set_Bright()

    if uluaGet(qmcp737c_avionics_on) > 0 then
        qmcp737c:SetLed()
    else
        qmcp737c:OffLed()
    end

    if uluaGet(qmcp737c_battery_on) > 0 then
        qmcp737c:LoopMcp()
    else
        qmcp737c:OffMcp()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_com1_power) > 0 then
        qmcp737c:SetVhfA()
        qmcp737c:SetVhfS()
    else
        qmcp737c:OffVhf()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_nav1_power) > 0 then
        qmcp737c:SetNavA()
        qmcp737c:SetNavS()
    else
        qmcp737c:OffNav()
    end
end
uluaAddDoLoop("qmcp737c_zibo_loop()")
