-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-09-07
-- *****************************************************************
-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for General aircrafts")

-- ===========================================================
-- button binding
-- Strobe
qmovha:CfgCmd(0, "sim/lights/strobe_lights_on")
qmovha:CfgCmd(41, "sim/lights/strobe_lights_on")
qmovha:CfgCmd(1, "sim/lights/strobe_lights_off")

-- beacon  lights
qmovha:CfgCmd(2, "sim/lights/beacon_lights_on", "sim/lights/beacon_lights_off")

-- Wing lights
qmovha:CfgCmd(3, "sim/lights/strobe_lights_on", "sim/lights/strobe_lights_off")

-- NAV lights
qmovha:CfgCmd(4, "sim/lights/nav_lights_on")
qmovha:CfgCmd(42, "sim/lights/nav_lights_on")
qmovha:CfgCmd(5, "sim/lights/nav_lights_off")

-- Taxi lights
qmovha:CfgCmd(6, "sim/lights/taxi_lights_on")
qmovha:CfgCmd(45, "sim/lights/taxi_lights_on")
qmovha:CfgCmd(7, "sim/lights/taxi_lights_off")

-- R Landing lights
qmovha:CfgCmd(8, "sim/lights/landing_02_light_on")
qmovha:CfgCmd(44, "sim/lights/landing_02_light_off")
qmovha:CfgCmd(9, "sim/lights/landing_02_light_off")
-- L Landing lights
qmovha:CfgCmd(10, "sim/lights/landing_01_light_on")
qmovha:CfgCmd(43, "sim/lights/landing_01_light_off")
qmovha:CfgCmd(11, "sim/lights/landing_01_light_off")

-- OVHD INTEG LT
qmovha:CfgEncFull(17, 16, "sim/cockpit/electrical/instrument_brightness", 0.05, 0.05, 1, 0.05, 1.0)

-- APU Start
qmovha:CfgValT(30, "sim/cockpit2/electrical/cross_tie")
-- APU Master
qmovha:CfgCmd(31, "sim/systems/avionics_toggle")

-- BAT 1&2
---- GEN1
qmovha:CfgValT(58, "sim/cockpit2/electrical/generator_on[0]")
---- BAT1
qmovha:CfgValT(59, "sim/cockpit/electrical/battery_on")
---- BAT2
qmovha:CfgValT(60, "sim/cockpit/electrical/battery_on")
---- GEN2
qmovha:CfgValT(62, "sim/cockpit2/electrical/generator_on[1]")


-- FUEL
qmovha:CfgValT(54, "sim/cockpit2/engine/actuators/fuel_pump_on[0]")
qmovha:CfgValT(68, "sim/cockpit2/engine/actuators/fuel_pump_on[1]")

qmovha:CfgValT(67, "sim/cockpit2/engine/actuators/fuel_pump_on[2]")
qmovha:CfgValT(65, "sim/cockpit2/engine/actuators/fuel_pump_on[3]")

qmovha:CfgValT(64, "sim/cockpit2/engine/actuators/fuel_pump_on[4]")
qmovha:CfgValT(63, "sim/cockpit2/engine/actuators/fuel_pump_on[5]")

qmovha:CfgValT(66, "sim/cockpit2/engine/actuators/fuel_pump_on[7]")


-- ===========================================================
-- Read data

qmovha:GetStartUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetStartDn('sim/cockpit2/electrical/cross_tie')
qmovha:GetMswUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetMswDn('sim/cockpit/electrical/avionics_on')

qmovha:GetUpled2Gen1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Gen1Dn('sim/cockpit/electrical/generator_on[0]', true)
qmovha:GetUpled2Bat1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Bat1Dn('sim/cockpit/electrical/battery_on', true)
qmovha:GetUpled2Bat2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Bat2Dn('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled2ExtUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2ExtDn('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled2Gen2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Gen2Dn('sim/cockpit/electrical/generator_on[1]', true)

qmovha:GetEng2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetEng2Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetEng1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetEng1Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetWingUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetWingDn('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetPack1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetPack1Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetApubUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetApubDn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetPack2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetPack2Dn('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetCrew('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Gndctl('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled1TerrUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1TerrDn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1SysUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1SysDn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Flap3('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled1Adr1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr1Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr3Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr3Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr2Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Onbat('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled1Ltk1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Ltk1Dn('sim/cockpit/engine/fuel_pump_on[0]', true)
qmovha:GetUpled1Ltk2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Ltk2Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtklUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtklDn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtkrUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtkrDn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk1Dn('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk2Dn('sim/cockpit/engine/fuel_pump_on[1]', true)
qmovha:GetUpled2XfeedUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2XfeedDn('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetUpled1Fire2('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Firea('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Fire1('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Eng1ag1('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Eng1ag2('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Eng2ag1('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Eng2ag2('sim/cockpit2/annunciators/electric_trim_off')

qmovha:GetBkl('sim/cockpit/electrical/instrument_brightness', 100) -- 0~1

-- DONT use this name "Qmovha_XP_GA_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_XP_GA_loop()
    qmovha:SetDnled()
    qmovha:SetUpled1()
    qmovha:SetUpled2()

    qmovha:SetBkl()
end

uluaAddDoLoop("Qmovha_XP_GA_loop()")
