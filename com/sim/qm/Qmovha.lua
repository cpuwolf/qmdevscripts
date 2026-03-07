-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-08-25
-- *****************************************************************
local Qmovha = oop.class(com.sim.Qmdev)

function Qmovha:init()
    self.QmdevId = 9
    -- uluaLog('Qmovha:init'..self.QmdevId)
end

function Qmovha:Init()
    if ilua_hw_qmovh_a_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qmovha == 1 then
        return false
    end
    ilua_hw_assigned_qmovha = 1
    uluaSet(idr_qmovh_a_hid_mode_enable, 1)
    return true
end

-- ========
-- Backlight
function Qmovha:GetBkl(dpath, scale)
    self.d_bkl_scale = scale == nil and 30 or scale
    self.d_bkl = iDataRef:New(dpath)
end

function Qmovha:_SetBkl(idr, val)
    if val == nil then
        val = self.d_bkl:Get() * self.d_bkl_scale
        if self.d_bkl:ChangedUpdate() then
            uluaSet(idr, val)
        end
    else
        uluaSet(idr, val)
    end
end

function Qmovha:SetBkl(val)
    self:_SetBkl(idr_qmovh_a_hid_bright_int, val)
end

function Qmovha:FreshBkl()
    -- self:FreshBits()
    self.d_bkl:Invalid(-1)
end

-- ========
-- Brt/Dim
-- ========
function Qmovha:GetBrtDim(dpath, base)
    self.d_dim_base = base == nil and 1 or base
    self.d_dim = iDataRef:New(dpath)
end

function Qmovha:SetBrtDim(val)
    if val == nil then
        val = self.d_dim_base - self.d_dim:Get()
        if self.d_dim:ChangedUpdate() then
            uluaSet(idr_qmovh_a_hid_dim_brtdim, val)
        end
    else
        uluaSet(idr_qmovh_a_hid_dim_brtdim, val)
    end
end

-- ========
-- Off
function Qmovha:Off(val)
    uluaSet(idr_qmovh_a_hid_mode_off, 1)
end

-- ========
-- DN LED Start Up

function Qmovha:GetStartUp(dpath, revert)
    self:GetBit(0, dpath, revert)
end

function Qmovha:SetStartUp(valbase, val)
    self:SetBit(0, idr_qmovh_a_hid_dnled_start_up, valbase, val)
end

-- ========
-- DN LED Start Down

function Qmovha:GetStartDn(dpath, revert)
    self:GetBit(1, dpath, revert)
end

function Qmovha:SetStartDn(valbase, val)
    self:SetBit(1, idr_qmovh_a_hid_dnled_start_dn, valbase, val)
end

-- ========
-- DN LED MSW Up

function Qmovha:GetMswUp(dpath, revert)
    self:GetBit(2, dpath, revert)
end

function Qmovha:SetMswUp(valbase, val)
    self:SetBit(2, idr_qmovh_a_hid_dnled_msw_up, valbase, val)
end

-- ========
-- DN LED MSW Down

function Qmovha:GetMswDn(dpath, revert)
    self:GetBit(3, dpath, revert)
end

function Qmovha:SetMswDn(valbase, val)
    self:SetBit(3, idr_qmovh_a_hid_dnled_msw_dn, valbase, val)
end

-- ========
-- DN LED Eng2 Up

function Qmovha:GetEng2Up(dpath, revert)
    self:GetBit(4, dpath, revert)
end

function Qmovha:SetEng2Up(valbase, val)
    self:SetBit(4, idr_qmovh_a_hid_dnled_eng2_up, valbase, val)
end

-- ========
-- DN LED Eng2 Down

function Qmovha:GetEng2Dn(dpath, revert)
    self:GetBit(5, dpath, revert)
end

function Qmovha:SetEng2Dn(valbase, val)
    self:SetBit(5, idr_qmovh_a_hid_dnled_eng2_dn, valbase, val)
end

-- ========
-- DN LED Eng1 Up

function Qmovha:GetEng1Up(dpath, revert)
    self:GetBit(6, dpath, revert)
end

function Qmovha:SetEng1Up(valbase, val)
    self:SetBit(6, idr_qmovh_a_hid_dnled_eng1_up, valbase, val)
end

-- ========
-- DN LED Eng1 Down

function Qmovha:GetEng1Dn(dpath, revert)
    self:GetBit(7, dpath, revert)
end

function Qmovha:SetEng1Dn(valbase, val)
    self:SetBit(7, idr_qmovh_a_hid_dnled_eng1_dn, valbase, val)
end

-- ========
-- DN LED Pack1 Up

function Qmovha:GetPack1Up(dpath, revert)
    self:GetBit(8, dpath, revert)
end

function Qmovha:SetPack1Up(valbase, val)
    self:SetBit(8, idr_qmovh_a_hid_dnled_pack1_up, valbase, val)
end

-- ========
-- DN LED Pack1 Down

function Qmovha:GetPack1Dn(dpath, revert)
    self:GetBit(9, dpath, revert)
end

function Qmovha:SetPack1Dn(valbase, val)
    self:SetBit(9, idr_qmovh_a_hid_dnled_pack1_dn, valbase, val)
end

-- ========
-- DN LED APU B Up

function Qmovha:GetApubUp(dpath, revert)
    self:GetBit(10, dpath, revert)
end

function Qmovha:SetApubUp(valbase, val)
    self:SetBit(10, idr_qmovh_a_hid_dnled_apub_up, valbase, val)
end

-- ========
-- DN LED APU B Down

function Qmovha:GetApubDn(dpath, revert)
    self:GetBit(11, dpath, revert)
end

function Qmovha:SetApubDn(valbase, val)
    self:SetBit(11, idr_qmovh_a_hid_dnled_apub_dn, valbase, val)
end

-- ========
-- DN LED Pack2 Up

function Qmovha:GetPack2Up(dpath, revert)
    self:GetBit(12, dpath, revert)
end

function Qmovha:SetPack2Up(valbase, val)
    self:SetBit(12, idr_qmovh_a_hid_dnled_pack2_up, valbase, val)
end

-- ========
-- DN LED Pack2 Down

function Qmovha:GetPack2Dn(dpath, revert)
    self:GetBit(13, dpath, revert)
end

function Qmovha:SetPack2Dn(valbase, val)
    self:SetBit(13, idr_qmovh_a_hid_dnled_pack2_dn, valbase, val)
end

-- ========
-- DN LED Wing Up

function Qmovha:GetWingUp(dpath, revert)
    self:GetBit(14, dpath, revert)
end

function Qmovha:SetWingUp(valbase, val)
    self:SetBit(14, idr_qmovh_a_hid_dnled_wing_up, valbase, val)
end

-- ========
-- DN LED Wing Down

function Qmovha:GetWingDn(dpath, revert)
    self:GetBit(15, dpath, revert)
end

function Qmovha:SetWingDn(valbase, val)
    self:SetBit(15, idr_qmovh_a_hid_dnled_wing_dn, valbase, val)
end

-- ========
-- DN LED Crew

function Qmovha:GetCrew(dpath, revert)
    self:GetBit(16, dpath, revert)
end

function Qmovha:SetCrew(valbase, val)
    self:SetBit(16, idr_qmovh_a_hid_dnled_crew, valbase, val)
end

-- ========
-- UP LED1 Terr Up

function Qmovha:GetUpled1TerrUp(dpath, revert)
    self:GetBit(17, dpath, revert)
end

function Qmovha:SetUpled1TerrUp(valbase, val)
    self:SetBit(17, idr_qmovh_a_hid_upled1_terr_up, valbase, val)
end

-- ========
-- UP LED1 Terr Down

function Qmovha:GetUpled1TerrDn(dpath, revert)
    self:GetBit(18, dpath, revert)
end

function Qmovha:SetUpled1TerrDn(valbase, val)
    self:SetBit(18, idr_qmovh_a_hid_upled1_terr_dn, valbase, val)
end

-- ========
-- UP LED1 Sys Up

function Qmovha:GetUpled1SysUp(dpath, revert)
    self:GetBit(19, dpath, revert)
end

function Qmovha:SetUpled1SysUp(valbase, val)
    self:SetBit(19, idr_qmovh_a_hid_upled1_sys_up, valbase, val)
end

-- ========
-- UP LED1 Sys Down

function Qmovha:GetUpled1SysDn(dpath, revert)
    self:GetBit(20, dpath, revert)
end

function Qmovha:SetUpled1SysDn(valbase, val)
    self:SetBit(20, idr_qmovh_a_hid_upled1_sys_dn, valbase, val)
end

-- ========
-- UP LED1 Flap3

function Qmovha:GetUpled1Flap3(dpath, revert)
    self:GetBit(21, dpath, revert)
end

function Qmovha:SetUpled1Flap3(valbase, val)
    self:SetBit(21, idr_qmovh_a_hid_upled1_flap3, valbase, val)
end

-- ========
-- UP LED1 Gnd Ctl

function Qmovha:GetUpled1Gndctl(dpath, revert)
    self:GetBit(22, dpath, revert)
end

function Qmovha:SetUpled1Gndctl(valbase, val)
    self:SetBit(22, idr_qmovh_a_hid_upled1_gndctl, valbase, val)
end

-- ========
-- UP LED1 LTK1 Up

function Qmovha:GetUpled1Ltk1Up(dpath, revert)
    self:GetBit(23, dpath, revert)
end

function Qmovha:SetUpled1Ltk1Up(valbase, val)
    self:SetBit(23, idr_qmovh_a_hid_upled1_ltk1_up, valbase, val)
end

-- ========
-- UP LED1 LTK1 Down

function Qmovha:GetUpled1Ltk1Dn(dpath, revert)
    self:GetBit(24, dpath, revert)
end

function Qmovha:SetUpled1Ltk1Dn(valbase, val)
    self:SetBit(24, idr_qmovh_a_hid_upled1_ltk1_dn, valbase, val)
end

-- ========
-- UP LED1 ADR1 Up

function Qmovha:GetUpled1Adr1Up(dpath, revert)
    self:GetBit(25, dpath, revert)
end

function Qmovha:SetUpled1Adr1Up(valbase, val)
    self:SetBit(25, idr_qmovh_a_hid_upled1_adr1_up, valbase, val)
end

-- ========
-- UP LED1 ADR1 Down

function Qmovha:GetUpled1Adr1Dn(dpath, revert)
    self:GetBit(26, dpath, revert)
end

function Qmovha:SetUpled1Adr1Dn(valbase, val)
    self:SetBit(26, idr_qmovh_a_hid_upled1_adr1_dn, valbase, val)
end

-- ========
-- UP LED1 ADR3 Up

function Qmovha:GetUpled1Adr3Up(dpath, revert)
    self:GetBit(27, dpath, revert)
end

function Qmovha:SetUpled1Adr3Up(valbase, val)
    self:SetBit(27, idr_qmovh_a_hid_upled1_adr3_up, valbase, val)
end

-- ========
-- UP LED1 ADR3 Down

function Qmovha:GetUpled1Adr3Dn(dpath, revert)
    self:GetBit(28, dpath, revert)
end

function Qmovha:SetUpled1Adr3Dn(valbase, val)
    self:SetBit(28, idr_qmovh_a_hid_upled1_adr3_dn, valbase, val)
end

-- ========
-- UP LED1 ADR2 Up

function Qmovha:GetUpled1Adr2Up(dpath, revert)
    self:GetBit(29, dpath, revert)
end

function Qmovha:SetUpled1Adr2Up(valbase, val)
    self:SetBit(29, idr_qmovh_a_hid_upled1_adr2_up, valbase, val)
end

-- ========
-- UP LED1 ADR2 Down

function Qmovha:GetUpled1Adr2Dn(dpath, revert)
    self:GetBit(30, dpath, revert)
end

function Qmovha:SetUpled1Adr2Dn(valbase, val)
    self:SetBit(30, idr_qmovh_a_hid_upled1_adr2_dn, valbase, val)
end

-- ========
-- UP LED1 LTK2 Up

function Qmovha:GetUpled1Ltk2Up(dpath, revert)
    self:GetBit(31, dpath, revert)
end

function Qmovha:SetUpled1Ltk2Up(valbase, val)
    self:SetBit(31, idr_qmovh_a_hid_upled1_ltk2_up, valbase, val)
end

-- ========
-- UP LED1 LTK2 Down

function Qmovha:GetUpled1Ltk2Dn(dpath, revert)
    self:GetBit(32, dpath, revert)
end

function Qmovha:SetUpled1Ltk2Dn(valbase, val)
    self:SetBit(32, idr_qmovh_a_hid_upled1_ltk2_dn, valbase, val)
end

-- ========
-- UP LED1 CTKL Up

function Qmovha:GetUpled1CtklUp(dpath, revert)
    self:GetBit(33, dpath, revert)
end

function Qmovha:SetUpled1CtklUp(valbase, val)
    self:SetBit(33, idr_qmovh_a_hid_upled1_ctkl_up, valbase, val)
end

-- ========
-- UP LED1 CTKL Down

function Qmovha:GetUpled1CtklDn(dpath, revert)
    self:GetBit(34, dpath, revert)
end

function Qmovha:SetUpled1CtklDn(valbase, val)
    self:SetBit(34, idr_qmovh_a_hid_upled1_ctkl_dn, valbase, val)
end

-- ========
-- UP LED1 CTKR Up

function Qmovha:GetUpled1CtkrUp(dpath, revert)
    self:GetBit(35, dpath, revert)
end

function Qmovha:SetUpled1CtkrUp(valbase, val)
    self:SetBit(35, idr_qmovh_a_hid_upled1_ctkr_up, valbase, val)
end

-- ========
-- UP LED1 CTKR Down

function Qmovha:GetUpled1CtkrDn(dpath, revert)
    self:GetBit(36, dpath, revert)
end

function Qmovha:SetUpled1CtkrDn(valbase, val)
    self:SetBit(36, idr_qmovh_a_hid_upled1_ctkr_dn, valbase, val)
end

-- ========
-- UP LED1 Fire2

function Qmovha:GetUpled1Fire2(dpath, revert)
    self:GetBit(37, dpath, revert)
end

function Qmovha:SetUpled1Fire2(valbase, val)
    self:SetBit(37, idr_qmovh_a_hid_upled1_fire2, valbase, val)
end

-- ========
-- UP LED1 FireA

function Qmovha:GetUpled1Firea(dpath, revert)
    self:GetBit(38, dpath, revert)
end

function Qmovha:SetUpled1Firea(valbase, val)
    self:SetBit(38, idr_qmovh_a_hid_upled1_firea, valbase, val)
end

-- ========
-- UP LED1 Fire1

function Qmovha:GetUpled1Fire1(dpath, revert)
    self:GetBit(39, dpath, revert)
end

function Qmovha:SetUpled1Fire1(valbase, val)
    self:SetBit(39, idr_qmovh_a_hid_upled1_fire1, valbase, val)
end

-- ========
-- UP LED1 On Bat

function Qmovha:GetUpled1Onbat(dpath, revert)
    self:GetBit(40, dpath, revert)
end

function Qmovha:SetUpled1Onbat(valbase, val)
    self:SetBit(40, idr_qmovh_a_hid_upled1_onbat, valbase, val)
end

-- ========
-- UP LED2 RTK1 Up

function Qmovha:GetUpled2Rtk1Up(dpath, revert)
    self:GetBit(41, dpath, revert)
end

function Qmovha:SetUpled2Rtk1Up(valbase, val)
    self:SetBit(41, idr_qmovh_a_hid_upled2_rtk1_up, valbase, val)
end

-- ========
-- UP LED2 RTK1 Down

function Qmovha:GetUpled2Rtk1Dn(dpath, revert)
    self:GetBit(42, dpath, revert)
end

function Qmovha:SetUpled2Rtk1Dn(valbase, val)
    self:SetBit(42, idr_qmovh_a_hid_upled2_rtk1_dn, valbase, val)
end

-- ========
-- UP LED2 RTK2 Up

function Qmovha:GetUpled2Rtk2Up(dpath, revert)
    self:GetBit(43, dpath, revert)
end

function Qmovha:SetUpled2Rtk2Up(valbase, val)
    self:SetBit(43, idr_qmovh_a_hid_upled2_rtk2_up, valbase, val)
end

-- ========
-- UP LED2 RTK2 Down

function Qmovha:GetUpled2Rtk2Dn(dpath, revert)
    self:GetBit(44, dpath, revert)
end

function Qmovha:SetUpled2Rtk2Dn(valbase, val)
    self:SetBit(44, idr_qmovh_a_hid_upled2_rtk2_dn, valbase, val)
end

-- ========
-- UP LED2 Gen1 Up

function Qmovha:GetUpled2Gen1Up(dpath, revert)
    self:GetBit(45, dpath, revert)
end

function Qmovha:SetUpled2Gen1Up(valbase, val)
    self:SetBit(45, idr_qmovh_a_hid_upled2_gen1_up, valbase, val)
end

-- ========
-- UP LED2 Gen1 Down

function Qmovha:GetUpled2Gen1Dn(dpath, revert)
    self:GetBit(46, dpath, revert)
end

function Qmovha:SetUpled2Gen1Dn(valbase, val)
    self:SetBit(46, idr_qmovh_a_hid_upled2_gen1_dn, valbase, val)
end

-- ========
-- UP LED2 Xfeed Up

function Qmovha:GetUpled2XfeedUp(dpath, revert)
    self:GetBit(47, dpath, revert)
end

function Qmovha:SetUpled2XfeedUp(valbase, val)
    self:SetBit(47, idr_qmovh_a_hid_upled2_xfeed_up, valbase, val)
end

-- ========
-- UP LED2 Xfeed Down

function Qmovha:GetUpled2XfeedDn(dpath, revert)
    self:GetBit(48, dpath, revert)
end

function Qmovha:SetUpled2XfeedDn(valbase, val)
    self:SetBit(48, idr_qmovh_a_hid_upled2_xfeed_dn, valbase, val)
end

-- ========
-- UP LED2 Bat1 Up

function Qmovha:GetUpled2Bat1Up(dpath, revert)
    self:GetBit(49, dpath, revert)
end

function Qmovha:SetUpled2Bat1Up(valbase, val)
    self:SetBit(49, idr_qmovh_a_hid_upled2_bat1_up, valbase, val)
end

-- ========
-- UP LED2 Bat1 Down

function Qmovha:GetUpled2Bat1Dn(dpath, revert)
    self:GetBit(50, dpath, revert)
end

function Qmovha:SetUpled2Bat1Dn(valbase, val)
    self:SetBit(50, idr_qmovh_a_hid_upled2_bat1_dn, valbase, val)
end

-- ========
-- UP LED2 Bat2 Up

function Qmovha:GetUpled2Bat2Up(dpath, revert)
    self:GetBit(51, dpath, revert)
end

function Qmovha:SetUpled2Bat2Up(valbase, val)
    self:SetBit(51, idr_qmovh_a_hid_upled2_bat2_up, valbase, val)
end

-- ========
-- UP LED2 Bat2 Down

function Qmovha:GetUpled2Bat2Dn(dpath, revert)
    self:GetBit(52, dpath, revert)
end

function Qmovha:SetUpled2Bat2Dn(valbase, val)
    self:SetBit(52, idr_qmovh_a_hid_upled2_bat2_dn, valbase, val)
end

-- ========
-- UP LED2 Ext Up

function Qmovha:GetUpled2ExtUp(dpath, revert)
    self:GetBit(53, dpath, revert)
end

function Qmovha:SetUpled2ExtUp(valbase, val)
    self:SetBit(53, idr_qmovh_a_hid_upled2_ext_up, valbase, val)
end

-- ========
-- UP LED2 Ext Down

function Qmovha:GetUpled2ExtDn(dpath, revert)
    self:GetBit(54, dpath, revert)
end

function Qmovha:SetUpled2ExtDn(valbase, val)
    self:SetBit(54, idr_qmovh_a_hid_upled2_ext_dn, valbase, val)
end

-- ========
-- UP LED2 Gen2 Up

function Qmovha:GetUpled2Gen2Up(dpath, revert)
    self:GetBit(55, dpath, revert)
end

function Qmovha:SetUpled2Gen2Up(valbase, val)
    self:SetBit(55, idr_qmovh_a_hid_upled2_gen2_up, valbase, val)
end

-- ========
-- UP LED2 Gen2 Down

function Qmovha:GetUpled2Gen2Dn(dpath, revert)
    self:GetBit(56, dpath, revert)
end

function Qmovha:SetUpled2Gen2Dn(valbase, val)
    self:SetBit(56, idr_qmovh_a_hid_upled2_gen2_dn, valbase, val)
end

-- ========
-- UP LED2 Eng1AG1

function Qmovha:GetUpled2Eng1ag1(dpath, revert)
    self:GetBit(57, dpath, revert)
end

function Qmovha:SetUpled2Eng1ag1(valbase, val)
    self:SetBit(57, idr_qmovh_a_hid_upled2_eng1ag1, valbase, val)
end

-- ========
-- UP LED2 Eng1AG2

function Qmovha:GetUpled2Eng1ag2(dpath, revert)
    self:GetBit(58, dpath, revert)
end

function Qmovha:SetUpled2Eng1ag2(valbase, val)
    self:SetBit(58, idr_qmovh_a_hid_upled2_eng1ag2, valbase, val)
end

-- ========
-- UP LED2 Eng2AG1

function Qmovha:GetUpled2Eng2ag1(dpath, revert)
    self:GetBit(59, dpath, revert)
end

function Qmovha:SetUpled2Eng2ag1(valbase, val)
    self:SetBit(59, idr_qmovh_a_hid_upled2_eng2ag1, valbase, val)
end

-- ========
-- UP LED2 Eng2AG2

function Qmovha:GetUpled2Eng2ag2(dpath, revert)
    self:GetBit(60, dpath, revert)
end

function Qmovha:SetUpled2Eng2ag2(valbase, val)
    self:SetBit(60, idr_qmovh_a_hid_upled2_eng2ag2, valbase, val)
end

function Qmovha:SetDnled(valbase, val)
    self:SetStartUp(valbase, val)
    self:SetStartDn(valbase, val)
    self:SetMswUp(valbase, val)
    self:SetMswDn(valbase, val)
    self:SetEng2Up(valbase, val)
    self:SetEng2Dn(valbase, val)
    self:SetEng1Up(valbase, val)
    self:SetEng1Dn(valbase, val)
    self:SetPack1Up(valbase, val)
    self:SetPack1Dn(valbase, val)
    self:SetApubUp(valbase, val)
    self:SetApubDn(valbase, val)
    self:SetPack2Up(valbase, val)
    self:SetPack2Dn(valbase, val)
    self:SetWingUp(valbase, val)
    self:SetWingDn(valbase, val)
    self:SetCrew(valbase, val)
end

function Qmovha:SetUpled1(valbase, val)
    self:SetUpled1TerrUp(valbase, val)
    self:SetUpled1TerrDn(valbase, val)
    self:SetUpled1SysUp(valbase, val)
    self:SetUpled1SysDn(valbase, val)
    self:SetUpled1Flap3(valbase, val)
    self:SetUpled1Gndctl(valbase, val)
    self:SetUpled1Ltk1Up(valbase, val)
    self:SetUpled1Ltk1Dn(valbase, val)
    self:SetUpled1Adr1Up(valbase, val)
    self:SetUpled1Adr1Dn(valbase, val)
    self:SetUpled1Adr3Up(valbase, val)
    self:SetUpled1Adr3Dn(valbase, val)
    self:SetUpled1Adr2Up(valbase, val)
    self:SetUpled1Adr2Dn(valbase, val)
    self:SetUpled1Ltk2Up(valbase, val)
    self:SetUpled1Ltk2Dn(valbase, val)
    self:SetUpled1CtklUp(valbase, val)
    self:SetUpled1CtklDn(valbase, val)
    self:SetUpled1CtkrUp(valbase, val)
    self:SetUpled1CtkrDn(valbase, val)
    self:SetUpled1Fire2(valbase, val)
    self:SetUpled1Firea(valbase, val)
    self:SetUpled1Fire1(valbase, val)
    self:SetUpled1Onbat(valbase, val)
end

function Qmovha:SetUpled2(valbase, val)
    self:SetUpled2Rtk1Up(valbase, val)
    self:SetUpled2Rtk1Dn(valbase, val)
    self:SetUpled2Rtk2Up(valbase, val)
    self:SetUpled2Rtk2Dn(valbase, val)
    self:SetUpled2Gen1Up(valbase, val)
    self:SetUpled2Gen1Dn(valbase, val)
    self:SetUpled2XfeedUp(valbase, val)
    self:SetUpled2XfeedDn(valbase, val)
    self:SetUpled2Bat1Up(valbase, val)
    self:SetUpled2Bat1Dn(valbase, val)
    self:SetUpled2Bat2Up(valbase, val)
    self:SetUpled2Bat2Dn(valbase, val)
    self:SetUpled2ExtUp(valbase, val)
    self:SetUpled2ExtDn(valbase, val)
    self:SetUpled2Gen2Up(valbase, val)
    self:SetUpled2Gen2Dn(valbase, val)
    self:SetUpled2Eng1ag1(valbase, val)
    self:SetUpled2Eng1ag2(valbase, val)
    self:SetUpled2Eng2ag1(valbase, val)
    self:SetUpled2Eng2ag2(valbase, val)
end

function Qmovha:FreshAllled()
    for i = 0, 60 do
        self:FreshBit(i)
    end
end

function Qmovha:FreshUpled2()
    for i = 41, 60 do
        self:FreshBit(i)
    end
end

-- ========
-- Air Condition(Pack)
-- ========
function Qmovha:GetAirCond(onoff, degree, degree_scale, degree_offset)
    self.d_ac_onoff = iDataRef:New(onoff)
    self.d_ac_temp = iDataRef:New(degree)
    self.d_ac_temp_scale = degree_scale == nil and 1 or degree_scale
    self.d_ac_temp_offset = degree_offset == nil and 0 or degree_offset
end

function Qmovha:SetAirCond()
    onoff = self.d_ac_onoff:Get()
    degree = self.d_ac_temp:Get()
    if self.d_ac_onoff:ChangedUpdate() or self.d_ac_temp:ChangedUpdate() then
        if uluaSetAC ~= nil then
            uluaSetAC(onoff, degree * self.d_ac_temp_scale + self.d_ac_temp_offset)
        end
    end
end

return Qmovha
