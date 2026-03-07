-- Driver for QG1K-PFD
-- Author: QuickMake
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-08-12 ,last modified:2020-12-22
--
-- for audio panel
-- Send 3 Bytes:
-- 1st Byte
---- B7   B6   B5   B4   B3      B2      B1     B0
---- BL   NAV1  DME  MKR COM2  COM2/MIC  COM1  COM1/MIC
-- 2nd Byte
---- B7 B6 B5 B4 B3 B2  B1   B0
---- X  X  X  X  X  X   NAV2 ADF
-- 3rd Byte
---- B7 B6 B5 B4 B3 B2 B1 B0
----  Brightness
--
-- Notes:
--BL:backlight  1=PC control ; 0=Manual control
-- backlight brightness value  0-255  (keep a low level to protect your eyes)
--**********************Copyright***********************--

-- modified by Wei Shuai <cpuwolf@gmail.com>
-- 2022-01-10 tested on Hot Start TBM-900 v1.1.13
--######################  Edit part  #####################
--此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节

local FastTurnsPerSecond = 30 --How many spins per second  is considered FAST?

--########################################################

----------------------  Edit the  DataRef for different Aircraft -----------------------

-------  Common Dataref -------------------------------
local dr_cockpit_led = uluaFind("sim/cockpit/electrical/cockpit_lights")

if PLANE_ICAO == "TBM9" then
    dr_QG1K_com_sele = uluaFind("sim/cockpit2/radios/actuators/audio_com_selection") -- COM1 MIC=6; COM2 MIC=7
    dr_QG1K_com1mic = uluaFind("tbm900/lights/audio1/com1_mic")
    dr_QG1K_com2mic = uluaFind("tbm900/lights/audio1/com2_mic")
    dr_QG1K_com1 = uluaFind("tbm900/lights/audio1/com1")
    dr_QG1K_com2 = uluaFind("tbm900/lights/audio1/com2")
    dr_QG1K_mkr = uluaFind("tbm900/lights/audio1/mkr_mute")
    dr_QG1K_dme = uluaFind("tbm900/lights/audio1/dme")
    dr_QG1K_nav1 = uluaFind("tbm900/lights/audio1/nav1")
    dr_QG1K_nav2 = uluaFind("tbm900/lights/audio1/nav2")
    dr_QG1K_adf = uluaFind("tbm900/lights/audio1/adf")
    dr_QG1K_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_battery_on = uluaFind("sim/cockpit/electrical/battery_on")
elseif PLANE_ICAO == "C172" or PLANE_ICAO == "DA62" or PLANE_ICAO == "DR40" then
    dr_QG1K_com_sele = uluaFind("sim/cockpit2/radios/actuators/audio_com_selection") -- COM1 MIC=6; COM2 MIC=7
    dr_QG1K_com1 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com1")
    dr_QG1K_com2 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com2")
    dr_QG1K_mkr = uluaFind("sim/cockpit2/radios/actuators/audio_marker_enabled")
    dr_QG1K_dme = uluaFind("sim/cockpit2/radios/actuators/audio_dme_enabled")
    dr_QG1K_nav1 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_nav1")
    dr_QG1K_nav2 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_nav2")
    dr_QG1K_adf = uluaFind("sim/cockpit2/radios/actuators/audio_selection_adf1")
    dr_QG1K_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_battery_on = uluaFind("sim/cockpit/electrical/battery_on")
else
    dr_QG1K_com_sele = uluaFind("sim/cockpit2/radios/actuators/audio_com_selection") -- COM1 MIC=6; COM2 MIC=7
    dr_QG1K_com1 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com1")
    dr_QG1K_com2 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_com2")
    dr_QG1K_mkr = uluaFind("sim/cockpit2/radios/actuators/audio_marker_enabled")
    dr_QG1K_dme = uluaFind("sim/cockpit2/radios/actuators/audio_dme_enabled")
    dr_QG1K_nav1 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_nav1")
    dr_QG1K_nav2 = uluaFind("sim/cockpit2/radios/actuators/audio_selection_nav2")
    dr_QG1K_adf = uluaFind("sim/cockpit2/radios/actuators/audio_selection_adf1")
    dr_QG1K_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_battery_on = uluaFind("sim/cockpit/electrical/battery_on")
end

if ilua_hw_qg1k_pfd_absent(FastTurnsPerSecond) then
    return
end


if PLANE_ICAO == "TBM9" then
    uluaQmdevConfig(3, 'ROTATE;"i";0;1;10;1;0;0;360;"sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot"')
    uluaQmdevConfig(3, 'ROTATE;"i";8;9;10;1;0;0;360;"tbm900/knobs/ap/hdg"')
    uluaQmdevConfig(3, 'ASSIGN;0;"tbm900/actuators/efis/pfd1_nav_vol_down"')
    uluaQmdevConfig(3, 'ASSIGN;1;"tbm900/actuators/efis/pfd1_nav_vol_up"')
    uluaQmdevConfig(3, 'ASSIGN;2;"sim/GPS/g1000n1_nav_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;3;"sim/GPS/g1000n1_nav_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;4;"sim/GPS/g1000n1_nav_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;5;"sim/GPS/g1000n1_nav_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;6;"sim/GPS/g1000n1_nav12"')
    uluaQmdevConfig(3, 'ASSIGN;7;"sim/GPS/g1000n1_nav_ff"')
    uluaQmdevConfig(3, 'ASSIGN;8;"sim/GPS/g1000n1_hdg_down"')
    uluaQmdevConfig(3, 'ASSIGN;9;"sim/GPS/g1000n1_hdg_up"')
    uluaQmdevConfig(3, 'ASSIGN;10;"tbm900/actuators/ap/hdg_sync"')
    uluaQmdevConfig(3, 'ASSIGN;11;"tbm900/actuators/ap/ap"')
    uluaQmdevConfig(3, 'ASSIGN;12;"tbm900/actuators/ap/fd"')
    uluaQmdevConfig(3, 'ASSIGN;13;"tbm900/actuators/ap/hdg"')
    uluaQmdevConfig(3, 'ASSIGN;14;"tbm900/actuators/ap/alt"')
    uluaQmdevConfig(3, 'ASSIGN;15;"tbm900/actuators/ap/nav"')
    uluaQmdevConfig(3, 'ASSIGN;16;"tbm900/actuators/ap/vnv"')
    uluaQmdevConfig(3, 'ASSIGN;17;"tbm900/actuators/ap/apr"')
    uluaQmdevConfig(3, 'ASSIGN;18;"tbm900/actuators/ap/bc"')
    uluaQmdevConfig(3, 'ASSIGN;19;"tbm900/actuators/ap/vs"')
    uluaQmdevConfig(3, 'ASSIGN;20;"tbm900/actuators/ap/nose_up"')
    uluaQmdevConfig(3, 'ASSIGN;21;"tbm900/actuators/ap/flc"')
    uluaQmdevConfig(3, 'ASSIGN;22;"tbm900/actuators/ap/nose_down"')
    uluaQmdevConfig(3, 'ASSIGN;24;"sim/GPS/g1000n1_alt_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;25;"sim/GPS/g1000n1_alt_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;26;"sim/GPS/g1000n1_alt_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;27;"sim/GPS/g1000n1_alt_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;28;"sim/GPS/g1000n1_softkey1"')
    uluaQmdevConfig(3, 'ASSIGN;29;"sim/GPS/g1000n1_softkey2"')
    uluaQmdevConfig(3, 'ASSIGN;30;"sim/GPS/g1000n1_softkey3"')
    uluaQmdevConfig(3, 'ASSIGN;31;"sim/GPS/g1000n1_softkey4"')
    uluaQmdevConfig(3, 'ASSIGN;32;"sim/GPS/g1000n1_softkey5"')
    uluaQmdevConfig(3, 'ASSIGN;33;"sim/GPS/g1000n1_softkey6"')
    uluaQmdevConfig(3, 'ASSIGN;34;"sim/GPS/g1000n1_softkey7"')
    uluaQmdevConfig(3, 'ASSIGN;35;"sim/GPS/g1000n1_softkey8"')
    uluaQmdevConfig(3, 'ASSIGN;36;"sim/GPS/g1000n1_softkey9"')
    uluaQmdevConfig(3, 'ASSIGN;37;"sim/GPS/g1000n1_softkey10"')
    uluaQmdevConfig(3, 'ASSIGN;38;"sim/GPS/g1000n1_softkey11"')
    uluaQmdevConfig(3, 'ASSIGN;39;"sim/GPS/g1000n1_softkey12"')
    uluaQmdevConfig(3, 'ASSIGN;40;"sim/GPS/g1000n1_fms_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;41;"sim/GPS/g1000n1_fms_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;42;"sim/GPS/g1000n1_fms_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;43;"sim/GPS/g1000n1_fms_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;44;"sim/GPS/g1000n1_cursor"')
    uluaQmdevConfig(3, 'ASSIGN;45;"sim/GPS/g1000n1_direct"')
    uluaQmdevConfig(3, 'ASSIGN;46;"sim/GPS/g1000n1_menu"')
    uluaQmdevConfig(3, 'ASSIGN;47;"sim/GPS/g1000n1_fpl"')
    uluaQmdevConfig(3, 'ASSIGN;48;"sim/GPS/g1000n1_proc"')
    uluaQmdevConfig(3, 'ASSIGN;49;"sim/GPS/g1000n1_clr"')
    uluaQmdevConfig(3, 'ASSIGN;50;"sim/GPS/g1000n1_ent"')
    uluaQmdevConfig(3, 'ASSIGN;51;"sim/GPS/g1000n1_pan_push"')
    uluaQmdevConfig(3, 'ASSIGN;52;"sim/GPS/g1000n1_pan_up"')
    uluaQmdevConfig(3, 'ASSIGN;53;"sim/GPS/g1000n1_pan_left"')
    uluaQmdevConfig(3, 'ASSIGN;54;"sim/GPS/g1000n1_pan_down"')
    uluaQmdevConfig(3, 'ASSIGN;55;"sim/GPS/g1000n1_pan_right"')
    uluaQmdevConfig(3, 'ASSIGN;56;"sim/GPS/g1000n1_range_down"')
    uluaQmdevConfig(3, 'ASSIGN;57;"sim/GPS/g1000n1_range_up"')
    uluaQmdevConfig(3, 'ASSIGN;58;"sim/GPS/g1000n1_crs_down"')
    uluaQmdevConfig(3, 'ASSIGN;59;"sim/GPS/g1000n1_crs_up"')
    uluaQmdevConfig(3, 'ASSIGN;60;"sim/GPS/g1000n1_baro_down"')
    uluaQmdevConfig(3, 'ASSIGN;61;"sim/GPS/g1000n1_baro_up"')
    uluaQmdevConfig(3, 'ASSIGN;62;"tbm900/actuators/efis/pfd1_baro_push"')
    uluaQmdevConfig(3, 'ASSIGN;63;"sim/GPS/g1000n1_com12"')
    uluaQmdevConfig(3, 'ASSIGN;64;"sim/GPS/g1000n1_com_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;65;"sim/GPS/g1000n1_com_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;66;"sim/GPS/g1000n1_com_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;67;"sim/GPS/g1000n1_com_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;68;"tbm900/actuators/efis/pfd1_com_vol_down"')
    uluaQmdevConfig(3, 'ASSIGN;69;"tbm900/actuators/efis/pfd1_com_vol_up"')
    uluaQmdevConfig(3, 'ASSIGN;70;"sim/GPS/g1000n1_cvol"')
    uluaQmdevConfig(3, 'ASSIGN;71;"sim/GPS/g1000n1_com_ff"')
    uluaQmdevConfig(3, 'ASSIGN;72;"sim/GPS/g1000n1_nvol"')
    uluaQmdevConfig(3, 'ASSIGN;73;"tbm900/actuators/audio1/com1_mic"')
    uluaQmdevConfig(3, 'ASSIGN;74;"tbm900/actuators/audio1/com1"')
    uluaQmdevConfig(3, 'ASSIGN;75;"tbm900/actuators/audio1/com2_mic"')
    uluaQmdevConfig(3, 'ASSIGN;76;"tbm900/actuators/audio1/com2"')
    uluaQmdevConfig(3, 'ASSIGN;77;"tbm900/actuators/audio1/mkr_mute"')
    uluaQmdevConfig(3, 'ASSIGN;78;"tbm900/actuators/audio1/dme"')
    uluaQmdevConfig(3, 'ASSIGN;79;"tbm900/actuators/audio1/nav1"')
    uluaQmdevConfig(3, 'ASSIGN;80;"tbm900/actuators/audio1/adf"')
    uluaQmdevConfig(3, 'ASSIGN;81;"tbm900/actuators/audio1/nav2"')
    uluaQmdevConfig(3, 'ASSIGN;82;"tbm900/switches/efis/rev_left"')
else
    uluaQmdevConfig(3, 'ROTATE;"f";8;9;5;1;0;0;360;"sim/cockpit/autopilot/heading_mag"')
    uluaQmdevConfig(3, 'ROTATE;"f";58;59;5;1;0;0;360;"sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot"')
    uluaQmdevConfig(3, 'ASSIGN;0;"sim/GPS/g1000n1_nvol_dn"')
    uluaQmdevConfig(3, 'ASSIGN;1;"sim/GPS/g1000n1_nvol_up"')
    uluaQmdevConfig(3, 'ASSIGN;2;"sim/GPS/g1000n1_nav_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;3;"sim/GPS/g1000n1_nav_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;4;"sim/GPS/g1000n1_nav_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;5;"sim/GPS/g1000n1_nav_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;6;"sim/GPS/g1000n1_nav12"')
    uluaQmdevConfig(3, 'ASSIGN;7;"sim/GPS/g1000n1_nav_ff"')
    uluaQmdevConfig(3, 'ASSIGN;8;"sim/none/none"')
    uluaQmdevConfig(3, 'ASSIGN;9;"sim/none/none"')
    uluaQmdevConfig(3, 'ASSIGN;10;"sim/GPS/g1000n1_hdg_sync"')
    uluaQmdevConfig(3, 'ASSIGN;11;"sim/GPS/g1000n1_ap"')
    uluaQmdevConfig(3, 'ASSIGN;12;"sim/GPS/g1000n1_fd"')
    uluaQmdevConfig(3, 'ASSIGN;13;"sim/GPS/g1000n1_hdg"')
    uluaQmdevConfig(3, 'ASSIGN;14;"sim/GPS/g1000n1_alt"')
    uluaQmdevConfig(3, 'ASSIGN;15;"sim/GPS/g1000n1_nav"')
    uluaQmdevConfig(3, 'ASSIGN;16;"sim/GPS/g1000n1_vnv"')
    uluaQmdevConfig(3, 'ASSIGN;17;"sim/GPS/g1000n1_apr"')
    uluaQmdevConfig(3, 'ASSIGN;18;"sim/GPS/g1000n1_bc"')
    uluaQmdevConfig(3, 'ASSIGN;19;"sim/GPS/g1000n1_vs"')
    uluaQmdevConfig(3, 'ASSIGN;20;"sim/GPS/g1000n1_nose_up"')
    uluaQmdevConfig(3, 'ASSIGN;21;"sim/GPS/g1000n1_flc"')
    uluaQmdevConfig(3, 'ASSIGN;22;"sim/GPS/g1000n1_nose_down"')
    uluaQmdevConfig(3, 'ASSIGN;24;"sim/GPS/g1000n1_alt_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;25;"sim/GPS/g1000n1_alt_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;26;"sim/GPS/g1000n1_alt_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;27;"sim/GPS/g1000n1_alt_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;28;"sim/GPS/g1000n1_softkey1"')
    uluaQmdevConfig(3, 'ASSIGN;29;"sim/GPS/g1000n1_softkey2"')
    uluaQmdevConfig(3, 'ASSIGN;30;"sim/GPS/g1000n1_softkey3"')
    uluaQmdevConfig(3, 'ASSIGN;31;"sim/GPS/g1000n1_softkey4"')
    uluaQmdevConfig(3, 'ASSIGN;32;"sim/GPS/g1000n1_softkey5"')
    uluaQmdevConfig(3, 'ASSIGN;33;"sim/GPS/g1000n1_softkey6"')
    uluaQmdevConfig(3, 'ASSIGN;34;"sim/GPS/g1000n1_softkey7"')
    uluaQmdevConfig(3, 'ASSIGN;35;"sim/GPS/g1000n1_softkey8"')
    uluaQmdevConfig(3, 'ASSIGN;36;"sim/GPS/g1000n1_softkey9"')
    uluaQmdevConfig(3, 'ASSIGN;37;"sim/GPS/g1000n1_softkey10"')
    uluaQmdevConfig(3, 'ASSIGN;38;"sim/GPS/g1000n1_softkey11"')
    uluaQmdevConfig(3, 'ASSIGN;39;"sim/GPS/g1000n1_softkey12"')
    uluaQmdevConfig(3, 'ASSIGN;40;"sim/GPS/g1000n1_fms_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;41;"sim/GPS/g1000n1_fms_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;42;"sim/GPS/g1000n1_fms_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;43;"sim/GPS/g1000n1_fms_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;44;"sim/GPS/g1000n1_cursor"')
    uluaQmdevConfig(3, 'ASSIGN;45;"sim/GPS/g1000n1_direct"')
    uluaQmdevConfig(3, 'ASSIGN;46;"sim/GPS/g1000n1_menu"')
    uluaQmdevConfig(3, 'ASSIGN;47;"sim/GPS/g1000n1_fpl"')
    uluaQmdevConfig(3, 'ASSIGN;48;"sim/GPS/g1000n1_proc"')
    uluaQmdevConfig(3, 'ASSIGN;49;"sim/GPS/g1000n1_clr"')
    uluaQmdevConfig(3, 'ASSIGN;50;"sim/GPS/g1000n1_ent"')
    uluaQmdevConfig(3, 'ASSIGN;51;"sim/GPS/g1000n1_pan_push"')
    uluaQmdevConfig(3, 'ASSIGN;52;"sim/GPS/g1000n1_pan_up"')
    uluaQmdevConfig(3, 'ASSIGN;53;"sim/GPS/g1000n1_pan_left"')
    uluaQmdevConfig(3, 'ASSIGN;54;"sim/GPS/g1000n1_pan_down"')
    uluaQmdevConfig(3, 'ASSIGN;55;"sim/GPS/g1000n1_pan_right"')
    uluaQmdevConfig(3, 'ASSIGN;56;"sim/GPS/g1000n1_range_down"')
    uluaQmdevConfig(3, 'ASSIGN;57;"sim/GPS/g1000n1_range_up"')
    uluaQmdevConfig(3, 'ASSIGN;58;"sim/none/none"')
    uluaQmdevConfig(3, 'ASSIGN;59;"sim/none/none"')
    uluaQmdevConfig(3, 'ASSIGN;60;"sim/GPS/g1000n1_baro_down"')
    uluaQmdevConfig(3, 'ASSIGN;61;"sim/GPS/g1000n1_baro_up"')
    uluaQmdevConfig(3, 'ASSIGN;62;"sim/GPS/g1000n1_crs_sync"')
    uluaQmdevConfig(3, 'ASSIGN;63;"sim/GPS/g1000n1_com12"')
    uluaQmdevConfig(3, 'ASSIGN;64;"sim/GPS/g1000n1_com_inner_down"')
    uluaQmdevConfig(3, 'ASSIGN;65;"sim/GPS/g1000n1_com_inner_up"')
    uluaQmdevConfig(3, 'ASSIGN;66;"sim/GPS/g1000n1_com_outer_down"')
    uluaQmdevConfig(3, 'ASSIGN;67;"sim/GPS/g1000n1_com_outer_up"')
    uluaQmdevConfig(3, 'ASSIGN;68;"sim/GPS/g1000n1_cvol_dn"')
    uluaQmdevConfig(3, 'ASSIGN;69;"sim/GPS/g1000n1_cvol_up"')
    uluaQmdevConfig(3, 'ASSIGN;70;"sim/GPS/g1000n1_cvol"')
    uluaQmdevConfig(3, 'ASSIGN;71;"sim/GPS/g1000n1_com_ff"')
    uluaQmdevConfig(3, 'ASSIGN;72;"sim/GPS/g1000n1_nvol"')
    uluaQmdevConfig(3, 'ASSIGN;73;"sim/audio_panel/transmit_audio_com1"')
    uluaQmdevConfig(3, 'ASSIGN;74;"sim/audio_panel/monitor_audio_com1"')
    uluaQmdevConfig(3, 'ASSIGN;75;"sim/audio_panel/transmit_audio_com2"')
    uluaQmdevConfig(3, 'ASSIGN;76;"sim/audio_panel/monitor_audio_com2"')
    uluaQmdevConfig(3, 'ASSIGN;77;"sim/audio_panel/monitor_audio_mkr"')
    uluaQmdevConfig(3, 'ASSIGN;78;"sim/audio_panel/monitor_audio_dme"')
    uluaQmdevConfig(3, 'ASSIGN;79;"sim/audio_panel/monitor_audio_nav1"')
    uluaQmdevConfig(3, 'ASSIGN;80;"sim/audio_panel/monitor_audio_adf1"')
    uluaQmdevConfig(3, 'ASSIGN;81;"sim/audio_panel/monitor_audio_nav2"')
    uluaQmdevConfig(3, 'ASSIGN;82;"sim/GPS/G1000_display_reversion"')


end

function qg1k_pfd_powoff()
    --uluaSet(idr_qg1k_pfd_hid_leds, 0)
    uluaSet(idr_qg1k_pfd_hid_lednav1, 0)
    uluaSet(idr_qg1k_pfd_hid_leddme, 0)
    uluaSet(idr_qg1k_pfd_hid_ledmkr, 0)
    uluaSet(idr_qg1k_pfd_hid_ledcom2, 0)

    uluaSet(idr_qg1k_pfd_hid_ledcom1, 0)

    uluaSet(idr_qg1k_pfd_hid_ledvadf, 0)
    uluaSet(idr_qg1k_pfd_hid_lednav2, 0)

    uluaSet(idr_qg1k_pfd_hid_ledcom1mic, 0)
    uluaSet(idr_qg1k_pfd_hid_ledcom2mic, 0)

    uluaSet(idr_qg1k_pfd_hid_bright, 0)
end

function qg1k_pfd_tbm9_audio()
    local cockpit_led = uluaGet(dr_cockpit_led)
    uluaSet(idr_qg1k_pfd_hid_ledcom1mic, uluaGet(dr_QG1K_com1mic))
    uluaSet(idr_qg1k_pfd_hid_ledcom2mic, uluaGet(dr_QG1K_com2mic))

    local led_br = math.floor(cockpit_led * 255.0)
    uluaSet(idr_qg1k_pfd_hid_bright, led_br)
end

function qg1k_pfd_ga_audio()
    local QG1K_com_sele = uluaGet(dr_QG1K_com_sele)
    if QG1K_com_sele == 6 then
        uluaSet(idr_qg1k_pfd_hid_ledcom1mic, 1)
        uluaSet(idr_qg1k_pfd_hid_ledcom2mic, 0)
    elseif QG1K_com_sele == 7 then
        uluaSet(idr_qg1k_pfd_hid_ledcom1mic, 0)
        uluaSet(idr_qg1k_pfd_hid_ledcom2mic, 1)
    end
    local led_br = 8
    if uluaGet(dr_QG1K_brightness) >= 0.1 then --set the  min brightness
        led_br = uluaGet(dr_QG1K_brightness) * 50
    end
    uluaSet(idr_qg1k_pfd_hid_bright, led_br)
end

local qg1k_pfd_audio_func
if PLANE_ICAO == "TBM9" then
    qg1k_pfd_audio_func = qg1k_pfd_tbm9_audio
else
    qg1k_pfd_audio_func = qg1k_pfd_ga_audio	
end

function qg1k_pfd_LED_UPD()
    if uluaGet(dr_QG1K_battery_on) <= 0 then
        qg1k_pfd_powoff()
        return
    end
    uluaSet(idr_qg1k_pfd_hid_lednav1, uluaGet(dr_QG1K_nav1))
    uluaSet(idr_qg1k_pfd_hid_leddme, uluaGet(dr_QG1K_dme))
    uluaSet(idr_qg1k_pfd_hid_ledmkr, uluaGet(dr_QG1K_mkr))
    uluaSet(idr_qg1k_pfd_hid_ledcom2, uluaGet(dr_QG1K_com2))

    uluaSet(idr_qg1k_pfd_hid_ledcom1, uluaGet(dr_QG1K_com1))

    uluaSet(idr_qg1k_pfd_hid_ledvadf, uluaGet(dr_QG1K_adf))
    uluaSet(idr_qg1k_pfd_hid_lednav2, uluaGet(dr_QG1K_nav2))

    qg1k_pfd_audio_func()
end

uluaAddDoLoop("qg1k_pfd_LED_UPD()")
