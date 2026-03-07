-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qcdub = oop.class(com.sim.qm.Qcdu)

function Qcdub:init()
    self.QmdevId = 5
    -- uluaLog('Qcdub:init'..self.QmdevId)
end

function Qcdub:Init()
    if ilua_hw_qcdu_b737_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qcdu_b737 == 1 then
        return false
    end
    ilua_hw_assigned_qcdu_b737 = 1
    return true
end

-- ***********************************************************************************
-- Driver for QCDU
-- Author: QuickMade
-- Email:  409050332@qq.com
-- Website: https://space.bilibili.com/323386663/
-- Build:  2020-09-26
--
--
-- Send 3 Bytes:
-- 1st Byte
---- B7   B6   B5   B4    B3    B2     B1     B0
---- X    X    X   EXEC  FAIL  CALL   OFST   MSG
-- 2nd Byte
---- B7 B6 B5 B4  B3  B2    B1   B0
---- X  X  X  FM2  ?  RDY   IND  FM1
-- 3rd Byte
---- B7 B6 B5 B4 B3 B2 B1 B0
----  Brightness
--
-- ******************************************Copyright***********************

--- =========================Leds
-- ========
-- Leds Msg
function Qcdub:GetMsg(dpath)
    self:GetBit(0, dpath)
end

function Qcdub:SetMsg(valbase, val)
    self:SetBit(0, idr_qcdu_b737_hid_ledmsg, valbase, val)
end

-- ========
-- Leds Ofst
function Qcdub:GetOfst(dpath)
    self:GetBit(1, dpath)
end

function Qcdub:SetOfst(valbase, val)
    self:SetBit(1, idr_qcdu_b737_hid_ledofst, valbase, val)
end

-- ========
-- Leds Call
function Qcdub:GetCall(dpath)
    self:GetBit(2, dpath)
end

function Qcdub:SetCall(valbase, val)
    self:SetBit(2, idr_qcdu_b737_hid_ledcall, valbase, val)
end

-- ========
-- Leds Fail
function Qcdub:GetFail(dpath)
    self:GetBit(3, dpath)
end

function Qcdub:SetFail(valbase, val)
    self:SetBit(3, idr_qcdu_b737_hid_ledfail, valbase, val)
end
-- ========
-- Leds Exec
function Qcdub:GetExec(dpath)
    self:GetBit(4, dpath)
end

function Qcdub:SetExec(valbase, val)
    self:SetBit(4, idr_qcdu_b737_hid_ledexec, valbase, val)
end

function Qcdub:SetLeds()
    self:SetMsg()
    self:SetOfst()
    self:SetCall()
    self:SetFail()
    self:SetExec()
end

-- ========
-- Backlight
function Qcdub:SetBkl(val)
    self:_SetBkl(idr_qcdu_b737_hid_bright, val)
end

function Qcdub:Off(val)
    uluaSet(idr_qcdu_b737_hid_bright, 0)
    uluaSet(idr_qcdu_b737_hid_leds, 0)
end

return Qcdub
