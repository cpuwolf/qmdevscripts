-- **********************************************************************************************************--
-- QMCP737C Driver for Fenix A320
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2019-07-21  last modified:2020-12-24
-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2022-11-30 for Fenix A320
-- modified by Carson Lou @ QQ 2025-07-20
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBightness = 30       -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.
--
-- ########################################################
if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("fnx-") then
    if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("FNX_") then
        return
    end
end

local fnxready = false

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for Fenix A320")

qmcp737c:CfgRpn(0, "(>H:AS1000_PFD_CRS_DEC)")
qmcp737c:CfgRpn(1, "(>H:AS1000_PFD_CRS_INC)")
-- FD
qmcp737c:CfgRpn(70, "1 (>L:S_FCU_EFIS1_FD) , 1 (>L:S_FCU_EFIS2_FD)", "0 (>L:S_FCU_EFIS1_FD) , 0 (>L:S_FCU_EFIS2_FD)")

-- SPD
if MSFS_VERSION == 0 then
    qmcp737c:CfgEnc(4, 5, "B:FNX320_Input_Knob_PushPull_E_FCU_SPEED_Knob")
else
    qmcp737c:CfgRpn(4, "(L:E_FCU_SPEED) -- (>L:E_FCU_SPEED)")
    qmcp737c:CfgRpn(5, "(L:E_FCU_SPEED) ++ (>L:E_FCU_SPEED)")
end

-- SPD MANAGED
qmcp737c:CfgRpn(6, "(L:S_FCU_SPEED) -- (>L:S_FCU_SPEED)")

-- SPD SELECTED
qmcp737c:CfgRpn(8, "(L:S_FCU_SPEED) ++ (>L:S_FCU_SPEED)")

qmcp737c:CfgRpn(9, "(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)")
qmcp737c:CfgRpn(10, "1 (>L:S_FCU_SPD_MACH)", "0 (>L:S_FCU_SPD_MACH)")
qmcp737c:CfgRpn(11, "(L:XMLVAR_VNAVButtonValue, Bool) ! (>L:XMLVAR_VNAVButtonValue)")

-- HDG
if MSFS_VERSION == 0 then
    qmcp737c:CfgEnc(12, 13, "B:FNX320_Input_Knob_PushPull_E_FCU_HEADING_Knob")
else
    qmcp737c:CfgRpn(12, "(L:E_FCU_HEADING) -- (>L:E_FCU_HEADING)")
    qmcp737c:CfgRpn(13, "(L:E_FCU_HEADING) ++ (>L:E_FCU_HEADING)")
end

-- HDG MANAGED
qmcp737c:CfgRpn(14, "(L:S_FCU_HEADING) -- (>L:S_FCU_HEADING)")

-- HDG SELECTED
qmcp737c:CfgRpn(15, "(L:S_FCU_HEADING) ++ (>L:S_FCU_HEADING)")

-- ALT
if MSFS_VERSION == 0 then
    qmcp737c:CfgEnc(16, 17, "B:FNX320_Input_Knob_PushPull_E_FCU_ALTITUDE_Knob")
else
    qmcp737c:CfgRpn(16, "(L:E_FCU_ALTITUDE) -- (>L:E_FCU_ALTITUDE)")
    qmcp737c:CfgRpn(17, "(L:E_FCU_ALTITUDE) ++ (>L:E_FCU_ALTITUDE)")
end

-- ALT 100/1000
qmcp737c:CfgRpn(18,
    "(L:S_FCU_ALTITUDE_SCALE, Bool) if{ 0 (>L:S_FCU_ALTITUDE_SCALE) } els{ 1 (>L:S_FCU_ALTITUDE_SCALE) }")

qmcp737c:CfgRpn(19, "(>K:AP_NAV1_HOLD)")

qmcp737c:CfgRpn(20, "1 (>L:S_FCU_LOC)", "0 (>L:S_FCU_LOC)")

qmcp737c:CfgRpn(21, "1 (>L:S_FCU_APPR)", "0 (>L:S_FCU_APPR)")

-- ALT SELECTED
qmcp737c:CfgRpn(22, "(L:S_FCU_ALTITUDE) ++ (>L:S_FCU_ALTITUDE)")

-- V/S SELECTED
qmcp737c:CfgRpn(23, "(L:S_FCU_VERTICAL_SPEED) ++ (>L:S_FCU_VERTICAL_SPEED)")

qmcp737c:CfgRpn(24, "(L:E_FCU_VS) -- (>L:E_FCU_VS)")
qmcp737c:CfgRpn(25, "(L:E_FCU_VS) ++ (>L:E_FCU_VS)")

qmcp737c:CfgRpn(28, "1 (>L:S_FCU_EFIS2_FD)", "0 (>L:S_FCU_EFIS2_FD)")

-- ALT MANAGED
qmcp737c:CfgRpn(29, "(L:S_FCU_ALTITUDE) -- (>L:S_FCU_ALTITUDE)")

qmcp737c:CfgRpn(30, "1 (>L:S_FCU_AP1)", "0 (>L:S_FCU_AP1)")
qmcp737c:CfgRpn(31, "1 (>L:S_FCU_AP2)", "0 (>L:S_FCU_AP2)")

-- mins
local dr_pmdg_737_baro_mode = uluaFind("(L:S_FCU_EFIS1_BARO_MODE)")
function fnx_baro_mode_inc()
    local fnx_baro_mode_idx = uluaGet(dr_pmdg_737_baro_mode)
    fnx_baro_mode_idx = fnx_baro_mode_idx + 1
    if fnx_baro_mode_idx > 1 then
        fnx_baro_mode_idx = 1
    end
    local cmd = fnx_baro_mode_idx .. " (>L:S_FCU_EFIS1_BARO_MODE)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(33, "fnx_baro_mode_inc()")

function fnx_baro_mode_dec()
    local fnx_baro_mode_idx = uluaGet(dr_pmdg_737_baro_mode)
    fnx_baro_mode_idx = fnx_baro_mode_idx - 1
    if fnx_baro_mode_idx < 0 then
        fnx_baro_mode_idx = 0
    end
    local cmd = fnx_baro_mode_idx .. " (>L:S_FCU_EFIS1_BARO_MODE)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(32, "fnx_baro_mode_dec()")

-- BARO STD
qmcp737c:CfgRpn(50, "(L:S_FCU_EFIS2_BARO_STD) 0 == if{ 1 } els{ 0 } (>L:S_FCU_EFIS2_BARO_STD)")

--
qmcp737c:CfgRpn(34, "2 (>L:S_FCU_EFIS1_NAV1)", "1 (>L:S_FCU_EFIS1_NAV1)")
qmcp737c:CfgRpn(35, "0 (>L:S_FCU_EFIS1_NAV1)", "1 (>L:S_FCU_EFIS1_NAV1)")

qmcp737c:CfgRpn(37, "1 (>L:S_FCU_HDGVS_TRKFPA)", "0 (>L:S_FCU_HDGVS_TRKFPA)")

-- CSTR
qmcp737c:CfgRpn(39, "1 (>L:S_FCU_EFIS1_CSTR) , 1 (>L:S_FCU_EFIS2_CSTR)",
    "0 (>L:S_FCU_EFIS1_CSTR) , 0 (>L:S_FCU_EFIS2_CSTR)")

-- EFIS map mode
local dr_pmdg_737_map_mode = uluaFind("(L:S_FCU_EFIS1_ND_MODE)")
function fnx_map_mode_inc()
    local fnx_map_mode_idx = uluaGet(dr_pmdg_737_map_mode)
    fnx_map_mode_idx = fnx_map_mode_idx + 1
    if fnx_map_mode_idx > 4 then
        fnx_map_mode_idx = 4
    end
    local cmd = fnx_map_mode_idx .. " (>L:S_FCU_EFIS1_ND_MODE)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(41, "fnx_map_mode_inc()")

function fnx_map_mode_dec()
    local fnx_map_mode_idx = uluaGet(dr_pmdg_737_map_mode)
    fnx_map_mode_idx = fnx_map_mode_idx - 1
    if fnx_map_mode_idx < 0 then
        fnx_map_mode_idx = 0
    end
    local cmd = fnx_map_mode_idx .. " (>L:S_FCU_EFIS1_ND_MODE)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(42, "fnx_map_mode_dec()")
qmcp737c:CfgRpn(43, "1 (>L:S_FCU_METRIC_ALT)", "0 (>L:S_FCU_METRIC_ALT)")

-- FCU LS BUTTON
qmcp737c:CfgRpn(38, "1 (>L:S_FCU_EFIS1_LS) , 1 (>L:S_FCU_EFIS2_LS)", "0 (>L:S_FCU_EFIS1_LS) , 0 (>L:S_FCU_EFIS2_LS)")

-- WPT
qmcp737c:CfgRpn(44, "1 (>L:S_FCU_EFIS1_WPT) , 1 (>L:S_FCU_EFIS2_WPT)", "0 (>L:S_FCU_EFIS1_WPT) , 0 (>L:S_FCU_EFIS2_WPT)")

-- VORD
qmcp737c:CfgRpn(46, "1 (>L:S_FCU_EFIS1_VORD) , 1 (>L:S_FCU_EFIS2_VORD)",
    "0 (>L:S_FCU_EFIS1_VORD) , 0 (>L:S_FCU_EFIS1_VORD)")

-- NDB
qmcp737c:CfgRpn(47, "1 (>L:S_FCU_EFIS1_NDB) , 1 (>L:S_FCU_EFIS2_NDB)", "0 (>L:S_FCU_EFIS1_NDB) , 0 (>L:S_FCU_EFIS2_NDB)")

-- ARPT
qmcp737c:CfgRpn(45, "1 (>L:S_FCU_EFIS1_ARPT) , 1 (>L:S_FCU_EFIS2_ARPT)",
    "0 (>L:S_FCU_EFIS1_ARPT) , 0 (>L:S_FCU_EFIS2_ARPT)")

qmcp737c:CfgRpn(48, "(L:E_MIP_ISFD_BARO) -- (>L:E_MIP_ISFD_BARO)")
qmcp737c:CfgRpn(49, "(L:E_MIP_ISFD_BARO) ++ (>L:E_MIP_ISFD_BARO)")

-- 所有仪表亮度
qmcp737c:CfgRpn(0,
    "(L:A_DISPLAY_BRIGHTNESS_CO) 0.05 - 0 max (>L:A_DISPLAY_BRIGHTNESS_CO) , (L:A_DISPLAY_BRIGHTNESS_CI) 0.05 - 0 max (>L:A_DISPLAY_BRIGHTNESS_CI) , (L:A_DISPLAY_BRIGHTNESS_ECAM_L) 0.05 - 0 max (>L:A_DISPLAY_BRIGHTNESS_ECAM_L) , (L:A_DISPLAY_BRIGHTNESS_ECAM_U) 0.05 - 0 max (>L:A_DISPLAY_BRIGHTNESS_ECAM_U)")

qmcp737c:CfgRpn(1,
    "(L:A_DISPLAY_BRIGHTNESS_CO) 0.05 + 1 min (>L:A_DISPLAY_BRIGHTNESS_CO) , (L:A_DISPLAY_BRIGHTNESS_CI) 0.05 + 1 min (>L:A_DISPLAY_BRIGHTNESS_CI) , (L:A_DISPLAY_BRIGHTNESS_ECAM_L) 0.05 + 1 min (>L:A_DISPLAY_BRIGHTNESS_ECAM_L) , (L:A_DISPLAY_BRIGHTNESS_ECAM_U) 0.05 + 1 min (>L:A_DISPLAY_BRIGHTNESS_ECAM_U)")

-- FLOOD LT
qmcp737c:CfgRpn(26, "(L:A_MIP_LIGHTING_FLOOD_MAIN) 0.05 - 0 max (>L:A_MIP_LIGHTING_FLOOD_MAIN)",
    "(L:A_MIP_LIGHTING_FLOOD_PEDESTAL) 0.05 - 0 max (>L:A_MIP_LIGHTING_FLOOD_PEDESTAL)")
qmcp737c:CfgRpn(27, "(L:A_MIP_LIGHTING_FLOOD_MAIN) 0.05 + 1 min (>L:A_MIP_LIGHTING_FLOOD_MAIN)",
    "(L:A_MIP_LIGHTING_FLOOD_PEDESTAL) 0.05 + 1 min (>L:A_MIP_LIGHTING_FLOOD_PEDESTAL)")

local dr_pmdg_737_map_range = uluaFind("(L:S_FCU_EFIS1_ND_ZOOM)")
function fnx_map_range_inc()
    local fnx_map_range_idx = uluaGet(dr_pmdg_737_map_range)
    fnx_map_range_idx = fnx_map_range_idx + 1
    if fnx_map_range_idx > 5 then
        fnx_map_range_idx = 5
    end
    local cmd = fnx_map_range_idx .. " (>L:S_FCU_EFIS1_ND_ZOOM)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(52, "fnx_map_range_inc()")

function fnx_map_range_dec()
    local fnx_map_range_idx = uluaGet(dr_pmdg_737_map_range)
    fnx_map_range_idx = fnx_map_range_idx - 1
    if fnx_map_range_idx < 0 then
        fnx_map_range_idx = 0
    end
    local cmd = fnx_map_range_idx .. " (>L:S_FCU_EFIS1_ND_ZOOM)"
    uluaWriteCmd(cmd)
end

qmcp737c:CfgFc(51, "fnx_map_range_dec()")

--
qmcp737c:CfgRpn(54, "0 (>L:S_FCU_EFIS1_NAV2)", "1 (>L:S_FCU_EFIS1_NAV2)")
qmcp737c:CfgRpn(55, "2 (>L:S_FCU_EFIS1_NAV2)", "1 (>L:S_FCU_EFIS1_NAV2)")

-- qmcp737c:CfgRpn(56, "(L:E_PED_RMP1_INNER) -- (>L:E_PED_RMP1_INNER)")
-- qmcp737c:CfgRpn(57, "(L:E_PED_RMP1_INNER) ++ (>L:E_PED_RMP1_INNER)")
-- qmcp737c:CfgRpn(58, "(L:E_PED_RMP1_OUTER) -- (>L:E_PED_RMP1_OUTER)")
-- qmcp737c:CfgRpn(59, "(L:E_PED_RMP1_OUTER) ++ (>L:E_PED_RMP1_OUTER)")
-- qmcp737c:CfgRpn(60, "(>H:AS1000_PFD_COM_Push)")
-- qmcp737c:CfgRpn(61, "(L:S_PED_RMP1_XFER) ++ (>L:S_PED_RMP1_XFER)")

local lua_vhf1_or_vhf2 = 0 -- COM1 default value
function default_vhf1()
    qmcp737c:CfgRpn(56, "(L:E_PED_RMP1_INNER) -- (>L:E_PED_RMP1_INNER)")
    qmcp737c:CfgRpn(57, "(L:E_PED_RMP1_INNER) ++ (>L:E_PED_RMP1_INNER)")
    -- outer
    qmcp737c:CfgRpn(58, "(L:E_PED_RMP1_OUTER) -- (>L:E_PED_RMP1_OUTER)")
    qmcp737c:CfgRpn(59, "(L:E_PED_RMP1_OUTER) ++ (>L:E_PED_RMP1_OUTER)")

    qmcp737c:CfgRpn(61, "(L:S_PED_RMP1_XFER) ++ (>L:S_PED_RMP1_XFER)", "(L:S_PED_RMP1_XFER) ++ (>L:S_PED_RMP1_XFER)")
end

default_vhf1()

function flip_vhf1_vhf2()
    lua_vhf1_or_vhf2 = 1 - lua_vhf1_or_vhf2
    if lua_vhf1_or_vhf2 == 0 then
        default_vhf1()
    else
        qmcp737c:CfgRpn(56, "(L:E_PED_RMP2_INNER) -- (>L:E_PED_RMP2_INNER)")
        qmcp737c:CfgRpn(57, "(L:E_PED_RMP2_INNER) ++ (>L:E_PED_RMP2_INNER)")
        -- outer
        qmcp737c:CfgRpn(58, "(L:E_PED_RMP2_OUTER) -- (>L:E_PED_RMP2_OUTER)")
        qmcp737c:CfgRpn(59, "(L:E_PED_RMP2_OUTER) ++ (>L:E_PED_RMP2_OUTER)")

        qmcp737c:CfgRpn(61, "(L:S_PED_RMP2_XFER) ++ (>L:S_PED_RMP2_XFER)", "(L:S_PED_RMP2_XFER) ++ (>L:S_PED_RMP2_XFER)")
    end
end

qmcp737c:CfgFc(60, "flip_vhf1_vhf2()")
-- VHF1/VHF2 End

qmcp737c:CfgRpn(64, "(L:A_WR_TILT) -- -15 max (>L:A_WR_TILT)")
qmcp737c:CfgRpn(65, "(L:A_WR_TILT)  ++ 15 min (>L:A_WR_TILT)")

qmcp737c:CfgRpn(66, "(L:A_WR_GAIN) -- -5 max (>L:A_WR_GAIN)")
qmcp737c:CfgRpn(67, "(L:A_WR_GAIN) ++ 4 min (>L:A_WR_GAIN)")

qmcp737c:CfgRpn(68, "(>H:AS1000_PFD_NAV_Push)")
qmcp737c:CfgRpn(69, "(>H:AS1000_PFD_NAV_Switch)")
-- Terr
--qmcp737c:CfgRpn(70, "1 (>L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT)", "0 (>L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT)")

qmcp737c:CfgRpn(71, "1 (>L:S_FC_CAPT_INST_DISCONNECT)", "0 (>L:S_FC_CAPT_INST_DISCONNECT)")

-- Taxi lights
qmcp737c:CfgRpn(72, "0 (>L:S_OH_EXT_LT_NOSE)", "2 (>L:S_OH_EXT_LT_NOSE)")

-- Right Runway lights
qmcp737c:CfgRpn(73, "0 (>L:S_OH_EXT_LT_NAV_LOGO)", "1 (>L:S_OH_EXT_LT_NAV_LOGO)")
-- Left Runway lights
qmcp737c:CfgRpn(74, "0 (>L:S_OH_EXT_LT_RWY_TURNOFF)", "1 (>L:S_OH_EXT_LT_RWY_TURNOFF)")

-- Wheel lights
qmcp737c:CfgRpn(75, "0 (>L:S_OH_SIGNS)", "1 (>L:S_OH_SIGNS)")

-- Wing lights
qmcp737c:CfgRpn(76, "0 (>L:S_OH_EXT_LT_WING)", "1 (>L:S_OH_EXT_LT_WING)")

-- Anti Collision lights
qmcp737c:CfgRpn(77, "0 (>L:S_OH_EXT_LT_BEACON)", "1 (>L:S_OH_EXT_LT_BEACON)")

-- POS/Strobe
qmcp737c:CfgRpn(79, "2 (>L:S_OH_EXT_LT_STROBE)", "1 (>L:S_OH_EXT_LT_STROBE)")
qmcp737c:CfgRpn(78, "0 (>L:S_OH_EXT_LT_STROBE)", "1 (>L:S_OH_EXT_LT_STROBE)")

-- R Landing lights
qmcp737c:CfgRpn(80, "0 (>L:S_OH_EXT_LT_LANDING_R)", "2 (>L:S_OH_EXT_LT_LANDING_R)")
-- L Landing lights
qmcp737c:CfgRpn(81, "0 (>L:S_OH_EXT_LT_LANDING_L)", "2 (>L:S_OH_EXT_LT_LANDING_L)")

-- Logo lights
qmcp737c:CfgRpn(82, "0 (>L:S_OH_EXT_LT_NAV_LOGO)", "1 (>L:S_OH_EXT_LT_NAV_LOGO)")

qmcp737c:CfgRpn(83, "1 (>L:S_MIP_GEAR)")
qmcp737c:CfgRpn(84, "0 (>L:S_MIP_GEAR)")

-- Auto brake
-- qmcp737c:CfgRpn(85, "1 (>L:S_MIP_AUTOBRAKE_MAX)", "0 (>L:S_MIP_AUTOBRAKE_MAX)")
-- 86 off
-- 87 low
-- qmcp737c:CfgRpn(87, "1 (>L:S_MIP_AUTOBRAKE_LO)", "0 (>L:S_MIP_AUTOBRAKE_LO)")
-- qmcp737c:CfgRpn(88, "1 (>L:S_MIP_AUTOBRAKE_MED)", "0 (>L:S_MIP_AUTOBRAKE_MED)")
-- qmcp737c:CfgRpn(89, "1 (>L:S_MIP_AUTOBRAKE_MAX)", "0 (>L:S_MIP_AUTOBRAKE_MAX)")
-- qmcp737c:CfgRpn(90, "1 (>L:S_MIP_AUTOBRAKE_MAX)", "0 (>L:S_MIP_AUTOBRAKE_MAX)")

local dr_pmdg_737_autobrake_1 = uluaFind("(L:S_MIP_AUTOBRAKE_LO)")
local dr_pmdg_737_autobrake_2 = uluaFind("(L:S_MIP_AUTOBRAKE_MED)")
local dr_pmdg_737_autobrake_3 = uluaFind("(L:S_MIP_AUTOBRAKE_MAX)")
local dr_pmdg_737_autobrake_l1 = uluaFind("(L:I_MIP_AUTOBRAKE_LO_L)")
local dr_pmdg_737_autobrake_l2 = uluaFind("(L:I_MIP_AUTOBRAKE_MED_L)")
local dr_pmdg_737_autobrake_l3 = uluaFind("(L:I_MIP_AUTOBRAKE_MAX_L)")
local Autobrakebuttonstatus = -1
function FnxAutobrakeSet(dnum)
    Autobrakebuttonstatus = dnum
    FnxAutobrakeAction()
end

function FnxAutobrakeAction()
    local fnx_pos1 = uluaGet(dr_pmdg_737_autobrake_1)
    local fnx_pos2 = uluaGet(dr_pmdg_737_autobrake_2)
    local fnx_pos3 = uluaGet(dr_pmdg_737_autobrake_3)
    local fnx_posl1 = uluaGet(dr_pmdg_737_autobrake_l1)
    local fnx_posl2 = uluaGet(dr_pmdg_737_autobrake_l2)
    local fnx_posl3 = uluaGet(dr_pmdg_737_autobrake_l3)

    if Autobrakebuttonstatus == 0 then
        if fnx_posl1 > 0 then
            FnxAutobrakeSet(10)
        elseif fnx_posl2 > 0 then
            FnxAutobrakeSet(20)
        elseif fnx_posl3 > 0 then
            FnxAutobrakeSet(30)
        end
    elseif Autobrakebuttonstatus == 10 then
        uluaLog("low")
        if fnx_pos1 % 2 > 0 then
            uluaWriteCmd("0 (>L:S_MIP_AUTOBRAKE_LO)")
        else
            uluaWriteCmd("1 (>L:S_MIP_AUTOBRAKE_LO)")
            uluasetTimeout("FnxAutobrakeAction()", 300)
        end
    elseif Autobrakebuttonstatus == 20 then
        uluaLog("mid")
        if fnx_pos2 % 2 > 0 then
            uluaWriteCmd("0 (>L:S_MIP_AUTOBRAKE_MED)")
        else
            uluaWriteCmd("1 (>L:S_MIP_AUTOBRAKE_MED)")
            uluasetTimeout("FnxAutobrakeAction()", 300)
        end
    elseif Autobrakebuttonstatus == 30 then
        uluaLog("max")
        if fnx_pos3 % 2 > 0 then
            uluaWriteCmd("0 (>L:S_MIP_AUTOBRAKE_MAX)")
        else
            uluaWriteCmd("1 (>L:S_MIP_AUTOBRAKE_MAX)")
            uluasetTimeout("FnxAutobrakeAction()", 300)
        end
    end
end

qmcp737c:CfgFc(85, "FnxAutobrakeSet(30)")
qmcp737c:CfgFc(86, "FnxAutobrakeSet(0)")
qmcp737c:CfgFc(87, "FnxAutobrakeSet(10)")
qmcp737c:CfgFc(88, "FnxAutobrakeSet(20)")
qmcp737c:CfgFc(89, "")
qmcp737c:CfgFc(90, "FnxAutobrakeSet(30)")
-- flaps
qmcp737c:CfgRpn(91, "0 (>L:S_FC_FLAPS)")
qmcp737c:CfgRpn(92, "1 (>L:S_FC_FLAPS)")
qmcp737c:CfgRpn(93, "2 (>L:S_FC_FLAPS)")
qmcp737c:CfgRpn(94, "3 (>L:S_FC_FLAPS)")
qmcp737c:CfgRpn(95, "4 (>L:S_FC_FLAPS)")

-- speed brake
qmcp737c:CfgRpn(100, "1 (>L:A_FC_SPEEDBRAKE)")
qmcp737c:CfgRpn(101, "0 (>L:A_FC_SPEEDBRAKE)", "0.5 (>L:A_FC_SPEEDBRAKE)")
qmcp737c:CfgRpn(102, "2 (>L:A_FC_SPEEDBRAKE)", "0.5 (>L:A_FC_SPEEDBRAKE)")
qmcp737c:CfgRpn(103, "3 (>L:A_FC_SPEEDBRAKE)")

function ga_qmcp737c_digi_disp_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end

function ga_qmcp737c_digi_disp_powoff_mcp()
    qmcp737c:OffMcp()
end

function ga_qmcp737c_digi_disp_powoff_com()
    local i = uluaGet(idr_qmcp737c_hid_vhfa)
    i = i + 1
    if (i > 128) or (i < 0) then
        i = 1
    end
    uluaSet(idr_qmcp737c_hid_vhfa, i)
    uluaSet(idr_qmcp737c_hid_vhfs, i)
end

function ga_qmcp737c_digi_disp_powoff_nav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end

-- switches
function loop_3wayswitch(dataref, b1, b2, i1, i2, i3)
    local d_ref = uluaFind(dataref)
    local d_type = XPLMGetDataRefTypes(d_ref)
    local wdatafunc = XPLMSetDatai
    if d_type == 2 then
        wdatafunc = XPLMSetDataf
    elseif d_type == 3 then
        wdatafunc = XPLMSetDatad
    end
    if button(QMCP_ADDR + b1) then
        wdatafunc(d_ref, i1)
    elseif button(QMCP_ADDR + b2) then
        wdatafunc(d_ref, i2)
    else
        wdatafunc(d_ref, i3)
    end
end

function loop_button_toggle(dataref, b)
    local d_ref = uluaFind(dataref)
    local d_type = XPLMGetDataRefTypes(d_ref)
    local rdatafunc = XPLMGetDatai
    local wdatafunc = XPLMSetDatai
    if d_type == 2 then
        rdatafunc = XPLMGetDataf
        wdatafunc = XPLMSetDataf
    elseif d_type == 3 then
        rdatafunc = XPLMGetDatad
        wdatafunc = XPLMSetDatad
    end
    local cmd = "FlyWithLua/QMCP737C/" .. dataref
    local function btoggle()
        wdatafunc(d_ref, (rdatafunc(d_ref) + 1) % 2)
    end
    if button(QMCP_ADDR + b) and not last_button(QMCP_ADDR + b) then
        btoggle()
    end
end

----------------------------  Display Dataref Set End ------------------------------------
----------------------------  Display Dataref Set End ------------------------------------
--------X-Plane common aircraft
----------------------------  Display Dataref Set	 ------------------------------------
-- MCP Panel Digital Display
local dr_qmcp737c_bright_test = iDataRef:New("(L:S_OH_IN_LT_ANN_LT)") -- 0: DIM 1: BRT 2: test mode
local qmcp737c_com1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_nav1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_battery_on = uluaFind("(L:B_ELEC_BUS_POWER_AC_ESS, Bool)")
local qmcp737c_avionics_on = uluaFind("(L:B_ELEC_BUS_POWER_DC_BAT, Bool)")

local d_crs1 = uluaFind("(A:NAV OBS:1,Degrees)")
local d_ias = uluaFind("(L:N_FCU_SPEED)")
local d_hdg = uluaFind("(L:N_FCU_HEADING)")
local d_alt = uluaFind("(L:N_FCU_ALTITUDE)")
local d_vs = uluaFind("(L:N_FCU_VS)")
local d_crs2 = uluaFind("(A:NAV OBS:2,Degrees)")
local d_ias_8 = 0
-- d_ias_8=uluaFind( "laminar/B738/mcp/digit_8")
local d_ias_A = 0
-- d_ias_A=uluaFind( "laminar/B738/mcp/digit_A")
local dr_qmcp737c_ias_hidden = uluaFind("(L:B_FCU_SPEED_DASHED)")
local qmcp737c_vvi_show = uluaFind("(A:AUTOPILOT VERTICAL HOLD,Bool)")
-- new add C/O display
local d_is_mach = uluaFind("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")
local d_ias_mach = uluaFind("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")

-- COM Panel Digital Display
local d_com = uluaFind("(L:N_PED_RMP1_ACTIVE)")
local d_coms = uluaFind("(L:N_PED_RMP1_STDBY)")

local d_com2 = uluaFind("(L:N_PED_RMP2_ACTIVE)")
local d_com2s = uluaFind("(L:N_PED_RMP2_STDBY)")

local d_nav = uluaFind("(A:NAV ACTIVE FREQUENCY:1,MHz)")
local d_navs = uluaFind("(A:TRANSPONDER CODE:1, enum)")
local led_alth_min = 0
-- LED Indicator light
local led_app = uluaFind("(L:I_FCU_APPR)")
local led_alth = uluaFind("(L:I_FCU_ALTITUDE_MANAGED)")
local led_vs = uluaFind("(A:AUTOPILOT VERTICAL HOLD, Bool)")
local led_cmda = uluaFind("(L:I_FCU_AP1)")
local led_cmdb = uluaFind("(L:I_FCU_AP2)")

local led_lgn = uluaFind("(L:I_MIP_GEAR_2_L)")
local led_lgl = uluaFind("(L:I_MIP_GEAR_1_L)")
local led_lgr = uluaFind("(L:I_MIP_GEAR_3_L)")

local led_ma = uluaFind("(L:I_FCU_EFIS1_FD)")

local led_n1 = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")

local led_spd = uluaFind("(L:I_FCU_SPEED_SELECTED)")
local led_lvl = uluaFind("(L:I_FCU_ALTITUDE_MANAGED)")
local led_vnav = uluaFind("(L:I_FCU_SPEED_MANAGED)")
local led_hdgs = uluaFind("(A:AUTOPILOT HEADING LOCK,Bool)")
local led_lnav = uluaFind("(L:I_FCU_HEADING_MANAGED)")
local led_vorl = uluaFind("(L:I_FCU_LOC)")

local led_at = uluaFind("(L:I_FCU_ATHR)")

local led_vhf1 = uluaFind("(A:COM RECEIVE:1,bool)")
local led_vhf2 = uluaFind("(A:COM RECEIVE:2,bool)")

local ap_state = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local brightness = uluaFind("(L:N_PED_LIGHTING_PEDESTAL)")

-- VHF1/VHF2
-- cmd_vhf1_mode = uluaFind("sim/radios/com1_standy_flip")
-- cmd_vhf2_mode = uluaFind("sim/radios/com2_standy_flip")

-- cmd_vhf1_d_small = uluaFind("sim/radios/stby_com1_fine_down")
-- cmd_vhf1_u_small = uluaFind("sim/radios/stby_com1_fine_up")
-- cmd_vhf1_d_big = uluaFind("sim/radios/stby_com1_coarse_down")
-- cmd_vhf1_u_big = uluaFind("sim/radios/stby_com1_coarse_up")

-- cmd_vhf2_d_small = uluaFind("sim/radios/stby_com2_fine_down")
-- cmd_vhf2_u_small = uluaFind("sim/radios/stby_com2_fine_up")
-- cmd_vhf2_d_big = uluaFind("sim/radios/stby_com2_coarse_down")
-- cmd_vhf2_u_big = uluaFind("sim/radios/stby_com2_coarse_up")

function Qmcp737c_fnx_frame_upd()
    local qmcp737c_val_condbtn_56 = idr_qmcp737c_hid_condbtn_56:Get()
    local qmcp737c_val_condbtn_58 = idr_qmcp737c_hid_condbtn_58:Get()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    local qmcp737c_val_condbtn_61 = idr_qmcp737c_hid_condbtn_61:Get()
    ---- VHF1/VHF2 small switch
    if idr_qmcp737c_hid_condbtn_56:Changed() then
        local smallstep = idr_qmcp737c_hid_condbtn_56:Delta()
        uluaLog(string.format("small=%d  %d", smallstep, qmcp737c_val_condbtn_56))
        -- uluaSet(idr_qfcu_hid_condbtn_16, 0)
        idr_qmcp737c_hid_condbtn_56:Update()

        if qmcp737c_val_condbtn_60 == 0 then
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    uluaCmdOnce(cmd_vhf1_d_small)
                end
            else
                for i = 1, smallstep, 1 do
                    uluaCmdOnce(cmd_vhf1_u_small)
                end
            end
        else
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    uluaCmdOnce(cmd_vhf2_d_small)
                end
            else
                for i = 1, smallstep, 1 do
                    uluaCmdOnce(cmd_vhf2_u_small)
                end
            end
        end
    end
    ---- VHF1/VHF2 big switch
    if idr_qmcp737c_hid_condbtn_58:Changed() then
        local smallstep = idr_qmcp737c_hid_condbtn_58:Delta()
        uluaLog(string.format("big=%d  %d", smallstep, qmcp737c_val_condbtn_58))
        -- uluaSet(idr_qfcu_hid_condbtn_16, 0)
        idr_qmcp737c_hid_condbtn_58:Update()

        if qmcp737c_val_condbtn_60 == 0 then
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    uluaCmdOnce(cmd_vhf1_d_big)
                end
            else
                for i = 1, smallstep, 1 do
                    uluaCmdOnce(cmd_vhf1_u_big)
                end
            end
        else
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    uluaCmdOnce(cmd_vhf2_d_big)
                end
            else
                for i = 1, smallstep, 1 do
                    uluaCmdOnce(cmd_vhf2_u_big)
                end
            end
        end
    end
    ----toggle VHF1/2
    if idr_qmcp737c_hid_condbtn_60:Changed() then
        idr_qmcp737c_hid_condbtn_60:Update()
    end
    ----switch active/stanby
    if idr_qmcp737c_hid_condbtn_61:Changed() then
        idr_qmcp737c_hid_condbtn_61:Update()
        if qmcp737c_val_condbtn_60 == 0 then
            uluaCmdOnce(cmd_vhf1_mode)
            uluaLog("VHF1 flip")
        else
            uluaCmdOnce(cmd_vhf2_mode)
        end
    end
end

-- uluaAddDoLoop("Qmcp737c_fnx_frame_upd()")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function ga_qmcp737c_digi_disp_set_LEDS()
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

    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_ledvhf1, 1)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 0)
    else
        uluaSet(idr_qmcp737c_hid_ledvhf1, 0)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 1)
    end
end

-- MCP Digital Display
function ga_qmcp737c_digi_disp_set_CRS1()
    uluaSet(idr_qmcp737c_hid_crs1, uluaGet(d_crs1))
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end

-- be carefull about:
----d_ias_A
----d_ias_8
function ga_qmcp737c_digi_disp_set_IAS()
    local d_ias_mach_val = uluaGet(d_ias_mach)
    local qmcp737c_ias_hidden = uluaGet(dr_qmcp737c_ias_hidden) -- 1: blank, 0: show

    if qmcp737c_ias_hidden == 0 then
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

function ga_qmcp737c_digi_disp_set_HDG()
    uluaSet(idr_qmcp737c_hid_hdg, uluaGet(d_hdg))
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function ga_qmcp737c_digi_disp_set_ALT()
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

local d_vs_old_val = -1
function ga_qmcp737c_digi_disp_set_VS()
    local d_vs_val = uluaGet(d_vs)

    if d_vs_val < 0 then
        local dis = math.abs(d_vs_val)
        if d_vs_val ~= d_vs_old_val then
            uluaSet(idr_qmcp737c_hid_vs, dis)
            uluaSet(idr_qmcp737c_hid_vsmod, 1)
            d_vs_old_val = d_vs_val
        end
    else
        uluaSet(idr_qmcp737c_hid_vs, d_vs_val)
        uluaSet(idr_qmcp737c_hid_vsmod, 0)
    end
end

function ga_qmcp737c_digi_disp_set_CRS2()
    uluaSet(idr_qmcp737c_hid_crs2, uluaGet(d_crs2))
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

-- COM Panel
function ga_qmcp737c_digi_disp_set_VHFA()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

function ga_qmcp737c_digi_disp_set_VHFS()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_coms))
    else
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_com2s))
    end
end

function ga_qmcp737c_digi_disp_set_NAVA()
    uluaSet(idr_qmcp737c_hid_nava, uluaGet(d_nav) * 100)
    uluaSet(idr_qmcp737c_hid_navamod, 1)
end

function ga_qmcp737c_digi_disp_set_NAVS()
    uluaSet(idr_qmcp737c_hid_navs, uluaGet(d_navs)) -- * 100)
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end

-- Backlight
function ga_qmcp737c_digi_disp_set_Bright()
    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
    if uluaGet(qmcp737c_avionics_on) < 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, uluaGet(brightness) * 30)
    end
    if qmcp737c_bright_test_val == 2 then
        uluaSet(idr_qmcp737c_hid_brightmod, 1) --test mode
        uluaSet(idr_qmcp737c_hid_leds, 16777215)
    else
        uluaSet(idr_qmcp737c_hid_brightmod, 0) -- normal mode
    end
    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(uluaGet(brightness) * 2 / 100))

    if dr_qmcp737c_bright_test:Changed() then
        if qmcp737c_bright_test_val ~= 2 then
            -- refresh all data when non test mode
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        dr_qmcp737c_bright_test:Update()
    end
    if qmcp737c_bright_test_val == 2 then
        -- test mode
        return true
    else
        return false
    end
end

-----end sub functions
local ga_qmcp737c_digi_disp_mcp_func_table = { ga_qmcp737c_digi_disp_set_CRS1, ga_qmcp737c_digi_disp_set_IAS,
    ga_qmcp737c_digi_disp_set_HDG, ga_qmcp737c_digi_disp_set_ALT,
    ga_qmcp737c_digi_disp_set_VS, ga_qmcp737c_digi_disp_set_CRS2 }

local ga_qmcp737c_digi_disp_com_func_table = { ga_qmcp737c_digi_disp_set_VHFA, ga_qmcp737c_digi_disp_set_VHFS }

local ga_qmcp737c_digi_disp_nav_func_table = { ga_qmcp737c_digi_disp_set_NAVA, ga_qmcp737c_digi_disp_set_NAVS }
local ga_qmcp737c_digi_disp_rr_func_idx = 0
function ga_qmcp737c_digi_disp_mcp_rr()
    for i = 1, 6 do
        -- Round-Robin check
        ga_qmcp737c_digi_disp_rr_func_idx = ga_qmcp737c_digi_disp_rr_func_idx + 1
        if ga_qmcp737c_digi_disp_rr_func_idx > 6 then
            ga_qmcp737c_digi_disp_rr_func_idx = 1
        end
        ga_qmcp737c_digi_disp_mcp_func_table[ga_qmcp737c_digi_disp_rr_func_idx]()
    end
end

function ga_qmcp737c_digi_disp_com()
    for i = 1, 2 do
        if ga_qmcp737c_digi_disp_com_func_table[i]() then
            -- break
        end
    end
end

function ga_qmcp737c_digi_disp_nav()
    for i = 1, 2 do
        if ga_qmcp737c_digi_disp_nav_func_table[i]() then
            -- break
        end
    end
end

function fnx_qmcp737c_digi_disp_every_frame()
    if ga_qmcp737c_digi_disp_set_Bright() then
        return
    end

    if uluaGet(qmcp737c_avionics_on) > 0 then
        ga_qmcp737c_digi_disp_set_LEDS()
    else
        ga_qmcp737c_digi_disp_powoff_leds()
    end

    if uluaGet(qmcp737c_battery_on) > 0 then
        ga_qmcp737c_digi_disp_mcp_rr()
    else
        ga_qmcp737c_digi_disp_powoff_mcp()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_com1_power) > 0 then
        ga_qmcp737c_digi_disp_com()
    else
        ga_qmcp737c_digi_disp_powoff_com()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_nav1_power) > 0 then
        ga_qmcp737c_digi_disp_nav()
    else
        ga_qmcp737c_digi_disp_powoff_nav()
    end
end

uluaAddDoLoop("fnx_qmcp737c_digi_disp_every_frame()")
