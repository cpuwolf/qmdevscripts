-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-09-10
-- *****************************************************************
if ilua_is_acfpath_excluded("PMDG") or ilua_is_acfpath_excluded("737") then
    return
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A of PMDG B737")

uluaAddToggleMenu("need QMOVH GPWS", "需要QMOVH的GPWS功能", "g_need_qmovha_pmdg737_gpws")

-- A330
local isPMDG800 = false
if not ilua_is_acfpath_excluded("738") then
    isPMDG800 = true
    uluaLog("- QMOVH_A PMDG 737-800")
end

-- ===========================================================
-- buttons binding
-- POS/Strobe
qmovha:CfgRpn(0, "0 (>L:INI_LIGHTS_STROBE)")
qmovha:CfgRpn(41, "1 (>L:INI_LIGHTS_STROBE)")
qmovha:CfgRpn(1, "2 (>L:INI_LIGHTS_STROBE)")

-- BEACON lights
qmovha:CfgRpn(2, "(L:switch_124_73X, number) 0 == if{ 12401 (>K:ROTOR_BRAKE) }",
    "(L:switch_124_73X, number) 0 != if{ 12401 (>K:ROTOR_BRAKE) }")

-- Wing lights
qmovha:CfgRpn(3, "(L:switch_125_73X, number) 0 == if{ 12501 (>K:ROTOR_BRAKE) }",
    "(L:switch_125_73X, number) 0 != if{ 12501 (>K:ROTOR_BRAKE) }")

-- NAV&Logo lights
local pswh4 = QmdevPosSwitchInit("(L:switch_123_73X, number)", 50, "12308 (>K:ROTOR_BRAKE)", "12307 (>K:ROTOR_BRAKE)", 500)
local pswh5 = QmdevPosSwitchInit("(L:switch_122_73X, number)", 100, "12202 (>K:ROTOR_BRAKE)", "12201 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgFc(4, qmovha:GenPSwStr(pswh4, 0) .. ";" .. qmovha:GenPSwStr(pswh5, 100) )
qmovha:CfgFc(42, qmovha:GenPSwStr(pswh4, 100) .. ";" .. qmovha:GenPSwStr(pswh5, 100) )
qmovha:CfgFc(5, qmovha:GenPSwStr(pswh4, 50) .. ";" .. qmovha:GenPSwStr(pswh5, 0) )

-- Nose lights
qmovha:CfgRpn(6, "(L:switch_117_73X, number) 0 == if{ 11701 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(45, "(L:switch_117_73X, number) 0 == if{ 11701 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(7, "(L:switch_117_73X, number) 0 != if{ 11701 (>K:ROTOR_BRAKE) }")

-- R Landing lights
local pswh8 = QmdevPosSwitchInit("(L:switch_112_73X, number)", 50, "11208 (>K:ROTOR_BRAKE)", "11207 (>K:ROTOR_BRAKE)", 500)
local pswh9 = QmdevPosSwitchInit("(L:switch_114_73X, number)", 100, "11402 (>K:ROTOR_BRAKE)", "11401 (>K:ROTOR_BRAKE)", 500)

qmovha:CfgFc(8, qmovha:GenPSwStr(pswh8, 100) .. ";" .. qmovha:GenPSwStr(pswh9, 100) )
qmovha:CfgPSw(44, pswh8, 50)
qmovha:CfgFc(9, qmovha:GenPSwStr(pswh8, 0) .. ";" .. qmovha:GenPSwStr(pswh9, 0) )

-- L Landing lights
local pswh10 = QmdevPosSwitchInit("(L:switch_111_73X, number)", 50, "11108 (>K:ROTOR_BRAKE)", "11107 (>K:ROTOR_BRAKE)", 500)
local pswh11 = QmdevPosSwitchInit("(L:switch_113_73X, number)", 100, "11302 (>K:ROTOR_BRAKE)", "11301 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgFc(10, qmovha:GenPSwStr(pswh10, 100) .. ";" .. qmovha:GenPSwStr(pswh11, 100) )
qmovha:CfgPSw(43, pswh10, 50)
qmovha:CfgFc(11, qmovha:GenPSwStr(pswh10, 0) .. ";" .. qmovha:GenPSwStr(pswh11, 0) )

-- Runway Turn Off lights
qmovha:CfgRpn(12,
    "(L:switch_115_73X, number) 0 == if{ 11501 (>K:ROTOR_BRAKE) } (L:switch_116_73X, number) 0 == if{ 11601 (>K:ROTOR_BRAKE) }",
    "(L:switch_115_73X, number) 0 != if{ 11501 (>K:ROTOR_BRAKE) } (L:switch_116_73X, number) 0 != if{ 11601 (>K:ROTOR_BRAKE) }")

-- OVHD INTEG LT KNOBS  BRT <-> OFF
if MSFS_VERSION == 0 then
    qmovha:CfgRpn(16, "9507 (>K:ROTOR_BRAKE)")
    qmovha:CfgRpn(17, "9508 (>K:ROTOR_BRAKE)")
else
    qmovha:CfgRpn(17, "(L:OH_PANEL_LIGHT_CONTROL, number) 6 - 0 max (>L:OH_PANEL_LIGHT_CONTROL, number)")
    qmovha:CfgRpn(16, "(L:OH_PANEL_LIGHT_CONTROL, number) 6 + 300 min (>L:OH_PANEL_LIGHT_CONTROL, number)")
end

-- SEAT BELTS
local pswh13 = QmdevPosSwitchInit("(L:switch_103_73X, number)", 100, "10301 (>K:ROTOR_BRAKE)", "10302 (>K:ROTOR_BRAKE)")
qmovha:CfgFc(13, qmovha:GenPSwStr(pswh13, 100), qmovha:GenPSwStr(pswh13, 0))

-- NO SMOKING
local pswh14 = QmdevPosSwitchInit("(L:switch_104_73X, number)", 50, "10401 (>K:ROTOR_BRAKE)", "10402 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(14, pswh14, 100)
qmovha:CfgPSw(48, pswh14, 50)
qmovha:CfgPSw(15, pswh14, 0)

-- DOME
local pswh18 = QmdevPosSwitchInit("(L:switch_258_73X, number)", 50, "25801 (>K:ROTOR_BRAKE)", "25802 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(18, pswh18, 100)
qmovha:CfgPSw(46, pswh18, 0)
qmovha:CfgPSw(19, pswh18, 50)

-- ANN LT
local pswh20 = QmdevPosSwitchInit("(L:switch_346_73X, number)", 50, "34608 (>K:ROTOR_BRAKE)", "34607 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(20, pswh20, 0)
qmovha:CfgPSw(47, pswh20, 50)
qmovha:CfgPSw(21, pswh20, 100)

-- EMER EXIT LT
local pswh22 = QmdevPosSwitchInit("(L:switch_100_73X, number)", 50, "10001 (>K:ROTOR_BRAKE)", "10002 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(22, pswh22, 100)
qmovha:CfgPSw(49, pswh22, 50)
qmovha:CfgPSw(23, pswh22, 0)

-- APU
---- start
qmovha:CfgRpn(30, "11801 (>K:ROTOR_BRAKE)")
---- master: 0: OFF 50: ON
qmovha:CfgRpn(31, "(L:switch_118_73X) 0 ==  if{ 11801 (>K:ROTOR_BRAKE) } els{ 11802 (>K:ROTOR_BRAKE) }")

-- ANTI ICE
---- ENG2
qmovha:CfgRpn(32, "15801 (>K:ROTOR_BRAKE)")
---- ENG1
qmovha:CfgRpn(33, "15701 (>K:ROTOR_BRAKE)")
---- WING
qmovha:CfgRpn(37, "15601 (>K:ROTOR_BRAKE)")

-- AIR COND
---- PACK1
qmovha:CfgRpn(34, "(L:switch_200_73X) 50 ==  if{ 20002 (>K:ROTOR_BRAKE) } els{ 20001 (>K:ROTOR_BRAKE) }")
---- APU BLEED
qmovha:CfgRpn(35, "21102 (>K:ROTOR_BRAKE)")
---- PACK2
qmovha:CfgRpn(36, "(L:switch_201_73X) 50 ==  if{ 20102 (>K:ROTOR_BRAKE) } els{ 20101 (>K:ROTOR_BRAKE) }")

---- XBLEED
local pswh27 = QmdevPosSwitchInit("(L:switch_202_73X, number)", 50, "20201 (>K:ROTOR_BRAKE)", "20202 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(27, pswh27, 0)
qmovha:CfgPSw(28, pswh27, 50)
qmovha:CfgPSw(29, pswh27, 100)

-- WIPER
local pswh24 = QmdevPosSwitchInit("(L:switch_36_73X, number)", 10, "3602 (>K:ROTOR_BRAKE)", "3601 (>K:ROTOR_BRAKE)")
local pswh25 = QmdevPosSwitchInit("(L:switch_109_73X, number)", 10, "10902 (>K:ROTOR_BRAKE)", "10901 (>K:ROTOR_BRAKE)")
qmovha:CfgFc(24, qmovha:GenPSwStr(pswh24, 0) .. ";" .. qmovha:GenPSwStr(pswh25, 0) )
qmovha:CfgFc(25, qmovha:GenPSwStr(pswh24, 10) .. ";" .. qmovha:GenPSwStr(pswh25, 10) )
qmovha:CfgFc(26, qmovha:GenPSwStr(pswh24, 30) .. ";" .. qmovha:GenPSwStr(pswh25, 30) )

-- OXYGEN CREW SUPPLY
qmovha:CfgRpn(38, "19601 (>K:ROTOR_BRAKE)")

-- CALLS ALL
qmovha:CfgRpn(40, "10501 (>K:ROTOR_BRAKE)", "10504 (>K:ROTOR_BRAKE)")

-- GPWS
if g_need_qmovha_pmdg737_gpws == 1 then
    ---- TERR
    qmovha:CfgRpn(50, "50501 (>K:ROTOR_BRAKE)")
    ---- SYS
    qmovha:CfgRpn(51, "50301 (>K:ROTOR_BRAKE)")
    ---- FLAPS3
    qmovha:CfgRpn(52, "50101 (>K:ROTOR_BRAKE)")
    -- GND CTL CVR
    qmovha:CfgRpn(53, "(L:INI_GND_CTL) ! (>L:INI_GND_CTL)")
else
    ---- TERR: HYD PMUP ENG1
    qmovha:CfgRpn(50, "16501 (>K:ROTOR_BRAKE)")
    ---- SYS: HYD PMUP ELEC2
    qmovha:CfgRpn(51, "16701 (>K:ROTOR_BRAKE)")
    ---- FLAPS3: : HYD PMUP ELEC1
    qmovha:CfgRpn(52, "16801 (>K:ROTOR_BRAKE)")
    -- GND CTL CVR: : HYD PMUP ENG2
    qmovha:CfgRpn(53, "16601 (>K:ROTOR_BRAKE)")
end

-- ADIRS 2,3,1
local pswh55 = QmdevPosSwitchInit("(L:switch_140_73X, number)", 100, "14001 (>K:ROTOR_BRAKE)", "14001 (>K:ROTOR_BRAKE)", 500)
local pswh51 = QmdevPosSwitchInit("(L:switch_141_73X, number)", 100, "14101 (>K:ROTOR_BRAKE)", "14101 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg737_prob_heat = iDataRef:New("(L:switch_140_73X, number)")
qmovha:CfgFc(55,
    "local pos = 100 - dr_qmovh_pmdg737_prob_heat:Get();QmdevPosSwitchSet(" .. tostring(pswh55) .. ",  pos);QmdevPosSwitchSet(" .. tostring(pswh51) .. ",  pos)")

local pswh56 = QmdevPosSwitchInit("(L:switch_135_73X, number)", 100, "13501 (>K:ROTOR_BRAKE)", "13501 (>K:ROTOR_BRAKE)", 500)
local pswh54 = QmdevPosSwitchInit("(L:switch_136_73X, number)", 100, "13601 (>K:ROTOR_BRAKE)", "13601 (>K:ROTOR_BRAKE)", 500)
local pswh53 = QmdevPosSwitchInit("(L:switch_138_73X, number)", 100, "13801 (>K:ROTOR_BRAKE)", "13801 (>K:ROTOR_BRAKE)", 500)
local pswh52 = QmdevPosSwitchInit("(L:switch_139_73X, number)", 100, "13901 (>K:ROTOR_BRAKE)", "13901 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg737_win_heat = iDataRef:New("(L:switch_135_73X, number)")
qmovha:CfgFc(56,
    "local pos = 100 - dr_qmovh_pmdg737_win_heat:Get();QmdevPosSwitchSet(" .. tostring(pswh56) .. ",  pos);QmdevPosSwitchSet(" .. tostring(pswh54) .. ",  pos);QmdevPosSwitchSet(" .. tostring(pswh53) .. ",  pos);QmdevPosSwitchSet(" .. tostring(pswh52) .. ",  pos)")

qmovha:CfgRpn(57, "6301 (>K:ROTOR_BRAKE)")

-- IR1
local pswh73 = QmdevPosSwitchInit("(L:switch_255_73X, number)", 10, "25502 (>K:ROTOR_BRAKE)", "25501 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgPSw(73, pswh73, 0)
qmovha:CfgPSw(74, pswh73, 20)
qmovha:CfgPSw(75, pswh73, 30)

-- IR3
local pswh81 = QmdevPosSwitchInit("(L:switch_58_73X, number)", 10, "5802 (>K:ROTOR_BRAKE)", "5801 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgPSw(79, pswh81, 0)
qmovha:CfgPSw(80, pswh81, 10)
qmovha:CfgPSw(81, pswh81, 20)

-- IR2
local pswh76 = QmdevPosSwitchInit("(L:switch_256_73X, number)", 10, "25602 (>K:ROTOR_BRAKE)", "25601 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgPSw(76, pswh76, 0)
qmovha:CfgPSw(77, pswh76, 20)
qmovha:CfgPSw(78, pswh76, 30)

-- BAT 1&2
---- GEN1
dr_qmovh_pmdg737_eng_gen1_off = iDataRef:New("pmdg/ng3/data/ELEC_annunGEN_BUS_OFF[0]")
qmovha:CfgFc(58,
    'if dr_qmovh_pmdg737_eng_gen1_off:Get() == 0 then uluaWriteCmd("2702 (>K:ROTOR_BRAKE)") else uluaWriteCmd("2701 (>K:ROTOR_BRAKE)") end')
---- BAT1
qmovha:CfgRpn(59, "101 (>K:ROTOR_BRAKE)")
---- BAT2
qmovha:CfgRpn(60, "97401 (>K:ROTOR_BRAKE) 501 (>K:ROTOR_BRAKE) 601 (>K:ROTOR_BRAKE)")
---- GEN2 x1 UP, x2 DOWN
dr_qmovh_pmdg737_eng_gen2_off = iDataRef:New("pmdg/ng3/data/ELEC_annunGEN_BUS_OFF[1]")
qmovha:CfgFc(62,
    'if dr_qmovh_pmdg737_eng_gen2_off:Get() == 0 then uluaWriteCmd("3002 (>K:ROTOR_BRAKE)") else uluaWriteCmd("3001 (>K:ROTOR_BRAKE)") end')

-- EXT PWR: 1702 UP, 1701 DOWN
qmovha:CfgRpn(61, "(L:7X7X_Ground_Power_Light_Connected, Bool) if{ 1702 (>K:ROTOR_BRAKE) } els{ 1701 (>K:ROTOR_BRAKE) }")

-- FUEL
---- L1
qmovha:CfgRpn(54, "3701 (>K:ROTOR_BRAKE)")
---- L2
qmovha:CfgRpn(68, "3801 (>K:ROTOR_BRAKE)")
---- C1
qmovha:CfgRpn(67, "4501 (>K:ROTOR_BRAKE)")
---- C2
qmovha:CfgRpn(65, "4601 (>K:ROTOR_BRAKE)")
---- R1
qmovha:CfgRpn(64, "3901 (>K:ROTOR_BRAKE)")
---- R2
qmovha:CfgRpn(63, "4001 (>K:ROTOR_BRAKE)")
---- XFEED
qmovha:CfgRpn(66, "4901 (>K:ROTOR_BRAKE)")

-- FIRE

---- eng2 agent2
qmovha:CfgRpn(69, "69902 (>K:ROTOR_BRAKE)")
---- eng2 agent1
qmovha:CfgRpn(70, "69901 (>K:ROTOR_BRAKE)")
---- eng1 agent2
qmovha:CfgRpn(71, "69702 (>K:ROTOR_BRAKE)")
---- eng1 agent1
qmovha:CfgRpn(72, "69701 (>K:ROTOR_BRAKE)")

---- ENG1
qmovha:CfgRpn(82, "97601 (>K:ROTOR_BRAKE) 69701 (>K:ROTOR_BRAKE)", "697101 (>K:ROTOR_BRAKE)")
---- APU
qmovha:CfgRpn(83, "97701 (>K:ROTOR_BRAKE) 698101 (>K:ROTOR_BRAKE)", "698101 (>K:ROTOR_BRAKE)")
---- ENG2
qmovha:CfgRpn(84, "97801 (>K:ROTOR_BRAKE) 69901 (>K:ROTOR_BRAKE)", "699101 (>K:ROTOR_BRAKE)")

---- ENG1 Test
qmovha:CfgRpn(85, "69601 (>K:ROTOR_BRAKE)")
---- APU Test
qmovha:CfgRpn(86, "69602 (>K:ROTOR_BRAKE)")
---- ENG2 Test
qmovha:CfgRpn(87, "71501 (>K:ROTOR_BRAKE)")

-- ===========================================================
-- Read data for lights
qmovha:GetStartUp('(L:APU_Volume) 100 >=')
qmovha:GetStartDn('(L:APU)')
qmovha:GetMswUp('(L:INI_APU_MASTER_FAULT)')
qmovha:GetMswDn('(L:switch_118_73X) 50 >=')

qmovha:GetUpled2Gen1Up('pmdg/ng3/data/ELEC_annunSOURCE_OFF[0]')
qmovha:GetUpled2Gen1Dn('pmdg/ng3/data/ELEC_annunGEN_BUS_OFF[0]')
qmovha:GetUpled2Gen2Up('pmdg/ng3/data/ELEC_annunSOURCE_OFF[1]')
qmovha:GetUpled2Gen2Dn('pmdg/ng3/data/ELEC_annunGEN_BUS_OFF[1]')

qmovha:GetUpled2Bat1Up('(L:INI_BATTERY_1_FAULT)')
qmovha:GetUpled2Bat1Dn('pmdg/ng3/data/ELEC_BatSelector', true)
qmovha:GetUpled2Bat2Up('(L:INI_BATTERY_2_FAULT)')
if isPMDG800 then
    qmovha:GetUpled2Bat2Dn('(L:switch_05_73X, bool) ! (L:switch_06_73X, bool) ! or')
else
    qmovha:GetUpled2Bat2Dn('(L:switch_974_73X, bool) !')
end
qmovha:GetUpled2ExtUp('(L:7X7X_Ground_Power_Light_NotInUse) (L:7X7X_Ground_Power_Light_Connected, Bool) ! and')
qmovha:GetUpled2ExtDn('(L:7X7X_Ground_Power_Light_Connected, Bool)')

qmovha:GetEng2Up('(L:INI_ENG_ANTI_ICE2_FAULT)')
qmovha:GetEng2Dn('(L:switch_158_73X, bool)')
qmovha:GetEng1Up('(L:INI_ENG_ANTI_ICE1_FAULT)')
qmovha:GetEng1Dn('(L:switch_157_73X, bool)')
qmovha:GetWingUp('(L:INI_WING_ANTI_ICE1_FAULT)')
qmovha:GetWingDn('(L:switch_156_73X, bool)')

qmovha:GetPack1Up('(L:INI_AIR_PACK1_FAULT)')
qmovha:GetPack1Dn('(L:switch_200_73X) 0 ==')
qmovha:GetApubUp('(L:VC_OVHD_AC_Eng_APU_Bleed_Button_TOP)')
qmovha:GetApubDn('(L:switch_211_73X, bool)')
qmovha:GetPack2Up('(L:INI_AIR_PACK2_FAULT)')
qmovha:GetPack2Dn('(L:switch_201_73X) 0 ==')

qmovha:GetCrew('(L:switch_196_73X) 0 ==')

if g_need_qmovha_pmdg737_gpws == 1 then
    qmovha:GetUpled1TerrUp('(L:VC_OVHD_GPWS_TERR_Button_TOP)')
    qmovha:GetUpled1TerrDn('(L:switch_505_73X, bool) !')
    qmovha:GetUpled1SysUp('(L:VC_OVHD_GPWS_SYS_Button_TOP)')
    qmovha:GetUpled1SysDn('(L:switch_503_73X, bool) !')
    qmovha:GetUpled1Flap3('(L:switch_501_73X, bool) !')
    qmovha:GetUpled1Gndctl('(L:INI_GND_CTL)')
else
    qmovha:GetUpled1TerrUp('(L:VC_OVHD_GPWS_TERR_Button_TOP)')
    qmovha:GetUpled1TerrDn('(L:switch_165_73X, bool) !')
    qmovha:GetUpled1SysUp('(L:VC_OVHD_GPWS_SYS_Button_TOP)')
    qmovha:GetUpled1SysDn('(L:switch_167_73X, bool) !')
    qmovha:GetUpled1Flap3('(L:switch_168_73X, bool) !')
    qmovha:GetUpled1Gndctl('(L:switch_166_73X, bool) !')
end
qmovha:GetUpled1Adr1Up('pmdg/ng3/data/FCTL_annunYAW_DAMPER')
qmovha:GetUpled1Adr1Dn('(L:switch_63_73X, bool) !')
qmovha:GetUpled1Adr3Up('(L:INI_ADR3_FAULT)')
qmovha:GetUpled1Adr3Dn('(L:switch_135_73X, bool) !')
qmovha:GetUpled1Adr2Up('(L:INI_ADR3_FAULT)')
qmovha:GetUpled1Adr2Dn('(L:switch_140_73X, bool) !')
qmovha:GetUpled1Onbat('pmdg/ng3/data/IRS_annunON_DC')

qmovha:GetUpled1Ltk1Up('pmdg/ng3/data/FUEL_annunLOWPRESS_Aft[0]')
qmovha:GetUpled1Ltk1Dn('(L:switch_37_73X, bool) !')
qmovha:GetUpled1Ltk2Up('pmdg/ng3/data/FUEL_annunLOWPRESS_Fwd[0]')
qmovha:GetUpled1Ltk2Dn('(L:switch_38_73X, bool) !')
qmovha:GetUpled1CtklUp('pmdg/ng3/data/FUEL_annunLOWPRESS_Ctr[0]')
qmovha:GetUpled1CtklDn('(L:switch_45_73X) !')
qmovha:GetUpled1CtkrUp('pmdg/ng3/data/FUEL_annunLOWPRESS_Ctr[1]')
qmovha:GetUpled1CtkrDn('(L:switch_46_73X) !')
qmovha:GetUpled2Rtk1Up('pmdg/ng3/data/FUEL_annunLOWPRESS_Fwd[1]')
qmovha:GetUpled2Rtk1Dn('(L:switch_39_73X, bool) !')
qmovha:GetUpled2Rtk2Up('pmdg/ng3/data/FUEL_annunLOWPRESS_Aft[1]')
qmovha:GetUpled2Rtk2Dn('(L:switch_40_73X, bool) !')
qmovha:GetUpled2XfeedUp('pmdg/ng3/data/FUEL_annunXFEED_VALVE_OPEN')
qmovha:GetUpled2XfeedDn('(L:switch_49_73X, bool) !')

qmovha:GetUpled1Fire2('pmdg/ng3/data/FIRE_HandleIlluminated[2]')
qmovha:GetUpled1Firea('pmdg/ng3/data/FIRE_HandleIlluminated[1]')
qmovha:GetUpled1Fire1('pmdg/ng3/data/FIRE_HandleIlluminated[0]')
qmovha:GetUpled2Eng1ag1('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng1ag2('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng2ag1('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng2ag2('(L:INI_FIRE_TEST)')

qmovha:GetBkl('(L:BL_Overhead, number) 100 * near', 1)             -- 0~100

qmovha:GetBrtDim("(L:switch_346_73X, number)", 50)                 -- 100: DIM 50: BRT 0: test mode
local dr_test = iDataRef:New("(L:switch_346_73X,number)")          -- 2: DIM 1: BRT 0: test mode
local dr_ac_bus = iDataRef:New("pmdg/ng3/data/ELEC_BusPowered[3]") -- 0: OFF 1: ON

-- stability functions
local StabilityManager = {
    monitors = {}
}

function StabilityManager:addMonitor(name, initialValue, threshold, interval)
    self.monitors[name] = {
        lastValue = initialValue,
        threshold = threshold,
        interval = interval,
        lastCheckTime = os.time(),
        stableCount = 0,
        requiredStableChecks = 3
    }
end

function StabilityManager:update(name, currentValue)
    local monitor = self.monitors[name]
    if not monitor then return false end

    local currentTime = os.time()

    -- 检查是否到达检查间隔
    if currentTime - monitor.lastCheckTime < monitor.interval then
        return false
    end

    monitor.lastCheckTime = currentTime

    -- 计算变化
    local delta = math.abs(currentValue - monitor.lastValue)
    monitor.lastValue = currentValue

    -- 更新稳定状态
    if delta <= monitor.threshold then
        monitor.stableCount = monitor.stableCount + 1
    else
        monitor.stableCount = 0
    end

    return monitor.stableCount >= monitor.requiredStableChecks
end

local dr_qmovh_pmdg737_apu_egt = iDataRef:New("pmdg/ng3/data/APU_EGTNeedle")
local isstableapuegt = 0
local dr_apu_on = iDataRef:New('(L:APU)')

StabilityManager:addMonitor("EGT", 25.0, 2, 1) -- 温度监控
-- DONT use this name "Qmovha_pmdg_737_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_pmdg_737_loop()
    -- expert code: test mode
    local b_ac_bus = dr_ac_bus:Get()

    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 0 and b_ac_bus == 1 then
            -- TEST
            uluaSet(idr_qmovh_a_hid_mode_off, 0)
            uluaSet(idr_qmovh_a_hid_mode_test, 1)
        else
            uluaSet(idr_qmovh_a_hid_mode_test, 0)
        end
    end

    if b_test == 0 then
        -- TEST
        return
    end

    local isapuon = dr_apu_on:Get()
    local currentTemp = dr_qmovh_pmdg737_apu_egt:Get()
    if currentTemp > 350 then
        -- uluaLog(string.format("APU Egt (%d)", currentTemp))
        if StabilityManager:update("EGT", currentTemp) then
            isstableapuegt = 1
        end
    else
        isstableapuegt = 0
    end
    if isstableapuegt > 0 then
        isapuon = 0
    end
    -- qmovha:SetDnled()
    if currentTemp < 1000 then
        -- PMDG SDK float data correction path in C code
        qmovha:SetStartUp(0, isstableapuegt)
        qmovha:SetStartDn(0, isapuon)
    else
        qmovha:SetStartUp()
        qmovha:SetStartDn()
    end
    qmovha:SetMswUp()
    qmovha:SetMswDn()
    qmovha:SetEng2Up()
    qmovha:SetEng2Dn()
    qmovha:SetEng1Up()
    qmovha:SetEng1Dn()
    qmovha:SetPack1Up()
    qmovha:SetPack1Dn()
    qmovha:SetApubUp()
    qmovha:SetApubDn()
    qmovha:SetPack2Up()
    qmovha:SetPack2Dn()
    qmovha:SetWingUp()
    qmovha:SetWingDn()
    qmovha:SetCrew()
    --
    qmovha:SetUpled1()
    qmovha:SetUpled2()

    qmovha:SetBkl()
    qmovha:SetBrtDim()
end

uluaAddDoLoop("Qmovha_pmdg_737_loop()")
