-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qcdua = oop.class(com.sim.qm.Qcdu)

function Qcdua:init()
    self.QmdevId = 6
    -- uluaLog('Qcdua:init'..self.QmdevId)
end

function Qcdua:Init()
    if ilua_hw_qcdu_a320_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qcdu_a320 == 1 then
        return false
    end
    ilua_hw_assigned_qcdu_a320 = 1
    return true
end

--------------------------- process encoder ----------------
---- B7   B6   B5   B4    B3    B2     B1     B0
---- X    X    X         FMGC  FAIL          MENU
-- 2nd Byte
---- B7 B6 B5 B4  B3  B2    B1   B0
---- X  X  X  FM2  ?  RDY   IND  FM1
---------------------------------------------------------------------------------------------------
-- =========================Leds
-- ========
-- Leds Menu
function Qcdua:GetMenu(dpath)
    self:GetBit(0, dpath)
end

function Qcdua:SetMenu(valbase, val)
    self:SetBit(0, idr_qcdu_a320_hid_ledmenu, valbase, val)
end
-- ========
-- Leds Fail
function Qcdua:GetFail(dpath)
    self:GetBit(2, dpath)
end

function Qcdua:SetFail(valbase, val)
    self:SetBit(2, idr_qcdu_a320_hid_ledfail, valbase, val)
end
-- ========
-- Leds Fmgc
function Qcdua:GetFmgc(dpath)
    self:GetBit(3, dpath)
end

function Qcdua:SetFmgc(valbase, val)
    self:SetBit(3, idr_qcdu_a320_hid_ledfmgc, valbase, val)
end

-- ========
-- Leds Fm1
function Qcdua:GetFm1(dpath)
    self:GetBit(8, dpath)
end

function Qcdua:SetFm1(valbase, val)
    self:SetBit(8, idr_qcdu_a320_hid_ledfm1, valbase, val)
end

-- ========
-- Leds Ind
function Qcdua:GetInd(dpath)
    self:GetBit(9, dpath)
end

function Qcdua:SetInd(valbase, val)
    self:SetBit(9, idr_qcdu_a320_hid_ledind, valbase, val)
end

-- ========
-- Leds Rdy
function Qcdua:GetRdy(dpath)
    self:GetBit(10, dpath)
end

function Qcdua:SetRdy(valbase, val)
    self:SetBit(10, idr_qcdu_a320_hid_ledrdy, valbase, val)
end

-- ========
-- Leds Fm2
function Qcdua:GetFm2(dpath)
    self:GetBit(12, dpath)
end

function Qcdua:SetFm2(valbase, val)
    self:SetBit(12, idr_qcdu_a320_hid_ledfm2, valbase, val)
end

function Qcdua:SetLeds()
    self:SetMenu()
    self:SetFail()
    self:SetFmgc()
    self:SetFm1()
    self:SetInd()
    self:SetRdy()
    self:SetFm2()
end

-- ========
-- Backlight
function Qcdua:SetBkl(val)
    self:_SetBkl(idr_qcdu_a320_hid_bright, val)
end

function Qcdua:Off(val)
    uluaSet(idr_qcdu_a320_hid_bright, 0)
    uluaSet(idr_qcdu_a320_hid_leds, 0)
end

return Qcdua
