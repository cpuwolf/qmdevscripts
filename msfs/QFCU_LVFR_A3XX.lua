-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBrightness = 100 -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.

-- ###############################################################################################
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-05-12 LVFR

if ilua_is_acfpath_excluded("lvfr") or ilua_is_acfpath_excluded("a3") then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QFCU LVFR A3XX")

-- ===========================================================
-- button binding

qfcu:CfgEnc(0, 1, "B:AUTOPILOT_Speed")
qfcu:CfgVal(2, "B:AUTOPILOT_Speed_Managed", 1, 0)
qfcu:CfgVal(3, "B:AUTOPILOT_Speed_Selected", 1, 0)

qfcu:CfgEnc(4, 5, "B:AUTOPILOT_Heading")
qfcu:CfgVal(6, "B:AUTOPILOT_Heading_Managed", 1, 0)
qfcu:CfgVal(7, "B:AUTOPILOT_Heading_Selected", 1, 0)

qfcu:CfgVal(8, "B:AUTOPILOT_Localizer_Button", 1, 0)

qfcu:CfgVal(9, "B:AUTOPILOT_AP_2", 1, 0)
qfcu:CfgVal(10, "B:AUTOPILOT_AP_1", 1, 0)

qfcu:CfgVal(11, "B:AUTOPILOT_AutoThrottle_1", 1, 0)

qfcu:CfgVal(12, "B:AUTOPILOT_Expedite_Mode", 1, 0)
qfcu:CfgVal(13, "B:AUTOPILOT_Approach_Button", 1, 0)

qfcu:CfgVal(14, "B:AIRLINER_Metric_Alt", 1, 0)

qfcu:CfgRpn(15, "100 (>L:XMLVAR_Autopilot_Altitude_Increment)",
    "1000 (>L:XMLVAR_Autopilot_Altitude_Increment)")

qfcu:CfgEnc(16, 17, "B:AUTOPILOT_Altitude")
qfcu:CfgVal(18, "B:AUTOPILOT_Altitude_Managed", 1, 0)
qfcu:CfgVal(19, "B:AUTOPILOT_Altitude_Selected", 1, 0)

qfcu:CfgEnc(20, 21, "B:AUTOPILOT_VerticalSpeed")
qfcu:CfgVal(22, "B:AUTOPILOT_VerticalSpeed_Zero", 1, 0)
qfcu:CfgVal(23, "B:AUTOPILOT_VerticalSpeed_Hold", 1, 0)

-- EFIS ROSE mode
local b_lvfr_rose_mode = uluaFind("B:AIRLINER_ROSE_Mode")
function LvfrRoseModeSet(dnum)
    uluaSet(b_lvfr_rose_mode, dnum)
end

qfcu:CfgFc(24, "LvfrRoseModeSet(0)")
qfcu:CfgFc(25, "LvfrRoseModeSet(1)")
qfcu:CfgFc(26, "LvfrRoseModeSet(2)")
qfcu:CfgFc(27, "LvfrRoseModeSet(3)")
qfcu:CfgFc(28, "LvfrRoseModeSet(4)")

-- EFIS Range
local b_lvfr_range = uluaFind("B:AIRLINER_ND_Range_1")
function LvfrRangeSet(dnum)
    uluaSet(b_lvfr_range, dnum)
end

qfcu:CfgFc(29, "LvfrRangeSet(0)")
qfcu:CfgFc(30, "LvfrRangeSet(1)")
qfcu:CfgFc(31, "LvfrRangeSet(2)")
qfcu:CfgFc(32, "LvfrRangeSet(3)")
qfcu:CfgFc(33, "LvfrRangeSet(4)")
qfcu:CfgFc(34, "LvfrRangeSet(5)")

qfcu:CfgFc(35, 'uluaSet(uluaFind("B:AIRLINER_CSTR"), 1-uluaGet(uluaFind("(L:BTN_CSTR_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(36, 'uluaSet(uluaFind("B:AIRLINER_WPT"), 1-uluaGet(uluaFind("(L:BTN_WPT_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(37, 'uluaSet(uluaFind("B:AIRLINER_VORD"), 1-uluaGet(uluaFind("(L:BTN_VORD_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(38, 'uluaSet(uluaFind("B:AIRLINER_NDB"), 1-uluaGet(uluaFind("(L:BTN_NDB_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(39, 'uluaSet(uluaFind("B:AIRLINER_ARPT"), 1-uluaGet(uluaFind("(L:BTN_ARPT_FILTER_ACTIVE)")))', "")

qfcu:CfgRpn(40, "(>K:TOGGLE_FLIGHT_DIRECTOR)")

qfcu:CfgFc(41, 'uluaSet(uluaFind("B:AIRLINER_LS"), 1-uluaGet(uluaFind("(L:BTN_LS_FILTER_ACTIVE)")))', "")

qfcu:CfgVal(42, "B:AIRLINER_L_VOR_ADF_1", 0, 1)
qfcu:CfgVal(43, "B:AIRLINER_L_VOR_ADF_1", 2, 1)

qfcu:CfgVal(44, "B:AIRLINER_L_VOR_ADF_2", 0, 1)
qfcu:CfgVal(45, "B:AIRLINER_L_VOR_ADF_2", 2, 1)

qfcu:CfgEnc(47, 46, "B:AUTOPILOT_Baro_1")
qfcu:CfgVal(48, "B:AUTOPILOT_Baro_1_QNH", 0, 1)
qfcu:CfgVal(49, "B:AUTOPILOT_Baro_1_STD", 1, 0)

qfcu:CfgRpn(50, "0 (>L:XMLVAR_Baro_Selector_HPA_1)", "1 (>L:XMLVAR_Baro_Selector_HPA_1)")

qfcu:CfgVal(51, "B:AUTOPILOT_Baro_2_QNH", 0, 1)
qfcu:CfgVal(52, "B:AUTOPILOT_Baro_2_STD", 0, 1)

qfcu:CfgRpn(53, "0 (>L:XMLVAR_Baro_Selector_HPA_1)", "1 (>L:XMLVAR_Baro_Selector_HPA_1)")

qfcu:CfgFc(54, 'uluaSet(uluaFind("B:AIRLINER_HDG_TRK"), 1-uluaGet(uluaFind("(L:XMLVAR_TRK_FPA_MODE_ACTIVE)")))', "")

qfcu:CfgFc(55,
    'uluaSet(uluaFind("B:AUTOPILOT_SpeedToggle_Mode"), 1-uluaGet(uluaFind("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")))',
    "")

qfcu:CfgFc(56, "LvfrRoseModeSet(0)")
qfcu:CfgFc(57, "LvfrRoseModeSet(1)")
qfcu:CfgFc(58, "LvfrRoseModeSet(2)")
qfcu:CfgFc(59, "LvfrRoseModeSet(3)")
qfcu:CfgFc(60, "LvfrRoseModeSet(4)")

qfcu:CfgFc(61, "LvfrRangeSet(0)")
qfcu:CfgFc(62, "LvfrRangeSet(1)")
qfcu:CfgFc(63, "LvfrRangeSet(2)")
qfcu:CfgFc(64, "LvfrRangeSet(3)")
qfcu:CfgFc(65, "LvfrRangeSet(4)")
qfcu:CfgFc(66, "LvfrRangeSet(5)")

qfcu:CfgFc(67, 'uluaSet(uluaFind("B:AIRLINER_CSTR"), 1-uluaGet(uluaFind("(L:BTN_CSTR_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(68, 'uluaSet(uluaFind("B:AIRLINER_WPT"), 1-uluaGet(uluaFind("(L:BTN_WPT_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(68, 'uluaSet(uluaFind("B:AIRLINER_VORD"), 1-uluaGet(uluaFind("(L:BTN_VORD_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(70, 'uluaSet(uluaFind("B:AIRLINER_NDB"), 1-uluaGet(uluaFind("(L:BTN_NDB_FILTER_ACTIVE)")))', "")
qfcu:CfgFc(71, 'uluaSet(uluaFind("B:AIRLINER_ARPT"), 1-uluaGet(uluaFind("(L:BTN_ARPT_FILTER_ACTIVE)")))', "")

qfcu:CfgRpn(72, "(>K:TOGGLE_FLIGHT_DIRECTOR)")

qfcu:CfgFc(73, 'uluaSet(uluaFind("B:AIRLINER_LS"), 1-uluaGet(uluaFind("(L:BTN_LS_FILTER_ACTIVE)")))', "")

qfcu:CfgVal(74, "B:AIRLINER_R_VOR_ADF_1", 0, 1)
qfcu:CfgVal(75, "B:AIRLINER_R_VOR_ADF_1", 2, 1)

qfcu:CfgVal(76, "B:AIRLINER_R_VOR_ADF_2", 0, 1)
qfcu:CfgVal(77, "B:AIRLINER_R_VOR_ADF_2", 2, 1)

qfcu:CfgEnc(78, 79, "B:AUTOPILOT_Baro_2")

-- ===========================================================
-- Read data
-- LED Indicator light
-- fcu
local dr_qfcu_airspeed = iDataRef:New("(A:AUTOPILOT AIRSPEED HOLD VAR:1,Knots)")
local dr_qfcu_mach_airspeed = iDataRef:New("(A:AUTOPILOT MACH HOLD VAR:1,Number)")
local dr_qfcu_is_mach = iDataRef:New("(A:AUTOPILOT MANAGED SPEED IN MACH,Bool)")
local dr_qfcu_heading = iDataRef:New("(A:AUTOPILOT HEADING LOCK DIR:1, degrees)")
local dr_qfcu_hdgtrkmode = iDataRef:New("(L:XMLVAR_TRK_FPA_MODE_ACTIVE)")
local dr_qfcu_altitude = iDataRef:New("(L:HUD_AP_SELECTED_ALTITUDE)")
local dr_qfcu_vs = iDataRef:New("(A:AUTOPILOT VERTICAL HOLD VAR,Feet/minute)")
local dr_qfcu_fpa_vs = iDataRef:New("(L:XMLVAR_TRK_FPA_MODE_ACTIVE)")
local dr_qfcu_spddashed = iDataRef:New("(L:A32NX_FCU_SPD_MANAGED_DASHES)")
local dr_qfcu_hdgdashed = iDataRef:New("(L:A32NX_FCU_HDG_MANAGED_DASHES)")
local dr_qfcu_vsdashed = iDataRef:New("(L:A32NX_FCU_VS_MANAGED)")
local dr_qfcu_altmanaged = iDataRef:New("(L:A32NX_FCU_ALT_MANAGED)")
local dr_qfcu_is_spdmgd = iDataRef:New("(L:A32NX_FCU_SPD_MANAGED_DOT)")
local dr_qfcu_is_hdgmgd = iDataRef:New("(L:A32NX_FCU_HDG_MANAGED_DOT)")
-- efis capt
local dr_qfcu_c_cstr = iDataRef:New("(L:BTN_CSTR_FILTER_ACTIVE)")
local dr_qfcu_c_wpt = iDataRef:New("(L:BTN_WPT_FILTER_ACTIVE)")
local dr_qfcu_c_vord = iDataRef:New("(L:BTN_VORD_FILTER_ACTIVE)")
local dr_qfcu_c_ndb = iDataRef:New("(L:BTN_NDB_FILTER_ACTIVE)")
local dr_qfcu_c_arpt = iDataRef:New("(L:BTN_ARPT_FILTER_ACTIVE)")
local dr_qfcu_c_fd = iDataRef:New("(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool)")
local dr_qfcu_c_ils = iDataRef:New("(L:BTN_LS_FILTER_ACTIVE)")

local dr_qfcu_c_baro = iDataRef:New(
    "(L:XMLVAR_Baro1_Mode) 2 > if{ 99 } els{ (L:XMLVAR_Baro_Selector_HPA_1,bool) ! if{ (A:KOHLSMAN SETTING HG, inHg) 100 * near } els{ (A:KOHLSMAN SETTING HG, mbar) near } }")
local dr_qfcu_c_barounit = iDataRef:New("(L:XMLVAR_Baro_Selector_HPA_1)")
-- QFE:0 QNH:1 STD:3
local dr_qfcu_c_barostd = iDataRef:New("(L:XMLVAR_Baro1_Mode)")
-- EFIS FO
local dr_qfcu_f_cstr = iDataRef:New("(L:BTN_CSTR_FILTER_ACTIVE)")
local dr_qfcu_f_wpt = iDataRef:New("(L:BTN_WPT_FILTER_ACTIVE)")
local dr_qfcu_f_vord = iDataRef:New("(L:BTN_VORD_FILTER_ACTIVE)")
local dr_qfcu_f_ndb = iDataRef:New("(L:BTN_NDB_FILTER_ACTIVE)")
local dr_qfcu_f_arpt = iDataRef:New("(L:BTN_ARPT_FILTER_ACTIVE)")
local dr_qfcu_f_fd = iDataRef:New("(L:BTN_LS_FILTER_ACTIVE)")
local dr_qfcu_f_ils = iDataRef:New("(L:BTN_LS_FILTER_ACTIVE)")
local dr_qfcu_f_baro = iDataRef:New(
    "(L:XMLVAR_Baro1_Mode) 2 > if{ 99 } els{ (L:XMLVAR_Baro_Selector_HPA_1,bool) ! if{ (A:KOHLSMAN SETTING HG, inHg) 100 * near } els{ (A:KOHLSMAN SETTING HG, mbar) near } }")
local dr_qfcu_f_barounit = iDataRef:New("(L:XMLVAR_Baro_Selector_HPA_1)")
local dr_qfcu_f_barostd = iDataRef:New("(L:XMLVAR_Baro1_Mode)")

local dr_qfcu_ap1 = iDataRef:New("(L:XMLVAR_Autopilot_1_Status)")
local dr_qfcu_ap2 = iDataRef:New("(L:XMLVAR_Autopilot_2_Status)")
local dr_qfcu_athr = iDataRef:New("(A:AUTOTHROTTLE ACTIVE,Bool)")
local dr_qfcu_loc = iDataRef:New("(A:AUTOPILOT APPROACH HOLD,Bool)")
local dr_qfcu_exped = iDataRef:New("(L:A32NX_FMA_EXPEDITE_MODE)")
local dr_qfcu_appr = iDataRef:New("(A:AUTOPILOT GLIDESLOPE ARM,Bool)")

-- brightness  AirbusFBW/ALT100_1000
local dr_qfcu_fcu_light = iDataRef:New("(L:LIGHTING_PANEL_2)") -- 0~100
local dr_qfcu_fcu_lightDisp = iDataRef:New("(L:LIGHTING_POTENTIOMETER_17)") -- 0~100
-- annun test mode
local dr_qfcu_fcu_test = iDataRef:New("(L:A320_Neo_BAT_ScreenLuminosity, number)")
-- local dr_qfcu_fcu_power = iDataRef:New( 'sim/cockpit/electrical/cockpit_lights') -- > 0.5
local dr_qfcu_fcu_power = iDataRef:New("(L:A320_Neo_BAT_ScreenLuminosity, number)") -- 0: OFF  1：ON
local dr_qfcu_alt_unit = iDataRef:New("(L:A320_Neo_BAT_ScreenLuminosity, number)")
----------------------------  Display Dataref Set End ------------------------------------

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light

local function digi_disp_set_LEDS_fcu()
    local qfcu_ap1 = dr_qfcu_ap1:Get()
    local qfcu_ap2 = dr_qfcu_ap2:Get()
    local qfcu_athr = dr_qfcu_athr:Get()
    local qfcu_loc = dr_qfcu_loc:Get()
    local qfcu_appr = dr_qfcu_appr:Get()
    local qfcu_exped = dr_qfcu_exped:Get()
    local qfcu_c_barounit = dr_qfcu_c_barounit:Get()
    local qfcu_f_barounit = dr_qfcu_f_barounit:Get()
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
        uluaSet(idr_qfcu_hid_ledsexped, ilua_bool_ternary(qfcu_exped, 0)) -- qfcu_exped)
    end

    if qfcu_c_barounit == 0 then -- dot mode:29.92
        uluaSet(idr_qfcu_hid_ledslqnhqfe, 1)
    else
        uluaSet(idr_qfcu_hid_ledslqnhqfe, 0)
    end
    if qfcu_f_barounit == 0 then -- dot mode:29.92
        uluaSet(idr_qfcu_hid_ledsrqnhqfe, 0)
    else
        uluaSet(idr_qfcu_hid_ledsrqnhqfe, 1)
    end
end
local function digi_disp_set_LEDS_l_efis()
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
        if qfcu_c_barostd == 0 then
            uluaSet(idr_qfcu_hid_ledslqfe, 1) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
        elseif qfcu_c_barostd == 1 then
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 1) -- qhn)
        elseif qfcu_c_barostd == 2 then
            uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
        end
    end
end
local function digi_disp_set_LEDS_r_efis()
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
        -- dr_qfcu_f_barostd:Update()
        ---------------------------------------Efis leds FO---------
        uluaSet(idr_qfcu_hid_ledsrcstr, ilua_bool_ternary(qfcu_f_cstr, 0)) -- cstr)
        uluaSet(idr_qfcu_hid_ledsrwpt, ilua_bool_ternary(qfcu_f_wpt, 0))
        -- wpt)
        uluaSet(idr_qfcu_hid_ledsrvord, ilua_bool_ternary(qfcu_f_vord, 0)) -- vord)
        uluaSet(idr_qfcu_hid_ledsrndb, ilua_bool_ternary(qfcu_f_ndb, 0)) -- ndb)
        uluaSet(idr_qfcu_hid_ledsraprt, ilua_bool_ternary(qfcu_f_arpt, 0)) -- aprt)
        uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_f_fd, 0)) -- fd)
        uluaSet(idr_qfcu_hid_ledsrls, ilua_bool_ternary(qfcu_f_ils, 0)) -- ls)
        if qfcu_f_barostd == 0 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 1) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
        elseif qfcu_f_barostd == 1 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 1) -- qhn)
        elseif qfcu_f_barostd == 2 then
            uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
            uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
        end
    end
end

local function digi_disp_set_LEDS()
    digi_disp_set_LEDS_fcu()
    digi_disp_set_LEDS_l_efis()
    digi_disp_set_LEDS_r_efis()
end
local function digi_disp_set_SPD()
    local qfcu_airspeed = dr_qfcu_airspeed:Get()
    local qfcu_mach_airspeed = dr_qfcu_mach_airspeed:Get()
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
                    uluaSet(idr_qfcu_hid_iasmode, 4) -- dash Mach
                else
                    uluaSet(idr_qfcu_hid_iasmode, 2) -- dash Knots
                end
            else
                if qfcu_is_mach == 1 then
                    c_spd = qfcu_mach_airspeed + 0.005
                    uluaSet(idr_qfcu_hid_iasval_f, c_spd)
                    uluaSet(idr_qfcu_hid_iasmode, 6) -- dot Mach
                else
                    c_spd = math.floor(qfcu_airspeed + 0.5)
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
end
local function digi_disp_set_HDG()
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
                uluaSet(idr_qfcu_hid_hdgmode, 2) -- dash
            else
                uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading + 0.5))
                uluaSet(idr_qfcu_hid_hdgmode, 3) -- dot hdg
            end
        else
            if qfcu_hdgdashed == 1 then
                uluaSet(idr_qfcu_hid_hdgmode, 2) -- dash hdg
            else
                uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading + 0.5))
                uluaSet(idr_qfcu_hid_hdgmode, 1)
            end
        end
    end
end
local function digi_disp_set_ALT()
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

local function digi_disp_set_VS()
    local qfcu_vs = dr_qfcu_vs:Get()
    local qfcu_fpa_vs = dr_qfcu_fpa_vs:Get()
    local qfcu_hdgtrkmode = dr_qfcu_hdgtrkmode:Get()
    local qfcu_vsdashed = dr_qfcu_vsdashed:Get()
    if dr_qfcu_vs:Changed() or dr_qfcu_hdgtrkmode:Changed() or dr_qfcu_vsdashed:Changed() or dr_qfcu_fpa_vs:Changed() then
        dr_qfcu_vs:Update()
        dr_qfcu_hdgtrkmode:Update()
        dr_qfcu_vsdashed:Update()
        dr_qfcu_fpa_vs:Update()
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
end
-----------EFIS Capt-------------
local function digi_disp_set_L_EFIS()
    local qfcu_c_baro = dr_qfcu_c_baro:Get()
    local qfcu_c_barounit = dr_qfcu_c_barounit:Get()
    local qfcu_c_barostd = dr_qfcu_c_barostd:Get()
    if dr_qfcu_c_baro:Changed() or dr_qfcu_c_barounit:Changed() or dr_qfcu_c_barostd:Changed() then
        dr_qfcu_c_baro:Update()
        dr_qfcu_c_barounit:Update()
        dr_qfcu_c_barostd:Update()
        -- real code
        if qfcu_c_barostd == 2 or qfcu_c_barostd == 3 then -- std
            uluaSet(idr_qfcu_hid_lefismode, 3)
        else
            if qfcu_c_barounit == 1 then -- hpa mode:29.92
                c_baro = math.floor(qfcu_c_baro)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 2)
            else -- QFE
                c_baro = math.floor(qfcu_c_baro)
                uluaSet(idr_qfcu_hid_lefisval_i, c_baro)
                uluaSet(idr_qfcu_hid_lefismode, 1)
            end
        end
    end
end
---------------------EFIS FO-------------
local function digi_disp_set_R_EFIS()
    local qfcu_f_baro = dr_qfcu_f_baro:Get()
    local qfcu_f_barounit = dr_qfcu_f_barounit:Get()
    local qfcu_f_barostd = dr_qfcu_f_barostd:Get()
    if dr_qfcu_f_baro:Changed() or dr_qfcu_f_barounit:Changed() or dr_qfcu_f_barostd:Changed() then
        dr_qfcu_f_baro:Update()
        dr_qfcu_f_barounit:Update()
        dr_qfcu_f_barostd:Update()
        -- real code
        if qfcu_f_barostd == 2 or qfcu_f_barostd == 3 then -- std
            uluaSet(idr_qfcu_hid_refismode, 3)
        else
            if qfcu_f_barounit == 1 then -- hpa mode:29.92
                f_baro = math.floor(qfcu_f_baro)
                uluaSet(idr_qfcu_hid_refisval_i, f_baro)
                uluaSet(idr_qfcu_hid_refismode, 2)
            else
                f_baro = math.floor(qfcu_f_baro)
                uluaSet(idr_qfcu_hid_refisval_i, f_baro)
                uluaSet(idr_qfcu_hid_refismode, 1)
            end
        end
    end
end
local function invalid_buffer_digi()
    -- update cache
    dr_qfcu_airspeed:Invalid(-1)
    dr_qfcu_heading:Invalid(-1)
    dr_qfcu_altitude:Invalid(-1000000)
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
    if dr_qfcu_fcu_test:Changed() then
        dr_qfcu_fcu_test:Update()
        uluaSet(idr_qfcu_hid_indbrightval_i, 3 - qfcu_fcu_test)
        if qfcu_fcu_test ~= 0 then
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

local function digi_disp_set_BrightOff()
    dr_qfcu_fcu_light:Invalid(-1)
    dr_qfcu_fcu_lightDisp:Invalid(-1)
    uluaSet(idr_qfcu_hid_brightval_i, 0)
    uluaSet(idr_qfcu_hid_indbrightval_i, 1)
    uluasetTimeout("QFCU_Off()", 200)
end

local function digi_disp_powoff_leds()
    -- update cache
    dr_qfcu_ap1:Invalid(-1)
    dr_qfcu_c_cstr:Invalid(-1)
    dr_qfcu_f_cstr:Invalid(-1)
    -- real code
    uluaSet(idr_qfcu_hid_ledsval_i, 0)
    uluaSet(idr_qfcu_hid_ledslval_i, 0)
    uluaSet(idr_qfcu_hid_ledsrval_i, 0)
end

local function digi_disp_powoff_mcp()
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

local function digi_disp_mcp_rr()
    for i = 1, #digi_disp_fcu_func_table do
        -- Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx % #digi_disp_fcu_func_table + 1
        digi_disp_fcu_func_table[digi_disp_rr_func_idx]()
    end
end

function qfcu_lvfr_digi_disp_every_frame()
    local qfcu_fcu_power = dr_qfcu_fcu_power:Get()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    local qfcu_fcu_test = dr_qfcu_fcu_test:Get()
    local qfcu_alt_unit = dr_qfcu_alt_unit:Get()
    if dr_qfcu_fcu_power:Changed() then
        if qfcu_fcu_power > 0 then
            uluaSet(idr_qfcu_hid_indbrightval_i, 3 - qfcu_fcu_test)
            uluaSet(idr_qfcu_hid_invalid, -1)
        else
            digi_disp_powoff_leds()
            digi_disp_powoff_mcp()
            digi_disp_set_BrightOff()
        end
        dr_qfcu_fcu_power:Update()
    end

    -------------------
    if qfcu_fcu_power > 0 then
        digi_disp_set_Bright()
        digi_disp_set_LEDS()
        digi_disp_mcp_rr()
    end
end

uluaAddDoLoop("qfcu_lvfr_digi_disp_every_frame()")
