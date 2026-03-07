-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-22
-- *****************************************************************
if PLANE_ICAO ~= "B738" and PLANE_ICAO ~= "B736" and PLANE_ICAO ~= "B737" and PLANE_ICAO ~= "B739" and PLANE_TAILNUMBER ~=
    "ZB738" and PLANE_TAILNUMBER ~= "ZB736" and PLANE_TAILNUMBER ~= "ZB737" and PLANE_TAILNUMBER ~= "ZB739" then
    return
end

-- Do not remove below lines: hardware detection
local qcdub = com.sim.qm.Qcdub:new()
if not qcdub:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU for ZIBO")

ilua_qlcd_set_airplane(100)

-- Configure button bindings using Qcdub class
qcdub:CfgEncFull(69, 70, "laminar/B738/electric/instrument_brightness[10]", 0.05, 0.05, 1, 0.05, 1.0)
qcdub:CfgCmd(0, "laminar/B738/button/fmc1_1L")
qcdub:CfgCmd(1, "laminar/B738/button/fmc1_2L")
qcdub:CfgCmd(2, "laminar/B738/button/fmc1_3L")
qcdub:CfgCmd(3, "laminar/B738/button/fmc1_4L")
qcdub:CfgCmd(4, "laminar/B738/button/fmc1_5L")
qcdub:CfgCmd(5, "laminar/B738/button/fmc1_6L")
qcdub:CfgCmd(6, "laminar/B738/button/fmc1_1R")
qcdub:CfgCmd(7, "laminar/B738/button/fmc1_2R")
qcdub:CfgCmd(8, "laminar/B738/button/fmc1_3R")
qcdub:CfgCmd(9, "laminar/B738/button/fmc1_4R")
qcdub:CfgCmd(10, "laminar/B738/button/fmc1_5R")
qcdub:CfgCmd(11, "laminar/B738/button/fmc1_6R")
qcdub:CfgCmd(12, "laminar/B738/button/fmc1_init_ref")
qcdub:CfgCmd(13, "laminar/B738/button/fmc1_rte")
qcdub:CfgCmd(14, "laminar/B738/button/fmc1_clb")
qcdub:CfgCmd(15, "laminar/B738/button/fmc1_crz")
qcdub:CfgCmd(16, "laminar/B738/button/fmc1_des")
qcdub:CfgCmd(17, "laminar/B738/button/fmc1_menu")
qcdub:CfgCmd(18, "laminar/B738/button/fmc1_legs")
qcdub:CfgCmd(19, "laminar/B738/button/fmc1_dep_app")
qcdub:CfgCmd(20, "laminar/B738/button/fmc1_hold")
qcdub:CfgCmd(21, "laminar/B738/button/fmc1_prog")
qcdub:CfgCmd(22, "laminar/B738/button/fmc1_exec")
qcdub:CfgCmd(23, "laminar/B738/button/fmc1_n1_lim")
qcdub:CfgCmd(24, "laminar/B738/button/fmc1_fix")
qcdub:CfgCmd(25, "laminar/B738/button/fmc1_prev_page")
qcdub:CfgCmd(26, "laminar/B738/button/fmc1_next_page")
qcdub:CfgCmd(27, "laminar/B738/button/fmc1_1")
qcdub:CfgCmd(28, "laminar/B738/button/fmc1_2")
qcdub:CfgCmd(29, "laminar/B738/button/fmc1_3")
qcdub:CfgCmd(30, "laminar/B738/button/fmc1_4")
qcdub:CfgCmd(31, "laminar/B738/button/fmc1_5")
qcdub:CfgCmd(32, "laminar/B738/button/fmc1_6")
qcdub:CfgCmd(33, "laminar/B738/button/fmc1_7")
qcdub:CfgCmd(34, "laminar/B738/button/fmc1_8")
qcdub:CfgCmd(35, "laminar/B738/button/fmc1_9")
qcdub:CfgCmd(36, "laminar/B738/button/fmc1_period")
qcdub:CfgCmd(37, "laminar/B738/button/fmc1_0")
qcdub:CfgCmd(38, "laminar/B738/button/fmc1_minus")
qcdub:CfgCmd(39, "laminar/B738/button/fmc1_A")
qcdub:CfgCmd(40, "laminar/B738/button/fmc1_B")
qcdub:CfgCmd(41, "laminar/B738/button/fmc1_C")
qcdub:CfgCmd(42, "laminar/B738/button/fmc1_D")
qcdub:CfgCmd(43, "laminar/B738/button/fmc1_E")
qcdub:CfgCmd(44, "laminar/B738/button/fmc1_F")
qcdub:CfgCmd(45, "laminar/B738/button/fmc1_G")
qcdub:CfgCmd(46, "laminar/B738/button/fmc1_H")
qcdub:CfgCmd(47, "laminar/B738/button/fmc1_I")
qcdub:CfgCmd(48, "laminar/B738/button/fmc1_J")
qcdub:CfgCmd(49, "laminar/B738/button/fmc1_K")
qcdub:CfgCmd(50, "laminar/B738/button/fmc1_L")
qcdub:CfgCmd(51, "laminar/B738/button/fmc1_M")
qcdub:CfgCmd(52, "laminar/B738/button/fmc1_N")
qcdub:CfgCmd(53, "laminar/B738/button/fmc1_O")
qcdub:CfgCmd(54, "laminar/B738/button/fmc1_P")
qcdub:CfgCmd(55, "laminar/B738/button/fmc1_Q")
qcdub:CfgCmd(56, "laminar/B738/button/fmc1_R")
qcdub:CfgCmd(57, "laminar/B738/button/fmc1_S")
qcdub:CfgCmd(58, "laminar/B738/button/fmc1_T")
qcdub:CfgCmd(59, "laminar/B738/button/fmc1_U")
qcdub:CfgCmd(60, "laminar/B738/button/fmc1_V")
qcdub:CfgCmd(61, "laminar/B738/button/fmc1_W")
qcdub:CfgCmd(62, "laminar/B738/button/fmc1_X")
qcdub:CfgCmd(63, "laminar/B738/button/fmc1_Y")
qcdub:CfgCmd(64, "laminar/B738/button/fmc1_Z")
qcdub:CfgCmd(65, "laminar/B738/button/fmc1_SP")
qcdub:CfgCmd(66, "laminar/B738/button/fmc1_del")
qcdub:CfgCmd(67, "laminar/B738/button/fmc1_slash")
qcdub:CfgCmd(68, "laminar/B738/button/fmc1_clr")

-- DataRef setup for LED indicators
local dr_CDU_B737_msg = uluaFind("laminar/B738/fmc/fmc_message")
if dr_CDU_B737_msg == nil  then
    uluaLog("This is not ZIBO, maybe default 738")
    return
end
local dr_CDU_B737_exec = uluaFind("laminar/B738/indicators/fmc_exec_lights")
local dr_CDU_B737_brightness = uluaFind("laminar/B738/electric/panel_brightness[3]")
qcdub:GetScreenBrt("laminar/B738/electric/instrument_brightness[10]") -- 0-1

-- LED Update Function
function CDU_B737_LED_UPD()
    qcdub:SetMsg(nil, math.floor(uluaGet(dr_CDU_B737_msg) + 0.5))
    qcdub:SetExec(nil, math.floor(uluaGet(dr_CDU_B737_exec) + 0.5))
    qcdub:SetScreenBrt()
    local brightness = math.floor(uluaGet(dr_CDU_B737_brightness) * 50)
    qcdub:SetBkl(brightness)
end

uluaAddDoLoop("CDU_B737_LED_UPD()")
