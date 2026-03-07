-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-11-28
-- *****************************************************************

if ilua_is_acftitle_excluded("E1") or ilua_is_acfpath_excluded("embraer") then
    return
end


-- Do not remove below lines: hardware detection
local qcdub = com.sim.qm.Qcdub:new()
if not qcdub:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU for ERJ family")

ilua_qlcd_set_airplane(100)

-- Configure button bindings using Qcdub class
qcdub:CfgCmd(0, "XCrafts/ERJ/CDU_1/LSK1")
qcdub:CfgCmd(1, "XCrafts/ERJ/CDU_1/LSK2")
qcdub:CfgCmd(2, "XCrafts/ERJ/CDU_1/LSK3")
qcdub:CfgCmd(3, "XCrafts/ERJ/CDU_1/LSK4")
qcdub:CfgCmd(4, "XCrafts/ERJ/CDU_1/LSK5")
qcdub:CfgCmd(5, "XCrafts/ERJ/CDU_1/LSK6")
qcdub:CfgCmd(6, "XCrafts/ERJ/CDU_1/RSK1")
qcdub:CfgCmd(7, "XCrafts/ERJ/CDU_1/RSK2")
qcdub:CfgCmd(8, "XCrafts/ERJ/CDU_1/RSK3")
qcdub:CfgCmd(9, "XCrafts/ERJ/CDU_1/RSK4")
qcdub:CfgCmd(10, "XCrafts/ERJ/CDU_1/RSK5")
qcdub:CfgCmd(11, "XCrafts/ERJ/CDU_1/RSK6")
qcdub:CfgCmd(12, "XCrafts/ERJ/CDU_1/Key_PERF")
qcdub:CfgCmd(13, "XCrafts/ERJ/CDU_1/Key_RTE")
qcdub:CfgCmd(14, "XCrafts/ERJ/CDU_1/Key_CB")
qcdub:CfgCmd(15, "XCrafts/ERJ/CDU_1/Key_CRZ")
qcdub:CfgCmd(16, "XCrafts/ERJ/CDU_1/Key_DES")
qcdub:CfgCmd(17, "XCrafts/ERJ/CDU_1/Key_MENU")
qcdub:CfgCmd(18, "XCrafts/ERJ/CDU_1/Key_FPL")
qcdub:CfgCmd(19, "XCrafts/ERJ/CDU_1/Key_NAV")
qcdub:CfgCmd(20, "XCrafts/ERJ/CDU_1/Key_DLK")
qcdub:CfgCmd(21, "XCrafts/ERJ/CDU_1/Key_PROG")
qcdub:CfgCmd(22, "XCrafts/ERJ/CDU_1/Key_EXEC")
qcdub:CfgCmd(23, "XCrafts/ERJ/CDU_1/Key_TRS")
qcdub:CfgCmd(24, "XCrafts/ERJ/CDU_1/Key_RADIO")
qcdub:CfgCmd(25, "XCrafts/ERJ/CDU_1/Key_PREV")
qcdub:CfgCmd(26, "XCrafts/ERJ/CDU_1/Key_NEXT")
qcdub:CfgCmd(27, "XCrafts/ERJ/CDU_1/Key_1")
qcdub:CfgCmd(28, "XCrafts/ERJ/CDU_1/Key_2")
qcdub:CfgCmd(29, "XCrafts/ERJ/CDU_1/Key_3")
qcdub:CfgCmd(30, "XCrafts/ERJ/CDU_1/Key_4")
qcdub:CfgCmd(31, "XCrafts/ERJ/CDU_1/Key_5")
qcdub:CfgCmd(32, "XCrafts/ERJ/CDU_1/Key_6")
qcdub:CfgCmd(33, "XCrafts/ERJ/CDU_1/Key_7")
qcdub:CfgCmd(34, "XCrafts/ERJ/CDU_1/Key_8")
qcdub:CfgCmd(35, "XCrafts/ERJ/CDU_1/Key_9")
qcdub:CfgCmd(36, "XCrafts/ERJ/CDU_1/Key_Decimal")
qcdub:CfgCmd(37, "XCrafts/ERJ/CDU_1/Key_0")
qcdub:CfgCmd(38, "XCrafts/ERJ/CDU_1/Key_PlusMinus")
qcdub:CfgCmd(39, "XCrafts/ERJ/CDU_1/Key_A")
qcdub:CfgCmd(40, "XCrafts/ERJ/CDU_1/Key_B")
qcdub:CfgCmd(41, "XCrafts/ERJ/CDU_1/Key_C")
qcdub:CfgCmd(42, "XCrafts/ERJ/CDU_1/Key_D")
qcdub:CfgCmd(43, "XCrafts/ERJ/CDU_1/Key_E")
qcdub:CfgCmd(44, "XCrafts/ERJ/CDU_1/Key_F")
qcdub:CfgCmd(45, "XCrafts/ERJ/CDU_1/Key_G")
qcdub:CfgCmd(46, "XCrafts/ERJ/CDU_1/Key_H")
qcdub:CfgCmd(47, "XCrafts/ERJ/CDU_1/Key_I")
qcdub:CfgCmd(48, "XCrafts/ERJ/CDU_1/Key_J")
qcdub:CfgCmd(49, "XCrafts/ERJ/CDU_1/Key_K")
qcdub:CfgCmd(50, "XCrafts/ERJ/CDU_1/Key_L")
qcdub:CfgCmd(51, "XCrafts/ERJ/CDU_1/Key_M")
qcdub:CfgCmd(52, "XCrafts/ERJ/CDU_1/Key_N")
qcdub:CfgCmd(53, "XCrafts/ERJ/CDU_1/Key_O")
qcdub:CfgCmd(54, "XCrafts/ERJ/CDU_1/Key_P")
qcdub:CfgCmd(55, "XCrafts/ERJ/CDU_1/Key_Q")
qcdub:CfgCmd(56, "XCrafts/ERJ/CDU_1/Key_R")
qcdub:CfgCmd(57, "XCrafts/ERJ/CDU_1/Key_S")
qcdub:CfgCmd(58, "XCrafts/ERJ/CDU_1/Key_T")
qcdub:CfgCmd(59, "XCrafts/ERJ/CDU_1/Key_U")
qcdub:CfgCmd(60, "XCrafts/ERJ/CDU_1/Key_V")
qcdub:CfgCmd(61, "XCrafts/ERJ/CDU_1/Key_W")
qcdub:CfgCmd(62, "XCrafts/ERJ/CDU_1/Key_X")
qcdub:CfgCmd(63, "XCrafts/ERJ/CDU_1/Key_Y")
qcdub:CfgCmd(64, "XCrafts/ERJ/CDU_1/Key_Z")
qcdub:CfgCmd(65, "XCrafts/ERJ/CDU_1/Key_Space")
qcdub:CfgCmd(66, "XCrafts/ERJ/CDU_1/Key_DEL")
qcdub:CfgCmd(67, "XCrafts/ERJ/CDU_1/Key_Slash_Command")
qcdub:CfgCmd(68, "XCrafts/ERJ/CDU_1/Key_CLR")

qcdub:CfgCmd(69, "XCrafts/ERJ/CDU_1/Key_DIM")
qcdub:CfgCmd(70, "XCrafts/ERJ/CDU_1/Key_BRT")


-- DataRef setup for LED indicators
local dr_CDU_ERJ_exec = uluaFind("sim/cockpit/g1000/g1000_n2_eis")
local dr_CDU_ERJ_msg = uluaFind("sim/cockpit/g1000/g1000_n2_eis")
local dr_CDU_ERJ_brightness = uluaFind("sim/cockpit2/electrical/panel_brightness_ratio[2]") -- 0-1
qcdub:GetScreenBrt('XCrafts/FMS/CDU1_brt') -- 0-1

-- LED Update Function
-- DONT use this name "CDU_ERJ_LED_UPD" again
-- it must be unique across all .sec and lua files
function CDU_ERJ_LED_UPD()
    qcdub:SetMsg(nil, math.floor(uluaGet(dr_CDU_ERJ_msg) + 0.5))
    qcdub:SetExec(nil, math.floor(uluaGet(dr_CDU_ERJ_exec) + 0.5))
    qcdub:SetScreenBrt()
    local brightness = math.floor(uluaGet(dr_CDU_ERJ_brightness) * 60)
    qcdub:SetBkl(brightness)
end

uluaAddDoLoop("CDU_ERJ_LED_UPD()")
