-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-22
-- *****************************************************************
if ilua_is_acfpath_excluded("lvfr") or ilua_is_acfpath_excluded("a3") then
    return
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection
uluaLog("QCDU-A320 for LVFR")

-- ===========================================================
-- button binding

qcdua:CfgVal(0, "B:FMC_A320_1_Softkey_L_1", 1, 0)
qcdua:CfgVal(1, "B:FMC_A320_1_Softkey_L_2", 1, 0)
qcdua:CfgVal(2, "B:FMC_A320_1_Softkey_L_3", 1, 0)
qcdua:CfgVal(3, "B:FMC_A320_1_Softkey_L_4", 1, 0)
qcdua:CfgVal(4, "B:FMC_A320_1_Softkey_L_5", 1, 0)
qcdua:CfgVal(5, "B:FMC_A320_1_Softkey_L_6", 1, 0)
qcdua:CfgVal(6, "B:FMC_A320_1_Softkey_R_1", 1, 0)
qcdua:CfgVal(7, "B:FMC_A320_1_Softkey_R_2", 1, 0)
qcdua:CfgVal(8, "B:FMC_A320_1_Softkey_R_3", 1, 0)
qcdua:CfgVal(9, "B:FMC_A320_1_Softkey_R_4", 1, 0)
qcdua:CfgVal(10, "B:FMC_A320_1_Softkey_R_5", 1, 0)
qcdua:CfgVal(11, "B:FMC_A320_1_Softkey_R_6", 1, 0)

qcdua:CfgVal(12, "B:FMC_A320_1_Button_DIR", 1, 0)
qcdua:CfgVal(13, "B:FMC_A320_1_Button_PROG", 1, 0)
qcdua:CfgVal(14, "B:FMC_A320_1_Button_PERF", 1, 0)
qcdua:CfgVal(15, "B:FMC_A320_1_Button_INIT", 1, 0)
qcdua:CfgVal(16, "B:FMC_A320_1_Button_DATA", 1, 0)
qcdua:CfgVal(17, "B:FMC_A320_1_Button_FPLN", 1, 0)
qcdua:CfgVal(18, "B:FMC_A320_1_Button_NAVRAD", 1, 0)
qcdua:CfgVal(19, "B:FMC_A320_1_Button_FUEL", 1, 0)
qcdua:CfgVal(20, "B:FMC_A320_1_Button_SEC", 1, 0)
qcdua:CfgVal(21, "B:FMC_A320_1_Button_ATC", 1, 0)
qcdua:CfgVal(22, "B:FMC_A320_1_Button_MENU", 1, 0)

qcdua:CfgVal(23, "B:FMC_A320_1_Button_AIRPORT", 1, 0)
qcdua:CfgVal(24, "B:FMC_A320_1_Button_UP", 1, 0)
qcdua:CfgVal(25, "B:FMC_A320_1_Button_PREVPAGE", 1, 0)
qcdua:CfgVal(26, "B:FMC_A320_1_Button_NEXTPAGE", 1, 0)
qcdua:CfgVal(71, "B:FMC_A320_1_Button_DOWN", 1, 0)

qcdua:CfgVal(27, "B:FMC_A320_1_Keyboard_1", 1, 0)
qcdua:CfgVal(28, "B:FMC_A320_1_Keyboard_2", 1, 0)
qcdua:CfgVal(29, "B:FMC_A320_1_Keyboard_3", 1, 0)
qcdua:CfgVal(30, "B:FMC_A320_1_Keyboard_4", 1, 0)
qcdua:CfgVal(31, "B:FMC_A320_1_Keyboard_5", 1, 0)
qcdua:CfgVal(32, "B:FMC_A320_1_Keyboard_6", 1, 0)
qcdua:CfgVal(33, "B:FMC_A320_1_Keyboard_7", 1, 0)
qcdua:CfgVal(34, "B:FMC_A320_1_Keyboard_8", 1, 0)
qcdua:CfgVal(35, "B:FMC_A320_1_Keyboard_9", 1, 0)
qcdua:CfgVal(36, "B:FMC_A320_1_Button_DOT", 1, 0)

qcdua:CfgVal(37, "B:FMC_A320_1_Keyboard_0", 1, 0)
qcdua:CfgVal(38, "B:FMC_A320_1_Button_PLUSMINUS", 1, 0)

qcdua:CfgVal(39, "B:FMC_A320_1_Keyboard_A", 1, 0)
qcdua:CfgVal(40, "B:FMC_A320_1_Keyboard_B", 1, 0)
qcdua:CfgVal(41, "B:FMC_A320_1_Keyboard_C", 1, 0)
qcdua:CfgVal(42, "B:FMC_A320_1_Keyboard_D", 1, 0)
qcdua:CfgVal(43, "B:FMC_A320_1_Keyboard_E", 1, 0)
qcdua:CfgVal(44, "B:FMC_A320_1_Keyboard_F", 1, 0)
qcdua:CfgVal(45, "B:FMC_A320_1_Keyboard_G", 1, 0)
qcdua:CfgVal(46, "B:FMC_A320_1_Keyboard_H", 1, 0)
qcdua:CfgVal(47, "B:FMC_A320_1_Keyboard_I", 1, 0)
qcdua:CfgVal(48, "B:FMC_A320_1_Keyboard_J", 1, 0)
qcdua:CfgVal(49, "B:FMC_A320_1_Keyboard_K", 1, 0)
qcdua:CfgVal(50, "B:FMC_A320_1_Keyboard_L", 1, 0)
qcdua:CfgVal(51, "B:FMC_A320_1_Keyboard_M", 1, 0)
qcdua:CfgVal(52, "B:FMC_A320_1_Keyboard_N", 1, 0)
qcdua:CfgVal(53, "B:FMC_A320_1_Keyboard_O", 1, 0)
qcdua:CfgVal(54, "B:FMC_A320_1_Keyboard_P", 1, 0)
qcdua:CfgVal(55, "B:FMC_A320_1_Keyboard_Q", 1, 0)
qcdua:CfgVal(56, "B:FMC_A320_1_Keyboard_R", 1, 0)
qcdua:CfgVal(57, "B:FMC_A320_1_Keyboard_S", 1, 0)
qcdua:CfgVal(58, "B:FMC_A320_1_Keyboard_T", 1, 0)
qcdua:CfgVal(59, "B:FMC_A320_1_Keyboard_U", 1, 0)
qcdua:CfgVal(60, "B:FMC_A320_1_Keyboard_V", 1, 0)
qcdua:CfgVal(61, "B:FMC_A320_1_Keyboard_W", 1, 0)
qcdua:CfgVal(62, "B:FMC_A320_1_Keyboard_X", 1, 0)
qcdua:CfgVal(63, "B:FMC_A320_1_Keyboard_Y", 1, 0)
qcdua:CfgVal(64, "B:FMC_A320_1_Keyboard_Z", 1, 0)

qcdua:CfgVal(65, "B:FMC_A320_1_Button_SP", 1, 0)
qcdua:CfgVal(66, "B:FMC_A320_1_Button_OVFY", 1, 0)
qcdua:CfgVal(67, "B:FMC_A320_1_Button_DIV", 1, 0)
qcdua:CfgVal(68, "B:FMC_A320_1_Button_CLR", 1, 0)

qcdua:CfgVal(69, "B:FMC_A320_1_Button_BRT_DIM", 2, 1)
qcdua:CfgVal(70, "B:FMC_A320_1_Button_BRT_DIM", 1, 0)

-- ===========================================================
-- Read data

qcdua:GetFm1("(L:I_CDU1_FM1)")
qcdua:GetInd("(L:I_CDU1_IND)")
qcdua:GetRdy("(L:I_CDU1_RDY)")
qcdua:GetFm2("(L:I_CDU1_FM2)")
qcdua:GetMenu("(L:I_CDU1_MCDU_MENU)")
qcdua:GetFail("(L:I_CDU1_FAIL)")
qcdua:GetFmgc("(L:I_CDU1_FM)")
qcdua:GetBkl("(L:LIGHTING_PANEL_1)", 0.3) -- 0~100
local dr_CDU_A320_ecp_power = iDataRef:New("(L:A320_Neo_BAT_ScreenLuminosity, number)")

function CDU_LVFR_LED_UPD()
    local CDU_A320_ecp_power = dr_CDU_A320_ecp_power:Get()
    qcdua:SetLeds()

    if CDU_A320_ecp_power == 1 then
        qcdua:SetBkl()
    else
        qcdua:Off()
    end
end

uluaAddDoLoop("CDU_LVFR_LED_UPD()")

