-- *****************************************************************
-- created by Joseph Yoon <joseph@jyoon.pro> 2024-07-01
-- *****************************************************************
if ilua_is_acfpath_excluded("a300") and ilua_is_acfpath_excluded("600") then
    return
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 for INIBUILDS A300")

-- ===========================================================
-- button binding

qcdua:CfgRpn(0, '1 (>L:INI_MCDU1_LSK1L)', '')
qcdua:CfgRpn(1, '1 (>L:INI_MCDU1_LSK2L)', '')
qcdua:CfgRpn(2, '1 (>L:INI_MCDU1_LSK3L)', '')
qcdua:CfgRpn(3, '1 (>L:INI_MCDU1_LSK4L)', '')
qcdua:CfgRpn(4, '1 (>L:INI_MCDU1_LSK5L)', '')
qcdua:CfgRpn(5, '1 (>L:INI_MCDU1_LSK6L)', '')
qcdua:CfgRpn(6, '1 (>L:INI_MCDU1_LSK1R)', '')
qcdua:CfgRpn(7, '1 (>L:INI_MCDU1_LSK2R)', '')
qcdua:CfgRpn(8, '1 (>L:INI_MCDU1_LSK3R)', '')
qcdua:CfgRpn(9, '1 (>L:INI_MCDU1_LSK4R)', '')
qcdua:CfgRpn(10, '1 (>L:INI_MCDU1_LSK5R)', '')
qcdua:CfgRpn(11, '1 (>L:INI_MCDU1_LSK6R)', '')
qcdua:CfgRpn(12, '1 (>L:INI_MCDU1_DIR_TO)', '')
qcdua:CfgRpn(13, '1 (>L:INI_MCDU1_PROG)', '')
qcdua:CfgRpn(14, '1 (>L:INI_MCDU1_TO_APPR)', '')
qcdua:CfgRpn(15, '1 (>L:INI_MCDU1_INIT)', '')
qcdua:CfgRpn(16, '1 (>L:INI_MCDU1_REF)', '')
qcdua:CfgRpn(17, '1 (>L:INI_MCDU1_FPLAN)', '')
qcdua:CfgRpn(18, '1 (>L:INI_MCDU1_MODE)', '')
qcdua:CfgRpn(19, '1 (>L:INI_MCDU1_TACT_MODE)', '')
qcdua:CfgRpn(20, '1 (>L:INI_MCDU1_SEC_PLAN)', '')
qcdua:CfgRpn(21, '1 (>L:INI_MCDU1_MENU)', '')
qcdua:CfgRpn(22, '1 (>L:INI_MCDU1_MENU)', '')
qcdua:CfgRpn(23, '1 (>L:INI_MCDU1_ENGOUT)', '')
qcdua:CfgRpn(24, '1 (>L:INI_MCDU1_UARROW)', '')
qcdua:CfgRpn(26, '1 (>L:INI_MCDU1_NEXT)', '')
qcdua:CfgRpn(71, '1 (>L:INI_MCDU1_DOWN)', '')
qcdua:CfgRpn(27, '1 (>L:INI_MCDU1_1)', '')
qcdua:CfgRpn(28, '1 (>L:INI_MCDU1_2)', '')
qcdua:CfgRpn(29, '1 (>L:INI_MCDU1_3)', '')
qcdua:CfgRpn(30, '1 (>L:INI_MCDU1_4)', '')
qcdua:CfgRpn(31, '1 (>L:INI_MCDU1_5)', '')
qcdua:CfgRpn(32, '1 (>L:INI_MCDU1_6)', '')
qcdua:CfgRpn(33, '1 (>L:INI_MCDU1_7)', '')
qcdua:CfgRpn(34, '1 (>L:INI_MCDU1_8)', '')
qcdua:CfgRpn(35, '1 (>L:INI_MCDU1_9)', '')
qcdua:CfgRpn(36, '1 (>L:INI_MCDU1_DOT)', '')
qcdua:CfgRpn(37, '1 (>L:INI_MCDU1_0)', '')
qcdua:CfgRpn(38, '1 (>L:INI_MCDU1_MINUS)', '')
qcdua:CfgRpn(39, '1 (>L:INI_MCDU1_A)', '')
qcdua:CfgRpn(40, '1 (>L:INI_MCDU1_B)', '')
qcdua:CfgRpn(41, '1 (>L:INI_MCDU1_C)', '')
qcdua:CfgRpn(42, '1 (>L:INI_MCDU1_D)', '')
qcdua:CfgRpn(43, '1 (>L:INI_MCDU1_E)', '')
qcdua:CfgRpn(44, '1 (>L:INI_MCDU1_F)', '')
qcdua:CfgRpn(45, '1 (>L:INI_MCDU1_G)', '')
qcdua:CfgRpn(46, '1 (>L:INI_MCDU1_H)', '')
qcdua:CfgRpn(47, '1 (>L:INI_MCDU1_I)', '')
qcdua:CfgRpn(48, '1 (>L:INI_MCDU1_J)', '')
qcdua:CfgRpn(49, '1 (>L:INI_MCDU1_K)', '')
qcdua:CfgRpn(50, '1 (>L:INI_MCDU1_L)', '')
qcdua:CfgRpn(51, '1 (>L:INI_MCDU1_M)', '')
qcdua:CfgRpn(52, '1 (>L:INI_MCDU1_N)', '')
qcdua:CfgRpn(53, '1 (>L:INI_MCDU1_O)', '')
qcdua:CfgRpn(54, '1 (>L:INI_MCDU1_P)', '')
qcdua:CfgRpn(55, '1 (>L:INI_MCDU1_Q)', '')
qcdua:CfgRpn(56, '1 (>L:INI_MCDU1_R)', '')
qcdua:CfgRpn(57, '1 (>L:INI_MCDU1_S)', '')
qcdua:CfgRpn(58, '1 (>L:INI_MCDU1_T)', '')
qcdua:CfgRpn(59, '1 (>L:INI_MCDU1_U)', '')
qcdua:CfgRpn(60, '1 (>L:INI_MCDU1_V)', '')
qcdua:CfgRpn(61, '1 (>L:INI_MCDU1_W)', '')
qcdua:CfgRpn(62, '1 (>L:INI_MCDU1_X)', '')
qcdua:CfgRpn(63, '1 (>L:INI_MCDU1_Y)', '')
qcdua:CfgRpn(64, '1 (>L:INI_MCDU1_Z)', '')
qcdua:CfgRpn(65, '1 (>L:INI_MCDU1_MINUS)', '')
qcdua:CfgRpn(66, '1 (>L:INI_MCDU1_PLUS)', '')
qcdua:CfgRpn(67, '1 (>L:INI_MCDU1_SLASH)', '')
qcdua:CfgRpn(68, '1 (>L:INI_MCDU1_CLR)', '')
qcdua:CfgRpn(69, '(L:INI_POTENTIOMETER_66) 10 - 0 max (>L:INI_POTENTIOMETER_66)', '')
qcdua:CfgRpn(70, '(L:INI_POTENTIOMETER_66) 10 + 100 min (>L:INI_POTENTIOMETER_66)', '')

-- ===========================================================
-- Read data

qcdua:GetFm1("(L:INI_FMS1_display_light)")
qcdua:GetInd("(L:INI_FMS1_display_light)")
qcdua:GetRdy("(L:INI_FMS1_display_light)")
qcdua:GetFm2("(L:INI_FMS1_display_light)")
qcdua:GetMenu("(L:INI_FMS1_message_light)")
qcdua:GetFail("(L:INI_FMS1_display_light)")
qcdua:GetFmgc("(L:INI_FMS1_display_light)")
qcdua:GetBkl("(A:LIGHT POTENTIOMETER:3, Percent)", 0.3)

function CDU_INIA300_LED_UPD()
    qcdua:SetBkl()
end

uluaAddDoLoop("CDU_INIA300_LED_UPD()")

