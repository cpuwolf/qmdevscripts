-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-10-17
-- *****************************************************************
if ilua_is_acfpath_excluded("a340") or ilua_is_acfpath_excluded("inibuild") then
    return
end

-- Do not remove below lines: hardware detection
local qmpe = com.sim.qm.Qmpe:new()
if not qmpe:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMPE for Inibuild A340")

-- A330
local isINIA330 = true
-- 0:ELEC AC  1:ELEC DC
local iniA330_ecam_elec_acdc = 0

-- ===========================================================
-- button binding

-- RMP
-- Power On/Off
qmpe:CfgRpn(4, "(L:INI_RMP1_STATE) ! (>L:INI_RMP1_STATE)")
qmpe:CfgRpn(32, "(L:INI_RMP2_STATE) ! (>L:INI_RMP2_STATE)")
-- VHF1
qmpe:CfgRpn(7, "1 (>L:INI_SELECTED_RADIO_CPT)")
-- VHF2
qmpe:CfgRpn(6, "2 (>L:INI_SELECTED_RADIO_CPT)")

-- VHF1 RX
qmpe:CfgTog(10, "B:AIRLINER_CPT_VHF1_VOL_Button", "(L:INI_RMP1_1_RECEIVE_SEL)")
-- VHF2 RX
qmpe:CfgTog(11, "B:AIRLINER_CPT_VHF2_VOL_Button", "(L:INI_RMP1_2_RECEIVE_SEL)")
-- INT RX
qmpe:CfgTog(12, "B:AIRLINER_CPT_INT_VOL_Button", "(L:INI_RMP1_8_RECEIVE_SEL)")
-- CAB RX
qmpe:CfgTog(13, "B:AIRLINER_CPT_CAB_VOL_Button", "(L:INI_RMP1_11_RECEIVE_SEL)")
-- PA RX
qmpe:CfgTog(14, "B:AIRLINER_CPT_PA_VOL_Button", "(L:INI_RMP1_9_RECEIVE_SEL)")
-- VHF1 TX
qmpe:CfgRpn(15, "1 (>L:INI_RMP1_TRANSMIT_CHANNEL)")
-- VHF2 TX
qmpe:CfgRpn(24, "2 (>L:INI_RMP1_TRANSMIT_CHANNEL)")
-- INT TX
qmpe:CfgRpn(25, "8 (>L:INI_RMP1_TRANSMIT_CHANNEL)")
-- CAB TX
qmpe:CfgRpn(26, "11 (>L:INI_RMP1_TRANSMIT_CHANNEL)")
-- PA TX, Airbus PA send is not latched
qmpe:CfgRpn(27, "1 (>B:AIRLINER_CPT_BTN_PA_Push)", "0 (>B:AIRLINER_CPT_BTN_PA_Release)")

-- VHF1 RX volume
qmpe:CfgFc(16,
    'uluaSet(uluaFind("B:AIRLINER_CPT_VHF1_VOL"), uluaGet(uluaFind("(L:INI_RMP1_1_VOLUME)"))-5)')
qmpe:CfgFc(17,
    'uluaSet(uluaFind("B:AIRLINER_CPT_VHF1_VOL"), uluaGet(uluaFind("(L:INI_RMP1_1_VOLUME)"))+5)')

-- VHF2 RX volume
qmpe:CfgFc(18,
    'uluaSet(uluaFind("B:AIRLINER_CPT_VHF2_VOL"), uluaGet(uluaFind("(L:INI_RMP1_2_VOLUME)"))-5)')
qmpe:CfgFc(19,
    'uluaSet(uluaFind("B:AIRLINER_CPT_VHF2_VOL"), uluaGet(uluaFind("(L:INI_RMP1_2_VOLUME)"))+5)')

-- INT RX volume
qmpe:CfgFc(20,
    'uluaSet(uluaFind("B:AIRLINER_CPT_INT_VOL"), uluaGet(uluaFind("(L:INI_RMP1_8_VOLUME)"))-5)')
qmpe:CfgFc(21,
    'uluaSet(uluaFind("B:AIRLINER_CPT_INT_VOL"), uluaGet(uluaFind("(L:INI_RMP1_8_VOLUME)"))+5)')

-- CAB RX volume
qmpe:CfgFc(22,
    'uluaSet(uluaFind("B:AIRLINER_CPT_CAB_VOL"), uluaGet(uluaFind("(L:INI_RMP1_11_VOLUME)"))-5)')
qmpe:CfgFc(23,
    'uluaSet(uluaFind("B:AIRLINER_CPT_CAB_VOL"), uluaGet(uluaFind("(L:INI_RMP1_11_VOLUME)"))+5)')

-- PA volume
qmpe:CfgFc(8,
    'uluaSet(uluaFind("B:AIRLINER_CPT_PA_VOL"), uluaGet(uluaFind("(L:INI_RMP1_9_VOLUME)"))-5)')
qmpe:CfgFc(9,
    'uluaSet(uluaFind("B:AIRLINER_CPT_PA_VOL"), uluaGet(uluaFind("(L:INI_RMP1_9_VOLUME)"))+5)')

-- RMP2
-- VHF1
qmpe:CfgRpn(34, "1 (>L:INI_SELECTED_RADIO_FO)")
-- VHF2
qmpe:CfgRpn(35, "2 (>L:INI_SELECTED_RADIO_FO)")

-- weather SYS 1/OFF/2
qmpe:CfgRpn(36, "0 (>L:INI_WX_SYS_SWITCH)")
-- 80 is middle key
qmpe:CfgRpn(80, "1 (>L:INI_WX_SYS_SWITCH)")
qmpe:CfgRpn(37, "2 (>L:INI_WX_SYS_SWITCH)")

-- weather PWS off/auto
qmpe:CfgVal(38, "B:AIRLINER_WX_PWS", 0, nil)

-- 39 is right key
qmpe:CfgVal(39, "B:AIRLINER_WX_PWS", 1, nil)

-- XPDR STBY/TA/TARA
qmpe:CfgRpn(40, "0 (>L:INI_tcas_mode_pedestal)")
qmpe:CfgRpn(41, "1 (>L:INI_tcas_mode_pedestal)")
qmpe:CfgRpn(81, "2 (>L:INI_tcas_mode_pedestal)")

-- XPDR STBY/AUTO/ON
qmpe:CfgRpn(42, "0 (>L:INI_TCAS_STBY_STATE)")
qmpe:CfgRpn(43, "1 (>L:INI_TCAS_STBY_STATE)")
qmpe:CfgRpn(82, "2 (>L:INI_TCAS_STBY_STATE)")

-- CAUT
qmpe:CfgRpn(44, "1 (>L:INI_MASTER_CAUTION_COMMAND)", "0 (>L:INI_MASTER_CAUTION_COMMAND)")
-- WARN
qmpe:CfgRpn(79, "1 (>L:INI_MASTER_WARNING_COMMAND)", "0 (>L:INI_MASTER_WARNING_COMMAND)")

-- INTEG LT Push
qmpe:CfgRpn(45, "1 (>L:A32NX_DCDU_ATC_MSG_ACK)")

-- INTEG LT
qmpe:CfgRpn(46, "1 (>B:AIRLINER_INTEG_LT_KNOB_Dec)")
qmpe:CfgRpn(47, "1 (>B:AIRLINER_INTEG_LT_KNOB_Inc)")

-- ECAM
-- TO CONFIG
qmpe:CfgVal(78, "B:AIRLINER_ECAM_TOCONFIG", 2, 0)

qmpe:CfgVal(48, "B:AIRLINER_ECAM_ENG", 2, 0)
qmpe:CfgVal(49, "B:AIRLINER_ECAM_BLEED", 2, 0)
qmpe:CfgVal(50, "B:AIRLINER_ECAM_PRESS", 2, 0)

function flip_ecam_ac_dc()
    iniA330_ecam_elec_acdc = 1 - iniA330_ecam_elec_acdc
    if iniA330_ecam_elec_acdc == 0 then
        qmpe:CfgVal(51, "B:AIRLINER_ECAM_ELAC", 2, 0)
    else
        qmpe:CfgVal(51, "B:AIRLINER_ECAM_ELDC", 2, 0)
    end
end

flip_ecam_ac_dc()
qmpe:CfgFc(51, "flip_ecam_ac_dc()")

qmpe:CfgVal(52, "B:AIRLINER_ECAM_HYD", 2, 0)
qmpe:CfgVal(53, "B:AIRLINER_ECAM_FUEL", 2, 0)
qmpe:CfgVal(54, "B:AIRLINER_ECAM_APU", 2, 0)
qmpe:CfgVal(55, "B:AIRLINER_ECAM_COND", 2, 0)
qmpe:CfgVal(56, "B:AIRLINER_ECAM_DOOR", 2, 0)
qmpe:CfgVal(57, "B:AIRLINER_ECAM_WHEEL", 2, 0)
qmpe:CfgVal(58, "B:AIRLINER_ECAM_FCTL", 2, 0)

qmpe:CfgVal(59, "B:AIRLINER_ECAM_ALL", 2, 0)

qmpe:CfgVal(60, "B:AIRLINER_ECAM_CLR", 2, 0)
qmpe:CfgVal(61, "B:AIRLINER_ECAM_STS", 2, 0)
qmpe:CfgVal(62, "B:AIRLINER_ECAM_RCL", 2, 0)

-- Terrain
qmpe:CfgRpn(63, "(L:INI_TERR_ON_CAPT) ! (>L:INI_TERR_ON_CAPT)")

-- XDRD IDENT
-- qmpe:CfgRpn(64, "(>H:A320_Neo_ATC_BTN_IDENT)")
qmpe:CfgRpn(64, "(>K:XPNDR_IDENT_ON)")

-- Chrone
qmpe:CfgRpn(65, "1 (>L:INI_CPT_CHRONO_BUTTON)")

-- XPRD ATC Keypad
qmpe:CfgRpn(66, "1 (>L:INI_TCAS_1_COMMAND)")
qmpe:CfgRpn(67, "1 (>L:INI_TCAS_2_COMMAND)")
qmpe:CfgRpn(68, "1 (>L:INI_TCAS_3_COMMAND)")
qmpe:CfgRpn(69, "1 (>L:INI_TCAS_4_COMMAND)")
qmpe:CfgRpn(70, "1 (>L:INI_TCAS_5_COMMAND)")
qmpe:CfgRpn(71, "1 (>L:INI_TCAS_6_COMMAND)")
qmpe:CfgRpn(72, "1 (>L:INI_TCAS_7_COMMAND)")
qmpe:CfgRpn(73, "1 (>L:INI_TCAS_0_COMMAND)")
qmpe:CfgRpn(74, "1 (>L:INI_TCAS_CLR_COMMAND)")
-- autobrake
qmpe:CfgRpn(75,
    "(L:INI_AUTOBRAKE_LEVEL, number) 5 != if{ 5 (>L:INI_AUTOBRAKE_LEVEL, number) } els{ 0 (>L:INI_AUTOBRAKE_LEVEL, number) }")
qmpe:CfgRpn(76,
    "(L:INI_AUTOBRAKE_LEVEL, number) 3 != if{ 3 (>L:INI_AUTOBRAKE_LEVEL, number) } els{ 0 (>L:INI_AUTOBRAKE_LEVEL, number) }")
qmpe:CfgRpn(77,
    "(L:INI_AUTOBRAKE_LEVEL, number) 4 != if{ 4 (>L:INI_AUTOBRAKE_LEVEL, number) } els{ 0 (>L:INI_AUTOBRAKE_LEVEL, number) }")

---- RMP1
-- inner
qmpe:CfgRpn(0, "(>K:COM_RADIO_FRACT_DEC)")
qmpe:CfgRpn(1, "(>K:COM_RADIO_FRACT_INC)")
-- outer
qmpe:CfgRpn(2, "(>K:COM_RADIO_WHOLE_DEC)")
qmpe:CfgRpn(3, "(>K:COM_RADIO_WHOLE_INC)")
-- flip
qmpe:CfgRpn(5, "1 (>L:INI_CPT_VHF_TRANSFER_SWITCH_COMMAND)")

---- RMP2
-- inner
qmpe:CfgRpn(28, "(>K:COM2_RADIO_FRACT_DEC)")
qmpe:CfgRpn(29, "(>K:COM2_RADIO_FRACT_INC)")
-- outer
qmpe:CfgRpn(30, "(>K:COM2_RADIO_WHOLE_DEC)")
qmpe:CfgRpn(31, "(>K:COM2_RADIO_WHOLE_INC)")
-- flip

qmpe:CfgRpn(33, "1 (>L:INI_FO_VHF_TRANSFER_SWITCH_COMMAND)")
-- qmpe:CfgRpn(33, "(>K:COM2_STBY_RADIO_SWAP)")

-- ===========================================================
-- Read data

-- =====XPDR
qmpe:GetXpdr("(A:TRANSPONDER CODE:1, Number)")
-- Expert: FBW own logic
local b_xpdr_power = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)", -1)
-- XPDR
-- @ AUTO CLR = true
-- @ TIMEOUT = 7s
-- @ Fast CLR = 99999
qmpe:FakeXpdrInit(false, 7, 99999)
local b_xpdr_act = iDataRef:New("(A:TRANSPONDER CODE:1, Number)")
local function xpdr_update()
    if b_xpdr_power:Get() == 0 then
        qmpe:OffXpdr()
        return
    end

    if qmpe:FakeXpdrIsTimeOut() or b_xpdr_act:ChangedUpdate() then
        qmpe:FakeXpdrCopy()
    end
    local xpdr_stby, stdr_num = qmpe:FakeXpdrGet()
    if stdr_num == 0 and qmpe:FakeXpdrIsTimeOut() then
        qmpe:SetXpdr(qmpe:EncXpdr(b_xpdr_act:Get()))
    else
        qmpe:SetXpdr(qmpe:EncXpdr(xpdr_stby, stdr_num))
    end
end
-- =====RMP
qmpe:GetR1vhf1("(L:INI_SELECTED_RADIO_CPT) 1 ==")
qmpe:GetR1vhf2("(L:INI_SELECTED_RADIO_CPT) 2 ==")
qmpe:GetR2vhf1("(L:INI_SELECTED_RADIO_FO) 1 ==")
qmpe:GetR2vhf2("(L:INI_SELECTED_RADIO_FO) 2 ==")
-- =====ACP
-- VHF1 TX LIGHT
qmpe:GetSVhf1("(L:INI_RMP1_TRANSMIT_CHANNEL) 1 ==")
-- VHF1 CALL LIGHT
qmpe:GetCVhf1("(L:I_ASP_VHF_1_CALL)")
-- VHF1 RX LIGHT
qmpe:GetRVhf1("(L:INI_RMP1_1_RECEIVE_SEL)")
-- VHF2 TX LIGHT
qmpe:GetSVhf2("(L:INI_RMP1_TRANSMIT_CHANNEL) 2 ==")
-- VHF2 CALL LIGHT
qmpe:GetCVhf2("(L:I_ASP_VHF_2_CALL)")
-- VHF2 RX LIGHT
qmpe:GetRVhf2("(L:INI_RMP1_2_RECEIVE_SEL)")
-- MECH TX LIGHT
qmpe:GetSMech("(L:INI_RMP1_TRANSMIT_CHANNEL) 8 ==")
-- MECH CALL LIGHT
qmpe:GetCMech("(L:I_ASP_INT_CALL)")
-- MECH RX LIGHT
qmpe:GetRMech("(L:INI_RMP1_8_RECEIVE_SEL)")
-- ATT TX LIGHT
qmpe:GetSAtt("(L:INI_RMP1_TRANSMIT_CHANNEL) 11 ==")
-- ATT CALL LIGHT
qmpe:GetCAtt("(L:I_ASP_CAB_CALL)")
-- ATT RX LIGHT
qmpe:GetRAtt("(L:INI_RMP1_11_RECEIVE_SEL)")
-- PA TX LIGHT
qmpe:GetSPa("(L:INI_RMP1_PA_CHANNEL)")
-- PA RX LIGHT
qmpe:GetRPa("(L:INI_RMP1_9_RECEIVE_SEL)")

-- =====ECAM
if isINIA330 == true then
    qmpe:GetEEng("(L:INI_ECAM_ACTIVE_PAGE) 1 ==")
    qmpe:GetEBleed("(L:INI_ECAM_ACTIVE_PAGE) 5 ==")
    qmpe:GetEPress("(L:INI_ECAM_ACTIVE_PAGE) 7 ==")
    -- AC or DC
    qmpe:GetEElec("(L:INI_ECAM_ACTIVE_PAGE) 3 == (L:INI_ECAM_ACTIVE_PAGE) 4 == ||")

    qmpe:GetEHyd("(L:INI_ECAM_ACTIVE_PAGE) 2 ==")
    qmpe:GetEFuel("(L:INI_ECAM_ACTIVE_PAGE) 8 ==")

    qmpe:GetEApu("(L:INI_ECAM_ACTIVE_PAGE) 9 ==")
    qmpe:GetECond("(L:INI_ECAM_ACTIVE_PAGE) 6 ==")
    qmpe:GetEDoor("(L:INI_ECAM_ACTIVE_PAGE) 11 ==")
    qmpe:GetEWheel("(L:INI_ECAM_ACTIVE_PAGE) 12 ==")
    qmpe:GetEFctl("(L:INI_ECAM_ACTIVE_PAGE) 10 ==")

    qmpe:GetEClr("(L:INI_ATLEASTONEMASTERCAUTION, Bool)")
    qmpe:GetESts("(L:INI_ECAM_ACTIVE_PAGE) 14 ==")
else
    qmpe:GetEEng("(L:INI_ECAM_ACTIVE_PAGE) 1 ==")
    qmpe:GetEBleed("(L:INI_ECAM_ACTIVE_PAGE) 4 ==")
    qmpe:GetEPress("(L:INI_ECAM_ACTIVE_PAGE) 6 ==")
    qmpe:GetEElec("(L:INI_ECAM_ACTIVE_PAGE) 3 ==")
    qmpe:GetEHyd("(L:INI_ECAM_ACTIVE_PAGE) 2 ==")
    qmpe:GetEFuel("(L:INI_ECAM_ACTIVE_PAGE) 7 ==")

    qmpe:GetEApu("(L:INI_ECAM_ACTIVE_PAGE) 8 ==")
    qmpe:GetECond("(L:INI_ECAM_ACTIVE_PAGE) 5 ==")
    qmpe:GetEDoor("(L:INI_ECAM_ACTIVE_PAGE) 10 ==")
    qmpe:GetEWheel("(L:INI_ECAM_ACTIVE_PAGE) 11 ==")
    qmpe:GetEFctl("(L:INI_ECAM_ACTIVE_PAGE) 9 ==")

    qmpe:GetEClr("(L:INI_ECAM_CLR_LIGHT, Bool)")
    qmpe:GetESts("(L:INI_ECAM_ACTIVE_PAGE) 13 ==")
end

-- =====MISC
qmpe:GetWarn("(L:INI_MASTER_WARNING_CAPT_BOTTOM)")
qmpe:GetCaut("(L:INI_MASTER_CAUTION_CAPT_BOTTOM)")

qmpe:GetMsg("(L:A32NX_DCDU_ATC_MSG_WAITING, bool)")
qmpe:GetFail("(L:I_XPDR_FAIL)")
qmpe:GetLand("(L:I_MIP_AUTOLAND_CAPT)")

qmpe:GetTerr("(L:INI_TERR_ON_CAPT)")


qmpe:GetLo("(L:INI_AUTOBRAKE_LEVEL) 5 ==")
qmpe:GetMed("(L:INI_AUTOBRAKE_LEVEL) 3 ==")
qmpe:GetMax("(L:INI_AUTOBRAKE_LEVEL) 4 ==")


qmpe:GetBkl("(A:LIGHT POTENTIOMETER:15, Percent)", 0.3) -- 0~100

qmpe:GetLock1("(L:INI_GEAR1_POSITION) 50 ==")
qmpe:GetLock2("(L:INI_GEAR0_POSITION) 50 ==")
qmpe:GetLock3("(L:INI_GEAR2_POSITION) 50 ==")

qmpe:GetUnlock1("(L:INI_GEAR1_UNLK_LIGHT)")
qmpe:GetUnlock2("(L:INI_GEAR0_UNLK_LIGHT)")
qmpe:GetUnlock3("(L:INI_GEAR2_UNLK_LIGHT)")

-- =====RMP radio
qmpe:GetRmp1("(A:COM ACTIVE FREQUENCY:1,KHz)", "(A:COM STANDBY FREQUENCY:1, KHz) near")
qmpe:GetRmp2("(A:COM ACTIVE FREQUENCY:2,KHz)", "(A:COM STANDBY FREQUENCY:2, KHz) near")

-- Expert: ini own logic
-- RMP1 expert mode
local dr_rmp_bus_power = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)", -1) -- 0: OFF 1: ON

local b_rmp1_power = iDataRef:New("(L:INI_RMP1_STATE)")

local b_rmp1_sel = iDataRef:New("(L:INI_SELECTED_RADIO_CPT)")
local v_com1_a = iDataRef:New("(L:INI_VHF1_ACTIVE_FREQ)")
local v_com2_a = iDataRef:New("(L:INI_VHF2_ACTIVE_FREQ)")
local v_com1_s = iDataRef:New("(L:INI_VHF1_STANDBY_FREQ)")
local v_com2_s = iDataRef:New("(L:INI_VHF2_STANDBY_FREQ)")

local b_rmp1_mode = iDataRef:New("(L:INI_CPT_RADIO_MODE)")

local b_rmp1_vor_sel = iDataRef:New("(L:INI_COMM_VOR_CPT)")
local d_rmp1_vor_a = iDataRef:New("(L:INI_VOR1_FREQUENCY)")
local d_rmp1_vor_s = iDataRef:New("(L:INI_VOR1_STBY_FREQUENCY)")
local d_rmp1_vor_crs = iDataRef:New("(L:INI_vor1_course)")

local b_rmp1_ils_sel = iDataRef:New("(L:INI_COMM_LS_CPT)")
local d_rmp1_ils_a = iDataRef:New("(L:INI_ILS_FREQUENCY)")
local d_rmp1_ils_s = iDataRef:New("(L:INI_ILS_STBY_FREQUENCY)")
local d_rmp1_ils_crs = iDataRef:New("(L:INI_vor1_course)")

local b_rmp1_adf_sel = iDataRef:New("(L:INI_COMM_ADF_CPT)")
local d_rmp1_adf_a = iDataRef:New("(L:INI_ADF1_FREQUENCY)")
local d_rmp1_adf_s = iDataRef:New("(L:INI_ADF1_STBY_FREQUENCY)")

local function RmpFreq(drf)
    return drf:Get() * 10
end

-- INI_COMM_VOR_CPT
-- INI_COMM_LS_CPT
-- INI_COMM_ADF_CPT

-- INI_VOR1_FREQUENCY
-- INI_ILS_FREQUENCY
-- INI_ADF1_FREQUENCY

-- INI_VOR1_STBY_FREQUENCY
-- INI_ILS_STBY_FREQUENCY
-- INI_ADF1_STBY_FREQUENCY

local function rmp1_update()
    -- power control
    local rmp1_pow = b_rmp1_power:Get()
    if rmp1_pow == 0 or dr_rmp_bus_power:Get() == 0 then
        qmpe:OffRmp1()
        return
    end
    if b_rmp1_vor_sel:Get() > 0 then
        qmpe:SetRmp1A(RmpFreq(d_rmp1_vor_a))
        qmpe:SetRmp1SCrs(d_rmp1_vor_crs:Get())
        b_rmp1_sel:Update()
    elseif b_rmp1_ils_sel:Get() > 0 then
        qmpe:SetRmp1A(RmpFreq(d_rmp1_ils_a))
        qmpe:SetRmp1SCrs(d_rmp1_ils_crs:Get())
        b_rmp1_sel:Update()
    elseif b_rmp1_adf_sel:Get() > 0 then
        qmpe:SetRmp1AAdf(d_rmp1_adf_a:Get() * 100)
        qmpe:SetRmp1SAdf(d_rmp1_adf_s:Get() * 100)
        b_rmp1_sel:Update()
    elseif b_rmp1_sel:Get() == 2 then
        qmpe:SetRmp1(v_com2_a:Get(), v_com2_s:Get())
        b_rmp1_sel:Update()
    else
        if b_rmp1_sel:ChangedUpdate() or b_rmp1_mode:ChangedUpdate() then
            qmpe:FreshRmp1()
        end
        qmpe:SetRmp1()
    end
end
-- RMP2 expert mode
local b_rmp2_power = iDataRef:New("(L:INI_RMP2_STATE)")
local b_rmp2_sel = iDataRef:New("(L:INI_SELECTED_RADIO_FO)")

local function rmp2_update()
    -- power control
    local rmp2_pow = b_rmp2_power:Get()
    if rmp2_pow == 0 or dr_rmp_bus_power:Get() == 0 then
        qmpe:OffRmp2()
        return
    end

    if b_rmp2_sel:Get() == 1 then
        qmpe:SetRmp2(v_com1_a:Get(), v_com1_s:Get())
        b_rmp2_sel:Update()
    else
        if b_rmp2_sel:ChangedUpdate() then
            qmpe:FreshRmp2()
        end
        qmpe:SetRmp2()
    end
end

-- =====Annunciator test
local dr_test = iDataRef:New("(L:INI_ANNLT_SWITCH, number)")                 -- 0: TEST 1:BRT: 2: DIM
local dr_power = iDataRef:New("(L:INI_DC_ESSENTIAL_BUS_IS_POWERED, number)") -- 0: OFF 1: ON

function Qmpe_IniA340_loop()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    if b_power == 0 then
        qmpe:Off()
        return
    else
        qmpe:FreshBkl()
    end

    -- expert code: test mode
    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 0 then
            qmpe:SetBklMode(1)
            return
        elseif b_test == 2 then
            -- DIM
            qmpe:SetBklCtrl(1)
        else
            qmpe:SetBklMode(0)
            qmpe:SetBklCtrl(0)
            uluaSet(idr_qmpe_hid_invalid, -1)
        end
    end

    -- DATA

    -- RMP1/RMP2
    rmp1_update()
    rmp2_update()
    -- XPDR
    xpdr_update()
    -- LEDS
    qmpe:SetRmp()
    qmpe:SetAcp()
    qmpe:SetEcam()
    qmpe:SetMisc()
end

uluaAddDoLoop("Qmpe_IniA340_loop()")
