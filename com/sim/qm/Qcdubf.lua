-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qcdubf = oop.class(com.sim.qm.Qcdub)

function Qcdubf:init()
    self.QmdevId = 0x40000005
    -- uluaLog('Qcdubf:init'..self.QmdevId)
end

function Qcdubf:Init()
    if ilua_hw_qcdu_b737_1_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qcdu_b737_1 == 1 then
        return false
    end
    ilua_hw_assigned_qcdu_b737_1 = 1
    return true
end

-- ========
-- Leds Msg
function Qcdubf:SetMsg(valbase, val)
    self:SetBit(0, idr_qcdu_b737_1_hid_ledmsg, valbase, val)
end

-- ========
-- Leds Ofst
function Qcdubf:SetOfst(valbase, val)
    self:SetBit(1, idr_qcdu_b737_1_hid_ledofst, valbase, val)
end

-- ========
-- Leds Call
function Qcdubf:SetCall(valbase, val)
    self:SetBit(2, idr_qcdu_b737_1_hid_ledcall, valbase, val)
end

-- ========
-- Leds Fail
function Qcdubf:SetFail(valbase, val)
    self:SetBit(3, idr_qcdu_b737_1_hid_ledfail, valbase, val)
end

-- ========
-- Leds Exec
function Qcdubf:SetExec(valbase, val)
    self:SetBit(4, idr_qcdu_b737_1_hid_ledexec, valbase, val)
end

-- ========
-- Backlight
function Qcdubf:SetBkl(val)
    self:_SetBkl(idr_qcdu_b737_1_hid_bright, val)
end

function Qcdubf:Off(val)
    uluaSet(idr_qcdu_b737_1_hid_bright, 0)
    uluaSet(idr_qcdu_b737_1_hid_leds, 0)
end

return Qcdubf