-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-25
-- *****************************************************************
local Qfcu = oop.class(com.sim.Qmdev)

function Qfcu:init()
    self.QmdevId = 7
    -- uluaLog('Qfcu:init'..self.QmdevId)
end

function Qfcu:Init()
    if ilua_hw_qfcu_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qfcu == 1 then
        return false
    end
    ilua_hw_assigned_qfcu = 1
    return true
end

-- ========================= Alt
-- Alt
function Qfcu:GetAlt(dpath)
    self.d_alt = iDataRef:New(dpath)
end

function Qfcu:_SetAlt(dot, val)
    if val > 0 then
        uluaSet(idr_qfcu_hid_altval_i, val)
        if dot then
            uluaSet(idr_qfcu_hid_altmode, 2)
        else
            uluaSet(idr_qfcu_hid_altmode, 1)
        end
    else
        uluaSet(idr_qfcu_hid_altmode, 0)
    end
end

function Qfcu:SetAlt(dot, val)
    if val == nil then
        self:_SetAlt(dot, self.d_alt:Get())
    else
        self:_SetAlt(dot, val)
    end
end

function Qfcu:FreshAlt()
    self.d_alt:Invalid(-1000000)
end

-- ======== L EFIS
-- Baro Digi IN/HPA/STD = 1/2/3
function Qfcu:SetLBaro(mode, val)
    if mode == 1 then
        uluaSet(idr_qfcu_hid_lefisval_i, val)
        uluaSet(idr_qfcu_hid_lefismode, 1) -- IN)
    elseif mode == 2 then
        uluaSet(idr_qfcu_hid_lefisval_i, val)
        uluaSet(idr_qfcu_hid_lefismode, 2) -- HPA)
    elseif mode == 3 then
        uluaSet(idr_qfcu_hid_lefismode, 3) -- STD)
    end
end

-- ======== R EFIS
-- Baro Digi IN/HPA/STD = 1/2/3
function Qfcu:SetRBaro(mode, val)
    if mode == 1 then
        uluaSet(idr_qfcu_hid_refisval_i, val)
        uluaSet(idr_qfcu_hid_refismode, 1) -- IN)
    elseif mode == 2 then
        uluaSet(idr_qfcu_hid_refisval_i, val)
        uluaSet(idr_qfcu_hid_refismode, 2) -- HPA)
    elseif mode == 3 then
        uluaSet(idr_qfcu_hid_refismode, 3) -- STD)
    end
end

-- =========================Leds
-- ========
-- Leds Appr
function Qfcu:GetAppr(dpath)
    self:GetBit(2, dpath)
end

function Qfcu:SetAppr(valbase, val)
    self:SetBit(2, idr_qfcu_hid_ledsappr, valbase, val)
end

-- ========
-- Leds Exped
function Qfcu:GetExped(dpath)
    self:GetBit(3, dpath)
end

function Qfcu:SetExped(valbase, val)
    self:SetBit(3, idr_qfcu_hid_ledsexped, valbase, val)
end

-- ========
-- Leds Athr
function Qfcu:GetAthr(dpath)
    self:GetBit(4, dpath)
end

function Qfcu:SetAthr(valbase, val)
    self:SetBit(4, idr_qfcu_hid_ledsathr, valbase, val)
end

-- ========
-- Leds Ap2
function Qfcu:GetAp2(dpath)
    self:GetBit(5, dpath)
end

function Qfcu:SetAp2(valbase, val)
    self:SetBit(5, idr_qfcu_hid_ledsap2, valbase, val)
end

-- ========
-- Leds Ap1
function Qfcu:GetAp1(dpath)
    self:GetBit(6, dpath)
end

function Qfcu:SetAp1(valbase, val)
    self:SetBit(6, idr_qfcu_hid_ledsap1, valbase, val)
end

-- ========
-- Leds Loc
function Qfcu:GetLoc(dpath)
    self:GetBit(7, dpath)
end

function Qfcu:SetLoc(valbase, val)
    self:SetBit(7, idr_qfcu_hid_ledsloc, valbase, val)
end

-- ========
-- Leds mid part
function Qfcu:SetMidLeds()
    self:SetAp1()
    self:SetAp2()
    self:SetAthr()
    self:SetLoc()
    self:SetExped()
    self:SetAppr()
end

-- ========
-- Leds mid part
function Qfcu:FreshMidLeds()
    self:FreshBit(2)
    self:FreshBit(3)
    self:FreshBit(4)
    self:FreshBit(5)
    self:FreshBit(6)
    self:FreshBit(7)
end

-- ======== L EFIS
-- Leds LCstr
function Qfcu:GetLCstr(dpath)
    self:GetBit(24, dpath)
end

function Qfcu:SetLCstr(valbase, val)
    self:SetBit(24, idr_qfcu_hid_ledslcstr, valbase, val)
end

-- ======== L EFIS
-- Leds LWpt
function Qfcu:GetLWpt(dpath)
    self:GetBit(25, dpath)
end

function Qfcu:SetLWpt(valbase, val)
    self:SetBit(25, idr_qfcu_hid_ledslwpt, valbase, val)
end

-- ======== L EFIS
-- Leds LVord
function Qfcu:GetLVord(dpath)
    self:GetBit(26, dpath)
end

function Qfcu:SetLVord(valbase, val)
    self:SetBit(26, idr_qfcu_hid_ledslvord, valbase, val)
end

-- ======== L EFIS
-- Leds LNdb
function Qfcu:GetLNdb(dpath)
    self:GetBit(27, dpath)
end

function Qfcu:SetLNdb(valbase, val)
    self:SetBit(27, idr_qfcu_hid_ledslndb, valbase, val)
end

-- ======== L EFIS
-- Leds LArpt
function Qfcu:GetLArpt(dpath)
    self:GetBit(28, dpath)
end

function Qfcu:SetLArpt(valbase, val)
    self:SetBit(28, idr_qfcu_hid_ledslaprt, valbase, val)
end

-- ======== L EFIS
-- Leds LFd
function Qfcu:GetLFd(dpath)
    self:GetBit(29, dpath)
end

function Qfcu:SetLFd(valbase, val)
    self:SetBit(29, idr_qfcu_hid_ledslfd, valbase, val)
end

-- ======== L EFIS
-- Leds LIls
function Qfcu:GetLIls(dpath)
    self:GetBit(30, dpath)
end

function Qfcu:SetLIls(valbase, val)
    self:SetBit(30, idr_qfcu_hid_ledslls, valbase, val)
end

-- ========
-- Leds Left part
function Qfcu:SetLeftLeds()
    self:SetLCstr()
    self:SetLWpt()
    self:SetLVord()
    self:SetLNdb()
    self:SetLArpt()
    self:SetLFd()
    self:SetLIls()
end

-- ========
-- Leds Left part
function Qfcu:FreshLeftLeds()
    self:FreshBit(24)
    self:FreshBit(25)
    self:FreshBit(26)
    self:FreshBit(27)
    self:FreshBit(28)
    self:FreshBit(29)
    self:FreshBit(30)
end

-- ======== L EFIS
-- Baro Indicator QFE/QNH/OFF = 0/1/2
function Qfcu:SetLBaroMode(mode)
    if mode == 0 then
        uluaSet(idr_qfcu_hid_ledslqfe, 1) -- qfe)
        uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
    elseif mode == 1 then
        uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
        uluaSet(idr_qfcu_hid_ledslqhn, 1) -- qhn)
    elseif mode == 2 then
        uluaSet(idr_qfcu_hid_ledslqfe, 0) -- qfe)
        uluaSet(idr_qfcu_hid_ledslqhn, 0) -- qhn)
    end
end

-- ======== R EFIS
-- Leds RCstr
function Qfcu:GetRCstr(dpath)
    self:GetBit(40, dpath)
end

function Qfcu:SetRCstr(valbase, val)
    self:SetBit(40, idr_qfcu_hid_ledsrcstr, valbase, val)
end

-- ======== R EFIS
-- Leds RWpt
function Qfcu:GetRWpt(dpath)
    self:GetBit(41, dpath)
end

function Qfcu:SetRWpt(valbase, val)
    self:SetBit(41, idr_qfcu_hid_ledsrwpt, valbase, val)
end

-- ======== R EFIS
-- Leds RVord
function Qfcu:GetRVord(dpath)
    self:GetBit(42, dpath)
end

function Qfcu:SetRVord(valbase, val)
    self:SetBit(42, idr_qfcu_hid_ledsrvord, valbase, val)
end

-- ======== R EFIS
-- Leds RNdb
function Qfcu:GetRNdb(dpath)
    self:GetBit(43, dpath)
end

function Qfcu:SetRNdb(valbase, val)
    self:SetBit(43, idr_qfcu_hid_ledsrndb, valbase, val)
end

-- ======== R EFIS
-- Leds RArpt
function Qfcu:GetRArpt(dpath)
    self:GetBit(44, dpath)
end

function Qfcu:SetRArpt(valbase, val)
    self:SetBit(44, idr_qfcu_hid_ledsraprt, valbase, val)
end

-- ======== R EFIS
-- Leds RFd
function Qfcu:GetRFd(dpath)
    self:GetBit(45, dpath)
end

function Qfcu:SetRFd(valbase, val)
    self:SetBit(45, idr_qfcu_hid_ledsrfd, valbase, val)
end

-- ======== R EFIS
-- Leds RIls
function Qfcu:GetRIls(dpath)
    self:GetBit(46, dpath)
end

function Qfcu:SetRIls(valbase, val)
    self:SetBit(46, idr_qfcu_hid_ledsrls, valbase, val)
end

-- ========
-- Leds Right part
function Qfcu:SetRightLeds()
    self:SetRCstr()
    self:SetRWpt()
    self:SetRVord()
    self:SetRNdb()
    self:SetRArpt()
    self:SetRFd()
    self:SetRIls()
end

-- ========
-- Leds Right part
function Qfcu:FreshRightLeds()
    self:FreshBit(40)
    self:FreshBit(41)
    self:FreshBit(42)
    self:FreshBit(43)
    self:FreshBit(44)
    self:FreshBit(45)
    self:FreshBit(46)
end

-- ======== R EFIS
-- Baro Indicator QFE/QNH/OFF = 0/1/2
function Qfcu:SetRBaroMode(mode)
    if mode == 0 then
        uluaSet(idr_qfcu_hid_ledsrqfe, 1) -- qfe)
        uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
    elseif mode == 1 then
        uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
        uluaSet(idr_qfcu_hid_ledsrqhn, 1) -- qhn)
    elseif mode == 2 then
        uluaSet(idr_qfcu_hid_ledsrqfe, 0) -- qfe)
        uluaSet(idr_qfcu_hid_ledsrqhn, 0) -- qhn)
    end
end

-- turn off all digital Displays
function QFCU_Off()
    uluaSet(idr_qfcu_hid_indbrightval_i, 0)
    -- dr_qfcu_fcu_test:Invalid(os.clock())
end

function Qfcu:SetDigiBrtOff()
    -- dr_qfcu_fcu_light:Invalid(-1)
    -- dr_qfcu_fcu_lightDisp:Invalid(-1)
    uluaSet(idr_qfcu_hid_brightval_i, 0)
    uluaSet(idr_qfcu_hid_indbrightval_i, 1)
    uluasetTimeout("QFCU_Off()", 200)
end

function Qfcu:SetLedsOff()
    -- update cache
    self:FreshMidLeds()
    self:FreshLeftLeds()
    self:FreshRightLeds()

    -- real code
    uluaSet(idr_qfcu_hid_ledsval_i, 0)
    uluaSet(idr_qfcu_hid_ledslval_i, 0)
    uluaSet(idr_qfcu_hid_ledsrval_i, 0)
end

function Qfcu:SetDigiOff()
    -- real code
    uluaSet(idr_qfcu_hid_iasmode, 0)
    uluaSet(idr_qfcu_hid_hdgmode, 0)
    uluaSet(idr_qfcu_hid_altmode, 0)
    uluaSet(idr_qfcu_hid_vsmode, 0)
    uluaSet(idr_qfcu_hid_refismode, 0)
    uluaSet(idr_qfcu_hid_lefismode, 0)
end

return Qfcu
