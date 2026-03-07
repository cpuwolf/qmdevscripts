-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
if ilua_is_acftitle_excluded("A3") or ilua_is_acfpath_excluded("toliss") then
    if ilua_is_acftitle_excluded("A2") or ilua_is_acfpath_excluded("toliss") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qmpe = com.sim.qm.Qmpe:new()
if not qmpe:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMPE for Toliss")

-- check Toliss old verion or new
local oldversion = false

local function check_verion()
    local file = ilua_get_path(AIRCRAFT_PATH) .. "skunkcrafts_updater.cfg"
    if not ilua_file_exists(file) then
        uluaLog("Toliss XP11 old version")
        oldversion = true
    else
        uluaLog("Toliss XP12 new version")
    end
end
check_verion()

-- 0:ELEC AC  1:ELEC DC
local iniA330_ecam_elec_acdc = 0

-- A330
local isINIA330 = false
local isINIA340 = false
if not ilua_is_acftitle_excluded("A33") then
    isINIA330 = true
    uluaLog("- QMPE Toliss A33X")
elseif not ilua_is_acftitle_excluded("A34") then
    isINIA340 = true
    uluaLog("- QMPE Toliss A34X")
end

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

if oldversion then
    -- VHF1 RX
    qmpe:CfgCmd(10, "AirbusFBW/ListenVHF1")
    -- VHF2 RX
    qmpe:CfgCmd(11, "AirbusFBW/ListenVHF2")
else
    -- VHF1 RX
    qmpe:CfgValT(10, "AirbusFBW/ACP1KnobPush[0]")
    -- VHF2 RX
    qmpe:CfgValT(11, "AirbusFBW/ACP1KnobPush[1]")
    -- INT RX
    qmpe:CfgValT(12, "AirbusFBW/ACP1KnobPush[5]")
    -- CAB RX
    qmpe:CfgValT(13, "AirbusFBW/ACP1KnobPush[6]")
    -- PA RX
    qmpe:CfgValT(14, "AirbusFBW/ACP1KnobPush[15]")
end
-- VHF1 TX
qmpe:CfgCmd(15, "sim/audio_panel/select_audio_com1")
-- VHF2 TX
qmpe:CfgCmd(24, "sim/audio_panel/select_audio_com2")
-- INT TX nop
qmpe:CfgCmd(25, "AirbusFBW/ACP1/INTPress")
-- CAB TX pop up menu
qmpe:CfgCmd(26, "AirbusFBW/ACP1/CABPress")
-- PA TX nop, Airbus PA send is not latched
-- qmpe:CfgCmd(27, "1 (>L:S_ASP_PA_SEND)", "0 (>L:S_ASP_PA_SEND)")

if not isINIA330 then
    -- VHF1 RX volume
    qmpe:CfgEncFull(16, 17, "ckpt/oh/vhf1/1/anim", 10, 10, 1, 0, 270)
    -- VHF2 RX volume
    qmpe:CfgEncFull(18, 19, "ckpt/oh/vhf2/1/anim", 10, 10, 1, 0, 270)
else
    -- VHF1 RX volume
    qmpe:CfgEncFull(16, 17, "sim/cockpit2/radios/actuators/audio_volume_com1", 0.1, 0.1, 1, 0, 1)
    -- VHF2 RX volume
    qmpe:CfgEncFull(18, 19, "sim/cockpit2/radios/actuators/audio_volume_com2", 0.1, 0.1, 1, 0, 1)
end

-- INT RX volume
qmpe:CfgEncFull(20, 21, "ckpt/oh/int/1/anim", 10, 10, 1, 0, 270)
-- CAB RX volume
qmpe:CfgEncFull(22, 23, "ckpt/oh/cab/1/anim", 10, 10, 1, 0, 270)
-- PA volume
qmpe:CfgEncFull(8, 9, "ckpt/oh/pa/1/anim", 10, 10, 1, 0, 270)

-- RMP2
-- VHF1 RX
qmpe:CfgCmd(34, "AirbusFBW/VHF1Co")
-- VHF2 RX
qmpe:CfgCmd(35, "AirbusFBW/VHF2Co")

-- weather SYS 1/OFF/2
qmpe:CfgVal(36, "AirbusFBW/WXPowerSwitch", 0, 1)
-- 80 is middle key reserved
-- qmpe:CfgVal(80, "ckpt/radar/sys/anim", 1, 2)
qmpe:CfgVal(37, "AirbusFBW/WXPowerSwitch", 2, 1)

-- weather PWS off/auto
if oldversion then
    -- weather PWS off/auto
    qmpe:CfgVal(38, "ckpt/ped/radar/pwr/anim", 0, 2)
else
    qmpe:CfgVal(38, "AirbusFBW/WXSwitchPWS", 0, 2)
end
-- 39 is right key reserved
-- qmpe:CfgVal(39, "ckpt/ped/radar/pwr/anim")

-- XPDR STBY/TA/TARA
if not isINIA330 and not isINIA340 then
    qmpe:CfgVal(40, "AirbusFBW/XPDRPower", 0, 3)
    -- 41 is middle key reserved
    -- qmpe:CfgVal(41, "AirbusFBW/XPDRPower", 4, 0)
    qmpe:CfgVal(81, "AirbusFBW/XPDRPower", 4, 3)
else
    -- A339
    qmpe:CfgVal(40, "AirbusFBW/XPDRTCASMode", 0, 1)
    qmpe:CfgVal(81, "AirbusFBW/XPDRTCASMode", 2, 1)
end

-- XPDR STBY/AUTO/ON
if not isINIA330 and not isINIA340 then
    -- qmpe:CfgVal(42, "ckpt/transponder/pwrx/anim")
    -- qmpe:CfgVal(43, "ckpt/transponder/pwrx/anim", 0, 1)
    qmpe:CfgVal(82, "AirbusFBW/XPDRTCASMode", 1, 0)
else
    -- A339
    qmpe:CfgVal(42, "AirbusFBW/XPDRPower", 0, 1)
    qmpe:CfgVal(82, "AirbusFBW/XPDRPower", 2, 1)
end

-- CAUT
qmpe:CfgCmd(44, "sim/annunciator/clear_master_caution")
-- WARN
qmpe:CfgCmd(79, "sim/annunciator/clear_master_warning")
-- INTEG LT Push
-- qmpe:CfgCmd(45, "1 (>L:A32NX_DCDU_ATC_MSG_ACK)")

-- INTEG LT
qmpe:CfgEncFull(46, 47, "AirbusFBW/PanelBrightnessLevel", 0.0185, 0.0185, 1, 0, 1)

-- ECAM
-- TO CONFIG
qmpe:CfgCmd(78, "AirbusFBW/TOConfigPress")

qmpe:CfgValT(48, "AirbusFBW/SDENG")
qmpe:CfgValT(49, "AirbusFBW/SDBLEED")
qmpe:CfgValT(50, "AirbusFBW/SDPRESS")

function flip_ecam_ac_dc()
    -- uluaLog(string.format("flip_ecam_ac_dc=%d", iniA330_ecam_elec_acdc))
    iniA330_ecam_elec_acdc = 1 - iniA330_ecam_elec_acdc
    if iniA330_ecam_elec_acdc == 0 then
        qmpe:CfgValT(51, "AirbusFBW/SDELEC")
    else
        qmpe:CfgValT(51, "AirbusFBW/SDELECDC")
    end
end

if not isINIA330 and not isINIA340 then
    qmpe:CfgValT(51, "AirbusFBW/SDELEC")
else
    flip_ecam_ac_dc()
    qmpe:CfgFc(51, "", "flip_ecam_ac_dc()")
end

qmpe:CfgValT(52, "AirbusFBW/SDHYD")
qmpe:CfgValT(53, "AirbusFBW/SDFUEL")

qmpe:CfgValT(54, "AirbusFBW/SDAPU")
qmpe:CfgValT(55, "AirbusFBW/SDCOND")
qmpe:CfgValT(56, "AirbusFBW/SDDOOR")
qmpe:CfgValT(57, "AirbusFBW/SDWHEEL")
qmpe:CfgValT(58, "AirbusFBW/SDFCTL")

qmpe:CfgCmd(59, "AirbusFBW/ECAMAll")

qmpe:CfgCmd(60, "sim/annunciator/clear_master_accept")
qmpe:CfgValT(61, "AirbusFBW/SDSTATUS")
qmpe:CfgCmd(62, "AirbusFBW/ECAMRecall")

-- Terrain
qmpe:CfgValT(63, "AirbusFBW/TerrainSelectedND1")

-- XDRD IDENT
qmpe:CfgCmd(64, "sim/radios/transponder_ident")

-- Chrone
qmpe:CfgCmd(65, "AirbusFBW/CaptChronoButton")

-- XPRD ATC Keypad
qmpe:CfgCmd(66, "AirbusFBW/ATCCodeKey1")
qmpe:CfgCmd(67, "AirbusFBW/ATCCodeKey2")
qmpe:CfgCmd(68, "AirbusFBW/ATCCodeKey3")
qmpe:CfgCmd(69, "AirbusFBW/ATCCodeKey4")
qmpe:CfgCmd(70, "AirbusFBW/ATCCodeKey5")
qmpe:CfgCmd(71, "AirbusFBW/ATCCodeKey6")
qmpe:CfgCmd(72, "AirbusFBW/ATCCodeKey7")
qmpe:CfgCmd(73, "AirbusFBW/ATCCodeKey0")
qmpe:CfgCmd(74, "AirbusFBW/ATCCodeKeyCLR")
-- autobrake
qmpe:CfgCmd(75, "AirbusFBW/AbrkLo")
qmpe:CfgCmd(76, "AirbusFBW/AbrkMed")
qmpe:CfgCmd(77, "AirbusFBW/AbrkMax")

---- RMP1
-- inner
qmpe:CfgCmd(0, "AirbusFBW/RMP1FreqDownSml")
qmpe:CfgCmd(1, "AirbusFBW/RMP1FreqUpSml")
-- outer
qmpe:CfgCmd(2, "AirbusFBW/RMP1FreqDownLrg")
qmpe:CfgCmd(3, "AirbusFBW/RMP1FreqUpLrg")
-- flip
qmpe:CfgCmd(5, "AirbusFBW/RMPSwapCapt")

---- RMP2
-- inner
qmpe:CfgCmd(28, "AirbusFBW/RMP2FreqDownSml")
qmpe:CfgCmd(29, "AirbusFBW/RMP2FreqUpSml")
-- outer
qmpe:CfgCmd(30, "AirbusFBW/RMP2FreqDownLrg")
qmpe:CfgCmd(31, "AirbusFBW/RMP2FreqUpLrg")
-- flip
qmpe:CfgCmd(33, "AirbusFBW/RMPSwapCo")

-- ===========================================================
-- Read data
-- =====XPDR
qmpe:GetXpdr("sim/cockpit/radios/transponder_code")
-- Expert: Toliss own logic
local b_xpdr_power = iDataRef:New("sim/cockpit/radios/transponder_brightness") -- 0:0ff
--local b_xpdr_power1 = iDataRef:New("AirbusFBW/XPDRString") -- data
qmpe:FakeXpdrInit()
local b_xpdr_act = iDataRef:New("sim/cockpit/radios/transponder_code")

local function xpdr_update()
    if b_xpdr_power:Get() == 0 then
        qmpe:OffXpdr()
        return
    end

    -- if qmpe:FakeXpdrIsTimeOut()  then
    if b_xpdr_act:ChangedUpdate() then
        qmpe:FakeXpdrClear()
    end
    local xpdr_stby, stdr_num = qmpe:FakeXpdrGet()
    if stdr_num == 0 then
        qmpe:SetXpdr(qmpe:EncXpdr(b_xpdr_act:Get()))
    else
        qmpe:SetXpdr(qmpe:EncXpdr(xpdr_stby, stdr_num))
    end
end
-- =====RMP
qmpe:GetR1vhf1("AirbusFBW/RMP1Lights[1]")
qmpe:GetR1vhf2("AirbusFBW/RMP1Lights[2]")
qmpe:GetR2vhf1("AirbusFBW/RMP2Lights[1]")
qmpe:GetR2vhf2("AirbusFBW/RMP2Lights[2]")
-- =====ACP
-- VHF1 TX LIGHT
qmpe:GetSVhf1("AirbusFBW/ACP1Lights[0]")
-- VHF1 CALL LIGHT
qmpe:GetCVhf1("AirbusFBW/ACP1Lights[3]")
-- VHF1 RX LIGHT
if oldversion then
    qmpe:GetRVhf1("AirbusFBW/ACP1Lights[8]")
else
    qmpe:GetRVhf1("AirbusFBW/ACP1RotaryLight[0]")
end
-- VHF2 TX LIGHT
qmpe:GetSVhf2("AirbusFBW/ACP1Lights[1]")
-- VHF2 CALL LIGHT
qmpe:GetCVhf2("AirbusFBW/ACP1Lights[3]")
-- VHF2 RX LIGHT
if oldversion then
    qmpe:GetRVhf2("AirbusFBW/ACP1Lights[9]")
else
    qmpe:GetRVhf2("AirbusFBW/ACP1RotaryLight[1]")
end
-- MECH TX LIGHT
if oldversion then
    qmpe:GetSMech("AirbusFBW/ACP1Lights[3]")
else
    qmpe:GetSMech("AirbusFBW/ACP1Lights[5]")
end
-- MECH CALL LIGHT
qmpe:GetCMech("AirbusFBW/ACP1Lights[3]")
-- MECH RX LIGHT
if oldversion then
    qmpe:GetRMech("AirbusFBW/ACP1Lights[13]")
else
    qmpe:GetRMech("AirbusFBW/ACP1RotaryLight[5]")
end
-- ATT TX LIGHT
if oldversion then
    qmpe:GetSAtt("AirbusFBW/ACP1Lights[4]")
else
    qmpe:GetSAtt("AirbusFBW/ACP1Lights[6]")
end
-- ATT CALL LIGHT
qmpe:GetCAtt("AirbusFBW/ACP1Lights[3]")
-- ATT RX LIGHT
if oldversion then
    qmpe:GetRAtt("AirbusFBW/ACP1Lights[14]")
else
    qmpe:GetRAtt("AirbusFBW/ACP1RotaryLight[6]")
end
-- PX TX LIGHT
if oldversion then
    qmpe:GetSPa("AirbusFBW/ACP1Lights[4]")
else
    qmpe:GetSPa("AirbusFBW/ACP1Lights[7]")
end
-- ATT RX LIGHT
if oldversion then
    qmpe:GetRPa("AirbusFBW/ACP1Lights[15]")
else
    qmpe:GetRPa("AirbusFBW/ACP1RotaryLight[15]")
end

-- =====ECAM
qmpe:GetEEng("AirbusFBW/OHPLightsATA31[30]")
qmpe:GetEBleed("AirbusFBW/OHPLightsATA31[31]")
qmpe:GetEPress("AirbusFBW/OHPLightsATA31[32]")

if not isINIA330 and not isINIA340 then
    qmpe:GetEElec("AirbusFBW/OHPLightsATA31[33]")
else
    qmpe:GetEElecAcDc("AirbusFBW/OHPLightsATA31[33]", "AirbusFBW/OHPLightsATA31[52]")
end

qmpe:GetEHyd("AirbusFBW/OHPLightsATA31[34]")
qmpe:GetEFuel("AirbusFBW/OHPLightsATA31[35]")

qmpe:GetEApu("AirbusFBW/OHPLightsATA31[36]")
qmpe:GetECond("AirbusFBW/OHPLightsATA31[37]")
qmpe:GetEDoor("AirbusFBW/OHPLightsATA31[38]")
qmpe:GetEWheel("AirbusFBW/OHPLightsATA31[39]")
qmpe:GetEFctl("AirbusFBW/OHPLightsATA31[40]")

qmpe:GetEClr("AirbusFBW/OHPLightsATA31[42]")
qmpe:GetESts("AirbusFBW/OHPLightsATA31[41]")

-- =====MISC
qmpe:GetWarn("AirbusFBW/OHPLightsATA31[3]")
qmpe:GetCaut("AirbusFBW/OHPLightsATA31[4]")

qmpe:GetMsg("AirbusFBW/ACP2Lights[15]")
qmpe:GetFail("AirbusFBW/OHPLightsATA31[1]")
qmpe:GetLand("AirbusFBW/OHPLightsATA31[1]")

qmpe:GetTerr("AirbusFBW/OHPLightsATA34[24]")

qmpe:GetLo("AirbusFBW/OHPLightsATA32[12]")
qmpe:GetMed("AirbusFBW/OHPLightsATA32[14]")
qmpe:GetMax("AirbusFBW/OHPLightsATA32[16]")

qmpe:GetBkl("AirbusFBW/PanelBrightnessLevel", 60)

qmpe:GetLock1("AirbusFBW/OHPLightsATA32[2]")
qmpe:GetLock2("AirbusFBW/OHPLightsATA32[0]")
qmpe:GetLock3("AirbusFBW/OHPLightsATA32[4]")

qmpe:GetUnlock1("AirbusFBW/OHPLightsATA32[3]")
qmpe:GetUnlock2("AirbusFBW/OHPLightsATA32[1]")
qmpe:GetUnlock3("AirbusFBW/OHPLightsATA32[5]")

-- =====RMP radio
qmpe:GetRmp1("sim/cockpit2/radios/actuators/com1_left_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com1_standby_frequency_hz_833")
qmpe:GetRmp2("sim/cockpit2/radios/actuators/com2_left_frequency_hz_833",
    "sim/cockpit2/radios/actuators/com2_standby_frequency_hz_833")
-- Expert: Toliss own logic
-- RMP1 expert mode
local dr_rmp_bus_power
if oldversion then
    dr_rmp_bus_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on") -- 0: OFF >0: ON
else
    dr_rmp_bus_power = iDataRef:New("AirbusFBW/DCBusVoltages[3]", -1)          -- 0: OFF >0: ON
end
local b_rmp1_power = iDataRef:New("AirbusFBW/RMP1Available")
local b_rmp1_sel = iDataRef:New("AirbusFBW/RMP1SelFunc")
local v_rmp1_a = iDataRef:New("AirbusFBW/RMP1Freq")
local v_rmp1_s = iDataRef:New("AirbusFBW/RMP1StbyFreq")
local v_rmp1_crs = iDataRef:New("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot")

local str_rmp1_s
if uluaFind("AirbusFBW/RMP1/StandbyWindowString") ~= nil then
    str_rmp1_s = iDataRef:New("AirbusFBW/RMP1/StandbyWindowString")
else
    str_rmp1_s = v_rmp1_s
end
local function RmpFreq(drf)
    -- 131.3375=131.335
    local freqraw = drf:Get() + 0.0004
    local freq100 = math.floor(freqraw * 100)
    local freq1000 = math.floor(freqraw * 1000)
    if freq1000 - freq100 * 10 >= 5 then
        return freq100 * 10 + 5
    else
        return freq100 * 10
    end
end

local function rmp1_update()
    -- power control
    local rmp1_pow = b_rmp1_power:Get()
    if rmp1_pow == 0 or dr_rmp_bus_power:Get() == 0 then
        qmpe:OffRmp1()
        return
    end

    if b_rmp1_sel:Get() == 0 then
        qmpe:SetRmp1(RmpFreq(v_rmp1_a), RmpFreq(v_rmp1_s))
    elseif b_rmp1_sel:Get() == 1 then
        qmpe:SetRmp1(RmpFreq(v_rmp1_a), RmpFreq(v_rmp1_s))
    elseif b_rmp1_sel:Get() == 2 then
        -- data mode
        qmpe:SetRmp1DataA()
        qmpe:SetRmp1S(v_rmp1_s:Get() * 1000)
    elseif b_rmp1_sel:Get() == 6 or b_rmp1_sel:Get() == 7 then
        -- VOR
        qmpe:SetRmp1A(v_rmp1_a:Get() * 1000)
        -- C/143
        local str_rmp1_data = str_rmp1_s:Get()
        local i
        i = string.match(str_rmp1_data, "C/(%d+)")
        if i == nil then
            qmpe:SetRmp1S(v_rmp1_s:Get() * 1000)
        else
            -- uluaLog(string.format("RMP1 VOR STBY=%s", i))
            qmpe:SetRmp1SCrs(tonumber(i))
        end
    elseif b_rmp1_sel:Get() == 9 then
        qmpe:SetRmp1AAdf(v_rmp1_a:Get() * 100)
        qmpe:SetRmp1SAdf(v_rmp1_s:Get() * 100)
    else
        -- simple mode
        qmpe:SetRmp1()
    end
end
-- RMP2 expert mode
local b_rmp2_power = iDataRef:New("AirbusFBW/RMP2Available")
local b_rmp2_sel = iDataRef:New("AirbusFBW/RMP2SelFunc")
local v_rmp2_a = iDataRef:New("AirbusFBW/RMP2Freq")
local v_rmp2_s = iDataRef:New("AirbusFBW/RMP2StbyFreq")
local v_rmp2_crs = iDataRef:New("sim/cockpit2/radios/actuators/nav2_obs_deg_mag_copilot")
local str_rmp2_s
if uluaFind("AirbusFBW/RMP2/StandbyWindowString") ~= nil then
    str_rmp2_s = iDataRef:New("AirbusFBW/RMP2/StandbyWindowString")
else
    str_rmp2_s = v_rmp2_s
end
local function rmp2_update()
    -- power control
    local rmp2_pow = b_rmp2_power:Get()
    if rmp2_pow == 0 then
        qmpe:OffRmp2()
        return
    end
    if b_rmp2_sel:Get() == 0 then
        qmpe:SetRmp2(RmpFreq(v_rmp2_a), RmpFreq(v_rmp2_s))
    elseif b_rmp2_sel:Get() == 1 then
        qmpe:SetRmp2(RmpFreq(v_rmp2_a), RmpFreq(v_rmp2_s))
    elseif b_rmp2_sel:Get() == 2 then
        -- data mode
        qmpe:SetRmp2DataA()
        qmpe:SetRmp2S(v_rmp2_s:Get() * 1000)
    elseif b_rmp2_sel:Get() == 6 or b_rmp2_sel:Get() == 7 then
        -- qmpe:SetRmp2Crs()
        qmpe:SetRmp2A(v_rmp2_a:Get() * 1000)
        -- C/143
        local str_rmp2_data = str_rmp2_s:Get()
        local i
        i = string.match(str_rmp2_data, "C/(%d+)")
        if i == nil then
            qmpe:SetRmp2S(v_rmp2_s:Get() * 1000)
        else
            -- uluaLog(string.format("RMP1 VOR STBY=%s", i))
            qmpe:SetRmp2SCrs(tonumber(i))
        end
    elseif b_rmp2_sel:Get() == 9 then
        qmpe:SetRmp2AAdf(v_rmp2_a:Get() * 100)
        qmpe:SetRmp2SAdf(v_rmp2_s:Get() * 100)
    else
        -- simple mode
        qmpe:SetRmp2()
    end
end
-- =====Annunciator test
local dr_test = iDataRef:New("AirbusFBW/AnnunMode") -- 0: DIM 1: BRT 2: test mode

local dr_power
local dr_bkl_power

if oldversion then
    dr_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on")     -- 0: OFF >0: ON
    dr_bkl_power = iDataRef:New("sim/cockpit2/switches/avionics_power_on") -- 0: OFF >0: ON
else
    dr_power = iDataRef:New("AirbusFBW/DCBusVoltages[3]")                  -- 0: OFF >0: ON
    dr_bkl_power = iDataRef:New("AirbusFBW/ACBusVoltages[0]")              -- 0: OFF >0: ON
end

function Qmpe_Toliss_loop()
    -- expert code: cold and dark
    local b_power = dr_power:Get()
    if b_power == 0 then
        qmpe:Off()
        return
    else
        if dr_bkl_power:Get() > 0 then
            qmpe:FreshBkl()
        end
    end

    -- expert code: test mode
    local b_test = dr_test:Get()
    if dr_test:ChangedUpdate() then
        if b_test == 2 then
            qmpe:SetBklMode(1)
            return
        elseif b_test == 0 then
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
    if not isINIA330 and not isINIA340 then
        qmpe:SetEcam()
    else
        qmpe:SetEcamAcDc()
    end
    qmpe:SetMisc()
end

uluaAddDoLoop("Qmpe_Toliss_loop()")
