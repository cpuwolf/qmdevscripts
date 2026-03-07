-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qmpe = oop.class(com.sim.Qmdev)

function Qmpe:init()
    self.QmdevId = 8
    -- uluaLog('Qmpe:init'..self.QmdevId)
end

function Qmpe:Init()
    if ilua_hw_qmpe_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qmpe == 1 then
        return false
    end
    ilua_hw_assigned_qmpe = 1
    return true
end

-- ========================= RMP VHF1/2
-- RMP1
function Qmpe:GetRmp1(dcom1, dcom1s, scale)
    self.d_rmp1_scale = scale == nil and 1 or scale
    self.d_rmp1 = iDataRef:New(dcom1)
    self.d_rmp1s = iDataRef:New(dcom1s)
end

function Qmpe:SetRmp1A(val)
    if val == nil then
        val = self.d_rmp1:Get()
        if self.d_rmp1:ChangedUpdate() then
            if val > 0 then
                uluaSet(idr_qmpe_hid_vhf1a_int, val * self.d_rmp1_scale)
            end
        end
    else
        uluaSet(idr_qmpe_hid_vhf1a_int, val)
        uluaSet(idr_qmpe_hid_vhf1a_mode, 1)
    end
end

function Qmpe:SetRmp1S(val)
    if val == nil then
        local val = self.d_rmp1s:Get()
        if self.d_rmp1s:ChangedUpdate() then
            if val > 0 then
                uluaSet(idr_qmpe_hid_vhf1s_int, val * self.d_rmp1_scale)
            end
        end
    else
        uluaSet(idr_qmpe_hid_vhf1s_int, val)
        uluaSet(idr_qmpe_hid_vhf1s_mode, 1)
    end
end

function Qmpe:FreshRmp1()
    self.d_rmp1:Invalid(-1)
    self.d_rmp1s:Invalid(-1)
end

function Qmpe:SetRmp1SCrs(val)
    self:SetRmp1S(val)
    uluaSet(idr_qmpe_hid_vhf1s_mode, 4)
end

function Qmpe:SetRmp1AAdf(val)
    self:SetRmp1A(val)
    uluaSet(idr_qmpe_hid_vhf1a_mode, 5)
end

function Qmpe:SetRmp1SAdf(val)
    self:SetRmp1S(val)
    uluaSet(idr_qmpe_hid_vhf1s_mode, 5)
end

function Qmpe:SetRmp1(dcom1, dcom1s)
    if dcom1 == nil then
        self:SetRmp1A()
        uluaSet(idr_qmpe_hid_vhf1a_mode, 1)
        self:SetRmp1S()
        uluaSet(idr_qmpe_hid_vhf1s_mode, 1)
    else
        self:SetRmp1A(dcom1)
        self:SetRmp1S(dcom1s)
    end
end

function Qmpe:OffRmp1()
    self.d_rmp1:Invalid(-1)
    self.d_rmp1s:Invalid(-1)
    uluaSet(idr_qmpe_hid_vhf1a_mode, 0)
    uluaSet(idr_qmpe_hid_vhf1s_mode, 0)
end

function Qmpe:SetRmp1DataA(val)
    self:SetRmp1A()
    uluaSet(idr_qmpe_hid_vhf1a_mode, 3)
    if val == nil then
        val = self.d_rmp1s:Get()
        if val > 0 then
            uluaSet(idr_qmpe_hid_vhf1s_int, val)
            uluaSet(idr_qmpe_hid_vhf1s_mode, 1)
        end
    else
        uluaSet(idr_qmpe_hid_vhf1s_int, val)
        uluaSet(idr_qmpe_hid_vhf1s_mode, 1)
    end
end

function Qmpe:SetRmp1DataS(val)
    self:SetRmp1S()
    uluaSet(idr_qmpe_hid_vhf1s_mode, 3)
    if val == nil then
        val = self.d_rmp1:Get()
        if val > 0 then
            uluaSet(idr_qmpe_hid_vhf1a_int, val)
            uluaSet(idr_qmpe_hid_vhf1a_mode, 1)
        end
    else
        uluaSet(idr_qmpe_hid_vhf1a_int, val)
        uluaSet(idr_qmpe_hid_vhf1a_mode, 1)
    end
end

function Qmpe:SetRmp1Crs(val)
    self:SetRmp1A()
    uluaSet(idr_qmpe_hid_vhf1a_mode, 1)
    if val == nil then
        val = self.d_rmp1s:Get()
        if val >= 0 then
            uluaSet(idr_qmpe_hid_vhf1s_int, val)
            uluaSet(idr_qmpe_hid_vhf1s_mode, 4)
        end
    else
        uluaSet(idr_qmpe_hid_vhf1s_int, val)
        uluaSet(idr_qmpe_hid_vhf1s_mode, 4)
    end
end

function Qmpe:SetRmp1Adf(valscale)
    valscale = valscale == nil and 1 or valscale
    local val = self.d_rmp1:Get()
    if val > 0 then
        uluaSet(idr_qmpe_hid_vhf1a_int, val * valscale)
        uluaSet(idr_qmpe_hid_vhf1a_mode, 5)
    end

    val = self.d_rmp1s:Get()
    if val > 0 then
        uluaSet(idr_qmpe_hid_vhf1s_int, val * valscale)
        uluaSet(idr_qmpe_hid_vhf1s_mode, 5)
    end
end

-- RMP2
function Qmpe:GetRmp2(dcom2, dcom2s, scale)
    self.d_rmp2_scale = scale == nil and 1 or scale
    self.d_rmp2 = iDataRef:New(dcom2)
    self.d_rmp2s = iDataRef:New(dcom2s)
end

function Qmpe:SetRmp2A(val)
    if val == nil then
        local val = self.d_rmp2:Get()
        if self.d_rmp2:ChangedUpdate() then
            if val > 0 then
                uluaSet(idr_qmpe_hid_vhf2a_int, val * self.d_rmp2_scale)
            end
        end
    else
        uluaSet(idr_qmpe_hid_vhf2a_int, val)
        uluaSet(idr_qmpe_hid_vhf2a_mode, 1)
    end
end

function Qmpe:SetRmp2S(val)
    if val == nil then
        local val = self.d_rmp2s:Get()
        if self.d_rmp2s:ChangedUpdate() then
            if val > 0 then
                uluaSet(idr_qmpe_hid_vhf2s_int, val * self.d_rmp2_scale)
            end
        end
    else
        uluaSet(idr_qmpe_hid_vhf2s_int, val)
        uluaSet(idr_qmpe_hid_vhf2s_mode, 1)
    end
end

function Qmpe:FreshRmp2()
    self.d_rmp2:Invalid(-1)
    self.d_rmp2s:Invalid(-1)
end

function Qmpe:SetRmp2SCrs(val)
    self:SetRmp2S(val)
    uluaSet(idr_qmpe_hid_vhf2s_mode, 4)
end

function Qmpe:SetRmp2AAdf(val)
    self:SetRmp2A(val)
    uluaSet(idr_qmpe_hid_vhf2a_mode, 5)
end

function Qmpe:SetRmp2SAdf(val)
    self:SetRmp2S(val)
    uluaSet(idr_qmpe_hid_vhf2s_mode, 5)
end

function Qmpe:SetRmp2(dcom2, dcom2s)
    if dcom2 == nil then
        self:SetRmp2A()
        uluaSet(idr_qmpe_hid_vhf2a_mode, 1)
        self:SetRmp2S()
        uluaSet(idr_qmpe_hid_vhf2s_mode, 1)
    else
        self:SetRmp2A(dcom2)
        self:SetRmp2S(dcom2s)
    end
end

function Qmpe:OffRmp2()
    self.d_rmp2:Invalid(-1)
    self.d_rmp2s:Invalid(-1)
    uluaSet(idr_qmpe_hid_vhf2a_mode, 0)
    uluaSet(idr_qmpe_hid_vhf2s_mode, 0)
end

function Qmpe:SetRmp2DataA(val)
    self:SetRmp2A()
    uluaSet(idr_qmpe_hid_vhf2a_mode, 3)
    if val == nil then
        val = self.d_rmp2s:Get()
        if val > 0 then
            uluaSet(idr_qmpe_hid_vhf2s_int, val)
            uluaSet(idr_qmpe_hid_vhf2s_mode, 1)
        end
    else
        uluaSet(idr_qmpe_hid_vhf2s_int, val)
        uluaSet(idr_qmpe_hid_vhf2s_mode, 1)
    end
end

function Qmpe:SetRmp2DataS(val)
    self:SetRmp2S()
    uluaSet(idr_qmpe_hid_vhf2s_mode, 3)
    if val == nil then
        val = self.d_rmp2:Get()
        if val > 0 then
            uluaSet(idr_qmpe_hid_vhf2a_int, val)
            uluaSet(idr_qmpe_hid_vhf2a_mode, 1)
        end
    else
        uluaSet(idr_qmpe_hid_vhf2a_int, val)
        uluaSet(idr_qmpe_hid_vhf2a_mode, 1)
    end
end

function Qmpe:SetRmp2Crs(val)
    self:SetRmp2A()
    uluaSet(idr_qmpe_hid_vhf2a_mode, 1)
    if val == nil then
        val = self.d_rmp2s:Get()
        if val > 0 then
            uluaSet(idr_qmpe_hid_vhf2s_int, val)
            uluaSet(idr_qmpe_hid_vhf2s_mode, 4)
        end
    else
        uluaSet(idr_qmpe_hid_vhf2s_int, val)
        uluaSet(idr_qmpe_hid_vhf2s_mode, 4)
    end
end

function Qmpe:SetRmp2Adf(valscale)
    valscale = valscale == nil and 1 or valscale
    local val = self.d_rmp2:Get()
    if val > 0 then
        uluaSet(idr_qmpe_hid_vhf2a_int, val * valscale)
        uluaSet(idr_qmpe_hid_vhf2a_mode, 5)
    end

    val = self.d_rmp2s:Get()
    if val > 0 then
        uluaSet(idr_qmpe_hid_vhf2s_int, val * valscale)
        uluaSet(idr_qmpe_hid_vhf2s_mode, 5)
    end
end
-- ========================= XPDR
-- XPDR code 1~4 digi
function Qmpe:GetXpdr(dpath)
    self.d_xpdr = iDataRef:New(dpath)
end

function Qmpe:_SetXpdr(val)
    if val > 0 then
        uluaSet(idr_qmpe_hid_xpdr_int, val)
        uluaSet(idr_qmpe_hid_xpdr_mode, 1)
    else
        uluaSet(idr_qmpe_hid_xpdr_mode, 0)
    end
end
function Qmpe:SetXpdr(val)
    if val == nil then
        val = self.d_xpdr:Get()
        if self.d_xpdr:ChangedUpdate() then
            self:_SetXpdr(self:EncXpdr(val))
        end
    else
        self:_SetXpdr(val)
    end
end

function Qmpe:FreshXpdr()
    self.d_xpdr:Invalid(-1)
end

function Qmpe:OffXpdr()
    uluaSet(idr_qmpe_hid_xpdr_mode, 0)
end

function Qmpe:EncXpdr(xcode, diginum)
    local val = xcode
    diginum = diginum == nil and 4 or diginum
    if xcode < 1000 and diginum >= 4 then
        val = val + 9000
    end
    if xcode < 100 and diginum >= 3 then
        val = val + 900
    end
    if xcode < 10 and diginum >= 2 then
        val = val + 90
    end
    if xcode == 0 and diginum == 1 then
        val = 9
    end
    return val
end

-- digial 9 is hidden digi
-- return xcode, diginum
function Qmpe:XpdrDecode9(xcode)
    local newcode = 0
    local diginum = 0
    local digis = {}
    -- extract 1234={1, 2, 3, 4}
    local val = math.floor(xcode / 1000)
    digis[1] = val
    xcode = xcode - val * 1000
    val = math.floor(xcode / 100)
    digis[2] = val
    xcode = xcode - val * 100
    val = math.floor(xcode / 10)
    digis[3] = val
    xcode = xcode - val * 10
    val = xcode
    digis[4] = val

    for i = 1, 4 do
        if digis[i] == 9 then
            break
        else
            diginum = diginum + 1
        end
    end

    for i = 1, diginum do
        newcode = newcode + (digis[i] * (10 ^ (diginum - i)))
    end

    return newcode, diginum
end

-- ========================= RMP
-- RMP R1VHF1
function Qmpe:GetR1vhf1(dpath)
    self.d_rmp_r1vhf1 = iDataRef:New(dpath)
end

function Qmpe:SetR1vhf1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_rmp_r1vhf1:Get()
        if self.d_rmp_r1vhf1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_rmp_r1vhf1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_rmp_r1vhf1, ilua_bool_ternary(val, valbase))
    end
end

function Qmpe:OffR1vhf1(dpath)
    self.d_rmp_r1vhf1:Invalid()
    uluaSet(idr_qmpe_hid_rmp_r1vhf1, 0)
end
-- RMP R1VHF2
function Qmpe:GetR1vhf2(dpath)
    self.d_rmp_r1vhf2 = iDataRef:New(dpath)
end

function Qmpe:SetR1vhf2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_rmp_r1vhf2:Get()
        if self.d_rmp_r1vhf2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_rmp_r1vhf2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_rmp_r1vhf2, ilua_bool_ternary(val, valbase))
    end
end

function Qmpe:OffR1vhf2(dpath)
    self.d_rmp_r1vhf2:Invalid()
    uluaSet(idr_qmpe_hid_rmp_r1vhf2, 0)
end

-- RMP R2VHF1
function Qmpe:GetR2vhf1(dpath)
    self.d_rmp_r2vhf1 = iDataRef:New(dpath)
end

function Qmpe:SetR2vhf1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_rmp_r2vhf1:Get()
        if self.d_rmp_r2vhf1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_rmp_r2vhf1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_rmp_r2vhf1, ilua_bool_ternary(val, valbase))
    end
end

function Qmpe:OffR2vhf1(dpath)
    self.d_rmp_r2vhf1:Invalid()
    uluaSet(idr_qmpe_hid_rmp_r2vhf1, 0)
end

-- RMP R2VHF2
function Qmpe:GetR2vhf2(dpath)
    self.d_rmp_r2vhf2 = iDataRef:New(dpath)
end

function Qmpe:SetR2vhf2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_rmp_r2vhf2:Get()
        if self.d_rmp_r2vhf2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_rmp_r2vhf2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_rmp_r2vhf2, ilua_bool_ternary(val, valbase))
    end
end

function Qmpe:OffR2vhf2(dpath)
    self.d_rmp_r2vhf2:Invalid()
    uluaSet(idr_qmpe_hid_rmp_r2vhf2, 0)
end

function Qmpe:SetRmp()
    self:SetR1vhf1()
    self:SetR1vhf2()
    self:SetR2vhf1()
    self:SetR2vhf2()
end

function Qmpe:OffRmp()
    self:OffR1vhf1()
    self:OffR1vhf2()
    self:OffR2vhf1()
    self:OffR2vhf2()
end

-- =========================ACP
-- send VHF1
function Qmpe:GetSVhf1(dpath)
    self.d_s_vhf1 = iDataRef:New(dpath)
end

function Qmpe:SetSVhf1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_s_vhf1:Get()
        if self.d_s_vhf1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_s_vhf1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_s_vhf1, ilua_bool_ternary(val, valbase))
    end
end

-- Call VHF1
function Qmpe:GetCVhf1(dpath)
    self.d_c_vhf1 = iDataRef:New(dpath)
end

function Qmpe:SetCVhf1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_c_vhf1:Get()
        if self.d_c_vhf1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_c_vhf1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_c_vhf1, ilua_bool_ternary(val, valbase))
    end
end

-- receive VHF1
function Qmpe:GetRVhf1(dpath)
    self.d_r_vhf1 = iDataRef:New(dpath)
end

function Qmpe:SetRVhf1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_r_vhf1:Get()
        if self.d_r_vhf1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_r_vhf1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_r_vhf1, ilua_bool_ternary(val, valbase))
    end
end
-- ========
-- send VHF2
function Qmpe:GetSVhf2(dpath)
    self.d_s_vhf2 = iDataRef:New(dpath)
end

function Qmpe:SetSVhf2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_s_vhf2:Get()
        if self.d_s_vhf2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_s_vhf2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_s_vhf2, ilua_bool_ternary(val, valbase))
    end
end

-- Call VHF2
function Qmpe:GetCVhf2(dpath)
    self.d_c_vhf2 = iDataRef:New(dpath)
end

function Qmpe:SetCVhf2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_c_vhf2:Get()
        if self.d_c_vhf2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_c_vhf2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_c_vhf2, ilua_bool_ternary(val, valbase))
    end
end

-- receive VHF2
function Qmpe:GetRVhf2(dpath)
    self.d_r_vhf2 = iDataRef:New(dpath)
end

function Qmpe:SetRVhf2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_r_vhf2:Get()
        if self.d_r_vhf2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_r_vhf2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_r_vhf2, ilua_bool_ternary(val, valbase))
    end
end
-- ========
-- send INT/MECH
function Qmpe:GetSMech(dpath)
    self.d_s_mech = iDataRef:New(dpath)
end

function Qmpe:SetSMech(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_s_mech:Get()
        if self.d_s_mech:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_s_mech, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_s_mech, ilua_bool_ternary(val, valbase))
    end
end

-- Call INT/MECH
function Qmpe:GetCMech(dpath)
    self.d_c_mech = iDataRef:New(dpath)
end

function Qmpe:SetCMech(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_c_mech:Get()
        if self.d_c_mech:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_c_mech, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_c_mech, ilua_bool_ternary(val, valbase))
    end
end

-- receive INT/MECH
function Qmpe:GetRMech(dpath)
    self.d_r_mech = iDataRef:New(dpath)
end

function Qmpe:SetRMech(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_r_mech:Get()
        if self.d_r_mech:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_r_int, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_r_int, ilua_bool_ternary(val, valbase))
    end
end
-- ========
-- send ATT/CAB
function Qmpe:GetSAtt(dpath)
    self.d_s_att = iDataRef:New(dpath)
end

function Qmpe:SetSAtt(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_s_att:Get()
        if self.d_s_att:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_s_att, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_s_att, ilua_bool_ternary(val, valbase))
    end
end

-- Call ATT/CAB
function Qmpe:GetCAtt(dpath)
    self.d_c_att = iDataRef:New(dpath)
end

function Qmpe:SetCAtt(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_c_att:Get()
        if self.d_c_att:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_c_att, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_c_att, ilua_bool_ternary(val, valbase))
    end
end

-- receive ATT/CAB
function Qmpe:GetRAtt(dpath)
    self.d_r_att = iDataRef:New(dpath)
end

function Qmpe:SetRAtt(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_r_att:Get()
        if self.d_r_att:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_r_cab, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_r_cab, ilua_bool_ternary(val, valbase))
    end
end

-- ========
-- send PA
function Qmpe:GetSPa(dpath)
    self.d_s_pa = iDataRef:New(dpath)
end

function Qmpe:SetSPa(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_s_pa:Get()
        if self.d_s_pa:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_s_pa, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_s_pa, ilua_bool_ternary(val, valbase))
    end
end

-- receive PA
function Qmpe:GetRPa(dpath)
    self.d_r_pa = iDataRef:New(dpath)
end

function Qmpe:SetRPa(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_r_pa:Get()
        if self.d_r_pa:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_acp_r_pa, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_acp_r_pa, ilua_bool_ternary(val, valbase))
    end
end
-- set ACP all
function Qmpe:SetAcp()
    self:SetSVhf1()
    self:SetCVhf1()
    self:SetRVhf1()
    --
    self:SetSVhf2()
    self:SetCVhf2()
    self:SetRVhf2()
    --
    self:SetSMech()
    self:SetCMech()
    self:SetRMech()
    self:SetSAtt()
    self:SetCAtt()
    self:SetRAtt()
    self:SetSPa()
    self:SetRPa()
end
-- set ACP off
function Qmpe:OffAcp()
    uluaSet(idr_qmpe_hid_acp_int, 0)
end
-- =========================ECAM
-- ========
-- ECAM ENG
function Qmpe:GetEEng(dpath)
    self.d_ec_eng = iDataRef:New(dpath)
end

function Qmpe:SetEEng(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_eng:Get()
        if self.d_ec_eng:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_eng, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_eng, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM BLEED
function Qmpe:GetEBleed(dpath)
    self.d_ec_bleed = iDataRef:New(dpath)
end

function Qmpe:SetEBleed(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_bleed:Get()
        if self.d_ec_bleed:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_bleed, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_bleed, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM PRESS
function Qmpe:GetEPress(dpath)
    self.d_ec_press = iDataRef:New(dpath)
end

function Qmpe:SetEPress(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_press:Get()
        if self.d_ec_press:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_press, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_press, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM ELEC
function Qmpe:GetEElec(dpath)
    self.d_ec_elec = iDataRef:New(dpath)
end

function Qmpe:SetEElec(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_elec:Get()
        if self.d_ec_elec:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_elec, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_elec, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM ELEC AC DC
function Qmpe:GetEElecAcDc(dpath, d_dc_path)
    self.d_ec_elec = iDataRef:New(dpath)
    self.d_ec_elec_dc = iDataRef:New(d_dc_path)

end

function Qmpe:SetEElecAcDc(valbase, val)
    valbase = valbase == nil and 0 or valbase
    local val_dc
    if val == nil then
        val = self.d_ec_elec:Get()
        val_dc = self.d_ec_elec_dc:Get()

        if self.d_ec_elec:ChangedUpdate() or self.d_ec_elec_dc:ChangedUpdate() then
            val = (val + val_dc) / 2
            uluaSet(idr_qmpe_hid_ec_elec, ilua_bool_ternary(val, valbase))
        end
    else
        val = (val + val_dc) / 2
        uluaSet(idr_qmpe_hid_ec_elec, ilua_bool_ternary(val, valbase))
    end
end

-- ECAM HYD
function Qmpe:GetEHyd(dpath)
    self.d_ec_hyd = iDataRef:New(dpath)
end

function Qmpe:SetEHyd(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_hyd:Get()
        if self.d_ec_hyd:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_hyd, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_hyd, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM FUEL
function Qmpe:GetEFuel(dpath)
    self.d_ec_fuel = iDataRef:New(dpath)
end

function Qmpe:SetEFuel(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_fuel:Get()
        if self.d_ec_fuel:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_fuel, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_fuel, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM FCTL
function Qmpe:GetEFctl(dpath)
    self.d_ec_fctl = iDataRef:New(dpath)
end

function Qmpe:SetEFctl(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_fctl:Get()
        if self.d_ec_fctl:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_fctl, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_fctl, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM APU
function Qmpe:GetEApu(dpath)
    self.d_ec_apu = iDataRef:New(dpath)
end

function Qmpe:SetEApu(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_apu:Get()
        if self.d_ec_apu:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_apu, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_apu, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM COND
function Qmpe:GetECond(dpath)
    self.d_ec_cond = iDataRef:New(dpath)
end

function Qmpe:SetECond(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_cond:Get()
        if self.d_ec_cond:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_cond, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_cond, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM DOOR
function Qmpe:GetEDoor(dpath)
    self.d_ec_door = iDataRef:New(dpath)
end

function Qmpe:SetEDoor(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_door:Get()
        if self.d_ec_door:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_door, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_door, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM WHEEL
function Qmpe:GetEWheel(dpath)
    self.d_ec_wheel = iDataRef:New(dpath)
end

function Qmpe:SetEWheel(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_wheel:Get()
        if self.d_ec_wheel:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_wheel, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_wheel, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM CLR
function Qmpe:GetEClr(dpath)
    self.d_ec_clr = iDataRef:New(dpath)
end

function Qmpe:SetEClr(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_clr:Get()
        if self.d_ec_clr:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_clr, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_clr, ilua_bool_ternary(val, valbase))
    end
end
-- ECAM STS
function Qmpe:GetESts(dpath)
    self.d_ec_sts = iDataRef:New(dpath)
end

function Qmpe:SetESts(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_ec_sts:Get()
        if self.d_ec_sts:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_ec_sts, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_ec_sts, ilua_bool_ternary(val, valbase))
    end
end

-- ECAM all
function Qmpe:SetEcam(valbase)
    valbase = valbase == nil and 0 or valbase
    self:SetEEng(valbase)
    self:SetEBleed(valbase)
    self:SetEPress(valbase)
    self:SetEElec(valbase)
    self:SetEHyd(valbase)
    self:SetEFuel(valbase)
    self:SetEFctl(valbase)
    self:SetEApu(valbase)
    self:SetECond(valbase)
    self:SetEDoor(valbase)
    self:SetEWheel(valbase)
    self:SetEClr(valbase)
    self:SetESts(valbase)
end

function Qmpe:SetEcamAcDc(valbase)
    valbase = valbase == nil and 0 or valbase
    self:SetEEng(valbase)
    self:SetEBleed(valbase)
    self:SetEPress(valbase)
    self:SetEElecAcDc(valbase)
    self:SetEHyd(valbase)
    self:SetEFuel(valbase)
    self:SetEFctl(valbase)
    self:SetEApu(valbase)
    self:SetECond(valbase)
    self:SetEDoor(valbase)
    self:SetEWheel(valbase)
    self:SetEClr(valbase)
    self:SetESts(valbase)
end

-- set ECAM off
function Qmpe:OffEcam()
    uluaSet(idr_qmpe_hid_ec_int, 0)
end

-- ========
-- Backlight
function Qmpe:GetBkl(dpath, scale)
    self.d_bkl_scale = scale == nil and 30 or scale
    self.d_bkl = iDataRef:New(dpath)
end

function Qmpe:SetBkl(val)
    if val == nil then
        val = self.d_bkl:Get() * self.d_bkl_scale
        if self.d_bkl:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_bright_int, val)
        end
    else
        uluaSet(idr_qmpe_hid_bright_int, val)
    end
end

function Qmpe:FreshBkl()
    self.d_bkl:Invalid(-1)
end

-- Backlight mode
function Qmpe:GetBklMode(dpath)
    self.d_bklmod = iDataRef:New(dpath)
end

function Qmpe:SetBklMode(val)
    if val == nil then
        val = self.d_bklmod:Get()
        if self.d_bklmod:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_bright_mode, val)
        end
    else
        uluaSet(idr_qmpe_hid_bright_mode, val)
    end
end
-- Backlight ctrl
function Qmpe:GetBklCtrl(dpath)
    self.d_bklctrl = iDataRef:New(dpath)
end

function Qmpe:SetBklCtrl(val)
    if val == nil then
        val = self.d_bklctrl:Get()
        if self.d_bklctrl:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_bright_ctrl, val)
        end
    else
        uluaSet(idr_qmpe_hid_bright_ctrl, val)
    end
end

-- ========
-- MISC WARN
function Qmpe:GetWarn(dpath)
    self.d_misc_warn = iDataRef:New(dpath)
end

function Qmpe:SetWarn(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_warn:Get()
        if self.d_misc_warn:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_warn, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_warn, ilua_bool_ternary(val, valbase))
    end
end
-- MISC CAUT
function Qmpe:GetCaut(dpath)
    self.d_misc_caut = iDataRef:New(dpath)
end

function Qmpe:SetCaut(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_caut:Get()
        if self.d_misc_caut:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_caut, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_caut, ilua_bool_ternary(val, valbase))
    end
end
-- MISC LOCK3
function Qmpe:GetLock3(dpath)
    self.d_misc_lock3 = iDataRef:New(dpath)
end

function Qmpe:SetLock3(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_lock3:Get()
        if self.d_misc_lock3:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_lock3, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_lock3, ilua_bool_ternary(val, valbase))
    end
end
-- MISC LOCK2
function Qmpe:GetLock2(dpath)
    self.d_misc_lock2 = iDataRef:New(dpath)
end

function Qmpe:SetLock2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_lock2:Get()
        if self.d_misc_lock2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_lock2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_lock2, ilua_bool_ternary(val, valbase))
    end
end
-- MISC LOCK1
function Qmpe:GetLock1(dpath)
    self.d_misc_lock1 = iDataRef:New(dpath)
end

function Qmpe:SetLock1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_lock1:Get()
        if self.d_misc_lock1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_lock1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_lock1, ilua_bool_ternary(val, valbase))
    end
end
-- MISC UNLOCK3
function Qmpe:GetUnlock3(dpath)
    self.d_misc_unlock3 = iDataRef:New(dpath)
end

function Qmpe:SetUnlock3(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_unlock3:Get()
        if self.d_misc_unlock3:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_unlock3, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_unlock3, ilua_bool_ternary(val, valbase))
    end
end
-- MISC UNLOCK2
function Qmpe:GetUnlock2(dpath)
    self.d_misc_unlock2 = iDataRef:New(dpath)
end

function Qmpe:SetUnlock2(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_unlock2:Get()
        if self.d_misc_unlock2:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_unlock2, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_unlock2, ilua_bool_ternary(val, valbase))
    end
end
-- MISC UNLOCK1
function Qmpe:GetUnlock1(dpath)
    self.d_misc_unlock1 = iDataRef:New(dpath)
end

function Qmpe:SetUnlock1(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_unlock1:Get()
        if self.d_misc_unlock1:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_unlock1, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_unlock1, ilua_bool_ternary(val, valbase))
    end
end
-- MISC MSG
function Qmpe:GetMsg(dpath)
    self.d_misc_msg = iDataRef:New(dpath)
end

function Qmpe:SetMsg(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_msg:Get()
        if self.d_misc_msg:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_msg, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_msg, ilua_bool_ternary(val, valbase))
    end
end
-- MISC FAIL
function Qmpe:GetFail(dpath)
    self.d_misc_fail = iDataRef:New(dpath)
end

function Qmpe:SetFail(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_fail:Get()
        if self.d_misc_fail:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_fail, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_fail, ilua_bool_ternary(val, valbase))
    end
end
-- MISC LO
function Qmpe:GetLo(dpath)
    self.d_misc_lo = iDataRef:New(dpath)
end

function Qmpe:SetLo(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_lo:Get()
        if self.d_misc_lo:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_lo, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_lo, ilua_bool_ternary(val, valbase))
    end
end
-- MISC MED
function Qmpe:GetMed(dpath)
    self.d_misc_med = iDataRef:New(dpath)
end

function Qmpe:SetMed(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_med:Get()
        if self.d_misc_med:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_med, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_med, ilua_bool_ternary(val, valbase))
    end
end
-- MISC MAX
function Qmpe:GetMax(dpath)
    self.d_misc_max = iDataRef:New(dpath)
end

function Qmpe:SetMax(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_max:Get()
        if self.d_misc_max:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_max, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_max, ilua_bool_ternary(val, valbase))
    end
end
-- MISC TERR
function Qmpe:GetTerr(dpath)
    self.d_misc_terr = iDataRef:New(dpath)
end

function Qmpe:SetTerr(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_terr:Get()
        if self.d_misc_terr:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_terr, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_terr, ilua_bool_ternary(val, valbase))
    end
end
-- MISC LAND
function Qmpe:GetLand(dpath)
    self.d_misc_land = iDataRef:New(dpath)
end

function Qmpe:SetLand(valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.d_misc_land:Get()
        if self.d_misc_land:ChangedUpdate() then
            uluaSet(idr_qmpe_hid_misc_land, ilua_bool_ternary(val, valbase))
        end
    else
        uluaSet(idr_qmpe_hid_misc_land, ilua_bool_ternary(val, valbase))
    end
end

-- MISC set all
function Qmpe:SetMisc(valbase)
    valbase = valbase == nil and 0 or valbase
    self:SetWarn(valbase)
    self:SetCaut(valbase)

    self:SetLock1(valbase)
    self:SetLock2(valbase)
    self:SetLock3(valbase)
    self:SetUnlock1(valbase)
    self:SetUnlock2(valbase)
    self:SetUnlock3(valbase)

    self:SetMsg(valbase)
    self:SetFail(valbase)

    self:SetLo(valbase)
    self:SetMed(valbase)
    self:SetMax(valbase)
    self:SetTerr(valbase)
    self:SetLand(valbase)

    -- brightness
    self:SetBkl()
end

-- set MISC off
function Qmpe:OffMisc()
    uluaSet(idr_qmpe_hid_misc_int, 0)
end

-- set LEDS off
function Qmpe:Off()
    -- all LEDS
    self:OffRmp()
    self:OffAcp()
    self:OffEcam()
    self:OffMisc()
    self:SetBkl(0)
    -- data
    self:OffRmp1()
    self:OffRmp2()
    self:OffXpdr()
end

-- ========================= Fake tranponder
-- fake tranponder standby code
-- when you key in 1,2,3,4,5, "5" will clear "1234" by default
_G.QmpeFakeXpdrKeyNumAutoClr = true
-- Fast CLR, when press CLR twice, will clear all
_G.QmpeFakeXpdrFastClr = false
_G.QmpeFakeXpdrFastClrTimeOut = 99999
_G.QmpeFakeXpdrFastClrIdleTime = os.clock()
-- XPDR standby timeout
_G.QmpeFakeXpdrKeyTimeOut = -1
_G.QmpeFakeXpdrKeyIdleTime = os.clock()
-- XPDR standby code
_G.QmpeFakeXpdrKeyNum = 0
_G.QmpeFakeXpdrKeyTable = {0, 0, 0, 0}
-- global callback function
_G.QmpeFakeXpdrKeyCallBackFunc = function(KeyCode)
    uluaLog('key press->' .. tostring(KeyCode))
    -- handle timeout
    if os.clock() - _G.QmpeFakeXpdrKeyIdleTime > QmpeFakeXpdrKeyTimeOut then
        if _G.QmpeFakeXpdrKeyNumAutoClr then
            _G.QmpeFakeXpdrKeyNum = 0
        end
        uluaLog('QmpeFakeXpdr timeout\n')
    end

    -- handle keycode: we use 9 as CLR
    if KeyCode ~= 9 then
        if _G.QmpeFakeXpdrKeyNum < 4 then
            _G.QmpeFakeXpdrKeyNum = _G.QmpeFakeXpdrKeyNum + 1
            _G.QmpeFakeXpdrKeyTable[_G.QmpeFakeXpdrKeyNum] = KeyCode
        else
            if _G.QmpeFakeXpdrKeyNumAutoClr then
                _G.QmpeFakeXpdrKeyNum = 1
                _G.QmpeFakeXpdrKeyTable[_G.QmpeFakeXpdrKeyNum] = KeyCode
            end
        end
        _G.QmpeFakeXpdrFastClr = false
    else
        -- handle FAST CLR
        if _G.QmpeFakeXpdrFastClr and os.clock() - _G.QmpeFakeXpdrFastClrIdleTime < QmpeFakeXpdrFastClrTimeOut then
            _G.QmpeFakeXpdrKeyNum = 0
            uluaLog('QmpeFakeXpdr FAST CLR\n')
            _G.QmpeFakeXpdrFastClr = false
        else
            _G.QmpeFakeXpdrFastClr = true
        end

        if _G.QmpeFakeXpdrKeyNum > 0 then
            _G.QmpeFakeXpdrKeyNum = _G.QmpeFakeXpdrKeyNum - 1
        end
        -- update FAST CLR timer
        _G.QmpeFakeXpdrFastClrIdleTime = os.clock()

    end
    -- reset timer
    _G.QmpeFakeXpdrKeyIdleTime = os.clock()
end

-- @ FuncCbName: is string of a global function name
-- @ timeout: can be empty
function Qmpe:FakeXpdrInit(autoclr, timeout, fastclrtm)
    _G.QmpeFakeXpdrKeyNumAutoClr = autoclr == nil and true or autoclr
    _G.QmpeFakeXpdrKeyTimeOut = timeout == nil and 99999 or timeout
    _G.QmpeFakeXpdrFastClrTimeOut = fastclrtm == nil and -1 or fastclrtm

    -- XPRD ATC Keypad
    -- CLR faked as number 9
    self:CfgFc(66, "_G.QmpeFakeXpdrKeyCallBackFunc(1)")
    self:CfgFc(67, "_G.QmpeFakeXpdrKeyCallBackFunc(2)")
    self:CfgFc(68, "_G.QmpeFakeXpdrKeyCallBackFunc(3)")
    self:CfgFc(69, "_G.QmpeFakeXpdrKeyCallBackFunc(4)")
    self:CfgFc(70, "_G.QmpeFakeXpdrKeyCallBackFunc(5)")
    self:CfgFc(71, "_G.QmpeFakeXpdrKeyCallBackFunc(6)")
    self:CfgFc(72, "_G.QmpeFakeXpdrKeyCallBackFunc(7)")
    self:CfgFc(73, "_G.QmpeFakeXpdrKeyCallBackFunc(0)")
    self:CfgFc(74, "_G.QmpeFakeXpdrKeyCallBackFunc(9)")
end

function Qmpe:FakeXpdrClear()
    _G.QmpeFakeXpdrKeyNum = 0
end

function Qmpe:FakeXpdrCopy(xcode)
    xcode = xcode == nil and self.d_xpdr:Get() or xcode

    _G.QmpeFakeXpdrKeyNum = 4
    -- extract 1234={1, 2, 3, 4}
    local val = math.floor(xcode / 1000)
    -- uluaLog('XPDR CPY1 ' .. tostring(val))
    _G.QmpeFakeXpdrKeyTable[1] = val
    xcode = xcode - val * 1000
    val = math.floor(xcode / 100)
    -- uluaLog('XPDR CPY2 ' .. tostring(val))
    _G.QmpeFakeXpdrKeyTable[2] = val
    xcode = xcode - val * 100
    val = math.floor(xcode / 10)
    -- uluaLog('XPDR CPY3 ' .. tostring(val))
    _G.QmpeFakeXpdrKeyTable[3] = val
    xcode = xcode - val * 10
    val = xcode
    -- uluaLog('XPDR CPY4 ' .. tostring(val))
    _G.QmpeFakeXpdrKeyTable[4] = val
end

function Qmpe:XpdrBc016(xcode)

    local bc016 = 0
    -- extract 1234={1, 2, 3, 4}
    local val = math.floor(xcode / 1000)
    -- uluaLog('XPDR CPY1 ' .. tostring(val))
    bc016 = bc016 + val * 4096
    xcode = xcode - val * 1000
    val = math.floor(xcode / 100)
    -- uluaLog('XPDR CPY2 ' .. tostring(val))
    bc016 = bc016 + val * 256
    xcode = xcode - val * 100
    val = math.floor(xcode / 10)
    -- uluaLog('XPDR CPY3 ' .. tostring(val))
    bc016 = bc016 + val * 16
    xcode = xcode - val * 10
    val = xcode
    -- uluaLog('XPDR CPY4 ' .. tostring(val))
    bc016 = bc016 + val
    return bc016
end

function Qmpe:FakeXpdrGet()
    local FakeXpdr = 0
    if _G.QmpeFakeXpdrKeyNum > 0 then
        for i = 1, _G.QmpeFakeXpdrKeyNum do
            -- uluaLog(tostring(i) .. '---' .. tostring(_G.QmpeFakeXpdrKeyTable[i]))
            FakeXpdr = FakeXpdr + (_G.QmpeFakeXpdrKeyTable[i] * (10 ^ (_G.QmpeFakeXpdrKeyNum - i)))
        end
        -- uluaLog('XPDR ' .. tostring(FakeXpdr))
    end
    return FakeXpdr, _G.QmpeFakeXpdrKeyNum
end

function Qmpe:FakeXpdrIsTimeOut()
    return os.clock() - _G.QmpeFakeXpdrKeyIdleTime > QmpeFakeXpdrKeyTimeOut
end

-- ========================= Digital RMP VHF standby Frequency 
local function table_contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

local function removeFirstElement(array)
    if #array == 0 then
        return nil, "Array is empty"
    end

    -- Remove and return the first element
    local firstElement = table.remove(array, 1)
    return firstElement
end

local function DigiRmpStbyFreqRangeCheck(freq)
    freq = freq - (freq % 5)
    if freq < 118000 then
        freq = 118000 + (freq % 1000)
    end
    if freq > 137000 then
        freq = 136000 + (freq % 1000)
    end
    return freq
end

local function combineArrays(array1, array2)
    for _, value in ipairs(array2) do
        table.insert(array1, value)
    end
    return array1
end

local function extractDigits(freq)
    local digits = {}
    local num = freq

    -- Calculate the number of digits
    local numDigits = math.floor(math.log(num, 10)) + 1

    -- Extract each digit from high to low
    for i = numDigits, 1, -1 do
        local divisor = 10 ^ (i - 1)
        local digit = math.floor(num / divisor)
        table.insert(digits, digit)
        num = num % divisor
    end

    return digits
end

-- Digital RMP VHF standby Frequency timeout
_G.QmpeDigiRmpVhf1StbyTimeOut = 1
_G.QmpeDigiRmpVhf1StbyIdleTime = os.clock() + 999999999
-- Digital RMP VHF standby Frequency
_G.QmpeDigiRmpVhf1StbyFreq = 0
_G.QmpeDigiRmpVhf1StbyKeyArray = {}
_G.QmpeDigiRmpVhf1StbyKeyPressCallBack = nil
-- global callback function
_G.QmpeDigiRmpVhf1StbyCallBackFunc = function(increment)
    local invalidlist = {20, 45, 70, 95}

    _G.QmpeDigiRmpVhf1StbyFreq = _G.QmpeDigiRmpVhf1StbyFreq + increment
    -- _G.QmpeDigiRmpVhf1StbyFreq = fixVHFFreq(_G.QmpeDigiRmpVhf1StbyFreq)
    _G.QmpeDigiRmpVhf1StbyFreq = DigiRmpStbyFreqRangeCheck(_G.QmpeDigiRmpVhf1StbyFreq)
    local lowerTwoDigits = _G.QmpeDigiRmpVhf1StbyFreq % 100
    if table_contains(invalidlist, lowerTwoDigits) then
        _G.QmpeDigiRmpVhf1StbyFreq = _G.QmpeDigiRmpVhf1StbyFreq + increment
        _G.QmpeDigiRmpVhf1StbyFreq = DigiRmpStbyFreqRangeCheck(_G.QmpeDigiRmpVhf1StbyFreq)
        -- handle the case where lowerTwoDigits is in invalidlist
    end

    -- uluaLog(string.format("stby=%d", _G.QmpeDigiRmpVhf1StbyFreq))
    -- reset timer
    _G.QmpeDigiRmpVhf1StbyIdleTime = os.clock()
end

function Qmpe:DigiRmpVhf1StbyGet()
    return _G.QmpeDigiRmpVhf1StbyFreq
end

function Qmpe:DigiRmpVhf1StbySet(freq)
    _G.QmpeDigiRmpVhf1StbyFreq = freq
end

function Qmpe:DigiRmpVhf1StbyInit(initfreq, func)
    _G.QmpeDigiRmpVhf1StbyFreq = initfreq == nil and 0 or initfreq
    uluaLog(string.format("init stby=%d", _G.QmpeDigiRmpVhf1StbyFreq))

    _G.QmpeDigiRmpVhf1KeyPressCallBack = func

    -- inner
    self:CfgFc(0, "_G.QmpeDigiRmpVhf1StbyCallBackFunc(-5)")
    self:CfgFc(1, "_G.QmpeDigiRmpVhf1StbyCallBackFunc(5)")
    self:CfgFc(2, "_G.QmpeDigiRmpVhf1StbyCallBackFunc(-1000)")
    self:CfgFc(3, "_G.QmpeDigiRmpVhf1StbyCallBackFunc(1000)")
end

function Qmpe:DigiRmpVhf1StbyIsTimeOut()
    return os.clock() - _G.QmpeDigiRmpVhf1StbyIdleTime > _G.QmpeDigiRmpVhf1StbyTimeOut
end

function Qmpe:DigiRmpVhf1StbyDisTimeOut()
    _G.QmpeDigiRmpVhf1StbyIdleTime = os.clock() + 999999999
end

_G.DigiRmpVhf1KeyPoll = function()
    local firstElement = removeFirstElement(_G.QmpeDigiRmpVhf1KeyArray)
    if firstElement and _G.QmpeDigiRmpVhf1KeyPressCallBack then
        _G.QmpeDigiRmpVhf1KeyPressCallBack(firstElement)
        uluasetTimeout("_G.DigiRmpVhf1KeyPoll()", 200)
    end
end

function Qmpe:DigiRmpVhf1StbyTimeOutHandle(key)
    self:DigiRmpVhf1StbyDisTimeOut()
    -- -1: VHF Key Press
    -- -2: Right LINE 1 Key Press
    -- -3: Right LINE 2 Key Press
    local array1 = {-1, -2}
    local array2 = extractDigits(_G.QmpeDigiRmpVhf1StbyFreq)
    table.insert(array2, -2)
    _G.QmpeDigiRmpVhf1KeyArray = combineArrays(array1, array2)
    uluasetTimeout("_G.DigiRmpVhf1KeyPoll()", 200)
end
------------------------------------------------------------
--- VHF2
_G.QmpeDigiRmpVhf2StbyTimeOut = 1
_G.QmpeDigiRmpVhf2StbyIdleTime = os.clock() + 999999999
-- Digital RMP VHF standby Frequency
_G.QmpeDigiRmpVhf2StbyFreq = 0
_G.QmpeDigiRmpVhf2StbyKeyArray = {}
_G.QmpeDigiRmpVhf2StbyKeyPressCallBack = nil
-- global callback function
_G.QmpeDigiRmpVhf2StbyCallBackFunc = function(increment)
    local invalidlist = {20, 45, 70, 95}

    _G.QmpeDigiRmpVhf2StbyFreq = _G.QmpeDigiRmpVhf2StbyFreq + increment
    -- _G.QmpeDigiRmpVhf2StbyFreq = fixVHFFreq(_G.QmpeDigiRmpVhf2StbyFreq)
    _G.QmpeDigiRmpVhf2StbyFreq = DigiRmpStbyFreqRangeCheck(_G.QmpeDigiRmpVhf2StbyFreq)
    local lowerTwoDigits = _G.QmpeDigiRmpVhf2StbyFreq % 100
    if table_contains(invalidlist, lowerTwoDigits) then
        _G.QmpeDigiRmpVhf2StbyFreq = _G.QmpeDigiRmpVhf2StbyFreq + increment
        _G.QmpeDigiRmpVhf2StbyFreq = DigiRmpStbyFreqRangeCheck(_G.QmpeDigiRmpVhf2StbyFreq)
        -- handle the case where lowerTwoDigits is in invalidlist
    end

    -- uluaLog(string.format("stby=%d", _G.QmpeDigiRmpVhf2StbyFreq))
    -- reset timer
    _G.QmpeDigiRmpVhf2StbyIdleTime = os.clock()
end

function Qmpe:DigiRmpVhf2StbyGet()
    return _G.QmpeDigiRmpVhf2StbyFreq
end

function Qmpe:DigiRmpVhf2StbySet(freq)
    _G.QmpeDigiRmpVhf2StbyFreq = freq
end

function Qmpe:DigiRmpVhf2StbyInit(initfreq, func)
    _G.QmpeDigiRmpVhf2StbyFreq = initfreq == nil and 0 or initfreq
    uluaLog(string.format("init stby=%d", _G.QmpeDigiRmpVhf2StbyFreq))

    _G.QmpeDigiRmpVhf2KeyPressCallBack = func

    -- inner
    self:CfgFc(28, "_G.QmpeDigiRmpVhf2StbyCallBackFunc(-5)")
    self:CfgFc(29, "_G.QmpeDigiRmpVhf2StbyCallBackFunc(5)")
    self:CfgFc(30, "_G.QmpeDigiRmpVhf2StbyCallBackFunc(-1000)")
    self:CfgFc(31, "_G.QmpeDigiRmpVhf2StbyCallBackFunc(1000)")
end

function Qmpe:DigiRmpVhf2StbyIsTimeOut()
    return os.clock() - _G.QmpeDigiRmpVhf2StbyIdleTime > _G.QmpeDigiRmpVhf2StbyTimeOut
end

function Qmpe:DigiRmpVhf2StbyDisTimeOut()
    _G.QmpeDigiRmpVhf2StbyIdleTime = os.clock() + 999999999
end

_G.DigiRmpVhf2KeyPoll = function()
    local firstElement = removeFirstElement(_G.QmpeDigiRmpVhf2KeyArray)
    if firstElement and _G.QmpeDigiRmpVhf2KeyPressCallBack then
        _G.QmpeDigiRmpVhf2KeyPressCallBack(firstElement)
        uluasetTimeout("_G.DigiRmpVhf2KeyPoll()", 200)
    end
end

function Qmpe:DigiRmpVhf2StbyTimeOutHandle(key)
    self:DigiRmpVhf2StbyDisTimeOut()
    -- -1: VHF Key Press
    -- -2: Right LINE 1 Key Press
    -- -3: Right LINE 2 Key Press
    local array1 = {-1, -3}
    local array2 = extractDigits(_G.QmpeDigiRmpVhf2StbyFreq)
    table.insert(array2, -3)
    _G.QmpeDigiRmpVhf2KeyArray = combineArrays(array1, array2)
    uluasetTimeout("_G.DigiRmpVhf2KeyPoll()", 200)
end

return Qmpe
