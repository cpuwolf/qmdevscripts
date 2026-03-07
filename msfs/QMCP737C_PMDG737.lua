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
-- ######################  Edit part  #####################
-- 此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 40 -- How many spins per second  is considered FAST?
--
local MaxBightness = 30       -- Max brightness set   /背光的最大亮度设定,调小些够用就好,环保省电不刺眼.
--
-- ########################################################

if ilua_is_acfpath_excluded("PMDG") or ilua_is_acfpath_excluded("737") then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for PMDG737")

uluaAddToggleMenu("dis 737C gear/flap", "禁用737C起落架/襟翼", "g_dis_qmcp737c_pmdg737_gear_flap")

qmcp737c:CfgRpn(0, "(>K:VOR1_OBI_DEC)")
qmcp737c:CfgRpn(1, "(>K:VOR1_OBI_INC)")
-- FD
qmcp737c:CfgRpn(2, "(L:switch_378_73X, number) 0 != if{ 37801 (>K:ROTOR_BRAKE) }",
    "(L:switch_378_73X, number) 0 == if{ 37801 (>K:ROTOR_BRAKE) }")
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
qmcp737c:CfgRpn(9, "39101 (>K:ROTOR_BRAKE)")

-- SPD INV
qmcp737c:CfgRpn(10, "38701 (>K:ROTOR_BRAKE)")
-- VNAV
qmcp737c:CfgRpn(11, "38601 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(12, "1 (>K:HEADING_BUG_DEC)")
qmcp737c:CfgRpn(13, "1 (>K:HEADING_BUG_INC)")

qmcp737c:CfgRpn(14, "36601 (>K:ROTOR_BRAKE)")
-- HDG
qmcp737c:CfgRpn(15, "39201 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(16, "100 (>K:AP_ALT_VAR_DEC)")
qmcp737c:CfgRpn(17, "100 (>K:AP_ALT_VAR_INC)")
-- LNAV
qmcp737c:CfgRpn(19, "39701 (>K:ROTOR_BRAKE)")
-- VOR
qmcp737c:CfgRpn(20, "39601 (>K:ROTOR_BRAKE)")
-- APP
qmcp737c:CfgRpn(21, "39301 (>K:ROTOR_BRAKE)")
-- ALT HOLD
qmcp737c:CfgRpn(22, "39401 (>K:ROTOR_BRAKE)")
-- VS
qmcp737c:CfgRpn(23, "39501 (>K:ROTOR_BRAKE)")
-- VS Thumbwheel
qmcp737c:CfgRpn(24, "40107 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(25, "40108 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(26, "(>K:VOR2_OBI_DEC)")
qmcp737c:CfgRpn(27, "(>K:VOR2_OBI_INC)")

-- FD copilot
qmcp737c:CfgRpn(28, "40701 (>K:ROTOR_BRAKE)")

-- ALT INTV
qmcp737c:CfgRpn(29, "88501 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(30, "40201 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(31, "40301 (>K:ROTOR_BRAKE)")
-- MIMINUM
qmcp737c:CfgRpn(32, "35508 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(33, "35507 (>K:ROTOR_BRAKE)")

-- VOR/ADF
qmcp737c:CfgRpn(34, "35807 (>K:ROTOR_BRAKE)", "35808 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(35, "35808 (>K:ROTOR_BRAKE)", "35807 (>K:ROTOR_BRAKE)")

-- MIN BARO/RADIO
function key_36_long_func()
    uluaWriteCmd("35601 (>K:ROTOR_BRAKE)")
end

function key_36_short_func()
    uluaWriteCmd("35701 (>K:ROTOR_BRAKE)")
end

qmcp737c:CfgLongFc(36, 1000, key_36_long_func, key_36_short_func)

-- FPV
qmcp737c:CfgRpn(37, "36301 (>K:ROTOR_BRAKE)")
-- WXR
qmcp737c:CfgRpn(38, "36901 (>K:ROTOR_BRAKE)")
-- STA
qmcp737c:CfgRpn(39, "37001 (>K:ROTOR_BRAKE)")

-- CTR
qmcp737c:CfgRpn(40, "36001 (>K:ROTOR_BRAKE)")

-- EFIS MODE
qmcp737c:CfgRpn(41, "35907 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(42, "35908 (>K:ROTOR_BRAKE)")
-- MTRS
qmcp737c:CfgRpn(43, "36401 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(44, "37101 (>K:ROTOR_BRAKE)")
-- APT
qmcp737c:CfgRpn(45, "37201 (>K:ROTOR_BRAKE)")
-- DATA
qmcp737c:CfgRpn(46, "37301 (>K:ROTOR_BRAKE)")
-- POS
qmcp737c:CfgRpn(47, "37401 (>K:ROTOR_BRAKE)")
-- BARO
qmcp737c:CfgRpn(48, "36508 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(49, "36507 (>K:ROTOR_BRAKE)")

-- BARO STD
function qmcp737c_pmdg737_key_50_release_end()
    uluaWriteCmd("36704 (>K:ROTOR_BRAKE)")
end

function key_50_long_func()
    uluaWriteCmd("36601 (>K:ROTOR_BRAKE)")
end

function key_50_short_func()
    uluaWriteCmd("36701 (>K:ROTOR_BRAKE)")
    uluasetTimeout("qmcp737c_pmdg737_key_50_release_end()", 200)
end

qmcp737c:CfgLongFc(50, 1000, key_50_long_func, key_50_short_func)

-- MAP range
qmcp737c:CfgRpn(51, "36108 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(52, "36107 (>K:ROTOR_BRAKE)")
-- TFC
qmcp737c:CfgRpn(53, "36201 (>K:ROTOR_BRAKE)")

-- VOR2/ADF
qmcp737c:CfgRpn(54, "36808 (>K:ROTOR_BRAKE)", "36807 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(55, "36807 (>K:ROTOR_BRAKE)", "36808 (>K:ROTOR_BRAKE)")

-- qmcp737c:CfgRpn(56, '(>K:COM_RADIO_FRACT_DEC)')
-- qmcp737c:CfgRpn(57, '(>K:COM_RADIO_FRACT_INC)')
-- qmcp737c:CfgRpn(58, '(>K:COM_RADIO_WHOLE_DEC)')
-- qmcp737c:CfgRpn(59, '(>K:COM_RADIO_WHOLE_INC)')
-- VHF1/VHF2
-- qmcp737c:CfgRpn(60, '(>H:AS1000_PFD_COM_Push)')
-- qmcp737c:CfgRpn(61, '(>K:COM_STBY_RADIO_SWAP)')
local lua_vhf1_or_vhf2 = 0 -- COM1 default value
qmcp737c:CfgRpn(56, "72708 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(57, "72707 (>K:ROTOR_BRAKE)")
-- outer
qmcp737c:CfgRpn(58, "72608 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(59, "72607 (>K:ROTOR_BRAKE)")

qmcp737c:CfgRpn(61, "72101 (>K:ROTOR_BRAKE)")
function flip_vhf1_vhf2()
    lua_vhf1_or_vhf2 = 1 - lua_vhf1_or_vhf2
    if lua_vhf1_or_vhf2 == 0 then
        qmcp737c:CfgRpn(56, "72708 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(57, "72707 (>K:ROTOR_BRAKE)")
        -- outer
        qmcp737c:CfgRpn(58, "72608 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(59, "72607 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(61, "72101 (>K:ROTOR_BRAKE)")
    else
        qmcp737c:CfgRpn(56, "84308 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(57, "84307 (>K:ROTOR_BRAKE)")
        -- outer
        qmcp737c:CfgRpn(58, "84208 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(59, "84207 (>K:ROTOR_BRAKE)")
        qmcp737c:CfgRpn(61, "83701 (>K:ROTOR_BRAKE)")
    end
end

qmcp737c:CfgFc(60, "flip_vhf1_vhf2()")
-- VHF1/VHF2 End

qmcp737c:CfgRpn(64, "(>K:NAV1_RADIO_FRACT_DEC)")
qmcp737c:CfgRpn(65, "(>K:NAV1_RADIO_FRACT_INC)")

qmcp737c:CfgRpn(66, "(>K:NAV1_RADIO_WHOLE_DEC)")
qmcp737c:CfgRpn(67, "(>K:NAV1_RADIO_WHOLE_INC)")
qmcp737c:CfgRpn(69, "(>K:NAV1_RADIO_SWAP)")
local lua_nav1_or_nav2 = 0 -- NAV1 default value
function flip_nav1_nav2()
    lua_nav1_or_nav2 = 1 - lua_nav1_or_nav2
    if lua_nav1_or_nav2 == 0 then
        qmcp737c:CfgRpn(64, "(>K:NAV1_RADIO_FRACT_DEC)")
        qmcp737c:CfgRpn(65, "(>K:NAV1_RADIO_FRACT_INC)")

        qmcp737c:CfgRpn(66, "(>K:NAV1_RADIO_WHOLE_DEC)")
        qmcp737c:CfgRpn(67, "(>K:NAV1_RADIO_WHOLE_INC)")
        qmcp737c:CfgRpn(69, "(>K:NAV1_RADIO_SWAP)")
    else
        qmcp737c:CfgRpn(64, "(>K:NAV2_RADIO_FRACT_DEC)")
        qmcp737c:CfgRpn(65, "(>K:NAV2_RADIO_FRACT_INC)")

        qmcp737c:CfgRpn(66, "(>K:NAV2_RADIO_WHOLE_DEC)")
        qmcp737c:CfgRpn(67, "(>K:NAV2_RADIO_WHOLE_INC)")
        qmcp737c:CfgRpn(69, "(>K:NAV2_RADIO_SWAP)")
    end
end

qmcp737c:CfgFc(68, "flip_nav1_nav2()")

-- TERR
qmcp737c:CfgRpn(70, "37501 (>K:ROTOR_BRAKE)")
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
local pswh80 = QmdevPosSwitchInit("(L:switch_112_73X, number)", 50, "11208 (>K:ROTOR_BRAKE)", "11207 (>K:ROTOR_BRAKE)", 500)
local pswh79 = QmdevPosSwitchInit("(L:switch_114_73X, number)", 100, "11402 (>K:ROTOR_BRAKE)", "11401 (>K:ROTOR_BRAKE)", 500)
qmcp737c:CfgFc(80, qmcp737c:GenPSwStr(pswh80, 100) .. qmcp737c:GenPSwStr(pswh79, 100),
    qmcp737c:GenPSwStr(pswh80, 0) .. qmcp737c:GenPSwStr(pswh79, 0))

-- Left Landing lights
local pswh81 = QmdevPosSwitchInit("(L:switch_111_73X, number)", 50, "11108 (>K:ROTOR_BRAKE)", "11107 (>K:ROTOR_BRAKE)", 500)
local pswh78 = QmdevPosSwitchInit("(L:switch_113_73X, number)", 100, "11302 (>K:ROTOR_BRAKE)", "11301 (>K:ROTOR_BRAKE)", 500)
qmcp737c:CfgFc(81, qmcp737c:GenPSwStr(pswh81, 100) .. qmcp737c:GenPSwStr(pswh78, 100),
    qmcp737c:GenPSwStr(pswh81, 0) .. qmcp737c:GenPSwStr(pswh78, 0))

-- Logo lights
local pswh82 = QmdevPosSwitchInit("(L:switch_122_73X, number)", 100, "12202 (>K:ROTOR_BRAKE)", "12201 (>K:ROTOR_BRAKE)", 500)
qmcp737c:CfgFc(82, qmcp737c:GenPSwStr(pswh82, 100), qmcp737c:GenPSwStr(pswh82, 0))

if g_dis_qmcp737c_pmdg737_gear_flap == 0 then
    -- landing gear
    local pswh83 = QmdevPosSwitchInit("(L:switch_455_73X, number)", 30, "45501 (>K:ROTOR_BRAKE)", "45502 (>K:ROTOR_BRAKE)", 1000)
    qmcp737c:CfgFc(83, qmcp737c:GenPSwStr(pswh83, 60), qmcp737c:GenPSwStr(pswh83, 30))
    qmcp737c:CfgFc(84, qmcp737c:GenPSwStr(pswh83, 0), qmcp737c:GenPSwStr(pswh83, 30))
end
-- RTO
local pswh85 = QmdevPosSwitchInit("(L:switch_460_73X, number)", 10, "46007 (>K:ROTOR_BRAKE)", "46008 (>K:ROTOR_BRAKE)")
qmcp737c:CfgFc(85, qmcp737c:GenPSwStr(pswh85, 0))
qmcp737c:CfgFc(86, qmcp737c:GenPSwStr(pswh85, 10))
qmcp737c:CfgFc(87, qmcp737c:GenPSwStr(pswh85, 20))
qmcp737c:CfgFc(88, qmcp737c:GenPSwStr(pswh85, 30))
qmcp737c:CfgFc(89, qmcp737c:GenPSwStr(pswh85, 40))
qmcp737c:CfgFc(90, qmcp737c:GenPSwStr(pswh85, 50))

if g_dis_qmcp737c_pmdg737_gear_flap == 0 then
    -- flaps
    local pswh91 = QmdevPosSwitchInit("(L:switch_714_73X, number)", 10, "71408 (>K:ROTOR_BRAKE)", "71407 (>K:ROTOR_BRAKE)", 1000)
    qmcp737c:CfgFc(91, qmcp737c:GenPSwStr(pswh91, 0))
    qmcp737c:CfgFc(92, qmcp737c:GenPSwStr(pswh91, 10))
    qmcp737c:CfgFc(93, qmcp737c:GenPSwStr(pswh91, 20))
    qmcp737c:CfgFc(94, qmcp737c:GenPSwStr(pswh91, 30))
    qmcp737c:CfgFc(95, qmcp737c:GenPSwStr(pswh91, 40))
    qmcp737c:CfgFc(96, qmcp737c:GenPSwStr(pswh91, 50))
    qmcp737c:CfgFc(97, qmcp737c:GenPSwStr(pswh91, 60))
    qmcp737c:CfgFc(98, qmcp737c:GenPSwStr(pswh91, 70))
    qmcp737c:CfgFc(99, qmcp737c:GenPSwStr(pswh91, 80))
end

-- speed brake
qmcp737c:CfgRpn(100, "679101 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(101, "679201 (>K:ROTOR_BRAKE)", "679301 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(102, "679401 (>K:ROTOR_BRAKE)", "679301 (>K:ROTOR_BRAKE)")
qmcp737c:CfgRpn(103, "679501 (>K:ROTOR_BRAKE)")

----------------------------  Display Dataref Set End ------------------------------------
----------------------------  Display Dataref Set End ------------------------------------
--------X-Plane common aircraft
----------------------------  Display Dataref Set	 ------------------------------------
-- MCP Panel Digital Display
local dr_qmcp737c_bright_test = iDataRef:New("(L:switch_346_73X,number)")
local qmcp737c_com1_power = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_nav1_power = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_battery_on = uluaFind("(A:AVIONICS MASTER SWITCH,Bool)")
local qmcp737c_avionics_on = uluaFind("pmdg/ng3/data/MCP_indication_powered") -- 1 batt 2 AC bus

-- CRS1
qmcp737c:GetCrs1("(L:ngx_CRSwindowL)")
-- IAS
local d_ias = uluaFind("(L:ngx_SPDwindow)")
local dr_ias_A = uluaFind("pmdg/ng3/data/MCP_IASUnderspeedFlash")
if dr_ias_A == nil then
    dr_ias_A = uluaFind("(L:ngx_SPDwindow) !")
end
local dr_ias_8 = uluaFind("pmdg/ng3/data/MCP_IASOverspeedFlash")
if dr_ias_8 == nil then
    dr_ias_8 = uluaFind("(L:ngx_SPDwindow) !")
end
local dr_qmcp737c_ias_hidden = uluaFind("pmdg/ng3/data/MCP_IASBlank")
if dr_qmcp737c_ias_hidden == nil then
    dr_qmcp737c_ias_hidden = uluaFind("(L:ngx_SPDwindow) !")
end
local d_is_mach = uluaFind("(L:ngx_SPDwindow) 1 <")
local d_ias_mach = uluaFind("(L:ngx_SPDwindow)")
-- Hdg
qmcp737c:GetHdg("(L:ngx_HDGwindow)")
-- Alt
qmcp737c:GetAlt("(L:ngx_ALTwindow)")
-- VS
local d_vs = uluaFind("pmdg/ng3/data/MCP_VertSpeed")
if d_vs == nil then
    d_vs = uluaFind("(L:ngx_VSwindow)")
end
local qmcp737c_vvi_show = uluaFind("(L:ngx_MCP_VS)")

qmcp737c:GetVs("pmdg/ng3/data/MCP_VertSpeed", "(L:ngx_MCP_VS)")
-- CRS2
qmcp737c:GetCrs2("(L:ngx_CRSwindowR)")

-- new add C/O display

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
local led_app = uluaFind("(L:ngx_MCP_App)")
local led_alth = uluaFind("(L:ngx_MCP_AltHold)")
local led_vs = uluaFind("(L:ngx_MCP_VS)")
local led_cmda = uluaFind("(L:ngx_MCP_CMDA)")
local led_cmdb = uluaFind("(L:ngx_MCP_CMDB)")

local led_lgn = uluaFind("(L:switch_2611_73X, number)")
local led_lgl = uluaFind("(L:switch_2591_73X, number)")
local led_lgr = uluaFind("(L:switch_2601_73X, number)")

local led_ma = uluaFind("(L:ngx_MCP_FDLeft)")

local led_n1 = uluaFind("(L:ngx_MCP_N1)")

local led_spd = uluaFind("(L:ngx_MCP_Speed)")
local led_lvl = uluaFind("(L:ngx_MCP_LvlChg)")
local led_vnav = uluaFind("(L:ngx_MCP_VNav)")
local led_hdgs = uluaFind("(L:ngx_MCP_HdgSel)")
local led_lnav = uluaFind("(L:ngx_MCP_LNav)")
local led_vorl = uluaFind("(L:ngx_MCP_VORLock)")

local led_at = uluaFind("(L:ngx_MCP_ATArm)")

local led_vhf1 = uluaFind("(A:COM RECEIVE:1,bool)")
local led_vhf2 = uluaFind("(A:COM RECEIVE:2,bool)")

local ap_state = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local dr_brightness = iDataRef:New("(L:BL_MainCA, number) 100 * near")

-------------------  Send Message Process  ------------------------------------

-- LED Indicator light

local function digi_disp_set_LEDS()
    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
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
local function digi_disp_set_CRS1()
    qmcp737c:SetCrs1()
end

-- be carefull about:
----d_ias_A
----d_ias_8
local function digi_disp_set_IAS()
    local d_ias_mach_val = uluaGet(d_ias_mach)
    local d_ias_8 = uluaGet(dr_ias_8)
    local d_ias_A = uluaGet(dr_ias_A)
    local qmcp737c_ias_hidden = uluaGet(dr_qmcp737c_ias_hidden) -- 1: blank, 0: show

    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
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

local function digi_disp_set_HDG()
    qmcp737c:SetHdg()
end

local function digi_disp_set_ALT()
    qmcp737c:SetAlt()
end

local function digi_disp_set_VS()
    qmcp737c:SetVs()
end

local function digi_disp_set_CRS2()
    qmcp737c:SetCrs2()
end

-- COM Panel
local function digi_disp_set_VHFA()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

local function digi_disp_set_VHFS()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if lua_vhf1_or_vhf2 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_coms))
    else
        uluaSet(idr_qmcp737c_hid_vhfs, uluaGet(d_com2s))
    end
end

local function digi_disp_set_NAVA()
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
function digi_disp_set_Bright()
    local qmcp737c_bright_test_val = dr_qmcp737c_bright_test:Get()
    local bright = dr_brightness:Get()
    if uluaGet(qmcp737c_avionics_on) ~= 1 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        if qmcp737c_bright_test_val == 100 then -- DIM mode
            bright = bright / 2
        end
        uluaSet(idr_qmcp737c_hid_bright, bright * MaxBightness / 100)
    end
    if qmcp737c_bright_test_val == 50 then    -- normal mode
        uluaSet(idr_qmcp737c_hid_brightmod, 0)
    elseif qmcp737c_bright_test_val == 0 then -- test mode
        if math.floor(os.clock()) % 2 == 0 then
            uluaSet(idr_qmcp737c_hid_brightmod, 1)
        else
            uluaSet(idr_qmcp737c_hid_brightmod, 2) -- blank
        end
    end
    if dr_brightness:Changed() then
        uluaSet(idr_qmcp737c_hid_dispbright, math.floor(bright / 100))
        dr_brightness:Update()
    end

    if dr_qmcp737c_bright_test:Changed() then
        if qmcp737c_bright_test_val ~= 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        dr_qmcp737c_bright_test:Update()
    end
end

local function digi_disp_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end
local function digi_disp_powoff_mcp()
    qmcp737c:OffMcp()
end

local function digi_disp_powoff_com()
    local i = uluaGet(idr_qmcp737c_hid_vhfa)
    i = i + 1
    if (i > 128) or (i < 0) then
        i = 1
    end
    uluaSet(idr_qmcp737c_hid_vhfa, i)
    uluaSet(idr_qmcp737c_hid_vhfs, i)
end
local function digi_disp_powoff_nav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end
-----end sub functions
local digi_disp_mcp_func_table = { digi_disp_set_CRS1, digi_disp_set_IAS, digi_disp_set_HDG, digi_disp_set_ALT,
    digi_disp_set_VS, digi_disp_set_CRS2 }

local digi_disp_com_func_table = { digi_disp_set_VHFA, digi_disp_set_VHFS }

local digi_disp_nav_func_table = { digi_disp_set_NAVA, digi_disp_set_NAVS }
local digi_disp_rr_func_idx = 0
local function digi_disp_mcp_rr()
    for i = 1, #digi_disp_mcp_func_table do
        -- Round-Robin check
        digi_disp_rr_func_idx = digi_disp_rr_func_idx % #digi_disp_mcp_func_table + 1
        digi_disp_mcp_func_table[digi_disp_rr_func_idx]()
    end
end
local function digi_disp_com()
    for i = 1, #digi_disp_com_func_table do
        if digi_disp_com_func_table[i]() then
            -- break
        end
    end
end
local function digi_disp_nav()
    for i = 1, #digi_disp_nav_func_table do
        if digi_disp_nav_func_table[i]() then
            -- break
        end
    end
end

function digi_disp_every_frame()
    digi_disp_set_Bright()

    if uluaGet(qmcp737c_avionics_on) == 1 then
        digi_disp_set_LEDS()
    else
        digi_disp_powoff_leds()
    end

    if uluaGet(qmcp737c_avionics_on) == 1 then
        digi_disp_mcp_rr()
    else
        digi_disp_powoff_mcp()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_com1_power) > 0 then
        digi_disp_com()
    else
        digi_disp_powoff_com()
    end

    if uluaGet(qmcp737c_battery_on) > 0 and uluaGet(qmcp737c_nav1_power) > 0 then
        digi_disp_nav()
    else
        digi_disp_powoff_nav()
    end
end

uluaAddDoLoop("digi_disp_every_frame()")
