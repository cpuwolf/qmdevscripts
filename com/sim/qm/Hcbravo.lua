-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2026-03-12
-- *****************************************************************
local Hcbravo = oop.class(com.sim.Qmdev)

function Hcbravo:init()
    self.QmdevId = 0x32129CCC
    _G.ilua_hw_assigned_hcbravo = 0
    -- uluaLog('Hcbravo:init'..self.QmdevId)
end

function Hcbravo:absent(FastTurnsPerSecond)
    if not uluaFind('cpuwolf/qmdev/HCBravo/LED/AP.autopilot') then
        return true
    end
    _G.idr_hcbravo_hid_fastkey = uluaFind('cpuwolf/qmdev/HCBravo/fastkeypersec')
    _G.idr_hcbravo_hid_led_int = uluaFind('cpuwolf/qmdev/HCBravo/LED/int')
    _G.idr_hcbravo_hid_led_ap_hdg = uluaFind('cpuwolf/qmdev/HCBravo/LED/AP.hdg')
    -- uluaSet(_G.idr_hcbravo_hid_fastkey, FastTurnsPerSecond)
    return false
end

function Hcbravo:Init()
    if self.absent(self.FastTurnsPerSecond) then
        return false
    end
    if _G.ilua_hw_assigned_hcbravo == 1 then
        return false
    end
    _G.ilua_hw_assigned_hcbravo = 1
    return true
end

-- ========
-- Leds Hdg
function Hcbravo:GetHdg(dpath)
    self:GetBit(0, dpath)
end

function Hcbravo:SetHdg(valbase, val)
    self:SetBit(0, idr_hcbravo_hid_led_ap_hdg, valbase, val)
end

return Hcbravo
