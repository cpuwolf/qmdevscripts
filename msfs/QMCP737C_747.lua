-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2019-06-12
-- modified by Wei Shuai <cpuwolf@gmail.com> 2020-03-14 add General Aviation
-- modified by Wei Shuai <cpuwolf@gmail.com> 2020-06-18 add C90B
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-02-06 asobo 747-8 1.36.2.0
-- ########################################################
if ilua_is_acftitle_excluded("Salty") and ilua_is_acftitle_excluded("747") then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for Salty 747")

qmcp737c:CfgRpn(0, "(>K:VOR1_OBI_DEC)")
qmcp737c:CfgRpn(1, "(>K:VOR1_OBI_INC)")
-- FD
qmcp737c:CfgRpn(2, "(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }",
    "(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool) if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) }")
-- AUTO throttle
qmcp737c:CfgRpn(3, "(L:switch_380_73X, number) 0 != if{ 38001 (>K:ROTOR_BRAKE) }",
    "(L:switch_380_73X, number) 0 == if{ 38001 (>K:ROTOR_BRAKE) }")

qmcp737c:CfgRpn(4, "(>K:AP_SPD_VAR_DEC)")
qmcp737c:CfgRpn(5, "(>K:AP_SPD_VAR_INC)")

-- C/O MACH
qmcp737c:CfgRpn(6, "38301 (>K:ROTOR_BRAKE)")

-- N1
qmcp737c:CfgRpn(7, "38101 (>K:ROTOR_BRAKE)")
-- SPEED
qmcp737c:CfgRpn(8, "38201 (>K:ROTOR_BRAKE)")
-- FLT LVL
qmcp737c:CfgRpn(9, "(>H:B747_8_FMC_1_AP_FLCH)")

-- SPD INV
qmcp737c:CfgRpn(10, "38701 (>K:ROTOR_BRAKE)")
-- VNAV
qmcp737c:CfgRpn(11, "(>H:B747_8_FMC_1_AP_VNAV)")

qmcp737c:CfgRpn(12, "1 (>K:HEADING_BUG_DEC)")
qmcp737c:CfgRpn(13, "1 (>K:HEADING_BUG_INC)")

qmcp737c:CfgRpn(14, "(>H:B747_8_FMC_1_AP_HEADING_SEL)")
-- HDG
qmcp737c:CfgRpn(15, "(>H:B747_8_FMC_1_AP_HEADING_HOLD)")

qmcp737c:CfgRpn(16, "100 (>K:AP_ALT_VAR_DEC)")
qmcp737c:CfgRpn(17, "100 (>K:AP_ALT_VAR_INC)")
-- LNAV
qmcp737c:CfgRpn(19, "(>H:B747_8_FMC_1_AP_LNAV)")
-- VOR
qmcp737c:CfgRpn(20, "39601 (>K:ROTOR_BRAKE)")
-- APP
qmcp737c:CfgRpn(21, "(>H:B747_8_FMC_1_AP_APP_ARMED)")
-- ALT HOLD
qmcp737c:CfgRpn(22, "(>H:B747_8_FMC_1_AP_ALT)")
-- VS
qmcp737c:CfgRpn(23, "(>H:B747_8_FMC_1_AP_VSPEED)")
-- VS Thumbwheel
qmcp737c:CfgRpn(24, "(>K:AP_VS_VAR_DEC)")
qmcp737c:CfgRpn(25, "(>K:AP_VS_VAR_INC)")

qmcp737c:CfgRpn(26, "(>K:VOR2_OBI_DEC)")
qmcp737c:CfgRpn(27, "(>K:VOR2_OBI_INC)")

-- FD copilot
qmcp737c:CfgRpn(28, "40701 (>K:ROTOR_BRAKE)")

-- ALT INTV
qmcp737c:CfgRpn(29, "88501 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(30, "40201 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(31, "40301 (>K:ROTOR_BRAKE)")
-- MIMINUM
qmcp737c:CfgRpn(32, "(>H:B747_8_PFD_Mins_DEC)")
qmcp737c:CfgRpn(33, "(>H:B747_8_PFD_Mins_INC)")

-- VOR/ADF
qmcp737c:CfgRpn(34, "35807 (>K:ROTOR_BRAKE)", "35808 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(35, "35808 (>K:ROTOR_BRAKE)", "35807 (>K:ROTOR_BRAKE)")

-- MIN BARO/RADIO
qmcp737c:CfgRpn(36, "(>H:B747_8_PFD_Mins_Press)")
-- FPV
qmcp737c:CfgRpn(37, "(>H:B747_8_PFD_FPV)")
-- WXR
qmcp737c:CfgRpn(38, "(>H:AS01B_MFD_1_WXR)")
-- STA
qmcp737c:CfgRpn(39, "(>H:AS01B_MFD_1_STA)")

-- CTR
qmcp737c:CfgRpn(40, "36001 (>K:ROTOR_BRAKE)")

-- EFIS MODE
qmcp737c:CfgRpn(42, "(L:B747_8_MFD_1_NAV_MODE) -- 0 max 3 min (>L:B747_8_MFD_1_NAV_MODE)", "")
qmcp737c:CfgRpn(41, "(L:B747_8_MFD_1_NAV_MODE) ++ 0 max 3 min (>L:B747_8_MFD_1_NAV_MODE)", "")
-- MTRS
qmcp737c:CfgRpn(43, "(>H:B747_8_PFD_MTRS)")
-- WPT
qmcp737c:CfgRpn(44, "(>H:AS01B_MFD_1_WPT)")
-- APT
qmcp737c:CfgRpn(45, "(>H:AS01B_MFD_1_ARPT)")
-- DATA
qmcp737c:CfgRpn(46, "(>H:AS01B_MFD_1_DATA)")
-- POS
qmcp737c:CfgRpn(47, "(>H:B747_8_MFD_BTN_POS) (>H:B747_8_PFD_BTN_POS) and")
-- BARO
qmcp737c:CfgRpn(48, "(>K:KOHLSMAN_DEC)")
qmcp737c:CfgRpn(49, "(>K:KOHLSMAN_INC)")
-- BARO STD
qmcp737c:CfgRpn(50, "36701 (>K:ROTOR_BRAKE)")
-- MAP range
qmcp737c:CfgRpn(51, "(L:B747_8_MFD_1_Range) -- 0 max 12 min (>L:B747_8_MFD_1_Range)")
qmcp737c:CfgRpn(52, "(L:B747_8_MFD_1_Range) ++ 0 max 12 min (>L:B747_8_MFD_1_Range)", "")
-- TFC
qmcp737c:CfgRpn(53, "36201 (>K:ROTOR_BRAKE)")

-- VOR2/ADF
qmcp737c:CfgRpn(54, "36808 (>K:ROTOR_BRAKE)", "36807 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(55, "36807 (>K:ROTOR_BRAKE)", "36808 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(56, "(>K:COM_RADIO_FRACT_DEC)")
qmcp737c:CfgRpn(57, "(>K:COM_RADIO_FRACT_INC)")
qmcp737c:CfgRpn(58, "(>K:COM_RADIO_WHOLE_DEC)")
qmcp737c:CfgRpn(59, "(>K:COM_RADIO_WHOLE_INC)")
-- VHF1/VHF2
qmcp737c:CfgRpn(60, "(>H:AS1000_PFD_COM_Push)")
qmcp737c:CfgRpn(61, "(>K:COM_STBY_RADIO_SWAP)")
-- VHF1/VHF2 End

qmcp737c:CfgRpn(64, "(>K:NAV1_RADIO_FRACT_DEC)")
qmcp737c:CfgRpn(65, "(>K:NAV1_RADIO_FRACT_INC)")

qmcp737c:CfgRpn(66, "(>K:NAV1_RADIO_WHOLE_DEC)")
qmcp737c:CfgRpn(67, "(>K:NAV1_RADIO_WHOLE_INC)")
qmcp737c:CfgRpn(69, "(>K:COM_STBY_RADIO_SWAP)")
-- TERR
qmcp737c:CfgRpn(70, "(>H:B747_8_MFD_BTN_TERR) (>H:B747_8_PFD_BTN_TERR) and")
-- DISC
qmcp737c:CfgRpn(71, "40601 (>K:ROTOR_BRAKE)", "40601 (>K:ROTOR_BRAKE)")

-- Taxi lights
qmcp737c:CfgRpn(72, "(L:switch_117_73X, number) 0 == if{ 11701 (>K:ROTOR_BRAKE) }",
    "(L:switch_117_73X, number) 0 != if{ 11701 (>K:ROTOR_BRAKE) }")

-- Right Runway lights
qmcp737c:CfgRpn(73, "(L:switch_116_73X, number) 0 == if{ 11601 (>K:ROTOR_BRAKE) }",
    "(L:switch_116_73X, number) 0 != if{ 11601 (>K:ROTOR_BRAKE) }")
-- Left Runway lights
qmcp737c:CfgRpn(74, "(L:switch_115_73X, number) 0 == if{ 11501 (>K:ROTOR_BRAKE) }",
    "(L:switch_115_73X, number) 0 != if{ 11501 (>K:ROTOR_BRAKE) }")

-- Wheel well lights
qmcp737c:CfgRpn(75, "(L:switch_126_73X, number) 0 == if{ 12601 (>K:ROTOR_BRAKE) }",
    "(L:switch_126_73X, number) 0 != if{ 12601 (>K:ROTOR_BRAKE) }")

-- Wing lights
qmcp737c:CfgRpn(76, "(L:switch_125_73X, number) 0 == if{ 12501 (>K:ROTOR_BRAKE) }",
    "(L:switch_125_73X, number) 0 != if{ 12501 (>K:ROTOR_BRAKE) }")
-- Anti Collision lights
qmcp737c:CfgRpn(77, "(L:switch_124_73X, number) 0 == if{ 12401 (>K:ROTOR_BRAKE) }",
    "(L:switch_124_73X, number) 0 != if{ 12401 (>K:ROTOR_BRAKE) }")

-- POS/Strobe
qmcp737c:CfgRpn(79, "12307 (>K:ROTOR_BRAKE)", "12308 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(78, "12308 (>K:ROTOR_BRAKE)", "12307 (>K:ROTOR_BRAKE)")

-- Right Landing lights
qmcp737c:CfgRpn(80, "(L:switch_114_73X, number) 0 == if{ 11401 (>K:ROTOR_BRAKE) }",
    "(L:switch_114_73X, number) 0 != if{ 11401 (>K:ROTOR_BRAKE) }")
-- Left Landing lights
qmcp737c:CfgRpn(81, "(L:switch_113_73X, number) 0 == if{ 11301 (>K:ROTOR_BRAKE) }",
    "(L:switch_113_73X, number) 0 != if{ 11301 (>K:ROTOR_BRAKE) }")

-- Logo lights
qmcp737c:CfgRpn(82, "(L:switch_122_73X, number) 0 == if{ 12201 (>K:ROTOR_BRAKE) }",
    "(L:switch_122_73X, number) 0 != if{ 12201 (>K:ROTOR_BRAKE) }")

-- landing gear
qmcp737c:CfgRpn(83, "(>K:GEAR_DOWN)")
qmcp737c:CfgRpn(84, "(>K:GEAR_UP)")

-- RTO
qmcp737c:CfgRpn(85, "",
    "(L:switch_460_73X, number) 0 == if{ 46007 (>K:ROTOR_BRAKE) } els{ 46008 (>K:ROTOR_BRAKE) }")
qmcp737c:CfgRpn(86, "",
    "(L:switch_460_73X, number) 10 < if{ 46007 (>K:ROTOR_BRAKE) } els{ 46008 (>K:ROTOR_BRAKE) }")
qmcp737c:CfgRpn(87, "",
    "(L:switch_460_73X, number) 20 < if{ 46007 (>K:ROTOR_BRAKE) } els{ 46008 (>K:ROTOR_BRAKE) }")
qmcp737c:CfgRpn(88, "",
    "(L:switch_460_73X, number) 30 < if{ 46007 (>K:ROTOR_BRAKE) } els{ 46008 (>K:ROTOR_BRAKE) }")
qmcp737c:CfgRpn(90, "",
    "(L:switch_460_73X, number) 40 < if{ 46007 (>K:ROTOR_BRAKE) } els{ 46008 (>K:ROTOR_BRAKE) }")

-- Auto Brake
-- qmcp737c:CfgFc(85, "AutobrakeSet(0)")
-- qmcp737c:CfgFc(86, "AutobrakeSet(10)")
-- qmcp737c:CfgFc(87, "AutobrakeSet(20)")
-- qmcp737c:CfgFc(88, "AutobrakeSet(30)")
-- qmcp737c:CfgFc(89, "AutobrakeSet(40)")
-- qmcp737c:CfgFc(90, "AutobrakeSet(50)")

-- flaps
-- qmcp737c:CfgFc(91, "FlapsSet(0)")
-- qmcp737c:CfgFc(92, "FlapsSet(10)")
-- qmcp737c:CfgFc(93, "FlapsSet(20)")
-- qmcp737c:CfgFc(94, "FlapsSet(30)")
-- qmcp737c:CfgFc(95, "FlapsSet(40)")
-- qmcp737c:CfgFc(96, "FlapsSet(50)")
-- qmcp737c:CfgFc(97, "FlapsSet(60)")
-- qmcp737c:CfgFc(98, "FlapsSet(70)")
-- qmcp737c:CfgFc(99, "FlapsSet(80)")

-- speed brake
qmcp737c:CfgRpn(100, "679101 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(101, "679201 (>K:ROTOR_BRAKE)", "679301 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(102, "679401 (>K:ROTOR_BRAKE)", "679301 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(103, "679501 (>K:ROTOR_BRAKE)")

-- MCP Panel Digital Display
local qmcp737c_bright_test = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_com1_power = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_nav1_power = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_battery_on = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_avionics_on = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")

local d_crs1 = uluaFind("(A:NAV OBS:1,Degrees)")
local d_ias = uluaFind("(L:AP_SPD_ACTIVE)")
local d_hdg = uluaFind("(A:AUTOPILOT HEADING LOCK DIR,Degrees)")
local d_alt = uluaFind("(L:HUD_AP_SELECTED_ALTITUDE)")
--
local d_vs = uluaFind("(A:AUTOPILOT VERTICAL HOLD VAR,Feet/minute)")

local d_crs2 = uluaFind("(A:NAV OBS:2,Degrees)")

local dr_ias_A = uluaFind("(A:CIRCUIT AVIONICS ON,Bool) !")

local dr_ias_8 = uluaFind("(A:CIRCUIT AVIONICS ON,Bool) !")

local dr_qmcp737c_ias_hidden = uluaFind("(A:CIRCUIT AVIONICS ON,Bool) !")

local qmcp737c_vvi_show = uluaFind("(L:AP_VS_ACTIVE)")
-- new add C/O display
local d_is_mach = uluaFind("(L:XMLVAR_AirSpeedIsInMach)")
local d_ias_mach = uluaFind("(A:AUTOPILOT MACH HOLD VAR,Number)")

-- COM Panel Digital Display
local d_com = uluaFind("(A:COM ACTIVE FREQUENCY:1,KHz)")
local d_coms = uluaFind("(A:COM STANDBY FREQUENCY:1, KHz) near")

local d_com2 = uluaFind("(A:COM ACTIVE FREQUENCY:2,KHz)")
local d_com2s = uluaFind("(A:COM STANDBY FREQUENCY:2, KHz) near")

local d_nav = uluaFind("(A:NAV ACTIVE FREQUENCY:1,MHz)")
local d_navs = uluaFind("(A:NAV STANDBY FREQUENCY:1,MHz)")

local d_nav2 = uluaFind("(A:NAV ACTIVE FREQUENCY:2,MHz)")
local d_nav2s = uluaFind("(A:NAV STANDBY FREQUENCY:2,MHz)")

local led_alth_min = 0
-- LED Indicator light
local led_app = uluaFind("(L:AP_APP_ARMED)")
local led_alth = uluaFind("(L:AP_ALT_HOLD_ACTIVE)")
local led_vs = uluaFind("(L:AP_VS_ACTIVE)")
local led_cmda = uluaFind("(A:AUTOPILOT MASTER, Bool)")
local led_cmdb = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local led_lgn = uluaFind("(A:GEAR CENTER POSITION, percent over 100)")
local led_lgl = uluaFind("(A:GEAR LEFT POSITION, percent over 100)")
local led_lgr = uluaFind("(A:GEAR RIGHT POSITION, percent over 100)")

local led_ma = uluaFind("(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool)")

local led_n1 = uluaFind("AUTOPILOT MACH HOLD")

local led_spd = uluaFind("(L:AP_SPD_ACTIVE)")
local led_lvl = uluaFind("(L:AP_FLCH_ACTIVE)")
local led_vnav = uluaFind("(L:AP_VNAV_ARMED)")
local led_hdgs = uluaFind("(L:AP_HEADING_HOLD_ACTIVE)")
local led_lnav = uluaFind("(L:AP_LNAV_ARMED)")
local led_vorl = uluaFind("(L:AP_LOC_ARMED, Bool)")

local led_at = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")

local led_vhf1 = uluaFind("(A:COM RECEIVE:1,bool)")
local led_vhf2 = uluaFind("(A:COM RECEIVE:2,bool)")

local ap_state = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local brightness = uluaFind("(A:LIGHT POTENTIOMETER:3, Percent)")

-------------------  Send Message Process  ------------------------------------
-- LED Indicator light
local lua_vhf1_or_vhf2 = 0
function digi_disp_set_LEDS()
    local qmcp737c_bright_test_val = uluaGet(qmcp737c_bright_test)
    if qmcp737c_bright_test_val == 0 then -- test mode
        uluaSet(idr_qmcp737c_hid_leds, 16777215)
        return
    end
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
function digi_disp_set_CRS1()
    uluaSet(idr_qmcp737c_hid_crs1, uluaGet(d_crs1))
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end

-- be carefull about:
----d_ias_A
----d_ias_8
function digi_disp_set_IAS()
    local d_ias_mach_val = uluaGet(d_ias_mach)
    local d_ias_8 = uluaGet(dr_ias_8)
    local d_ias_A = uluaGet(dr_ias_A)
    local qmcp737c_ias_hidden = uluaGet(dr_qmcp737c_ias_hidden) -- 1: blank, 0: show

    local qmcp737c_bright_test_val = uluaGet(qmcp737c_bright_test)
    if qmcp737c_bright_test_val == 0 then -- test mode
        return
    end

    if qmcp737c_ias_hidden == 0 then
        if uluaGet(d_is_mach) > 0 then
            uluaSet(idr_qmcp737c_hid_ias_f, d_ias_mach_val)
            uluaSet(idr_qmcp737c_hid_iasmod, 3)
        else
            uluaSet(idr_qmcp737c_hid_ias_i, uluaGet(d_ias))
            if d_ias_A == 1 then
                -- uluaLog(string.format("IAS %d", math.floor(os.clock()) % 2))
                if math.floor(os.clock() * 2) % 2 == 0 then
                    uluaSet(idr_qmcp737c_hid_iasmod, 0)
                else
                    uluaSet(idr_qmcp737c_hid_iasmod, 1)
                end
            elseif d_ias_8 == 1 then
                -- uluaLog(string.format("IAS %d", math.floor(os.clock()) % 2))
                if math.floor(os.clock() * 2) % 2 == 0 then
                    uluaSet(idr_qmcp737c_hid_iasmod, 0)
                else
                    uluaSet(idr_qmcp737c_hid_iasmod, 2)
                end
            else
                uluaSet(idr_qmcp737c_hid_iasmod, 0)
            end
        end
    else
        -- hide IAS
        uluaSet(idr_qmcp737c_hid_iasmod, 4)
    end
end

function digi_disp_set_HDG()
    uluaSet(idr_qmcp737c_hid_hdg, uluaGet(d_hdg))
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function digi_disp_set_ALT()
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
function digi_disp_set_VS()
    local d_vs_val = uluaGet(d_vs)
    if uluaGet(qmcp737c_vvi_show) > 0 then
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
    else
        -- hide vvi
        uluaSet(idr_qmcp737c_hid_vsmod, 2)
    end
end

function digi_disp_set_CRS2()
    uluaSet(idr_qmcp737c_hid_crs2, uluaGet(d_crs2))
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

-- COM Panel
function digi_disp_set_VHFA()
    -- local qmcp737c_val_condbtn_60 = uluaGet(idr_qmcp737c_hid_condbtn_60)
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

function digi_disp_set_VHFS()
    -- local qmcp737c_val_condbtn_60 = uluaGet(idr_qmcp737c_hid_condbtn_60)
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_coms))
    else
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_com2s))
    end
end
local lua_nav1_or_nav2 = 0 -- NAV1 default value
function digi_disp_set_NAVA()
    if lua_nav1_or_nav2 == 0 then
        uluaSet(idr_qmcp737c_hid_nava, math.floor(uluaGet(d_nav) * 100 + 0.5))
    else
        uluaSet(idr_qmcp737c_hid_nava, math.floor(uluaGet(d_nav2) * 100 + 0.5))
    end
    uluaSet(idr_qmcp737c_hid_navamod, 1)
end

function digi_disp_set_NAVS()
    if lua_nav1_or_nav2 == 0 then
        uluaSet(idr_qmcp737c_hid_navs, math.floor(uluaGet(d_navs) * 100 + 0.5))
    else
        uluaSet(idr_qmcp737c_hid_navs, math.floor(uluaGet(d_nav2s) * 100 + 0.5))
    end
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end
-- Backlight
local light_test_last = 0
local old_bright = -1
function digi_disp_set_Bright()
    local qmcp737c_bright_test_val = uluaGet(qmcp737c_bright_test)
    local bright = uluaGet(brightness)
    if uluaGet(qmcp737c_avionics_on) ~= 1 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        if qmcp737c_bright_test_val == 100 then -- DIM mode
            bright = bright / 2
        end
        uluaSet(idr_qmcp737c_hid_bright, bright * 30 / 100)
    end
    if qmcp737c_bright_test_val == 50 then -- normal mode
        uluaSet(idr_qmcp737c_hid_brightmod, 0)
    elseif qmcp737c_bright_test_val == 0 then -- test mode
        if math.floor(os.clock()) % 2 == 0 then
            uluaSet(idr_qmcp737c_hid_brightmod, 1)
        else
            uluaSet(idr_qmcp737c_hid_brightmod, 2) -- blank
        end
    end
    if old_bright ~= bright then
        uluaSet(idr_qmcp737c_hid_dispbright, math.floor(bright / 100))
        old_bright = bright
    end

    if lighttest_last ~= qmcp737c_bright_test_val then
        if qmcp737c_bright_test_val ~= 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        lighttest_last = qmcp737c_bright_test_val
    end
end

-----end sub functions
local digi_disp_mcp_func_table = {digi_disp_set_CRS1, digi_disp_set_IAS, digi_disp_set_HDG, digi_disp_set_ALT,
                                  digi_disp_set_VS, digi_disp_set_CRS2}

local digi_disp_com_func_table = {digi_disp_set_VHFA, digi_disp_set_VHFS}

local digi_disp_nav_func_table = {digi_disp_set_NAVA, digi_disp_set_NAVS}
local digi_disp_rr_func_idx = 0
function digi_disp_mcp_rr()
    for i = 1, #digi_disp_mcp_func_table do
        -- Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx % #digi_disp_mcp_func_table + 1
        digi_disp_mcp_func_table[digi_disp_rr_func_idx]()
    end
end
function digi_disp_com()
    for i = 1, #digi_disp_com_func_table do
        if digi_disp_com_func_table[i]() then
            -- break
        end
    end
end
function digi_disp_nav()
    for i = 1, #digi_disp_nav_func_table do
        if digi_disp_nav_func_table[i]() then
            -- break
        end
    end
end

function digi_disp_every_frame()
    digi_disp_set_Bright()
    digi_disp_set_LEDS()
    digi_disp_mcp_rr()
    digi_disp_com()
    digi_disp_nav()
end
uluaAddDoLoop("digi_disp_every_frame()")
