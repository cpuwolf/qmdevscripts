-- ********************  Copyright   ***********************
-- modified by Wei Shuai <cpuwolf@gmail.com> 2020-11-19
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-02-06 asobo 747-8 1.36.2.0
-- https://sourceforge.net/projects/qmdevsimconnect/
-- ########################################################
if ilua_is_acftitle_excluded("Salty") and ilua_is_acftitle_excluded("747") then
    return
end

-- Do not remove below lines: hardware detection
local qcdub = com.sim.qm.Qcdub:new()
if not qcdub:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-B737 for 747")

function CDU_asobo747_LED_dataref_exists()

    dr_CDU_asobo747_exec = uluaFind("(L:FMC_EXEC_ACTIVE)")
    dr_CDU_asobo747_msg = uluaFind("(L:switch_6040_73X, number)")
    dr_CDU_asobo747_fail = uluaFind("(L:switch_6031_73X, number)")
    dr_CDU_asobo747_warn = uluaFind("(L:switch_6030_73X, number)")
    dr_CDU_asobo747_offset = uluaFind("(L:switch_6041_73X, number)")

    dr_CDU_asobo747_brightness = uluaFind("(A:LIGHT POTENTIOMETER:3, Percent)")

    qcdub:CfgRpn(0, '(>H:B747_8_FMC_1_BTN_L1)', '') -- FMS left LS1 key 
    qcdub:CfgRpn(1, '(>H:B747_8_FMC_1_BTN_L2)', '') -- FMS left LS2 key 
    qcdub:CfgRpn(2, '(>H:B747_8_FMC_1_BTN_L3)', '') -- FMS left LS3 key 
    qcdub:CfgRpn(3, '(>H:B747_8_FMC_1_BTN_L4)', '') -- FMS left LS4 key 
    qcdub:CfgRpn(4, '(>H:B747_8_FMC_1_BTN_L5)', '') -- FMS left LS5 key 
    qcdub:CfgRpn(5, '(>H:B747_8_FMC_1_BTN_L6)', '') -- FMS left LS6 key 
    qcdub:CfgRpn(6, '(>H:B747_8_FMC_1_BTN_R1)', '') -- FMS left LS7 key 
    qcdub:CfgRpn(7, '(>H:B747_8_FMC_1_BTN_R2)', '') -- FMS left LS8 key 
    qcdub:CfgRpn(8, '(>H:B747_8_FMC_1_BTN_R3)', '') -- FMS left LS9 key 
    qcdub:CfgRpn(9, '(>H:B747_8_FMC_1_BTN_R4)', '') -- FMS left LS10 key 
    qcdub:CfgRpn(10, '(>H:B747_8_FMC_1_BTN_R5)', '') -- FMS left LS11 key 
    qcdub:CfgRpn(11, '(>H:B747_8_FMC_1_BTN_R6)', '') -- FMS left LS12 key 
    qcdub:CfgRpn(12, '(>H:B747_8_FMC_1_BTN_INIT)', '') -- FMS left INIT REF key 
    qcdub:CfgRpn(13, '(>H:B747_8_FMC_1_BTN_RTE)', '') -- FMS left RTE key 
    qcdub:CfgRpn(14, '(>H:B747_8_FMC_1_BTN_)', '') -- FMS left CLB key 
    qcdub:CfgRpn(15, '(>H:B747_8_FMC_1_BTN_ATC)', '') -- FMS left CRZ key 
    qcdub:CfgRpn(16, '(>H:B747_8_FMC_1_BTN_VNAV)', '') -- FMS left DES key 
    qcdub:CfgRpn(17, '(>H:B747_8_FMC_1_BTN_MENU)', '') -- FMS left MENU key 
    qcdub:CfgRpn(18, '(>H:B747_8_FMC_1_BTN_LEGS)', '') -- FMS left LEGS key 
    qcdub:CfgRpn(19, '(>H:B747_8_FMC_1_BTN_DEPARR)', '') -- FMS left DEP ARR key 
    qcdub:CfgRpn(20, '(>H:B747_8_FMC_1_BTN_HOLD)', '') -- FMS left HOLD key 
    qcdub:CfgRpn(21, '(>H:B747_8_FMC_1_BTN_PROG)', '') -- FMS left PROG key 
    qcdub:CfgRpn(22, '(>H:B747_8_FMC_1_BTN_EXEC)', '') -- FMS left EXEC key 
    qcdub:CfgRpn(23, '(>H:B747_8_FMC_1_BTN_1)', '') -- FMS left N1 LIMIT key 
    qcdub:CfgRpn(24, '(>H:B747_8_FMC_1_BTN_FIX)', '') -- FMS left FIX key 
    qcdub:CfgRpn(25, '(>H:B747_8_FMC_1_BTN_PREVPAGE)', '') -- FMS left PREV PAGE key 
    qcdub:CfgRpn(26, '(>H:B747_8_FMC_1_BTN_NEXTPAGE)', '') -- FMS left NEXT PAGE key 
    qcdub:CfgRpn(27, '(>H:B747_8_FMC_1_BTN_1)', '') -- FMS left NUM1 key 
    qcdub:CfgRpn(28, '(>H:B747_8_FMC_1_BTN_2)', '') -- FMS left NUM2 key 
    qcdub:CfgRpn(29, '(>H:B747_8_FMC_1_BTN_3)', '') -- FMS left NUM3 key 
    qcdub:CfgRpn(30, '(>H:B747_8_FMC_1_BTN_4)', '') -- FMS left NUM4 key 
    qcdub:CfgRpn(31, '(>H:B747_8_FMC_1_BTN_5)', '') -- FMS left NUM5 key 
    qcdub:CfgRpn(32, '(>H:B747_8_FMC_1_BTN_6)', '') -- FMS left NUM6 key 
    qcdub:CfgRpn(33, '(>H:B747_8_FMC_1_BTN_7)', '') -- FMS left NUM7 key 
    qcdub:CfgRpn(34, '(>H:B747_8_FMC_1_BTN_8)', '') -- FMS left NUM8 key 
    qcdub:CfgRpn(35, '(>H:B747_8_FMC_1_BTN_9)', '') -- FMS left NUM9 key 
    qcdub:CfgRpn(36, '(>H:B747_8_FMC_1_BTN_DOT)', '') -- FMS left NUMDECIMAL key 
    qcdub:CfgRpn(37, '(>H:B747_8_FMC_1_BTN_0)', '') -- FMS left NUM0 key 
    qcdub:CfgRpn(38, '(>H:B747_8_FMC_1_BTN_PLUSMINUS)', '') -- FMS left NUM+- key 
    qcdub:CfgRpn(39, '(>H:B747_8_FMC_1_BTN_A)', '') -- FMS left A key 
    qcdub:CfgRpn(40, '(>H:B747_8_FMC_1_BTN_B)', '') -- FMS left B key 
    qcdub:CfgRpn(41, '(>H:B747_8_FMC_1_BTN_C)', '') -- FMS left C key 
    qcdub:CfgRpn(42, '(>H:B747_8_FMC_1_BTN_D)', '') -- FMS left D key 
    qcdub:CfgRpn(43, '(>H:B747_8_FMC_1_BTN_E)', '') -- FMS left E key 
    qcdub:CfgRpn(44, '(>H:B747_8_FMC_1_BTN_F)', '') -- FMS left F key 
    qcdub:CfgRpn(45, '(>H:B747_8_FMC_1_BTN_G)', '') -- FMS left G key 
    qcdub:CfgRpn(46, '(>H:B747_8_FMC_1_BTN_H)', '') -- FMS left H key 
    qcdub:CfgRpn(47, '(>H:B747_8_FMC_1_BTN_I)', '') -- FMS left I key 
    qcdub:CfgRpn(48, '(>H:B747_8_FMC_1_BTN_J)', '') -- FMS left J key 
    qcdub:CfgRpn(49, '(>H:B747_8_FMC_1_BTN_K)', '') -- FMS left K key 
    qcdub:CfgRpn(50, '(>H:B747_8_FMC_1_BTN_L)', '') -- FMS left L key 
    qcdub:CfgRpn(51, '(>H:B747_8_FMC_1_BTN_M)', '') -- FMS left M key 
    qcdub:CfgRpn(52, '(>H:B747_8_FMC_1_BTN_N)', '') -- FMS left N key 
    qcdub:CfgRpn(53, '(>H:B747_8_FMC_1_BTN_O)', '') -- FMS left O key 
    qcdub:CfgRpn(54, '(>H:B747_8_FMC_1_BTN_P)', '') -- FMS left P key 
    qcdub:CfgRpn(55, '(>H:B747_8_FMC_1_BTN_Q)', '') -- FMS left Q key 
    qcdub:CfgRpn(56, '(>H:B747_8_FMC_1_BTN_R)', '') -- FMS left R key 
    qcdub:CfgRpn(57, '(>H:B747_8_FMC_1_BTN_S)', '') -- FMS left S key 
    qcdub:CfgRpn(58, '(>H:B747_8_FMC_1_BTN_T)', '') -- FMS left T key 
    qcdub:CfgRpn(59, '(>H:B747_8_FMC_1_BTN_U)', '') -- FMS left U key 
    qcdub:CfgRpn(60, '(>H:B747_8_FMC_1_BTN_V)', '') -- FMS left V key 
    qcdub:CfgRpn(61, '(>H:B747_8_FMC_1_BTN_W)', '') -- FMS left W key 
    qcdub:CfgRpn(62, '(>H:B747_8_FMC_1_BTN_X)', '') -- FMS left X key 
    qcdub:CfgRpn(63, '(>H:B747_8_FMC_1_BTN_Y)', '') -- FMS left Y key 
    qcdub:CfgRpn(64, '(>H:B747_8_FMC_1_BTN_Z)', '') -- FMS left Z key 
    qcdub:CfgRpn(65, '(>H:B747_8_FMC_1_BTN_SP)', '') -- FMS left SP key 
    qcdub:CfgRpn(66, '(>H:B747_8_FMC_1_BTN_DEL)', '') -- FMS left DEL key 
    qcdub:CfgRpn(67, '(>H:B747_8_FMC_1_BTN_DIV)', '') -- FMS left SLASH key 
    qcdub:CfgRpn(68, '(>H:B747_8_FMC_1_BTN_CLR)', '') -- FMS left CLR key 
    qcdub:CfgRpn(69, '(>H:B747_8_FMC_1_BTN_BRT_DIM)', '') -- FMS LEFT BRIGHTNESS CONTROL selector 
    qcdub:CfgRpn(70, '(>H:B747_8_FMC_1_BTN_1)', '(>H:B747_8_FMC_1_BTN_1)') -- FMS LEFT BRIGHTNESS CONTROL selector 

    uluaAddDoLoop("CDU_asobo747_LED_UPD()")
end

---------------------------------------------------------------------------------------------------

function CDU_asobo747_LED_UPD()
    local CDU_asobo747_msg = uluaGet(dr_CDU_asobo747_msg)
    local CDU_asobo747_exec = uluaGet(dr_CDU_asobo747_exec)
    local CDU_asobo747_fail = uluaGet(dr_CDU_asobo747_fail)
    local CDU_asobo747_warn = uluaGet(dr_CDU_asobo747_warn)
    local CDU_asobo747_offset = uluaGet(dr_CDU_asobo747_offset)
    local CDU_asobo747_brightness = uluaGet(dr_CDU_asobo747_brightness)

    uluaSet(idr_qcdu_b737_hid_ledfail, math.floor(CDU_asobo747_fail + 0.5))
    uluaSet(idr_qcdu_b737_hid_ledcall, math.floor(CDU_asobo747_warn + 0.5))

    uluaSet(idr_qcdu_b737_hid_ledmsg, math.floor(CDU_asobo747_msg + 0.5))

    uluaSet(idr_qcdu_b737_hid_ledexec, math.floor(CDU_asobo747_exec + 0.5))

    uluaSet(idr_qcdu_b737_hid_ledofst, ilua_01_ternary(dr_CDU_asobo747_offset, 0.4))

    uluaSet(idr_qcdu_b737_hid_bright, math.floor(CDU_asobo747_brightness * 0.15)) -- max 300
end
-- polling function for LEDS
uluasetTimeout("CDU_asobo747_LED_dataref_exists()", 100)
