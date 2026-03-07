-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-08-26
-- *****************************************************************
if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("fnx-") then
    if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("FNX_") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for Fenix")

-- ===========================================================
-- button binding
-- POS/Strobe
qmovha:CfgRpn(0, "2 (>L:S_OH_EXT_LT_STROBE)")
qmovha:CfgRpn(41, "1 (>L:S_OH_EXT_LT_STROBE)")
qmovha:CfgRpn(1, "0 (>L:S_OH_EXT_LT_STROBE)")

-- Anti Collision lights
qmovha:CfgRpn(2, "1 (>L:S_OH_EXT_LT_BEACON)", "0 (>L:S_OH_EXT_LT_BEACON)")

-- Wing lights
qmovha:CfgRpn(3, "1 (>L:S_OH_EXT_LT_WING)", "0 (>L:S_OH_EXT_LT_WING)")

-- Logo lights
qmovha:CfgRpn(4, "2 (>L:S_OH_EXT_LT_NAV_LOGO)")
qmovha:CfgRpn(42, "1 (>L:S_OH_EXT_LT_NAV_LOGO)")
qmovha:CfgRpn(5, "0 (>L:S_OH_EXT_LT_NAV_LOGO)")

-- Taxi lights
qmovha:CfgRpn(6, "2 (>L:S_OH_EXT_LT_NOSE)")
qmovha:CfgRpn(45, "1 (>L:S_OH_EXT_LT_NOSE)")
qmovha:CfgRpn(7, "0 (>L:S_OH_EXT_LT_NOSE)")

-- R Landing lights
qmovha:CfgRpn(8, "2 (>L:S_OH_EXT_LT_LANDING_R)")
qmovha:CfgRpn(44, "1 (>L:S_OH_EXT_LT_LANDING_R)")
qmovha:CfgRpn(9, "0 (>L:S_OH_EXT_LT_LANDING_R)")
-- L Landing lights
qmovha:CfgRpn(10, "2 (>L:S_OH_EXT_LT_LANDING_L)")
qmovha:CfgRpn(43, "1 (>L:S_OH_EXT_LT_LANDING_L)")
qmovha:CfgRpn(11, "0 (>L:S_OH_EXT_LT_LANDING_L)")

-- Runway Turn Off lights
qmovha:CfgRpn(12, "1 (>L:S_OH_EXT_LT_RWY_TURNOFF)", "0 (>L:S_OH_EXT_LT_RWY_TURNOFF)")

-- OVHD INTEG LT
qmovha:CfgRpn(16, "(L:A_OH_LIGHTING_OVD) 0.1 + 1 min (>L:A_OH_LIGHTING_OVD)")
qmovha:CfgRpn(17, "(L:A_OH_LIGHTING_OVD) 0.1 - 0 max (>L:A_OH_LIGHTING_OVD)")

-- SEAT BELTS
qmovha:CfgRpn(13, "1 (>L:S_OH_SIGNS)", "0 (>L:S_OH_SIGNS)")

-- NO SMOKING
qmovha:CfgRpn(14, "2 (>L:S_OH_SIGNS_SMOKING)")
qmovha:CfgRpn(48, "1 (>L:S_OH_SIGNS_SMOKING)")
qmovha:CfgRpn(15, "0 (>L:S_OH_SIGNS_SMOKING)")

-- DOME
qmovha:CfgRpn(18, "2 (>L:S_OH_INT_LT_DOME)")
qmovha:CfgRpn(46, "1 (>L:S_OH_INT_LT_DOME)")
qmovha:CfgRpn(19, "0 (>L:S_OH_INT_LT_DOME)")

-- ANN LT
qmovha:CfgRpn(20, "2 (>L:S_OH_IN_LT_ANN_LT)")
qmovha:CfgRpn(47, "1 (>L:S_OH_IN_LT_ANN_LT)")
qmovha:CfgRpn(21, "0 (>L:S_OH_IN_LT_ANN_LT)")

-- EMER EXIT LT
qmovha:CfgRpn(22, "2 (>L:S_OH_INT_LT_EMER)")
qmovha:CfgRpn(49, "1 (>L:S_OH_INT_LT_EMER)")
qmovha:CfgRpn(23, "0 (>L:S_OH_INT_LT_EMER)")

-- APU
qmovha:CfgRpn(30, "(L:S_OH_ELEC_APU_START) ++ (>L:S_OH_ELEC_APU_START)",
    "(L:S_OH_ELEC_APU_START) ++ (>L:S_OH_ELEC_APU_START)")
qmovha:CfgRpn(31, "(L:S_OH_ELEC_APU_MASTER) ! (>L:S_OH_ELEC_APU_MASTER)")

-- ANTI ICE
qmovha:CfgRpn(32, "(L:S_OH_PNEUMATIC_ENG2_ANTI_ICE) ! (>L:S_OH_PNEUMATIC_ENG2_ANTI_ICE)")
qmovha:CfgRpn(33, "(L:S_OH_PNEUMATIC_ENG1_ANTI_ICE) ! (>L:S_OH_PNEUMATIC_ENG1_ANTI_ICE)")
qmovha:CfgRpn(37, "(L:S_OH_PNEUMATIC_WING_ANTI_ICE) ! (>L:S_OH_PNEUMATIC_WING_ANTI_ICE)")

-- AIR COND
qmovha:CfgRpn(34, "(L:S_OH_PNEUMATIC_PACK_1) ! (>L:S_OH_PNEUMATIC_PACK_1)")
qmovha:CfgRpn(35, "(L:S_OH_PNEUMATIC_APU_BLEED) ! (>L:S_OH_PNEUMATIC_APU_BLEED)")
qmovha:CfgRpn(36, "(L:S_OH_PNEUMATIC_PACK_2) ! (>L:S_OH_PNEUMATIC_PACK_2)")

qmovha:CfgRpn(27, "0 (>L:S_OH_PNEUMATIC_XBLEED_SELECTOR)")
qmovha:CfgRpn(28, "1 (>L:S_OH_PNEUMATIC_XBLEED_SELECTOR)")
qmovha:CfgRpn(29, "2 (>L:S_OH_PNEUMATIC_XBLEED_SELECTOR)")

-- WIPER
qmovha:CfgRpn(24, "0 (>L:S_MISC_WIPER_CAPT) 0 (>L:S_MISC_WIPER_FO)")
qmovha:CfgRpn(25, "1 (>L:S_MISC_WIPER_CAPT) 1 (>L:S_MISC_WIPER_FO)")
qmovha:CfgRpn(26, "2 (>L:S_MISC_WIPER_CAPT) 2 (>L:S_MISC_WIPER_FO)")

-- OXYGEN
qmovha:CfgRpn(38, "(L:S_OH_OXYGEN_CREW_OXYGEN) ! (>L:S_OH_OXYGEN_CREW_OXYGEN)")
qmovha:CfgRpn(40, "(L:S_OH_CALLS_ALL) ++ (>L:S_OH_CALLS_ALL)", "(L:S_OH_CALLS_ALL) ++ (>L:S_OH_CALLS_ALL)")

-- GPWS
qmovha:CfgRpn(50, "(L:S_OH_GPWS_TERR) ! (>L:S_OH_GPWS_TERR)")
qmovha:CfgRpn(51, "(L:S_OH_GPWS_SYS) ! (>L:S_OH_GPWS_SYS)")
qmovha:CfgRpn(52, "(L:S_OH_GPWS_LDG_FLAP3) ! (>L:S_OH_GPWS_LDG_FLAP3)")

-- GND CTL CVR
qmovha:CfgRpn(53, "(L:S_OH_RCRD_GND_CTL) ++ (>L:S_OH_RCRD_GND_CTL)", "(L:S_OH_RCRD_GND_CTL) ++ (>L:S_OH_RCRD_GND_CTL)")

-- ADIRS 2,3,1
qmovha:CfgRpn(55, "(L:S_OH_NAV_ADR2) ++ (>L:S_OH_NAV_ADR2)", "(L:S_OH_NAV_ADR2) ++ (>L:S_OH_NAV_ADR2)")
qmovha:CfgRpn(56, "(L:S_OH_NAV_ADR3) ++ (>L:S_OH_NAV_ADR3)", "(L:S_OH_NAV_ADR3) ++ (>L:S_OH_NAV_ADR3)")
qmovha:CfgRpn(57, "(L:S_OH_NAV_ADR1) ++ (>L:S_OH_NAV_ADR1)", "(L:S_OH_NAV_ADR1) ++ (>L:S_OH_NAV_ADR1)")

qmovha:CfgRpn(73, "0 (>L:S_OH_NAV_IR1_MODE)")
qmovha:CfgRpn(74, "1 (>L:S_OH_NAV_IR1_MODE)")
qmovha:CfgRpn(75, "2 (>L:S_OH_NAV_IR1_MODE)")

qmovha:CfgRpn(79, "0 (>L:S_OH_NAV_IR3_MODE)")
qmovha:CfgRpn(80, "1 (>L:S_OH_NAV_IR3_MODE)")
qmovha:CfgRpn(81, "2 (>L:S_OH_NAV_IR3_MODE)")

qmovha:CfgRpn(76, "0 (>L:S_OH_NAV_IR2_MODE)")
qmovha:CfgRpn(77, "1 (>L:S_OH_NAV_IR2_MODE)")
qmovha:CfgRpn(78, "2 (>L:S_OH_NAV_IR2_MODE)")

-- BAT 1&2
qmovha:CfgRpn(58, "(L:S_OH_ELEC_GEN1) ! (>L:S_OH_ELEC_GEN1)")
qmovha:CfgRpn(59, "(L:S_OH_ELEC_BAT1) ! (>L:S_OH_ELEC_BAT1)")
qmovha:CfgRpn(60, "(L:S_OH_ELEC_BAT2) ! (>L:S_OH_ELEC_BAT2)")
qmovha:CfgRpn(62, "(L:S_OH_ELEC_GEN2) ! (>L:S_OH_ELEC_GEN2)")

-- EXT PWR
qmovha:CfgRpn(61, "(L:S_OH_ELEC_EXT_PWR) ++ (>L:S_OH_ELEC_EXT_PWR)", "(L:S_OH_ELEC_EXT_PWR) ++ (>L:S_OH_ELEC_EXT_PWR)")

-- FUEL
qmovha:CfgRpn(54, "(L:S_OH_FUEL_LEFT_1) ! (>L:S_OH_FUEL_LEFT_1)")
qmovha:CfgRpn(68, "(L:S_OH_FUEL_LEFT_2) ! (>L:S_OH_FUEL_LEFT_2)")

qmovha:CfgRpn(67, "(L:S_OH_FUEL_CENTER_1) ! (>L:S_OH_FUEL_CENTER_1)")
qmovha:CfgRpn(65, "(L:S_OH_FUEL_CENTER_2) ! (>L:S_OH_FUEL_CENTER_2)")

qmovha:CfgRpn(64, "(L:S_OH_FUEL_RIGHT_1) ! (>L:S_OH_FUEL_RIGHT_1)")
qmovha:CfgRpn(63, "(L:S_OH_FUEL_RIGHT_2) ! (>L:S_OH_FUEL_RIGHT_2)")

qmovha:CfgRpn(66, "(L:S_OH_FUEL_XFEED) ! (>L:S_OH_FUEL_XFEED)")

-- FIRE
qmovha:CfgRpn(69, "(L:S_OH_FIRE_ENG2_AGENT2) ++ (>L:S_OH_FIRE_ENG2_AGENT2",
    "(L:S_OH_FIRE_ENG2_AGENT2) ++ (>L:S_OH_FIRE_ENG2_AGENT2")
qmovha:CfgRpn(70, "(L:S_OH_FIRE_ENG2_AGENT1) ++ (>L:S_OH_FIRE_ENG2_AGENT1)",
    "(L:S_OH_FIRE_ENG2_AGENT1) ++ (>L:S_OH_FIRE_ENG2_AGENT1)")
qmovha:CfgRpn(71, "(L:S_OH_FIRE_ENG1_AGENT2) ++ (>L:S_OH_FIRE_ENG1_AGENT2)",
    "(L:S_OH_FIRE_ENG1_AGENT2) ++ (>L:S_OH_FIRE_ENG1_AGENT2)")
qmovha:CfgRpn(72, "(L:S_OH_FIRE_ENG1_AGENT1) ++ (>L:S_OH_FIRE_ENG1_AGENT1)",
    "(L:S_OH_FIRE_ENG1_AGENT1) ++ (>L:S_OH_FIRE_ENG1_AGENT1)")

qmovha:CfgRpn(82, "1 (>L:S_OH_FIRE_ENG1_BUTTON_Cover) 1 (>L:S_OH_FIRE_ENG1_BUTTON)", "0 (>L:S_OH_FIRE_ENG1_BUTTON)")
qmovha:CfgRpn(83, "1 (>L:S_OH_FIRE_APU_BUTTON_Cover) 1 (>L:S_OH_FIRE_APU_BUTTON)", "0 (>L:S_OH_FIRE_APU_BUTTON)")
qmovha:CfgRpn(84, "1 (>L:S_OH_FIRE_ENG2_BUTTON_Cover) 1 (>L:S_OH_FIRE_ENG2_BUTTON)", "0 (>L:S_OH_FIRE_ENG2_BUTTON)")

qmovha:CfgRpn(85, "(L:S_OH_FIRE_ENG1_TEST) ++ (>L:S_OH_FIRE_ENG1_TEST)",
    "(L:S_OH_FIRE_ENG1_TEST) ++ (>L:S_OH_FIRE_ENG1_TEST)")
qmovha:CfgRpn(86, "(L:S_OH_FIRE_APU_TEST) ++ (>L:S_OH_FIRE_APU_TEST)",
    "(L:S_OH_FIRE_APU_TEST) ++ (>L:S_OH_FIRE_APU_TEST)")
qmovha:CfgRpn(87, "(L:S_OH_FIRE_ENG2_TEST) ++ (>L:S_OH_FIRE_ENG2_TEST)",
    "(L:S_OH_FIRE_ENG2_TEST) ++ (>L:S_OH_FIRE_ENG2_TEST)")

-- ===========================================================
-- Read data

qmovha:GetStartUp('(L:I_OH_ELEC_APU_START_U)')
qmovha:GetStartDn('(L:I_OH_ELEC_APU_START_L)')
qmovha:GetMswUp('(L:I_OH_ELEC_APU_MASTER_U)')
qmovha:GetMswDn('(L:I_OH_ELEC_APU_MASTER_L)')
qmovha:GetUpled2Gen1Up('(L:I_OH_ELEC_GEN1_U)')
qmovha:GetUpled2Gen1Dn('(L:I_OH_ELEC_GEN1_L)')
qmovha:GetUpled2Bat1Up('(L:I_OH_ELEC_BAT1_U)')
qmovha:GetUpled2Bat1Dn('(L:I_OH_ELEC_BAT1_L)')
qmovha:GetUpled2Bat2Up('(L:I_OH_ELEC_BAT2_U)')
qmovha:GetUpled2Bat2Dn('(L:I_OH_ELEC_BAT2_L)')
qmovha:GetUpled2ExtUp('(L:I_OH_ELEC_EXT_PWR_U)')
qmovha:GetUpled2ExtDn('(L:I_OH_ELEC_EXT_PWR_L)')
qmovha:GetUpled2Gen2Up('(L:I_OH_ELEC_GEN2_U)')
qmovha:GetUpled2Gen2Dn('(L:I_OH_ELEC_GEN2_L)')

qmovha:GetEng2Up('(L:I_OH_PNEUMATIC_ENG2_ANTI_ICE_U)')
qmovha:GetEng2Dn('(L:I_OH_PNEUMATIC_ENG2_ANTI_ICE_L)')
qmovha:GetEng1Up('(L:I_OH_PNEUMATIC_ENG1_ANTI_ICE_U)')
qmovha:GetEng1Dn('(L:I_OH_PNEUMATIC_ENG1_ANTI_ICE_L)')
qmovha:GetPack1Up('(L:I_OH_PNEUMATIC_PACK_1_U)')
qmovha:GetPack1Dn('(L:I_OH_PNEUMATIC_PACK_1_L)')
qmovha:GetApubUp('(L:I_OH_PNEUMATIC_APU_BLEED_U)')
qmovha:GetApubDn('(L:I_OH_PNEUMATIC_APU_BLEED_L)')
qmovha:GetPack2Up('(L:I_OH_PNEUMATIC_PACK_2_U)')
qmovha:GetPack2Dn('(L:I_OH_PNEUMATIC_PACK_2_L)')
qmovha:GetWingUp('(L:I_OH_PNEUMATIC_WING_ANTI_ICE_U)')
qmovha:GetWingDn('(L:I_OH_PNEUMATIC_WING_ANTI_ICE_L)')

qmovha:GetCrew('(L:I_OH_OXYGEN_CREW_OXYGEN_L)')
qmovha:GetUpled1Gndctl('(L:I_OH_RCRD_GND_CTL_L)')

qmovha:GetUpled1TerrUp('(L:I_OH_GPWS_TERR_U)')
qmovha:GetUpled1TerrDn('(L:I_OH_GPWS_TERR_L)')
qmovha:GetUpled1SysUp('(L:I_OH_GPWS_SYS_U)')
qmovha:GetUpled1SysDn('(L:I_OH_GPWS_SYS_L)')
qmovha:GetUpled1Flap3('(L:I_OH_GPWS_LDG_FLAP3_L)')

qmovha:GetUpled1Adr1Up('(L:I_OH_NAV_ADR1_U)')
qmovha:GetUpled1Adr1Dn('(L:I_OH_NAV_ADR1_L)')
qmovha:GetUpled1Adr3Up('(L:I_OH_NAV_ADR3_U)')
qmovha:GetUpled1Adr3Dn('(L:I_OH_NAV_ADR3_L)')
qmovha:GetUpled1Adr2Up('(L:I_OH_NAV_ADR2_U)')
qmovha:GetUpled1Adr2Dn('(L:I_OH_NAV_ADR2_L)')
qmovha:GetUpled1Onbat('(L:I_OH_NAV_ADIRS_ON_BAT)')

qmovha:GetUpled1Ltk1Up('(L:I_OH_FUEL_LEFT_1_U)')
qmovha:GetUpled1Ltk1Dn('(L:I_OH_FUEL_LEFT_1_L)')
qmovha:GetUpled1Ltk2Up('(L:I_OH_FUEL_LEFT_2_U)')
qmovha:GetUpled1Ltk2Dn('(L:I_OH_FUEL_LEFT_2_L)')
qmovha:GetUpled1CtklUp('(L:I_OH_FUEL_CENTER_1_U)')
qmovha:GetUpled1CtklDn('(L:I_OH_FUEL_CENTER_1_L)')
qmovha:GetUpled1CtkrUp('(L:I_OH_FUEL_CENTER_2_U)')
qmovha:GetUpled1CtkrDn('(L:I_OH_FUEL_CENTER_2_L)')
qmovha:GetUpled2Rtk1Up('(L:I_OH_FUEL_RIGHT_1_U)')
qmovha:GetUpled2Rtk1Dn('(L:I_OH_FUEL_RIGHT_1_L)')
qmovha:GetUpled2Rtk2Up('(L:I_OH_FUEL_RIGHT_2_U)')
qmovha:GetUpled2Rtk2Dn('(L:I_OH_FUEL_RIGHT_2_L)')
qmovha:GetUpled2XfeedUp('(L:I_OH_FUEL_XFEED_U)')
qmovha:GetUpled2XfeedDn('(L:I_OH_FUEL_XFEED_L)')

qmovha:GetUpled1Fire2('(L:I_OH_FIRE_ENG2_BUTTON)')
qmovha:GetUpled1Firea('(L:I_OH_FIRE_APU_BUTTON) (L:I_OH_FIRE_APU_BUTTON_ON_BATT) ||')
qmovha:GetUpled1Fire1('(L:I_OH_FIRE_ENG1_BUTTON)')
qmovha:GetUpled2Eng1ag1('(L:I_OH_FIRE_ENG1_AGENT1_U)')
qmovha:GetUpled2Eng1ag2('(L:I_OH_FIRE_ENG1_AGENT2_U)')
qmovha:GetUpled2Eng2ag1('(L:I_OH_FIRE_ENG2_AGENT1_U)')
qmovha:GetUpled2Eng2ag2('(L:I_OH_FIRE_ENG2_AGENT2_U)')

qmovha:GetBkl('(L:A_OH_LIGHTING_OVD)', 100)                                              -- 0~1

qmovha:GetBrtDim("(L:S_OH_IN_LT_ANN_LT)", 1)                                             -- 0: DIM 1: BRT 2: test mode
qmovha:GetAirCond("(L:A320_Sound:Pack_Left)", "(L:A_OH_PNEUMATIC_COCKPIT_TEMP)", 12, 18) --0~100, 0~1
local dr_test = iDataRef:New("(L:S_OH_IN_LT_ANN_LT)")                                    -- 0: DIM 1: BRT 2: test mode
local dr_ac_bus = iDataRef:New("(L:B_ELEC_BUS_POWER_AC_ESS, Bool)")
local dr_dc_bus = iDataRef:New("(L:B_ELEC_BUS_POWER_DC_BAT, Bool)")

-- DONT use this name "Qmovha_Fenix_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_Fenix_loop()
    -- expert code: test mode
    local b_ac_bus = dr_ac_bus:Get()
    local b_dc_bus = dr_dc_bus:Get()

    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 2 and b_dc_bus == 1 then
            -- TEST mode and bat1&2 both are ON
            uluaSet(idr_qmovh_a_hid_mode_off, 0)
            uluaSet(idr_qmovh_a_hid_mode_test, 1)
        else
            uluaSet(idr_qmovh_a_hid_mode_test, 0)
        end
    end
    if b_test == 2 then
        -- use QMOVH-A hardware test mode
        -- ignore update all Leds and Backlight
        return
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

uluaAddDoLoop("Qmovha_Fenix_loop()")
