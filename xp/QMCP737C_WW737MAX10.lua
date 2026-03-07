--**********************************************************************************************************--
-- QMCP737C Driver for  737MAX
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-10-29  last modified:2020-12-22  test with ZIBO 3_42-3_44
--**********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2019-06-12
-- modified by Wei Shuai <cpuwolf@gmail.com> 2022-03-27 for init.lua
--######################  Edit part  #####################
--此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 --How many spins per second  is considered FAST?
--
local MaxBightness = 25 --Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.
local SetNav2same = 1 --set Nav2 Freq = NAV1   //设定Nav2和NAV2 相同,值为1有效
local IsAlreadyInit = 0 --是否已经初始化过了，用来设定首次通电时要执行的内容

--
--laminar/B738/electric/panel_brightness 面板背光，四个数组，浮点
--########################################################
if PLANE_ICAO ~= "B38M" and PLANE_TAILNUMBER ~= "ZB38M" then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for WW 737-MAX10")


uluaQmdevConfig(2, 'ROTATE;"f";0;1;5;1;0;0;360;"sim/cockpit/radios/nav1_obs_degm"')
uluaQmdevConfig(2, 'ROTATE;"i";12;13;5;1;2;0;360;"laminar/B738/autopilot/mcp_hdg_dial"')
uluaQmdevConfig(2, 'ROTATE;"i";16;17;500;100;1;0;41000;"laminar/B738/autopilot/mcp_alt_dial"')
uluaQmdevConfig(2, 'ROTATE;"f";26;27;5;1;0;0;360;"sim/cockpit/radios/nav1_obs_degm2"')
uluaQmdevConfig(2, 'ASSIGN;0;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;1;"sim/none/none"')
uluaQmdevConfig(2, 'DFKEY;2;1;0;"laminar/B738/switches/autopilot/fd_ca"')
uluaQmdevConfig(2, 'DFKEY;3;1;0;"laminar/B738/switches/autopilot/at_arm"')
uluaQmdevConfig(2, 'ASSIGN;4;"sim/autopilot/airspeed_down"')
uluaQmdevConfig(2, 'ASSIGN;5;"sim/autopilot/airspeed_up')
uluaQmdevConfig(2, 'ASSIGN;6;"laminar/B738/autopilot/change_over_press"')
uluaQmdevConfig(2, 'ASSIGN;7;"laminar/B738/autopilot/n1_press"')
uluaQmdevConfig(2, 'ASSIGN;8;"laminar/B738/autopilot/speed_press"')
uluaQmdevConfig(2, 'ASSIGN;9;"laminar/B738/autopilot/lvl_chg_press"')
uluaQmdevConfig(2, 'ASSIGN;10;"laminar/B738/autopilot/spd_interv"')
uluaQmdevConfig(2, 'ASSIGN;11;"laminar/B738/autopilot/vnav_press"')
uluaQmdevConfig(2, 'ASSIGN;12;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;13;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;14;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;15;"laminar/B738/autopilot/hdg_sel_press"')
uluaQmdevConfig(2, 'ASSIGN;16;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;17;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;18;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;19;"laminar/B738/autopilot/lnav_press"')
uluaQmdevConfig(2, 'ASSIGN;20;"laminar/B738/autopilot/vorloc_press"')
uluaQmdevConfig(2, 'ASSIGN;21;"laminar/B738/autopilot/app_press"')
uluaQmdevConfig(2, 'ASSIGN;22;"laminar/B738/autopilot/alt_hld_press"')
uluaQmdevConfig(2, 'ASSIGN;23;"laminar/B738/autopilot/vs_press"')
uluaQmdevConfig(2, 'ASSIGN;24;"sim/autopilot/vertical_speed_down"')
uluaQmdevConfig(2, 'ASSIGN;25;"sim/autopilot/vertical_speed_up"')
uluaQmdevConfig(2, 'ASSIGN;26;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;27;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;28;"sim/none/none"')
uluaQmdevConfig(2, 'ASSIGN;28;"laminar/B738/autopilot/flight_director_fo_toggle"')
uluaQmdevConfig(2, 'ASSIGN;29;"laminar/B738/autopilot/alt_interv"')
uluaQmdevConfig(2, 'ASSIGN;30;"laminar/B738/autopilot/cmd_a_press"')
uluaQmdevConfig(2, 'ASSIGN;31;"laminar/B738/autopilot/cmd_b_press"')
uluaQmdevConfig(2, 'ASSIGN;32;"laminar/B738/pfd/dh_pilot_dn"')
uluaQmdevConfig(2, 'ASSIGN;33;"laminar/B738/pfd/dh_pilot_up"')
uluaQmdevConfig(2, 'ASSIGN;34;"laminar/B738/EFIS_control/capt/vor1_off_up";"laminar/B738/EFIS_control/capt/vor1_off_dn"')
uluaQmdevConfig(2, 'ASSIGN;35;"laminar/B738/EFIS_control/capt/vor1_off_dn";"laminar/B738/EFIS_control/capt/vor1_off_up"')
uluaQmdevConfig(2, 'ASSIGN;36;"laminar/B738/EFIS_control/capt/push_button/rst_press"')
uluaQmdevConfig(2, 'ASSIGN;37;"laminar/B738/EFIS_control/capt/push_button/fpv_press"')
uluaQmdevConfig(2, 'ASSIGN;38;"laminar/B738/EFIS_control/capt/push_button/wxr_press"')
uluaQmdevConfig(2, 'ASSIGN;39;"laminar/B738/EFIS_control/capt/push_button/sta_press"')
uluaQmdevConfig(2, 'ASSIGN;40;"laminar/B738/EFIS_control/capt/push_button/ctr_press"')
uluaQmdevConfig(2, 'ASSIGN;41;"laminar/B738/EFIS_control/capt/map_mode_up"')
uluaQmdevConfig(2, 'ASSIGN;42;"laminar/B738/EFIS_control/capt/map_mode_dn"')
uluaQmdevConfig(2, 'ASSIGN;43;"laminar/B738/EFIS_control/capt/push_button/mtrs_press"')
uluaQmdevConfig(2, 'ASSIGN;44;"laminar/B738/EFIS_control/capt/push_button/wpt_press"')
uluaQmdevConfig(2, 'ASSIGN;45;"laminar/B738/EFIS_control/capt/push_button/arpt_press"')
uluaQmdevConfig(2, 'ASSIGN;46;"laminar/B738/EFIS_control/capt/push_button/data_press"')
uluaQmdevConfig(2, 'ASSIGN;47;"laminar/B738/EFIS_control/capt/push_button/pos_press"')
uluaQmdevConfig(2, 'ASSIGN;48;"laminar/B738/pilot/barometer_down"')
uluaQmdevConfig(2, 'ASSIGN;49;"laminar/B738/pilot/barometer_up"')
uluaQmdevConfig(2, 'ASSIGN;50;"laminar/B738/EFIS_control/capt/push_button/std_press"')
uluaQmdevConfig(2, 'ASSIGN;51;"laminar/B738/EFIS_control/capt/map_range_dn"')
uluaQmdevConfig(2, 'ASSIGN;52;"laminar/B738/EFIS_control/capt/map_range_up"')
uluaQmdevConfig(2, 'ASSIGN;53;"laminar/B738/EFIS_control/capt/push_button/tfc_press"')
uluaQmdevConfig(2, 'ASSIGN;54;"laminar/B738/EFIS_control/capt/vor2_off_dn";"laminar/B738/EFIS_control/capt/vor2_off_up"')
uluaQmdevConfig(2, 'ASSIGN;55;"laminar/B738/EFIS_control/capt/vor2_off_up";"laminar/B738/EFIS_control/capt/vor2_off_dn"')
uluaQmdevConfig(2, 'ASSIGN;56;"laminar/B738/rtp_L/freq_khz/sel_dial_dn"')
uluaQmdevConfig(2, 'ASSIGN;57;"laminar/B738/rtp_L/freq_khz/sel_dial_up"')
uluaQmdevConfig(2, 'ASSIGN;58;"laminar/B738/rtp_L/freq_MHz/sel_dial_dn"')
uluaQmdevConfig(2, 'ASSIGN;59;"laminar/B738/rtp_L/freq_MHz/sel_dial_up"')
uluaQmdevConfig(2, 'DFKEY;60;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[60]"')
uluaQmdevConfig(2, 'ASSIGN;61;"laminar/B738/rtp_L/freq_txfr/sel_switch"')
uluaQmdevConfig(2, 'ASSIGN;64;"sim/radios/stby_nav1_fine_down"')
uluaQmdevConfig(2, 'ASSIGN;65;"sim/radios/stby_nav1_fine_up"')
uluaQmdevConfig(2, 'ASSIGN;66;"sim/radios/stby_nav1_coarse_down"')
uluaQmdevConfig(2, 'ASSIGN;67;"sim/radios/stby_nav1_coarse_up"')
uluaQmdevConfig(2, 'DFKEY;68;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[68]"')
uluaQmdevConfig(2, 'ASSIGN;69;"laminar/B738/push_button/switch_freq_nav1_press"')
uluaQmdevConfig(2, 'ASSIGN;70;"laminar/B738/EFIS_control/capt/push_button/terr_press"')
uluaQmdevConfig(2, 'DFKEY;71;1;0;"laminar/B738/switches/autopilot/ap_disconnect"')
uluaQmdevConfig(2, 'DFKEY;72;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[72]"')
uluaQmdevConfig(2, 'DFKEY;73;1;0;"sim/cockpit2/switches/generic_lights_switch[3]"')
uluaQmdevConfig(2, 'DFKEY;74;1;0;"sim/cockpit2/switches/generic_lights_switch[2]"')
uluaQmdevConfig(2, 'DFKEY;75;1;0;"sim/cockpit2/switches/generic_lights_switch[5]"')
uluaQmdevConfig(2, 'DFKEY;76;1;0;"sim/cockpit2/switches/generic_lights_switch[0]"')
uluaQmdevConfig(2, 'DFKEY;77;1;0;"sim/cockpit/electrical/beacon_lights_on"')
uluaQmdevConfig(2, 'DFKEY;78;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[78]"')
uluaQmdevConfig(2, 'DFKEY;79;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[79]"')
uluaQmdevConfig(2, 'DFKEY;80;1;0;"laminar/B738/switch/land_lights_right_pos"')
uluaQmdevConfig(2, 'DFKEY;81;1;0;"laminar/B738/switch/land_lights_left_pos"')
uluaQmdevConfig(2, 'DFKEY;82;1;0;"sim/cockpit2/switches/generic_lights_switch[1]"')
uluaQmdevConfig(2, 'ASSIGN;83;"laminar/B738/push_button/gear_down"')
uluaQmdevConfig(2, 'ASSIGN;84;"laminar/B738/push_button/gear_up"')
uluaQmdevConfig(2, 'DFKEY;85;0;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'DFKEY;86;1;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'DFKEY;87;2;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'DFKEY;88;3;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'DFKEY;89;4;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'DFKEY;90;5;;"cpuwolf/qmdev/QMCP737C/condbtn[85]"')
uluaQmdevConfig(2, 'ASSIGN;91;"laminar/B738/push_button/flaps_0"')
uluaQmdevConfig(2, 'ASSIGN;92;"laminar/B738/push_button/flaps_1"')
uluaQmdevConfig(2, 'ASSIGN;93;"laminar/B738/push_button/flaps_2"')
uluaQmdevConfig(2, 'ASSIGN;94;"laminar/B738/push_button/flaps_5"')
uluaQmdevConfig(2, 'ASSIGN;95;"laminar/B738/push_button/flaps_10"')
uluaQmdevConfig(2, 'ASSIGN;96;"laminar/B738/push_button/flaps_15"')
uluaQmdevConfig(2, 'ASSIGN;97;"laminar/B738/push_button/flaps_25"')
uluaQmdevConfig(2, 'ASSIGN;98;"laminar/B738/push_button/flaps_30"')
uluaQmdevConfig(2, 'ASSIGN;99;"laminar/B738/push_button/flaps_40"')
uluaQmdevConfig(2, 'DFKEY;100;0;;"laminar/B738/flt_ctrls/speedbrake_lever"')
uluaQmdevConfig(2, 'DFKEY;101;1;0;"cpuwolf/qmdev/QMCP737C/condbtn[101]"')
uluaQmdevConfig(2, 'DFKEY;102;2;0;"cpuwolf/qmdev/QMCP737C/condbtn[101]"')
uluaQmdevConfig(2, 'DFKEY;103;1;;"laminar/B738/flt_ctrls/speedbrake_lever"')


function digi_disp_n1_leds()
    uluaSet(idr_qmcp737c_hid_leds, 16384)
end

function digi_disp_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end
function digi_disp_powoff_mcp()
    uluaSet(idr_qmcp737c_hid_crs1mod, 0)
    uluaSet(idr_qmcp737c_hid_iasmod, 4)
    uluaSet(idr_qmcp737c_hid_hdgmod, 0)
    uluaSet(idr_qmcp737c_hid_altmod, 2)
    uluaSet(idr_qmcp737c_hid_vsmod, 0)
    uluaSet(idr_qmcp737c_hid_vsmod, 2)
    uluaSet(idr_qmcp737c_hid_crs2mod, 0)
end

function digi_disp_powoff_com()
    local i = uluaGet(idr_qmcp737c_hid_vhfa)
    i = i + 1
    if (i > 128) or (i < 0) then
        i = 1
    end
    uluaSet(idr_qmcp737c_hid_vhfa, i)
    uluaSet(idr_qmcp737c_hid_vhfs, i)
end
function digi_disp_powoff_nav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end

--switches

----------------------------  Display Dataref Set	 ------------------------------------
-- Display for Zibo 737
--MCP Panel Digital Display

local dr_qmcp737c_bright_test = iDataRef:New("laminar/B738/dspl_light_test")
local dr_qmcp737c_com1_power = uluaFind("sim/cockpit2/radios/actuators/com1_power")
local dr_qmcp737c_nav1_power = uluaFind("laminar/B738/comm/nav1_status")
local dr_qmcp737c_battery_on = uluaFind("sim/cockpit/electrical/battery_on")
local dr_qmcp737c_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")
--dr_qmcp737c_power_on = uluaFind("sim/cockpit2/switches/avionics_power_on")
local dr_d_crs1 = uluaFind("sim/cockpit/radios/nav1_obs_degm")
local d_ias = uluaFind("laminar/B738/autopilot/mcp_speed_dial_kts_mach")
local d_hdg = uluaFind("laminar/B738/autopilot/mcp_hdg_dial")
local d_alt = uluaFind("laminar/B738/autopilot/mcp_alt_dial")
local dr_d_vs = uluaFind("sim/cockpit2/autopilot/vvi_dial_fpm")
--DataRef('d_crs2', 'sim/cockpit2/radios/actuators/nav1_obs_deg_mag_copilot')
local dr_d_crs2 = uluaFind("sim/cockpit/radios/nav1_obs_degm2")
local dr_d_ias_8 = uluaFind("laminar/B738/mcp/digit_8")
local dr_d_ias_A = uluaFind("laminar/B738/mcp/digit_A")
local dr_qmcp737c_ias_show = uluaFind("laminar/B738/autopilot/show_ias")
local dr_qmcp737c_vvi_show = uluaFind("laminar/B738/autopilot/vvi_dial_show")
--new add C/O display
local d_is_mach = uluaFind("sim/cockpit/autopilot/airspeed_is_mach")
local d_ias_mach = uluaFind("laminar/B738/autopilot/mcp_speed_dial_kts_mach")

--COM Panel Digital Display
local dr_d_com = uluaFind("sim/cockpit2/radios/actuators/com1_frequency_hz_833")
local dr_d_coms = uluaFind("sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833")

local dr_d_com2 = uluaFind("sim/cockpit2/radios/actuators/com2_frequency_hz_833")
local dr_d_com2s = uluaFind("sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")

local dr_d_nav = uluaFind("sim/cockpit/radios/nav1_freq_hz")
local dr_d_navs = uluaFind("sim/cockpit/radios/nav1_stdby_freq_hz")

if SetNav2same == 1 then
    dr_d_nav2 = uluaFind("sim/cockpit/radios/nav2_freq_hz")
end

-- LED Indicator light
local dr_led_app = uluaFind("laminar/B738/autopilot/app_status")
local dr_led_alth = uluaFind("laminar/B738/autopilot/alt_hld_status")
local led_alth_min = 0
local dr_led_vs = uluaFind("laminar/B738/autopilot/vs_status")
local dr_led_cmda = uluaFind("laminar/B738/autopilot/cmd_a_status")
local dr_led_cmdb = uluaFind("laminar/B738/autopilot/cmd_b_status")
local dr_led_lgn = uluaFind("laminar/B738/annunciator/nose_gear_safe")
local dr_led_lgl = uluaFind("laminar/B738/annunciator/left_gear_safe")
local dr_led_lgr = uluaFind("laminar/B738/annunciator/right_gear_safe")

local dr_led_ma = uluaFind("laminar/B738/autopilot/master_capt_status")
local dr_led_n1 = uluaFind("laminar/B738/autopilot/n1_status")
local dr_led_spd = uluaFind("laminar/B738/autopilot/speed_status1")
local dr_led_lvl = uluaFind("laminar/B738/autopilot/lvl_chg_status")
local dr_led_vnav = uluaFind("laminar/B738/autopilot/vnav_status1")
local dr_led_hdgs = uluaFind("laminar/B738/autopilot/hdg_sel_status")
local dr_led_lnav = uluaFind("laminar/B738/autopilot/lnav_status")
local dr_led_vorl = uluaFind("laminar/B738/autopilot/vorloc_status")

local dr_led_at = uluaFind("laminar/B738/autopilot/autothrottle_status")

local dr_led_vhf1 = uluaFind("laminar/B738/comm/rtp_L/vhf_1_status")
local dr_led_vhf2 = uluaFind("laminar/B738/comm/rtp_L/vhf_2_status")

local dr_ap_state = uluaFind("sim/cockpit/autopilot/autopilot_state")

local dr_brightness = uluaFind("laminar/B738/electric/panel_brightness")
local dr_brightness1 = uluaFind("laminar/B738/electric/panel_brightness")
local dr_brightness2 = uluaFind("laminar/B738/electric/panel_brightness")
local dr_brightness3 = uluaFind("laminar/B738/electric/panel_brightness")
----------------------------  Display Dataref Set End ------------------------------------

--*****************************  Special Swichs Dataref  ****************************************
--For ZIBO737

local dr_vor1 = uluaFind("laminar/B738/EFIS_control/capt/vor1_off_pos")
local dr_vor2 = uluaFind("laminar/B738/EFIS_control/capt/vor2_off_pos")
local dr_taxi = uluaFind("laminar/B738/toggle_switch/taxi_light_brightness_pos") --TAXI Light Switch
local dr_sbrake = uluaFind("laminar/B738/flt_ctrls/speedbrake_lever")
local dr_zibo_at_arm_pos = uluaFind("laminar/B738/autopilot/autothrottle_arm_pos")
local dr_zibo_ap_disc_pos = uluaFind("laminar/B738/autopilot/disconnect_pos")
local dr_lg = uluaFind("laminar/B738/switches/landing_gear")
local dr_position_light = uluaFind("laminar/B738/toggle_switch/position_light_pos") --positon light
local dr_autobreak_pose = uluaFind("laminar/B738/autobrake/autobrake_pos") -- auto break switch position rto is 0 max is 5

local dr_vhf_sen = uluaFind("laminar/B738/comm/rtp_L/hf_sens_ctrl/rheostat")
--new fix dh display bug
-- DataRef('dh_pilot', 'laminar/B738/pfd/dh_pilot')
--*************************************************************************************

------------------ Spical Switchs  Process  -------------------------------
local last_left_land = 0 --last landing light left state
local last_right_land = 0 --last landing light right state

local zibo738_d_baro_hap = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa")
local zibo738_d_land_lpos = uluaFind("laminar/B738/switch/land_lights_left_pos")
local zibo738_d_land_rpos = uluaFind("laminar/B738/switch/land_lights_right_pos")
local zibo738_cmd_vhf1_switch = uluaFind("laminar/B738/rtp_L/vhf_1/sel_switch")
local zibo738_cmd_vhf2_switch = uluaFind("laminar/B738/rtp_L/vhf_2/sel_switch")
local zibo738_cmd_baro_hpa_u = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_up")
local zibo738_cmd_baro_hpa_d = uluaFind("laminar/B738/EFIS_control/capt/baro_in_hpa_dn")
local zibo738_cmd_land_l_off = uluaFind("laminar/B738/switch/land_lights_ret_left_off")
local zibo738_cmd_land_l_on = uluaFind("laminar/B738/switch/land_lights_ret_left_on")
local zibo738_cmd_land_r_off = uluaFind("laminar/B738/switch/land_lights_ret_right_off")
local zibo738_cmd_land_r_on = uluaFind("laminar/B738/switch/land_lights_ret_right_on")
local zibo738_cmd_disap = uluaFind("laminar/B738/autopilot/disconnect_toggle")
local zibo738_cmd_taxi_toggle = uluaFind("laminar/B738/toggle_switch/taxi_light_brigh_toggle")
local zibo738_cmd_pos_down = uluaFind("laminar/B738/toggle_switch/position_light_down")
local zibo738_cmd_pos_up = uluaFind("laminar/B738/toggle_switch/position_light_up")
local zibo738_cmd_autobrake_down = uluaFind("laminar/B738/knob/autobrake_dn")
local zibo738_cmd_autobrake_up = uluaFind("laminar/B738/knob/autobrake_up")
--local org_vhf = d_coms
-- local last_dh_pilot = dh_pilot
local vhf_toggle_pressed = false
local taxi_last_press
local pos78_last_press
local pos79_last_press
local sbreak_last = 0
local abrake_last = 0
local abrake_turn = 0
-- local vor1_last = 0
-- local vor2_last = 0
function ZB738M_frame_update()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    local qmcp737c_val_condbtn_68 = idr_qmcp737c_hid_condbtn_68:Get()
    local qmcp737c_val_condbtn_72 = idr_qmcp737c_hid_condbtn_72:Get()
    local qmcp737c_val_condbtn_78 = idr_qmcp737c_hid_condbtn_78:Get()
    local qmcp737c_val_condbtn_79 = idr_qmcp737c_hid_condbtn_79:Get()
    local qmcp737c_val_condbtn_85 = idr_qmcp737c_hid_condbtn_85:Get()
    local qmcp737c_val_condbtn_101 = idr_qmcp737c_hid_condbtn_101:Get()
    -- --fix the bug  display dh_pilot
    -- if (last_dh_pilot ~= dh_pilot) then
    --     if (qmcp737c_hid_fastkey[32] == 1) then
    --         dh_pilot = dh_pilot - 20
    --     elseif qmcp737c_hid_fastkey[33] == 1 then
    --         dh_pilot = dh_pilot + 20
    --     end
    --     last_dh_pilot = dh_pilot
    -- end
    --VHF1 VHF2 Toggle

    --VHF1 VHF2 Toggle
    if qmcp737c_val_condbtn_60 == 1 then
        if vhf_toggle_pressed == false then
            if led_vhf1 == 1 then
                uluaCmdOnce(zibo738_cmd_vhf2_switch)
            else
                uluaCmdOnce(zibo738_cmd_vhf1_switch)
            end
            vhf_toggle_pressed = true
        end
    elseif qmcp737c_val_condbtn_68 == 1 then
        if vhf_toggle_pressed == false then
            if (uluaGet(zibo738_d_baro_hap) == 0) then
                uluaCmdOnce(zibo738_cmd_baro_hpa_u)
            else
                uluaCmdOnce(zibo738_cmd_baro_hpa_d)
            end
            vhf_toggle_pressed = true
        end
    else
        vhf_toggle_pressed = false
    end

    --TAXI Switch
    local taxi = uluaGet(dr_taxi)
    if qmcp737c_val_condbtn_72 ~= taxi_last_press then
        if (qmcp737c_val_condbtn_72 == 1 and taxi == 0) or (qmcp737c_val_condbtn_72 == 0 and taxi > 0) then
            uluaCmdOnce(zibo738_cmd_taxi_toggle)
        end
        taxi_last_press = qmcp737c_val_condbtn_72
    end

    if qmcp737c_val_condbtn_101 ~= sbreak_last then
        if qmcp737c_val_condbtn_101 == 1 then
            uluaSet(dr_sbrake, 0.0889)
        elseif qmcp737c_val_condbtn_101 == 2 then
            uluaSet(dr_sbrake, 0.75)
        end
        sbreak_last = qmcp737c_val_condbtn_101
    end
    --Position
    local position_light = uluaGet(dr_position_light)
    if qmcp737c_val_condbtn_78 ~= pos78_last_press then
        if qmcp737c_val_condbtn_78 == 1 and position_light == 0 then
            uluaCmdOnce(zibo738_cmd_pos_down)
        elseif qmcp737c_val_condbtn_78 == 0 and position_light == -1 then
            uluaCmdOnce(zibo738_cmd_pos_up)
        end
        pos78_last_press = qmcp737c_val_condbtn_78
    end

    if qmcp737c_val_condbtn_79 ~= pos79_last_press then
        if qmcp737c_val_condbtn_79 == 1 and position_light == 0 then
            uluaCmdOnce(zibo738_cmd_pos_up)
        elseif qmcp737c_val_condbtn_79 == 0 and position_light == 1 then
            uluaCmdOnce(zibo738_cmd_pos_down)
        end
        pos79_last_press = qmcp737c_val_condbtn_79
    end
    -- -- autobrake position
    local autobreak_pose = uluaGet(dr_autobreak_pose)
    if qmcp737c_val_condbtn_85 ~= abrake_last then
        abrake_turn = qmcp737c_val_condbtn_85 - autobreak_pose
        abrake_last = qmcp737c_val_condbtn_85
    end
    if (abrake_turn < 0) then
        uluaCmdOnce(zibo738_cmd_autobrake_down)
        abrake_turn = abrake_turn + 1
    end
    if (abrake_turn > 0) then
        uluaCmdOnce(zibo738_cmd_autobrake_up)
        abrake_turn = abrake_turn - 1
    end
end

uluaAddDoLoop("ZB738M_frame_update()")
uluaAddDoLoop("ZB738M_digi_disp_every_frame()")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function digi_disp_set_LEDS()
    local led_cmda = uluaGet(dr_led_cmda)
    local led_cmdb = uluaGet(dr_led_cmdb)
    local led_vs = uluaGet(dr_led_vs)
    local led_lvl = uluaGet(dr_led_lvl)
    local led_spd = uluaGet(dr_led_spd)
    local led_lnav = uluaGet(dr_led_lnav)
    local led_vnav = uluaGet(dr_led_vnav)
    local led_vorl = uluaGet(dr_led_vorl)
    local led_hdgs = uluaGet(dr_led_hdgs)
    local led_alth = uluaGet(dr_led_alth)
    local led_app = uluaGet(dr_led_app)
    --
    local led_lgn = uluaGet(dr_led_lgn)
    local led_lgl = uluaGet(dr_led_lgl)
    local led_lgr = uluaGet(dr_led_lgr)
    local led_ma = uluaGet(dr_led_ma)
    local led_n1 = uluaGet(dr_led_n1)
    local led_at = uluaGet(dr_led_at)
    local led_vhf1 = uluaGet(dr_led_vhf1)
    local led_vhf2 = uluaGet(dr_led_vhf2)
    uluaSet(idr_qmcp737c_hid_ledapp, led_app)
    if led_alth > led_alth_min then
        uluaSet(idr_qmcp737c_hid_ledalth, 1)
    else
        uluaSet(idr_qmcp737c_hid_ledalth, 0)
    end
    uluaSet(idr_qmcp737c_hid_ledvs, led_vs)
    uluaSet(idr_qmcp737c_hid_ledcmda, led_cmda)
    uluaSet(idr_qmcp737c_hid_ledcmdb, led_cmdb)
    uluaSet(idr_qmcp737c_hid_ledlgn, math.floor(led_lgn + 0.5))
    uluaSet(idr_qmcp737c_hid_ledlgl, math.floor(led_lgl + 0.5))
    uluaSet(idr_qmcp737c_hid_ledlgr, math.floor(led_lgr + 0.5))
    uluaSet(idr_qmcp737c_hid_ledma, led_ma)
    uluaSet(idr_qmcp737c_hid_ledn1, led_n1)
    uluaSet(idr_qmcp737c_hid_ledspd, led_spd)
    uluaSet(idr_qmcp737c_hid_ledlvl, led_lvl)
    uluaSet(idr_qmcp737c_hid_ledvnav, led_vnav)
    uluaSet(idr_qmcp737c_hid_ledhdgs, led_hdgs)
    uluaSet(idr_qmcp737c_hid_ledlnav, led_lnav)
    uluaSet(idr_qmcp737c_hid_ledvorl, led_vorl)
    uluaSet(idr_qmcp737c_hid_ledat, led_at)
    uluaSet(idr_qmcp737c_hid_ledvhf1, led_vhf1)
    uluaSet(idr_qmcp737c_hid_ledvhf2, led_vhf2)
end

-- MCP Digital Display
function digi_disp_set_CRS1()
    local d_crs1 = uluaGet(dr_d_crs1)
    d_crs1 = math.floor(d_crs1 + 0.5)
    uluaSet(idr_qmcp737c_hid_crs1, d_crs1)
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end
--be carefull about:
----d_ias_A
----d_ias_8
function digi_disp_set_IAS()
    local qmcp737c_ias_show = uluaGet(dr_qmcp737c_ias_show)
    if qmcp737c_ias_show > 0 then
        if uluaGet(d_is_mach) > 0 then
            uluaSet(idr_qmcp737c_hid_disfast_4, 1)
            uluaSet(idr_qmcp737c_hid_disfast_5, 1)
            uluaSet(idr_qmcp737c_hid_ias_f, uluaGet(d_ias_mach))
            uluaSet(idr_qmcp737c_hid_iasmod, 3)
        else
            uluaSet(idr_qmcp737c_hid_disfast_4, 0)
            uluaSet(idr_qmcp737c_hid_disfast_5, 0)
            uluaSet(idr_qmcp737c_hid_ias_i, uluaGet(d_ias))
            if uluaGet(dr_d_ias_A) == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 1)
            elseif uluaGet(dr_d_ias_8) == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 2)
            else
                uluaSet(idr_qmcp737c_hid_iasmod, 0)
            end
        end
    else
        --hide IAS
        uluaSet(idr_qmcp737c_hid_iasmod, 4)
    end
end

function digi_disp_set_HDG()
    uluaSet(idr_qmcp737c_hid_hdg, uluaGet(d_hdg))
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function digi_disp_set_ALT()
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

function digi_disp_set_VS()
    local d_vs = uluaGet(dr_d_vs)
    if uluaGet(dr_qmcp737c_vvi_show) > 0 then
        if d_vs < 0 then
            local dis = math.abs(d_vs)
            uluaSet(idr_qmcp737c_hid_vs, dis)
            uluaSet(idr_qmcp737c_hid_vsmod, 1)
        else
            uluaSet(idr_qmcp737c_hid_vs, d_vs)
            uluaSet(idr_qmcp737c_hid_vsmod, 0)
        end
    else
        --hide vvi
        uluaSet(idr_qmcp737c_hid_vsmod, 2)
    end
end

function digi_disp_set_CRS2()
    local d_crs2 = uluaGet(dr_d_crs2)
    d_crs2 = math.floor(d_crs2 + 0.5)
    uluaSet(idr_qmcp737c_hid_crs2, d_crs2)
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

--COM Panel
function digi_disp_set_VHFA()
    if uluaGet(dr_led_vhf1) == 1 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(dr_d_com))
    elseif uluaGet(dr_led_vhf2) == 1 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(dr_d_com2))
    end
end

function digi_disp_set_VHFS()
    if uluaGet(dr_led_vhf1) == 1 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(dr_d_coms))
    elseif uluaGet(dr_led_vhf2) == 1 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(dr_d_com2s))
    end
end

function digi_disp_set_NAVA()
    uluaSet(idr_qmcp737c_hid_nava, uluaGet(dr_d_nav))
    uluaSet(idr_qmcp737c_hid_navamod, 1)
    if SetNav2same == 1 then
        uluaSet(dr_d_nav2, uluaGet(dr_d_nav))
    end
end

function digi_disp_set_NAVS()
    uluaSet(idr_qmcp737c_hid_navs, uluaGet(dr_d_navs))
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end
--Backlight
local light_test_last = 0
local brightness = 0.8
function digi_disp_set_Bright()
    local qmcp737c_bright_test = dr_qmcp737c_bright_test:Get()
    --初始化面板背光，第一次通电时打开
    if IsAlreadyInit == 0 and uluaGet(dr_qmcp737c_battery_on) == 1 then
        brightness = 0.8
        brightness1 = 0.8
        brightness2 = 0.8
        brightness3 = 0.8
        IsAlreadyInit = 1
    end

    if qmcp737c_avionics_on == 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, brightness * MaxBightness)
    end
    --if uluaGet(uluaGet(dr_qmcp737c_battery_on)) == 0 then --power off  exit text mode
    --	uluaSet(idr_qmcp737c_hid_brightmod, 0)
    --else
    uluaSet(idr_qmcp737c_hid_brightmod, qmcp737c_bright_test) --1,2
    --end
    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(brightness * 2))

    if lighttest_last ~= qmcp737c_bright_test then
        if qmcp737c_bright_test == 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        lighttest_last = qmcp737c_bright_test
    end
end

-----end sub functions
local digi_disp_mcp_func_table = {
    digi_disp_set_CRS1,
    digi_disp_set_IAS,
    digi_disp_set_HDG,
    digi_disp_set_ALT,
    digi_disp_set_VS,
    digi_disp_set_CRS2
}

local digi_disp_com_func_table = {
    digi_disp_set_VHFA,
    digi_disp_set_VHFS
}

local digi_disp_nav_func_table = {
    digi_disp_set_NAVA,
    digi_disp_set_NAVS
}
local digi_disp_rr_func_idx = 0
function digi_disp_mcp_rr()
    for i = 1, 6 do
        --Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx + 1
        if digi_disp_rr_func_idx > 6 then
            digi_disp_rr_func_idx = 1
        end
        digi_disp_mcp_func_table[digi_disp_rr_func_idx]()
    end
end
function digi_disp_com()
    for i = 1, 2 do
        if digi_disp_com_func_table[i]() then
        --break
        end
    end
end
function digi_disp_nav()
    for i = 1, 2 do
        if digi_disp_nav_func_table[i]() then
        --break
        end
    end
end

function ZB738M_digi_disp_every_frame()
    local qmcp737c_battery_on = uluaGet(dr_qmcp737c_battery_on)
    local qmcp737c_com1_power = uluaGet(dr_qmcp737c_com1_power)
    local qmcp737c_nav1_power = uluaGet(dr_qmcp737c_nav1_power)
    digi_disp_set_Bright()

    if uluaGet(dr_qmcp737c_avionics_on) > 0 then
        digi_disp_set_LEDS()
    else
        digi_disp_powoff_leds()
    end

    if qmcp737c_battery_on > 0 then
        digi_disp_mcp_rr()
    else
        digi_disp_powoff_mcp()
    end

    if qmcp737c_battery_on > 0 and qmcp737c_com1_power > 0 then
        digi_disp_com()
    else
        digi_disp_powoff_com()
    end

    if qmcp737c_battery_on > 0 and qmcp737c_nav1_power > 0 then
        digi_disp_nav()
    else
        digi_disp_powoff_nav()
    end
end
