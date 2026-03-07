-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qcduaf = oop.class(com.sim.qm.Qcdua)

function Qcduaf:init()
    self.QmdevId = 0x106
    -- uluaLog('Qcduaf:init'..self.QmdevId)
end

function Qcduaf:Init()
    if ilua_hw_qcdu_a320_1_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qcdu_a320_1 == 1 then
        return false
    end
    ilua_hw_assigned_qcdu_a320_1 = 1
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
function Qcduaf:SetMenu(valbase, val)
    self:SetBit(0, idr_qcdu_a320_1_hid_ledmenu, valbase, val)
end
-- ========
-- Leds Fail
function Qcduaf:SetFail(valbase, val)
    self:SetBit(2, idr_qcdu_a320_1_hid_ledfail, valbase, val)
end
-- ========
-- Leds Fmgc
function Qcduaf:SetFmgc(valbase, val)
    self:SetBit(3, idr_qcdu_a320_1_hid_ledfmgc, valbase, val)
end

-- ========
-- Leds Fm1
function Qcduaf:SetFm1(valbase, val)
    self:SetBit(8, idr_qcdu_a320_1_hid_ledfm1, valbase, val)
end

-- ========
-- Leds Ind
function Qcduaf:SetInd(valbase, val)
    self:SetBit(9, idr_qcdu_a320_1_hid_ledind, valbase, val)
end

-- ========
-- Leds Rdy
function Qcduaf:SetRdy(valbase, val)
    self:SetBit(10, idr_qcdu_a320_1_hid_ledrdy, valbase, val)
end

-- ========
-- Leds Fm2
function Qcduaf:SetFm2(valbase, val)
    self:SetBit(12, idr_qcdu_a320_1_hid_ledfm2, valbase, val)
end

-- ========
-- Backlight
function Qcduaf:SetBkl(val)
    self:_SetBkl(idr_qcdu_a320_1_hid_bright, val)
end

function Qcduaf:Off(val)
    uluaSet(idr_qcdu_a320_1_hid_bright, 0)
    uluaSet(idr_qcdu_a320_1_hid_leds, 0)
end

return Qcduaf
