-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qcdu = oop.class(com.sim.Qmdev)

function Qcdu:init()
    self.QmdevId = 5
    -- uluaLog('Qcdu:init'..self.QmdevId)
end

-- ***********************************************************************************
-- Driver for QCDU  FFA320
-- Author: QuickMade
-- Build:  2020-09-26
--
--
-- Send 3 Bytes:
-- 1st Byte
---- B7   B6   B5   B4    B3    B2     B1     B0
---- X    X    X   EXEC  FAIL  CALL   OFST   MSG
---- X    X    X         FMGC  FAIL          MENU
-- 2nd Byte
---- B7 B6 B5 B4  B3  B2    B1   B0
---- X  X  X  FM2  ?  RDY   IND  FM1
-- 3rd Byte
---- B7 B6 B5 B4 B3 B2 B1 B0
----  Brightness
--
-- ******************************************  Copyright   ***********************

-- ========
-- Backlight
function Qcdu:GetBkl(dpath, scale)
    self.d_bkl_scale = scale == nil and 30 or scale
    self.d_bkl = iDataRef:New(dpath)
end

function Qcdu:_SetBkl(idr, val)
    if val == nil then
        val = self.d_bkl:Get() * self.d_bkl_scale
        if self.d_bkl:ChangedUpdate() then
            uluaSet(idr, val)
        end
    else
        uluaSet(idr, val)
    end
end

function Qcdu:FreshBkl()
    self:FreshBits()
    self.d_bkl:Invalid(-1)
end

-- ========
-- CDU screen Brightness
function Qcdu:GetScreenBrt(dpath, scale)
    self.d_srn_brt_scale = scale == nil and 100 or scale
    self.d_srn_brt = iDataRef:New(dpath)
end

function Qcdu:SetScreenBrt(val)
    if val == nil then
        local brt = self.d_srn_brt:Get() * self.d_srn_brt_scale
        if self.d_srn_brt:ChangedUpdate() then
            ilua_qlcd_set_brightness(brt)
        end
    else
        ilua_qlcd_set_brightness(val)
    end
end

function Qcdu:FreshScreenBrt()
    self.d_srn_brt:Invalid(-100)
end


return Qcdu

