-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("fnx-") then
    if ilua_is_acftitle_excluded("Fenix") and ilua_is_acfpath_excluded("FNX_") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qmpe = com.sim.qm.Qmpe:new()
if not qmpe:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMPE for Fenix")

-- ===========================================================
-- button binding

-- RMP 
-- Power On/Off
qmpe:CfgRpn(4, "(L:S_PED_RMP1_POWER) ! (>L:S_PED_RMP1_POWER)")
qmpe:CfgRpn(32, "(L:S_PED_RMP2_POWER) ! (>L:S_PED_RMP2_POWER)")
-- VHF1
qmpe:CfgRpn(7, "1 (>L:S_PED_RMP1_VHF1)", "0 (>L:S_PED_RMP1_VHF1)")
-- VHF2
qmpe:CfgRpn(6, "1 (>L:S_PED_RMP1_VHF2)", "0 (>L:S_PED_RMP1_VHF2)")

-- VHF1 RX
qmpe:CfgRpn(10, "(L:S_ASP_VHF_1_REC_LATCH) ! (>L:S_ASP_VHF_1_REC_LATCH)")
-- VHF2 RX
qmpe:CfgRpn(11, "(L:S_ASP_VHF_2_REC_LATCH) ! (>L:S_ASP_VHF_2_REC_LATCH)")
-- INT RX
qmpe:CfgRpn(12, "(L:S_ASP_INT_REC_LATCH) ! (>L:S_ASP_INT_REC_LATCH)")
-- CAB RX
qmpe:CfgRpn(13, "(L:S_ASP_CAB_REC_LATCH) ! (>L:S_ASP_CAB_REC_LATCH)")
-- PA RX
qmpe:CfgRpn(14, "(L:S_ASP_PA_REC_LATCH) ! (>L:S_ASP_PA_REC_LATCH)")
-- VHF1 TX
qmpe:CfgRpn(15, "1 (>L:S_ASP_VHF_1_SEND)", "0 (>L:S_ASP_VHF_1_SEND)")
-- VHF2 TX
qmpe:CfgRpn(24, "1 (>L:S_ASP_VHF_2_SEND)", "0 (>L:S_ASP_VHF_2_SEND)")
-- INT TX
qmpe:CfgRpn(25, "1 (>L:S_ASP_INT_SEND)", "0 (>L:S_ASP_INT_SEND)")
-- CAB TX
qmpe:CfgRpn(26, "1 (>L:S_ASP_CAB_SEND)", "0 (>L:S_ASP_CAB_SEND)")
-- PA TX nop, Airbus PA send is not latched
qmpe:CfgRpn(27, "1 (>L:S_ASP_PA_SEND)", "0 (>L:S_ASP_PA_SEND)")

-- VHF1 RX volume
qmpe:CfgRpn(16, "(L:A_ASP_VHF_1_VOLUME) 0.05 - 0 max (>L:A_ASP_VHF_1_VOLUME)")
qmpe:CfgRpn(17, "(L:A_ASP_VHF_1_VOLUME) 0.05 + 1 min (>L:A_ASP_VHF_1_VOLUME)")
-- VHF2 RX volume
qmpe:CfgRpn(18, "(L:A_ASP_VHF_2_VOLUME) 0.05 - 0 max (>L:A_ASP_VHF_2_VOLUME)")
qmpe:CfgRpn(19, "(L:A_ASP_VHF_2_VOLUME) 0.05 + 1 min (>L:A_ASP_VHF_2_VOLUME)")
-- INT RX volume
qmpe:CfgRpn(20, "(L:A_ASP_INT_VOLUME) 0.05 - 0 max (>L:A_ASP_INT_VOLUME)")
qmpe:CfgRpn(21, "(L:A_ASP_INT_VOLUME) 0.05 + 1 min (>L:A_ASP_INT_VOLUME)")
-- CAB RX volume
qmpe:CfgRpn(22, "(L:A_ASP_CAB_VOLUME) 0.05 - 0 max (>L:A_ASP_CAB_VOLUME)")
qmpe:CfgRpn(23, "(L:A_ASP_CAB_VOLUME) 0.05 + 1 min (>L:A_ASP_CAB_VOLUME)")
-- PA volume
qmpe:CfgRpn(8, "(L:A_ASP_PA_VOLUME) 0.05 - 0 max (>L:A_ASP_PA_VOLUME)")
qmpe:CfgRpn(9, "(L:A_ASP_PA_VOLUME) 0.05 + 1 min (>L:A_ASP_PA_VOLUME)")
-- RMP2
-- VHF1
qmpe:CfgRpn(34, "1 (>L:S_PED_RMP2_VHF1)", "0 (>L:S_PED_RMP2_VHF1)")
-- VHF2
qmpe:CfgRpn(35, "1 (>L:S_PED_RMP2_VHF2)", "0 (>L:S_PED_RMP2_VHF2)")

-- weather SYS 1/OFF/2
qmpe:CfgRpn(36, "0 (>L:S_WR_SYS)")
-- 80 is middle key
qmpe:CfgRpn(80, "1 (>L:S_WR_SYS)")
qmpe:CfgRpn(37, "2 (>L:S_WR_SYS)")

-- weather PWS off/auto
qmpe:CfgRpn(38, "0 (>L:S_WR_PRED_WS)")
-- 39 is right key
qmpe:CfgRpn(39, "1 (>L:S_WR_PRED_WS)")

-- XPDR STBY/TA/TARA
qmpe:CfgRpn(40, "0 (>L:S_XPDR_MODE)")
qmpe:CfgRpn(41, "1 (>L:S_XPDR_MODE)")
qmpe:CfgRpn(81, "2 (>L:S_XPDR_MODE)")

-- XPDR STBY/AUTO/ON
qmpe:CfgRpn(42, "0 (>L:S_XPDR_OPERATION)")
qmpe:CfgRpn(43, "1 (>L:S_XPDR_OPERATION)")
qmpe:CfgRpn(82, "2 (>L:S_XPDR_OPERATION)")

-- CAUT
qmpe:CfgRpn(44, "1 (>L:S_MIP_MASTER_CAUTION_CAPT)", "0 (>L:S_MIP_MASTER_CAUTION_CAPT)")
-- WARN
qmpe:CfgRpn(79, "1 (>L:S_MIP_MASTER_WARNING_CAPT)", "0 (>L:S_MIP_MASTER_WARNING_CAPT)")
-- INTEG LT Push
qmpe:CfgRpn(45, "1 (>L:S_MIP_ATC_MSG_CAPT)")

-- INTEG LT
qmpe:CfgRpn(46, "(L:A_PED_LIGHTING_PEDESTAL) 0.1 - 0 max (>L:A_PED_LIGHTING_PEDESTAL)")
qmpe:CfgRpn(47, "(L:A_PED_LIGHTING_PEDESTAL) 0.1 + 1 min (>L:A_PED_LIGHTING_PEDESTAL)")

-- ECAM
-- TO CONFIG
qmpe:CfgRpn(78, "1 (>L:S_ECAM_TO)", "0 (>L:S_ECAM_TO)")

qmpe:CfgRpn(48, "1 (>L:S_ECAM_ENGINE)", "0 (>L:S_ECAM_ENGINE)")
qmpe:CfgRpn(49, "1 (>L:S_ECAM_BLEED)", "0 (>L:S_ECAM_BLEED)")
qmpe:CfgRpn(50, "1 (>L:S_ECAM_CAB_PRESS)", "0 (>L:S_ECAM_CAB_PRESS)")
qmpe:CfgRpn(51, "1 (>L:S_ECAM_ELEC)", "0 (>L:S_ECAM_ELEC)")
qmpe:CfgRpn(52, "1 (>L:S_ECAM_HYD)", "0 (>L:S_ECAM_HYD)")
qmpe:CfgRpn(53, "1 (>L:S_ECAM_FUEL)", "0 (>L:S_ECAM_FUEL)")

qmpe:CfgRpn(54, "1 (>L:S_ECAM_APU)", "0 (>L:S_ECAM_APU)")
qmpe:CfgRpn(55, "1 (>L:S_ECAM_COND)", "0 (>L:S_ECAM_COND)")
qmpe:CfgRpn(56, "1 (>L:S_ECAM_DOOR)", "0 (>L:S_ECAM_DOOR)")
qmpe:CfgRpn(57, "1 (>L:S_ECAM_WHEEL)", "0 (>L:S_ECAM_WHEEL)")
qmpe:CfgRpn(58, "1 (>L:S_ECAM_FCTL)", "0 (>L:S_ECAM_FCTL)")

qmpe:CfgRpn(59, "1 (>L:S_ECAM_ALL)", "0 (>L:S_ECAM_ALL)")

qmpe:CfgRpn(60, "1 (>L:S_ECAM_CLR_LEFT)", "0 (>L:S_ECAM_CLR_LEFT)")
qmpe:CfgRpn(61, "1 (>L:S_ECAM_STATUS)", "0 (>L:S_ECAM_STATUS)")
qmpe:CfgRpn(62, "1 (>L:S_ECAM_RCL)", "0 (>L:S_ECAM_RCL)")

-- Terrain
qmpe:CfgRpn(63, "1 (>L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT)", "0 (>L:S_MIP_GPWS_TERRAIN_ON_ND_CAPT)")

-- XDRD IDENT
qmpe:CfgRpn(64, "1 (>L:S_XPDR_IDENT)", "0 (>L:S_XPDR_IDENT)")

-- Chrone
qmpe:CfgRpn(65, "1 (>L:S_MIP_CHRONO_CAPT)", "0 (>L:S_MIP_CHRONO_CAPT)")

-- XPRD ATC Keypad
qmpe:CfgRpn(66, "1 (>L:S_PED_ATC_1)", "0 (>L:S_PED_ATC_1)")
qmpe:CfgRpn(67, "1 (>L:S_PED_ATC_2)", "0 (>L:S_PED_ATC_2)")
qmpe:CfgRpn(68, "1 (>L:S_PED_ATC_3)", "0 (>L:S_PED_ATC_3)")
qmpe:CfgRpn(69, "1 (>L:S_PED_ATC_4)", "0 (>L:S_PED_ATC_4)")
qmpe:CfgRpn(70, "1 (>L:S_PED_ATC_5)", "0 (>L:S_PED_ATC_5)")
qmpe:CfgRpn(71, "1 (>L:S_PED_ATC_6)", "0 (>L:S_PED_ATC_6)")
qmpe:CfgRpn(72, "1 (>L:S_PED_ATC_7)", "0 (>L:S_PED_ATC_7)")
qmpe:CfgRpn(73, "1 (>L:S_PED_ATC_0)", "0 (>L:S_PED_ATC_0)")
qmpe:CfgRpn(74, "1 (>L:S_PED_ATC_CLR)", "0 (>L:S_PED_ATC_CLR)")
-- autobrake
qmpe:CfgRpn(75, "1 (>L:S_MIP_AUTOBRAKE_LO)", "0 (>L:S_MIP_AUTOBRAKE_LO)")
qmpe:CfgRpn(76, "1 (>L:S_MIP_AUTOBRAKE_MED)", "0 (>L:S_MIP_AUTOBRAKE_MED)")
qmpe:CfgRpn(77, "1 (>L:S_MIP_AUTOBRAKE_MAX)", "0 (>L:S_MIP_AUTOBRAKE_MAX)")

---- RMP1
-- inner
qmpe:CfgRpn(0, "(L:E_PED_RMP1_INNER) -- (>L:E_PED_RMP1_INNER)")
qmpe:CfgRpn(1, "(L:E_PED_RMP1_INNER) ++ (>L:E_PED_RMP1_INNER)")
-- outer
qmpe:CfgRpn(2, "(L:E_PED_RMP1_OUTER) -- (>L:E_PED_RMP1_OUTER)")
qmpe:CfgRpn(3, "(L:E_PED_RMP1_OUTER) ++ (>L:E_PED_RMP1_OUTER)")
-- flip
qmpe:CfgRpn(5, "(L:S_PED_RMP1_XFER) ++ (>L:S_PED_RMP1_XFER)", "(L:S_PED_RMP1_XFER) ++ (>L:S_PED_RMP1_XFER)")

---- RMP2
-- inner
qmpe:CfgRpn(28, "(L:E_PED_RMP2_INNER) -- (>L:E_PED_RMP2_INNER)")
qmpe:CfgRpn(29, "(L:E_PED_RMP2_INNER) ++ (>L:E_PED_RMP2_INNER)")
-- outer
qmpe:CfgRpn(30, "(L:E_PED_RMP2_OUTER) -- (>L:E_PED_RMP2_OUTER)")
qmpe:CfgRpn(31, "(L:E_PED_RMP2_OUTER) ++ (>L:E_PED_RMP2_OUTER)")
-- flip
qmpe:CfgRpn(33, "(L:S_PED_RMP2_XFER) ++ (>L:S_PED_RMP2_XFER)", "(L:S_PED_RMP2_XFER) ++ (>L:S_PED_RMP2_XFER)")

-- ===========================================================
-- Read data

-- =====XPDR
qmpe:GetXpdr("(L:N_FREQ_STANDBY_XPDR_SELECTED)")
-- Expert: Fenix own logic
local b_xpdr_fail = iDataRef:New("(L:I_XPDR_FAIL)")
local b_xpdr_power1 = iDataRef:New("(L:I_XPDR_ATC_1)")
local b_xpdr_power2 = iDataRef:New("(L:I_XPDR_ATC_2)")

-- XPDR
local b_xpdr_c_num = iDataRef:New("(L:N_PED_XPDR_CHAR_DISPLAYED)")
local b_xpdr_act = iDataRef:New("(L:N_FREQ_XPDR_SELECTED)")
local b_xpdr_stby = iDataRef:New("(L:N_FREQ_STANDBY_XPDR_SELECTED)")
local function xpdr_update()
    if b_xpdr_fail:Get() == 1 or (b_xpdr_power1:Get() == 0 and b_xpdr_power2:Get() == 0) then
        qmpe:OffXpdr()
        return
    end

    if b_xpdr_c_num:Get() == 4 then
        qmpe:SetXpdr(qmpe:EncXpdr(b_xpdr_act:Get()))
    else
        qmpe:SetXpdr(qmpe:EncXpdr(b_xpdr_stby:Get(), b_xpdr_c_num:Get()))
    end
end
-- =====RMP
qmpe:GetR1vhf1("(L:I_PED_RMP1_VHF1)")
qmpe:GetR1vhf2("(L:I_PED_RMP1_VHF2)")
qmpe:GetR2vhf1("(L:I_PED_RMP2_VHF1)")
qmpe:GetR2vhf2("(L:I_PED_RMP2_VHF2)")
-- =====ACP
-- VHF1 TX LIGHT
qmpe:GetSVhf1("(L:I_ASP_VHF_1_SEND)")
-- VHF1 CALL LIGHT
qmpe:GetCVhf1("(L:I_ASP_VHF_1_CALL)")
-- VHF1 RX LIGHT
qmpe:GetRVhf1("(L:I_ASP_VHF_1_REC)")
-- VHF2 TX LIGHT
qmpe:GetSVhf2("(L:I_ASP_VHF_2_SEND)")
-- VHF2 CALL LIGHT
qmpe:GetCVhf2("(L:I_ASP_VHF_2_CALL)")
-- VHF2 RX LIGHT
qmpe:GetRVhf2("(L:I_ASP_VHF_2_REC)")
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
qmpe:GetEEng("(L:I_ECAM_ENGINE)")
qmpe:GetEBleed("(L:I_ECAM_BLEED)")
qmpe:GetEPress("(L:I_ECAM_CAB_PRESS)")
qmpe:GetEElec("(L:I_ECAM_ELEC)")
qmpe:GetEHyd("(L:I_ECAM_HYD)")
qmpe:GetEFuel("(L:I_ECAM_FUEL)")
qmpe:GetEFctl("(L:I_ECAM_FCTL)")
qmpe:GetEApu("(L:I_ECAM_APU)")
qmpe:GetECond("(L:I_ECAM_COND)")
qmpe:GetEDoor("(L:I_ECAM_DOOR)")
qmpe:GetEWheel("(L:I_ECAM_WHEEL)")
qmpe:GetEClr("(L:I_ECAM_CLR_LEFT)")
qmpe:GetESts("(L:I_ECAM_STATUS)")

-- =====MISC
qmpe:GetWarn("(L:I_MIP_MASTER_WARNING_CAPT_L)")
qmpe:GetCaut("(L:I_MIP_MASTER_CAUTION_CAPT_L)")

qmpe:GetMsg("(L:I_MIP_ATC_MSG_CAPT_U)")
qmpe:GetFail("(L:I_XPDR_FAIL)")
qmpe:GetLand("(L:I_MIP_AUTOLAND_CAPT)")

qmpe:GetTerr("(L:I_MIP_GPWS_TERRAIN_ON_ND_CAPT_L)")

qmpe:GetLo("(L:I_MIP_AUTOBRAKE_LO_L)")
qmpe:GetMed("(L:I_MIP_AUTOBRAKE_MED_L)")
qmpe:GetMax("(L:I_MIP_AUTOBRAKE_MAX_L)")

qmpe:GetBkl("(L:N_PED_LIGHTING_PEDESTAL)", 30)

qmpe:GetLock1("(L:I_MIP_GEAR_1_L)")
qmpe:GetLock2("(L:I_MIP_GEAR_2_L)")
qmpe:GetLock3("(L:I_MIP_GEAR_3_L)")

qmpe:GetUnlock1("(L:I_MIP_GEAR_1_U)")
qmpe:GetUnlock2("(L:I_MIP_GEAR_2_U)")
qmpe:GetUnlock3("(L:I_MIP_GEAR_3_U)")

-- =====RMP radio
qmpe:GetRmp1("(L:N_PED_RMP1_ACTIVE)", "(L:N_PED_RMP1_STDBY)")
qmpe:GetRmp2("(L:N_PED_RMP2_ACTIVE)", "(L:N_PED_RMP2_STDBY)")
-- Expert: Fenix own logic
-- RMP1 expert mode
local b_rmp1_power = iDataRef:New("(L:B_PED_RMP1_POWER)")
local b_rmp1_data_a = iDataRef:New("(L:B_PED_RMP1_DATA_DISPLAYED_ACT)")
local b_rmp1_data_s = iDataRef:New("(L:B_PED_RMP1_DATA_DISPLAYED_STDBY)")

local b_rmp1_crs = iDataRef:New("(L:B_PED_RMP1_COURSE_DISPLAYED)")
local b_rmp1_adf = iDataRef:New("(L:I_PED_RMP1_ADF)")
local function rmp1_update()
    -- power control
    local rmp1_pow = b_rmp1_power:Get()
    if rmp1_pow == 0 then
        qmpe:OffRmp1()
        return
    end

    if b_rmp1_data_a:Get() > 0 then
        qmpe:SetRmp1DataA()
    elseif b_rmp1_data_s:Get() > 0 then
        qmpe:SetRmp1DataS()
    elseif b_rmp1_crs:Get() > 0 then
        qmpe:SetRmp1Crs()
    elseif b_rmp1_adf:Get() > 0 then
        qmpe:SetRmp1Adf()
    else
        qmpe:SetRmp1()
    end

end
-- RMP2 expert mode
local b_rmp2_power = iDataRef:New("(L:B_PED_RMP2_POWER)")
local b_rmp2_data_a = iDataRef:New("(L:B_PED_RMP2_DATA_DISPLAYED_ACT)")
local b_rmp2_data_s = iDataRef:New("(L:B_PED_RMP2_DATA_DISPLAYED_STDBY)")

local b_rmp2_crs = iDataRef:New("(L:B_PED_RMP2_COURSE_DISPLAYED)")
local b_rmp2_adf = iDataRef:New("(L:I_PED_RMP2_ADF)")
local function rmp2_update()
    -- power control
    local rmp2_pow = b_rmp2_power:Get()
    if rmp2_pow == 0 then
        qmpe:OffRmp2()
        return
    end
    -- normal data
    if b_rmp2_data_a:Get() > 0 then
        qmpe:SetRmp2DataA()
    elseif b_rmp2_data_s:Get() > 0 then
        qmpe:SetRmp2DataS()
    elseif b_rmp2_crs:Get() > 0 then
        qmpe:SetRmp2Crs()
    elseif b_rmp2_adf:Get() > 0 then
        qmpe:SetRmp2Adf()
    else
        qmpe:SetRmp2()
    end
end
-- =====Annunciator test
local dr_test = iDataRef:New("(L:S_OH_IN_LT_ANN_LT)") -- 0: DIM 1: BRT 2: test mode
function Qmpe_Test()
    qmpe:SetBklMode(1)
end

function Qmpe_Fenix_loop()
    -- expert code: test mode
    if dr_test:ChangedUpdate() then
        local b_test = dr_test:GetOld()
        if b_test == 2 then
            uluasetTimeout("Qmpe_Test()", 1000)
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
    qmpe:SetEcam()
    qmpe:SetMisc()
end

uluaAddDoLoop("Qmpe_Fenix_loop()")
