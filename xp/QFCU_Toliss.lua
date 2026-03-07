-- **********************************************************************************************************--
-- QFCU Driver for Toliss
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2021-02-10  last modified:2022-03-16  test with Toliss A321,A319,A346 Xplane 11.53
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2021-04-25
-- 2021-12-30 tested on Toliss A319 v1.6.3
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBrightness = 100 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- ###############################################################################################

if ilua_is_acftitle_excluded("A3") or ilua_is_acfpath_excluded("toliss") then
    if ilua_is_acftitle_excluded("A2") or ilua_is_acfpath_excluded("toliss") then
        return
    end
end


-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

-- LED Indicator light
-- fcu
local dr_qfcu_airspeed = iDataRef:New("sim/cockpit2/autopilot/airspeed_dial_kts_mach")
local dr_qfcu_is_mach = iDataRef:New("sim/cockpit2/autopilot/airspeed_is_mach")
local dr_qfcu_heading = iDataRef:New("sim/cockpit/autopilot/heading_mag")
local dr_qfcu_hdgtrkmode = iDataRef:New("AirbusFBW/HDGTRKmode")
local dr_qfcu_altitude = iDataRef:New("sim/cockpit/autopilot/altitude")
local dr_qfcu_vs = iDataRef:New("sim/cockpit/autopilot/vertical_velocity")
local dr_qfcu_spddashed = iDataRef:New("AirbusFBW/SPDdashed")
local dr_qfcu_hdgdashed = iDataRef:New("AirbusFBW/HDGdashed")
local dr_qfcu_vsdashed = iDataRef:New("AirbusFBW/VSdashed")
local dr_qfcu_altmanaged = iDataRef:New("AirbusFBW/ALTmanaged")
local dr_qfcu_is_spdmgd = iDataRef:New("AirbusFBW/SPDmanaged")
local dr_qfcu_is_hdgmgd = iDataRef:New("AirbusFBW/HDGmanaged")

-- efis capt
local dr_qfcu_c_cstr = iDataRef:New("AirbusFBW/NDShowCSTRCapt")
local dr_qfcu_c_wpt = iDataRef:New("AirbusFBW/NDShowWPTCapt")
local dr_qfcu_c_vord = iDataRef:New("AirbusFBW/NDShowVORDCapt")
local dr_qfcu_c_ndb = iDataRef:New("AirbusFBW/NDShowNDBCapt")
local dr_qfcu_c_arpt = iDataRef:New("AirbusFBW/NDShowARPTCapt")
local dr_qfcu_c_fd = iDataRef:New("AirbusFBW/FD1Engage")
local dr_qfcu_c_ils = iDataRef:New("AirbusFBW/ILSonCapt")

local dr_qfcu_c_baro = iDataRef:New("sim/cockpit/misc/barometer_setting")
local dr_qfcu_c_barounit = iDataRef:New("AirbusFBW/BaroUnitCapt")
local dr_qfcu_c_barostd = iDataRef:New("AirbusFBW/BaroStdCapt")

-- EFIS FO
local dr_qfcu_f_cstr = iDataRef:New("AirbusFBW/NDShowCSTRFO")
local dr_qfcu_f_wpt = iDataRef:New("AirbusFBW/NDShowWPTFO")
local dr_qfcu_f_vord = iDataRef:New("AirbusFBW/NDShowVORDFO")
local dr_qfcu_f_ndb = iDataRef:New("AirbusFBW/NDShowNDBFO")
local dr_qfcu_f_arpt = iDataRef:New("AirbusFBW/NDShowARPTFO")
local dr_qfcu_f_fd = iDataRef:New("AirbusFBW/FD2Engage")
local dr_qfcu_f_ils = iDataRef:New("AirbusFBW/ILSonFO")

local dr_qfcu_f_baro = iDataRef:New("sim/cockpit/misc/barometer_setting2")
local dr_qfcu_f_barounit = iDataRef:New("AirbusFBW/BaroUnitFO")
local dr_qfcu_f_barostd = iDataRef:New("AirbusFBW/BaroStdFO")

local dr_qfcu_ap1 = iDataRef:New("AirbusFBW/AP1Engage")
local dr_qfcu_ap2 = iDataRef:New("AirbusFBW/AP2Engage")
local dr_qfcu_athr = iDataRef:New("AirbusFBW/ATHRmode")
local dr_qfcu_loc = iDataRef:New("AirbusFBW/LOCilluminated")
local dr_qfcu_exped = iDataRef:New("AirbusFBW/APVerticalMode")
local dr_qfcu_appr = iDataRef:New("AirbusFBW/APPRilluminated")

-- brightness  AirbusFBW/ALT100_1000
-- local qfcu_fcu_lightDisp = 0
if not uluaFind("AirbusFBW/FCUIntegralBrightness") then
    dr_qfcu_fcu_light = iDataRef:New("AirbusFBW/PanelBrightnessLevel") -- 0~1
else
    dr_qfcu_fcu_light = iDataRef:New("AirbusFBW/FCUIntegralBrightness") -- 0~1
end
local dr_qfcu_fcu_lightDisp = iDataRef:New("AirbusFBW/SupplLightLevelRehostats[1]") -- 0~1
-- annun test mode
local dr_qfcu_fcu_test = iDataRef:New("AirbusFBW/AnnunMode") -- 0: DIM 1: BRT 2: test mode
-- dr_qfcu_fcu_power = iDataRef:New( 'sim/cockpit/electrical/cockpit_lights') -- > 0.5
local dr_qfcu_fcu_power = iDataRef:New("AirbusFBW/FCUAvail") -- 0: OFF  1：ON
local dr_qfcu_alt_unit = iDataRef:New("AirbusFBW/ALT100_1000") -- 0: 100  1：1000

----------------------------  Display Dataref Set End ------------------------------------

qfcu:CfgEncFull(16, 17, "cpuwolf/qmdev/QFCU/condbtn[16]" , 100, 100, 0, -39500, 39500)
qfcu:CfgEncFull(46, 47, "cpuwolf/qmdev/QFCU/condbtn[46]" , 1, 10, 0, -39500, 39500)
qfcu:CfgEncFull(78, 79, "cpuwolf/qmdev/QFCU/condbtn[78]" , 1, 10, 0, -39500, 39500)
qfcu:CfgCmd(0, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_down")
qfcu:CfgCmd(1, "sim/GPS/g430n2_msg", "sim/autopilot/airspeed_up")
qfcu:CfgCmd(2, "sim/GPS/g430n2_msg", "AirbusFBW/PushSPDSel")
qfcu:CfgCmd(3, "sim/GPS/g430n2_msg", "AirbusFBW/PullSPDSel")
qfcu:CfgCmd(4, "sim/GPS/g430n2_msg", "sim/autopilot/heading_down")
qfcu:CfgCmd(5, "sim/GPS/g430n2_msg", "sim/autopilot/heading_up")
qfcu:CfgCmd(6, "sim/GPS/g430n2_msg", "AirbusFBW/PushHDGSel")
qfcu:CfgCmd(7, "sim/GPS/g430n2_msg", "AirbusFBW/PullHDGSel")
qfcu:CfgCmd(8, "sim/GPS/g430n2_msg", "AirbusFBW/LOCbutton")
qfcu:CfgCmd(9, "sim/GPS/g430n2_msg", "toliss_airbus/ap2_push")
qfcu:CfgCmd(10, "sim/GPS/g430n2_msg", "toliss_airbus/ap1_push")
qfcu:CfgCmd(11, "sim/GPS/g430n2_msg", "AirbusFBW/ATHRbutton")
qfcu:CfgCmd(12, "sim/GPS/g430n2_msg", "AirbusFBW/EXPEDbutton")
qfcu:CfgCmd(13, "sim/GPS/g430n2_msg", "AirbusFBW/APPRbutton")
qfcu:CfgCmd(14, "sim/GPS/g430n2_msg", "toliss_airbus/dispcommands/MetricAltitudeSwitch")
qfcu:CfgVal(15, "AirbusFBW/ALT100_1000", 0, 1)
qfcu:CfgCmd(18, "sim/GPS/g430n2_msg", "AirbusFBW/PushAltitude")
qfcu:CfgCmd(19, "sim/GPS/g430n2_msg", "AirbusFBW/PullAltitude")
qfcu:CfgCmd(20, "sim/GPS/g430n2_msg", "sim/autopilot/vertical_speed_down")
qfcu:CfgCmd(21, "sim/GPS/g430n2_msg", "sim/autopilot/vertical_speed_up")
qfcu:CfgCmd(22, "sim/GPS/g430n2_msg", "AirbusFBW/PushVSSel")
qfcu:CfgCmd(23, "sim/GPS/g430n2_msg", "AirbusFBW/PullVSSel")
qfcu:CfgVal(24, "AirbusFBW/NDmodeCapt", 0, nil)
qfcu:CfgVal(25, "AirbusFBW/NDmodeCapt", 1, nil)
qfcu:CfgVal(26, "AirbusFBW/NDmodeCapt", 2, nil)
qfcu:CfgVal(27, "AirbusFBW/NDmodeCapt", 3, nil)
qfcu:CfgVal(28, "AirbusFBW/NDmodeCapt", 4, nil)
qfcu:CfgVal(29, "AirbusFBW/NDrangeCapt", 0, nil)
qfcu:CfgVal(30, "AirbusFBW/NDrangeCapt", 1, nil)
qfcu:CfgVal(31, "AirbusFBW/NDrangeCapt", 2, nil)
qfcu:CfgVal(32, "AirbusFBW/NDrangeCapt", 3, nil)
qfcu:CfgVal(33, "AirbusFBW/NDrangeCapt", 4, nil)
qfcu:CfgVal(34, "AirbusFBW/NDrangeCapt", 5, nil)
qfcu:CfgValT(35, "AirbusFBW/NDShowCSTRCapt")
qfcu:CfgValT(36, "AirbusFBW/NDShowWPTCapt")
qfcu:CfgValT(37, "AirbusFBW/NDShowVORDCapt")
qfcu:CfgValT(38, "AirbusFBW/NDShowNDBCapt")
qfcu:CfgValT(39, "AirbusFBW/NDShowARPTCapt")
qfcu:CfgCmd(40, "sim/GPS/g430n2_msg", "toliss_airbus/fd1_push")
qfcu:CfgCmd(41, "sim/GPS/g430n2_msg", "toliss_airbus/dispcommands/CaptLSButtonPush")
qfcu:CfgVal(42, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 0, 1)
qfcu:CfgVal(43, "sim/cockpit2/EFIS/EFIS_1_selection_pilot", 2, 1)
qfcu:CfgVal(44, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 0, 1)
qfcu:CfgVal(45, "sim/cockpit2/EFIS/EFIS_2_selection_pilot", 2, 1)
-- qfcu:CfgCmd(46, "sim/GPS/g430n2_msg", "sim/instruments/barometer_down")
-- qfcu:CfgCmd(47, "sim/GPS/g430n2_msg", "sim/instruments/barometer_up")
qfcu:CfgVal(48, "AirbusFBW/BaroStdCapt", 0, nil)
qfcu:CfgVal(49, "AirbusFBW/BaroStdCapt", 1, nil)
qfcu:CfgVal(50, "AirbusFBW/BaroUnitCapt", 0, 1)
qfcu:CfgVal(51, "AirbusFBW/BaroStdFO", 0, nil)
qfcu:CfgVal(52, "AirbusFBW/BaroStdFO", 1, nil)
qfcu:CfgVal(53, "AirbusFBW/BaroUnitFO", 0, 1)
qfcu:CfgCmd(54, "sim/GPS/g430n2_msg", "toliss_airbus/dispcommands/HeadingTrackModeSwitch")
qfcu:CfgCmd(55, "sim/GPS/g430n2_msg", "sim/autopilot/knots_mach_toggle")
qfcu:CfgVal(56, "AirbusFBW/NDmodeFO", 0, nil)
qfcu:CfgVal(57, "AirbusFBW/NDmodeFO", 1, nil)
qfcu:CfgVal(58, "AirbusFBW/NDmodeFO", 2, nil)
qfcu:CfgVal(59, "AirbusFBW/NDmodeFO", 3, nil)
qfcu:CfgVal(60, "AirbusFBW/NDmodeFO", 4, nil)
qfcu:CfgVal(61, "AirbusFBW/NDrangeFO", 0, nil)
qfcu:CfgVal(62, "AirbusFBW/NDrangeFO", 1, nil)
qfcu:CfgVal(63, "AirbusFBW/NDrangeFO", 2, nil)
qfcu:CfgVal(64, "AirbusFBW/NDrangeFO", 3, nil)
qfcu:CfgVal(65, "AirbusFBW/NDrangeFO", 4, nil)
qfcu:CfgVal(66, "AirbusFBW/NDrangeFO", 5, nil)
qfcu:CfgValT(67, "AirbusFBW/NDShowCSTRFO")
qfcu:CfgValT(68, "AirbusFBW/NDShowWPTFO")
qfcu:CfgValT(69, "AirbusFBW/NDShowVORDFO")
qfcu:CfgValT(70, "AirbusFBW/NDShowNDBFO")
qfcu:CfgValT(71, "AirbusFBW/NDShowARPTFO")
qfcu:CfgCmd(72, "sim/GPS/g430n2_msg", "toliss_airbus/fd2_push")
qfcu:CfgCmd(73, "sim/GPS/g430n2_msg", "toliss_airbus/dispcommands/CoLSButtonPush")
qfcu:CfgVal(74, "sim/cockpit2/EFIS/EFIS_1_selection_copilot", 0, 1)
qfcu:CfgVal(75, "sim/cockpit2/EFIS/EFIS_1_selection_copilot", 2, 1)
qfcu:CfgVal(76, "sim/cockpit2/EFIS/EFIS_2_selection_copilot", 0, 1)
qfcu:CfgVal(77, "sim/cockpit2/EFIS/EFIS_2_selection_copilot", 2, 1)
-- qfcu:CfgCmd(78, "sim/GPS/g430n2_msg", "sim/instruments/barometer_copilot_down")
-- qfcu:CfgCmd(79, "sim/GPS/g430n2_msg", "sim/instruments/barometer_copilot_up")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function digi_disp_set_LEDS_fcu()
    local qfcu_ap1 = dr_qfcu_ap1:Get()
    local qfcu_ap2 = dr_qfcu_ap2:Get()
    local qfcu_athr = dr_qfcu_athr:Get()
    local qfcu_loc = dr_qfcu_loc:Get()
    local qfcu_appr = dr_qfcu_appr:Get()
    local qfcu_exped = dr_qfcu_exped:Get()
    if dr_qfcu_ap1:Changed() or dr_qfcu_ap2:Changed() or dr_qfcu_athr:Changed() or dr_qfcu_loc:Changed() or
        dr_qfcu_appr:Changed() or dr_qfcu_exped:Changed() then
        dr_qfcu_ap1:Update()
        dr_qfcu_ap2:Update()
        dr_qfcu_athr:Update()
        dr_qfcu_loc:Update()
        dr_qfcu_appr:Update()
        dr_qfcu_exped:Update()
        ------------------------------------fcu light -------------------
        uluaSet(idr_qfcu_hid_ledsap1, ilua_bool_ternary(qfcu_ap1, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsap2, ilua_bool_ternary(qfcu_ap2, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsathr, ilua_bool_ternary(qfcu_athr, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsloc, ilua_bool_ternary(qfcu_loc, 0)) -- qfcu_loc)
        uluaSet(idr_qfcu_hid_ledsappr, ilua_bool_ternary(qfcu_appr, 0)) -- qfcu_appr)
        uluaSet(idr_qfcu_hid_ledsexped, ilua_bool_ternary(qfcu_exped, 110)) -- qfcu_exped)
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
        uluaSet(idr_qfcu_hid_ledslndb, ilua_bool_ternary(qfcu_c_ndb, 0)) -- ndb)
        uluaSet(idr_qfcu_hid_ledslaprt, ilua_bool_ternary(qfcu_c_arpt, 0)) -- aprt)
        uluaSet(idr_qfcu_hid_ledslfd, ilua_bool_ternary(qfcu_c_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledslls, ilua_bool_ternary(qfcu_c_ils, 0)) -- ls)
        -- uluaSet(idr_qfcu_hid_ledslqfe, ilua_bool_ternary(qfcu_c_mode, 1)) --qfe)
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
        uluaSet(idr_qfcu_hid_ledsrndb, ilua_bool_ternary(qfcu_f_ndb, 0)) -- ndb)
        uluaSet(idr_qfcu_hid_ledsraprt, ilua_bool_ternary(qfcu_f_arpt, 0)) -- aprt)
        uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_f_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledsrls, ilua_bool_ternary(qfcu_f_ils, 0)) -- ls)
        -- uluaSet(idr_qfcu_hid_ledsrqfe, ilua_bool_ternary(qfcu_f_mode, 1)) --qfe)

        if qfcu_f_barostd == 0 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 1) -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
        end
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
    local qfcu_is_spdmgd = dr_qfcu_is_spdmgd:Get()
    if dr_qfcu_airspeed:Changed() or dr_qfcu_spddashed:Changed() or dr_qfcu_is_mach:Changed() or
        dr_qfcu_is_spdmgd:Changed() then
        dr_qfcu_airspeed:Update()
        dr_qfcu_spddashed:Update()
        dr_qfcu_is_mach:Update()
        dr_qfcu_is_spdmgd:Update()

        if qfcu_is_spdmgd == 1 then
            if qfcu_spddashed == 1 then
                if qfcu_is_mach == 1 then
                    uluaSet(idr_qfcu_hid_iasmode, 4)
                else
                    uluaSet(idr_qfcu_hid_iasmode, 2)
                end
            else
                if qfcu_is_mach == 1 then
                    c_spd = math.floor(qfcu_airspeed * 100 + 0.5)
                    uluaSet(idr_qfcu_hid_iasval_f, c_spd / 100)
                    uluaSet(idr_qfcu_hid_iasmode, 6)
                else
                    c_spd = math.floor(qfcu_airspeed + 0.5)
                    uluaSet(idr_qfcu_hid_iasmode, 5)
                    uluaSet(idr_qfcu_hid_iasval_i, c_spd)
                end
            end
        else
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
end

function digi_disp_set_HDG()
    local qfcu_heading = dr_qfcu_heading:Get()
    local qfcu_hdgdashed = dr_qfcu_hdgdashed:Get()
    local qfcu_is_hdgmgd = dr_qfcu_is_hdgmgd:Get()

    if dr_qfcu_heading:Changed() or dr_qfcu_hdgdashed:Changed() or dr_qfcu_is_hdgmgd:Changed() then
        dr_qfcu_heading:Update()
        dr_qfcu_hdgdashed:Update()
        dr_qfcu_is_hdgmgd:Update()
        -- real code
        if qfcu_is_hdgmgd == 1 then
            if qfcu_hdgdashed == 1 then
                uluaSet(idr_qfcu_hid_hdgmode, 2)
            else
                uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading % 360)
                uluaSet(idr_qfcu_hid_hdgmode, 3)
            end
        else
            if qfcu_hdgdashed == 1 then
                uluaSet(idr_qfcu_hid_hdgmode, 2)
            else
                uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading % 360)
                uluaSet(idr_qfcu_hid_hdgmode, 1)
            end
        end
    end
end

function digi_disp_set_ALT()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    local qfcu_altmanaged = dr_qfcu_altmanaged:Get()
    if dr_qfcu_altitude:Changed() or dr_qfcu_altmanaged:Changed() then
        dr_qfcu_altitude:Update()
        dr_qfcu_altmanaged:Update()
        -- real code
        uluaSet(idr_qfcu_hid_altval_i, qfcu_altitude)
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
    if dr_qfcu_vs:Changed() or dr_qfcu_hdgtrkmode:Changed() or dr_qfcu_vsdashed:Changed() then
        dr_qfcu_vs:Update()
        dr_qfcu_hdgtrkmode:Update()
        dr_qfcu_vsdashed:Update()
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
                uluaSet(idr_qfcu_hid_vs_trkval_i, math.abs(qfcu_vs))
                if qfcu_vs < 0 then
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
    if dr_qfcu_c_baro:Changed() or dr_qfcu_c_barounit:Changed() or dr_qfcu_c_barostd:Changed() then
        dr_qfcu_c_baro:Update()
        dr_qfcu_c_barounit:Update()
        dr_qfcu_c_barostd:Update()
        -- real code
        if qfcu_c_barostd == 1 then -- std
            uluaSet(idr_qfcu_hid_lefismode, 3)
        else
            if qfcu_c_barounit == 1 then -- hpa mode
                c_baro = math.floor(qfcu_c_baro * 33.8638895 + 0.5)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 2)
            else
                c_baro = math.floor(qfcu_c_baro * 100 + 0.5)
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
                f_baro = math.floor(qfcu_f_baro * 33.8638895 + 0.5)
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
    qfcu_fcu_lightDisp = math.floor(qfcu_fcu_lightDisp * 100 / 25)

    if dr_qfcu_fcu_light:Changed() or dr_qfcu_fcu_lightDisp:Changed() then
        dr_qfcu_fcu_light:Update()
        dr_qfcu_fcu_lightDisp:Update()
        -- real code
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
function QFCU_Off()
    uluaSet(idr_qfcu_hid_indbrightval_i, 0)
end
function digi_disp_set_BrightOff()
    dr_qfcu_fcu_light:Invalid(-1)
    dr_qfcu_fcu_lightDisp:Invalid(-1)
    uluaSet(idr_qfcu_hid_brightval_i, 0)
    uluaSet(idr_qfcu_hid_indbrightval_i, 1)
    uluaSet(idr_qfcu_hid_invalid, -11)
    uluasetTimeout("QFCU_Off()", 200)
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
function toliss_boot()
    if is_load == 0 then
        local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
        if os.clock() > start_time + 5 or qfcu_fcu_power > 0 then
            is_load = 1
            uluaAddDoLoop("Toliss320_digi_disp_every_frame()")
        end
    end
end

function Toliss320_digi_disp_every_frame()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_val_condbtn_16 = idr_qfcu_hid_condbtn_16:Get()
    local qfcu_alt_unit = dr_qfcu_alt_unit:Get()
    local qfcu_val_condbtn_46 = idr_qfcu_hid_condbtn_46:Get()
    local qfcu_c_baro = dr_qfcu_c_baro:Get()
    local qfcu_c_barounit = dr_qfcu_c_barounit:Get()
    local qfcu_val_condbtn_78 = idr_qfcu_hid_condbtn_78:Get()
    local qfcu_f_baro = dr_qfcu_f_baro:Get()
    local qfcu_f_barounit = dr_qfcu_f_barounit:Get()
    if is_load == 0 then
        return
    end

    if dr_qfcu_fcu_power:Changed() then
        if qfcu_fcu_power > 0 then
            uluaSet(idr_qfcu_hid_indbrightval_i, qfcu_fcu_test + 1)
            uluaSet(idr_qfcu_hid_invalid, -1)
        else
            digi_disp_powoff_leds()
            digi_disp_powoff_mcp()
            digi_disp_set_BrightOff()
        end
        dr_qfcu_fcu_power:Update()
    end
    ---- fix altitude bug
    if idr_qfcu_hid_condbtn_16:Changed() then
        local altstep = idr_qfcu_hid_condbtn_16:Delta()
        local altnew = 0
        -- uluaLog(string.format("alt=%d  %d", altstep, qfcu_val_condbtn_16))
        -- uluaSet(idr_qfcu_hid_condbtn_16, 0)
        idr_qfcu_hid_condbtn_16:Update()
        if qfcu_alt_unit == 1 then
            altnew = qfcu_altitude + altstep * 10
        else
            altnew = qfcu_altitude + altstep
        end
        if altnew >= 0 and altnew <= 40000 then
            dr_qfcu_altitude:Set(altnew)
        end
    end

    -- Fix Captain Baro
    if idr_qfcu_hid_condbtn_46:Changed() then
        local smallstep = idr_qfcu_hid_condbtn_46:Delta()
        -- uluaLog(string.format("small=%d  %d", smallstep, qfcu_val_condbtn_46))
        idr_qfcu_hid_condbtn_46:Update()

        if qfcu_c_barounit == 1 then
            local inHg = qfcu_c_baro * 33.8638895 + smallstep
            -- update hPa
            dr_qfcu_c_baro:Set(inHg / 33.8638895)
        else
            local inHg = qfcu_c_baro + smallstep * 0.01
            -- update inHg
            dr_qfcu_c_baro:Set(inHg)
        end
    end
    -- Fix First Officer Baro
    if idr_qfcu_hid_condbtn_78:Changed() then
        local smallstep = idr_qfcu_hid_condbtn_78:Delta()
        -- uluaLog(string.format("small=%d  %d", smallstep, qfcu_val_condbtn_78))
        idr_qfcu_hid_condbtn_78:Update()

        if qfcu_f_barounit == 1 then
            local inHg = qfcu_f_baro * 33.8638895 + smallstep
            -- update hPa
            dr_qfcu_f_baro:Set(inHg / 33.8638895)
        else
            local inHg = qfcu_f_baro + smallstep * 0.01
            -- update inHg
            dr_qfcu_f_baro:Set(inHg)
        end
    end
    -------------------
    if qfcu_fcu_power > 0 then
        digi_disp_set_Bright()
        digi_disp_set_LEDS()
        digi_disp_mcp_rr()
    end
end

uluaAddDoLoop("toliss_boot()")
