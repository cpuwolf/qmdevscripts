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

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for GA")

qmcp737c:CfgRpn(0, "(>H:AS1000_PFD_CRS_DEC)")
qmcp737c:CfgRpn(1, "(>H:AS1000_PFD_CRS_INC)")

qmcp737c:CfgRpn(2, "1 (>K:TOGGLE_FLIGHT_DIRECTOR)", "(>K:TOGGLE_FLIGHT_DIRECTOR)")

qmcp737c:CfgRpn(9, "(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)")

qmcp737c:CfgRpn(11, "(L:XMLVAR_VNAVButtonValue, Bool) ! (>L:XMLVAR_VNAVButtonValue)")
qmcp737c:CfgRpn(12, "1 (>K:HEADING_BUG_DEC)")
qmcp737c:CfgRpn(13, "1 (>K:HEADING_BUG_INC)")

qmcp737c:CfgRpn(14, "(A:HEADING INDICATOR, degrees) (>K:HEADING_BUG_SET)")
qmcp737c:CfgRpn(15, "(>K:AP_PANEL_HEADING_HOLD)")

qmcp737c:CfgRpn(16, "100 (>K:AP_ALT_VAR_DEC)")
qmcp737c:CfgRpn(17, "100 (>K:AP_ALT_VAR_INC)")

qmcp737c:CfgRpn(19, "(>K:AP_NAV1_HOLD)")

qmcp737c:CfgRpn(20, "(>K:AP_NAV1_HOLD)")

qmcp737c:CfgRpn(21, "(>K:AP_APR_HOLD)")

qmcp737c:CfgRpn(22, "(>K:AP_ALT_HOLD)")

qmcp737c:CfgRpn(23, "(>K:AP_PANEL_VS_HOLD)")

qmcp737c:CfgRpn(24,
    "(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_DEC) (>H:AP_UP) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_INC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_DN) }",
    "")
qmcp737c:CfgRpn(25,
    "(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_INC) (>H:AP_DN) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_DEC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_UP) }",
    "")

qmcp737c:CfgRpn(30, "(>K:AP_MASTER) ")
qmcp737c:CfgRpn(31, "(>K:AP_MASTER) ")

qmcp737c:CfgRpn(48, "(>H:AS1000_PFD_BARO_DEC)")
qmcp737c:CfgRpn(49, "(>H:AS1000_PFD_BARO_INC)")

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

function ga_qmcp737c_digi_disp_powoff_leds()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end

function ga_qmcp737c_digi_disp_powoff_mcp()
    qmcp737c:OffMcp()
end

function ga_qmcp737c_digi_disp_powoff_com()
    uluaSet(idr_qmcp737c_hid_vhfa, 0)
    uluaSet(idr_qmcp737c_hid_vhfs, 0)
end

function ga_qmcp737c_digi_disp_powoff_nav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end

-- switches


----------------------------  Display Dataref Set End ------------------------------------
----------------------------  Display Dataref Set End ------------------------------------
--------X-Plane common aircraft
----------------------------  Display Dataref Set	 ------------------------------------
-- MCP Panel Digital Display
local qmcp737c_bright_test = 0
local qmcp737c_com1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_nav1_power = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_battery_on = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")
local qmcp737c_avionics_on = uluaFind("(A:CIRCUIT AVIONICS ON,Bool)")

local d_crs1 = uluaFind("(A:NAV OBS:1,Degrees)")
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
local led_app = uluaFind("(A:AUTOPILOT APPROACH HOLD,Bool)")
local led_alth = uluaFind("(A:AUTOPILOT ALTITUDE LOCK, Bool)")
local led_vs = uluaFind("(A:AUTOPILOT VERTICAL HOLD, Bool)")
local led_cmda = uluaFind("(A:AUTOPILOT MASTER, Bool)")
local led_cmdb = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local led_lgn = uluaFind("(A:GEAR CENTER POSITION, percent over 100)")
local led_lgl = uluaFind("(A:GEAR LEFT POSITION, percent over 100)")
local led_lgr = uluaFind("(A:GEAR RIGHT POSITION, percent over 100)")

local led_ma = uluaFind("(A:AUTOPILOT FLIGHT DIRECTOR ACTIVE:1, Bool)")

local led_n1 = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")

local led_spd = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")
local led_lvl = uluaFind("(A:AUTOPILOT FLIGHT LEVEL CHANGE, bool)")
local led_vnav = uluaFind("(A:AUTOPILOT VERTICAL HOLD, Bool)")
local led_hdgs = uluaFind("(A:AUTOPILOT HEADING LOCK,Bool)")
local led_lnav = uluaFind("(L:AP_LNAV_ARMED)")
local led_vorl = uluaFind("(A:AUTOPILOT NAV1 LOCK,Bool)")

local led_at = uluaFind("(A:AUTOTHROTTLE ACTIVE,Bool)")

local led_vhf1 = uluaFind("(A:COM RECEIVE:1,bool)")
local led_vhf2 = uluaFind("(A:COM RECEIVE:2,bool)")

local ap_state = uluaFind("(A:AUTOPILOT MASTER, Bool)")

local brightness = uluaFind("(A:LIGHT POTENTIOMETER:3, Percent)")

-- VHF1/VHF2


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

    uluaSet(idr_qmcp737c_hid_ledvhf1, uluaGet(led_vhf1))
    uluaSet(idr_qmcp737c_hid_ledvhf2, uluaGet(led_vhf2))
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

function ga_qmcp737c_digi_disp_set_VS()
    qmcp737c:SetVs()
end

function ga_qmcp737c_digi_disp_set_CRS2()
    uluaSet(idr_qmcp737c_hid_crs2, uluaGet(d_crs2))
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

-- COM Panel
function ga_qmcp737c_digi_disp_set_VHFA()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if 0 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com))
    else
        uluaSet(idr_qmcp737c_hid_vhfa, uluaGet(d_com2))
    end
end

function ga_qmcp737c_digi_disp_set_VHFS()
    -- local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if 0 == 0 then
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
    uluaSet(idr_qmcp737c_hid_navs, uluaGet(d_navs) * 100)
    uluaSet(idr_qmcp737c_hid_navsmod, 1)
end

-- Backlight
local light_test_last = 0
function ga_qmcp737c_digi_disp_set_Bright()
    local qmcp737c_bright_test_val = qmcp737c_bright_test
    if uluaGet(qmcp737c_avionics_on) < 0 then
        uluaSet(idr_qmcp737c_hid_bright, 0)
    else
        uluaSet(idr_qmcp737c_hid_bright, uluaGet(brightness) * MaxBightness / 100)
    end
    -- if uluaGet(qmcp737c_battery_on) == 0 then --power off  exit text mode
    --	uluaSet(idr_qmcp737c_hid_brightmod, 0)
    -- else
    uluaSet(idr_qmcp737c_hid_brightmod, qmcp737c_bright_test_val) -- 1,2
    -- end
    uluaSet(idr_qmcp737c_hid_dispbright, math.floor(uluaGet(brightness) * 2 / 100))

    if lighttest_last ~= qmcp737c_bright_test_val then
        if qmcp737c_bright_test_val == 0 then
            uluaSet(idr_qmcp737c_hid_invalid, -1)
        end
        lighttest_last = qmcp737c_bright_test_val
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

function ga_qmcp737c_digi_disp_every_frame()
    ga_qmcp737c_digi_disp_set_Bright()

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

uluaAddDoLoop("ga_qmcp737c_digi_disp_every_frame()")
