-- **********************************************************************************************************--
-- QMCP737C Driver for  GA
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-07-21  last modified:2020-12-24
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2019-06-12
-- modified by Wei Shuai <cpuwolf@gmail.com> 2020-03-14 add General Aviation
-- modified by Wei Shuai <cpuwolf@gmail.com> 2020-06-18 add C90B
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBightness = 30 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for GA")

if PLANE_ICAO == "B350" then
    qmcp737c:CfgEncFull(0, 1, "sim/cockpit/radios/nav1_obs_degm", 1, 5, 0, 0, 360)
    qmcp737c:CfgEncFull(12, 13, "sim/cockpit/autopilot/heading", 1, 5, 2, 0, 360)
    qmcp737c:CfgEncFull(26, 27, "sim/cockpit/radios/nav2_obs_degm", 1, 5, 0, 0, 360)
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
    qmcp737c:CfgCmd(16, "KA350/cmd/avpanel/alt/altSetDec")
    qmcp737c:CfgCmd(17, "KA350/cmd/avpanel/alt/altSetInc")
    qmcp737c:CfgCmd(18, "KA350/cmd/avpanel/alt/mode")
    qmcp737c:CfgCmd(19, "laminar/B738/autopilot/lnav_press")
    qmcp737c:CfgCmd(20, "laminar/B738/autopilot/vorloc_press")
    qmcp737c:CfgCmd(21, "laminar/B738/autopilot/app_press")
    qmcp737c:CfgCmd(22, "laminar/B738/autopilot/alt_hld_press")
    qmcp737c:CfgCmd(23, "laminar/B738/autopilot/vs_press")
    qmcp737c:CfgCmd(24, "KA350/cmd/cPanel/autopilotCP/pitchSwitchDec")
    qmcp737c:CfgCmd(25, "KA350/cmd/cPanel/autopilotCP/pitchSwitchInc")
    qmcp737c:CfgCmd(26, "sim/none/none")
    qmcp737c:CfgCmd(27, "sim/none/none")
    qmcp737c:CfgCmd(28, "KA350/cmd/cPanel/pilotDisplayCP/crsPre")
    qmcp737c:CfgCmd(29, "laminar/B738/autopilot/alt_interv")
    qmcp737c:CfgCmd(30, "laminar/B738/autopilot/cmd_a_press")
    qmcp737c:CfgCmd(31, "laminar/B738/autopilot/cmd_b_press")
    qmcp737c:CfgCmd(32, "KA350/cmd/cPanel/pilotDisplayCP/dhSetDec")
    qmcp737c:CfgCmd(33, "KA350/cmd/cPanel/pilotDisplayCP/dhSetInc")
    qmcp737c:CfgCmd(34, "laminar/B738/EFIS_control/capt/vor1_off_up", "laminar/B738/EFIS_control/capt/vor1_off_dn")
    qmcp737c:CfgCmd(35, "laminar/B738/EFIS_control/capt/vor1_off_dn", "laminar/B738/EFIS_control/capt/vor1_off_up")
    qmcp737c:CfgCmd(36, "KA350/cmd/cPanel/pilotDisplayCP/rdr")
    qmcp737c:CfgCmd(37, "KA350/cmd/cPanel/efisSCP/navData")
    qmcp737c:CfgCmd(38, "laminar/B738/EFIS_control/capt/push_button/wxr_press")
    qmcp737c:CfgCmd(39, "laminar/B738/EFIS_control/capt/push_button/sta_press")
    qmcp737c:CfgCmd(40, "laminar/B738/EFIS_control/capt/push_button/ctr_press")
    qmcp737c:CfgCmd(41, "KA350/cmd/cPanel/pilotDisplayCP/formatInc")
    qmcp737c:CfgCmd(42, "KA350/cmd/cPanel/pilotDisplayCP/formatDec")
    qmcp737c:CfgCmd(43, "KA350/cmd/cPanel/efisSCP/courseCtrl")
    qmcp737c:CfgCmd(44, "laminar/B738/EFIS_control/capt/push_button/wpt_press")
    qmcp737c:CfgCmd(45, "laminar/B738/EFIS_control/capt/push_button/arpt_press")
    qmcp737c:CfgCmd(46, "laminar/B738/EFIS_control/capt/push_button/data_press")
    qmcp737c:CfgCmd(47, "laminar/B738/EFIS_control/capt/push_button/pos_press")
    qmcp737c:CfgCmd(48, "KA350/cmd/gauges/p/alt/baroDec")
    qmcp737c:CfgCmd(49, "KA350/cmd/gauges/p/alt/baroInc")
    qmcp737c:CfgCmd(50, "laminar/B738/EFIS_control/capt/push_button/std_press")
    qmcp737c:CfgCmd(51, "KA350/cmd/cPanel/pilotDisplayCP/selRngDec")
    qmcp737c:CfgCmd(52, "KA350/cmd/cPanel/pilotDisplayCP/selRngInc")
    qmcp737c:CfgCmd(53, "laminar/B738/EFIS_control/capt/push_button/tfc_press")
    qmcp737c:CfgCmd(54, "laminar/B738/EFIS_control/capt/vor2_off_dn", "laminar/B738/EFIS_control/capt/vor2_off_up")
    qmcp737c:CfgCmd(55, "laminar/B738/EFIS_control/capt/vor2_off_up", "laminar/B738/EFIS_control/capt/vor2_off_dn")
    qmcp737c:CfgCmd(56, "KA350/cockpit/g430n1/fineDec")
    qmcp737c:CfgCmd(57, "KA350/cockpit/g430n1/fineInc")
    qmcp737c:CfgCmd(58, "KA350/cockpit/g430n1/coarseDec")
    qmcp737c:CfgCmd(59, "KA350/cockpit/g430n1/coarseInc")
    qmcp737c:CfgCmd(60, "sim/GPS/g430n1_nav_com_tog")
    qmcp737c:CfgCmd(61, "sim/GPS/g430n1_com_ff")
    qmcp737c:CfgCmd(64, "sim/radios/stby_nav1_fine_down")
    qmcp737c:CfgCmd(65, "sim/radios/stby_nav1_fine_up")
    qmcp737c:CfgCmd(66, "sim/radios/stby_nav1_coarse_down")
    qmcp737c:CfgCmd(67, "sim/radios/stby_nav1_coarse_up")
    qmcp737c:CfgVal(68, "cpuwolf/qmdev/QMCP737C/condbtn[68]", 1, 0)
    qmcp737c:CfgCmd(69, "laminar/B738/push_button/switch_freq_nav1_press")
    qmcp737c:CfgCmd(70, "KA350/cmd/cPanel/pilotDisplayCP/crsAct")
    qmcp737c:CfgVal(71, "cpuwolf/qmdev/QMCP737C/condbtn[71]", 1, 0)
    qmcp737c:CfgVal(72, "KA350/ianim/pSubpanel/taxiLights", 1, 0)
    qmcp737c:CfgVal(73, "laminar/B738/toggle_switch/rwy_light_right", 1, 0)
    qmcp737c:CfgVal(74, "laminar/B738/toggle_switch/rwy_light_left", 1, 0)
    qmcp737c:CfgVal(75, "sim/cockpit2/switches/generic_lights_switch[5]", 1, 0)
    qmcp737c:CfgVal(76, "sim/cockpit2/switches/generic_lights_switch[0]", 1, 0)
    qmcp737c:CfgVal(77, "KA350/ianim/pSubpanel/beaconLights", 1, 0)
    qmcp737c:CfgCmd(78, "laminar/B738/toggle_switch/position_light_steady", "laminar/B738/toggle_switch/position_light_off")
    qmcp737c:CfgCmd(79, "laminar/B738/toggle_switch/position_light_strobe", "laminar/B738/toggle_switch/position_light_off")
    qmcp737c:CfgVal(80, "KA350/ianim/pSubpanel/landingLightsRight", 1, 0)
    qmcp737c:CfgVal(81, "KA350/ianim/pSubpanel/landingLightsLeft", 1, 0)
    qmcp737c:CfgVal(82, "KA350/ianim/pSubpanel/tailLights", 1, 0)
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
elseif PLANE_ICAO == "BE9L" then
    qmcp737c:CfgEncFull(0, 1, "sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot", 1, 10, 0, 0, 360)
    qmcp737c:CfgEncFull(12, 13, "sim/cockpit/autopilot/heading_mag", 1, 10, 0, 0, 360)
    qmcp737c:CfgEncFull(26, 27, "laminar/B738/autopilot/course_copilot", 1, 10, 0, 0, 360)
    qmcp737c:CfgCmd(0, "sim/GPS/g1000n1_crs_down")
    qmcp737c:CfgCmd(1, "sim/GPS/g1000n1_crs_up")
    qmcp737c:CfgCmd(2, "laminar/c90/avionics/switch/fd")
    qmcp737c:CfgCmd(3, "sim/autopilot/autothrottle_on")
    qmcp737c:CfgCmd(4, "laminar/c90/avionics/dial/nav_data_sel_dn")
    qmcp737c:CfgCmd(5, "laminar/c90/avionics/dial/nav_data_sel_up")
    qmcp737c:CfgCmd(6, "sim/autopilot/airspeed_sync")
    qmcp737c:CfgCmd(7, "sim/autopilot/autothrottle_n1epr")
    qmcp737c:CfgCmd(8, "sim/autopilot/autothrottle_toggle")
    qmcp737c:CfgCmd(9, "sim/autopilot/level_change")
    qmcp737c:CfgCmd(10, "sim/none/none")
    qmcp737c:CfgCmd(11, "sim/autopilot/vnav")
    qmcp737c:CfgCmd(12, "sim/GPS/g1000n1_hdg_down")
    qmcp737c:CfgCmd(13, "sim/GPS/g1000n1_hdg_up")
    qmcp737c:CfgCmd(14, "sim/autopilot/heading_sync")
    qmcp737c:CfgCmd(15, "sim/autopilot/heading")
    qmcp737c:CfgCmd(16, "sim/autopilot/altitude_down")
    qmcp737c:CfgCmd(17, "sim/autopilot/altitude_up")
    qmcp737c:CfgCmd(18, "sim/autopilot/altitude_sync")
    qmcp737c:CfgCmd(19, "sim/autopilot/hdg_nav")
    qmcp737c:CfgCmd(20, "sim/autopilot/NAV")
    qmcp737c:CfgCmd(21, "sim/autopilot/approach")
    qmcp737c:CfgCmd(22, "sim/autopilot/altitude_arm")
    qmcp737c:CfgCmd(23, "sim/autopilot/vertical_speed")
    qmcp737c:CfgCmd(24, "sim/autopilot/nose_down")
    qmcp737c:CfgCmd(25, "sim/autopilot/nose_up")
    qmcp737c:CfgCmd(26, "sim/GPS/g1000n2_crs_down")
    qmcp737c:CfgCmd(27, "sim/GPS/g1000n2_crs_up")
    qmcp737c:CfgCmd(28, "sim/none/none")
    qmcp737c:CfgCmd(29, "sim/none/none")
    qmcp737c:CfgCmd(30, "sim/autopilot/servos_toggle")
    qmcp737c:CfgCmd(31, "sim/systems/yaw_damper_toggle")
    qmcp737c:CfgCmd(32, "sim/instruments/dh_ref_down")
    qmcp737c:CfgCmd(33, "sim/instruments/dh_ref_up")
    qmcp737c:CfgCmd(34, "sim/none/none")
    qmcp737c:CfgCmd(35, "sim/none/none")
    qmcp737c:CfgCmd(36, "sim/none/none")
    qmcp737c:CfgCmd(37, "laminar/c90/avionics/switch/brg_ptr1_sel")
    qmcp737c:CfgCmd(38, "sim/none/none")
    qmcp737c:CfgCmd(39, "sim/none/none")
    qmcp737c:CfgCmd(40, "laminar/c90/avionics/switch/crs_sel")
    qmcp737c:CfgCmd(41, "laminar/c90/avionics/dial/EFIS_map_mode_sel_up")
    qmcp737c:CfgCmd(42, "laminar/c90/avionics/dial/EFIS_map_mode_sel_dn")
    qmcp737c:CfgCmd(43, "laminar/c90/avionics/switch/brg_ptr2_sel")
    qmcp737c:CfgCmd(44, "sim/none/none")
    qmcp737c:CfgCmd(45, "sim/none/none")
    qmcp737c:CfgCmd(46, "sim/none/none")
    qmcp737c:CfgCmd(47, "sim/none/none")
    qmcp737c:CfgCmd(48, "sim/instruments/barometer_down")
    qmcp737c:CfgCmd(49, "sim/instruments/barometer_up")
    qmcp737c:CfgCmd(50, "sim/instruments/barometer_2992")
    qmcp737c:CfgCmd(51, "sim/instruments/map_zoom_out")
    qmcp737c:CfgCmd(52, "sim/instruments/map_zoom_in")
    qmcp737c:CfgCmd(53, "sim/GPS/g1000n1_range_up")
    qmcp737c:CfgCmd(54, "sim/none/none")
    qmcp737c:CfgCmd(55, "sim/none/none")
    qmcp737c:CfgCmd(56, "sim/radios/stby_com1_fine_down_833")
    qmcp737c:CfgCmd(57, "sim/radios/stby_com1_fine_up_833")
    qmcp737c:CfgCmd(58, "sim/radios/stby_com1_coarse_down_833")
    qmcp737c:CfgCmd(59, "sim/radios/stby_com1_coarse_up_833")
    qmcp737c:CfgCmd(60, "sim/none/none")
    qmcp737c:CfgCmd(61, "sim/radios/com1_standy_flip")
    qmcp737c:CfgCmd(62, "sim/none/none")
    qmcp737c:CfgCmd(63, "sim/none/none")
    qmcp737c:CfgCmd(64, "sim/radios/stby_nav1_fine_down")
    qmcp737c:CfgCmd(65, "sim/radios/stby_nav1_fine_up")
    qmcp737c:CfgCmd(66, "sim/radios/stby_nav1_coarse_down")
    qmcp737c:CfgCmd(67, "sim/radios/stby_nav1_coarse_up")
    qmcp737c:CfgCmd(68, "sim/none/none")
    qmcp737c:CfgCmd(69, "sim/radios/nav1_standy_flip")
    qmcp737c:CfgCmd(70, "laminar/c90/avionics/switch/crs_sync_sel")
    qmcp737c:CfgCmd(71, "sim/autopilot/servos_off_any")
    qmcp737c:CfgCmd(72, "sim/lights/taxi_lights_on")
    qmcp737c:CfgCmd(73, "sim/none/none")
    qmcp737c:CfgCmd(74, "sim/none/none")
    qmcp737c:CfgCmd(75, "sim/none/none")
    qmcp737c:CfgCmd(76, "sim/none/none")
    qmcp737c:CfgCmd(77, "sim/none/none")
    qmcp737c:CfgCmd(78, "sim/flight_controls/flaps_down")
    qmcp737c:CfgCmd(79, "sim/flight_controls/flaps_up")
    qmcp737c:CfgCmd(80, "sim/none/none")
    qmcp737c:CfgCmd(81, "sim/lights/landing_lights_on")
    qmcp737c:CfgCmd(82, "sim/none/none")
    qmcp737c:CfgCmd(83, "sim/flight_controls/landing_gear_down")
    qmcp737c:CfgCmd(84, "sim/flight_controls/landing_gear_up")
else
    qmcp737c:CfgEncFull(0, 1, "sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot", 1, 10, 0, 0, 360)
    qmcp737c:CfgEncFull(4, 5, "laminar/B738/autopilot/mcp_speed_dial_kts_mach", 1, 20, 0, 0, 360)
    qmcp737c:CfgEncFull(12, 13, "sim/cockpit/autopilot/heading_mag", 1, 10, 0, 0, 360)
    qmcp737c:CfgEncFull(16, 17, "sim/cockpit/autopilot/altitude", 1, 500, 0, 0, 360)
    qmcp737c:CfgEncFull(56, 57, "cpuwolf/qmdev/QMCP737C/condbtn[56]", 1, 1, 0, -39500, 39500)
    qmcp737c:CfgEncFull(58, 59, "cpuwolf/qmdev/QMCP737C/condbtn[58]", 1, 1, 0, -39500, 39500)
    qmcp737c:CfgCmd(0, "sim/radios/obs1_down")
    qmcp737c:CfgCmd(1, "sim/radios/obs1_up")
    qmcp737c:CfgCmd(4, "sim/radios/adf1_card_down")
    qmcp737c:CfgCmd(5, "sim/radios/adf1_card_up")
    qmcp737c:CfgCmd(12, "sim/autopilot/heading_down")
    qmcp737c:CfgCmd(13, "sim/autopilot/heading_up")
    qmcp737c:CfgCmd(16, "sim/autopilot/altitude_down")
    qmcp737c:CfgCmd(17, "sim/autopilot/altitude_up")
    qmcp737c:CfgCmd(26, "sim/radios/obs2_down")
    qmcp737c:CfgCmd(27, "sim/radios/obs2_up")
    qmcp737c:CfgCmd(38, "172/xpdr/xpdr_idt")
    qmcp737c:CfgCmd(39, "172/xpdr/xpdr_vfr")
    qmcp737c:CfgCmd(41, "sim/instruments/DG_sync_up")
    qmcp737c:CfgCmd(42, "sim/instruments/DG_sync_down")
    qmcp737c:CfgCmd(48, "sim/instruments/barometer_down")
    qmcp737c:CfgCmd(49, "sim/instruments/barometer_up")
    qmcp737c:CfgCmd(50, "sim/instruments/barometer_2992")
    qmcp737c:CfgCmd(51, "sim/instruments/map_zoom_out")
    qmcp737c:CfgCmd(52, "sim/instruments/map_zoom_in")
    qmcp737c:CfgCmd(53, "172/com_XPDR_mode_Turn_left")
    qmcp737c:CfgCmd(54, "172/com_XPDR_mode_Turn_right")
    qmcp737c:CfgCmd(60, "cpuwolf/qmdev/QMCP737C/condbtn[60]")
    qmcp737c:CfgCmd(61, "cpuwolf/qmdev/QMCP737C/condbtn[61]")
    qmcp737c:CfgCmd(64, "sim/radios/stby_nav1_fine_down")
    qmcp737c:CfgCmd(65, "sim/radios/stby_nav1_fine_up")
    qmcp737c:CfgCmd(66, "sim/radios/stby_nav1_coarse_down")
    qmcp737c:CfgCmd(67, "sim/radios/stby_nav1_coarse_up")
    qmcp737c:CfgCmd(69, "sim/radios/nav1_standy_flip")
    qmcp737c:CfgCmd(72, "sim/lights/taxi_lights_on", "sim/lights/taxi_lights_off")
    qmcp737c:CfgCmd(77, "sim/lights/beacon_lights_on", "sim/lights/beacon_lights_off")
    qmcp737c:CfgCmd(79, "sim/lights/strobe_lights_on", "sim/lights/strobe_lights_off")
    qmcp737c:CfgCmd(81, "sim/lights/landing_01_light_on", "sim/lights/landing_01_light_off")
    qmcp737c:CfgCmd(82, "sim/lights/landing_02_light_on", "sim/lights/landing_01_light_off")
    qmcp737c:CfgCmd(83, "sim/flight_controls/landing_gear_down")
    qmcp737c:CfgCmd(84, "sim/flight_controls/landing_gear_up")
end

function qmcp737c_ga_digi_disp_set_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end
function qmcp737c_ga_digi_disp_set_powoff_mcp()
    uluaSet(idr_qmcp737c_hid_crs1mod, 0)
    uluaSet(idr_qmcp737c_hid_iasmod, 4)
    uluaSet(idr_qmcp737c_hid_hdgmod, 0)
    uluaSet(idr_qmcp737c_hid_altmod, 2)
    uluaSet(idr_qmcp737c_hid_vsmod, 0)
    uluaSet(idr_qmcp737c_hid_vsmod, 2)
    uluaSet(idr_qmcp737c_hid_crs2mod, 0)
end

function qmcp737c_ga_digi_disp_set_powoff_com()
    local i = uluaGet(idr_qmcp737c_hid_vhfa)
    i = i + 1
    if (i > 128) or (i < 0) then
        i = 1
    end
    uluaSet(idr_qmcp737c_hid_vhfa, i)
    uluaSet(idr_qmcp737c_hid_vhfs, i)
end
function qmcp737c_ga_digi_disp_set_powoff_nav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end

-- switches


----------------------------  Display Dataref Set End ------------------------------------
----------------------------  Display Dataref Set End ------------------------------------
--------X-Plane common aircraft
----------------------------  Display Dataref Set	 ------------------------------------
-- MCP Panel Digital Display
local qmcp737c_bright_test = 0
local qmcp737c_com1_power = uluaFind("sim/cockpit2/radios/actuators/com1_power")
local qmcp737c_nav1_power = uluaFind("sim/cockpit2/radios/actuators/nav_power", "readonly", 0)
local qmcp737c_battery_on = uluaFind("sim/cockpit/electrical/battery_on")
local qmcp737c_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")

local d_crs1 = uluaFind("sim/cockpit/radios/nav1_obs_degm")
local d_ias = uluaFind("sim/cockpit2/autopilot/airspeed_dial_kts_mach")
local d_hdg = uluaFind("sim/cockpit/autopilot/heading_mag")
local d_alt = uluaFind("sim/cockpit2/autopilot/altitude_dial_ft")
local d_vs = uluaFind("sim/cockpit2/autopilot/vvi_dial_fpm")
local d_crs2 = uluaFind("sim/cockpit/radios/nav2_obs_degm")
local d_ias_8 = 0
-- d_ias_8=uluaFind( "laminar/B738/mcp/digit_8")
local d_ias_A = 0
-- d_ias_A=uluaFind( "laminar/B738/mcp/digit_A")
local qmcp737c_ias_show = 1
local qmcp737c_vvi_show = 1
-- new add C/O display
local d_is_mach = uluaFind("sim/cockpit/autopilot/airspeed_is_mach")
local d_ias_mach = uluaFind("sim/cockpit2/autopilot/airspeed_dial_kts_mach")

-- COM Panel Digital Display
local d_com = uluaFind("sim/cockpit2/radios/actuators/com1_frequency_hz_833")
local d_coms = uluaFind("sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833")

local d_com2 = uluaFind("sim/cockpit2/radios/actuators/com2_frequency_hz_833")
local d_com2s = uluaFind("sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")

local d_nav = uluaFind("sim/cockpit/radios/nav1_freq_hz")
local d_navs = uluaFind("sim/cockpit/radios/nav1_stdby_freq_hz")
local led_alth_min = 0
-- LED Indicator light
local led_app = uluaFind("sim/cockpit2/autopilot/approach_status")
local led_alth = uluaFind("sim/cockpit2/autopilot/altitude_hold_status")
local led_vs = uluaFind("sim/cockpit2/autopilot/vvi_status")
local led_cmda = uluaFind("sim/cockpit2/autopilot/servos_on")
local led_cmdb = uluaFind("sim/cockpit2/autopilot/servos_on")

local led_lgn = uluaFind("sim/flightmodel2/gear/deploy_ratio", "readonly", 0)
local led_lgl = uluaFind("sim/flightmodel2/gear/deploy_ratio", "readonly", 1)
local led_lgr = uluaFind("sim/flightmodel2/gear/deploy_ratio", "readonly", 2)

local led_ma = uluaFind("sim/cockpit2/autopilot/flight_director_mode")

local led_n1 = uluaFind("sim/cockpit2/autopilot/TOGA_status")

local led_spd = uluaFind("sim/cockpit2/autopilot/speed_status")
local led_lvl = uluaFind("sim/cockpit2/autopilot/speed_status")
local led_vnav = uluaFind("sim/cockpit2/autopilot/vnav_status")
local led_hdgs = uluaFind("sim/cockpit2/autopilot/heading_mode")
local led_lnav = uluaFind("sim/cockpit2/autopilot/nav_status")
local led_vorl = uluaFind("sim/cockpit2/autopilot/nav_status")

local led_at = uluaFind("sim/cockpit2/autopilot/autothrottle_on")

local led_vhf1 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com1")
local led_vhf2 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com2")

local ap_state = uluaFind("sim/cockpit/autopilot/autopilot_state")

local brightness = uluaFind("sim/cockpit/electrical/cockpit_lights[0]")


-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function qmcp737c_ga_digi_disp_set_LEDS()
    uluaSet(idr_qmcp737c_hid_ledapp, uluaGet(led_app))
    if uluaGet(led_alth) > led_alth_min then
        uluaSet(idr_qmcp737c_hid_ledalth, 1)
    else
        uluaSet(idr_qmcp737c_hid_ledalth, 0)
    end
    uluaSet(idr_qmcp737c_hid_ledvs, uluaGet(led_vs))
    uluaSet(idr_qmcp737c_hid_ledcmda, uluaGet(led_cmda))
    uluaSet(idr_qmcp737c_hid_ledcmdb, uluaGet(led_cmdb))
    uluaSet(idr_qmcp737c_hid_ledlgn, math.floor(uluaGet(led_lgn) + 0.5))
    uluaSet(idr_qmcp737c_hid_ledlgl, math.floor(uluaGet(led_lgl) + 0.5))
    uluaSet(idr_qmcp737c_hid_ledlgr, math.floor(uluaGet(led_lgr) + 0.5))
    uluaSet(idr_qmcp737c_hid_ledma, uluaGet(led_ma))
    uluaSet(idr_qmcp737c_hid_ledn1, uluaGet(led_n1))
    uluaSet(idr_qmcp737c_hid_ledspd, uluaGet(led_spd))
    uluaSet(idr_qmcp737c_hid_ledlvl, uluaGet(led_lvl))
    uluaSet(idr_qmcp737c_hid_ledvnav, uluaGet(led_vnav))
    uluaSet(idr_qmcp737c_hid_ledhdgs, uluaGet(led_hdgs))
    uluaSet(idr_qmcp737c_hid_ledlnav, uluaGet(led_lnav))
    uluaSet(idr_qmcp737c_hid_ledvorl, uluaGet(led_vorl))
    uluaSet(idr_qmcp737c_hid_ledat, uluaGet(led_at))
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_ledvhf1, 1)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 0)
    else
        uluaSet(idr_qmcp737c_hid_ledvhf1, 0)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 1)
    end
end

-- MCP Digital Display
function qmcp737c_ga_digi_disp_set_CRS1()
    uluaSet(idr_qmcp737c_hid_crs1, uluaGet(d_crs1))
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end
-- be carefull about:
----d_ias_A
----d_ias_8
function qmcp737c_ga_digi_disp_set_IAS()
    local d_ias_mach_val = uluaGet(d_ias_mach)

    if qmcp737c_ias_show > 0 then
        if uluaGet(d_is_mach) > 0 then
            uluaSet(idr_qmcp737c_hid_ias_f, d_ias_mach_val)
            uluaSet(idr_qmcp737c_hid_iasmod, 3)
        else
            uluaSet(idr_qmcp737c_hid_ias_i, uluaGet(d_ias))
            if d_ias_A == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 1)
            elseif d_ias_8 == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 2)
            else
                uluaSet(idr_qmcp737c_hid_iasmod, 0)
            end
        end
    else
        -- hide IAS
        uluaSet(idr_qmcp737c_hid_iasmod, 4)
    end
end

function qmcp737c_ga_digi_disp_set_HDG()
    uluaSet(idr_qmcp737c_hid_hdg, uluaGet(d_hdg))
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function qmcp737c_ga_digi_disp_set_ALT()
    dd_alt = uluaGet(d_alt)
    if dd_alt < 0 then
        local dis = math.abs(dd_alt - 0.5)
        uluaSet(idr_qmcp737c_hid_alt, dis)
        uluaSet(idr_qmcp737c_hid_altmod, 1)
    else
        local dis = dd_alt + 0.5
        uluaSet(idr_qmcp737c_hid_alt, dis)
        uluaSet(idr_qmcp737c_hid_altmod, 0)
    end
end

function qmcp737c_ga_digi_disp_set_VS()
    local d_vs_val = uluaGet(d_vs)
    if qmcp737c_vvi_show > 0 then
        if d_vs_val < 0 then
            local dis = math.abs(d_vs_val)
            uluaSet(idr_qmcp737c_hid_vs, dis)
            uluaSet(idr_qmcp737c_hid_vsmod, 1)
        else
            uluaSet(idr_qmcp737c_hid_vs, d_vs_val)
            uluaSet(idr_qmcp737c_hid_vsmod, 0)
        end
    else
        -- hide vvi
        uluaSet(idr_qmcp737c_hid_vsmod, 2)
    end
end

function qmcp737c_ga_digi_disp_set_CRS2()
    uluaSet(idr_qmcp737c_hid_crs2, uluaGet(d_crs2))
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

-- COM Panel
function qmcp737c_ga_digi_disp_set_VHFA()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

function qmcp737c_ga_digi_disp_set_VHFS()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_coms))
    else
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_com2s))
    end
end

function qmcp737c_ga_digi_disp_set_NAVA()
    uluaSet(idr_qmcp737c_hid_nava, uluaGet(d_nav))
    uluaSet(idr_qmcp737c_hid_navamod, 1)
end

function qmcp737c_ga_digi_disp_set_NAVS()
    uluaSet(idr_qmcp737c_hid_navs, uluaGet(d_navs))
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end
-- Backlight
local light_test_last = 0
function qmcp737c_ga_digi_disp_set_Bright()
    local qmcp737c_bright_test_val = qmcp737c_bright_test
    if uluaGet(qmcp737c_avionics_on) == 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, uluaGet(brightness) * MaxBightness)
    end
    -- if uluaGet(qmcp737c_battery_on) == 0 then --power off  exit text mode
    --	uluaSet(idr_qmcp737c_hid_brightmod, 0)
    -- else
    uluaSet(idr_qmcp737c_hid_brightmod, qmcp737c_bright_test_val) -- 1,2
    -- end
    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(uluaGet(brightness) * 2))
end

-----end sub functions
local qmcp737c_ga_digi_disp_mcp_func_table = {
    qmcp737c_ga_digi_disp_set_CRS1,
    qmcp737c_ga_digi_disp_set_IAS,
    qmcp737c_ga_digi_disp_set_HDG,
    qmcp737c_ga_digi_disp_set_ALT,
    qmcp737c_ga_digi_disp_set_VS,
    qmcp737c_ga_digi_disp_set_CRS2
}

local qmcp737c_ga_digi_disp_com_func_table = {qmcp737c_ga_digi_disp_set_VHFA, qmcp737c_ga_digi_disp_set_VHFS}

local qmcp737c_ga_digi_disp_nav_func_table = {qmcp737c_ga_digi_disp_set_NAVA, qmcp737c_ga_digi_disp_set_NAVS}
local qmcp737c_ga_digi_disp_rr_func_idx = 0
function qmcp737c_ga_digi_disp_mcp_rr()
    for i = 1, 6 do
        -- Round-Robin check
        qmcp737c_ga_digi_disp_rr_func_idx = qmcp737c_ga_digi_disp_rr_func_idx + 1
        if qmcp737c_ga_digi_disp_rr_func_idx > 6 then
            qmcp737c_ga_digi_disp_rr_func_idx = 1
        end
        qmcp737c_ga_digi_disp_mcp_func_table[qmcp737c_ga_digi_disp_rr_func_idx]()
    end
end
function qmcp737c_ga_digi_disp_com()
    for i = 1, 2 do
        if qmcp737c_ga_digi_disp_com_func_table[i]() then
        -- break
        end
    end
end
function qmcp737c_ga_digi_disp_nav()
    for i = 1, 2 do
        if qmcp737c_ga_digi_disp_nav_func_table[i]() then
        -- break
        end
    end
end

function qmcp737c_ga_digi_disp_every_frame()
    qmcp737c_ga_digi_disp_set_Bright()

    if uluaGet(qmcp737c_avionics_on) > 0 then
        qmcp737c_ga_digi_disp_set_LEDS()
    else
        --qmcp737c_ga_digi_disp_powoff_leds()
    end

    if uluaGet(qmcp737c_battery_on) > 0 then
        qmcp737c_ga_digi_disp_mcp_rr()
    else
        --qmcp737c_ga_digi_disp_powoff_mcp()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_com1_power) > 0 then
        qmcp737c_ga_digi_disp_com()
    else
        --qmcp737c_ga_digi_disp_powoff_com()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_nav1_power) > 0 then
        qmcp737c_ga_digi_disp_nav()
    else
        --qmcp737c_ga_digi_disp_powoff_nav()
    end
end
uluaAddDoLoop("qmcp737c_ga_digi_disp_every_frame()")
