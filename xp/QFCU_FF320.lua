-- **********************************************************************************************************--
-- QFCU Driver for FlightFactor A320 Ultimate
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2021-02-12  last modified:2021-05-12  test with FF320 v1.17beta ,Xplane 11.53
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2021-04-23
-- 2021-12-30 tested on FF320 v1.2.5 beta
-- 2023-10-20 tested on FF320 v1.7.2-2692
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBrightness = 100 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- ###############################################################################################
--[[
********** edit the file  X-plane11\Aircraft\FlightFactor A320 ultimate\data\publish.txt********
            add these lines
********************************  Start (not include this line)***********************
a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit1/State
a320/Aircraft/FMGS/FCU1/SpeedIsMach
a320/Aircraft/FMGS/FCU1/Speed
a320/Aircraft/FMGS/FCU1/Lateral
a320/Aircraft/FMGS/FCU1/Altitude
a320/Aircraft/FMGS/FCU1/Vertical
a320/Aircraft/FMGS/FCU1/Mode
a320/Aircraft/FMGS/FCU1/AutoPilotLight1
a320/Aircraft/FMGS/FCU1/AutoPilotLight2
a320/Aircraft/FMGS/FCU1/AutoThrustLight
a320/Aircraft/FMGS/FCU1/LocalizerLight
a320/Aircraft/FMGS/FCU1/ExpediteLight
a320/Aircraft/FMGS/FCU1/ApproachLight
a320/Aircraft/FMGS/FCU1/BaroTypeL
a320/Aircraft/FMGS/FCU1/BaroModeL
a320/Aircraft/FMGS/FCU1/BaroL
a320/Aircraft/FMGS/FCU1/LandSysL
a320/Aircraft/FMGS/FCU1/FlightDirL
a320/Aircraft/FMGS/FCU1/NavTypeL
a320/Aircraft/FMGS/FCU1/SpeedManaged
a320/Aircraft/FMGS/FCU1/SpeedMode
a320/Aircraft/FMGS/FCU1/LateralManaged
a320/Aircraft/FMGS/FCU1/AltitudeManaged
a320/Aircraft/FMGS/FCU1/VerticalManaged
a320/Aircraft/FMGS/FCU1/BaroTypeR
a320/Aircraft/FMGS/FCU1/BaroModeR
a320/Aircraft/FMGS/FCU1/BaroR
a320/Aircraft/FMGS/FCU1/LandSysR
a320/Aircraft/FMGS/FCU1/FlightDirR
a320/Aircraft/FMGS/FCU1/NavTypeR
a320/Panel/LightShield
a320/Panel/LightDisplay
*****************************  End (not include this line)*************************
]]
if PLANE_ICAO ~= "A320" or PLANE_TAILNUMBER ~= "D-AXLA" then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog(string.format("aircraft dir=%s", AIRCRAFT_PATH))

function check_if_dataref_exists()
    if uluaFind("a320/Aircraft/FMGS/FCU1/Speed") ~= nil and uluaFind("a320/Aircraft/FMGS/FCU1/NavTypeR") ~= nil then

        -- qfcu:CfgEncFull(78, 79, "a320/Panel/EFIS_BaroR" , 1, 1, 1, -500, 500)
        qfcu:CfgCmd(0, "a320/Panel/FCU_Speed_switch-")
        qfcu:CfgCmd(1, "a320/Panel/FCU_Speed_switch+")
        qfcu:CfgCmd(2, "a320/Panel/FCU_SpeedMode_switch_push")
        qfcu:CfgCmd(3, "a320/Panel/FCU_SpeedMode_switch_pull")
        qfcu:CfgCmd(4, "a320/Panel/FCU_Lateral_switch-")
        qfcu:CfgCmd(5, "a320/Panel/FCU_Lateral_switch+")
        qfcu:CfgCmd(6, "a320/Panel/FCU_LateralMode_switch_push")
        qfcu:CfgCmd(7, "a320/Panel/FCU_LateralMode_switch_pull")
        qfcu:CfgCmd(8, "a320/Panel/FCU_Localizer_button")
        qfcu:CfgCmd(9, "a320/Panel/FCU_AutoPilot2_button")
        qfcu:CfgCmd(10, "a320/Panel/FCU_AutoPilot1_button")
        qfcu:CfgCmd(11, "a320/Panel/FCU_AutoThrust_button")
        qfcu:CfgCmd(12, "a320/Panel/FCU_Expedite_button")
        qfcu:CfgCmd(13, "a320/Panel/FCU_Approach_button")
        qfcu:CfgCmd(14, "a320/Panel/FCU_Metric_button")
        qfcu:CfgVal(15, "a320/Panel/FCU_AltitudeStep", 0, 1)
        qfcu:CfgCmd(16, "a320/Panel/FCU_Altitude_switch-")
        qfcu:CfgCmd(17, "a320/Panel/FCU_Altitude_switch+")
        qfcu:CfgCmd(18, "a320/Panel/FCU_AltitudeMode_switch_push")
        qfcu:CfgCmd(19, "a320/Panel/FCU_AltitudeMode_switch_pull")
        qfcu:CfgCmd(20, "a320/Panel/FCU_Vertical_switch-")
        qfcu:CfgCmd(21, "a320/Panel/FCU_Vertical_switch+")
        qfcu:CfgCmd(22, "a320/Panel/FCU_VerticalMode_switch_push")
        qfcu:CfgCmd(23, "a320/Panel/FCU_VerticalMode_switch_pull")
        qfcu:CfgVal(24, "a320/Panel/EFIS_NavModeL", 0, nil)
        qfcu:CfgVal(25, "a320/Panel/EFIS_NavModeL", 1, nil)
        qfcu:CfgVal(26, "a320/Panel/EFIS_NavModeL", 2, nil)
        qfcu:CfgVal(27, "a320/Panel/EFIS_NavModeL", 3, nil)
        qfcu:CfgVal(28, "a320/Panel/EFIS_NavModeL", 4, nil)
        qfcu:CfgVal(29, "a320/Panel/EFIS_NavRangeL", 0, nil)
        qfcu:CfgVal(30, "a320/Panel/EFIS_NavRangeL", 1, nil)
        qfcu:CfgVal(31, "a320/Panel/EFIS_NavRangeL", 2, nil)
        qfcu:CfgVal(32, "a320/Panel/EFIS_NavRangeL", 3, nil)
        qfcu:CfgVal(33, "a320/Panel/EFIS_NavRangeL", 4, nil)
        qfcu:CfgVal(34, "a320/Panel/EFIS_NavRangeL", 5, nil)
        qfcu:CfgCmd(35, "a320/Panel/EFIS_NavType1L_button")
        qfcu:CfgCmd(36, "a320/Panel/EFIS_NavType2L_button")
        qfcu:CfgCmd(37, "a320/Panel/EFIS_NavType3L_button")
        qfcu:CfgCmd(38, "a320/Panel/EFIS_NavType4L_button")
        qfcu:CfgCmd(39, "a320/Panel/EFIS_NavType5L_button")
        qfcu:CfgCmd(40, "a320/Panel/EFIS_FlightDirL_button")
        qfcu:CfgCmd(41, "a320/Panel/EFIS_LandSysL_button")
        qfcu:CfgVal(42, "a320/Panel/EFIS_NavReciver1L", 0, 1)
        qfcu:CfgVal(43, "a320/Panel/EFIS_NavReciver1L", 2, 1)
        qfcu:CfgVal(44, "a320/Panel/EFIS_NavReciver2L", 0, 1)
        qfcu:CfgVal(45, "a320/Panel/EFIS_NavReciver2L", 2, 1)
        qfcu:CfgCmd(46, "a320/Panel/EFIS_BaroL_switch-")
        qfcu:CfgCmd(47, "a320/Panel/EFIS_BaroL_switch+")
        qfcu:CfgCmd(48, "a320/Panel/EFIS_BaroModeL_switch_push")
        qfcu:CfgCmd(49, "a320/Panel/EFIS_BaroModeL_switch_pull")
        qfcu:CfgVal(50, "a320/Panel/EFIS_BaroTypeL", 0, 1)
        qfcu:CfgVal(51, "a320/Panel/EFIS_BaroModeR", 0, 1)
        qfcu:CfgVal(52, "a320/Panel/EFIS_BaroModeR", 0, -1)
        qfcu:CfgVal(53, "a320/Panel/EFIS_BaroTypeR", 0, 1)
        qfcu:CfgCmd(54, "a320/Panel/FCU_Mode_button")
        qfcu:CfgCmd(55, "a320/Panel/FCU_Mach_button")
        qfcu:CfgVal(56, "a320/Panel/EFIS_NavModeR", 0, nil)
        qfcu:CfgVal(57, "a320/Panel/EFIS_NavModeR", 1, nil)
        qfcu:CfgVal(58, "a320/Panel/EFIS_NavModeR", 2, nil)
        qfcu:CfgVal(59, "a320/Panel/EFIS_NavModeR", 3, nil)
        qfcu:CfgVal(60, "a320/Panel/EFIS_NavModeR", 4, nil)
        qfcu:CfgVal(61, "a320/Panel/EFIS_NavRangeR", 0, nil)
        qfcu:CfgVal(62, "a320/Panel/EFIS_NavRangeR", 1, nil)
        qfcu:CfgVal(63, "a320/Panel/EFIS_NavRangeR", 2, nil)
        qfcu:CfgVal(64, "a320/Panel/EFIS_NavRangeR", 3, nil)
        qfcu:CfgVal(65, "a320/Panel/EFIS_NavRangeR", 4, nil)
        qfcu:CfgVal(66, "a320/Panel/EFIS_NavRangeR", 5, nil)
        qfcu:CfgCmd(67, "a320/Panel/EFIS_NavType1R_button")
        qfcu:CfgCmd(68, "a320/Panel/EFIS_NavType2R_button")
        qfcu:CfgCmd(69, "a320/Panel/EFIS_NavType3R_button")
        qfcu:CfgCmd(70, "a320/Panel/EFIS_NavType4R_button")
        qfcu:CfgCmd(71, "a320/Panel/EFIS_NavType5R_button")
        qfcu:CfgCmd(72, "a320/Panel/EFIS_FlightDirR_button")
        qfcu:CfgCmd(73, "a320/Panel/EFIS_LandSysR_button")
        qfcu:CfgVal(74, "a320/Panel/EFIS_NavReciver1R", 0, 1)
        qfcu:CfgVal(75, "a320/Panel/EFIS_NavReciver1R", 2, 1)
        qfcu:CfgVal(76, "a320/Panel/EFIS_NavReciver2R", 0, 1)
        qfcu:CfgVal(77, "a320/Panel/EFIS_NavReciver2R", 2, 1)
        qfcu:CfgCmd(78, "a320/Panel/EFIS_BaroR_switch-")
        qfcu:CfgCmd(79, "a320/Panel/EFIS_BaroR_switch+")

        -- LED Indicator light
        -- fcu
        dr_qfcu_airspeed = iDataRef:New("a320/Aircraft/FMGS/FCU1/Speed")
        dr_qfcu_is_mach = iDataRef:New("a320/Aircraft/FMGS/FCU1/SpeedIsMach")
        dr_qfcu_heading = iDataRef:New("a320/Aircraft/FMGS/FCU1/Lateral")
        dr_qfcu_hdgtrkmode = iDataRef:New("a320/Aircraft/FMGS/FCU1/Mode") -- 0:hdg 1:TRK
        dr_qfcu_altitude = iDataRef:New("a320/Aircraft/FMGS/FCU1/Altitude")
        dr_qfcu_vs = iDataRef:New("a320/Aircraft/FMGS/FCU1/Vertical")
        -- SPD -1:preslect 0:manual 1:MFA
        dr_qfcu_spddashed = iDataRef:New("a320/Aircraft/FMGS/FCU1/SpeedManaged")
        -- HDG -1:preslect 0:manual 1:MFA
        dr_qfcu_hdgdashed = iDataRef:New("a320/Aircraft/FMGS/FCU1/LateralManaged")
        dr_qfcu_altmanaged = iDataRef:New("a320/Aircraft/FMGS/FCU1/AltitudeManaged")
        dr_qfcu_vsdashed = iDataRef:New("a320/Aircraft/FMGS/FCU1/VerticalManaged")

        dr_qfcu_loc = iDataRef:New("a320/Aircraft/FMGS/FCU1/LocalizerLight")
        dr_qfcu_ap1 = iDataRef:New("a320/Aircraft/FMGS/FCU1/AutoPilotLight1")
        dr_qfcu_ap2 = iDataRef:New("a320/Aircraft/FMGS/FCU1/AutoPilotLight2")
        dr_qfcu_athr = iDataRef:New("a320/Aircraft/FMGS/FCU1/AutoThrustLight")
        dr_qfcu_exped = iDataRef:New("a320/Aircraft/FMGS/FCU1/ExpediteLight")
        dr_qfcu_appr = iDataRef:New("a320/Aircraft/FMGS/FCU1/ApproachLight")

        -- efis capt
        dr_qfcu_c_type = iDataRef:New("a320/Aircraft/FMGS/FCU1/NavTypeL") -- 1:CSTR 2:WPT 3:VORD 4:NDB 5:APRT
        dr_qfcu_c_fd = iDataRef:New("a320/Aircraft/FMGS/FCU1/FlightDirL") -- 0 active
        dr_qfcu_c_ils = iDataRef:New("a320/Aircraft/FMGS/FCU1/LandSysL") -- 1 active

        dr_qfcu_c_baro = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroL")
        dr_qfcu_c_barounit = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroTypeL") -- 0:inHg 1:hPa
        dr_qfcu_c_mode = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroModeL") -- 1:QFE 2:QNH  <0: Std

        -- efis FO
        dr_qfcu_f_type = iDataRef:New("a320/Aircraft/FMGS/FCU1/NavTypeR") -- 1:CSTR 2:WPT 3:VORD 4:NDB 5:APRT
        dr_qfcu_f_fd = iDataRef:New("a320/Aircraft/FMGS/FCU1/FlightDirR") -- 0 active
        dr_qfcu_f_ils = iDataRef:New("a320/Aircraft/FMGS/FCU1/LandSysR") -- 1 active

        dr_qfcu_f_baro = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroR")
        dr_qfcu_f_barounit = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroTypeR") -- 0:inHg 1:hPa
        dr_qfcu_f_mode = iDataRef:New("a320/Aircraft/FMGS/FCU1/BaroModeR") -- 1:QFE 2:QNH <0:Std

        -- brightness
        dr_qfcu_fcu_light = iDataRef:New("a320/Panel/LightShield") -- 0~27
        dr_qfcu_fcu_lightDisp = iDataRef:New("a320/Panel/LightDisplay") -- 0~27

        -- annun test mode
        dr_qfcu_fcu_test = iDataRef:New("a320/Overhead/LightAnnun") -- 0: DIM 1: BRT 2: test mode
        dr_qfcu_fcu_power = iDataRef:New("a320/Aircraft/Cockpit/Panel/FCU_AltitudeDigit1/State") -- > 0:off  1:ON
        dr_qfcu_fcu_bkpwr = iDataRef:New("model/material/panel_front") -- > backlight poweron  in dark cold mode
        ----------------------------  Display Dataref Set End ------------------------------------
        -- cmd_qmdev_reload = uluaFind("cpuwolf/qmdev/reloadcfg")
        -- uluaCmdOnce(cmd_qmdev_reload)
        uluaAddDoLoop("FF320_digi_disp_every_frame()")
        uluaLog("QFCU for FF320")
    else
        uluasetTimeout("check_if_dataref_exists()", 1000)
    end
end
uluasetTimeout("check_if_dataref_exists()", 1000)
-- check_if_dataref_exists()
-- Open USB HID Device

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light
function ternary(vari, value)
    if vari == value then
        return 1
    else
        return 0
    end
end
function ternaryp(vari, value)
    if vari == value and FF320_FCU_power_on() then
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
        uluaSet(idr_qfcu_hid_ledsap1, ilua_bool_ternary(qfcu_ap1, 0)) -- ap1)
        uluaSet(idr_qfcu_hid_ledsap2, ilua_bool_ternary(qfcu_ap2, 0)) -- ap2)
        uluaSet(idr_qfcu_hid_ledsathr, ilua_bool_ternary(qfcu_athr, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsloc, ilua_bool_ternary(qfcu_loc, 0)) -- qfcu_loc)
        uluaSet(idr_qfcu_hid_ledsappr, ilua_bool_ternary(qfcu_appr, 0)) -- qfcu_appr)
        uluaSet(idr_qfcu_hid_ledsexped, ilua_bool_ternary(qfcu_exped, 0)) -- qfcu_exped)
    end
end

function digi_disp_set_LEDS_l_efis()
    local qfcu_c_type = dr_qfcu_c_type:Get()
    local qfcu_c_fd = dr_qfcu_c_fd:Get()
    local qfcu_c_ils = dr_qfcu_c_ils:Get()
    local qfcu_c_mode = dr_qfcu_c_mode:Get()
    if dr_qfcu_c_type:Changed() or dr_qfcu_c_fd:Changed() or dr_qfcu_c_ils:Changed() or dr_qfcu_c_mode:Changed() then
        dr_qfcu_c_type:Update()
        dr_qfcu_c_fd:Update()
        dr_qfcu_c_ils:Update()
        -- dr_qfcu_c_mode:Update()
        ---------------------------------------Efis leds Capt---------
        uluaSet(idr_qfcu_hid_ledslcstr, ternary(qfcu_c_type, 1)) -- cstr)
        uluaSet(idr_qfcu_hid_ledslwpt, ternary(qfcu_c_type, 2))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledslvord, ternary(qfcu_c_type, 4)) -- vord)
        uluaSet(idr_qfcu_hid_ledslndb, ternary(qfcu_c_type, 8)) -- ndb)
        uluaSet(idr_qfcu_hid_ledslaprt, ternary(qfcu_c_type, 16)) -- aprt)
        uluaSet(idr_qfcu_hid_ledslfd, ternary(qfcu_c_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledslls, ternary(qfcu_c_ils, 1)) -- ls)
        if qfcu_c_mode ~= 0 then
            uluaSet(idr_qfcu_hid_ledslqfe, ternary(qfcu_c_mode, 1)) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, ternary(qfcu_c_mode, 2)) -- qhn)
        else
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
        end
    end
end

function digi_disp_set_LEDS_r_efis()
    local qfcu_f_type = dr_qfcu_f_type:Get()
    local qfcu_f_fd = dr_qfcu_f_fd:Get()
    local qfcu_f_ils = dr_qfcu_f_ils:Get()
    local qfcu_f_mode = dr_qfcu_f_mode:Get()
    if dr_qfcu_f_type:Changed() or dr_qfcu_f_fd:Changed() or dr_qfcu_f_ils:Changed() or dr_qfcu_f_mode:Changed() then
        dr_qfcu_f_type:Update()
        dr_qfcu_f_fd:Update()
        dr_qfcu_f_ils:Update()
        -- dr_qfcu_f_mode:Update()
        ---------------------------------------Efis leds FO---------
        uluaSet(idr_qfcu_hid_ledsrcstr, ternary(qfcu_f_type, 1)) -- cstr)
        uluaSet(idr_qfcu_hid_ledsrwpt, ternary(qfcu_f_type, 2))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledsrvord, ternary(qfcu_f_type, 4)) -- vord)
        uluaSet(idr_qfcu_hid_ledsrndb, ternary(qfcu_f_type, 8)) -- ndb)
        uluaSet(idr_qfcu_hid_ledsraprt, ternary(qfcu_f_type, 16)) -- aprt)
        uluaSet(idr_qfcu_hid_ledsrfd, ternary(qfcu_f_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledsrls, ternary(qfcu_f_ils, 1)) -- ls)
        if qfcu_f_mode ~= 0 then
            uluaSet(idr_qfcu_hid_ledsrqfe, ternary(qfcu_f_mode, 1)) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, ternary(qfcu_f_mode, 2)) -- qhn)
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

function digi_disp_set_FCUSPD()
    local qfcu_airspeed_val = dr_qfcu_airspeed:Get()
    local qfcu_spddashed = dr_qfcu_spddashed:Get()
    local qfcu_is_mach = dr_qfcu_is_mach:Get()

    if dr_qfcu_airspeed:Changed() or dr_qfcu_spddashed:Changed() or dr_qfcu_is_mach:Changed() then
        dr_qfcu_airspeed:Update()
        dr_qfcu_spddashed:Update()
        dr_qfcu_is_mach:Update()

        if qfcu_spddashed == 1 then
            if qfcu_is_mach == 1 then
                uluaSet(idr_qfcu_hid_iasmode, 4)
            else
                uluaSet(idr_qfcu_hid_iasmode, 2)
            end
        elseif qfcu_spddashed == -1 then
            if qfcu_is_mach == 1 then
                uluaSet(idr_qfcu_hid_iasval_f, qfcu_airspeed_val / 100)
                uluaSet(idr_qfcu_hid_iasmode, 6)
            else
                uluaSet(idr_qfcu_hid_iasmode, 5)
                uluaSet(idr_qfcu_hid_iasval_i, qfcu_airspeed_val)
            end
        else
            if qfcu_is_mach == 1 then
                uluaSet(idr_qfcu_hid_iasval_f, qfcu_airspeed_val / 100)
                uluaSet(idr_qfcu_hid_iasmode, 3)
            else
                uluaSet(idr_qfcu_hid_iasmode, 1)
                uluaSet(idr_qfcu_hid_iasval_i, qfcu_airspeed_val)
            end
        end
    end
end

function digi_disp_set_HDG()
    local qfcu_heading_val = dr_qfcu_heading:Get()
    local qfcu_hdgdashed = dr_qfcu_hdgdashed:Get()
    if dr_qfcu_heading:Changed() or dr_qfcu_hdgdashed:Changed() then
        dr_qfcu_heading:Update()
        dr_qfcu_hdgdashed:Update()
        -- real code
        if qfcu_hdgdashed == 1 then
            uluaSet(idr_qfcu_hid_hdgmode, 2)
        elseif qfcu_hdgdashed == -1 then
            uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading_val)
            uluaSet(idr_qfcu_hid_hdgmode, 3)
        else
            uluaSet(idr_qfcu_hid_hdgval_i, qfcu_heading_val)
            uluaSet(idr_qfcu_hid_hdgmode, 1)
        end
    end
end

function digi_disp_set_ALT()
    local qfcu_altitude_val = dr_qfcu_altitude:Get()
    local qfcu_altmanaged = dr_qfcu_altmanaged:Get()
    if dr_qfcu_altitude:Changed() or dr_qfcu_altmanaged:Changed() then
        dr_qfcu_altitude:Update()
        dr_qfcu_altmanaged:Update()
        -- real code
        uluaSet(idr_qfcu_hid_altval_i, qfcu_altitude_val * 100)
        if qfcu_altmanaged == -1 then
            uluaSet(idr_qfcu_hid_altmode, 2)
        elseif qfcu_altmanaged == 0 then
            uluaSet(idr_qfcu_hid_altmode, 1)
        end
    end
end

function digi_disp_set_VS()
    local qfcu_vs_val = dr_qfcu_vs:Get()
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
                uluaSet(idr_qfcu_hid_vs_trkval_i, math.abs(qfcu_vs_val) * 100)
                if qfcu_vs_val < 0 then
                    uluaSet(idr_qfcu_hid_vs_trkmode, 3)
                else
                    uluaSet(idr_qfcu_hid_vs_trkmode, 1)
                end
                uluaSet(idr_qfcu_hid_invalid, 4)
            else
                uluaSet(idr_qfcu_hid_vsval_i, math.abs(qfcu_vs_val) * 100)
                if qfcu_vs_val < 0 then
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
    local qfcu_c_mode = dr_qfcu_c_mode:Get()
    if dr_qfcu_c_baro:Changed() or dr_qfcu_c_barounit:Changed() or dr_qfcu_c_mode:Changed() then
        dr_qfcu_c_baro:Update()
        dr_qfcu_c_barounit:Update()
        dr_qfcu_c_mode:Update()
        -- real code
        if qfcu_c_mode <= 0 then -- std
            uluaSet(idr_qfcu_hid_lefismode, 3)
        else
            if qfcu_c_barounit == 1 then -- hpa mode
                uluaSet(idr_qfcu_hid_lefisval_i, qfcu_c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 2)
            else
                uluaSet(idr_qfcu_hid_lefisval_i, qfcu_c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 1)
            end
        end
    end
end
---------------------EFIS FO-------------
function digi_disp_set_R_EFIS()
    local qfcu_f_baro = dr_qfcu_f_baro:Get()
    local qfcu_f_barounit = dr_qfcu_f_barounit:Get()
    local qfcu_f_mode = dr_qfcu_f_mode:Get()
    if dr_qfcu_f_baro:Changed() or dr_qfcu_f_barounit:Changed() or dr_qfcu_f_mode:Changed() then
        dr_qfcu_f_baro:Update()
        dr_qfcu_f_barounit:Update()
        dr_qfcu_f_mode:Update()
        -- real code
        if qfcu_f_mode <= 0 then -- std
            uluaSet(idr_qfcu_hid_refismode, 3)
        else
            if qfcu_f_barounit == 1 then -- hpa mode
                uluaSet(idr_qfcu_hid_refisval_i, qfcu_f_baro)
                uluaSet(idr_qfcu_hid_refismode, 2)
            else
                uluaSet(idr_qfcu_hid_refisval_i, qfcu_f_baro)
                uluaSet(idr_qfcu_hid_refismode, 1)
            end
        end
    end
end

function invalid_buffer_digi()
    -- update cache
    dr_qfcu_f_fd:Invalid(-1)
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
    local qfcu_fcu_lightDisp = dr_qfcu_fcu_lightDisp:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    if dr_qfcu_fcu_light:Changed() or dr_qfcu_fcu_lightDisp:Changed() then
        dr_qfcu_fcu_light:Update()
        dr_qfcu_fcu_lightDisp:Update()
        -- real code
        -------------------------------------------------------------
        uluaSet(idr_qfcu_hid_brightval_i, math.floor(qfcu_fcu_light * MaxBrightness / 28))
        if not dr_qfcu_fcu_test:Changed() then
            uluaSet(idr_qfcu_hid_dispbrightval_i, math.floor(qfcu_fcu_lightDisp / 7))
            -- math.floor(qfcu_fcu_lightDisp*3/28))
        end
    end

    if dr_qfcu_fcu_test:Changed() then
        dr_qfcu_fcu_test:Update()
        uluaSet(idr_qfcu_hid_indbrightval_i, math.floor(qfcu_fcu_test + 1))
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
    -- uluaSet(idr_qfcu_hid_dispbrightval_i, 0)
    uluasetTimeout("QFCU_Off()", 200)
end

function digi_disp_powoff_leds()
    -- update cache
    dr_qfcu_ap1:Invalid(-1)
    dr_qfcu_c_mode:Invalid(-1)
    dr_qfcu_f_mode:Invalid(-1)
    -- real code
    uluaSet(idr_qfcu_hid_ledsval_i, 0)
    uluaSet(idr_qfcu_hid_ledslval_i, 0)
    uluaSet(idr_qfcu_hid_ledsrval_i, 0)
end
function digi_disp_powoff_mcp()
    -- update cache
    dr_qfcu_airspeed:Invalid(-1)
    dr_qfcu_heading:Invalid(-1)
    dr_qfcu_altitude:Invalid(-1000000)
    dr_qfcu_vsdashed:Invalid(11)
    dr_qfcu_c_baro:Invalid(-1)
    dr_qfcu_f_baro:Invalid(-1)
    -- real code
    uluaSet(idr_qfcu_hid_iasmode, 0)
    uluaSet(idr_qfcu_hid_hdgmode, 0)
    uluaSet(idr_qfcu_hid_altmode, 0)
    uluaSet(idr_qfcu_hid_vsmode, 0)
    uluaSet(idr_qfcu_hid_refismode, 0)
    uluaSet(idr_qfcu_hid_lefismode, 0)
end

-----end sub functions
local digi_disp_fcu_func_table = {digi_disp_set_FCUSPD, digi_disp_set_HDG, digi_disp_set_ALT, digi_disp_set_VS,
                                  digi_disp_set_L_EFIS, digi_disp_set_R_EFIS}

function digi_disp_mcp_rr()
    for i = 1, 6 do
        digi_disp_fcu_func_table[i]()
    end
end

function FF320_FCU_power_on()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    if qfcu_fcu_power > 0 then
        return true
    else
        return false
    end
end

local qfcu_fcu_first_lighton = 0
function FF320_digi_disp_every_frame()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    local qfcu_fcu_bkpwr = dr_qfcu_fcu_bkpwr:Get()
    local qfcu_fcu_light = dr_qfcu_fcu_light:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    if dr_qfcu_fcu_power:Changed() then
        if qfcu_fcu_power > 0 and dr_qfcu_fcu_power:GetOld() == 0 then
            uluaSet(idr_qfcu_hid_indbrightval_i, qfcu_fcu_test + 1)
            uluaSet(idr_qfcu_hid_invalid, -1)
            invalid_buffer_digi()
        end

        dr_qfcu_fcu_power:Update()
    end

    if FF320_FCU_power_on() then
        digi_disp_set_LEDS()
        digi_disp_mcp_rr()
        digi_disp_set_Bright()
    elseif qfcu_fcu_bkpwr > 0 then -- backlight on first startup
        if qfcu_fcu_first_lighton == 0 then
            uluaSet(idr_qfcu_hid_brightval_i, math.floor(qfcu_fcu_light * MaxBrightness / 28))
            qfcu_fcu_first_lighton = 1
        end
    else
        digi_disp_powoff_leds()
        digi_disp_powoff_mcp()
        digi_disp_set_BrightOff()
        qfcu_fcu_first_lighton = 0
    end
end
