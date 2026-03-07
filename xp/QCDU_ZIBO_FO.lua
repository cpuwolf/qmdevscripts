-- ***********************************************************************************
-- QCDU Driver for ZIBO
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- GitHub Repository: https://gitee.com/cpuwolf/qmdev
-- Last Modified: 2023-10-31
-- Version: 3.51.7 (ZIBO)
--
-- This script is part of the QCDU project, which interfaces with the ZIBO mod
-- for X-Plane 11. It utilizes the qmdev plugin for hardware interaction.
-- 
-- Send 3 Bytes:
-- 1st Byte
---- B7   B6   B5   B4    B3    B2     B1     B0
---- X    X    X   EXEC  FAIL  CALL   OFST   MSG
-- 2nd Byte
---- B7 B6 B5 B4  B3  B2    B1   B0
---- X  X  X  FM2  ?  RDY   IND  FM1
-- 3rd Byte
---- B7 B6 B5 B4 B3 B2 B1 B0
----  Brightness
-- ***********************************************************************************
if PLANE_ICAO ~= "B738" and PLANE_ICAO ~= "B736" and PLANE_ICAO ~= "B737" and PLANE_ICAO ~= "B739" and PLANE_TAILNUMBER ~=
    "ZB738" and PLANE_TAILNUMBER ~= "ZB736" and PLANE_TAILNUMBER ~= "ZB737" and PLANE_TAILNUMBER ~= "ZB739" then
    return
end

-- Do not remove below lines: hardware detection
local qcdubf = com.sim.qm.Qcdubf:new()
if not qcdubf:Init() then
    return
end
-- Do not remove above lines: hardware detection

ilua_qlcd_set_airplane(100)

-- Configure button bindings using Qcdubf class
qcdubf:CfgEncFull(69, 70, "laminar/B738/electric/instrument_brightness[11]", 0.05, 0.05, 1, 0.05, 1.0)
qcdubf:CfgCmd(0, "laminar/B738/button/fmc2_1L")
qcdubf:CfgCmd(1, "laminar/B738/button/fmc2_2L")
qcdubf:CfgCmd(2, "laminar/B738/button/fmc2_3L")
qcdubf:CfgCmd(3, "laminar/B738/button/fmc2_4L")
qcdubf:CfgCmd(4, "laminar/B738/button/fmc2_5L")
qcdubf:CfgCmd(5, "laminar/B738/button/fmc2_6L")
qcdubf:CfgCmd(6, "laminar/B738/button/fmc2_1R")
qcdubf:CfgCmd(7, "laminar/B738/button/fmc2_2R")
qcdubf:CfgCmd(8, "laminar/B738/button/fmc2_3R")
qcdubf:CfgCmd(9, "laminar/B738/button/fmc2_4R")
qcdubf:CfgCmd(10, "laminar/B738/button/fmc2_5R")
qcdubf:CfgCmd(11, "laminar/B738/button/fmc2_6R")
qcdubf:CfgCmd(12, "laminar/B738/button/fmc2_init_ref")
qcdubf:CfgCmd(13, "laminar/B738/button/fmc2_rte")
qcdubf:CfgCmd(14, "laminar/B738/button/fmc2_clb")
qcdubf:CfgCmd(15, "laminar/B738/button/fmc2_crz")
qcdubf:CfgCmd(16, "laminar/B738/button/fmc2_des")
qcdubf:CfgCmd(17, "laminar/B738/button/fmc2_menu")
qcdubf:CfgCmd(18, "laminar/B738/button/fmc2_legs")
qcdubf:CfgCmd(19, "laminar/B738/button/fmc2_dep_app")
qcdubf:CfgCmd(20, "laminar/B738/button/fmc2_hold")
qcdubf:CfgCmd(21, "laminar/B738/button/fmc2_prog")
qcdubf:CfgCmd(22, "laminar/B738/button/fmc2_exec")
qcdubf:CfgCmd(23, "laminar/B738/button/fmc2_n1_lim")
qcdubf:CfgCmd(24, "laminar/B738/button/fmc2_fix")
qcdubf:CfgCmd(25, "laminar/B738/button/fmc2_prev_page")
qcdubf:CfgCmd(26, "laminar/B738/button/fmc2_next_page")
qcdubf:CfgCmd(27, "laminar/B738/button/fmc2_1")
qcdubf:CfgCmd(28, "laminar/B738/button/fmc2_2")
qcdubf:CfgCmd(29, "laminar/B738/button/fmc2_3")
qcdubf:CfgCmd(30, "laminar/B738/button/fmc2_4")
qcdubf:CfgCmd(31, "laminar/B738/button/fmc2_5")
qcdubf:CfgCmd(32, "laminar/B738/button/fmc2_6")
qcdubf:CfgCmd(33, "laminar/B738/button/fmc2_7")
qcdubf:CfgCmd(34, "laminar/B738/button/fmc2_8")
qcdubf:CfgCmd(35, "laminar/B738/button/fmc2_9")
qcdubf:CfgCmd(36, "laminar/B738/button/fmc2_period")
qcdubf:CfgCmd(37, "laminar/B738/button/fmc2_0")
qcdubf:CfgCmd(38, "laminar/B738/button/fmc2_minus")
qcdubf:CfgCmd(39, "laminar/B738/button/fmc2_A")
qcdubf:CfgCmd(40, "laminar/B738/button/fmc2_B")
qcdubf:CfgCmd(41, "laminar/B738/button/fmc2_C")
qcdubf:CfgCmd(42, "laminar/B738/button/fmc2_D")
qcdubf:CfgCmd(43, "laminar/B738/button/fmc2_E")
qcdubf:CfgCmd(44, "laminar/B738/button/fmc2_F")
qcdubf:CfgCmd(45, "laminar/B738/button/fmc2_G")
qcdubf:CfgCmd(46, "laminar/B738/button/fmc2_H")
qcdubf:CfgCmd(47, "laminar/B738/button/fmc2_I")
qcdubf:CfgCmd(48, "laminar/B738/button/fmc2_J")
qcdubf:CfgCmd(49, "laminar/B738/button/fmc2_K")
qcdubf:CfgCmd(50, "laminar/B738/button/fmc2_L")
qcdubf:CfgCmd(51, "laminar/B738/button/fmc2_M")
qcdubf:CfgCmd(52, "laminar/B738/button/fmc2_N")
qcdubf:CfgCmd(53, "laminar/B738/button/fmc2_O")
qcdubf:CfgCmd(54, "laminar/B738/button/fmc2_P")
qcdubf:CfgCmd(55, "laminar/B738/button/fmc2_Q")
qcdubf:CfgCmd(56, "laminar/B738/button/fmc2_R")
qcdubf:CfgCmd(57, "laminar/B738/button/fmc2_S")
qcdubf:CfgCmd(58, "laminar/B738/button/fmc2_T")
qcdubf:CfgCmd(59, "laminar/B738/button/fmc2_U")
qcdubf:CfgCmd(60, "laminar/B738/button/fmc2_V")
qcdubf:CfgCmd(61, "laminar/B738/button/fmc2_W")
qcdubf:CfgCmd(62, "laminar/B738/button/fmc2_X")
qcdubf:CfgCmd(63, "laminar/B738/button/fmc2_Y")
qcdubf:CfgCmd(64, "laminar/B738/button/fmc2_Z")
qcdubf:CfgCmd(65, "laminar/B738/button/fmc2_SP")
qcdubf:CfgCmd(66, "laminar/B738/button/fmc2_del")
qcdubf:CfgCmd(67, "laminar/B738/button/fmc2_slash")
qcdubf:CfgCmd(68, "laminar/B738/button/fmc2_clr")

uluaLog("QCDU FO for ZIBO")

-- DataRef setup for LED indicators
local dr_CDU_B737_fo_exec = uluaFind("laminar/B738/indicators/fmc_exec_lights_fo")
local dr_CDU_B737_fo_msg = uluaFind("laminar/B738/fmc/fmc_message2")
local dr_CDU_B737_fo_brightness = uluaFind("laminar/B738/electric/panel_brightness[3]")
qcdubf:GetScreenBrt("laminar/B738/electric/instrument_brightness[11]") -- 0-1

-- LED Update Function
function CDU_B737_LED_FO_UPD()
    qcdubf:SetMsg(nil, math.floor(uluaGet(dr_CDU_B737_fo_msg) + 0.5))
    qcdubf:SetExec(nil, math.floor(uluaGet(dr_CDU_B737_fo_exec) + 0.5))
    qcdubf:SetScreenBrt()
    local brightness = math.floor(uluaGet(dr_CDU_B737_fo_brightness) * 50)
    qcdubf:SetBkl(brightness)
end

uluaAddDoLoop("CDU_B737_LED_FO_UPD()")
