-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-09-14
-- *****************************************************************
if PLANE_ICAO ~= "A320" or PLANE_TAILNUMBER ~= "D-AXLA" then
    return
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for FF320")

-- ===========================================================
-- 按钮绑定
-- Strobe
local pswh0 = QmdevPosSwitchInit("a320/Overhead/LightStrobe", 1, "a320/Overhead/LightStrobe_switch+",
    "a320/Overhead/LightStrobe_switch+", 500)
qmovha:CfgPSw(0, pswh0, 2)
qmovha:CfgPSw(41, pswh0, 1)
qmovha:CfgPSw(1, pswh0, 0)

-- beacon lights
local pswh2 = QmdevPosSwitchInit("a320/Overhead/LightBeacon", 1, "a320/Overhead/LightBeacon_switch+",
    "a320/Overhead/LightBeacon_switch+", 500)
qmovha:CfgPSw(2, pswh2, 1, 0)

-- Wing lights
local pswh3 = QmdevPosSwitchInit("a320/Overhead/LightWing", 1, "a320/Overhead/LightWing_switch+",
    "a320/Overhead/LightWing_switch+", 500)
qmovha:CfgPSw(3, pswh3, 1, 0)

-- NAV&Logo  lights
local pswh4 = QmdevPosSwitchInit("a320/Overhead/LightLogo", 1, "a320/Overhead/LightLogo_switch+",
    "a320/Overhead/LightLogo_switch+", 500)
qmovha:CfgPSw(4, pswh4, 2)
qmovha:CfgPSw(42, pswh4, 1)
qmovha:CfgPSw(5, pswh4, 0)

-- Nose lights
local pswh6 = QmdevPosSwitchInit("a320/Overhead/LightNose", 1, "a320/Overhead/LightNose_switch+",
    "a320/Overhead/LightNose_switch+", 500)
qmovha:CfgPSw(6, pswh6, 2)
qmovha:CfgPSw(45, pswh6, 1)
qmovha:CfgPSw(7, pswh6, 0)

-- R Landing lights
local pswh8 = QmdevPosSwitchInit("a320/Overhead/LightLandR", 1, "a320/Overhead/LightLandR_switch+",
    "a320/Overhead/LightLandR_switch+", 500)
qmovha:CfgPSw(8, pswh8, 2)
qmovha:CfgPSw(44, pswh8, 1)
qmovha:CfgPSw(9, pswh8, 0)

-- L Landing lights
local pswh10 = QmdevPosSwitchInit("a320/Overhead/LightLandL", 1, "a320/Overhead/LightLandL_switch+",
    "a320/Overhead/LightLandL_switch+", 500)
qmovha:CfgPSw(10, pswh10, 2)
qmovha:CfgPSw(43, pswh10, 1)
qmovha:CfgPSw(11, pswh10, 0)

-- Runway Turn Off lights
local pswh12 = QmdevPosSwitchInit("a320/Overhead/LightTurn", 1, "a320/Overhead/LightTurn_switch+",
    "a320/Overhead/LightTurn_switch+", 500)
qmovha:CfgPSw(12, pswh12, 1, 0)

-- OVHD INTEG LT
-- qmovha:CfgEncFull(17, 16, "sim/cockpit/electrical/instrument_brightness", 0.05, 0.05, 1, 0.05, 1.0)
qmovha:CfgCmd(17, "a320/Overhead/LightOverhead_switch-")
qmovha:CfgCmd(16, "a320/Overhead/LightOverhead_switch+")
-- SEAT BELTS
local pswh13 = QmdevPosSwitchInit("a320/Overhead/LightBelts", 1, "a320/Overhead/LightBelts_switch+",
    "a320/Overhead/LightBelts_switch+", 500)
qmovha:CfgPSw(13, pswh13, 2, 0)

-- NO SMOKING
local pswh14 = QmdevPosSwitchInit("a320/Overhead/LightSmoke", 1, "a320/Overhead/LightSmoke_switch+",
    "a320/Overhead/LightSmoke_switch+", 500)
qmovha:CfgPSw(14, pswh14, 2)
qmovha:CfgPSw(48, pswh14, 1)
qmovha:CfgPSw(15, pswh14, 0)

-- DOME
local pswh18 = QmdevPosSwitchInit("a320/Overhead/LightDome", 1, "a320/Overhead/LightDome_switch+",
    "a320/Overhead/LightDome_switch+", 500)
qmovha:CfgPSw(18, pswh18, 2)
qmovha:CfgPSw(46, pswh18, 1)
qmovha:CfgPSw(19, pswh18, 0)

-- ANN LT
local pswh20 = QmdevPosSwitchInit("a320/Overhead/LightAnnun", 1, "a320/Overhead/LightAnnun_switch+",
    "a320/Overhead/LightAnnun_switch+", 500)
qmovha:CfgPSw(20, pswh20, 2)
qmovha:CfgPSw(47, pswh20, 1)
qmovha:CfgPSw(21, pswh20, 0)

-- EMER EXIT LT
local pswh22 = QmdevPosSwitchInit("a320/Overhead/LightEmerMode", 1, "a320/Overhead/LightEmerMode_switch+",
    "a320/Overhead/LightEmerMode_switch+", 1000)
qmovha:CfgPSw(22, pswh22, 2)
qmovha:CfgPSw(49, pswh22, 1)
qmovha:CfgPSw(23, pswh22, 0)

-- APU Start
qmovha:CfgCmd(30, "a320/Overhead/APU_Start_button")
-- APU Master
qmovha:CfgCmd(31, "a320/Overhead/APU_Master_button")
-- ANTI ICE
---- ENG2
qmovha:CfgCmd(32, "a320/Overhead/HeatEngine2_button")
---- ENG1
qmovha:CfgCmd(33, "a320/Overhead/HeatEngine1_button")
---- WING
qmovha:CfgCmd(37, "a320/Overhead/HeatWing_button")

-- AIR COND
---- PACK1
qmovha:CfgCmd(34, "a320/Overhead/AirPack1_button")
---- APU BLEED
qmovha:CfgCmd(35, "a320/Overhead/AirBleedAux_button")
---- PACK2
qmovha:CfgCmd(36, "a320/Overhead/AirPack2_button")

---- XBLEED
local pswh27 = QmdevPosSwitchInit("a320/Overhead/AirXBleed", 1, "a320/Overhead/AirXBleed_switch+",
    "a320/Overhead/AirXBleed_switch-", 500)
qmovha:CfgPSw(27, pswh27, 0)
qmovha:CfgPSw(28, pswh27, 1)
qmovha:CfgPSw(29, pswh27, 2)

-- WIPER
local pswh24 = QmdevPosSwitchInit("a320/Overhead/Wiper1Mode", 1, "a320/Overhead/Wiper1Mode_switch+",
    "a320/Overhead/Wiper1Mode_switch-", 500)
qmovha:CfgPSw(24, pswh24, 0)
qmovha:CfgPSw(25, pswh24, 1)
qmovha:CfgPSw(26, pswh24, 2)

-- OXYGEN
qmovha:CfgCmd(38, "a320/Overhead/OxygenCrewSupply_button")
-- CALLS
qmovha:CfgValT(40, "a320/Overhead/CallsFwd")

-- GPWS
---- TERR
qmovha:CfgCmd(50, "a320/Overhead/GPWS_Terr_button")
---- SYS

qmovha:CfgCmd(51, "a320/Overhead/GPWS_System_button")
---- FLAPS3

qmovha:CfgCmd(52, "a320/Overhead/GPWS_Flaps3_button")

-- GND CTL CVR
qmovha:CfgCmd(53, "a320/Overhead/EmerOvrdProt_switch+")

-- ADIRS 2,3,1
qmovha:CfgCmd(55, "a320/Overhead/CDU_ADR2_button")
qmovha:CfgCmd(56, "a320/Overhead/CDU_ADR3_button")
qmovha:CfgCmd(57, "a320/Overhead/CDU_ADR1_button")
-- IR1
local pswh73 = QmdevPosSwitchInit("a320/Overhead/CDU_Mode1", 1, "a320/Overhead/CDU_Mode1_switch+",
    "a320/Overhead/CDU_Mode1_switch-", 500)
qmovha:CfgPSw(73, pswh73, 0)
qmovha:CfgPSw(74, pswh73, 1)
qmovha:CfgPSw(75, pswh73, 2)

-- IR3
local pswh79 = QmdevPosSwitchInit("a320/Overhead/CDU_Mode3", 1, "a320/Overhead/CDU_Mode3_switch+",
    "a320/Overhead/CDU_Mode3_switch-", 500)
qmovha:CfgPSw(79, pswh79, 0)
qmovha:CfgPSw(80, pswh79, 1)
qmovha:CfgPSw(81, pswh79, 2)

-- IR2
local pswh76 = QmdevPosSwitchInit("a320/Overhead/CDU_Mode2", 1, "a320/Overhead/CDU_Mode2_switch+",
    "a320/Overhead/CDU_Mode2_switch-", 500)
qmovha:CfgPSw(76, pswh76, 0)
qmovha:CfgPSw(77, pswh76, 1)
qmovha:CfgPSw(78, pswh76, 2)

-- BAT 1&2
---- GEN1
qmovha:CfgCmd(58, "a320/Overhead/ElecGen1_button")
---- BAT1
qmovha:CfgCmd(59, "a320/Overhead/ElecBat1_button")
---- BAT2
qmovha:CfgCmd(60, "a320/Overhead/ElecBat2_button")
---- GEN2
qmovha:CfgCmd(62, "a320/Overhead/ElecGen2_button")
-- EXT PWR
qmovha:CfgCmd(61, "a320/Overhead/ElecExt_button")

-- FUEL
---- L1
qmovha:CfgCmd(54, "a320/Overhead/FuelPump1_button")
---- L2
qmovha:CfgCmd(68, "a320/Overhead/FuelPump2_button")
---- C1
qmovha:CfgCmd(67, "a320/Overhead/FuelPump5_button")
---- C2
qmovha:CfgCmd(65, "a320/Overhead/FuelPump6_button")
---- R1
qmovha:CfgCmd(64, "a320/Overhead/FuelPump3_button")
---- R2
qmovha:CfgCmd(63, "a320/Overhead/FuelPump4_button")
---- XFEED
qmovha:CfgCmd(66, "a320/Overhead/FuelXFeed_button")

-- FIRE
---- eng2 agent2
qmovha:CfgCmd(69, "a320/Overhead/FireEngine2_Agent2_button")
---- eng2 agent1
qmovha:CfgCmd(70, "a320/Overhead/FireEngine2_Agent1_button")
---- eng1 agent2
qmovha:CfgCmd(71, "a320/Overhead/FireEngine1_Agent2_button")
---- eng1 agent1 
qmovha:CfgCmd(72, "a320/Overhead/FireEngine1_Agent1_button")

---- ENG1
local pswh82 = QmdevPosSwitchInit("a320/Overhead/FireEngine1", 1, "a320/Overhead/FireEngine1_button",
    "a320/Overhead/FireEngine1_button", 500)
local pswh72 = QmdevPosSwitchInit("a320/Overhead/FireEngine1_Prot", 1, "a320/Overhead/FireEngine1_Prot_switch+",
    "a320/Overhead/FireEngine1_Prot_switch+", 500)
qmovha:CfgFc(82, qmovha:GenPSwStr(pswh82, 0), qmovha:GenPSwStr(pswh82, 1) .. ";" .. qmovha:GenPSwStr(pswh72, 1))

---- APU
local pswh83 = QmdevPosSwitchInit("a320/Overhead/FireAPU", 1, "a320/Overhead/FireAPU_button", "a320/Overhead/FireAPU_button", 500)
local pswh73 = QmdevPosSwitchInit("a320/Overhead/FireAPU_Prot", 1, "a320/Overhead/FireAPU_Prot_switch+",
    "a320/Overhead/FireAPU_Prot_switch+", 500)
qmovha:CfgFc(83, qmovha:GenPSwStr(pswh83, 0), qmovha:GenPSwStr(pswh83, 1) .. ";" .. qmovha:GenPSwStr(pswh73, 1))

---- ENG2
local pswh84 = QmdevPosSwitchInit("a320/Overhead/FireEngine2", 1, "a320/Overhead/FireEngine2_button",
    "a320/Overhead/FireEngine2_button", 500)
local pswh74 = QmdevPosSwitchInit("a320/Overhead/FireEngine2_Prot", 1, "a320/Overhead/FireEngine2_Prot_switch+",
    "a320/Overhead/FireEngine2_Prot_switch+", 500)
qmovha:CfgFc(84, qmovha:GenPSwStr(pswh84, 0), qmovha:GenPSwStr(pswh84, 1) .. ";" .. qmovha:GenPSwStr(pswh74, 1))

---- ENG1 Test
qmovha:CfgCmd(85, "a320/Overhead/FireEngine1_Test_button")
---- APU Test
qmovha:CfgCmd(86, "a320/Overhead/FireAPU_Test_button")
---- ENG2 Test
qmovha:CfgCmd(87, "a320/Overhead/FireEngine2_Test_button")

-- ===========================================================
-- Read data

qmovha:GetStartUp('a320/Aircraft/Cockpit/Overhead/APU_StartAvail/Power')
qmovha:GetStartDn('a320/Aircraft/Cockpit/Overhead/APU_StartOn/Power')
qmovha:GetMswUp('a320/Aircraft/Cockpit/Overhead/APU_MasterFault/Power')
qmovha:GetMswDn('a320/Aircraft/Cockpit/Overhead/APU_MasterOn/Power')

qmovha:GetUpled2Gen1Up('a320/Aircraft/Cockpit/Overhead/ElecGen1_Fault/Power')
qmovha:GetUpled2Gen1Dn('a320/Aircraft/Cockpit/Overhead/ElecGen1_Off/Power')
qmovha:GetUpled2Bat1Up('a320/Aircraft/Cockpit/Overhead/ElecBat1_Fault/Power')
qmovha:GetUpled2Bat1Dn('a320/Aircraft/Cockpit/Overhead/ElecBat1_Off/Power')
qmovha:GetUpled2Bat2Up('a320/Aircraft/Cockpit/Overhead/ElecBat2_Fault/Power')
qmovha:GetUpled2Bat2Dn('a320/Aircraft/Cockpit/Overhead/ElecBat2_Off/Power')

qmovha:GetUpled2ExtUp('a320/Aircraft/Cockpit/Overhead/ElecAPU_ExtAvail/Power')
qmovha:GetUpled2ExtDn('a320/Aircraft/Cockpit/Overhead/ElecAPU_ExtOn/Power')

qmovha:GetUpled2Gen2Up('a320/Aircraft/Cockpit/Overhead/ElecGen2_Fault/Power')
qmovha:GetUpled2Gen2Dn('a320/Aircraft/Cockpit/Overhead/ElecGen2_Off/Power')

qmovha:GetEng2Up('a320/Aircraft/Cockpit/Overhead/HeatEngine2_Fault/Power')
qmovha:GetEng2Dn('a320/Aircraft/Cockpit/Overhead/HeatEngine2_On/Power')
qmovha:GetEng1Up('a320/Aircraft/Cockpit/Overhead/HeatEngine1_Fault/Power')
qmovha:GetEng1Dn('a320/Aircraft/Cockpit/Overhead/HeatEngine1_On/Power')
qmovha:GetWingUp('a320/Aircraft/Cockpit/Overhead/HeatWingFault/Power')
qmovha:GetWingDn('a320/Aircraft/Cockpit/Overhead/HeatWingOn/Power')

qmovha:GetPack1Up('a320/Aircraft/Cockpit/Overhead/AirPack1_Fault/Power')
qmovha:GetPack1Dn('a320/Aircraft/Cockpit/Overhead/AirPack1_Off/Power')
qmovha:GetApubUp('a320/Aircraft/Cockpit/Overhead/AirBleedAuxFault/Power')
qmovha:GetApubDn('a320/Aircraft/Cockpit/Overhead/AirBleedAuxOn/Power')
qmovha:GetPack2Up('a320/Aircraft/Cockpit/Overhead/AirPack2_Fault/Power')
qmovha:GetPack2Dn('a320/Aircraft/Cockpit/Overhead/AirPack2_Off/Power')

qmovha:GetCrew('a320/Aircraft/Cockpit/Overhead/OxygenCrewOff/Power')
qmovha:GetUpled1Gndctl('a320/Aircraft/Cockpit/Overhead/OxygenTmrRstOn/Power')

qmovha:GetUpled1TerrUp('a320/Aircraft/Cockpit/Overhead/GPWS_TerrFault/Power')
qmovha:GetUpled1TerrDn('a320/Aircraft/Cockpit/Overhead/GPWS_TerrOff/Power')
qmovha:GetUpled1SysUp('a320/Aircraft/Cockpit/Overhead/GPWS_SystemFault/Power')
qmovha:GetUpled1SysDn('a320/Aircraft/Cockpit/Overhead/GPWS_SystemOff/Power')
qmovha:GetUpled1Flap3('a320/Aircraft/Cockpit/Overhead/GPWS_Flaps3On/Power')

qmovha:GetUpled1Adr1Up('a320/Aircraft/Cockpit/Overhead/CDU_ADR1_Fault/Power')
qmovha:GetUpled1Adr1Dn('a320/Aircraft/Cockpit/Overhead/CDU_ADR1_Off/Power')
qmovha:GetUpled1Adr3Up('a320/Aircraft/Cockpit/Overhead/CDU_ADR3_Fault/Power')
qmovha:GetUpled1Adr3Dn('a320/Aircraft/Cockpit/Overhead/CDU_ADR3_Off/Power')
qmovha:GetUpled1Adr2Up('a320/Aircraft/Cockpit/Overhead/CDU_ADR2_Fault/Power')
qmovha:GetUpled1Adr2Dn('a320/Aircraft/Cockpit/Overhead/CDU_ADR2_Off/Power')
qmovha:GetUpled1Onbat('a320/Aircraft/Cockpit/Overhead/CDU_OnBatLight/Power')

qmovha:GetUpled1Ltk1Up('a320/Aircraft/Cockpit/Overhead/FuelPump1_Fault/Power')
qmovha:GetUpled1Ltk1Dn('a320/Aircraft/Cockpit/Overhead/FuelPump1_Off/Power')
qmovha:GetUpled1Ltk2Up('a320/Aircraft/Cockpit/Overhead/FuelPump2_Fault/Power')
qmovha:GetUpled1Ltk2Dn('a320/Aircraft/Cockpit/Overhead/FuelPump2_Off/Power')
qmovha:GetUpled1CtklUp('a320/Aircraft/Cockpit/Overhead/FuelPump5_Fault/Power')
qmovha:GetUpled1CtklDn('a320/Aircraft/Cockpit/Overhead/FuelPump5_Off/Power')
qmovha:GetUpled1CtkrUp('a320/Aircraft/Cockpit/Overhead/FuelPump6_Fault/Power')
qmovha:GetUpled1CtkrDn('a320/Aircraft/Cockpit/Overhead/FuelPump6_Off/Power')
qmovha:GetUpled2Rtk1Up('a320/Aircraft/Cockpit/Overhead/FuelPump3_Fault/Power')
qmovha:GetUpled2Rtk1Dn('a320/Aircraft/Cockpit/Overhead/FuelPump3_Off/Power')
qmovha:GetUpled2Rtk2Up('a320/Aircraft/Cockpit/Overhead/FuelPump4_Fault/Power')
qmovha:GetUpled2Rtk2Dn('a320/Aircraft/Cockpit/Overhead/FuelPump4_Off/Power')
qmovha:GetUpled2XfeedUp('a320/Aircraft/Cockpit/Overhead/FuelXFeedOpen/Power')
qmovha:GetUpled2XfeedDn('a320/Aircraft/Cockpit/Overhead/FuelXFeedOn/Power')

qmovha:GetUpled1Fire2('a320/Aircraft/Cockpit/Overhead/FireEngine2_LightA/Power')
qmovha:GetUpled1Firea('a320/Aircraft/Cockpit/Overhead/FireAPU_LightA/Power')
qmovha:GetUpled1Fire1('a320/Aircraft/Cockpit/Overhead/FireEngine1_LightA/Power')
qmovha:GetUpled2Eng1ag1('a320/Aircraft/Cockpit/Overhead/FireEngine1_AgentSquib1/Power')
qmovha:GetUpled2Eng1ag2('a320/Aircraft/Cockpit/Overhead/FireEngine1_AgentDisch1/Power')
qmovha:GetUpled2Eng2ag1('a320/Aircraft/Cockpit/Overhead/FireEngine2_AgentSquib1/Power')
qmovha:GetUpled2Eng2ag2('a320/Aircraft/Cockpit/Overhead/FireEngine2_AgentDisch1/Power')

qmovha:GetBkl('a320/Aircraft/Cockpit/Overhead/LightOverhead/Position', 100) -- 0~1

-- DONT use this name "Qmovha_ff320_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_ff320_loop()
    qmovha:SetDnled()
    qmovha:SetUpled1()
    qmovha:SetUpled2()

    qmovha:SetBkl()
end

uluaAddDoLoop("Qmovha_ff320_loop()")
