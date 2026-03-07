--**********************Copyright***********************--
-- modified by Wei Shuai <cpuwolf@gmail.com>
-- 2021-12-30 tested on Hot Start TBM-900 v1.1.13
--######################  Edit part  #####################
--此处调整加速点, 值越小,越容易进入加速模式,可根据自己的手感调节
local FastTurnsPerSecond = 30 --How many spins per second  is considered FAST?

--########################################################


-- Do not remove below lines: hardware detection
local qgmc710 = com.sim.qm.Qgmc710:new()
if not qgmc710:Init() then
    return
end
-- Do not remove above lines: hardware detection


local qgmv710_xp_cockpit_led = uluaFind("(A:LIGHT POTENTIOMETER:3, Percent)")

local qgmv710_xp_flc_led = uluaFind("(A:AUTOPILOT FLIGHT LEVEL CHANGE, bool)")
local qgmv710_xp_vs_led = uluaFind("(A:AUTOPILOT VERTICAL HOLD, Bool)")
local qgmv710_xp_yd_led = uluaFind("(A:AUTOPILOT YAW DAMPER,Bool)")
local qgmv710_xp_xfr_r_led = uluaFind("(A:AUTOPILOT BACKCOURSE HOLD,Bool)")
local qgmv710_xp_bank_led = uluaFind("(A:AUTOPILOT MAX BANK, Radians) 0.5 <")
local qgmv710_xp_nav_led = uluaFind("(A:AUTOPILOT NAV1 LOCK,Bool)")
local qgmv710_xp_hdg_led = uluaFind("(A:AUTOPILOT HEADING LOCK,Bool)")

local qgmv710_xp_vnv_led = uluaFind("(A:AUTOPILOT VERTICAL HOLD, Bool)")
local qgmv710_xp_alt_led = uluaFind("(A:AUTOPILOT ALTITUDE LOCK, Bool)")
local qgmv710_xp_ap_led = uluaFind("(A:AUTOPILOT MASTER, Bool)")
local qgmv710_xp_xfr_l_led = uluaFind("(A:AUTOPILOT BACKCOURSE HOLD,Bool)")
local qgmv710_xp_bc_led = uluaFind("(A:AUTOPILOT BACKCOURSE HOLD,Bool)")
local qgmv710_xp_apr_led = uluaFind("(A:AUTOPILOT APPROACH HOLD,Bool)")

qgmc710:CfgRpn(0, "(>K:AP_PANEL_HEADING_HOLD)", "")
qgmc710:CfgRpn(
    1,
    "(A:AUTOPILOT APPROACH HOLD,Bool) (A:AUTOPILOT GLIDESLOPE HOLD, Bool) ! and if{ (>K:AP_APR_HOLD) } (>K:AP_APR_HOLD)",
    ""
)
qgmc710:CfgRpn(2, "(>K:AP_NAV1_HOLD)", "")
qgmc710:CfgRpn(3, "(A:AUTOPILOT MASTER, bool) ! if{ 0 (>K:TOGGLE_FLIGHT_DIRECTOR) }", "")
qgmc710:CfgRpn(4, "(L:XMLVAR_PushXFR) ! (>L:XMLVAR_PushXFR)", "")
qgmc710:CfgRpn(5, "(>K:AP_ALT_HOLD)", "")
qgmc710:CfgRpn(6, "(>K:AP_PANEL_VS_HOLD)", "")
qgmc710:CfgRpn(7, "(>K:FLIGHT_LEVEL_CHANGE) (A:AIRSPEED INDICATED, knots) (>K:AP_SPD_VAR_SET)", "")
qgmc710:CfgRpn(8, "(>K:AP_BC_HOLD)", "")
qgmc710:CfgRpn(9, "(>K:AP_MAX_BANK_INC)", "")
qgmc710:CfgRpn(
    10,
    "(A:AUTOPILOT DISENGAGED, Bool) ! if{ (>K:AP_MASTER) (A:AUTOPILOT MASTER, Bool) if{ (A:AUTOPILOT FLIGHT DIRECTOR ACTIVE, Bool) ! if{ 1 (>K:TOGGLE_FLIGHT_DIRECTOR) } } (A:AUTOPILOT MASTER, bool) ! if{ (H:Generic_Autopilot_Manual_Off) } }",
    ""
)
qgmc710:CfgRpn(11, "(>K:YAW_DAMPER_TOGGLE)", "")
qgmc710:CfgRpn(12, "(L:XMLVAR_VNAVButtonValue) ! (>L:XMLVAR_VNAVButtonValue)", "")
qgmc710:CfgRpn(13, "(L:XMLVAR_AirSpeedIsInMach, Number) ! (>L:XMLVAR_AirSpeedIsInMach, Number)", "")
qgmc710:CfgRpn(14, "(A:HEADING INDICATOR, degrees) (>K:HEADING_BUG_SET)", "")
qgmc710:CfgRpn(15, "(A:HEADING INDICATOR, Radians) 57.29 * (>K:VOR1_SET)", "")
qgmc710:CfgRpn(17, "(A:HEADING INDICATOR, Radians) 57.29 * (>K:VOR2_SET)", "")
qgmc710:CfgRpn(18, "(>K:HEADING_BUG_DEC)", "")
qgmc710:CfgRpn(19, "(>K:HEADING_BUG_INC)", "")
qgmc710:CfgRpn(20, "(>K:VOR1_OBI_DEC)", "")
qgmc710:CfgRpn(21, "(>K:VOR1_OBI_INC)", "")
qgmc710:CfgRpn(22, "100 (>K:AP_ALT_VAR_DEC)", "")
qgmc710:CfgRpn(23, "100 (>K:AP_ALT_VAR_INC)", "")
qgmc710:CfgRpn(
    24,
    "(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_DEC) (>H:AP_UP) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_INC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_DN) }",
    ""
)
qgmc710:CfgRpn(
    25,
    "(A:AUTOPILOT VERTICAL HOLD, Bool) if{ (>K:AP_VS_VAR_INC) (>H:AP_DN) } (A:AUTOPILOT FLIGHT LEVEL CHANGE, Bool) if{ (>K:AP_SPD_VAR_DEC) } (A:AUTOPILOT PITCH HOLD, Bool) if{ (>K:AP_PITCH_REF_INC_UP) }",
    ""
)
qgmc710:CfgRpn(27, "(>K:VOR2_OBI_INC)", "")

uluaLog("QGMC710 for GA")

function QGMC710_GA_LED_UPD()
    local brightness = uluaGet(qgmv710_xp_cockpit_led)
    local led_br
    uluaSet(idr_qgmc710_hid_ledflc, ilua_01_ternary(qgmv710_xp_flc_led, 0))
    uluaSet(idr_qgmc710_hid_ledvs, ilua_01_ternary(qgmv710_xp_vs_led, 0))
    uluaSet(idr_qgmc710_hid_ledyd, ilua_01_ternary(qgmv710_xp_yd_led, 0))
    uluaSet(idr_qgmc710_hid_ledxfrr, ilua_01_ternary(qgmv710_xp_xfr_r_led, 0))
    uluaSet(idr_qgmc710_hid_ledbank, ilua_01_ternary(qgmv710_xp_bank_led, 0))
    uluaSet(idr_qgmc710_hid_lednav, ilua_01_ternary(qgmv710_xp_nav_led, 0))
    uluaSet(idr_qgmc710_hid_ledhdg, ilua_01_ternary(qgmv710_xp_hdg_led, 0))
    uluaSet(idr_qgmc710_hid_ledvnav, ilua_01_ternary(qgmv710_xp_vnv_led, 0))
    uluaSet(idr_qgmc710_hid_ledalt, ilua_01_ternary(qgmv710_xp_alt_led, 1))
    uluaSet(idr_qgmc710_hid_ledap, ilua_01_ternary(qgmv710_xp_ap_led, 0))
    uluaSet(idr_qgmc710_hid_ledxfrl, ilua_01_ternary(qgmv710_xp_xfr_l_led, 0))
    uluaSet(idr_qgmc710_hid_ledbc, ilua_01_ternary(qgmv710_xp_bc_led, 0))
    uluaSet(idr_qgmc710_hid_ledapr, ilua_01_ternary(qgmv710_xp_apr_led, 0))

    if brightness > 0 then
        led_br = math.floor(brightness)
    else
        led_br = 0
    end
    uluaSet(idr_qgmc710_hid_bright, led_br)
end

uluaAddDoLoop("QGMC710_GA_LED_UPD()")
