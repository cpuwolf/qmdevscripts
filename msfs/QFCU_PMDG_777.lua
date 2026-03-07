-- ###############################################################################
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-05-12 QFCU_LVFR_A3XX.lua
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
local MaxBrightness = 100 -- Max brightness set
-- ###############################################################################
-- modified by mdkirin

if ilua_is_acfpath_excluded("PMDG") or ilua_is_acfpath_excluded("77") then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QFCU for PMDG777")

-- ===========================================================
-- button binding

qfcu:CfgRpn(0, "21008 (>K:ROTOR_BRAKE)")
qfcu:CfgRpn(1, "21007 (>K:ROTOR_BRAKE)") -- speed knob
qfcu:CfgRpn(2, "210001 (>K:ROTOR_BRAKE)") -- speed knob push
qfcu:CfgRpn(3, "20701 (>K:ROTOR_BRAKE)") -- speed knob pull(A/T button)

qfcu:CfgRpn(4, "218008 (>K:ROTOR_BRAKE)")
qfcu:CfgRpn(5, "218007 (>K:ROTOR_BRAKE)") -- hdg knob
qfcu:CfgRpn(6, "21801 (>K:ROTOR_BRAKE)") -- hdg knob push
-- qfcu:CfgVal(7, "B:AUTOPILOT_Heading_Selected", 1, 0) -- hdg knob pull

-- qfcu:CfgVal(8, "B:AUTOPILOT_Localizer_Button", 1, 0) -- LOC

qfcu:CfgRpn(9, "21101 (>K:ROTOR_BRAKE)") -- AP2(LNAV)
qfcu:CfgRpn(10, "21201 (>K:ROTOR_BRAKE)") -- AP1(VNAV)

qfcu:CfgRpn(11, "20401 (>K:ROTOR_BRAKE) 20501 (>K:ROTOR_BRAKE)") -- A/THR

-- qfcu:CfgVal(12, "B:AUTOPILOT_Expedite_Mode", 1, 0) --EXPED
qfcu:CfgRpn(13, "22801 (>K:ROTOR_BRAKE)") -- APPR(APP)

-- qfcu:CfgVal(14, "B:AIRLINER_Metric_Alt", 1, 0) -- METRIC ALT

qfcu:CfgRpn(15, "(L:switch_225_a) 0 != if{ 22501 (>K:ROTOR_BRAKE) }",
    "(L:switch_225_a) 0 == if{ 22501 (>K:ROTOR_BRAKE) }") -- 100:press/1000:release 

qfcu:CfgRpn(16, "225008 (>K:ROTOR_BRAKE)") -- altitude knob
qfcu:CfgRpn(17, "225007 (>K:ROTOR_BRAKE)")

qfcu:CfgRpn(18, "225101 (>K:ROTOR_BRAKE)") -- altitude knob push
qfcu:CfgRpn(19, "21301 (>K:ROTOR_BRAKE)") -- altitude knob pull(FLCH)

qfcu:CfgRpn(20, "22207 (>K:ROTOR_BRAKE)") -- VS knob
qfcu:CfgRpn(21, "22208 (>K:ROTOR_BRAKE)")
-- qfcu:CfgVal(22, "B:AUTOPILOT_VerticalSpeed_Zero", 1, 0) -- VS knob push
qfcu:CfgRpn(23, "22301 (>K:ROTOR_BRAKE)") -- VS knob pull(VS/FPA button)

-- EFIS ROSE mode

-- rose knob
qfcu:CfgRpn(24,
    "0 (L:switch_185_a) - 10 div s0 :1 l0 0 > if{ 18507 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18508 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(25,
    "10 (L:switch_185_a) - 10 div s0 :1 l0 0 > if{ 18507 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18508 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
-- qfcu:CfgRpn(26, " (>K:ROTOR_BRAKE)")
qfcu:CfgRpn(27,
    "20 (L:switch_185_a) - 10 div s0 :1 l0 0 > if{ 18507 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18508 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(28,
    "30 (L:switch_185_a) - 10 div s0 :1 l0 0 > if{ 18507 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18508 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- EFIS Range

-- range knob
qfcu:CfgRpn(29,
    "0 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(30,
    "10 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(31,
    "20 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(32,
    "30 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(33,
    "40 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(34,
    "50 (L:switch_187_a) - 10 div s0 :1 l0 0 > if{ 18707 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18708 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- qfcu:CfgRpn(35, "37301 (>K:ROTOR_BRAKE)") -- CSTR CP
-- qfcu:CfgRpn(36, "37101 (>K:ROTOR_BRAKE)") -- WPT CP
-- qfcu:CfgRpn(37, "37001 (>K:ROTOR_BRAKE)") -- VOR.D CP
-- qfcu:CfgRpn(38, "37001 (>K:ROTOR_BRAKE)") --NDB CP
-- qfcu:CfgRpn(39, "37201 (>K:ROTOR_BRAKE)") --ARPT CP

qfcu:CfgRpn(40, "20201 (>K:ROTOR_BRAKE)") -- FD CP

-- qfcu:CfgFc(41, 'uluaSet(uluaFind("B:AIRLINER_LS"), 1-uluaGet(uluaFind("(L:BTN_LS_FILTER_ACTIVE)")))', "") -- LS CP

qfcu:CfgRpn(42,
    "100 (L:switch_184_a) - 50 div s0 :1 l0 0 > if{ 18401 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18402 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_184_a) - 50 div s0 :1 l0 0 > if{ 18401 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18402 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- ADF 1 CP 
qfcu:CfgRpn(43,
    "0 (L:switch_184_a) - 50 div s0 :1 l0 0 > if{ 18401 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18402 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_184_a) - 50 div s0 :1 l0 0 > if{ 18401 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18402 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- VOR 1 CP

qfcu:CfgRpn(44,
    "100 (L:switch_189_a) - 50 div s0 :1 l0 0 > if{ 18901 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18902 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_189_a) - 50 div s0 :1 l0 0 > if{ 18901 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18902 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- ADF 2 CP
qfcu:CfgRpn(45,
    "0 (L:switch_189_a) - 50 div s0 :1 l0 0 > if{ 18901 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18902 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_189_a) - 50 div s0 :1 l0 0 > if{ 18901 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 18902 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- VOR 2 CP

qfcu:CfgRpn(46,
    "(L:myBaroTimer) d 0 > if{(E:SIMULATION TIME, second) (L:myBaroTimer) > if{ 0 (>L:CABaroKnob, number) 0 (>L:FOBaroKnob, number) 0 (>L:myBaroTimer) } } (L:CABaroKnob, number) 5 - -50 max (>L:CABaroKnob, number)(E:SIMULATION TIME, second) 0.04 + (>L:myBaroTimer) ") -- BARO KNOB CP
qfcu:CfgRpn(47,
    "(L:myBaroTimer) d 0 > if{(E:SIMULATION TIME, second) (L:myBaroTimer) > if{ 0 (>L:CABaroKnob, number) 0 (>L:FOBaroKnob, number) 0 (>L:myBaroTimer) } } (L:CABaroKnob, number) 5 +  50 min (>L:CABaroKnob, number) (E:SIMULATION TIME, second) 0.04 + (>L:myBaroTimer)")

qfcu:CfgRpn(48, "19201 (>K:ROTOR_BRAKE)") -- BARO KNOB PUSH(STD)
-- qfcu:CfgVal(49, "B:AUTOPILOT_Baro_1_STD", 1, 0) -- BARO KNOB PULL

qfcu:CfgRpn(50, "(L:switch_190_a) 0 != if{ 19001 (>K:ROTOR_BRAKE) }",
    "(L:switch_190_a) 0 == if{ 19001 (>K:ROTOR_BRAKE) }") -- BARO SELECTOR inHg:pressed hPa:released

qfcu:CfgRpn(51, "25901 (>K:ROTOR_BRAKE)") -- BARO KNOB FO PUSH(STD)


qfcu:CfgRpn(53, "(L:switch_257_a) 0 != if{ 25701 (>K:ROTOR_BRAKE) }",
    "(L:switch_257_a) 0 == if{ 25701 (>K:ROTOR_BRAKE) }") -- BARO SELECTOR FO inHg:pressed hPa:released 

qfcu:CfgRpn(54, "21601 (>K:ROTOR_BRAKE)") -- HDG TRK(HDG TRK switch)

qfcu:CfgRpn(55, "20801 (>K:ROTOR_BRAKE)") -- SPD MACH(IAS MACH switch)

-- ROSE KNOB FO
qfcu:CfgRpn(56,
    "0 (L:switch_252_a) - 10 div s0 :1 l0 0 > if{ 25207 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25208 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(57,
    "10 (L:switch_252_a) - 10 div s0 :1 l0 0 > if{ 25207 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25208 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
-- qfcu:CfgRpn(58, " (>K:ROTOR_BRAKE)")
qfcu:CfgRpn(59,
    "20 (L:switch_252_a) - 10 div s0 :1 l0 0 > if{ 25207 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25208 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(60,
    "30 (L:switch_252_a) - 10 div s0 :1 l0 0 > if{ 25207 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25208 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- RANGE KNOB FO
qfcu:CfgRpn(61,
    "0 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(62,
    "10 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(63,
    "20 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(64,
    "30 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(65,
    "40 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qfcu:CfgRpn(66,
    "50 (L:switch_254_a) - 10 div s0 :1 l0 0 > if{ 25407 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25408 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- qfcu:CfgRpn(67, "42901 (>K:ROTOR_BRAKE)") -- CSTR FO
-- qfcu:CfgRpn(68, "42801 (>K:ROTOR_BRAKE)") -- WPT FO
-- qfcu:CfgRpn(69, "42601 (>K:ROTOR_BRAKE)") -- VOR.D FO
-- qfcu:CfgRpn(70, "42601 (>K:ROTOR_BRAKE)") --NDB FO
-- qfcu:CfgRpn(71, "42701 (>K:ROTOR_BRAKE)") --ARPT FO

qfcu:CfgRpn(72, "23001 (>K:ROTOR_BRAKE)") -- FD FO

-- qfcu:CfgFc(73, 'uluaSet(uluaFind("B:AIRLINER_LS"), 1-uluaGet(uluaFind("(L:BTN_LS_FILTER_ACTIVE)")))', "") -- LS FO

qfcu:CfgRpn(74,
    "100 (L:switch_251_a) - 50 div s0 :1 l0 0 > if{ 25101 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25102 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_251_a) - 50 div s0 :1 l0 0 > if{ 25101 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25102 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- ADF 1 FO 414
qfcu:CfgRpn(75,
    "0 (L:switch_251_a) - 50 div s0 :1 l0 0 > if{ 25101 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25102 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_251_a) - 50 div s0 :1 l0 0 > if{ 25101 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25102 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- VOR 1 FO

qfcu:CfgRpn(76,
    "100 (L:switch_256_a) - 50 div s0 :1 l0 0 > if{ 25601 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25602 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_256_a) - 50 div s0 :1 l0 0 > if{ 25601 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25602 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- ADF 2 FO
qfcu:CfgRpn(77,
    "0 (L:switch_256_a) - 50 div s0 :1 l0 0 > if{ 25601 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25602 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }",
    "50 (L:switch_256_a) - 50 div s0 :1 l0 0 > if{ 25601 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 25602 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }") -- VOR 2 FO

qfcu:CfgRpn(78,
    "(L:myMinsTimer) d 0 > if{(E:SIMULATION TIME, second) (L:myMinsTimer) > if{ 0 (>L:CAMinsKnob, number) 0 (>L:FOMinsKnob, number) 0 (>L:myMinsTimer) } } (L:FOBaroKnob, number) 5 - -50 max (>L:FOBaroKnob, number) (E:SIMULATION TIME, second) 0.04 + (>L:myBaroTimer) ") -- BARO KNOB FO
qfcu:CfgRpn(79,
    "(L:myMinsTimer) d 0 > if{(E:SIMULATION TIME, second) (L:myMinsTimer) > if{ 0 (>L:CAMinsKnob, number) 0 (>L:FOMinsKnob, number) 0 (>L:myMinsTimer) } } (L:FOBaroKnob, number) 5 +  50 min (>L:FOBaroKnob, number)(E:SIMULATION TIME, second) 0.04 + (>L:myBaroTimer) ")

-- ===========================================================

-- ===========================================================
-- Read data
-- LED Indicator light
-- fcu
local dr_qfcu_airspeed = iDataRef:New("(L:ngx_SPDwindow)")
-- local dr_qfcu_ias_hidden = iDataRef:New("pmdg/777x/data/MCP_IASBlank")
-- local dr_qfcu_ias_hidden = iDataRef:New("(L:ngx_SPDwindow) !")
local dr_qfcu_heading = iDataRef:New("(L:ngx_HDGwindow)")
local dr_qfcu_altitude = iDataRef:New("(L:ngx_ALTwindow)")
local dr_qfcu_vs = iDataRef:New("(L:ngx_VSwindow)")
-- local dr_qfcu_vs = uluaFind("pmdg/777x/data/MCP_VertSpeed")

local dr_qfcu_ap1 = iDataRef:New("(L:ngx_MCP_VNav)")
local dr_qfcu_ap2 = iDataRef:New("(L:ngx_MCP_LNav)")
local dr_qfcu_athr = iDataRef:New("(L:switch_204_a)")
local dr_qfcu_appr = iDataRef:New("(L:ngx_MCP_App)")
local dr_qfcu_c_fd = iDataRef:New("(L:switch_202_a)")
local dr_qfcu_f_fd = iDataRef:New("(L:switch_230_a)")
-- local dr_qfcu_c_crs = iDataRef:New("(L:ngx_CRSwindowL)")
-- local dr_qfcu_f_crs = iDataRef:New("(L:ngx_CRSwindowR)")

-- local dr_switch_spd = iDataRef:New("(L:ngx_MCP_Speed)")
-- local dr_switch_hdgs = iDataRef:New("(L:ngx_MCP_HdgSel)")
-- local dr_switch_lvl = iDataRef:New("(L:ngx_MCP_LvlChg)")
local dr_switch_at = iDataRef:New("(L:switch_207_a)")
local dr_switch_flch = iDataRef:New("(L:switch_213_a)")

local dr_bright = iDataRef:New("(L:BL_MCP, number)")
-- local dr_light_test = iDataRef:New("(L:switch_346_73X,number)")

-- local dr_qfcu_fcu_power = iDataRef:New("(A:AVIONICS MASTER SWITCH,Bool)")
local dr_qfcu_mcp_powered = iDataRef:New("(A:AVIONICS MASTER SWITCH,Bool)")

----------------------------  Display Dataref Set End ------------------------------------

local function digi_disp_set_LEDS_fcu()
    local qfcu_ap1 = dr_qfcu_ap1:Get()
    local qfcu_ap2 = dr_qfcu_ap2:Get()
    local qfcu_athr = (dr_qfcu_athr:Get() - 100) * (-1)
    local qfcu_appr = dr_qfcu_appr:Get()
    if dr_qfcu_ap1:Changed() or dr_qfcu_ap2:Changed() or dr_qfcu_athr:Changed() or dr_qfcu_appr:Changed() then
        dr_qfcu_ap1:Update()
        dr_qfcu_ap2:Update()
        dr_qfcu_athr:Update()
        dr_qfcu_appr:Update()

        ------------------------------------fcu light -------------------
        uluaSet(idr_qfcu_hid_ledsap1, ilua_bool_ternary(qfcu_ap1, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsap2, ilua_bool_ternary(qfcu_ap2, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsathr, ilua_bool_ternary(qfcu_athr, 0)) -- athr)
        uluaSet(idr_qfcu_hid_ledsappr, ilua_bool_ternary(qfcu_appr, 0)) -- qfcu_appr)
    end
end
local function digi_disp_set_LEDS_l_efis()
    local qfcu_c_fd = (dr_qfcu_c_fd:Get() - 100) * (-1)
    if dr_qfcu_c_fd:Changed() then
        dr_qfcu_c_fd:Update()

        ---------------------------------------Efis leds capt
        uluaSet(idr_qfcu_hid_ledslfd, ilua_bool_ternary(qfcu_c_fd, 0)) -- fd)
    end
end
local function digi_disp_set_LEDS_r_efis()
    local qfcu_f_fd = (dr_qfcu_f_fd:Get() - 100) * (-1)
    if dr_qfcu_f_fd:Changed() then
        dr_qfcu_f_fd:Update()
        ---------------------------------------Efis leds FO---------
        uluaSet(idr_qfcu_hid_ledsrfd, ilua_bool_ternary(qfcu_f_fd, 0)) -- fd)
    end
end

local function digi_disp_set_LEDS()
    digi_disp_set_LEDS_fcu()
    digi_disp_set_LEDS_l_efis()
    digi_disp_set_LEDS_r_efis()
end

--[[local function digi_disp_set_BARO()
	local crs_l=dr_qfcu_c_crs:Get()
	local crs_r=dr_qfcu_f_crs:Get()
--	if dr_qfcu_c_crs:Changed() or dr_qfcu_f_crs:Changed() then 
		dr_qfcu_c_crs:Update()
		dr_qfcu_f_crs:Update()
	uluaSet(idr_qfcu_hid_lefismode, 2) --1:xx.xx 2:xxxx 3:Std
	uluaSet(idr_qfcu_hid_lefisval_i, crs_l)
	uluaSet(idr_qfcu_hid_refismode, 2) --1:xx.xx 2:xxxx 3:Std
	uluaSet(idr_qfcu_hid_refisval_i, crs_r)
--	end
end
]]

local function digi_disp_set_SPD()
    local qfcu_airspeed = dr_qfcu_airspeed:Get()
    if dr_qfcu_airspeed:Changed() then
        dr_qfcu_airspeed:Update()
        if qfcu_airspeed == (-1) then
            uluaSet(idr_qfcu_hid_iasval_i, 0)
            uluaSet(idr_qfcu_hid_iasmode, 0)
        else
            if qfcu_airspeed < 1 then
                c_spd = qfcu_airspeed + 0.005
                uluaSet(idr_qfcu_hid_iasval_f, c_spd)
                uluaSet(idr_qfcu_hid_iasmode, 3)
            else
                c_spd = math.floor(qfcu_airspeed + 0.5)
                uluaSet(idr_qfcu_hid_iasval_i, c_spd)
                uluaSet(idr_qfcu_hid_iasmode, 1)
            end
        end
        --	else
        --		uluaSet(idr_qfcu_hid_iasmode, 1)
    end
end
local function digi_disp_set_HDG()
    local qfcu_heading = dr_qfcu_heading:Get()
    if dr_qfcu_heading:Changed() then
        dr_qfcu_heading:Update()
        -- real code
        uluaSet(idr_qfcu_hid_hdgval_i, math.floor(qfcu_heading + 0.5))
        uluaSet(idr_qfcu_hid_hdgmode, 1)
    end
end
local function digi_disp_set_ALT()
    local qfcu_altitude = dr_qfcu_altitude:Get()
    if dr_qfcu_altitude:Changed() then
        dr_qfcu_altitude:Update()
        -- real code
        uluaSet(idr_qfcu_hid_altval_i, qfcu_altitude)
        uluaSet(idr_qfcu_hid_altmode, 1)
    end
end
local function digi_disp_set_VS()
    local qfcu_vs = dr_qfcu_vs:Get()
    if dr_qfcu_vs:Changed() then
        dr_qfcu_vs:Update()
        -- real code
        uluaSet(idr_qfcu_hid_vsval_i, math.abs(qfcu_vs))
        if qfcu_vs == -20000 then
            uluaSet(idr_qfcu_hid_vsmode, 0)
        else
            if qfcu_vs >= 0 then
                uluaSet(idr_qfcu_hid_vsmode, 1)
            else
                uluaSet(idr_qfcu_hid_vsmode, 3)
            end
            uluaSet(idr_qfcu_hid_invalid, 3)
        end
    end
end
------------------------------------------------------------------------
local function invalid_buffer_digi()
    -- update cache
    dr_qfcu_airspeed:Invalid(-1)
    dr_qfcu_heading:Invalid(-1)
    dr_qfcu_altitude:Invalid(-1000000)
    dr_qfcu_vs:Invalid(11)
    -- dr_qfcu_c_crs:Invalid(-1)
    -- dr_qfcu_f_crs:Invalid(-1)
end
-------------------------------------------------------------
function QFCU_Off()
    uluaSet(idr_qfcu_hid_indbrightval_i, 0)
end

local function digi_disp_powoff_leds()
    -- update cache
    dr_qfcu_ap1:Invalid(-1)
    dr_qfcu_c_fd:Invalid(-1)
    dr_qfcu_f_fd:Invalid(-1)
    -- real code
    uluaSet(idr_qfcu_hid_ledsval_i, 0)
    uluaSet(idr_qfcu_hid_ledslval_i, 0)
    uluaSet(idr_qfcu_hid_ledsrval_i, 0)
end

--[[function qfcu_PMDG_digi_disp_every_frame()
    local qfcu_mcp_powered = dr_qfcu_mcp_powered:Get()
    local bright = dr_bright:Get()
    if dr_qfcu_mcp_powered:Changed() or dr_bright:Changed() then dr_qfcu_mcp_powered:Update(); dr_bright:Update()
		if qfcu_mcp_powered == 1 then 
					uluaSet(idr_qfcu_hid_invalid, -1)
					uluaSet(idr_qfcu_hid_indbrightval_i, 2) 
					digi_disp_set_SPD()
					digi_disp_set_HDG()
					digi_disp_set_ALT()
					digi_disp_set_VS()
					--digi_disp_set_BARO()
					digi_disp_set_LEDS()
					--invalid_buffer_digi()
				
		else
			--uluaSet(idr_qfcu_hid_invalid, -1)
			digi_disp_powoff_leds()
			invalid_buffer_digi()     
			uluaSet(idr_qfcu_hid_iasmode, 0)
			uluaSet(idr_qfcu_hid_hdgmode, 0)
			uluaSet(idr_qfcu_hid_altmode, 0)
			uluaSet(idr_qfcu_hid_vsmode, 0)
			uluaSet(idr_qfcu_hid_refismode, 0)
			uluaSet(idr_qfcu_hid_lefismode, 0)
--			invalid_buffer_digi()
			uluaSet(idr_qfcu_hid_indbrightval_i, 1)
			uluasetTimeout("QFCU_Off()", 200)
			
		end
	end
--		if qfcu_mcp_powered == 1 then 
					--uluaSet(idr_qfcu_hid_invalid, -1)
					uluaSet(idr_qfcu_hid_indbrightval_i, 2) 
					digi_disp_set_SPD()
					digi_disp_set_HDG()
					digi_disp_set_ALT()
					digi_disp_set_VS()
					--digi_disp_set_BARO()
					digi_disp_set_LEDS()
					--invalid_buffer_digi()

--		end
		if qfcu_mcp_powered == 1 then 
			uluaSet(idr_qfcu_hid_brightval_i, math.floor(bright * 50)) 
			uluaSet(idr_qfcu_hid_dispbrightval_i, math.floor(bright * 4)) 
		else 
			uluaSet(idr_qfcu_hid_brightval_i, 0) 
		end 
		--uluaSet(idr_qfcu_hid_invalid, 3)
	
end
uluaAddDoLoop("qfcu_PMDG_digi_disp_every_frame()")]]

function qfcu_PMDG_digi_disp_every_frame()
    local qfcu_mcp_powered = dr_qfcu_mcp_powered:Get()
    local bright = dr_bright:Get()
    if dr_qfcu_mcp_powered:Changed() then
        dr_qfcu_mcp_powered:Update()
        --		if qfc_mcp_powered == 0 then
        uluaSet(idr_qfcu_hid_invalid, -1)
        digi_disp_powoff_leds()
        uluaSet(idr_qfcu_hid_iasmode, 0)
        uluaSet(idr_qfcu_hid_hdgmode, 0)
        uluaSet(idr_qfcu_hid_altmode, 0)
        uluaSet(idr_qfcu_hid_vsmode, 0)
        uluaSet(idr_qfcu_hid_refismode, 0)
        uluaSet(idr_qfcu_hid_lefismode, 0)
        invalid_buffer_digi()
        uluaSet(idr_qfcu_hid_indbrightval_i, 1)
        uluasetTimeout("QFCU_Off()", 200)
        uluaSet(idr_qfcu_hid_brightval_i, 0)
        --		end
    end
    if qfcu_mcp_powered == 1 then
        -- uluaSet(idr_qfcu_hid_invalid, -1)
        uluaSet(idr_qfcu_hid_indbrightval_i, 2)
        digi_disp_set_SPD()
        digi_disp_set_HDG()
        digi_disp_set_ALT()
        digi_disp_set_VS()
        -- digi_disp_set_BARO()
        digi_disp_set_LEDS()
        -- invalid_buffer_digi()
        uluaSet(idr_qfcu_hid_brightval_i, math.floor(bright * 50))
        uluaSet(idr_qfcu_hid_dispbrightval_i, math.floor(bright * 4))
    end
end
uluaAddDoLoop("qfcu_PMDG_digi_disp_every_frame()")
