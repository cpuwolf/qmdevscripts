-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-11-30
-- *****************************************************************
if ilua_is_acfpath_excluded("a340") or ilua_is_acfpath_excluded("inibuild") then
    return
end

-- Do not remove below lines: hardware detection
local qcduaf = com.sim.qm.Qcduaf:new()
if not qcduaf:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 for Inibuild A340")

-- A330
local isINIA330 = false
if not ilua_is_acfpath_excluded("A330") then
    isINIA330 = true
    uluaLog("- QCDU Inibuild A330 FO")
end

-- ===========================================================
-- button binding

qcduaf:CfgRpn(0, '1 (>L:INI_MCDU2_LSK1L)')
qcduaf:CfgRpn(1, '1 (>L:INI_MCDU2_LSK2L)')
qcduaf:CfgRpn(2, '1 (>L:INI_MCDU2_LSK3L)')
qcduaf:CfgRpn(3, '1 (>L:INI_MCDU2_LSK4L)')
qcduaf:CfgRpn(4, '1 (>L:INI_MCDU2_LSK5L)')
qcduaf:CfgRpn(5, '1 (>L:INI_MCDU2_LSK6L)')
qcduaf:CfgRpn(6, '1 (>L:INI_MCDU2_LSK1R)')
qcduaf:CfgRpn(7, '1 (>L:INI_MCDU2_LSK2R)')
qcduaf:CfgRpn(8, '1 (>L:INI_MCDU2_LSK3R)')
qcduaf:CfgRpn(9, '1 (>L:INI_MCDU2_LSK4R)')
qcduaf:CfgRpn(10, '1 (>L:INI_MCDU2_LSK5R)')
qcduaf:CfgRpn(11, '1 (>L:INI_MCDU2_LSK6R)')
qcduaf:CfgRpn(12, '1 (>L:INI_MCDU2_DIR)')
qcduaf:CfgRpn(13, '1 (>L:INI_MCDU2_PROG)')
qcduaf:CfgRpn(14, '1 (>L:INI_MCDU2_PERF)')
qcduaf:CfgRpn(15, '1 (>L:INI_MCDU2_INIT)')
qcduaf:CfgRpn(16, '1 (>L:INI_MCDU2_DATA)')
qcduaf:CfgRpn(17, '1 (>L:INI_MCDU2_FPLAN)')
qcduaf:CfgRpn(18, '1 (>L:INI_MCDU2_RADNAV)')
qcduaf:CfgRpn(19, '1 (>L:INI_MCDU2_FUEL)')
qcduaf:CfgRpn(20, '1 (>L:INI_MCDU2_SEC)')
qcduaf:CfgRpn(21, '1 (>L:INI_MCDU2_ATC)')
qcduaf:CfgRpn(22, '1 (>L:INI_MCDU2_MENU)')
qcduaf:CfgRpn(23, '1 (>L:INI_MCDU2_AIRPORT)')
qcduaf:CfgRpn(24, '1 (>L:INI_MCDU2_UARROW)')
qcduaf:CfgRpn(25, '1 (>L:INI_MCDU2_PREV)')
qcduaf:CfgRpn(26, '1 (>L:INI_MCDU2_NEXT)')
qcduaf:CfgRpn(71, '1 (>L:INI_MCDU2_DOWN)')
qcduaf:CfgRpn(27, '1 (>L:INI_MCDU2_1)')
qcduaf:CfgRpn(28, '1 (>L:INI_MCDU2_2)')
qcduaf:CfgRpn(29, '1 (>L:INI_MCDU2_3)')
qcduaf:CfgRpn(30, '1 (>L:INI_MCDU2_4)')
qcduaf:CfgRpn(31, '1 (>L:INI_MCDU2_5)')
qcduaf:CfgRpn(32, '1 (>L:INI_MCDU2_6)')
qcduaf:CfgRpn(33, '1 (>L:INI_MCDU2_7)')
qcduaf:CfgRpn(34, '1 (>L:INI_MCDU2_8)')
qcduaf:CfgRpn(35, '1 (>L:INI_MCDU2_9)')
qcduaf:CfgRpn(36, '1 (>L:INI_MCDU2_DECIMAL)')
qcduaf:CfgRpn(37, '1 (>L:INI_MCDU2_0)')
qcduaf:CfgRpn(38, '1 (>L:INI_MCDU2_PLUS)')
qcduaf:CfgRpn(39, '1 (>L:INI_MCDU2_A)')
qcduaf:CfgRpn(40, '1 (>L:INI_MCDU2_B)')
qcduaf:CfgRpn(41, '1 (>L:INI_MCDU2_C)')
qcduaf:CfgRpn(42, '1 (>L:INI_MCDU2_D)')
qcduaf:CfgRpn(43, '1 (>L:INI_MCDU2_E)')
qcduaf:CfgRpn(44, '1 (>L:INI_MCDU2_F)')
qcduaf:CfgRpn(45, '1 (>L:INI_MCDU2_G)')
qcduaf:CfgRpn(46, '1 (>L:INI_MCDU2_H)')
qcduaf:CfgRpn(47, '1 (>L:INI_MCDU2_I)')
qcduaf:CfgRpn(48, '1 (>L:INI_MCDU2_J)')
qcduaf:CfgRpn(49, '1 (>L:INI_MCDU2_K)')
qcduaf:CfgRpn(50, '1 (>L:INI_MCDU2_L)')
qcduaf:CfgRpn(51, '1 (>L:INI_MCDU2_M)')
qcduaf:CfgRpn(52, '1 (>L:INI_MCDU2_N)')
qcduaf:CfgRpn(53, '1 (>L:INI_MCDU2_O)')
qcduaf:CfgRpn(54, '1 (>L:INI_MCDU2_P)')
qcduaf:CfgRpn(55, '1 (>L:INI_MCDU2_Q)')
qcduaf:CfgRpn(56, '1 (>L:INI_MCDU2_R)')
qcduaf:CfgRpn(57, '1 (>L:INI_MCDU2_S)')
qcduaf:CfgRpn(58, '1 (>L:INI_MCDU2_T)')
qcduaf:CfgRpn(59, '1 (>L:INI_MCDU2_U)')
qcduaf:CfgRpn(60, '1 (>L:INI_MCDU2_V)')
qcduaf:CfgRpn(61, '1 (>L:INI_MCDU2_W)')
qcduaf:CfgRpn(62, '1 (>L:INI_MCDU2_X)')
qcduaf:CfgRpn(63, '1 (>L:INI_MCDU2_Y)')
qcduaf:CfgRpn(64, '1 (>L:INI_MCDU2_Z)')
qcduaf:CfgRpn(65, '1 (>L:INI_MCDU2_SPACE)')
qcduaf:CfgRpn(66, '1 (>L:INI_MCDU2_OVERFLY)')
qcduaf:CfgRpn(67, '1 (>L:INI_MCDU2_SLASH)')
qcduaf:CfgRpn(68, '1 (>L:INI_MCDU2_CLR)')

qcduaf:CfgRpn(69, '2 (>L:INI_MCDU2_BRT_SWITCH)', '1 (>L:INI_MCDU2_BRT_SWITCH)')
qcduaf:CfgRpn(70, '0 (>L:INI_MCDU2_BRT_SWITCH)', '1 (>L:INI_MCDU2_BRT_SWITCH)')

-- ===========================================================
-- Read data

qcduaf:GetFm1("(L:INI_FMC2_FM1)")
qcduaf:GetInd("(L:INI_FMC2_IND)")
qcduaf:GetRdy("(L:INI_FMC2_RDY)")
qcduaf:GetFm2("(L:INI_FMC2_FM2)")
qcduaf:GetMenu("(L:INI_FMC2_MCDU)")
qcduaf:GetFail("(L:INI_FMC2_FAIL)")
qcduaf:GetFmgc("(L:INI_FMC2_FM)")
qcduaf:GetBkl("(L:INI_POTENTIOMETER_14)", 0.3)                                -- 0~100

local dr_test = iDataRef:New("(L:INI_ANNLT_SWITCH, number)")                 -- 0: TEST 1:BRT: 2: DIM
local dr_power = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)") -- 0: OFF 1: ON

function CDU_INIA320_FO_LED_UPD()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    if b_power == 0 then
        qcduaf:Off()
        return
    else
        if dr_test:Get() == 0 then
            qcduaf:SetMenu(0, 1)
            qcduaf:SetFail(0, 1)
            qcduaf:SetFmgc(0, 1)
            qcduaf:SetFm1(0, 1)
            qcduaf:SetInd(0, 1)
            qcduaf:SetRdy(0, 1)
            qcduaf:SetFm2(0, 1)
            return
        end
        qcduaf:FreshBkl()
    end

    qcduaf:SetMenu()
    qcduaf:SetFail()
    qcduaf:SetFmgc()
    qcduaf:SetFm1()
    qcduaf:SetInd()
    qcduaf:SetRdy(0.5)
    qcduaf:SetFm2()

    qcduaf:SetBkl()
end

uluaAddDoLoop("CDU_INIA320_FO_LED_UPD()")
