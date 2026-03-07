--require "bit"
--**********************************************************************************************************--
-- PC Driver for QGMC710
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2018-12-6

-- Send 3 Bytes:
-- 1st Byte
---- B7  B6  B5 B4   B3   B2  B1  B0
---- BL  FLC VS YD XFR_R BANK NAV HDG
-- 2nd Byte
---- B7 B6  B5   B4   B3   B2  B1  B0
---- X  X  VNV  ALT  AP  XFR_L BC  APR
-- 3rd Byte
---- B7 B6 B5 B4 B3 B2 B1 B0
----  Brightness
--
-- Notes:
-- BL:backlight  1=PC control ; 0=Manual control
---- When BL=1 , 3rd byte is the brightness value  0-255

--**********************Copyright***********************--

-- modified by Wei Shuai <cpuwolf@gmail.com>
-- 2021-12-30 tested on Hot Start TBM-900 v1.1.13
--######################  Edit part  #####################
--此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 30 --How many spins per second  is considered FAST?

--########################################################
----------------------  Edit the  DataRef for different Aircraft -----------------------
-------  Common Dataref -------------------------------
qgmv710_xp_cockpit_led = uluaFind("sim/cockpit/electrical/cockpit_lights")


if PLANE_ICAO == "TBM9" then
    qgmv710_xp_flc_led = uluaFind("tbm900/lights/ap/flc")
    qgmv710_xp_vs_led = uluaFind("tbm900/lights/ap/vs")
    qgmv710_xp_yd_led = uluaFind("tbm900/lights/ap/yd")
    qgmv710_xp_xfr_r_led = uluaFind("tbm900/lights/ap/comp_right")
    qgmv710_xp_bank_led = uluaFind("tbm900/lights/ap/bank")
    qgmv710_xp_nav_led = uluaFind("tbm900/lights/ap/nav")
    qgmv710_xp_hdg_led = uluaFind("tbm900/lights/ap/hdg")

    qgmv710_xp_vnv_led = uluaFind("tbm900/lights/ap/vnv")
    qgmv710_xp_alt_led = uluaFind("tbm900/lights/ap/alt")
    qgmv710_xp_ap_led = uluaFind("tbm900/lights/ap/ap")
    qgmv710_xp_xfr_l_led = uluaFind("tbm900/lights/ap/comp_left")
    qgmv710_xp_bc_led = uluaFind("tbm900/lights/ap/bc")
    qgmv710_xp_apr_led = uluaFind("tbm900/lights/ap/apr")
elseif PLANE_ICAO == "C172" then
    qgmv710_xp_flc_led = uluaFind("sim/cockpit2/autopilot/speed_status")
    qgmv710_xp_vs_led = uluaFind("sim/cockpit2/autopilot/vvi_status")
    qgmv710_xp_yd_led = uluaFind("sim/cockpit/switches/yaw_damper_on")
    qgmv710_xp_xfr_r_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_bank_led = uluaFind("sim/cockpit2/autopilot/heading_status")
    qgmv710_xp_nav_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_hdg_led = uluaFind("sim/cockpit2/autopilot/heading_status")

    qgmv710_xp_vnv_led = uluaFind("sim/cockpit2/autopilot/vnav_status")
    qgmv710_xp_alt_led = uluaFind("sim/cockpit2/autopilot/altitude_hold_status")
    qgmv710_xp_ap_led = uluaFind("sim/cockpit2/autopilot/servos_on")
    qgmv710_xp_xfr_l_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_bc_led = uluaFind("sim/cockpit2/autopilot/backcourse_status")
    qgmv710_xp_apr_led = uluaFind("sim/cockpit2/autopilot/approach_status")
else
    qgmv710_xp_flc_led = uluaFind("sim/cockpit2/autopilot/speed_status")
    qgmv710_xp_vs_led = uluaFind("sim/cockpit2/autopilot/vvi_status")
    qgmv710_xp_yd_led = uluaFind("sim/cockpit/switches/yaw_damper_on")
    qgmv710_xp_xfr_r_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_bank_led = uluaFind("sim/cockpit2/autopilot/heading_status")
    qgmv710_xp_nav_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_hdg_led = uluaFind("sim/cockpit2/autopilot/heading_status")

    qgmv710_xp_vnv_led = uluaFind("sim/cockpit2/autopilot/vnav_status")
    qgmv710_xp_alt_led = uluaFind("sim/cockpit2/autopilot/altitude_hold_status")
    qgmv710_xp_ap_led = uluaFind("sim/cockpit2/autopilot/servos_on")
    qgmv710_xp_xfr_l_led = uluaFind("sim/cockpit2/autopilot/nav_status")
    qgmv710_xp_bc_led = uluaFind("sim/cockpit2/autopilot/backcourse_status")
    qgmv710_xp_apr_led = uluaFind("sim/cockpit2/autopilot/approach_status")
end

if ilua_hw_qgmc710_absent(FastTurnsPerSecond) then return end


if PLANE_ICAO == "B350" then
    uluaQmdevConfig(1, 'ROTATE;"i";18;19;10;1;0;0;360;"sim/cockpit/autopilot/heading"')
    uluaQmdevConfig(1, 'ROTATE;"i";20;21;10;1;2;0;360;"sim/cockpit/radios/nav1_obs_degm"')
    uluaQmdevConfig(1, 'ROTATE;"i";22;23;500;100;0;0;360;"sim/cockpit/autopilot/altitude"')
    uluaQmdevConfig(1, 'ROTATE;"i";26;27;10;1;2;0;360;"sim/cockpit/radios/nav2_obs_degm"')
    uluaQmdevConfig(1, 'ASSIGN;0;"KA350/cmd/cPanel/flightCP/hdg"')
    uluaQmdevConfig(1, 'ASSIGN;1;"KA350/cmd/cPanel/flightCP/appr"')
    uluaQmdevConfig(1, 'ASSIGN;2;"KA350/cmd/cPanel/flightCP/nav"')
    uluaQmdevConfig(1, 'ASSIGN;3;"KA350/cmd/cPanel/pilotDisplayCP/crsPre"')
    uluaQmdevConfig(1, 'ASSIGN;4;"KA350/cmd/cPanel/pilotDisplayCP/crsAct"')
    uluaQmdevConfig(1, 'ASSIGN;5;"KA350/cmd/cPanel/flightCP/alt"')
    uluaQmdevConfig(1, 'ASSIGN;6;"KA350/cmd/cPanel/flightCP/vs"')
    uluaQmdevConfig(1, 'ASSIGN;7;"tbm900/actuators/ap/flc"')
    uluaQmdevConfig(1, 'ASSIGN;8;"KA350/cmd/cPanel/flightCP/bc"')
    uluaQmdevConfig(1, 'ASSIGN;9;"KA350/cmd/cPanel/autopilotCP/softRide"')
    uluaQmdevConfig(1, 'ASSIGN;10;"KA350/cmd/cPanel/autopilotCP/apEng"')
    uluaQmdevConfig(1, 'ASSIGN;11;"KA350/cmd/cPanel/autopilotCP/yawEng"')
    uluaQmdevConfig(1, 'ASSIGN;12;"KA350/cmd/cPanel/flightCP/altSel"')
    uluaQmdevConfig(1, 'ASSIGN;13;"KA350/cmd/cPanel/flightCP/ias"')
    uluaQmdevConfig(1, 'ASSIGN;14;"sim/autopilot/heading_sync"')
    uluaQmdevConfig(1, 'ASSIGN;15;"KA350/cmd/cPanel/efisSCP/courseDirect"')
    uluaQmdevConfig(1, 'ASSIGN;16;"sim/GPS/g1000n3_hdg_sync"')
    uluaQmdevConfig(1, 'ASSIGN;17;"KA350/cmd/cPanel/efisSCP/navData"')
    uluaQmdevConfig(1, 'ASSIGN;18;"KA350/cmd/cPanel/efisSCP/headingInc"')
    uluaQmdevConfig(1, 'ASSIGN;19;"KA350/cmd/cPanel/efisSCP/headingDec"')
    uluaQmdevConfig(1, 'ASSIGN;20;"KA350/cmd/cPanel/efisSCP/courseInc"')
    uluaQmdevConfig(1, 'ASSIGN;21;"KA350/cmd/cPanel/efisSCP/courseDec"')
    uluaQmdevConfig(1, 'ASSIGN;22;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;23;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;24;"KA350/cmd/cPanel/autopilotCP/pitchSwitchDec"')
    uluaQmdevConfig(1, 'ASSIGN;25;"KA350/cmd/cPanel/autopilotCP/pitchSwitchInc"')
elseif PLANE_ICAO == "TBM9" then
    uluaQmdevConfig(1, 'ROTATE;"i";18;19;10;1;0;0;360;"tbm900/knobs/ap/hdg"')
    uluaQmdevConfig(1, 'ROTATE;"i";20;21;10;1;0;0;360;"tbm900/knobs/ap/crs1"')
    uluaQmdevConfig(1, 'ROTATE;"i";22;23;500;100;0;0;360;"tbm900/knobs/ap/alt"')
    uluaQmdevConfig(1, 'ROTATE;"i";26;27;10;1;0;0;360;"tbm900/knobs/ap/crs2"')
    uluaQmdevConfig(1, 'ASSIGN;0;"tbm900/actuators/ap/hdg"')
    uluaQmdevConfig(1, 'ASSIGN;1;"tbm900/actuators/ap/apr"')
    uluaQmdevConfig(1, 'ASSIGN;2;"tbm900/actuators/ap/nav"')
    uluaQmdevConfig(1, 'ASSIGN;3;"tbm900/actuators/ap/fd"')
    uluaQmdevConfig(1, 'ASSIGN;4;"tbm900/actuators/ap/xfr"')
    uluaQmdevConfig(1, 'ASSIGN;5;"tbm900/actuators/ap/alt"')
    uluaQmdevConfig(1, 'ASSIGN;6;"tbm900/actuators/ap/vs"')
    uluaQmdevConfig(1, 'ASSIGN;7;"tbm900/actuators/ap/flc"')
    uluaQmdevConfig(1, 'ASSIGN;8;"tbm900/actuators/ap/bc"')
    uluaQmdevConfig(1, 'ASSIGN;9;"tbm900/actuators/ap/bank"')
    uluaQmdevConfig(1, 'ASSIGN;10;"tbm900/actuators/ap/ap"')
    uluaQmdevConfig(1, 'ASSIGN;11;"tbm900/actuators/ap/yd"')
    uluaQmdevConfig(1, 'ASSIGN;12;"tbm900/actuators/ap/vnv"')
    uluaQmdevConfig(1, 'ASSIGN;13;"tbm900/actuators/ap/spd"')
    uluaQmdevConfig(1, 'ASSIGN;14;"tbm900/actuators/ap/hdg_sync"')
    uluaQmdevConfig(1, 'ASSIGN;15;"tbm900/actuators/ap/crs1_dr"')
    uluaQmdevConfig(1, 'ASSIGN;16;"sim/GPS/g1000n3_hdg_sync"')
    uluaQmdevConfig(1, 'ASSIGN;17;"tbm900/actuators/ap/crs2_dr"')
    uluaQmdevConfig(1, 'ASSIGN;18;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;19;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;20;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;21;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;22;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;23;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;24;"tbm900/actuators/ap/nose_up"')
    uluaQmdevConfig(1, 'ASSIGN;25;"tbm900/actuators/ap/nose_down"')
else
    uluaQmdevConfig(1, 'ROTATE;"i";18;19;10;1;0;0;360;"sim/cockpit/autopilot/heading_mag"')
    uluaQmdevConfig(1, 'ROTATE;"i";20;21;10;1;0;0;360;"sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot"')
    uluaQmdevConfig(1, 'ROTATE;"i";22;23;500;100;0;0;360;"sim/cockpit/autopilot/altitude"')
    uluaQmdevConfig(1, 'ASSIGN;0;"sim/autopilot/heading"')
    uluaQmdevConfig(1, 'ASSIGN;1;"sim/autopilot/approach"')
    uluaQmdevConfig(1, 'ASSIGN;2;"sim/autopilot/NAV"')
    uluaQmdevConfig(1, 'ASSIGN;3;"sim/autopilot/fdir_toggle"')
    uluaQmdevConfig(1, 'ASSIGN;4;"tbm900/actuators/ap/xfr"')
    uluaQmdevConfig(1, 'ASSIGN;5;"sim/autopilot/altitude_hold"')
    uluaQmdevConfig(1, 'ASSIGN;6;"sim/autopilot/vertical_speed"')
    uluaQmdevConfig(1, 'ASSIGN;7;"sim/autopilot/level_change"')
    uluaQmdevConfig(1, 'ASSIGN;8;"sim/autopilot/back_course"')
    uluaQmdevConfig(1, 'ASSIGN;9;"sim/autopilot/bank_limit_toggle"')
    uluaQmdevConfig(1, 'ASSIGN;10;"sim/autopilot/servos_toggle"')
    uluaQmdevConfig(1, 'ASSIGN;11;"sim/systems/yaw_damper_toggle"')
    uluaQmdevConfig(1, 'ASSIGN;12;"sim/autopilot/vnav"')
    uluaQmdevConfig(1, 'ASSIGN;13;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;14;"sim/autopilot/heading_sync"')
    uluaQmdevConfig(1, 'ASSIGN;15;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;16;"sim/GPS/g1000n3_hdg_sync"')
    uluaQmdevConfig(1, 'ASSIGN;17;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;18;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;19;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;20;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;21;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;22;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;23;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;24;"sim/autopilot/nose_up"')
    uluaQmdevConfig(1, 'ASSIGN;25;"sim/autopilot/nose_down"')
    uluaQmdevConfig(1, 'ASSIGN;26;"sim/none/none"')
    uluaQmdevConfig(1, 'ASSIGN;27;"sim/none/none"')
end



function QGMC710_LED_UPD()
    uluaSet(idr_qgmc710_hid_ledflc, ilua_01_ternary(qgmv710_xp_flc_led, 0))
    uluaSet(idr_qgmc710_hid_ledvs, ilua_01_ternary(qgmv710_xp_vs_led, 0))
    uluaSet(idr_qgmc710_hid_ledyd, ilua_01_ternary(qgmv710_xp_yd_led, 0))
    uluaSet(idr_qgmc710_hid_ledxfrr, ilua_01_ternary(qgmv710_xp_xfr_r_led, 0))
    uluaSet(idr_qgmc710_hid_ledbank, ilua_01_ternary(qgmv710_xp_bank_led, 0))
    uluaSet(idr_qgmc710_hid_lednav, ilua_01_ternary(qgmv710_xp_nav_led, 0))
    uluaSet(idr_qgmc710_hid_ledhdg, ilua_01_ternary(qgmv710_xp_hdg_led, 0))
    uluaSet(idr_qgmc710_hid_ledvnav, ilua_01_ternary(qgmv710_xp_vnv_led, 0))
    uluaSet(idr_qgmc710_hid_ledalt, ilua_01_ternary(qgmv710_xp_alt_led, 1))
    uluaSet(idr_qgmc710_hid_ledap, ilua_01_ternary(qgmv710_xp_ap_led, 0))
    uluaSet(idr_qgmc710_hid_ledxfrl, ilua_01_ternary(qgmv710_xp_xfr_l_led, 0))
    uluaSet(idr_qgmc710_hid_ledbc, ilua_01_ternary(qgmv710_xp_bc_led, 0))
    uluaSet(idr_qgmc710_hid_ledapr, ilua_01_ternary(qgmv710_xp_apr_led, 0))

    local led_br = math.floor(uluaGet(qgmv710_xp_cockpit_led) * 255.0)
    uluaSet(idr_qgmc710_hid_bright, led_br)
end

uluaAddDoLoop("QGMC710_LED_UPD()")
