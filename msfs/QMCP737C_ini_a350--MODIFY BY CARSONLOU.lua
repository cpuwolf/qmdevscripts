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
-- modified by Carson Lou @ QQ 2025-07-20
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBightness = 30       -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.
--
-- ########################################################

if ilua_is_acfpath_excluded("a350") or ilua_is_acfpath_excluded("inibuild") then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C  inibuild a350\n")

qmcp737c:CfgRpn(0, "(>H:AS1000_PFD_CRS_DEC)")
qmcp737c:CfgRpn(1, "(>H:AS1000_PFD_CRS_INC)")

-- FD
qmcp737c:CfgRpn(2, "(L:INI_FD_ON) ! (>L:INI_FD_ON)", "(L:INI_FD_ON) ! (>L:INI_FD_ON)")

-- SPD
qmcp737c:CfgEnc(4, 5, "B:AIRLINER_FCU_SPD_KNOB")

-- SPD MANAGED
qmcp737c:CfgRpn(6, "1 (>L:INI_FCU_MANAGED_SPEED_BUTTON)")

-- SPD SELECTED
qmcp737c:CfgRpn(8, "1 (>L:INI_FCU_SELECTED_SPEED_BUTTON)")

qmcp737c:CfgRpn(9, "(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)")

-- SPD/MACH BUTTON
qmcp737c:CfgRpn(10, "1 (>L:INI_SPD_MACH_BUTTON)")

qmcp737c:CfgRpn(11, "(L:XMLVAR_VNAVButtonValue, Bool) ! (>L:XMLVAR_VNAVButtonValue)")

-- HDG
qmcp737c:CfgEnc(12, 13, "B:AIRLINER_FCU_HDG_KNOB")

-- HDG MANAGED
qmcp737c:CfgRpn(14, "1 (>L:INI_FCU_MANAGED_HEADING_BUTTON)")

-- HDG SELECTED
qmcp737c:CfgRpn(15, "1 (>L:INI_FCU_SELECTED_HEADING_BUTTON)")

-- ALT
qmcp737c:CfgEnc(16, 17, "B:AIRLINER_FCU_ALT_KNOB")

-- ALT 100/1000
qmcp737c:CfgRpn(18, "1 (>L:INI_FCU_ALTITUDE_MODE_COMMAND)")

qmcp737c:CfgRpn(19, "(>K:AP_NAV1_HOLD)")

-- LOC BUTTON
qmcp737c:CfgRpn(20, "1 (>L:AP6_BUTTON)")

qmcp737c:CfgRpn(21, "(>K:AP_APR_HOLD)")

-- ALT SELECTED
qmcp737c:CfgRpn(22, "1 (>L:INI_FCU_ALTITUDE_PULL_COMMAND)")

qmcp737c:CfgRpn(23, "1 (>L:AP9_BUTTON)")

-- V/S
qmcp737c:CfgEnc(24, 25, "B:AIRLINER_FCU_VS_KNOB")

-- ALT MANAGED
qmcp737c:CfgRpn(29, "1 (>L:INI_FCU_ALTITUDE_PUSH_COMMAND)")

qmcp737c:CfgRpn(30, "1 (>L:INI_AP1_BUTTON) ")
qmcp737c:CfgRpn(31, "1 (>L:INI_AP2_BUTTON) ")

-- CSTR
qmcp737c:CfgRpn(39, "1 (>L:INI_EFIS_CPT_CSTR_BUTTON) , 1 (>L:INI_EFIS_FO_CSTR_BUTTON)")

-- BARO
qmcp737c:CfgEnc(48, 49, "B:AIRLINER_EFIS_QNH_PRESSURE_SELECTOR_LEFT")

-- BARO STD
qmcp737c:CfgRpn(50, "1 (>L:INI_1_ALTIMETER_PUSH_COMMAND)")

-- BARO PULL
qmcp737c:CfgRpn(36, "1 (>L:INI_1_ALTIMETER_PULL_COMMAND)")

-- BARO INHG/HPA SELECT
qmcp737c:CfgRpn(32,
    "0 (>L:XMLVAR_BARO_Selector_HPA_1) , 0 (>L:XMLVAR_BARO_Selector_HPA_2) , 0 (>L:XMLVAR_BARO_Selector_HPA_3)")
qmcp737c:CfgRpn(33,
    "1 (>L:XMLVAR_BARO_Selector_HPA_1) , 1 (>L:XMLVAR_BARO_Selector_HPA_2) , 1 (>L:XMLVAR_BARO_Selector_HPA_3)")

-- FCU LS BUTTON
qmcp737c:CfgRpn(38, "(L:INI_LS_CAPTAIN) ! (>L:INI_LS_CAPTAIN) , (L:INI_LS_FO) ! (>L:INI_LS_FO)")

-- METER BUTTON
qmcp737c:CfgRpn(43, "(L:INI_FCU_METRIC_STATE) ! (>L:INI_FCU_METRIC_STATE)")

-- EIFS L MAP MODE
qmcp737c:CfgRpn(42, "(L:INI_MAP_MODE_CAPT_SWITCH) -- 0 max 4 min (>L:INI_MAP_MODE_CAPT_SWITCH)")
qmcp737c:CfgRpn(41, "(L:INI_MAP_MODE_CAPT_SWITCH) ++ 0 max 4 min (>L:INI_MAP_MODE_CAPT_SWITCH)")

-- EIFS L RANGE
qmcp737c:CfgRpn(51, "(L:INI_MAP_RANGE_CAPT_SWITCH) -- 0 max 11 min (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qmcp737c:CfgRpn(52, "(L:INI_MAP_RANGE_CAPT_SWITCH) ++ 0 max 11 min (>L:INI_MAP_RANGE_CAPT_SWITCH)")

-- TRAF
qmcp737c:CfgRpn(53, "1 (>L:INI_EFIS_BSK_4_CPT) , 1 (>L:INI_EFIS_BSK_4_FO)")

-- TERR
qmcp737c:CfgRpn(70, "1 (>L:INI_EFIS_BSK_3_CPT) , 1 (>L:INI_EFIS_BSK_3_FO)")

-- WPT
qmcp737c:CfgRpn(44, "1 (>L:INI_EFIS_CPT_FIXES_BUTTON) , 1 (>L:INI_EFIS_FO_FIXES_BUTTON)")

-- VORD
qmcp737c:CfgRpn(47, "1 (>L:INI_EFIS_CPT_VOR_BUTTON) , 1 (>L:INI_EFIS_FO_VOR_BUTTON)")

-- NDB
qmcp737c:CfgRpn(46, "1 (>L:INI_EFIS_CPT_NDB_BUTTON) , 1 (>L:INI_EFIS_FO_NDB_BUTTON)")

-- APRT
qmcp737c:CfgRpn(45, "1 (>L:INI_EFIS_CPT_ARPT_BUTTON) , 1 (>L:INI_EFIS_FO_ARPT_BUTTON)")

-- VOR/ADF
qmcp737c:CfgRpn(34, "1 (>L:INI_EFIS_BSK_1_CPT) , 1 (>L:INI_EFIS_BSK_1_FO)")
qmcp737c:CfgRpn(35, "1 (>L:INI_EFIS_BSK_1_CPT) , 1 (>L:INI_EFIS_BSK_1_FO)")

qmcp737c:CfgRpn(55, "1 (>L:INI_EFIS_BSK_5_CPT) , 1 (>L:INI_EFIS_BSK_5_FO)")
qmcp737c:CfgRpn(54, "1 (>L:INI_EFIS_BSK_5_CPT) , 1 (>L:INI_EFIS_BSK_5_FO)")

qmcp737c:CfgRpn(56, "(>H:AS1000_PFD_COM_Small_DEC)")
qmcp737c:CfgRpn(57, "(>H:AS1000_PFD_COM_Small_INC)")
qmcp737c:CfgRpn(58, "(>H:AS1000_PFD_COM_Large_DEC)")
qmcp737c:CfgRpn(59, "(>H:AS1000_PFD_COM_Large_INC)")
qmcp737c:CfgRpn(60, "(>H:AS1000_PFD_COM_Push)")
qmcp737c:CfgRpn(61, "(>H:AS1000_PFD_COM_Switch)")

qmcp737c:CfgRpn(64, "(>H:AS1000_PFD_NAV_Small_DEC)")
qmcp737c:CfgRpn(65, "(>H:AS1000_PFD_NAV_Small_INC)")

qmcp737c:CfgRpn(66, "(>H:AS1000_PFD_NAV_Large_DEC)")
qmcp737c:CfgRpn(67, "(>H:AS1000_PFD_NAV_Large_INC)")

qmcp737c:CfgRpn(68, "(>H:AS1000_PFD_NAV_Push)")
qmcp737c:CfgRpn(69, "(>H:AS1000_PFD_NAV_Switch)")

qmcp737c:CfgRpn(71, "(>K:AUTOPILOT_DISENGAGE_TOGGLE)")

qmcp737c:CfgRpn(83, "(>K:GEAR_DOWN)")
qmcp737c:CfgRpn(84, "(>K:GEAR_UP)")

function ini_a350_qmcp737c_digi_disp_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end

function ini_a350_qmcp737c_digi_disp_powoff_mcp()
    qmcp737c:OffMcp()
end

function ini_a350_qmcp737c_digi_disp_powoff_com()
    uluaSet(idr_qmcp737c_hid_vhfa, 0)
    uluaSet(idr_qmcp737c_hid_vhfs, 0)
end

function ini_a350_qmcp737c_digi_disp_powoff_nav()
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
local dr_qmcp737c_bright_test = iDataRef:New("(L:INI_ANNLT_SWITCH)") -- 0: test 1: BRT 2: DIM
local qmcp737c_com1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_nav1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_battery_on = uluaFind("(L:INI_battery_on, BOOL)")
local qmcp737c_avionics_on = uluaFind("(L:INI_ELEC_AC_ESS_SHED_BUS_IS_POWERED, BOOL)")

local d_crs1 = uluaFind("(A:NAV OBS:1,Degrees)")
--local d_ias = uluaFind("(L:INI_FCU_SPD_DASHED, Bool) if{ '---' } els{ (L:INI_AIRSPEED_IS_MACH, Bool) if{ %(L:INI_AIRSPEED_DIAL, Number )%!01.2f! } els{ %(L:INI_AIRSPEED_DIAL, Number )%!d! } }")
local d_ias = uluaFind("(A:AUTOPILOT AIRSPEED HOLD VAR, knot)")
local d_hdg = uluaFind("(A:AUTOPILOT HEADING LOCK DIR,Degrees)")
local d_alt = uluaFind("(A:AUTOPILOT ALTITUDE LOCK VAR,Feet)")

qmcp737c:GetVs("(A:AUTOPILOT VERTICAL HOLD VAR,Feet/minute)", "(A:CIRCUIT AVIONICS ON,Bool)")

local d_crs2 = uluaFind("(A:NAV OBS:2,Degrees)")
local d_ias_8 = 0
-- d_ias_8=uluaFind( "laminar/B738/mcp/digit_8")
local d_ias_A = 0
-- d_ias_A=uluaFind( "laminar/B738/mcp/digit_A")
local qmcp737c_ias_show = 1
local qmcp737c_vvi_show = uluaFind("(A:AUTOPILOT VERTICAL HOLD,Bool)")
-- new add C/O display
local d_is_mach = uluaFind("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")
local d_ias_mach = uluaFind("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")

-- COM Panel Digital Display
local d_com = uluaFind("(A:COM ACTIVE FREQUENCY:1,KHz)")
local d_coms = uluaFind("(A:COM STANDBY FREQUENCY:1, KHz) near")

local d_com2 = uluaFind("(A:COM ACTIVE FREQUENCY:2,KHz)")
local d_com2s = uluaFind("(A:COM STANDBY FREQUENCY:2, KHz) near")

local d_nav = uluaFind("(A:NAV ACTIVE FREQUENCY:1,MHz)")
local d_navs = uluaFind("(A:NAV STANDBY FREQUENCY:1,MHz)")
local led_alth_min = 0
-- LED Indicator light
local led_app = uluaFind("(L:INI_APPROACH_BUTTON)")
local led_alth = uluaFind("(L:INI_LEVEL_OFF_LIGHT)")
local led_vs = uluaFind("(L:INI_FCU_VS_DASHED)")
local led_cmda = uluaFind("(L:INI_ap1_on)")
local led_cmdb = uluaFind("(L:INI_ap2_on)")

local led_lgn = uluaFind("(A:GEAR CENTER POSITION, percent over 100)")
local led_lgl = uluaFind("(A:GEAR LEFT POSITION, percent over 100)")
local led_lgr = uluaFind("(A:GEAR RIGHT POSITION, percent over 100)")

local led_ma = uluaFind("(L:INI_FD_ON)")

local led_n1 = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")

local led_spd = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")
local led_lvl = uluaFind("(A:AUTOPILOT FLIGHT LEVEL CHANGE, bool)")
local led_vnav = uluaFind("(L:INI_MANAGED_SPEED)")
local led_hdgs = uluaFind("(A:AUTOPILOT HEADING LOCK,Bool)")
local led_lnav = uluaFind("(L:INI_FCU_HDG_DASHED)")
local led_vorl = uluaFind("(L:INI_MCU_LOC_LIGHT)")

local led_at = uluaFind("(L:INI_ATHR_LIGHT)")

local led_vhf1 = uluaFind("(A:COM RECEIVE:1,bool)")
local led_vhf2 = uluaFind("(A:COM RECEIVE:2,bool)")

local ap_state = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local brightness = uluaFind("(L:INI_CKPT_LT_INTEG)")

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

function Qmcp737c_ga_frame_upd()
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

-- uluaAddDoLoop("Qmcp737c_ga_frame_upd()")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

function ini_a350_qmcp737c_digi_disp_set_LEDS()
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

    uluaSet(idr_qmcp737c_hid_ledvhf1, uluaGet(led_vhf1))
    uluaSet(idr_qmcp737c_hid_ledvhf2, uluaGet(led_vhf2))
end

-- MCP Digital Display
function ini_a350_qmcp737c_digi_disp_set_CRS1()
    uluaSet(idr_qmcp737c_hid_crs1, uluaGet(d_crs1))
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end

-- be carefull about:
----d_ias_A
----d_ias_8
function ini_a350_qmcp737c_digi_disp_set_IAS()
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

function ini_a350_qmcp737c_digi_disp_set_HDG()
    uluaSet(idr_qmcp737c_hid_hdg, uluaGet(d_hdg))
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function ini_a350_qmcp737c_digi_disp_set_ALT()
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

function ini_a350_qmcp737c_digi_disp_set_VS()
    qmcp737c:SetVs()
end

function ini_a350_qmcp737c_digi_disp_set_CRS2()
    uluaSet(idr_qmcp737c_hid_crs2, uluaGet(d_crs2))
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

-- COM Panel
function ini_a350_qmcp737c_digi_disp_set_VHFA()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if 0 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

function ini_a350_qmcp737c_digi_disp_set_VHFS()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if 0 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_coms))
    else
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_com2s))
    end
end

function ini_a350_qmcp737c_digi_disp_set_NAVA()
    uluaSet(idr_qmcp737c_hid_nava, uluaGet(d_nav) * 100)
    uluaSet(idr_qmcp737c_hid_navamod, 1)
end

function ini_a350_qmcp737c_digi_disp_set_NAVS()
    uluaSet(idr_qmcp737c_hid_navs, uluaGet(d_navs) * 100)
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end

-- Backlight
function ini_a350_qmcp737c_digi_disp_set_Bright()
    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
    if uluaGet(qmcp737c_avionics_on) < 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, uluaGet(brightness) * MaxBightness / 100)
    end
    if qmcp737c_bright_test_val == 0 then
        uluaSet(idr_qmcp737c_hid_brightmod, 1) --test mode
        uluaSet(idr_qmcp737c_hid_leds, 16777215)
    else
        uluaSet(idr_qmcp737c_hid_brightmod, 0) -- normal mode
    end
    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(uluaGet(brightness) * 2 / 100))

    if dr_qmcp737c_bright_test:ChangedUpdate() then
        if qmcp737c_bright_test_val ~= 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
    end
    if qmcp737c_bright_test_val == 0 then
        -- test mode
        return true
    else
        return false
    end
end

-----end sub functions
local ini_a350_qmcp737c_digi_disp_mcp_func_table = { ini_a350_qmcp737c_digi_disp_set_CRS1,
    ini_a350_qmcp737c_digi_disp_set_IAS,
    ini_a350_qmcp737c_digi_disp_set_HDG,
    ini_a350_qmcp737c_digi_disp_set_ALT,
    ini_a350_qmcp737c_digi_disp_set_VS,
    ini_a350_qmcp737c_digi_disp_set_CRS2 }

local ini_a350_qmcp737c_digi_disp_com_func_table = { ini_a350_qmcp737c_digi_disp_set_VHFA,
    ini_a350_qmcp737c_digi_disp_set_VHFS }

local ini_a350_qmcp737c_digi_disp_nav_func_table = { ini_a350_qmcp737c_digi_disp_set_NAVA,
    ini_a350_qmcp737c_digi_disp_set_NAVS }
local ini_a350_qmcp737c_digi_disp_rr_func_idx = 0
function ini_a350_qmcp737c_digi_disp_mcp_rr()
    for i = 1, 6 do
        -- Round-Robin check
        ini_a350_qmcp737c_digi_disp_rr_func_idx = ini_a350_qmcp737c_digi_disp_rr_func_idx + 1
        if ini_a350_qmcp737c_digi_disp_rr_func_idx > 6 then
            ini_a350_qmcp737c_digi_disp_rr_func_idx = 1
        end
        ini_a350_qmcp737c_digi_disp_mcp_func_table[ini_a350_qmcp737c_digi_disp_rr_func_idx]()
    end
end

function ini_a350_qmcp737c_digi_disp_com()
    for i = 1, 2 do
        if ini_a350_qmcp737c_digi_disp_com_func_table[i]() then
            -- break
        end
    end
end

function ini_a350_qmcp737c_digi_disp_nav()
    for i = 1, 2 do
        if ini_a350_qmcp737c_digi_disp_nav_func_table[i]() then
            -- break
        end
    end
end

function ini_a350_qmcp737c_digi_disp_every_frame()
    if ini_a350_qmcp737c_digi_disp_set_Bright() then
        return
    end

    if uluaGet(qmcp737c_avionics_on) > 0 then
        ini_a350_qmcp737c_digi_disp_set_LEDS()
    else
        ini_a350_qmcp737c_digi_disp_powoff_leds()
    end

    if uluaGet(qmcp737c_battery_on) > 0 then
        ini_a350_qmcp737c_digi_disp_mcp_rr()
    else
        ini_a350_qmcp737c_digi_disp_powoff_mcp()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_com1_power) > 0 then
        ini_a350_qmcp737c_digi_disp_com()
    else
        ini_a350_qmcp737c_digi_disp_powoff_com()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_nav1_power) > 0 then
        ini_a350_qmcp737c_digi_disp_nav()
    else
        ini_a350_qmcp737c_digi_disp_powoff_nav()
    end
end

uluaAddDoLoop("ini_a350_qmcp737c_digi_disp_every_frame()")
