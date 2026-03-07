-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-08-26
-- *****************************************************************
if ilua_is_acftitle_excluded("A3") or ilua_is_acfpath_excluded("toliss") then
    if ilua_is_acftitle_excluded("A2") or ilua_is_acfpath_excluded("toliss") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for Toliss")
-- A330
local isINIA330 = false
if not ilua_is_acftitle_excluded("A33") then
    isINIA330 = true
    uluaLog("- QMPE Toliss A33X")
elseif not ilua_is_acftitle_excluded("A34") then
    isINIA330 = true
    uluaLog("- QMPE Toliss A34X")
end

-- ===========================================================
-- button binding
-- POS/Strobe
qmovha:CfgVal(0, "AirbusFBW/OHPLightSwitches[7]", 2, 1)
qmovha:CfgVal(1, "AirbusFBW/OHPLightSwitches[7]", 0, 1)

-- BEACON lights
qmovha:CfgVal(2, "AirbusFBW/OHPLightSwitches[0]", 1, 0)

-- Wing lights
qmovha:CfgVal(3, "AirbusFBW/OHPLightSwitches[1]", 1, 0)

-- Logo lights
qmovha:CfgVal(4, "AirbusFBW/OHPLightSwitches[2]", 2, 1)
qmovha:CfgVal(5, "AirbusFBW/OHPLightSwitches[2]", 0, 1)

-- Taxi lights
qmovha:CfgVal(6, "AirbusFBW/OHPLightSwitches[3]", 2, 1)
qmovha:CfgVal(7, "AirbusFBW/OHPLightSwitches[3]", 0, 1)

-- R Landing lights
if isINIA330 then
    qmovha:CfgVal(8, "AirbusFBW/OHPLightSwitches[4]", 1, 1)
    qmovha:CfgVal(9, "AirbusFBW/OHPLightSwitches[4]", 0, 1)
else
    qmovha:CfgVal(8, "AirbusFBW/OHPLightSwitches[5]", 2, 1)
    qmovha:CfgVal(9, "AirbusFBW/OHPLightSwitches[5]", 0, 1)
end

-- L Landing lights
if not isINIA330 then
    qmovha:CfgVal(10, "AirbusFBW/OHPLightSwitches[4]", 2, 1)
    qmovha:CfgVal(11, "AirbusFBW/OHPLightSwitches[4]", 0, 1)
end

-- Runway Turn Off lights
qmovha:CfgVal(12, "AirbusFBW/OHPLightSwitches[6]", 1, 0)

-- OVHD INTEG LT
if isINIA330 then
    qmovha:CfgEncFull(17, 16, "AirbusFBW/PanelBrightnessLevel", 0.0185, 0.0185, 1, 0, 1.0)
else
    qmovha:CfgEncFull(17, 16, "AirbusFBW/OHPBrightnessLevel", 0.05, 0.05, 1, 0.05, 1.0)
end

-- SEAT BELTS
if isINIA330 then
    qmovha:CfgVal(13, "AirbusFBW/OHPLightSwitches[11]", 2, 0)
else
    qmovha:CfgVal(13, "AirbusFBW/OHPLightSwitches[11]", 1, 0)
end
-- NO SMOKING
qmovha:CfgVal(14, "AirbusFBW/OHPLightSwitches[12]", 2, 1)
qmovha:CfgVal(15, "AirbusFBW/OHPLightSwitches[12]", 0, 1)

-- DOME
if isINIA330 then
    local dr_dome_storm = iDataRef:New("AirbusFBW/OHPLightSwitches[8]")
    local dr_dome_ctl = iDataRef:New("AirbusFBW/OHPLightSwitches[13]")
    local dr_dome_brighness = iDataRef:New("sim/cockpit2/switches/panel_brightness_ratio[0]")

    _G.qmovha_toliss_a3_dome = function(onoff)
        dr_dome_storm:Set(onoff)
    end
    _G.qmovha_toliss_a3_dome_onoff = function(onoff)
        local onoffexpect = onoff > 0 and 1 or 0
        local onoffsts = dr_dome_brighness:Get() > 0 and 1 or 0
        local revsts = dr_dome_ctl:Get() > 0 and 0 or 1
        if onoffexpect ~= onoffsts then
            dr_dome_ctl:Set(revsts)
            uluasetTimeout("qmovha_toliss_a3_dome_onoff(" .. tostring(onoff) .. ")", 500)
        end
    end
    qmovha:CfgFc(18, "qmovha_toliss_a3_dome(2);qmovha_toliss_a3_dome_onoff(2)",
        "qmovha_toliss_a3_dome(1);qmovha_toliss_a3_dome_onoff(1)")
    qmovha:CfgFc(19, "qmovha_toliss_a3_dome(0);qmovha_toliss_a3_dome_onoff(0)",
        "qmovha_toliss_a3_dome(1);qmovha_toliss_a3_dome_onoff(1)")
else
    qmovha:CfgVal(18, "AirbusFBW/OHPLightSwitches[8]", 2, 1)
    qmovha:CfgVal(19, "AirbusFBW/OHPLightSwitches[8]", 0, 1)
end

-- ANN LT
qmovha:CfgVal(20, "AirbusFBW/AnnunMode", 2, 1)
qmovha:CfgVal(21, "AirbusFBW/AnnunMode", 0, 1)

-- EMER EXIT LT
qmovha:CfgVal(22, "AirbusFBW/OHPLightSwitches[10]", 2, 1)
qmovha:CfgVal(23, "AirbusFBW/OHPLightSwitches[10]", 0, 1)

-- APU
qmovha:CfgCmd(30, "toliss_airbus/apucommands/StarterToggle")
qmovha:CfgCmd(31, "toliss_airbus/apucommands/MasterToggle")

-- ANTI ICE
qmovha:CfgCmd(32, "toliss_airbus/antiicecommands/ENG2Toggle")
qmovha:CfgCmd(33, "toliss_airbus/antiicecommands/ENG1Toggle")
qmovha:CfgCmd(37, "toliss_airbus/antiicecommands/WingToggle")

-- AIR COND
qmovha:CfgCmd(34, "toliss_airbus/aircondcommands/Pack1Toggle")
qmovha:CfgCmd(35, "toliss_airbus/apucommands/BleedToggle")
qmovha:CfgCmd(36, "toliss_airbus/aircondcommands/Pack2Toggle")

qmovha:CfgVal(27, "AirbusFBW/XBleedSwitch", 0, nil)
qmovha:CfgVal(28, "AirbusFBW/XBleedSwitch", 1, nil)
qmovha:CfgVal(29, "AirbusFBW/XBleedSwitch", 2, nil)

-- WIPER
qmovha:CfgVal(24, "AirbusFBW/LeftWiperSwitch", 0, nil)
qmovha:CfgVal(25, "AirbusFBW/LeftWiperSwitch", 1, nil)
qmovha:CfgVal(26, "AirbusFBW/LeftWiperSwitch", 2, nil)

local wiper_r_dr = iDataRef:New("AirbusFBW/RightWiperSwitch")
_G.qmovha_toliss_a3_right_wiper = function(idx)
    uluaLog(string.format("Right Wiper %d", idx))
    wiper_r_dr:Set(idx)
end
qmovha:CfgFc(24, "qmovha_toliss_a3_right_wiper(0)")
qmovha:CfgFc(25, "qmovha_toliss_a3_right_wiper(1)")
qmovha:CfgFc(26, "qmovha_toliss_a3_right_wiper(2)")

-- OXYGEN
qmovha:CfgValT(38, "AirbusFBW/CrewOxySwitch")
-- CALLS
qmovha:CfgCmd(40, "AirbusFBW/purser/fwd")

-- GPWS
qmovha:CfgValT(50, "AirbusFBW/GPWSSwitchArray[4]")
qmovha:CfgValT(51, "AirbusFBW/GPWSSwitchArray[0]")
qmovha:CfgValT(52, "AirbusFBW/GPWSSwitchArray[3]")

-- GND CTL CVR
qmovha:CfgValT(53, "AirbusFBW/CvrGndCtrl")

-- ADIRS 2,3,1
qmovha:CfgValT(55, "AirbusFBW/ADRSwitchArray[1]")
qmovha:CfgValT(56, "AirbusFBW/ADRSwitchArray[2]")
qmovha:CfgValT(57, "AirbusFBW/ADRSwitchArray[0]")

qmovha:CfgVal(73, "AirbusFBW/ADIRUSwitchArray[0]", 0, nil)
qmovha:CfgVal(74, "AirbusFBW/ADIRUSwitchArray[0]", 1, nil)
qmovha:CfgVal(75, "AirbusFBW/ADIRUSwitchArray[0]", 2, nil)

qmovha:CfgVal(79, "AirbusFBW/ADIRUSwitchArray[2]", 0, nil)
qmovha:CfgVal(80, "AirbusFBW/ADIRUSwitchArray[2]", 1, nil)
qmovha:CfgVal(81, "AirbusFBW/ADIRUSwitchArray[2]", 2, nil)

qmovha:CfgVal(76, "AirbusFBW/ADIRUSwitchArray[1]", 0, nil)
qmovha:CfgVal(77, "AirbusFBW/ADIRUSwitchArray[1]", 1, nil)
qmovha:CfgVal(78, "AirbusFBW/ADIRUSwitchArray[1]", 2, nil)

-- BAT 1&2
qmovha:CfgValT(58, "AirbusFBW/ElecOHPArray[0]")
qmovha:CfgCmd(59, "toliss_airbus/eleccommands/Bat1Toggle")
qmovha:CfgCmd(60, "toliss_airbus/eleccommands/Bat2Toggle")
if isINIA330 then
    local batt_apu_dr = iDataRef:New("AirbusFBW/ElecOHPArray[16]")
    local batt_2_dr = iDataRef:New("AirbusFBW/ElecOHPArray[6]")

    _G.qmovha_toliss_a33_toggle_batt_apu = function()
        local d_batt_2 = batt_2_dr:Get()
        uluaLog(string.format("a330_batt_2 %d", d_batt_2))
        batt_apu_dr:Set(1 - d_batt_2)
    end
    qmovha:CfgFc(60, "qmovha_toliss_a33_toggle_batt_apu()")
end

qmovha:CfgValT(62, "AirbusFBW/ElecOHPArray[1]")

-- EXT PWR
if not isINIA330 then
    qmovha:CfgCmd(61, "toliss_airbus/eleccommands/ExtPowToggle")
else
    local ext_b_cmd = uluaFind("toliss_airbus/eleccommands/ExtPowBToggle")
    function qmovha_toliss_a3_ext_b()
        uluaLog("ext B")
        uluaCmdOnce(ext_b_cmd)
    end

    qmovha:CfgFc(61, "qmovha_toliss_a3_ext_b()")
    qmovha:CfgCmd(61, "toliss_airbus/eleccommands/ExtPowAToggle", "sim/none/none")
end
-- FUEL
qmovha:CfgValT(54, "AirbusFBW/FuelOHPArray[0]")
qmovha:CfgValT(68, "AirbusFBW/FuelOHPArray[1]")

qmovha:CfgValT(67, "AirbusFBW/FuelOHPArray[2]")
qmovha:CfgValT(65, "AirbusFBW/FuelOHPArray[3]")

qmovha:CfgValT(64, "AirbusFBW/FuelOHPArray[4]")
qmovha:CfgValT(63, "AirbusFBW/FuelOHPArray[5]")

qmovha:CfgValT(66, "AirbusFBW/FuelOHPArray[7]")

-- FIRE
qmovha:CfgCmd(69, "AirbusFBW/EngFireProt/Eng2Agent2Push")
qmovha:CfgCmd(70, "AirbusFBW/EngFireProt/Eng2Agent1Push")
qmovha:CfgCmd(71, "AirbusFBW/EngFireProt/Eng1Agent2Push")
qmovha:CfgCmd(72, "AirbusFBW/EngFireProt/Eng1Agent1Push")

qmovha:CfgVal(82, "AirbusFBW/ENGFireSwitchArray[0]", 1, 0)
qmovha:CfgVal(83, "AirbusFBW/FireExOHPArray[0]", 1, 0)
qmovha:CfgVal(84, "AirbusFBW/ENGFireSwitchArray[1]", 1, 0)

qmovha:CfgCmd(85, "AirbusFBW/FireTestENG1")
qmovha:CfgCmd(86, "AirbusFBW/FireTestAPU")
qmovha:CfgCmd(87, "AirbusFBW/FireTestENG2")

-- ===========================================================
-- Read data

qmovha:GetStartUp('AirbusFBW/OHPLightsATA49[3]')
qmovha:GetStartDn('AirbusFBW/OHPLightsATA49[2]')
qmovha:GetMswUp('AirbusFBW/OHPLightsATA49[1]')
qmovha:GetMswDn('AirbusFBW/OHPLightsATA49[0]')
qmovha:GetUpled2Gen1Up('AirbusFBW/OHPLightsATA24[1]')
qmovha:GetUpled2Gen1Dn('AirbusFBW/OHPLightsATA24[0]')
qmovha:GetUpled2Bat1Up('AirbusFBW/OHPLightsATA24[10]')
qmovha:GetUpled2Bat1Dn('AirbusFBW/OHPLightsATA24[9]')
qmovha:GetUpled2Bat2Up('AirbusFBW/OHPLightsATA24[12]')
qmovha:GetUpled2Bat2Dn('AirbusFBW/OHPLightsATA24[11]')
if not isINIA330 then
    qmovha:GetUpled2ExtUp('AirbusFBW/OHPLightsATA24[7]')
    qmovha:GetUpled2ExtDn('AirbusFBW/OHPLightsATA24[6]')
else
    qmovha:GetUpled2ExtUp('AirbusFBW/OHPLightsATA24[30]')
    qmovha:GetUpled2ExtDn('AirbusFBW/OHPLightsATA24[29]')
end
qmovha:GetUpled2Gen2Up('AirbusFBW/OHPLightsATA24[3]')
qmovha:GetUpled2Gen2Dn('AirbusFBW/OHPLightsATA24[2]')

qmovha:GetEng2Up('AirbusFBW/OHPLightsATA30[5]')
qmovha:GetEng2Dn('AirbusFBW/OHPLightsATA30[4]')
qmovha:GetEng1Up('AirbusFBW/OHPLightsATA30[3]')
qmovha:GetEng1Dn('AirbusFBW/OHPLightsATA30[2]')
qmovha:GetWingUp('AirbusFBW/OHPLightsATA30[1]')
qmovha:GetWingDn('AirbusFBW/OHPLightsATA30[0]')

qmovha:GetPack1Up('AirbusFBW/OHPLightsATA21[7]')
qmovha:GetPack1Dn('AirbusFBW/OHPLightsATA21[6]')
qmovha:GetApubUp('AirbusFBW/OHPLightsATA21[5]')
qmovha:GetApubDn('AirbusFBW/OHPLightsATA21[4]')
qmovha:GetPack2Up('AirbusFBW/OHPLightsATA21[9]')
qmovha:GetPack2Dn('AirbusFBW/OHPLightsATA21[8]')

qmovha:GetCrew('AirbusFBW/OHPLightsATA35[1]')
qmovha:GetUpled1Gndctl('AirbusFBW/OHPLightsATA31[15]')

qmovha:GetUpled1TerrUp('AirbusFBW/OHPLightsATA34[27]')
qmovha:GetUpled1TerrDn('AirbusFBW/OHPLightsATA34[26]')
qmovha:GetUpled1SysUp('AirbusFBW/OHPLightsATA34[14]')
qmovha:GetUpled1SysDn('AirbusFBW/OHPLightsATA34[13]')
qmovha:GetUpled1Flap3('AirbusFBW/OHPLightsATA34[17]')

qmovha:GetUpled1Adr1Up('AirbusFBW/OHPLightsATA34[1]')
qmovha:GetUpled1Adr1Dn('AirbusFBW/OHPLightsATA34[0]')
qmovha:GetUpled1Adr3Up('AirbusFBW/OHPLightsATA34[5]')
qmovha:GetUpled1Adr3Dn('AirbusFBW/OHPLightsATA34[4]')
qmovha:GetUpled1Adr2Up('AirbusFBW/OHPLightsATA34[3]')
qmovha:GetUpled1Adr2Dn('AirbusFBW/OHPLightsATA34[2]')
qmovha:GetUpled1Onbat('AirbusFBW/OHPLightsATA34[12]')

qmovha:GetUpled1Ltk1Up('AirbusFBW/OHPLightsATA28[1]')
qmovha:GetUpled1Ltk1Dn('AirbusFBW/OHPLightsATA28[0]')
qmovha:GetUpled1Ltk2Up('AirbusFBW/OHPLightsATA28[3]')
qmovha:GetUpled1Ltk2Dn('AirbusFBW/OHPLightsATA28[2]')
qmovha:GetUpled1CtklUp('AirbusFBW/OHPLightsATA28[5]')
qmovha:GetUpled1CtklDn('AirbusFBW/OHPLightsATA28[4]')
qmovha:GetUpled1CtkrUp('AirbusFBW/OHPLightsATA28[7]')
qmovha:GetUpled1CtkrDn('AirbusFBW/OHPLightsATA28[6]')
qmovha:GetUpled2Rtk1Up('AirbusFBW/OHPLightsATA28[9]')
qmovha:GetUpled2Rtk1Dn('AirbusFBW/OHPLightsATA28[8]')
qmovha:GetUpled2Rtk2Up('AirbusFBW/OHPLightsATA28[11]')
qmovha:GetUpled2Rtk2Dn('AirbusFBW/OHPLightsATA28[10]')
qmovha:GetUpled2XfeedUp('AirbusFBW/OHPLightsATA28[15]')
qmovha:GetUpled2XfeedDn('AirbusFBW/OHPLightsATA28[14]')

qmovha:GetUpled1Fire2('AirbusFBW/OHPLightsATA70[13]')
qmovha:GetUpled1Firea('AirbusFBW/OHPLightsATA26[20]')
qmovha:GetUpled1Fire1('AirbusFBW/OHPLightsATA70[11]')
qmovha:GetUpled2Eng1ag1('AirbusFBW/OHPLightsATA26[2]')
qmovha:GetUpled2Eng1ag2('AirbusFBW/OHPLightsATA26[4]')
qmovha:GetUpled2Eng2ag1('AirbusFBW/OHPLightsATA26[7]')
qmovha:GetUpled2Eng2ag2('AirbusFBW/OHPLightsATA26[9]')

if isINIA330 then
    qmovha:GetBkl("AirbusFBW/PanelBrightnessLevel", 100)
else
    qmovha:GetBkl('AirbusFBW/OHPBrightnessLevel', 100) -- 0~1
end

qmovha:GetBrtDim("AirbusFBW/AnnunMode", 1)                                -- 0: DIM 1: BRT 2: test mode
qmovha:GetAirCond("AirbusFBW/Pack1FCVInd", "AirbusFBW/CockpitTemp", 1, 2) --0~1, 16~28
local dr_test = iDataRef:New("AirbusFBW/AnnunMode")                       -- 0: DIM 1: BRT 2: test mode
local dr_ac_bus = iDataRef:New("sim/cockpit2/radios/actuators/com2_power")

-- DONT use this name "Qmovha_Toliss_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_Toliss_loop()
    -- expert code: test mode
    local b_ac_bus = dr_ac_bus:Get()

    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 0 then
            -- DIM
            uluaSet(idr_qmovh_a_hid_dim_brtdim, 1)
            uluaSet(idr_qmovh_a_hid_mode_off, 0)
        elseif b_test == 2 then
            -- BRT
            uluaSet(idr_qmovh_a_hid_dim_brtdim, 0)
        end
    end

    qmovha:SetDnled()
    qmovha:SetUpled1()
    qmovha:SetUpled2()

    if b_ac_bus == 1 then
        qmovha:SetBkl()
        qmovha:SetBrtDim()
        qmovha:FreshBkl()
        qmovha:SetAirCond()
    else
        qmovha:SetBkl(0)
    end
end

uluaAddDoLoop("Qmovha_Toliss_loop()")
