-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- Modify by Carson Lou <carsonlu@sohu.com> 2025-7-25
-- *****************************************************************
if ilua_is_acfpath_excluded("PMDG") or ilua_is_acfpath_excluded("737") then
    return
end

-- Do not remove below lines: hardware detection
local qmpe = com.sim.qm.Qmpe:new()
if not qmpe:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMPE for PMDG737")

-- ===========================================================
-- button binding
-- TCAS STBY
qmpe:CfgRpn(42,
    "0 (L:switch_800_73X) - 10 div s0 :1 l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- TCAS ALT RPIG OFF
qmpe:CfgRpn(43,
    "10 (L:switch_800_73X) - 10 div s0 :1l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- TCAS XPNDR
qmpe:CfgRpn(40,
    "20 (L:switch_800_73X) - 10 div s0 :1 l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")
qmpe:CfgRpn(82,
    "20 (L:switch_800_73X) - 10 div s0 :1 l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- TCAS TA ONLY
qmpe:CfgRpn(41,
    "30 (L:switch_800_73X) - 10 div s0 :1 l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- TCAS TA/RA
qmpe:CfgRpn(81,
    "40 (L:switch_800_73X) - 10 div s0 :1 l0 0 > if{ 80007 (>K:ROTOR_BRAKE) l0 -- s0 g1 } l0 0 < if{ 80008 (>K:ROTOR_BRAKE) l0 ++ s0 g1 }")

-- OVHD FLT ALT
qmpe:CfgRpn(20, "21808 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(21, "21807 (>K:ROTOR_BRAKE)")

-- OVHD LDG ALT
qmpe:CfgRpn(22, "22008 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(23, "22007 (>K:ROTOR_BRAKE)")

-- WX+T
qmpe:CfgRpn(14, "91601 (>K:ROTOR_BRAKE) , 92001 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(8, "92308 (>K:ROTOR_BRAKE) , 92208 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(9, "92307 (>K:ROTOR_BRAKE) , 92207 (>K:ROTOR_BRAKE)")

-- CLOCK
qmpe:CfgRpn(65, "31401 (>K:ROTOR_BRAKE) , 52301 (>K:ROTOR_BRAKE)")

-- MASTER CAUTION
qmpe:CfgRpn(44, "34801 (>K:ROTOR_BRAKE)")

-- FIRE WARN BELL CUTOUT
qmpe:CfgRpn(79, "34701 (>K:ROTOR_BRAKE)")

-- FLOOD BRIGHT
if MSFS_VERSION == 0 then
    qmpe:CfgRpn(46, "75608 (>K:ROTOR_BRAKE) , 33808 (>K:ROTOR_BRAKE) , 33708 (>K:ROTOR_BRAKE) , 9408 (>K:ROTOR_BRAKE)")
    qmpe:CfgRpn(47, "75607 (>K:ROTOR_BRAKE) , 33807 (>K:ROTOR_BRAKE) , 33707 (>K:ROTOR_BRAKE) , 9407 (>K:ROTOR_BRAKE)")
else
    qmpe:CfgRpn(46,
        "(L:PED_PANEL_LIGHT_CONTROL, number) 6 - 0 max (>L:PED_PANEL_LIGHT_CONTROL, number) (L:CA_MAIN_PANEL_LIGHT_CONTROL, number) 6 - 0 max (>L:CA_MAIN_PANEL_LIGHT_CONTROL, number)")
    qmpe:CfgRpn(47,
        "(L:PED_PANEL_LIGHT_CONTROL, number) 6 + 300 min (>L:PED_PANEL_LIGHT_CONTROL, number) (L:CA_MAIN_PANEL_LIGHT_CONTROL, number) 6 + 300 min (>L:CA_MAIN_PANEL_LIGHT_CONTROL, number)")
end
-- RMP
-- Power On/Off
qmpe:CfgRpn(4, "(L:A32NX_RMP_L_TOGGLE_SWITCH) ! (>L:A32NX_RMP_L_TOGGLE_SWITCH)")
qmpe:CfgRpn(32, "(L:A32NX_RMP_R_TOGGLE_SWITCH) ! (>L:A32NX_RMP_R_TOGGLE_SWITCH)")
-- VHF1
qmpe:CfgRpn(7, "(>H:A32NX_RMP_L_VHF1_BUTTON_PRESSED)")
-- VHF2
qmpe:CfgRpn(6, "(>H:A32NX_RMP_L_VHF2_BUTTON_PRESSED)")
-- VHF1 RX
-- qmpe:CfgRpn(10, "(A:COM RECEIVE:1, Bool) ! (>K:COM1_RECEIVE_SELECT)")
qmpe:CfgRpn(10, "73901 (>K:ROTOR_BRAKE)")
-- VHF2 RX
-- qmpe:CfgRpn(11, "(A:COM RECEIVE:2, Bool) ! (>K:COM2_RECEIVE_SELECT)")
qmpe:CfgRpn(11, "74001 (>K:ROTOR_BRAKE)")
-- INT RX
qmpe:CfgRpn(12, "(L:S_ASP_INT_REC_LATCH) ! (>L:S_ASP_INT_REC_LATCH)")
-- CAB RX
qmpe:CfgRpn(13, "(L:S_ASP_CAB_REC_LATCH) ! (>L:S_ASP_CAB_REC_LATCH)")
-- PA RX
-- qmpe:CfgRpn(14, "(L:S_ASP_PA_REC_LATCH) ! (>L:S_ASP_PA_REC_LATCH)")
-- VHF1 TX
-- qmpe:CfgRpn(15, "(>K:COM1_TRANSMIT_SELECT)")
qmpe:CfgRpn(15, "73401 (>K:ROTOR_BRAKE) , 73404 (>K:ROTOR_BRAKE)")
-- VHF2 TX
-- qmpe:CfgRpn(24, "(>K:COM2_TRANSMIT_SELECT)")
qmpe:CfgRpn(24, "73501 (>K:ROTOR_BRAKE) , 73504 (>K:ROTOR_BRAKE)")
-- INT TX
qmpe:CfgRpn(25, "1 (>L:S_ASP_INT_SEND)", "0 (>L:S_ASP_INT_SEND)")
-- CAB TX
qmpe:CfgRpn(26, "1 (>L:S_ASP_CAB_SEND)", "0 (>L:S_ASP_CAB_SEND)")
-- PA TX nop, Airbus PA send is not latched
qmpe:CfgRpn(27, "1 (>L:S_ASP_PA_SEND)", "0 (>L:S_ASP_PA_SEND)")

-- VHF1 RX volume
qmpe:CfgRpn(16, "(L:XMLVAR_COM_1_Volume_VHF_L) 0.01 - 0 max (>L:XMLVAR_COM_1_Volume_VHF_L)")
qmpe:CfgRpn(17, "(L:XMLVAR_COM_1_Volume_VHF_L) 0.01 + 1 min (>L:XMLVAR_COM_1_Volume_VHF_L)")
-- VHF2 RX volume
qmpe:CfgRpn(18, "(L:XMLVAR_COM_1_Volume_VHF_C) 0.01 - 0 max (>L:XMLVAR_COM_1_Volume_VHF_C)")
qmpe:CfgRpn(19, "(L:XMLVAR_COM_1_Volume_VHF_C) 0.01 + 1 min (>L:XMLVAR_COM_1_Volume_VHF_C)")
-- INT RX volume
-- qmpe:CfgRpn(20, "(L:A_ASP_INT_VOLUME) 0.05 - 0 max (>L:A_ASP_INT_VOLUME)")
-- qmpe:CfgRpn(21, "(L:A_ASP_INT_VOLUME) 0.05 + 1 min (>L:A_ASP_INT_VOLUME)")
-- CAB RX volume
-- qmpe:CfgRpn(22, "(L:A_ASP_CAB_VOLUME) 0.05 - 0 max (>L:A_ASP_CAB_VOLUME)")
-- qmpe:CfgRpn(23, "(L:A_ASP_CAB_VOLUME) 0.05 + 1 min (>L:A_ASP_CAB_VOLUME)")
-- PA volume
-- qmpe:CfgRpn(8, "(L:A_ASP_PA_VOLUME) 0.05 - 0 max (>L:A_ASP_PA_VOLUME)")
-- qmpe:CfgRpn(9, "(L:A_ASP_PA_VOLUME) 0.05 + 1 min (>L:A_ASP_PA_VOLUME)")
-- RMP2
-- VHF1
qmpe:CfgRpn(34, "(>H:A32NX_RMP_R_VHF1_BUTTON_PRESSED)")
-- VHF2
qmpe:CfgRpn(35, "(>H:A32NX_RMP_R_VHF2_BUTTON_PRESSED)")

-- weather SYS 1/OFF/2
qmpe:CfgRpn(36, "0 (>L:XMLVAR_A320_WeatherRadar_Sys)")
-- 80 is middle key
qmpe:CfgRpn(80, "1 (>L:XMLVAR_A320_WeatherRadar_Sys)")
qmpe:CfgRpn(37, "2 (>L:XMLVAR_A320_WeatherRadar_Sys)")

-- weather PWS off/auto
qmpe:CfgRpn(38, "0 (>L:A32NX_SWITCH_RADAR_PWS_POSITION)")
-- 39 is right key
qmpe:CfgRpn(39, "1 (>L:A32NX_SWITCH_RADAR_PWS_POSITION)")

-- XPDR STBY/TA/TARA
-- qmpe:CfgRpn(40, "0 (>L:A32NX_SWITCH_TCAS_POSITION)")
-- qmpe:CfgRpn(41, "1 (>L:A32NX_SWITCH_TCAS_POSITION)")
-- qmpe:CfgRpn(81, "2 (>L:A32NX_SWITCH_TCAS_POSITION)")

-- XPDR STBY/AUTO/ON
-- qmpe:CfgRpn(42, "1 (>A:TRANSPONDER STATE:1, Enum)")
-- qmpe:CfgRpn(43, "3 (>A:TRANSPONDER STATE:1, Enum)")
-- qmpe:CfgRpn(82, "4 (>A:TRANSPONDER STATE:1, Enum)")

-- CAUT
-- qmpe:CfgRpn(44, "1 (>L:PUSH_AUTOPILOT_MASTERCAUT_L)", "0 (>L:PUSH_AUTOPILOT_MASTERCAUT_L)")
-- WARN
-- qmpe:CfgRpn(79, "1 (>L:PUSH_AUTOPILOT_MASTERAWARN_L)", "0 (>L:PUSH_AUTOPILOT_MASTERAWARN_L)")

-- INTEG LT Push
qmpe:CfgRpn(45, "1 (>L:A32NX_DCDU_ATC_MSG_ACK)")

-- INTEG LT
-- qmpe:CfgRpn(46, "(A:LIGHT POTENTIOMETER:85, Percent) 1 - 0 max 85 (>K:2:LIGHT_POTENTIOMETER_SET)")
-- qmpe:CfgRpn(47, "(A:LIGHT POTENTIOMETER:85, Percent) 1 + 100 min 85 (>K:2:LIGHT_POTENTIOMETER_SET)")

-- ECAM
-- HUD
qmpe:CfgRpn(78, "97901 (>K:ROTOR_BRAKE)")

-- MFD ENG BUTTON
-- qmpe:CfgRpn(48, "20 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 46300 1 + (>K:ROTOR_BRAKE)")

function pmdg737_eng_step2()
    uluaWriteCmd("20 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
end

function pmdg737_eng_step1()
    uluaWriteCmd("46300 1 + (>K:ROTOR_BRAKE)")
    uluasetTimeout("pmdg737_eng_step2()", 100)
end

qmpe:CfgFc(48, "pmdg737_eng_step1()", '')

qmpe:CfgRpn(49, "1 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(50, "2 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(51, "3 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")

-- CHOCKS TOGGLE
qmpe:CfgRpn(52, "62301 (>K:ROTOR_BRAKE) , 61601 (>K:ROTOR_BRAKE) , 61201 (>K:ROTOR_BRAKE) , 61701 (>K:ROTOR_BRAKE)")

-- GND PWR COWN
qmpe:CfgRpn(53, "62301 (>K:ROTOR_BRAKE) , 61601 (>K:ROTOR_BRAKE) , 61201 (>K:ROTOR_BRAKE) , 60701 (>K:ROTOR_BRAKE)")

qmpe:CfgRpn(54, "6 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(55, "7 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(56, "8 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(57, "9 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")
qmpe:CfgRpn(58, "10 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX)")

qmpe:CfgRpn(59, "1 (>L:A32NX_ECAM_ALL_Push_IsDown)", "0 (>L:A32NX_ECAM_ALL_Push_IsDown)")

qmpe:CfgRpn(60, "1 (>L:A32NX_BTN_CLR)", "0 (>L:A32NX_BTN_CLR)")

-- MFD SYS BUTTON
qmpe:CfgRpn(61,
    "(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 11 != if{ 11 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) } els{ -1 (>L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) } (>H:A32NX_SD_PAGE_CHANGED)  46200 1 + (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(62, "1 (>L:A32NX_BTN_RCL)", "0 (>L:A32NX_BTN_RCL)")

-- Terrain
qmpe:CfgRpn(63, "(L:A32NX_EFIS_TERR_L_ACTIVE,bool) ! (>L:A32NX_EFIS_TERR_L_ACTIVE)")

-- XDRD IDENT
-- qmpe:CfgRpn(64, "(>H:A320_Neo_ATC_BTN_IDENT)")
qmpe:CfgRpn(64, "80601 (>K:ROTOR_BRAKE)")
-- qmpe:CfgRpn(64, "(>K:XPNDR_IDENT_ON)")

-- Chrone
-- qmpe:CfgRpn(65, "0 (>H:A32NX_EFIS_L_CHRONO_PUSHED)")

-- XPRD ATC Keypad
qmpe:CfgRpn(66, "(>H:Transponder0)")
qmpe:CfgRpn(67, "(>H:Transponder2)")
qmpe:CfgRpn(68, "(>H:Transponder3)")
qmpe:CfgRpn(69, "(>H:Transponder4)")
qmpe:CfgRpn(70, "(>H:Transponder5)")
qmpe:CfgRpn(71, "(>H:Transponder6)")
qmpe:CfgRpn(72, "(>H:Transponder7)")
qmpe:CfgRpn(73, "(>H:Transponder0)")
qmpe:CfgRpn(74, "(>H:TransponderCLR)")
-- autobrake
qmpe:CfgRpn(75, "33901 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(76, "34001 (>K:ROTOR_BRAKE)")
qmpe:CfgRpn(77, "34101 (>K:ROTOR_BRAKE)")

---- RMP1
-- inner
qmpe:CfgRpn(0, "(>K:COM_RADIO_FRACT_DEC)")
qmpe:CfgRpn(1, "(>K:COM_RADIO_FRACT_INC)")
-- outer
qmpe:CfgRpn(2, "(>K:COM_RADIO_WHOLE_DEC)")
qmpe:CfgRpn(3, "(>K:COM_RADIO_WHOLE_INC)")
-- flip
qmpe:CfgRpn(5, "(>K:COM_STBY_RADIO_SWAP)")

---- RMP2
-- inner
qmpe:CfgRpn(28, "(>K:COM2_RADIO_FRACT_DEC)")
qmpe:CfgRpn(29, "(>K:COM2_RADIO_FRACT_INC)")
-- outer
qmpe:CfgRpn(30, "(>K:COM2_RADIO_WHOLE_DEC)")
qmpe:CfgRpn(31, "(>K:COM2_RADIO_WHOLE_INC)")
-- flip

qmpe:CfgRpn(33, "(>K:COM2_RADIO_SWAP)")
-- qmpe:CfgRpn(33, "(>K:COM2_STBY_RADIO_SWAP)")

-- ===========================================================
-- Read data

-- =====XPDR
qmpe:GetXpdr("(A:TRANSPONDER CODE:1, Number)")
-- Expert: FBW own logic
-- @ AUTO CLR = false
-- @ TIMEOUT = 2s
qmpe:FakeXpdrInit(false, 2)
local b_xpdr_act = iDataRef:New("(A:TRANSPONDER CODE:1, Number)")
local function xpdr_update()
    if qmpe:FakeXpdrIsTimeOut() or b_xpdr_act:ChangedUpdate() then
        -- qmpe:FakeXpdrCopy()
        qmpe:FakeXpdrClear()
    end
    local xpdr_stby, stdr_num = qmpe:FakeXpdrGet()
    if stdr_num == 0 then
        qmpe:SetXpdr(qmpe:EncXpdr(b_xpdr_act:Get()))
    elseif stdr_num == 4 then
        local bc016 = qmpe:XpdrBc016(xpdr_stby)
        uluaWriteCmd(tostring(bc016) .. " (>K:XPNDR_SET)")
    else
        qmpe:SetXpdr(qmpe:EncXpdr(xpdr_stby, stdr_num))
    end
end
-- =====RMP
qmpe:GetR1vhf1("(A:CIRCUIT AVIONICS ON,Bool)")
qmpe:GetR1vhf2("(L:A32NX_RMP_L_SELECTED_MODE) 2 ==")
qmpe:GetR2vhf1("(L:A32NX_RMP_R_SELECTED_MODE) 1 ==")
qmpe:GetR2vhf2("(A:CIRCUIT AVIONICS ON,Bool)")
-- =====ACP
-- VHF1 TX LIGHT
qmpe:GetSVhf1("(A:COM TRANSMIT:1, Bool)")
-- VHF1 CALL LIGHT
qmpe:GetCVhf1("(L:I_ASP_VHF_1_CALL)")
-- VHF1 RX LIGHT
qmpe:GetRVhf1("(A:COM RECEIVE:1, Bool)")
-- VHF2 TX LIGHT
qmpe:GetSVhf2("(A:COM TRANSMIT:2, Bool)")
-- VHF2 CALL LIGHT
qmpe:GetCVhf2("(L:I_ASP_VHF_2_CALL)")
-- VHF2 RX LIGHT
qmpe:GetRVhf2("(A:COM RECEIVE:2, Bool)")
-- MECH TX LIGHT
qmpe:GetSMech("(L:I_ASP_INT_SEND)")
-- MECH CALL LIGHT
qmpe:GetCMech("(L:I_ASP_INT_CALL)")
-- MECH RX LIGHT
qmpe:GetRMech("(L:I_ASP_INT_REC)")
-- ATT TX LIGHT
qmpe:GetSAtt("(L:I_ASP_CAB_SEND)")
-- ATT CALL LIGHT
qmpe:GetCAtt("(L:I_ASP_CAB_CALL)")
-- ATT RX LIGHT
qmpe:GetRAtt("(L:I_ASP_CAB_REC)")
-- PX TX LIGHT
qmpe:GetSPa("(L:I_ASP_PA_SEND)")
-- ATT RX LIGHT
qmpe:GetRPa("(L:I_ASP_PA_REC)")

-- =====ECAM
qmpe:GetEEng("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 20 ==")
qmpe:GetEBleed("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 1 ==")
qmpe:GetEPress("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 2 ==")
qmpe:GetEElec("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 3 ==")
qmpe:GetEHyd("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 4 ==")
qmpe:GetEFuel("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 5 ==")

qmpe:GetEApu("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 6 ==")
qmpe:GetECond("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 7 ==")
qmpe:GetEDoor("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 8 ==")
qmpe:GetEWheel("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 9 ==")
qmpe:GetEFctl("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 10 ==")

qmpe:GetEClr("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 12 ==")
qmpe:GetESts("(L:A32NX_ECAM_SD_CURRENT_PAGE_INDEX) 11 ==")

-- =====MISC
qmpe:GetWarn("(L:A32NX_MASTER_WARNING)")
qmpe:GetCaut("(L:Generic_Master_Caution_Active)")

qmpe:GetMsg("(L:A32NX_DCDU_ATC_MSG_WAITING, bool)")
qmpe:GetFail("(L:I_XPDR_FAIL)")
qmpe:GetLand("(L:I_MIP_AUTOLAND_CAPT)")

qmpe:GetTerr("(L:A32NX_EFIS_TERR_L_ACTIVE)")

if uluaFind("pmdg/ng3/data/MAIN_annunFMC") == nil then
    qmpe:GetLo("(L:A32NX_AUTOBRAKES_ARMED_MODE, Number) 1 ==")
    qmpe:GetMed("(L:A32NX_AUTOBRAKES_ARMED_MODE, Number) 2 ==")
    qmpe:GetMax("(L:A32NX_AUTOBRAKES_ARMED_MODE, Number) 3 ==")
else
    qmpe:GetLo("pmdg/ng3/data/MAIN_annunAP_Amber[0]")
    qmpe:GetMed("pmdg/ng3/data/MAIN_annunAT_Amber[0]")
    qmpe:GetMax("pmdg/ng3/data/MAIN_annunFMC")
end
-- brightness
if MSFS_VERSION == 0 then
    qmpe:GetBkl("(A:LIGHT POTENTIOMETER:85, Percent)", 0.3) -- 0~100
else
    qmpe:GetBkl("(L:PED_PANEL_LIGHT_CONTROL, number)", 0.3) -- 0~300
end

qmpe:GetLock1("(A:GEAR LEFT POSITION, percent over 100)")
qmpe:GetLock2("(A:GEAR CENTER POSITION, percent over 100)")
qmpe:GetLock3("(A:GEAR RIGHT POSITION, percent over 100)")

qmpe:GetUnlock1("(L:MSATR_GEAR_LEFT_UNLK_LT)")
qmpe:GetUnlock2("(L:MSATR_GEAR_NOSE_UNLK_LT)")
qmpe:GetUnlock3("(L:MSATR_GEAR_RIGHT_UNLK_LT)")

-- =====RMP radio
qmpe:GetRmp1("(A:COM ACTIVE FREQUENCY:1,KHz)", "(A:COM STANDBY FREQUENCY:1, KHz) near")
qmpe:GetRmp2("(A:COM ACTIVE FREQUENCY:2,KHz)", "(A:COM STANDBY FREQUENCY:2, KHz) near")

-- Expert: FBW own logic
-- RMP1 expert mode
local b_rmp1_power = iDataRef:New("(A:CIRCUIT AVIONICS ON,Bool)")
local function rmp1_update()
    -- power control
    local rmp1_pow = b_rmp1_power:Get()
    if rmp1_pow == 0 then
        qmpe:OffRmp1()
        return
    end

    qmpe:SetRmp1()
end
-- RMP2 expert mode
local b_rmp2_power = iDataRef:New("(A:CIRCUIT AVIONICS ON,Bool)")
local function rmp2_update()
    -- power control
    local rmp2_pow = b_rmp2_power:Get()
    if rmp2_pow == 0 then
        qmpe:OffRmp2()
        return
    end

    qmpe:SetRmp2()
end

-- =====Annunciator test
local dr_test = iDataRef:New("(L:switch_346_73X,number)") -- 100: DIM 50: BRT 0: test mode
local qmcp737c_com_power = iDataRef:New("(A:AVIONICS MASTER SWITCH,Bool)")
local dr_power1 = iDataRef:New("(A:AVIONICS MASTER SWITCH,Bool)")
local dr_power = iDataRef:New("pmdg/ng3/data/MCP_indication_powered") -- 1 batt 2 AC bus
--#region

local dr_ann_ap_amber = iDataRef:New("pmdg/ng3/data/MAIN_annunAP_Amber[0]")
local dr_ann_at_amber = iDataRef:New("pmdg/ng3/data/MAIN_annunAT_Amber[0]")
local dr_ann_ap = iDataRef:New("pmdg/ng3/data/MAIN_annunAP[0]")
local dr_ann_at = iDataRef:New("pmdg/ng3/data/MAIN_annunAT[0]")
function Qmpe_pmdg_737_loop()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    local b_power1 = dr_power1:Get()
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
    if uluaFind("pmdg/ng3/data/MAIN_annunFMC") == nil then
        qmpe:SetMisc()
    else
        qmpe:SetWarn()
        qmpe:SetCaut()

        qmpe:SetLock1()
        qmpe:SetLock2()
        qmpe:SetLock3()
        qmpe:SetUnlock1()
        qmpe:SetUnlock2()
        qmpe:SetUnlock3()

        qmpe:SetMsg()
        qmpe:SetFail()

        uluaSet(idr_qmpe_hid_misc_lo, ilua_bool_ternary(dr_ann_ap:Get() + dr_ann_ap_amber:Get(), 0))
        uluaSet(idr_qmpe_hid_misc_med, ilua_bool_ternary(dr_ann_at:Get() + dr_ann_at_amber:Get(), 0))
        qmpe:SetMax()
        qmpe:SetTerr()
        qmpe:SetLand()

        -- brightness
        qmpe:SetBkl()
    end
end

uluaAddDoLoop("Qmpe_pmdg_737_loop()")
