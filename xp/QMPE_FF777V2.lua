-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
if ilua_is_acftitle_excluded("B77") then
    return
end

local file
file = AIRCRAFT_PATH .. "\\..\\plugins\\T7Avionics\\64\\win.xpl"
-- uluaLog(file)

if ilua_file_exists(file) then
    uluaLog("FF777 old")
    return
end

-- Do not remove below lines: hardware detection
local qmpe = com.sim.qm.Qmpe:new()
if not qmpe:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMPE for FF777 V2\n")

-- ===========================================================
-- button binding

-- RMP 
-- Power On/Off
qmpe:CfgValT(4, "AirbusFBW/RMP1Switch")
qmpe:CfgValT(32, "AirbusFBW/RMP2Switch")
-- VHF1
qmpe:CfgCmd(7, "AirbusFBW/VHF1Capt")
-- VHF2
qmpe:CfgCmd(6, "AirbusFBW/VHF2Capt")

-- VHF1 RX
qmpe:CfgCmd(10, "sim/audio_panel/monitor_audio_com1")
-- VHF2 RX
qmpe:CfgCmd(11, "sim/audio_panel/monitor_audio_com2")
-- INT RX
-- qmpe:CfgValT(12, "AirbusFBW/ACP1KnobPush[5]")
-- CAB RX
-- qmpe:CfgValT(13, "AirbusFBW/ACP1KnobPush[6]")
-- PA RX
-- qmpe:CfgValT(14, "AirbusFBW/ACP1KnobPush[15]")

-- VHF1 TX
qmpe:CfgCmd(15, "sim/audio_panel/transmit_audio_com1")
-- VHF2 TX
qmpe:CfgCmd(24, "sim/audio_panel/transmit_audio_com2")
-- INT TX nop
-- qmpe:CfgCmd(25, "1 (>L:S_ASP_INT_SEND)", "0 (>L:S_ASP_INT_SEND)")
-- CAB TX nop
-- qmpe:CfgCmd(26, "1 (>L:S_ASP_CAB_SEND)", "0 (>L:S_ASP_CAB_SEND)")
-- PA TX nop, Airbus PA send is not latched
-- qmpe:CfgCmd(27, "1 (>L:S_ASP_PA_SEND)", "0 (>L:S_ASP_PA_SEND)")

-- VHF1 RX volume
qmpe:CfgEncFull(16, 17, "sim/cockpit2/radios/actuators/audio_volume_com1", 0.1, 0.1, 1, 0, 1)
-- VHF2 RX volume
qmpe:CfgEncFull(18, 19, "sim/cockpit2/radios/actuators/audio_volume_com2", 0.1, 0.1, 1, 0, 1)
-- INT RX volume
-- qmpe:CfgEncFull(20, 21, "ckpt/oh/int/1/anim", 10, 10, 1, 0, 270)
-- CAB RX volume
-- qmpe:CfgEncFull(22, 23, "ckpt/oh/cab/1/anim", 10, 10, 1, 0, 270)
-- PA volume
-- qmpe:CfgEncFull(8, 9, "ckpt/oh/pa/1/anim", 10, 10, 1, 0, 270)

-- RMP2
-- VHF1 RX
qmpe:CfgCmd(34, "AirbusFBW/VHF1Co")
-- VHF2 RX
qmpe:CfgCmd(35, "AirbusFBW/VHF2Co")

-- weather SYS 1/OFF/2
qmpe:CfgVal(36, "ckpt/radar/sys/anim", 0, 1)
-- 80 is middle key reserved
-- qmpe:CfgVal(80, "ckpt/radar/sys/anim", 1, 2)
qmpe:CfgVal(37, "ckpt/radar/sys/anim", 2, 1)

-- weather PWS off/auto
qmpe:CfgVal(38, "AirbusFBW/WXSwitchPWS", 0, 2)

-- 39 is right key reserved
-- qmpe:CfgVal(39, "ckpt/ped/radar/pwr/anim")

-- XPDR STBY/TA/TARA
-- qmpe:CfgVal(40, "sim/cockpit/radios/transponder_mode", 1, 2)
-- 41 is middle key reserved
-- qmpe:CfgVal(41, "sim/cockpit/radios/transponder_mode", 3, 0)
-- qmpe:CfgVal(81, "sim/cockpit/radios/transponder_mode", 3, 2)

-- XPDR STBY/AUTO/ON
qmpe:CfgVal(42, "sim/cockpit/radios/transponder_mode", 1, 2)
-- 43 is middle key reserved
-- qmpe:CfgVal(43, "sim/cockpit/radios/transponder_mode", 2, 3)
qmpe:CfgVal(82, "sim/cockpit/radios/transponder_mode", 3, 2)

-- CAUT
qmpe:CfgCmd(44, "sim/annunciator/clear_master_caution")
-- WARN
qmpe:CfgCmd(79, "sim/annunciator/clear_master_warning")
-- INTEG LT Push
-- qmpe:CfgCmd(45, "1 (>L:A32NX_DCDU_ATC_MSG_ACK)")

-- INTEG LT
qmpe:CfgEncFull(46, 47, "sim/cockpit2/switches/instrument_brightness_ratio[0]", 0.1, 0.1, 1, 0, 1)

-- ECAM
-- TO CONFIG
qmpe:CfgCmd(78, "1-sim/command/mfdPageChklButtom_button")

qmpe:CfgCmd(48, "1-sim/command/mfdPageEngButtom_button")
qmpe:CfgCmd(49, "1-sim/command/mfdPageAirButtom_button")
qmpe:CfgCmd(50, "1-sim/command/mfdPageAirButtom_button")
qmpe:CfgCmd(51, "1-sim/command/mfdPageElecButtom_button")
qmpe:CfgCmd(52, "1-sim/command/mfdPageHydButtom_button")
qmpe:CfgCmd(53, "1-sim/command/mfdPageFuelButtom_button")

qmpe:CfgCmd(54, "1-sim/command/mfdPageStatButtom_button")
qmpe:CfgCmd(55, "1-sim/command/mfdPageAirButtom_button")
qmpe:CfgCmd(56, "1-sim/command/mfdPageDoorButtom_button")
qmpe:CfgCmd(57, "1-sim/command/mfdPageGearButtom_button")
qmpe:CfgCmd(58, "1-sim/command/mfdPageFctlButtom_button")

qmpe:CfgCmd(59, "1-sim/command/mfdPageCommButtom_button")

qmpe:CfgCmd(60, "1-sim/command/mfdRclButton_button")
qmpe:CfgCmd(61, "1-sim/command/mfdPageStatButtom_button")
qmpe:CfgCmd(62, "1-sim/command/mfdRclButton_button")

-- Terrain
qmpe:CfgValT(63, "AirbusFBW/TerrainSelectedND1")

-- XDRD IDENT
qmpe:CfgCmd(64, "sim/radios/transponder_ident")

-- Chrone
qmpe:CfgCmd(65, "AirbusFBW/CaptChronoButton")

-- XPRD ATC Keypad
-- qmpe:CfgCmd(66, "sim/transponder/transponder_digit_1")
-- qmpe:CfgCmd(67, "sim/transponder/transponder_digit_2")
-- qmpe:CfgCmd(68, "sim/transponder/transponder_digit_3")
-- qmpe:CfgCmd(69, "sim/transponder/transponder_digit_4")
-- qmpe:CfgCmd(70, "sim/transponder/transponder_digit_5")
-- qmpe:CfgCmd(71, "sim/transponder/transponder_digit_6")
-- qmpe:CfgCmd(72, "sim/transponder/transponder_digit_7")
-- qmpe:CfgCmd(73, "sim/transponder/transponder_digit_0")
-- qmpe:CfgCmd(74, "sim/transponder/transponder_CLR")
-- autobrake
-- qmpe:CfgCmd(75, "AirbusFBW/AbrkLo")
-- qmpe:CfgCmd(76, "AirbusFBW/AbrkMed")
-- qmpe:CfgCmd(77, "AirbusFBW/AbrkMax")

---- RMP1
-- inner
qmpe:CfgCmd(0, "sim/radios/stby_com1_fine_down_833")
qmpe:CfgCmd(1, "sim/radios/stby_com1_fine_up_833")
-- outer
qmpe:CfgCmd(2, "sim/radios/stby_com1_coarse_down")
qmpe:CfgCmd(3, "sim/radios/stby_com1_coarse_up")
-- flip
qmpe:CfgCmd(5, "sim/radios/com1_standy_flip")

---- RMP2
-- inner
qmpe:CfgCmd(28, "sim/radios/stby_com2_fine_down_833")
qmpe:CfgCmd(29, "sim/radios/stby_com2_fine_up_833")
-- outer
qmpe:CfgCmd(30, "sim/radios/stby_com2_coarse_down")
qmpe:CfgCmd(31, "sim/radios/stby_com2_coarse_up")
-- flip
qmpe:CfgCmd(33, "sim/radios/com2_standy_flip")

-- ===========================================================
-- Read data
-- =====XPDR 
qmpe:GetXpdr("sim/cockpit2/radios/actuators/transponder_code")
-- Expert: Toliss own logic
local b_xpdr_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on")

-- Expert: FBW own logic
-- @ AUTO CLR = false
-- @ TIMEOUT = 2s
qmpe:FakeXpdrInit(false, 2)

local b_xpdr_act = iDataRef:New("sim/cockpit2/radios/actuators/transponder_code")

local function xpdr_update()
    if b_xpdr_power:Get() == 0 then
        qmpe:OffXpdr()
        return
    end

    if qmpe:FakeXpdrIsTimeOut() or b_xpdr_act:ChangedUpdate() then
        qmpe:FakeXpdrClear()
    end
    local xpdr_stby, stdr_num = qmpe:FakeXpdrGet()
    if stdr_num == 0 then
        -- force update
        qmpe:FreshXpdr()
        qmpe:SetXpdr()
    elseif stdr_num == 4 then
        b_xpdr_act:Set(xpdr_stby)
    else
        qmpe:SetXpdr(qmpe:EncXpdr(xpdr_stby, stdr_num))
    end
end
-- =====RMP
qmpe:GetR1vhf1("sim/cockpit2/switches/avionics_power_on")
qmpe:GetR1vhf2("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetR2vhf1("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetR2vhf2("sim/cockpit2/switches/avionics_power_on")
-- =====ACP
-- VHF1 TX LIGHT
qmpe:GetSVhf1("sim/cockpit2/radios/actuators/audio_com_selection") -- 6:COM1
-- VHF1 CALL LIGHT
qmpe:GetCVhf1("cpuwolf/qmdev/QMPE/condbtn[27]")
-- VHF1 RX LIGHT
qmpe:GetRVhf1("sim/cockpit2/radios/actuators/audio_selection_com1")

-- VHF2 TX LIGHT
qmpe:GetSVhf2("sim/cockpit2/radios/actuators/audio_com_selection") -- 7:COM2
-- VHF2 CALL LIGHT
qmpe:GetCVhf2("cpuwolf/qmdev/QMPE/condbtn[27]")
-- VHF2 RX LIGHT
qmpe:GetRVhf2("sim/cockpit2/radios/actuators/audio_selection_com2")

-- MECH TX LIGHT

qmpe:GetSMech("cpuwolf/qmdev/QMPE/condbtn[27]")

-- MECH CALL LIGHT
qmpe:GetCMech("cpuwolf/qmdev/QMPE/condbtn[27]")
-- MECH RX LIGHT

qmpe:GetRMech("cpuwolf/qmdev/QMPE/condbtn[27]")

-- ATT TX LIGHT

qmpe:GetSAtt("cpuwolf/qmdev/QMPE/condbtn[27]")

-- ATT CALL LIGHT
qmpe:GetCAtt("cpuwolf/qmdev/QMPE/condbtn[27]")
-- ATT RX LIGHT

qmpe:GetRAtt("cpuwolf/qmdev/QMPE/condbtn[27]")

-- PX TX LIGHT

qmpe:GetSPa("cpuwolf/qmdev/QMPE/condbtn[27]")

-- ATT RX LIGHT

qmpe:GetRPa("cpuwolf/qmdev/QMPE/condbtn[27]")

-- =====ECAM
qmpe:GetEEng("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEBleed("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEPress("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEElec("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEHyd("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEFuel("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetEApu("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetECond("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEDoor("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEWheel("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetEFctl("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetEClr("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetESts("cpuwolf/qmdev/QMPE/condbtn[27]")

-- =====MISC
qmpe:GetWarn("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetCaut("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetMsg("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetFail("sim/operation/failures/rel_xpndr")
qmpe:GetLand("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetTerr("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetLo("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetMed("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetMax("cpuwolf/qmdev/QMPE/condbtn[27]")

qmpe:GetBkl("sim/cockpit2/electrical/instrument_brightness_ratio[0]", 30)

qmpe:GetLock1("sim/flightmodel2/gear/deploy_ratio[1]")
qmpe:GetLock2("sim/flightmodel2/gear/deploy_ratio[0]")
qmpe:GetLock3("sim/flightmodel2/gear/deploy_ratio[2]")

qmpe:GetUnlock1("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetUnlock2("cpuwolf/qmdev/QMPE/condbtn[27]")
qmpe:GetUnlock3("cpuwolf/qmdev/QMPE/condbtn[27]")

-- =====RMP radio
qmpe:GetRmp1("sim/cockpit2/radios/actuators/com1_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833")
qmpe:GetRmp2("sim/cockpit2/radios/actuators/com2_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")
-- Expert: Toliss own logic
-- RMP1 expert mode
local b_rmp1_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on")
local function rmp1_update()
    -- power control
    local rmp1_pow = b_rmp1_power:Get()
    if rmp1_pow == 0 then
        qmpe:OffRmp1()
        return
    end

    -- simple mode
    qmpe:SetRmp1()
end
-- RMP2 expert mode
local b_rmp2_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on")
local function rmp2_update()
    -- power control
    local rmp2_pow = b_rmp2_power:Get()
    if rmp2_pow == 0 then
        qmpe:OffRmp2()
        return
    end
    -- simple mode
    qmpe:SetRmp2()

end
-- =====Annunciator test
local dr_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on") -- 0: OFF 1: ON
local dr_com_tx_sel = iDataRef:New("sim/cockpit2/radios/actuators/audio_com_selection") -- 6:COM1 7:COM2
function Qmpe_ff777v2_XP_loop()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    if dr_power:ChangedUpdate() then
        if b_power == 0 then
            qmpe:SetBkl(0)
            return
        else
            qmpe:FreshBkl()
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
    -- =============
    -- qmpe:SetAcp()
    local com_tx_sel = dr_com_tx_sel:Get()
    if com_tx_sel == 6 then
        qmpe:SetSVhf1(0, 1)
    else
        qmpe:SetSVhf1(0, 0)
    end
    qmpe:SetCVhf1()
    qmpe:SetRVhf1()
    --
    if com_tx_sel == 7 then
        qmpe:SetSVhf2(0, 1)
    else
        qmpe:SetSVhf2(0, 0)
    end
    qmpe:SetCVhf2()
    qmpe:SetRVhf2()
    --
    qmpe:SetSMech()
    qmpe:SetCMech()
    qmpe:SetRMech()
    qmpe:SetSAtt()
    qmpe:SetCAtt()
    qmpe:SetRAtt()
    qmpe:SetSPa()
    qmpe:SetRPa()

    -- =============

    qmpe:SetEcam()
    qmpe:SetMisc()
end

uluaAddDoLoop("Qmpe_ff777v2_XP_loop()")
