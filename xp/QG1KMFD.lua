-- Driver for QG1K-MFD
-- Author: QuickMake
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-08-12, last modified: 2020-12-22
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
-- 2022-02-14 tested on Hot Start TBM-900 v1.1.13
--######################  Edit part  #####################
--此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节

local FastTurnsPerSecond = 40 --How many spins per second  is considered FAST?

--########################################################

----------------------  Edit the  DataRef for different Aircraft -----------------------

-------  Common Dataref -------------------------------
local dr_cockpit_led = uluaFind("sim/cockpit/electrical/cockpit_lights")

if PLANE_ICAO == "TBM9" then
    dr_QG1K_mfd_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")
elseif PLANE_ICAO == "C172" or PLANE_ICAO == "DA62" or PLANE_ICAO == "DR40" then
    dr_QG1K_mfd_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")
else
    dr_QG1K_mfd_brightness = uluaFind("sim/cockpit/electrical/instrument_brightness")
    dr_QG1K_avionics_on = uluaFind("sim/cockpit/electrical/avionics_on")
end

if ilua_hw_qg1k_mfd_absent(FastTurnsPerSecond) then
    return
end


if PLANE_ICAO == "TBM9" then
    uluaQmdevConfig(4, 'ROTATE;"f";8;9;5;1;0;0;360;"sim/cockpit/autopilot/heading_mag"')
    uluaQmdevConfig(4, 'ROTATE;"f";58;59;5;1;0;0;360;"sim/cockpit2/radios/actuators/hsi_obs_deg_mag_pilot"')
    uluaQmdevConfig(4, 'ASSIGN;0;"sim/GPS/g1000n3_nvol_dn"')
    uluaQmdevConfig(4, 'ASSIGN;1;"sim/GPS/g1000n3_nvol_up"')
    uluaQmdevConfig(4, 'ASSIGN;2;"sim/GPS/g1000n3_nav_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;3;"sim/GPS/g1000n3_nav_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;4;"sim/GPS/g1000n3_nav_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;5;"sim/GPS/g1000n3_nav_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;6;"sim/GPS/g1000n3_nav12"')
    uluaQmdevConfig(4, 'ASSIGN;7;"sim/GPS/g1000n3_nav_ff"')
    uluaQmdevConfig(4, 'ASSIGN;8;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;9;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;10;"tbm900/actuators/ap/hdg_sync"')
    uluaQmdevConfig(4, 'ASSIGN;11;"tbm900/actuators/ap/ap"')
    uluaQmdevConfig(4, 'ASSIGN;12;"tbm900/actuators/ap/fd"')
    uluaQmdevConfig(4, 'ASSIGN;13;"tbm900/actuators/ap/hdg"')
    uluaQmdevConfig(4, 'ASSIGN;14;"tbm900/actuators/ap/alt"')
    uluaQmdevConfig(4, 'ASSIGN;15;"tbm900/actuators/ap/nav"')
    uluaQmdevConfig(4, 'ASSIGN;16;"tbm900/actuators/ap/vnv"')
    uluaQmdevConfig(4, 'ASSIGN;17;"tbm900/actuators/ap/apr"')
    uluaQmdevConfig(4, 'ASSIGN;18;"tbm900/actuators/ap/bc"')
    uluaQmdevConfig(4, 'ASSIGN;19;"tbm900/actuators/ap/vs"')
    uluaQmdevConfig(4, 'ASSIGN;20;"tbm900/actuators/ap/nose_up"')
    uluaQmdevConfig(4, 'ASSIGN;21;"tbm900/actuators/ap/flc"')
    uluaQmdevConfig(4, 'ASSIGN;22;"tbm900/actuators/ap/nose_down"')
    uluaQmdevConfig(4, 'ASSIGN;24;"sim/GPS/g1000n3_alt_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;25;"sim/GPS/g1000n3_alt_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;26;"sim/GPS/g1000n3_alt_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;27;"sim/GPS/g1000n3_alt_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;28;"sim/GPS/g1000n3_softkey1"')
    uluaQmdevConfig(4, 'ASSIGN;29;"sim/GPS/g1000n3_softkey2"')
    uluaQmdevConfig(4, 'ASSIGN;30;"sim/GPS/g1000n3_softkey3"')
    uluaQmdevConfig(4, 'ASSIGN;31;"sim/GPS/g1000n3_softkey4"')
    uluaQmdevConfig(4, 'ASSIGN;32;"sim/GPS/g1000n3_softkey5"')
    uluaQmdevConfig(4, 'ASSIGN;33;"sim/GPS/g1000n3_softkey6"')
    uluaQmdevConfig(4, 'ASSIGN;34;"sim/GPS/g1000n3_softkey7"')
    uluaQmdevConfig(4, 'ASSIGN;35;"sim/GPS/g1000n3_softkey8"')
    uluaQmdevConfig(4, 'ASSIGN;36;"sim/GPS/g1000n3_softkey9"')
    uluaQmdevConfig(4, 'ASSIGN;37;"sim/GPS/g1000n3_softkey10"')
    uluaQmdevConfig(4, 'ASSIGN;38;"sim/GPS/g1000n3_softkey11"')
    uluaQmdevConfig(4, 'ASSIGN;39;"sim/GPS/g1000n3_softkey12"')
    uluaQmdevConfig(4, 'ASSIGN;40;"sim/GPS/g1000n3_fms_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;41;"sim/GPS/g1000n3_fms_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;42;"sim/GPS/g1000n3_fms_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;43;"sim/GPS/g1000n3_fms_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;44;"sim/GPS/g1000n3_cursor"')
    uluaQmdevConfig(4, 'ASSIGN;45;"sim/GPS/g1000n3_direct"')
    uluaQmdevConfig(4, 'ASSIGN;46;"sim/GPS/g1000n3_menu"')
    uluaQmdevConfig(4, 'ASSIGN;47;"sim/GPS/g1000n3_fpl"')
    uluaQmdevConfig(4, 'ASSIGN;48;"sim/GPS/g1000n3_proc"')
    uluaQmdevConfig(4, 'ASSIGN;49;"sim/GPS/g1000n3_clr"')
    uluaQmdevConfig(4, 'ASSIGN;50;"sim/GPS/g1000n3_ent"')
    uluaQmdevConfig(4, 'ASSIGN;51;"sim/GPS/g1000n3_pan_push"')
    uluaQmdevConfig(4, 'ASSIGN;52;"sim/GPS/g1000n3_pan_up"')
    uluaQmdevConfig(4, 'ASSIGN;53;"sim/GPS/g1000n3_pan_left"')
    uluaQmdevConfig(4, 'ASSIGN;54;"sim/GPS/g1000n3_pan_down"')
    uluaQmdevConfig(4, 'ASSIGN;55;"sim/GPS/g1000n3_pan_right"')
    uluaQmdevConfig(4, 'ASSIGN;56;"sim/GPS/g1000n3_range_down"')
    uluaQmdevConfig(4, 'ASSIGN;57;"sim/GPS/g1000n3_range_up"')
    uluaQmdevConfig(4, 'ASSIGN;58;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;59;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;60;"sim/GPS/g1000n3_baro_down"')
    uluaQmdevConfig(4, 'ASSIGN;61;"sim/GPS/g1000n3_baro_up"')
    uluaQmdevConfig(4, 'ASSIGN;62;"sim/GPS/g1000n3_crs_sync"')
    uluaQmdevConfig(4, 'ASSIGN;63;"sim/GPS/g1000n3_com12"')
    uluaQmdevConfig(4, 'ASSIGN;64;"sim/GPS/g1000n3_com_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;65;"sim/GPS/g1000n3_com_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;66;"sim/GPS/g1000n3_com_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;67;"sim/GPS/g1000n3_com_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;68;"sim/GPS/g1000n3_cvol_dn"')
    uluaQmdevConfig(4, 'ASSIGN;69;"sim/GPS/g1000n3_cvol_up"')
    uluaQmdevConfig(4, 'ASSIGN;70;"sim/GPS/g1000n3_cvol"')
    uluaQmdevConfig(4, 'ASSIGN;71;"sim/GPS/g1000n3_com_ff"')
    uluaQmdevConfig(4, 'ASSIGN;72;"sim/GPS/g1000n3_nvol"')
else
    uluaQmdevConfig(4, 'ROTATE;"f";8;9;5;1;0;0;360;"sim/cockpit/autopilot/heading_mag"')
    uluaQmdevConfig(4, 'ROTATE;"f";58;59;5;1;0;0;360;"sim/cockpit/radios/nav1_obs_degm"')
    uluaQmdevConfig(4, 'ASSIGN;0;"sim/GPS/g1000n3_nvol_dn"')
    uluaQmdevConfig(4, 'ASSIGN;1;"sim/GPS/g1000n3_nvol_up"')
    uluaQmdevConfig(4, 'ASSIGN;2;"sim/GPS/g1000n3_nav_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;3;"sim/GPS/g1000n3_nav_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;4;"sim/GPS/g1000n3_nav_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;5;"sim/GPS/g1000n3_nav_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;6;"sim/GPS/g1000n3_nav12"')
    uluaQmdevConfig(4, 'ASSIGN;7;"sim/GPS/g1000n3_nav_ff"')
    uluaQmdevConfig(4, 'ASSIGN;8;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;9;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;10;"sim/GPS/g1000n3_hdg_sync"')
    uluaQmdevConfig(4, 'ASSIGN;11;"sim/GPS/g1000n3_ap"')
    uluaQmdevConfig(4, 'ASSIGN;12;"sim/GPS/g1000n3_fd"')
    uluaQmdevConfig(4, 'ASSIGN;13;"sim/GPS/g1000n3_hdg"')
    uluaQmdevConfig(4, 'ASSIGN;14;"sim/GPS/g1000n3_alt"')
    uluaQmdevConfig(4, 'ASSIGN;15;"sim/GPS/g1000n3_nav"')
    uluaQmdevConfig(4, 'ASSIGN;16;"sim/GPS/g1000n3_vnv"')
    uluaQmdevConfig(4, 'ASSIGN;17;"sim/GPS/g1000n3_apr"')
    uluaQmdevConfig(4, 'ASSIGN;18;"sim/GPS/g1000n3_bc"')
    uluaQmdevConfig(4, 'ASSIGN;19;"sim/GPS/g1000n3_vs"')
    uluaQmdevConfig(4, 'ASSIGN;20;"sim/GPS/g1000n3_nose_up"')
    uluaQmdevConfig(4, 'ASSIGN;21;"sim/GPS/g1000n3_flc"')
    uluaQmdevConfig(4, 'ASSIGN;22;"sim/GPS/g1000n3_nose_down"')
    uluaQmdevConfig(4, 'ASSIGN;24;"sim/GPS/g1000n3_alt_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;25;"sim/GPS/g1000n3_alt_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;26;"sim/GPS/g1000n3_alt_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;27;"sim/GPS/g1000n3_alt_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;28;"sim/GPS/g1000n3_softkey1"')
    uluaQmdevConfig(4, 'ASSIGN;29;"sim/GPS/g1000n3_softkey2"')
    uluaQmdevConfig(4, 'ASSIGN;30;"sim/GPS/g1000n3_softkey3"')
    uluaQmdevConfig(4, 'ASSIGN;31;"sim/GPS/g1000n3_softkey4"')
    uluaQmdevConfig(4, 'ASSIGN;32;"sim/GPS/g1000n3_softkey5"')
    uluaQmdevConfig(4, 'ASSIGN;33;"sim/GPS/g1000n3_softkey6"')
    uluaQmdevConfig(4, 'ASSIGN;34;"sim/GPS/g1000n3_softkey7"')
    uluaQmdevConfig(4, 'ASSIGN;35;"sim/GPS/g1000n3_softkey8"')
    uluaQmdevConfig(4, 'ASSIGN;36;"sim/GPS/g1000n3_softkey9"')
    uluaQmdevConfig(4, 'ASSIGN;37;"sim/GPS/g1000n3_softkey10"')
    uluaQmdevConfig(4, 'ASSIGN;38;"sim/GPS/g1000n3_softkey11"')
    uluaQmdevConfig(4, 'ASSIGN;39;"sim/GPS/g1000n3_softkey12"')
    uluaQmdevConfig(4, 'ASSIGN;40;"sim/GPS/g1000n3_fms_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;41;"sim/GPS/g1000n3_fms_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;42;"sim/GPS/g1000n3_fms_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;43;"sim/GPS/g1000n3_fms_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;44;"sim/GPS/g1000n3_cursor"')
    uluaQmdevConfig(4, 'ASSIGN;45;"sim/GPS/g1000n3_direct"')
    uluaQmdevConfig(4, 'ASSIGN;46;"sim/GPS/g1000n3_menu"')
    uluaQmdevConfig(4, 'ASSIGN;47;"sim/GPS/g1000n3_fpl"')
    uluaQmdevConfig(4, 'ASSIGN;48;"sim/GPS/g1000n3_proc"')
    uluaQmdevConfig(4, 'ASSIGN;49;"sim/GPS/g1000n3_clr"')
    uluaQmdevConfig(4, 'ASSIGN;50;"sim/GPS/g1000n3_ent"')
    uluaQmdevConfig(4, 'ASSIGN;51;"sim/GPS/g1000n3_pan_push"')
    uluaQmdevConfig(4, 'ASSIGN;52;"sim/GPS/g1000n3_pan_up"')
    uluaQmdevConfig(4, 'ASSIGN;53;"sim/GPS/g1000n3_pan_left"')
    uluaQmdevConfig(4, 'ASSIGN;54;"sim/GPS/g1000n3_pan_down"')
    uluaQmdevConfig(4, 'ASSIGN;55;"sim/GPS/g1000n3_pan_right"')
    uluaQmdevConfig(4, 'ASSIGN;56;"sim/GPS/g1000n3_range_down"')
    uluaQmdevConfig(4, 'ASSIGN;57;"sim/GPS/g1000n3_range_up"')
    uluaQmdevConfig(4, 'ASSIGN;58;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;59;"sim/none/none"')
    uluaQmdevConfig(4, 'ASSIGN;60;"sim/GPS/g1000n3_baro_down"')
    uluaQmdevConfig(4, 'ASSIGN;61;"sim/GPS/g1000n3_baro_up"')
    uluaQmdevConfig(4, 'ASSIGN;62;"sim/GPS/g1000n3_crs_sync"')
    uluaQmdevConfig(4, 'ASSIGN;63;"sim/GPS/g1000n3_com12"')
    uluaQmdevConfig(4, 'ASSIGN;64;"sim/GPS/g1000n3_com_inner_down"')
    uluaQmdevConfig(4, 'ASSIGN;65;"sim/GPS/g1000n3_com_inner_up"')
    uluaQmdevConfig(4, 'ASSIGN;66;"sim/GPS/g1000n3_com_outer_down"')
    uluaQmdevConfig(4, 'ASSIGN;67;"sim/GPS/g1000n3_com_outer_up"')
    uluaQmdevConfig(4, 'ASSIGN;68;"sim/GPS/g1000n3_cvol_dn"')
    uluaQmdevConfig(4, 'ASSIGN;69;"sim/GPS/g1000n3_cvol_up"')
    uluaQmdevConfig(4, 'ASSIGN;70;"sim/GPS/g1000n3_cvol"')
    uluaQmdevConfig(4, 'ASSIGN;71;"sim/GPS/g1000n3_com_ff"')
    uluaQmdevConfig(4, 'ASSIGN;72;"sim/GPS/g1000n3_nvol"')

end

function qg1k_mfd_powoff()
    uluaSet(idr_qg1k_mfd_hid_bright, 0)
end

function qg1k_mfd_LED_UPD()
    local QG1K_avionics_on = uluaGet(dr_QG1K_avionics_on)
    if QG1K_avionics_on <= 0 then
        qg1k_mfd_powoff()
        return
    end

    if PLANE_ICAO == "TBM9" then
        local cockpit_led = uluaGet(dr_cockpit_led)
        local led_br = math.floor(cockpit_led * 255.0)
        uluaSet(idr_qg1k_mfd_hid_bright, led_br)
    else
        local led_br = 8
        local QG1K_mfd_brightness = uluaGet(dr_QG1K_mfd_brightness)
        if QG1K_mfd_brightness >= 0.1 then --set the  min brightness
            led_br = QG1K_mfd_brightness * 50
        end
        uluaSet(idr_qg1k_mfd_hid_bright, led_br)
    end
end

uluaAddDoLoop("qg1k_mfd_LED_UPD()")
