-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-08-26
-- modify by Carson Lou <50984721@qq.com> 2025-11-23
-- *****************************************************************
-- Do not remove below lines: hardware detection
if ilua_is_acfpath_excluded("PMDG") or ilua_is_acfpath_excluded("777") then
    return
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for PMDG777")

-- ===========================================================

---- GEN1
qmovha:CfgRpn(58, "901 (>K:ROTOR_BRAKE)")
-- BATTERY
qmovha:CfgRpn(59, "101 (>K:ROTOR_BRAKE)")

--IFE/PASS SEATS& CABIN/UNILITY
qmovha:CfgRpn(60, "1701 (>K:ROTOR_BRAKE)", "1801 (>K:ROTOR_BRAKE)")

---- GEN2
qmovha:CfgRpn(62, "1001 (>K:ROTOR_BRAKE)")

--EMER LIGHTS _50_is Cap 0:closed, 100:open, _49_ is knob 0:OFF 50:ARMED 100:ON
local pswh22 = QmdevPosSwitchInit("(L:switch_49_a, number)", 50, "4908 (>K:ROTOR_BRAKE)", "4907 (>K:ROTOR_BRAKE)")
local pswh23 = QmdevPosSwitchInit("(L:switch_50_a, number)", 50, "5001 (>K:ROTOR_BRAKE)", "5001 (>K:ROTOR_BRAKE)", 1000)
qmovha:CfgFc(22, qmovha:GenPSwStr(pswh23, 100) .. ";" .. qmovha:GenPSwStr(pswh22, 100) )
qmovha:CfgFc(49, qmovha:GenPSwStr(pswh23, 0) .. ";" .. qmovha:GenPSwStr(pswh22, 50) )
qmovha:CfgFc(23, qmovha:GenPSwStr(pswh23, 100) .. ";" .. qmovha:GenPSwStr(pswh22, 0) )

--ADIRU
qmovha:CfgRpn(57, "5901 (>K:ROTOR_BRAKE)")

--ADR2 WINDOW HEAT
qmovha:CfgRpn(55,
    "4501 (>K:ROTOR_BRAKE) 4601 (>K:ROTOR_BRAKE) 4701 (>K:ROTOR_BRAKE) 4801 (>K:ROTOR_BRAKE)")
--ADR3 backup gen
qmovha:CfgRpn(56, "1101 (>K:ROTOR_BRAKE) 1201 (>K:ROTOR_BRAKE)")

--EXT PWR
--PRIMARY --SECONDARY
local pswh61 = QmdevPosSwitchInit("(L:switch_07_b, number)", 1, "701 (>K:ROTOR_BRAKE)", "701 (>K:ROTOR_BRAKE)", 500)
local pswh62 = QmdevPosSwitchInit("(L:switch_08_b, number)", 1, "801 (>K:ROTOR_BRAKE)", "801 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg777_ext_on = iDataRef:New("(L:switch_08_b, number)")
qmovha:CfgFc(61,
    "local pos = 1 - dr_qmovh_pmdg777_ext_on:Get();QmdevPosSwitchSet(" .. tostring(pswh61) .. ",  pos);QmdevPosSwitchSet(" .. tostring(pswh62) .. ",  pos)")

--FUEL PUMPS
qmovha:CfgRpn(54, "10301 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(68, "10501 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(67, "10901 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(65, "11001 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(64, "10401 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(63, "10601 (>K:ROTOR_BRAKE)")

--FUEL CROSSFEED FWD&AFT
qmovha:CfgRpn(66, "10801 (>K:ROTOR_BRAKE)", "10701 (>K:ROTOR_BRAKE)")

--HYDRAULIC
--TERR: L ENG & R ENG
qmovha:CfgRpn(50, "3901 (>K:ROTOR_BRAKE) 4201 (>K:ROTOR_BRAKE)")

--SYS: C1 C2 ELEC
qmovha:CfgRpn(51, "4001 (>K:ROTOR_BRAKE) 4101 (>K:ROTOR_BRAKE)")

--LDG FLAP3: FLAP OVRD
local pswh52 = QmdevPosSwitchInit("(L:switch_301_a, number)", 100, "30101 (>K:ROTOR_BRAKE)", "30101 (>K:ROTOR_BRAKE)", 1000)
local pswh53 = QmdevPosSwitchInit("(L:switch_302_a, number)", 100, "30201 (>K:ROTOR_BRAKE)", "30201 (>K:ROTOR_BRAKE)", 1000)
dr_qmovh_pmdg777_flap_ovrd = iDataRef:New("(L:switch_301_a, number)")
qmovha:CfgFc(52,
    "local pos = 100 - dr_qmovh_pmdg777_flap_ovrd:Get();QmdevPosSwitchSet(" .. tostring(pswh53) .. ", 100);QmdevPosSwitchSet(" .. tostring(pswh52) .. ",  pos)")

--GND CTL:
qmovha:CfgRpn(53, "(L:switch_152_a, number) 100 != if{ 15201 (>K:ROTOR_BRAKE) } els{ 15202 (>K:ROTOR_BRAKE) }")

--L ELEC
local pswh73 = QmdevPosSwitchInit("(L:switch_35_a, number)", 50, "3507 (>K:ROTOR_BRAKE)", "3508 (>K:ROTOR_BRAKE)", 100)
qmovha:CfgPSw(73, pswh73, 0)
qmovha:CfgPSw(74, pswh73, 50)
qmovha:CfgPSw(75, pswh73, 100)
--R ELEC
local pswh76 = QmdevPosSwitchInit("(L:switch_38_a, number)", 50, "3807 (>K:ROTOR_BRAKE)", "3808 (>K:ROTOR_BRAKE)", 100)
qmovha:CfgPSw(76, pswh76, 0)
qmovha:CfgPSw(77, pswh76, 50)
qmovha:CfgPSw(78, pswh76, 100)
--C1 AIR
local pswh79 = QmdevPosSwitchInit("(L:switch_36_a, number)", 50, "3607 (>K:ROTOR_BRAKE)", "3608 (>K:ROTOR_BRAKE)", 100)
local pswh80 = QmdevPosSwitchInit("(L:switch_37_a, number)", 50, "3707 (>K:ROTOR_BRAKE)", "3708 (>K:ROTOR_BRAKE)", 100)
qmovha:CfgFc(79, qmovha:GenPSwStr(pswh79, 0) .. ";" .. qmovha:GenPSwStr(pswh80, 0) )
qmovha:CfgFc(80, qmovha:GenPSwStr(pswh79, 50) .. ";" .. qmovha:GenPSwStr(pswh80, 50) )
qmovha:CfgFc(81, qmovha:GenPSwStr(pswh79, 100) .. ";" .. qmovha:GenPSwStr(pswh80, 100) )

--NO SMOKING
local pswh15 = QmdevPosSwitchInit("(L:switch_29_a, number)", 50, "2907 (>K:ROTOR_BRAKE)", "2908 (>K:ROTOR_BRAKE)", 100)
qmovha:CfgPSw(15, pswh15, 0)
qmovha:CfgPSw(48, pswh15, 50)
qmovha:CfgPSw(14, pswh15, 100)

--SEAT BELTS
qmovha:CfgRpn(13, "(L:switch_30_a, number) 0 == if{ 3007 (>K:ROTOR_BRAKE) }",
    "(L:switch_30_a, number) 0 != if{ 3008 (>K:ROTOR_BRAKE) }")

-- OVHD INTEG LT KNOBS  BRT <-> OFF
qmovha:CfgRpn(16, "(L:OH_MASTER_BRIGHT_ROTATE, number) 2 + 100 min (>L:OH_MASTER_BRIGHT_ROTATE, number)")
qmovha:CfgRpn(17, "(L:OH_MASTER_BRIGHT_ROTATE, number) 2 - 0 max (>L:OH_MASTER_BRIGHT_ROTATE, number)")

--APU
---- start
qmovha:CfgRpn(30, "307 (>K:ROTOR_BRAKE)")
---- master: 0: OFF 50: ON
qmovha:CfgRpn(31, "(L:switch_03_a, number) 0 ==  if{ 307 (>K:ROTOR_BRAKE) } els{ 308 (>K:ROTOR_BRAKE) }")

-- ANTI ICE
---- ENG2
local pswh32 = QmdevPosSwitchInit("(L:switch_113_a, number)", 50, "11307 (>K:ROTOR_BRAKE)", "11308 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg777_anti_eng2 = iDataRef:New("(L:switch_113_a, number)")
qmovha:CfgFc(32,
    "local pos = 100 == dr_qmovh_pmdg777_anti_eng2:Get() and 50 or 100;QmdevPosSwitchSet(" .. tostring(pswh32) .. ",  pos)")
---- ENG1
local pswh33 = QmdevPosSwitchInit("(L:switch_112_a, number)", 50, "11207 (>K:ROTOR_BRAKE)", "11208 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg777_anti_eng1 = iDataRef:New("(L:switch_112_a, number)")
qmovha:CfgFc(33,
    "local pos = 100 == dr_qmovh_pmdg777_anti_eng1:Get() and 50 or 100;QmdevPosSwitchSet(" .. tostring(pswh33) .. ",  pos)")
---- WING
local pswh37 = QmdevPosSwitchInit("(L:switch_111_a, number)", 50, "11107 (>K:ROTOR_BRAKE)", "11108 (>K:ROTOR_BRAKE)", 500)
dr_qmovh_pmdg777_anti_wing = iDataRef:New("(L:switch_111_a, number)")
qmovha:CfgFc(37,
    "local pos = 100 == dr_qmovh_pmdg777_anti_wing:Get() and 50 or 100;QmdevPosSwitchSet(" .. tostring(pswh37) .. ",  pos)")

--BLEED AIR
--L PACK
qmovha:CfgRpn(34, "13501 (>K:ROTOR_BRAKE)")
--R PACK
qmovha:CfgRpn(36, "13601 (>K:ROTOR_BRAKE)")
--APU
qmovha:CfgRpn(35, "13101 (>K:ROTOR_BRAKE)")

--NAV&LOGO 0:OFF 100:ON
local pswh4 = QmdevPosSwitchInit("(L:switch_115_a, number)", 100, "11501 (>K:ROTOR_BRAKE)", "11501 (>K:ROTOR_BRAKE)", 500)
local pswh5 = QmdevPosSwitchInit("(L:switch_116_a, number)", 100, "11601 (>K:ROTOR_BRAKE)", "11601 (>K:ROTOR_BRAKE)", 500)
qmovha:CfgFc(4, qmovha:GenPSwStr(pswh4, 100) .. ";" .. qmovha:GenPSwStr(pswh5, 100) )
qmovha:CfgFc(42, qmovha:GenPSwStr(pswh4, 100) .. ";" .. qmovha:GenPSwStr(pswh5, 0) )
qmovha:CfgFc(5, qmovha:GenPSwStr(pswh4, 0) .. ";" .. qmovha:GenPSwStr(pswh5, 0) )

--BEACON
qmovha:CfgRpn(2, "(L:switch_114_a, number) 0 == if{ 11401 (>K:ROTOR_BRAKE) }",
    "(L:switch_114_a, number) 0 != if{ 11401 (>K:ROTOR_BRAKE) }")

--WING
qmovha:CfgRpn(3, "(L:switch_117_a, number) 0 == if{ 11701 (>K:ROTOR_BRAKE) }",
    "(L:switch_117_a, number) 0 != if{ 11701 (>K:ROTOR_BRAKE) }")

-- POS/Strobe
qmovha:CfgRpn(0, "(L:switch_122_a, number) 0 == if{ 12201 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(41, "")
qmovha:CfgRpn(1, "(L:switch_122_a, number) 0 != if{ 12201 (>K:ROTOR_BRAKE) }")

--TAXI
qmovha:CfgRpn(6,
    "(L:switch_121_a, number) 0 == if{ 12101 (>K:ROTOR_BRAKE) } (L:switch_23_a, number) 0 == if{ 2301 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(45,
    "(L:switch_121_a, number) 0 == if{ 12101 (>K:ROTOR_BRAKE) } (L:switch_23_a, number) 0 != if{ 2301 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(7, "(L:switch_121_a, number) 0 != if{ 12101 (>K:ROTOR_BRAKE) }")

--RUNWAY TURNOFF
qmovha:CfgRpn(12,
    "(L:switch_119_a, number) 0 == if{ 11901 (>K:ROTOR_BRAKE) } (L:switch_120_a, number) 0 == if{ 12001 (>K:ROTOR_BRAKE) }",
    "(L:switch_119_a, number) 0 != if{ 11901 (>K:ROTOR_BRAKE) } (L:switch_120_a, number) 0 != if{ 12001 (>K:ROTOR_BRAKE) }")

--L LANDING LIGHTS
qmovha:CfgRpn(10, "(L:switch_22_a, number) 0 == if{ 2201 (>K:ROTOR_BRAKE) }",
    "(L:switch_22_a, number) 0 != if{ 2201 (>K:ROTOR_BRAKE) }")

--R LANDING LIGHTS
qmovha:CfgRpn(8, "(L:switch_24_a, number) 0 == if{ 2401 (>K:ROTOR_BRAKE) }",
    "(L:switch_24_a, number) 0 != if{ 2401 (>K:ROTOR_BRAKE) }")

--IND LTS
local pswh21 = QmdevPosSwitchInit("(L:switch_118_a, number)", 50, "11808 (>K:ROTOR_BRAKE)", "11807 (>K:ROTOR_BRAKE)", 100)
qmovha:CfgPSw(20, pswh21, 0)
qmovha:CfgPSw(47, pswh21, 50)
qmovha:CfgPSw(21, pswh21, 100)


---- XBLEED
local pswh27 = QmdevPosSwitchInit("(L:switch_133_a, number)", 100, "13301 (>K:ROTOR_BRAKE)", "13301 (>K:ROTOR_BRAKE)")
qmovha:CfgPSw(27, pswh27, 0)
qmovha:CfgPSw(28, pswh27, 100)
--qmovha:CfgPSw(29, pswh27, 100)

--WIPER
local pswh24 = QmdevPosSwitchInit("(L:switch_20_a, number)", 10, "2007 (>K:ROTOR_BRAKE)", "2008 (>K:ROTOR_BRAKE)", 30)
local pswh25 = QmdevPosSwitchInit("(L:switch_123_a, number)", 10, "12307 (>K:ROTOR_BRAKE)", "12308 (>K:ROTOR_BRAKE)", 30)
qmovha:CfgFc(24, qmovha:GenPSwStr(pswh24, 0) .. ";" .. qmovha:GenPSwStr(pswh25, 0) )
qmovha:CfgFc(25, qmovha:GenPSwStr(pswh24, 10) .. ";" .. qmovha:GenPSwStr(pswh25, 10) )
qmovha:CfgFc(26, qmovha:GenPSwStr(pswh24, 30) .. ";" .. qmovha:GenPSwStr(pswh25, 30) )

-- OXYGEN CREW SUPPLY
qmovha:CfgRpn(38, "107701 (>K:ROTOR_BRAKE)")

--CALL all（777好像没有这个功能）
--qmovha:CfgRpn(30, "13501 (>K:ROTOR_BRAKE)")

--STORM
qmovha:CfgRpn(18, "100 (>L:OH_DOME_SWITCH) (L:switch_27_a, number) 0 == if{ 2701 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(46, "50 (>L:OH_DOME_SWITCH) (L:switch_27_a, number) 0 != if{ 2701 (>K:ROTOR_BRAKE) }")
qmovha:CfgRpn(19, "0 (>L:OH_DOME_SWITCH)")

-- FIRE
---- eng2 agent2
qmovha:CfgRpn(69, "65202 (>K:ROTOR_BRAKE)")
---- eng2 agent1
qmovha:CfgRpn(70, "65201 (>K:ROTOR_BRAKE)")
---- eng1 agent2
qmovha:CfgRpn(71, "65102 (>K:ROTOR_BRAKE)")
---- eng1 agent1
qmovha:CfgRpn(72, "65101 (>K:ROTOR_BRAKE)")

---- ENG1 0:DOWN 10:UP
qmovha:CfgRpn(82, "(L:switch_651_a, number) 0 == if{ 651101 (>K:ROTOR_BRAKE) }",
    "(L:switch_651_a, number) 0 != if{ 651101 (>K:ROTOR_BRAKE) }")
---- APU
qmovha:CfgRpn(83, "(L:switch_84_a, number) 0 == if{ 840101 (>K:ROTOR_BRAKE) }",
    "(L:switch_84_a, number) 0 != if{ 840101 (>K:ROTOR_BRAKE) }")
---- ENG2 0:DOWN 10:UP
qmovha:CfgRpn(84, "(L:switch_652_a, number) 0 == if{ 652101 (>K:ROTOR_BRAKE) }",
    "(L:switch_652_a, number) 0 != if{ 652101 (>K:ROTOR_BRAKE) }")

---- FIRE Test
qmovha:CfgRpn(85, "8901 (>K:ROTOR_BRAKE)", "8904 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(86, "8901 (>K:ROTOR_BRAKE)", "8904 (>K:ROTOR_BRAKE)")
qmovha:CfgRpn(87, "8901 (>K:ROTOR_BRAKE)", "8904 (>K:ROTOR_BRAKE)")
----------------------------------------------------------------------------------------------------------------------------------------------------

-- Read data for lights

qmovha:GetStartUp('(L:APUStartup) 1 == (L:7X7XAPUInlet) 100 == and')
qmovha:GetStartDn('(L:APUStartup) 1 >=')
qmovha:GetMswUp('(L:APU, number)')
qmovha:GetMswDn('(L:switch_03_a) 50 ==')

qmovha:GetUpled2Gen1Up('(L:switch_09_c)')
qmovha:GetUpled2Gen1Dn('(L:switch_09_a) !')
qmovha:GetUpled2Gen2Up('(L:switch_10_c)')
qmovha:GetUpled2Gen2Dn('(L:switch_10_a) !')

qmovha:GetUpled2Bat1Up('(L:INI_BATTERY_1_FAULT)')
qmovha:GetUpled2Bat1Dn('(L:switch_01_a) !')
qmovha:GetUpled2Bat2Up('(L:INI_BATTERY_2_FAULT)')
qmovha:GetUpled2Bat2Dn('(L:switch_17_c)')
qmovha:GetUpled2ExtUp('(L:switch_07_c) (L:switch_08_c) or')
qmovha:GetUpled2ExtDn('(L:switch_08_b)')

qmovha:GetEng2Up('(L:INI_ENG_ANTI_ICE2_FAULT)')
qmovha:GetEng2Dn('(L:switch_113_a) 100 ==')
qmovha:GetEng1Up('(L:INI_ENG_ANTI_ICE1_FAULT)')
qmovha:GetEng1Dn('(L:switch_112_a) 100 ==')
qmovha:GetWingUp('(L:INI_WING_ANTI_ICE1_FAULT)')
qmovha:GetWingDn('(L:switch_111_a) 100 ==')

qmovha:GetPack1Up('(L:switch_135_c)')
qmovha:GetPack1Dn('(L:switch_135_a) !')
qmovha:GetApubUp('(L:switch_131_c)')
qmovha:GetApubDn('(L:switch_131_ac)')
qmovha:GetPack2Up('(L:switch_136_c)')
qmovha:GetPack2Dn('(L:switch_136_a) !')

qmovha:GetCrew('(L:switch_1077_a) 100 ==')

qmovha:GetUpled1TerrUp('(L:switch_39_c) (L:switch_42_c) or')
qmovha:GetUpled1TerrDn('(L:switch_39_a, bool) ! (L:switch_42_a, bool) ! and')
qmovha:GetUpled1SysUp('(L:switch_40_c) (L:switch_41_c) or')
qmovha:GetUpled1SysDn('(L:switch_40_a, bool) ! (L:switch_41_a, bool) ! and')
qmovha:GetUpled1Flap3('(L:switch_301_a) 100 ==')
qmovha:GetUpled1Gndctl('(L:switch_152_a) 100 ==')


qmovha:GetUpled1Adr1Up('(L:switch_59_c)')
qmovha:GetUpled1Adr1Dn('(L:switch_59_a) !')
qmovha:GetUpled1Adr3Up('(L:switch_11_c) (L:switch_12_c) or')
qmovha:GetUpled1Adr3Dn('(L:switch_11_a) ! (L:switch_12_a) ! and')
qmovha:GetUpled1Adr2Up('(L:switch_45_c) (L:switch_46_c) (L:switch_47_c) (L:switch_48_c) or')
qmovha:GetUpled1Adr2Dn('(L:switch_45_a) ! (L:switch_46_a) ! (L:switch_47_a) ! (L:switch_48_a) !')
qmovha:GetUpled1Onbat('(L:switch_58_a)')

qmovha:GetUpled1Ltk1Up('(L:switch_103_c)')
qmovha:GetUpled1Ltk1Dn('(L:switch_103_a) !')
qmovha:GetUpled1Ltk2Up('(L:switch_105_c)')
qmovha:GetUpled1Ltk2Dn('(L:switch_105_a) !')
qmovha:GetUpled1CtklUp('(L:switch_109_c)')
qmovha:GetUpled1CtklDn('(L:switch_109_a) !')
qmovha:GetUpled1CtkrUp('(L:switch_110_c)')
qmovha:GetUpled1CtkrDn('(L:switch_110_a) !')
qmovha:GetUpled2Rtk1Up('(L:switch_104_c)')
qmovha:GetUpled2Rtk1Dn('(L:switch_104_a) !')
qmovha:GetUpled2Rtk2Up('(L:switch_106_c)')
qmovha:GetUpled2Rtk2Dn('(L:switch_106_a) !')
qmovha:GetUpled2XfeedUp('(L:switch_107_a, bool) 100 ==')
qmovha:GetUpled2XfeedDn('(L:switch_107_c)')

qmovha:GetUpled1Fire2('(L:switch_6523_a)')
qmovha:GetUpled1Firea('(L:switch_8411_a)')
qmovha:GetUpled1Fire1('(L:switch_6513_a)')
qmovha:GetUpled2Eng1ag1('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng1ag2('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng2ag1('(L:INI_FIRE_TEST)')
qmovha:GetUpled2Eng2ag2('(L:INI_FIRE_TEST)')

--
qmovha:GetBkl('(L:BL_Overhead, number) 100 * near', 1)  -- 0~1

qmovha:GetBrtDim("(L:switch_118_a,number)", 50)         -- 100: DIM 50: BRT 0: test mode
local dr_test = iDataRef:New("(L:switch_118_a,number)") -- 2: DIM 1: BRT 0: test mode
local dr_ac_bus = iDataRef:New("(L:Battery)")           -- 0: OFF 1: ON

-- DONT use this name "Qmovha_pmdg_777_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_pmdg_777_loop()
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

    qmovha:SetStartUp()
    qmovha:SetStartDn()

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

uluaAddDoLoop("Qmovha_pmdg_777_loop()")
