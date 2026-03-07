-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-09-30
-- *****************************************************************
if PLANE_ICAO ~= "A333" then
    return
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for X-Plane Default A333")

local qmovha_new_xp = false
if uluaFind("laminar/A333/adirs/on_bat_status") ~= nil then
    qmovha_new_xp = true
end
-- ===========================================================
-- button binding
-- Strobe
local pswh0 = QmdevPosSwitchInit("laminar/a333/switches/strobe_pos", 1, "laminar/A333/toggle_switch/strobe_pos_up",
    "laminar/A333/toggle_switch/strobe_pos_dn")
qmovha:CfgPSw(0, pswh0, 2)
qmovha:CfgPSw(41, pswh0, 1)
qmovha:CfgPSw(1, pswh0, 0)

-- beacon  lights
qmovha:CfgCmd(2, "sim/lights/beacon_lights_on", "sim/lights/beacon_lights_off")

-- Wing lights
qmovha:CfgVal(3, "sim/cockpit2/switches/generic_lights_switch[1]", 1, 0)

-- NAV lights
local pswh4 = QmdevPosSwitchInit("laminar/a333/switches/nav_pos", 1, "laminar/A333/toggle_switch/nav_light_pos_up",
    "laminar/A333/toggle_switch/nav_light_pos_dn")
qmovha:CfgPSw(4, pswh4, 2)
qmovha:CfgPSw(42, pswh4, 1)
qmovha:CfgPSw(5, pswh4, 0)

-- Taxi lights
local pswh6 = QmdevPosSwitchInit("sim/cockpit2/switches/landing_lights_switch[1]", 0.5, "laminar/A333/switch/lighting/taxi_light_up",
    "laminar/A333/switch/lighting/taxi_light_dn")
qmovha:CfgPSw(6, pswh6, 1)
qmovha:CfgPSw(45, 6, 0.5)
qmovha:CfgPSw(7, pswh6, 0)

-- R Landing lights
qmovha:CfgVal(8, "sim/cockpit2/switches/landing_lights_on", 1)
qmovha:CfgVal(44, "sim/cockpit2/switches/landing_lights_on", 0)
qmovha:CfgVal(9, "sim/cockpit2/switches/landing_lights_on", 0)
-- L Landing lights
qmovha:CfgCmd(10, "sim/lights/landing_01_light_on")
qmovha:CfgCmd(43, "sim/lights/landing_01_light_off")
qmovha:CfgCmd(11, "sim/lights/landing_01_light_off")

-- Runway Turn Off lights
qmovha:CfgVal(12, "sim/cockpit2/switches/generic_lights_switch[0]", 1, 0)

-- OVHD INTEG LT
qmovha:CfgEncFull(17, 16, "laminar/a333/rheostats/integ_light_brightness", 0.025, 0.025, 1, 0, 1.0)

-- SEAT BELTS
local pswh13 = QmdevPosSwitchInit("laminar/A333/switches/fasten_seatbelts", 1, "laminar/A333/switches/seatbelt_signs_up",
    "laminar/A333/switches/seatbelt_signs_dn", 500)
qmovha:CfgPSw(13, pswh13, 2, 0)

-- NO SMOKING
local pswh14 = QmdevPosSwitchInit("laminar/A333/switches/no_smoking", 1, "laminar/A333/switches/smoking_signs_up",
    "laminar/A333/switches/smoking_signs_dn", 500)
qmovha:CfgPSw(14, pswh14, 2)
qmovha:CfgPSw(48, pswh14, 1)
qmovha:CfgPSw(15, pswh14, 0)

-- DOME
local pswh17 = QmdevPosSwitchInit("laminar/a333/switches/dome_1_pos", 1, "laminar/A333/toggle_switch/dome_1_pos_up",
    "laminar/A333/toggle_switch/dome_1_pos_dn", 500)
local pswh18 = QmdevPosSwitchInit("laminar/a333/switches/dome_brightness", 1, "laminar/A333/toggle_switch/dome_bright_up",
    "laminar/A333/toggle_switch/dome_bright_dn", 500)
qmovha:CfgPSw(18, pswh18, 2)
qmovha:CfgFc(46, qmovha:GenPSwStr(pswh17, 1) .. ";" .. qmovha:GenPSwStr(pswh18, 1))
qmovha:CfgFc(19, qmovha:GenPSwStr(pswh17, 0) .. ";" .. qmovha:GenPSwStr(pswh18, 0))

-- ANN LT
local pswh20 = QmdevPosSwitchInit("laminar/a333/switches/ann_light_pos", 1, "laminar/A333/toggle_switch/ann_lt_up",
    "laminar/A333/toggle_switch/ann_lt_dn")
qmovha:CfgPSw(20, pswh20, 2)
qmovha:CfgPSw(47, pswh20, 1)
qmovha:CfgPSw(21, pswh20, 0)

-- EMER EXIT LT
local pswh22 = QmdevPosSwitchInit("laminar/a333/switches/emer_exit_lt_pos", 1, "laminar/A333/toggle_switch/emer_exit_lt_up",
    "laminar/A333/toggle_switch/emer_exit_lt_dn", 1000)
qmovha:CfgPSw(22, pswh22, 2)
qmovha:CfgPSw(49, pswh22, 1)
qmovha:CfgPSw(23, pswh22, 0)

-- APU Start
qmovha:CfgCmd(30, "laminar/A333/buttons/APU_start")

-- APU Master
qmovha:CfgCmd(31, "laminar/A333/buttons/APU_master")

-- ANTI ICE
qmovha:CfgCmd(32, "sim/ice/inlet_heat1_tog")
qmovha:CfgCmd(33, "sim/ice/inlet_heat0_tog")
qmovha:CfgCmd(37, "sim/ice/wing_heat_tog")

-- AIR COND
qmovha:CfgCmd(34, "sim/bleed_air/pack_left_toggle")
qmovha:CfgCmd(35, "sim/bleed_air/apu_toggle")
qmovha:CfgCmd(36, "sim/bleed_air/pack_right_toggle")

qmovha:CfgVal(27, "laminar/A333/ecam/bleed/crossbleed_valve_pos", 0, nil)
qmovha:CfgVal(28, "laminar/A333/ecam/bleed/crossbleed_valve_pos", 1, nil)
qmovha:CfgVal(29, "laminar/A333/ecam/bleed/crossbleed_valve_pos", 2, nil)

-- WIPER
qmovha:CfgVal(24, "sim/cockpit2/switches/wiper_speed_switch[0]", 0, nil)
qmovha:CfgVal(25, "sim/cockpit2/switches/wiper_speed_switch[0]", 2, nil)
qmovha:CfgVal(26, "sim/cockpit2/switches/wiper_speed_switch[0]", 3, nil)

local wiper_r_dr = iDataRef:New("sim/cockpit2/switches/wiper_speed_switch[1]")
_G.qmovha_xp_a333_right_wiper = function(idx)
    uluaLog(string.format("Right Wiper %d", idx))
    wiper_r_dr:Set(idx)
end
qmovha:CfgFc(24, "qmovha_xp_a333_right_wiper(0)")
qmovha:CfgFc(25, "qmovha_xp_a333_right_wiper(2)")
qmovha:CfgFc(26, "qmovha_xp_a333_right_wiper(3)")

-- OXYGEN
qmovha:CfgCmd(38, "laminar/A333/crew_supply_toggle")
-- CALLS
qmovha:CfgCmd(40, "laminar/A333/buttons/call/all_push")

-- GPWS
qmovha:CfgCmd(50, "laminar/A333/buttons/gpws/terr_toggle")
qmovha:CfgCmd(51, "laminar/A333/buttons/gpws/sys_toggle")
qmovha:CfgCmd(52, "laminar/A333/buttons/gpws/flap_mode_toggle")

-- GND CTL CVR
qmovha:CfgCmd(53, "laminar/A333/buttons/rcdr/ground_control_push")

-- ADIRS 2,3,1
qmovha:CfgCmd(55, "laminar/A333/buttons/adirs/adr2_toggle")
qmovha:CfgCmd(56, "laminar/A333/buttons/adirs/adr3_toggle")
qmovha:CfgCmd(57, "laminar/A333/buttons/adirs/adr1_toggle")

local pswh73 = QmdevPosSwitchInit("laminar/A333/buttons/adirs/ir1_knob_pos", 1, "laminar/A333/knobs/adirs/ir1_knob_right",
    "laminar/A333/knobs/adirs/ir1_knob_left")
qmovha:CfgPSw(73, pswh73, 0)
qmovha:CfgPSw(74, pswh73, 1)
qmovha:CfgPSw(75, pswh73, 2)

local pswh79 = QmdevPosSwitchInit("laminar/A333/buttons/adirs/ir3_knob_pos", 1, "laminar/A333/knobs/adirs/ir3_knob_right",
    "laminar/A333/knobs/adirs/ir3_knob_left")
qmovha:CfgPSw(79, pswh79, 0)
qmovha:CfgPSw(80, pswh79, 1)
qmovha:CfgPSw(81, pswh79, 2)

local pswh76 = QmdevPosSwitchInit("laminar/A333/buttons/adirs/ir2_knob_pos", 1, "laminar/A333/knobs/adirs/ir2_knob_right",
    "laminar/A333/knobs/adirs/ir2_knob_left")
qmovha:CfgPSw(76, pswh76, 0)
qmovha:CfgPSw(77, pswh76, 1)
qmovha:CfgPSw(78, pswh76, 2)

-- BAT 1&2
---- GEN1
qmovha:CfgCmd(58, "sim/electrical/generator_1_toggle")
---- BAT1
qmovha:CfgCmd(59, "sim/electrical/battery_1_toggle")
---- BAT2
qmovha:CfgCmd(60, "sim/electrical/battery_2_toggle")
local batt_apu_cmd = uluaFind("laminar/A333/buttons/APU_batt_toggle")
_G.qmovha_xp_a333_toggle_batt_apu = function()
    uluaCmdOnce(batt_apu_cmd)
end
qmovha:CfgFc(60, "qmovha_xp_a333_toggle_batt_apu()")

-- EXT PWR
local ext_b_cmd = uluaFind("laminar/A333/buttons/external_powerB_toggle")
function qmovha_xp_a333_ext_b()
    uluaLog("ext B begin")
    if uluaCmdBegin ~= nil then
        uluaCmdBegin(ext_b_cmd)
    end
end

function qmovha_xp_a333_ext_b_end()
    uluaLog("ext B end")
    if uluaCmdEnd ~= nil then
        uluaCmdEnd(ext_b_cmd)
    end
end

qmovha:CfgFc(61, "qmovha_xp_a333_ext_b()", "qmovha_xp_a333_ext_b_end()")
qmovha:CfgCmd(61, "laminar/A333/buttons/external_powerA_toggle")

---- GEN2
qmovha:CfgCmd(62, "sim/electrical/generator_2_toggle")


-- FUEL
qmovha:CfgCmd(54, "laminar/A333/switches/left1_pump_toggle")
qmovha:CfgCmd(68, "laminar/A333/switches/left2_pump_toggle")

qmovha:CfgCmd(67, "laminar/A333/switches/center_left_pump_toggle")
qmovha:CfgCmd(65, "laminar/A333/switches/center_right_pump_toggle")

qmovha:CfgCmd(64, "laminar/A333/switches/right2_pump_toggle")
qmovha:CfgCmd(63, "laminar/A333/switches/right1_pump_toggle")
-- X FEED
qmovha:CfgCmd(66, "laminar/A333/switches/wing_x_feed_toggle")

-- FIRE
qmovha:CfgCmd(69, "laminar/A333/fire/buttons/eng2_agent2_pos")
qmovha:CfgCmd(70, "laminar/A333/fire/buttons/eng2_agent1_pos")
qmovha:CfgCmd(71, "laminar/A333/fire/buttons/eng1_agent2_pos")
qmovha:CfgCmd(72, "laminar/A333/fire/buttons/eng1_agent1_pos")

qmovha:CfgVal(82, "laminar/A333/fire/switches/eng1_handle", 1, 0)
qmovha:CfgVal(83, "laminar/A333/fire/switches/apu_handle", 1, 0)
qmovha:CfgVal(84, "laminar/A333/fire/switches/eng2_handle", 1, 0)

qmovha:CfgCmd(85, "laminar/A333/fire/buttons/eng_fire_test_push")
qmovha:CfgCmd(86, "laminar/A333/fire/buttons/apu_fire_test_push")
qmovha:CfgCmd(87, "laminar/A333/fire/buttons/eng_fire_test_push")

-- ===========================================================
-- Read data

qmovha:GetStartUp('laminar/A333/annun/apu_avail')
qmovha:GetStartDn('laminar/A333/annun/apu_start_on')
qmovha:GetMswUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetMswDn('laminar/A333/annun/apu_master_on')

qmovha:GetUpled2Gen1Up('sim/cockpit2/annunciators/electric_trim_off')
if not qmovha_new_xp then
    qmovha:GetUpled2Gen1Dn('sim/cockpit2/annunciators/electric_trim_off')
else
    qmovha:GetUpled2Gen1Dn('laminar/A333/annun/elec/gen1_off_reset')
end
qmovha:GetUpled2Bat1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Bat1Dn('laminar/A333/annun/elec/bat1_off')
qmovha:GetUpled2Bat2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Bat2Dn('laminar/A333/annun/elec/bat2_off')

qmovha:GetUpled2ExtUp('laminar/A333/annun/elec/ext_a_avail')
qmovha:GetUpled2ExtDn('laminar/A333/annun/elec/ext_a_on')

qmovha:GetUpled2Gen2Up('sim/cockpit2/annunciators/electric_trim_off')
if not qmovha_new_xp then
    qmovha:GetUpled2Gen2Dn('sim/cockpit2/annunciators/electric_trim_off')
else
    qmovha:GetUpled2Gen2Dn('laminar/A333/annun/elec/gen2_off_reset')
end

qmovha:GetEng2Up('laminar/A333/annun/engine2_anti_ice_fault')
qmovha:GetEng2Dn('laminar/A333/annun/engine2_anti_ice')
qmovha:GetEng1Up('laminar/A333/annun/engine1_anti_ice_fault')
qmovha:GetEng1Dn('laminar/A333/annun/engine1_anti_ice')
qmovha:GetWingUp('laminar/A333/annun/wing_anti_ice_fault')
qmovha:GetWingDn('laminar/A333/annun/wing_anti_ice')

qmovha:GetPack1Up('laminar/A333/annun/eng1_bleed_fault')
qmovha:GetPack1Dn('laminar/A333/ecam/bleed/pack1_valve_pos', true)
qmovha:GetApubUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetApubDn('laminar/A333/annun/apu_bleed_on')
qmovha:GetPack2Up('laminar/A333/annun/eng2_bleed_fault')
qmovha:GetPack2Dn('laminar/A333/ecam/bleed/pack2_valve_pos', true)

qmovha:GetCrew('laminar/A333/annun/oxygen/crew_supply_off')

if not qmovha_new_xp then
    qmovha:GetUpled1Gndctl('sim/cockpit2/annunciators/electric_trim_off')
else
    qmovha:GetUpled1Gndctl('laminar/A333/annun/rcdr/gnd_ctl_on')
end

if not qmovha_new_xp then
    qmovha:GetUpled1TerrUp('sim/cockpit2/annunciators/electric_trim_off')
else
    qmovha:GetUpled1TerrUp('laminar/A333/annun/gpws_terr_fault')
end
qmovha:GetUpled1TerrDn('laminar/A333/buttons/gpws/terrain_toggle_pos', true)
if not qmovha_new_xp then
    qmovha:GetUpled1SysUp('sim/cockpit2/annunciators/electric_trim_off')
else
    qmovha:GetUpled1SysUp('laminar/A333/annun/gpws_sys_fault')
end
qmovha:GetUpled1SysDn('laminar/A333/buttons/gpws/system_toggle_pos', true)
qmovha:GetUpled1Flap3('laminar/A333/buttons/gpws/flap_toggle_pos', true)

qmovha:GetUpled1Adr1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr1Dn('laminar/A333/annun/adirs/adr1_off')
qmovha:GetUpled1Adr3Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr3Dn('laminar/A333/annun/adirs/adr3_off')
qmovha:GetUpled1Adr2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Adr2Dn('laminar/A333/annun/adirs/adr2_off')

if not qmovha_new_xp then
    qmovha:GetUpled1Onbat('sim/cockpit2/annunciators/electric_trim_off')
else
    -- X-Plane 12.40 is here
    qmovha:GetUpled1Onbat('laminar/A333/adirs/on_bat_status')
end

qmovha:GetUpled1Ltk1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Ltk1Dn('laminar/A333/ecam/fuel/pump_L1_enum', true)
qmovha:GetUpled1Ltk2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1Ltk2Dn('laminar/A333/ecam/fuel/pump_L2_enum', true)
qmovha:GetUpled1CtklUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtklDn('laminar/A333/fuel/buttons/center_left_pump_pos', true)
qmovha:GetUpled1CtkrUp('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled1CtkrDn('laminar/A333/fuel/buttons/center_right_pump_pos', true)
qmovha:GetUpled2Rtk1Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk1Dn('laminar/A333/ecam/fuel/pump_R2_enum', true)
qmovha:GetUpled2Rtk2Up('sim/cockpit2/annunciators/electric_trim_off')
qmovha:GetUpled2Rtk2Dn('laminar/A333/ecam/fuel/pump_R1_enum', true)
qmovha:GetUpled2XfeedUp('laminar/A333/annun/fuel/wing_x_feed_open')
qmovha:GetUpled2XfeedDn('laminar/A333/annun/fuel/wing_x_feed_on')

qmovha:GetUpled1Fire2('laminar/A333/annun/engine2_fire')
qmovha:GetUpled1Firea('laminar/A333/annun/fire/apu_handle')
qmovha:GetUpled1Fire1('laminar/A333/annun/engine1_fire')
qmovha:GetUpled2Eng1ag1('laminar/A333/annun/fire/eng1_agent1_squib')
qmovha:GetUpled2Eng1ag2('laminar/A333/annun/fire/eng1_agent2_squib')
qmovha:GetUpled2Eng2ag1('laminar/A333/annun/fire/eng2_agent1_squib')
qmovha:GetUpled2Eng2ag2('laminar/A333/annun/fire/eng2_agent2_squib')

qmovha:GetBkl('laminar/a333/rheostats/integ_light_brightness', 100)                                                  -- 0~1

qmovha:GetBrtDim("laminar/a333/switches/ann_light_pos", 1)                                                           -- 0: DIM 1: BRT 2: test mode
if not qmovha_new_xp then
    qmovha:GetAirCond("sim/cockpit2/radios/actuators/com2_power", "sim/cockpit2/radios/actuators/com2_power", 6, 22) -- -1~1, 16~28
else
    qmovha:GetAirCond("laminar/A333/pressurization/pack_flow1_ratio", "laminar/A333/knob/cockpit_temp", 6, 22)       -- -1~1, 16~28
end

local dr_test = iDataRef:New("laminar/a333/switches/ann_light_pos") -- 0: DIM 1: BRT 2: test mode
--
local dr_dc_bus
local dr_ac_bus
if not qmovha_new_xp then
    dr_ac_bus = iDataRef:New("sim/cockpit2/radios/actuators/com2_power") -- 0: OFF 1: ON
    dr_dc_bus = iDataRef:New("sim/cockpit2/radios/actuators/com2_power")
else
    dr_ac_bus = iDataRef:New("laminar/A333/elec/ac_bus1_has_power") -- 0: OFF 1: ON
    dr_dc_bus = iDataRef:New("laminar/A333/elec/dc_bat_bus_has_power")
end

-- DONT use this name "Qmovha_XP_A333_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_XP_A333_loop()
    local b_dc_bus = dr_dc_bus:Get()
    local b_ac_bus = dr_ac_bus:Get()
    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 2 then
            uluaSet(idr_qmovh_a_hid_mode_off, 0)
            uluaSet(idr_qmovh_a_hid_mode_test, 1)
        else
            uluaSet(idr_qmovh_a_hid_mode_test, 0)
        end
    end
    if b_test == 2 then
        -- TEST
        return
    end
    qmovha:SetUpled2ExtUp()
    qmovha:SetUpled2ExtDn()

    if dr_ac_bus:ChangedUpdate() and b_ac_bus == 1 or b_dc_bus == 1 then
        qmovha:FreshAllled()
        qmovha:FreshBkl()
    end

    if b_dc_bus == 1 then
        qmovha:SetDnled()
        qmovha:SetUpled1()
        qmovha:SetUpled2Rtk1Up()
        qmovha:SetUpled2Rtk1Dn()
        qmovha:SetUpled2Rtk2Up()
        qmovha:SetUpled2Rtk2Dn()
        qmovha:SetUpled2Gen1Up()
        qmovha:SetUpled2Gen1Dn()
        qmovha:SetUpled2XfeedUp()
        qmovha:SetUpled2XfeedDn()
        qmovha:SetUpled2Bat1Up()
        qmovha:SetUpled2Bat1Dn()
        qmovha:SetUpled2Bat2Up()
        qmovha:SetUpled2Bat2Dn()
        qmovha:SetUpled2Gen2Up()
        qmovha:SetUpled2Gen2Dn()
        qmovha:SetUpled2Eng1ag1()
        qmovha:SetUpled2Eng1ag2()
        qmovha:SetUpled2Eng2ag1()
        qmovha:SetUpled2Eng2ag2()

        qmovha:SetBkl()
        qmovha:SetBrtDim()
        qmovha:SetAirCond()
    else
        qmovha:SetDnled(0, 0)

        if b_ac_bus == 0 then
            qmovha:SetUpled1TerrUp(0, 0)
            qmovha:SetUpled1TerrDn(0, 0)
            qmovha:SetUpled1SysUp(0, 0)
            qmovha:SetUpled1SysDn(0, 0)
            qmovha:SetUpled1Flap3(0, 0)
            qmovha:SetUpled1Gndctl(0, 0)
            qmovha:SetUpled1Ltk1Up(0, 0)
            qmovha:SetUpled1Ltk1Dn(0, 0)
            qmovha:SetUpled1Adr1Up(0, 0)
            qmovha:SetUpled1Adr1Dn(0, 0)
            qmovha:SetUpled1Adr3Up(0, 0)
            qmovha:SetUpled1Adr3Dn(0, 0)
            qmovha:SetUpled1Adr2Up(0, 0)
            qmovha:SetUpled1Adr2Dn(0, 0)
            qmovha:SetUpled1Ltk2Up(0, 0)
            qmovha:SetUpled1Ltk2Dn(0, 0)
            qmovha:SetUpled1CtklUp(0, 0)
            qmovha:SetUpled1CtklDn(0, 0)
            qmovha:SetUpled1CtkrUp(0, 0)
            qmovha:SetUpled1CtkrDn(0, 0)
            qmovha:SetUpled1Fire2(0, 0)
            qmovha:SetUpled1Firea(0, 0)
            qmovha:SetUpled1Fire1(0, 0)
            qmovha:SetUpled1Onbat(0, 0)

            qmovha:SetUpled2Rtk1Up(0, 0)
            qmovha:SetUpled2Rtk1Dn(0, 0)
            qmovha:SetUpled2Rtk2Up(0, 0)
            qmovha:SetUpled2Rtk2Dn(0, 0)
            qmovha:SetUpled2Gen1Up(0, 0)
            qmovha:SetUpled2Gen1Dn(0, 0)
            qmovha:SetUpled2XfeedUp(0, 0)
            qmovha:SetUpled2XfeedDn(0, 0)

            qmovha:SetUpled2Bat1Up(0, 0)
            qmovha:SetUpled2Bat1Dn(0, 0)
            qmovha:SetUpled2Bat2Up(0, 0)
            qmovha:SetUpled2Bat2Dn(0, 0)
            qmovha:SetUpled2Gen2Up(0, 0)
            qmovha:SetUpled2Gen2Dn(0, 0)
        else
            qmovha:SetUpled1Ltk1Up()
            qmovha:SetUpled1Ltk1Dn()
            qmovha:SetUpled1Fire2()
            qmovha:SetUpled1Firea()
            qmovha:SetUpled1Fire1()
            qmovha:SetUpled1Onbat()

            qmovha:SetUpled1Ltk2Up()
            qmovha:SetUpled1Ltk2Dn()
            qmovha:SetUpled1CtklUp()
            qmovha:SetUpled1CtklDn()
            qmovha:SetUpled1CtkrUp()
            qmovha:SetUpled1CtkrDn()

            qmovha:SetUpled2Rtk1Up()
            qmovha:SetUpled2Rtk1Dn()
            qmovha:SetUpled2Rtk2Up()
            qmovha:SetUpled2Rtk2Dn()
            qmovha:SetUpled2Gen1Up()
            qmovha:SetUpled2Gen1Dn()
            qmovha:SetUpled2XfeedUp()
            qmovha:SetUpled2XfeedDn()

            qmovha:SetUpled2Bat1Up()
            qmovha:SetUpled2Bat1Dn()
            qmovha:SetUpled2Bat2Up()
            qmovha:SetUpled2Bat2Dn()
            qmovha:SetUpled2Gen2Up()
            qmovha:SetUpled2Gen2Dn()
        end

        qmovha:SetUpled2Eng1ag1(0, 0)
        qmovha:SetUpled2Eng1ag2(0, 0)
        qmovha:SetUpled2Eng2ag1(0, 0)
        qmovha:SetUpled2Eng2ag2(0, 0)

        qmovha:SetBkl(0)
    end
end

uluaAddDoLoop("Qmovha_XP_A333_loop()")
