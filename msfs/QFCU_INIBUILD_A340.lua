-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-10-17
-- *****************************************************************
if ilua_is_acfpath_excluded("a340") or ilua_is_acfpath_excluded("inibuild") then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QFCU for Inibuild A340")

-- A340
uluaLog("- QFCU Inibuild A340")

-- ===========================================================
-- button binding
qfcu:CfgRpn(0, "1 (>B:AIRLINER_MCU_SPEED_Dec)")
qfcu:CfgRpn(1, "1 (>B:AIRLINER_MCU_SPEED_Inc)")
qfcu:CfgVal(2, "B:AIRLINER_MCU_SPEED_PUSH", 1, 0)
qfcu:CfgVal(3, "B:AIRLINER_MCU_SPEED_PULL", 1, 0)

qfcu:CfgRpn(4, "1 (>B:AIRLINER_MCU_HDG_Dec)")
qfcu:CfgRpn(5, "1 (>B:AIRLINER_MCU_HDG_Inc)")
qfcu:CfgVal(6, "B:AIRLINER_MCU_HDG_PUSH", 1, 0)
qfcu:CfgVal(7, "B:AIRLINER_MCU_HDG_PULL", 1, 0)

-- LOC
qfcu:CfgRpn(8, "0 (>B:AIRLINER_LOC_PUSH_Set)")

qfcu:CfgRpn(9, "0 (>B:AIRLINER_AP2_PUSH_Set)")
qfcu:CfgRpn(10, "0 (>B:AIRLINER_AP1_PUSH_Set)")

-- ATHR
qfcu:CfgRpn(11, "0 (>B:AIRLINER_ATHR_PUSH_Set)")

-- EXPED
qfcu:CfgRpn(12, "0 (>B:AIRLINER_ALT_PUSH_Set)")

-- APPR
qfcu:CfgRpn(13, "0 (>B:AIRLINER_APPR_PUSH_Set)")

qfcu:CfgRpn(14, "(L:INI_FCU_METRIC_STATE) ! (>L:INI_FCU_METRIC_STATE)")

-- 100~1000
local pswh15 = QmdevPosSwitchInit("(L:INI_ALTITUDE_STATE)", 1, "(>B:AIRLINER_MCU_ALTSELECT_Toggle)",
    "(>B:AIRLINER_MCU_ALTSELECT_Toggle)", 500)
qfcu:CfgPSw(15, pswh15, 0, 1)

qfcu:CfgRpn(16, "1 (>B:AIRLINER_MCU_ALT_Dec)")
qfcu:CfgRpn(17, "1 (>B:AIRLINER_MCU_ALT_Inc)")

qfcu:CfgVal(18, "B:AIRLINER_MCU_ALT_PUSH", 1, 0)
qfcu:CfgVal(19, "B:AIRLINER_MCU_ALT_PULL", 1, 0)

qfcu:CfgRpn(20, "1 (>B:AIRLINER_MCU_VS_Dec)")
qfcu:CfgRpn(21, "1 (>B:AIRLINER_MCU_VS_Inc)")

qfcu:CfgVal(22, "B:AIRLINER_MCU_VS_PUSH", 1, 0)
qfcu:CfgVal(23, "B:AIRLINER_MCU_VS_PULL", 1, 0)

-- EFIS ROSE mode
qfcu:CfgRpn(24, "0 (>L:INI_MAP_MODE_CAPT_SWITCH)")
qfcu:CfgRpn(25, "1 (>L:INI_MAP_MODE_CAPT_SWITCH)")
qfcu:CfgRpn(26, "2 (>L:INI_MAP_MODE_CAPT_SWITCH)")
qfcu:CfgRpn(27, "3 (>L:INI_MAP_MODE_CAPT_SWITCH)")
qfcu:CfgRpn(28, "4 (>L:INI_MAP_MODE_CAPT_SWITCH)")

-- EFIS Range
qfcu:CfgRpn(29, "0 (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qfcu:CfgRpn(30, "1 (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qfcu:CfgRpn(31, "2 (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qfcu:CfgRpn(32, "3 (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qfcu:CfgRpn(33, "4 (>L:INI_MAP_RANGE_CAPT_SWITCH)")
qfcu:CfgRpn(34, "5 (>L:INI_MAP_RANGE_CAPT_SWITCH)")

-- EFIS Buttons
qfcu:CfgRpn(35, "1 (>L:INI_EFIS_CPT_CSTR_BUTTON)")
qfcu:CfgRpn(36, "1 (>L:INI_EFIS_CPT_FIXES_BUTTON)")
qfcu:CfgRpn(37, "1 (>L:INI_EFIS_CPT_VOR_BUTTON)")
qfcu:CfgRpn(38, "1 (>L:INI_EFIS_CPT_NDB_BUTTON)")

qfcu:CfgRpn(39, "1 (>L:INI_EFIS_CPT_ARPT_BUTTON)")

qfcu:CfgRpn(40, "0 (>B:AIRLINER_CPT_FD_Set)")

qfcu:CfgRpn(41, "0 (>B:AIRLINER_CPT_LS_Set)")

qfcu:CfgRpn(42, "0 (>L:AIRLINER_EFIS_CPT_VOR1_Set)",
    "1 (>B:AIRLINER_EFIS_CPT_VOR1_Set)")
qfcu:CfgRpn(43, "2 (>B:AIRLINER_EFIS_CPT_VOR1_Set)",
    "1 (>B:AIRLINER_EFIS_CPT_VOR1_Set)")

qfcu:CfgRpn(44, "0 (>L:AIRLINER_EFIS_CPT_VOR2_Set)",
    "1 (>B:AIRLINER_EFIS_CPT_VOR2_Set)")
qfcu:CfgRpn(45, "2 (>B:AIRLINER_EFIS_CPT_VOR2_Set)",
    "1 (>B:AIRLINER_EFIS_CPT_VOR2_Set)")


qfcu:CfgRpn(46, "1 (>B:AIRLINER_CPT_BARO_SET_Dec)")
qfcu:CfgRpn(47, "1 (>B:AIRLINER_CPT_BARO_SET_Inc)")


qfcu:CfgVal(48, "B:AIRLINER_CPT_BARO_SET_PUSH", 1, 0)
qfcu:CfgVal(49, "B:AIRLINER_CPT_BARO_SET_PULL", 1, 0)


qfcu:CfgRpn(50, "0 (>L:XMLVAR_Baro_Selector_HPA_1)", "1 (>L:XMLVAR_Baro_Selector_HPA_1)")


qfcu:CfgVal(51, "B:AIRLINER_FO_BARO_SET_PUSH", 1, 0)
qfcu:CfgVal(52, "B:AIRLINER_FO_BARO_SET_PULL", 1, 0)


qfcu:CfgRpn(53, "0 (>L:XMLVAR_Baro_Selector_HPA_2)", "1 (>L:XMLVAR_Baro_Selector_HPA_2)")

qfcu:CfgRpn(54, "1 (>L:INI_FCU_HDG_VS_COMMAND)")

qfcu:CfgRpn(55, "0 (>B:AIRLINER_SPDMACH_Set)")

qfcu:CfgRpn(56, "0 (>L:INI_MAP_MODE_FO_SWITCH)")
qfcu:CfgRpn(57, "1 (>L:INI_MAP_MODE_FO_SWITCH)")
qfcu:CfgRpn(58, "2 (>L:INI_MAP_MODE_FO_SWITCH)")
qfcu:CfgRpn(59, "3 (>L:INI_MAP_MODE_FO_SWITCH)")
qfcu:CfgRpn(60, "4 (>L:INI_MAP_MODE_FO_SWITCH)")

qfcu:CfgRpn(61, "0 (>L:INI_MAP_RANGE_FO_SWITCH)")
qfcu:CfgRpn(62, "1 (>L:INI_MAP_RANGE_FO_SWITCH)")
qfcu:CfgRpn(63, "2 (>L:INI_MAP_RANGE_FO_SWITCH)")
qfcu:CfgRpn(64, "3 (>L:INI_MAP_RANGE_FO_SWITCH)")
qfcu:CfgRpn(65, "4 (>L:INI_MAP_RANGE_FO_SWITCH)")
qfcu:CfgRpn(66, "5 (>L:INI_MAP_RANGE_FO_SWITCH)")

-- EFIS Buttons
qfcu:CfgRpn(67, "1 (>L:INI_EFIS_FO_CSTR_BUTTON)")
qfcu:CfgRpn(68, "1 (>L:INI_EFIS_FO_FIXES_BUTTON)")
qfcu:CfgRpn(69, "1 (>L:INI_EFIS_FO_VOR_BUTTON)")
qfcu:CfgRpn(70, "1 (>L:INI_EFIS_FO_NDB_BUTTON)")
qfcu:CfgRpn(71, "1 (>L:INI_EFIS_FO_ARPT_BUTTON)")


qfcu:CfgRpn(72, "0 (>B:AIRLINER_FO_FD_Set)")

qfcu:CfgRpn(73, "0 (>B:AIRLINER_FO_LS_Set)")


qfcu:CfgRpn(74, "0 (>L:AIRLINER_EFIS_FO_VOR1_Set)",
    "1 (>B:AIRLINER_EFIS_FO_VOR1_Set)")
qfcu:CfgRpn(75, "2 (>B:AIRLINER_EFIS_FO_VOR1_Set)",
    "1 (>B:AIRLINER_EFIS_FO_VOR1_Set)")

qfcu:CfgRpn(76, "0 (>L:AIRLINER_EFIS_FO_VOR2_Set)",
    "1 (>B:AIRLINER_EFIS_FO_VOR2_Set)")
qfcu:CfgRpn(77, "2 (>B:AIRLINER_EFIS_FO_VOR2_Set)",
    "1 (>B:AIRLINER_EFIS_FO_VOR2_Set)")



qfcu:CfgRpn(78, "1 (>B:AIRLINER_FO_BARO_SET_Dec)")
qfcu:CfgRpn(79, "1 (>B:AIRLINER_FO_BARO_SET_Inc)")

-- ===========================================================
-- Read data

-- LED Indicator light
-- fcu
local dr_qfcu_airspeed = iDataRef:New("(L:INI_AIRSPEED_DIAL)")
local dr_qfcu_preset_airspeed = iDataRef:New("(L:INI_PRESET_DIAL)") -- 230 or 0.71 MACH
local dr_qfcu_mach_airspeed = iDataRef:New("(L:INI_AIRSPEED_DIAL)")
local dr_qfcu_is_mach = iDataRef:New("(L:INI_Airspeed_is_mach)")
local dr_qfcu_heading = iDataRef:New("(L:INI_HEADING_DIAL)")
local dr_qfcu_track = iDataRef:New("(L:INI_TRK_DIAL)")
local dr_qfcu_hdgtrkmode = iDataRef:New("(L:INI_TRACK_FPA_STATE)")

qfcu:GetAlt("(L:INI_ALTITUDE_DIAL)")

local dr_qfcu_vs = iDataRef:New("(L:INI_VVI_DIAL)")
local dr_qfcu_fpa_vs = iDataRef:New("(L:INI_FPA_DIAL)")
local dr_qfcu_spddashed = iDataRef:New("(L:INI_FCU_SPD_DASHED)")
local dr_qfcu_hdgdashed = iDataRef:New("(L:INI_FCU_HDG_DASHED)")
local dr_qfcu_altmanaged = iDataRef:New(
    "(L:FMGS_vertical_mode) 20 >= (L:FMGS_vertical_mode) 23 <= && (L:FMGS_vertical_mode) 40 >= || (L:FMGS_vertical_mode) 0 == (L:INI_PITCH_MODE_ARM) 3 == && || (L:FMGS_vertical_mode) 10 == (L:INI_REST_WPT_ALT) (A:INDICATED ALTITUDE,Feet) - abs 100 < && || (>L:MfAltDot) (L:MfAltDot)")
local dr_qfcu_vsdashed = iDataRef:New("(L:INI_FCU_VS_DASHED)")

local dr_qfcu_is_spdmgd = iDataRef:New("(L:INI_FCU_SPD_DOT)")
local dr_qfcu_is_hdgmgd = iDataRef:New("(L:INI_FCU_HDG_DOT)")
-- efis capt
qfcu:GetLCstr("(L:INI_SHOW_CONSTRAINTS)")
qfcu:GetLWpt("(L:INI_SHOW_FIXES)")
qfcu:GetLVord("(L:INI_SHOW_VORS)")
qfcu:GetLNdb("(L:INI_SHOW_NDBS)")
qfcu:GetLArpt("(L:INI_SHOW_AIRPORTS)")
qfcu:GetLFd("(L:INI_FD1_ON)")
qfcu:GetLIls("(L:INI_LS_CAPTAIN)")

local dr_qfcu_c_baro = iDataRef:New(
    "(L:XMLVAR_Baro1_Mode) 2 > if{ 99 } els{ (L:XMLVAR_Baro_Selector_HPA_1,bool) ! if{ (A:KOHLSMAN SETTING HG, inHg) 0.005 - 100 * near } els{ (A:KOHLSMAN SETTING HG, mbar) near } }")
-- IN/HPA
local dr_qfcu_c_barounit = iDataRef:New("(L:XMLVAR_Baro_Selector_HPA_1)")
-- QFE:?? QNH:0 STD:3
local dr_qfcu_c_barostd = iDataRef:New("(L:XMLVAR_Baro1_Mode)")
-- EFIS FO
qfcu:GetRCstr("(L:INI_SHOW_CONSTRAINTS2)")
qfcu:GetRWpt("(L:INI_SHOW_FIXES2)")
qfcu:GetRVord("(L:INI_SHOW_VORS2)")
qfcu:GetRNdb("(L:INI_SHOW_NDBS2)")
qfcu:GetRArpt("(L:INI_SHOW_AIRPORTS2)")
qfcu:GetRFd("(L:INI_FD2_ON)")
qfcu:GetRIls("(L:INI_LS_FO)")
local dr_qfcu_f_baro = iDataRef:New(
    "(L:XMLVAR_Baro2_Mode) 2 > if{ 99 } els{ (L:XMLVAR_Baro_Selector_HPA_2,bool) ! if{ (A:KOHLSMAN SETTING HG:2, inHg) 0.005 - 100 * near } els{ (A:KOHLSMAN SETTING HG:2, mbar) near } }")
local dr_qfcu_f_barounit = iDataRef:New("(L:XMLVAR_Baro_Selector_HPA_2)")
local dr_qfcu_f_barostd = iDataRef:New("(L:XMLVAR_Baro2_Mode)")

qfcu:GetAp1("(L:INI_ap1_on)")
qfcu:GetAp2("(L:INI_ap2_on)")
qfcu:GetAthr("(L:INI_ATHR_LIGHT)")
qfcu:GetLoc("(L:INI_MCU_LOC_LIGHT)")
qfcu:GetExped("(L:INI_LEVEL_OFF_LIGHT, Bool)")
qfcu:GetAppr("(L:INI_APPROACH_BUTTON)")

-- brightness  AirbusFBW/ALT100_1000
local dr_qfcu_fcu_light = iDataRef:New("(L:INI_POTENTIOMETER_16)")                        -- 0~100
local dr_qfcu_fcu_lightDisp = iDataRef:New("(L:INI_BRIGHTNESS_SCREEN_8)")                 -- 0~100
-- annun test mode
local dr_qfcu_fcu_test = iDataRef:New("(L:INI_ANNLT_SWITCH, number)", -1)                 -- 0: TEST 1:BRT: 2: DIM
-- local dr_qfcu_fcu_power = iDataRef:New( 'sim/cockpit/electrical/cockpit_lights') -- > 0.5
local dr_qfcu_fcu_power = iDataRef:New("(L:INI_ELEC_AC_ESS_SHED_BUS_IS_POWERED, number)") -- 0: OFF  1：ON
local dr_qfcu_alt_unit = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)")
----------------------------  Display Dataref Set End ------------------------------------

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

local function digi_disp_set_LEDS_fcu()
    qfcu:SetMidLeds()
end

local function digi_disp_set_LEDS_l_efis()
    qfcu:SetLeftLeds()

    qfcu:SetLBaroMode(math.abs(dr_qfcu_c_barostd:Get() - 1))
end
local function digi_disp_set_LEDS_r_efis()
    qfcu:SetRightLeds()

    qfcu:SetRBaroMode(math.abs(dr_qfcu_f_barostd:Get() - 1))
end

local function digi_disp_set_LEDS()
    digi_disp_set_LEDS_fcu()
    digi_disp_set_LEDS_l_efis()
    digi_disp_set_LEDS_r_efis()
end
local function digi_disp_set_SPD()
    if not dr_qfcu_airspeed:ChangedUpdate() and not dr_qfcu_preset_airspeed:ChangedUpdate() and
        not dr_qfcu_mach_airspeed:ChangedUpdate() and not dr_qfcu_spddashed:ChangedUpdate() and
        not dr_qfcu_is_mach:ChangedUpdate() and not dr_qfcu_is_spdmgd:ChangedUpdate() then
        return
    end
    local qfcu_airspeed = dr_qfcu_airspeed:GetOld()
    local qfcu_preset_airspeed = dr_qfcu_preset_airspeed:GetOld()
    local qfcu_mach_airspeed = dr_qfcu_mach_airspeed:GetOld()
    local qfcu_spddashed = dr_qfcu_spddashed:GetOld()
    local qfcu_is_mach = dr_qfcu_is_mach:GetOld()
    local qfcu_is_spdmgd = dr_qfcu_is_spdmgd:GetOld()

    if qfcu_is_spdmgd == 1 then
        if qfcu_spddashed == 1 then
            if qfcu_is_mach == 1 then
                uluaSet(idr_qfcu_hid_iasmode, 4) -- dash Mach
            else
                uluaSet(idr_qfcu_hid_iasmode, 2) -- dash Knots
            end
        else
            if qfcu_is_mach == 1 then
                c_spd = qfcu_preset_airspeed
                uluaSet(idr_qfcu_hid_iasval_f, c_spd)
                uluaSet(idr_qfcu_hid_iasmode, 6) -- dot Mach
            else
                c_spd = math.floor(qfcu_preset_airspeed)
                uluaSet(idr_qfcu_hid_iasmode, 5) -- dot Knots
                uluaSet(idr_qfcu_hid_iasval_i, c_spd)
            end
        end
    else
        if qfcu_spddashed == 1 then
            uluaSet(idr_qfcu_hid_iasmode, 2) -- dash Knots
        else
            if qfcu_is_mach == 1 then
                c_spd = qfcu_mach_airspeed + 0.005
                uluaSet(idr_qfcu_hid_iasval_f, c_spd)
                uluaSet(idr_qfcu_hid_iasmode, 3) -- Mach
            else
                c_spd = math.floor(qfcu_airspeed + 0.5)
                uluaSet(idr_qfcu_hid_iasmode, 1) -- Knots
                uluaSet(idr_qfcu_hid_iasval_i, c_spd)
            end
        end
    end
end
local function digi_disp_set_HDG()
    if not dr_qfcu_heading:ChangedUpdate() and not dr_qfcu_hdgdashed:ChangedUpdate() and
        not dr_qfcu_is_hdgmgd:ChangedUpdate() and not dr_qfcu_track:ChangedUpdate() and not dr_qfcu_hdgtrkmode:Changed() then
        return
    end
    local qfcu_heading = dr_qfcu_heading:GetOld()
    local qfcu_hdgdashed = dr_qfcu_hdgdashed:GetOld()
    local qfcu_is_hdgmgd = dr_qfcu_is_hdgmgd:GetOld()
    local qfcu_track = dr_qfcu_track:GetOld()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:GetOld()
    if qfcu_hdgtrkmode == 1 then
        qfcu_heading = qfcu_track
    end

    if qfcu_is_hdgmgd == 1 then
        if qfcu_hdgdashed == 1 then
            uluaSet(idr_qfcu_hid_hdgmode, 2) -- dash
        else
            uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading))
            uluaSet(idr_qfcu_hid_hdgmode, 3) -- dot hdg
        end
    else
        if qfcu_hdgdashed == 1 then
            uluaSet(idr_qfcu_hid_hdgmode, 2) -- dash hdg
        else
            uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading))
            uluaSet(idr_qfcu_hid_hdgmode, 1)
        end
    end
end
local function digi_disp_set_ALT()
    local altdot = dr_qfcu_altmanaged:Get()
    -- uluaLog(string.format("Alt dot=%f", altdot))
    qfcu:SetAlt(altdot > 0)
end

local function digi_disp_set_VS()
    if not dr_qfcu_vs:ChangedUpdate() and not dr_qfcu_hdgtrkmode:ChangedUpdate() and
        not dr_qfcu_vsdashed:ChangedUpdate() and not dr_qfcu_fpa_vs:ChangedUpdate() then
        return
    end
    local qfcu_vs = dr_qfcu_vs:GetOld()
    local qfcu_fpa_vs = dr_qfcu_fpa_vs:GetOld()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:GetOld()
    local qfcu_vsdashed = dr_qfcu_vsdashed:GetOld()

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
            ---idr_qfcu_hid_vs_trkval_i need 0.8*1000=800
            uluaLog(string.format("FPA VS=%f", qfcu_fpa_vs))
            uluaSet(idr_qfcu_hid_vs_trkval_i, math.abs(math.floor(qfcu_fpa_vs * 1000)))
            if qfcu_fpa_vs < 0 then
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
-----------EFIS Capt-------------
local function digi_disp_set_L_EFIS()
    if not dr_qfcu_c_baro:ChangedUpdate() and not dr_qfcu_c_barounit:ChangedUpdate() and
        not dr_qfcu_c_barostd:ChangedUpdate() then
        return
    end
    local qfcu_c_baro = dr_qfcu_c_baro:GetOld()
    local qfcu_c_barounit = dr_qfcu_c_barounit:GetOld()
    local qfcu_c_barostd = dr_qfcu_c_barostd:GetOld()

    if qfcu_c_barostd == 2 or qfcu_c_barostd == 3 then -- std
        qfcu:SetLBaro(3)
    else
        if qfcu_c_barounit == 1 then -- hpa mode:29.92
            qfcu:SetLBaro(2, qfcu_c_baro)
        else
            qfcu:SetLBaro(1, qfcu_c_baro)
        end
    end
end
---------------------EFIS FO-------------
local function digi_disp_set_R_EFIS()
    if not dr_qfcu_f_baro:ChangedUpdate() and not dr_qfcu_f_barounit:ChangedUpdate() and
        not dr_qfcu_f_barostd:ChangedUpdate() then
        return
    end
    local qfcu_f_baro = dr_qfcu_f_baro:GetOld()
    local qfcu_f_barounit = dr_qfcu_f_barounit:GetOld()
    local qfcu_f_barostd = dr_qfcu_f_barostd:GetOld()

    if qfcu_f_barostd == 2 or qfcu_f_barostd == 3 then -- std
        qfcu:SetRBaro(3)
    else
        if qfcu_f_barounit == 1 then -- hpa mode:29.92
            qfcu:SetRBaro(2, qfcu_f_baro)
        else
            qfcu:SetRBaro(1, qfcu_f_baro)
        end
    end
end
local function invalid_buffer_digi()
    -- update cache
    dr_qfcu_airspeed:Invalid(-1)
    dr_qfcu_heading:Invalid(-1)
    qfcu:FreshAlt()
    dr_qfcu_vsdashed:Invalid(11)
    dr_qfcu_c_baro:Invalid(-1)
    dr_qfcu_f_baro:Invalid(-1)
end
-- Backlight
local function digi_disp_set_Bright()
    local qfcu_fcu_light = dr_qfcu_fcu_light:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_fcu_lightDisp = dr_qfcu_fcu_lightDisp:Get()
    if dr_qfcu_fcu_light:Changed() or dr_qfcu_fcu_lightDisp:Changed() then
        dr_qfcu_fcu_light:Update()
        dr_qfcu_fcu_lightDisp:Update()
        -- real code
        -------------------------------------------------------------
        uluaSet(idr_qfcu_hid_brightval_i, math.floor(qfcu_fcu_light * 0.4))
        uluaSet(idr_qfcu_hid_dispbrightval_i, math.floor(qfcu_fcu_lightDisp / 33))
    end
    if dr_qfcu_fcu_test:ChangedUpdate() then
        uluaSet(idr_qfcu_hid_indbrightval_i, 3 - qfcu_fcu_test)
        if qfcu_fcu_test ~= 0 then
            invalid_buffer_digi()
            uluaSet(idr_qfcu_hid_invalid, -1)
        end
    end
end
-------------------------------------------------------------

local function digi_disp_set_BrightOff()
    dr_qfcu_fcu_light:Invalid(-1)
    dr_qfcu_fcu_lightDisp:Invalid(-1)
    qfcu:SetDigiBrtOff()
end

local function digi_disp_powoff_leds()
    qfcu:SetLedsOff()
end

local function digi_disp_powoff_mcp()
    invalid_buffer_digi()
    -- real code
    qfcu:SetDigiOff()
end

-----end sub functions
local digi_disp_fcu_func_table = { digi_disp_set_SPD, digi_disp_set_HDG, digi_disp_set_ALT, digi_disp_set_VS,
    digi_disp_set_L_EFIS, digi_disp_set_R_EFIS }

local digi_disp_rr_func_idx = 0

local function digi_disp_mcp_rr()
    for i = 1, #digi_disp_fcu_func_table do
        -- Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx % #digi_disp_fcu_func_table + 1
        digi_disp_fcu_func_table[digi_disp_rr_func_idx]()
    end
end

function qfcu_inia340_digi_disp_every_frame()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_alt_unit = dr_qfcu_alt_unit:Get()
    if dr_qfcu_fcu_power:ChangedUpdate() then
        if qfcu_fcu_power > 0 then
            dr_qfcu_fcu_test:Invalid(os.clock())
            uluaSet(idr_qfcu_hid_invalid, -1)
        else
            digi_disp_powoff_leds()
            digi_disp_powoff_mcp()
            digi_disp_set_BrightOff()
        end
    end

    -------------------
    if qfcu_fcu_power > 0 then
        digi_disp_set_Bright()
        digi_disp_set_LEDS()
        digi_disp_mcp_rr()
    end
end

uluaAddDoLoop("qfcu_inia340_digi_disp_every_frame()")
