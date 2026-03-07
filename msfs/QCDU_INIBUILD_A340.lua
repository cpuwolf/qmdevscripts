-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-10-17
-- *****************************************************************
if ilua_is_acfpath_excluded("a340") or ilua_is_acfpath_excluded("inibuild") then
    return
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 for Inibuild A340")

-- A330
local isINIA330 = false
if not ilua_is_acfpath_excluded("A330") then
    isINIA330 = true
    uluaLog("- QCDU Inibuild A330")
end

-- ===========================================================
-- button binding

qcdua:CfgRpn(0, '1 (>L:INI_MCDU1_LSK1L)')
qcdua:CfgRpn(1, '1 (>L:INI_MCDU1_LSK2L)')
qcdua:CfgRpn(2, '1 (>L:INI_MCDU1_LSK3L)')
qcdua:CfgRpn(3, '1 (>L:INI_MCDU1_LSK4L)')
qcdua:CfgRpn(4, '1 (>L:INI_MCDU1_LSK5L)')
qcdua:CfgRpn(5, '1 (>L:INI_MCDU1_LSK6L)')
qcdua:CfgRpn(6, '1 (>L:INI_MCDU1_LSK1R)')
qcdua:CfgRpn(7, '1 (>L:INI_MCDU1_LSK2R)')
qcdua:CfgRpn(8, '1 (>L:INI_MCDU1_LSK3R)')
qcdua:CfgRpn(9, '1 (>L:INI_MCDU1_LSK4R)')
qcdua:CfgRpn(10, '1 (>L:INI_MCDU1_LSK5R)')
qcdua:CfgRpn(11, '1 (>L:INI_MCDU1_LSK6R)')
qcdua:CfgRpn(12, '1 (>L:INI_MCDU1_DIR)')
qcdua:CfgRpn(13, '1 (>L:INI_MCDU1_PROG)')
qcdua:CfgRpn(14, '1 (>L:INI_MCDU1_PERF)')
qcdua:CfgRpn(15, '1 (>L:INI_MCDU1_INIT)')
qcdua:CfgRpn(16, '1 (>L:INI_MCDU1_DATA)')
qcdua:CfgRpn(17, '1 (>L:INI_MCDU1_FPLAN)')
qcdua:CfgRpn(18, '1 (>L:INI_MCDU1_RADNAV)')
qcdua:CfgRpn(19, '1 (>L:INI_MCDU1_FUEL)')
qcdua:CfgRpn(20, '1 (>L:INI_MCDU1_SEC)')
qcdua:CfgRpn(21, '1 (>L:INI_MCDU1_ATC)')
qcdua:CfgRpn(22, '1 (>L:INI_MCDU1_MENU)')
qcdua:CfgRpn(23, '1 (>L:INI_MCDU1_AIRPORT)')
qcdua:CfgRpn(24, '1 (>L:INI_MCDU1_UARROW)')
qcdua:CfgRpn(25, '1 (>L:INI_MCDU1_PREV)')
qcdua:CfgRpn(26, '1 (>L:INI_MCDU1_NEXT)')
qcdua:CfgRpn(71, '1 (>L:INI_MCDU1_DOWN)')
qcdua:CfgRpn(27, '1 (>L:INI_MCDU1_1)')
qcdua:CfgRpn(28, '1 (>L:INI_MCDU1_2)')
qcdua:CfgRpn(29, '1 (>L:INI_MCDU1_3)')
qcdua:CfgRpn(30, '1 (>L:INI_MCDU1_4)')
qcdua:CfgRpn(31, '1 (>L:INI_MCDU1_5)')
qcdua:CfgRpn(32, '1 (>L:INI_MCDU1_6)')
qcdua:CfgRpn(33, '1 (>L:INI_MCDU1_7)')
qcdua:CfgRpn(34, '1 (>L:INI_MCDU1_8)')
qcdua:CfgRpn(35, '1 (>L:INI_MCDU1_9)')
qcdua:CfgRpn(36, '1 (>L:INI_MCDU1_DECIMAL)')
qcdua:CfgRpn(37, '1 (>L:INI_MCDU1_0)')
qcdua:CfgRpn(38, '1 (>L:INI_MCDU1_PLUS)')
qcdua:CfgRpn(39, '1 (>L:INI_MCDU1_A)')
qcdua:CfgRpn(40, '1 (>L:INI_MCDU1_B)')
qcdua:CfgRpn(41, '1 (>L:INI_MCDU1_C)')
qcdua:CfgRpn(42, '1 (>L:INI_MCDU1_D)')
qcdua:CfgRpn(43, '1 (>L:INI_MCDU1_E)')
qcdua:CfgRpn(44, '1 (>L:INI_MCDU1_F)')
qcdua:CfgRpn(45, '1 (>L:INI_MCDU1_G)')
qcdua:CfgRpn(46, '1 (>L:INI_MCDU1_H)')
qcdua:CfgRpn(47, '1 (>L:INI_MCDU1_I)')
qcdua:CfgRpn(48, '1 (>L:INI_MCDU1_J)')
qcdua:CfgRpn(49, '1 (>L:INI_MCDU1_K)')
qcdua:CfgRpn(50, '1 (>L:INI_MCDU1_L)')
qcdua:CfgRpn(51, '1 (>L:INI_MCDU1_M)')
qcdua:CfgRpn(52, '1 (>L:INI_MCDU1_N)')
qcdua:CfgRpn(53, '1 (>L:INI_MCDU1_O)')
qcdua:CfgRpn(54, '1 (>L:INI_MCDU1_P)')
qcdua:CfgRpn(55, '1 (>L:INI_MCDU1_Q)')
qcdua:CfgRpn(56, '1 (>L:INI_MCDU1_R)')
qcdua:CfgRpn(57, '1 (>L:INI_MCDU1_S)')
qcdua:CfgRpn(58, '1 (>L:INI_MCDU1_T)')
qcdua:CfgRpn(59, '1 (>L:INI_MCDU1_U)')
qcdua:CfgRpn(60, '1 (>L:INI_MCDU1_V)')
qcdua:CfgRpn(61, '1 (>L:INI_MCDU1_W)')
qcdua:CfgRpn(62, '1 (>L:INI_MCDU1_X)')
qcdua:CfgRpn(63, '1 (>L:INI_MCDU1_Y)')
qcdua:CfgRpn(64, '1 (>L:INI_MCDU1_Z)')
qcdua:CfgRpn(65, '1 (>L:INI_MCDU1_SPACE)')
qcdua:CfgRpn(66, '1 (>L:INI_MCDU1_OVERFLY)')
qcdua:CfgRpn(67, '1 (>L:INI_MCDU1_SLASH)')
qcdua:CfgRpn(68, '1 (>L:INI_MCDU1_CLR)')

qcdua:CfgRpn(69, '2 (>L:INI_MCDU1_BRT_SWITCH)', '1 (>L:INI_MCDU1_BRT_SWITCH)')
qcdua:CfgRpn(70, '0 (>L:INI_MCDU1_BRT_SWITCH)', '1 (>L:INI_MCDU1_BRT_SWITCH)')

-- ===========================================================
-- Read data

qcdua:GetFm1("(L:INI_FMC1_FM1)")
qcdua:GetInd("(L:INI_FMC1_IND)")
qcdua:GetRdy("(L:INI_FMC1_RDY)")
qcdua:GetFm2("(L:INI_FMC1_FM2)")
qcdua:GetMenu("(L:INI_FMC1_MCDU)")
qcdua:GetFail("(L:INI_FMC1_FAIL)")
qcdua:GetFmgc("(L:INI_FMC1_FM)")
qcdua:GetBkl("(L:INI_POTENTIOMETER_14)", 0.3)                                -- 0~100

local dr_test = iDataRef:New("(L:INI_ANNLT_SWITCH, number)")                 -- 0: TEST 1:BRT: 2: DIM
local dr_power = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)") -- 0: OFF 1: ON

function CDU_INIA320_LED_UPD()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    if b_power == 0 then
        qcdua:Off()
        return
    else
        if dr_test:Get() == 0 then
            qcdua:SetMenu(0, 1)
            qcdua:SetFail(0, 1)
            qcdua:SetFmgc(0, 1)
            qcdua:SetFm1(0, 1)
            qcdua:SetInd(0, 1)
            qcdua:SetRdy(0, 1)
            qcdua:SetFm2(0, 1)
            return
        end
        qcdua:FreshBkl()
    end

    qcdua:SetMenu()
    qcdua:SetFail()
    qcdua:SetFmgc()
    qcdua:SetFm1()
    qcdua:SetInd()
    qcdua:SetRdy(0.5)
    qcdua:SetFm2()

    qcdua:SetBkl()
end

uluaAddDoLoop("CDU_INIA320_LED_UPD()")
