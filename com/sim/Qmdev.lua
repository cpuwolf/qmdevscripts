-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
-- *****************************************************************
local Qmdev = oop.class()

-- Initialize Qmdev object fields.
-- No parameters.
-- No return value.
function Qmdev:init()
    self.QmdevId = 0
    self.FastTurnsPerSecond = 40
    self.MaxBrightness = 100
    self.KeyTable = {}
    self.Bits = {}
    self.RevertBits = {}

    -- uluaLog('Qmdev:init')
end

-- Set FastTurnsPerSecond and MaxBrightness if provided.
-- @ftpsdefval: (number, optional) Fast turns per second default value.
-- @maxBright: (number, optional) Maximum brightness value.
-- No return value.
function Qmdev:CfgInit(ftpsdefval, maxBright)
    self.FastTurnsPerSecond = ftpsdefval == nil and self.FastTurnsPerSecond or ftpsdefval
    self.MaxBrightness = maxBright == nil and self.MaxBrightness or maxBright
end

-- Add a key index to KeyTable if not already present. Log if already assigned.
-- @KeyIdx: (number) The key index to add.
-- No return value.
function Qmdev:AddKey(KeyIdx)
    if self.KeyTable[KeyIdx] == nil then
        self.KeyTable[KeyIdx] = true
    else
        uluaLog(KeyIdx .. "<-already assigned")
    end
end

-- uluaQmdevConfig(7, 'ROTATE;"f";0;1;1;1;0;0;380;"B:AUTOPILOT_Speed"')
-- config encoder rotation
-- @DecKey: (number) Decrement key index
-- @IncKey: (number) Increment key index
-- @Rpnstr: (string) RPN string for the encoder
-- @SlowStep: (number, optional) Slow step value (default 1)
-- @FastStep: (number, optional) Fast step value (default 1)
-- @StepMode: (number, optional) Step mode (default 0)
-- @MinStep: (number, optional) Minimum step value (default 0)
-- @MaxStep: (number, optional) Maximum step value (default 99999)
-- No return value.
function Qmdev:CfgEncTypeFull(DataType, DecKey, IncKey, Rpnstr, SlowStep, FastStep, StepMode, MinStep, MaxStep)
    if math.abs(DecKey - IncKey) ~= 1 or DecKey < 0 or IncKey < 0 then
        error("key id error")
    end
    self:AddKey(DecKey)
    self:AddKey(IncKey)
    SlowStep = SlowStep == nil and 1 or SlowStep
    FastStep = FastStep == nil and 1 or FastStep
    StepMode = StepMode == nil and 0 or StepMode
    MinStep = MinStep == nil and 0 or MinStep
    MaxStep = MaxStep == nil and 99999 or MaxStep
    str = 'ROTATE;"' .. DataType .. '";' .. tostring(DecKey) .. ';' .. tostring(IncKey) .. ';'
    str = str .. tostring(FastStep) .. ';' .. tostring(SlowStep) .. ';'
    str = str .. tostring(StepMode) .. ';'
    str = str .. tostring(MinStep) .. ';' .. tostring(MaxStep) .. ';'
    str = str .. '"' .. Rpnstr .. '"'
    uluaQmdevConfig(self.QmdevId, str)
    -- uluaLog(self.QmdevId .. ', ' .. str)
end

function Qmdev:CfgEncFull(DecKey, IncKey, Rpnstr, SlowStep, FastStep, StepMode, MinStep, MaxStep)
    self:CfgEncTypeFull("a", DecKey, IncKey, Rpnstr, SlowStep, FastStep, StepMode, MinStep, MaxStep)
end

-- Configure an encoder with default step and mode values.
-- @DecKey: (number) Decrement key index
-- @IncKey: (number) Increment key index
-- @Rpnstr: (string) RPN string for the encoder
-- No return value.
function Qmdev:CfgEnc(DecKey, IncKey, Rpnstr)
    self:CfgEncFull(DecKey, IncKey, Rpnstr)
end

-- @KeyIdx: (number) Key index
-- @BeventStr: (string) B Event string
-- @RpnStr: (string) RPN string
-- uluaQmdevRegisterKey(7, 39, 'uluaSet(uluaFind("B:AIRLINER_ARPT"), 1-uluaGet(uluaFind("(L:BTN_ARPT_FILTER_ACTIVE)")))', "")
-- No return value.
function Qmdev:CfgTog(KeyIdx, BeventStr, RpnStr)
    self:AddKey(KeyIdx)
    str = 'uluaSet(uluaFind("' .. BeventStr .. '"), 1-uluaGet(uluaFind("' .. RpnStr .. '")))'
    uluaQmdevRegisterKey(self.QmdevId, KeyIdx, str, "")
    -- uluaLog(self.QmdevId .. ', ' .. str)
end

-- @KeyIdx: (number) Key index
-- @FuncPressStr: (string) Lua code for key press
-- @FuncReleaseStr: (string, optional) Lua code for key release
-- uluaQmdevRegisterKey(2, 71, "qmcp737c_zibo738_cmd_disconnect(1)", "qmcp737c_zibo738_cmd_disconnect(0)")
-- No return value.
function Qmdev:CfgFc(KeyIdx, FuncPressStr, FuncReleaseStr)
    self:AddKey(KeyIdx)
    FuncReleaseStr = FuncReleaseStr == nil and "" or FuncReleaseStr
    uluaQmdevRegisterKey(self.QmdevId, KeyIdx, FuncPressStr, FuncReleaseStr)
    -- uluaLog(self.QmdevId .. ', ' .. FuncPressStr.. ', '.. FuncReleaseStr)
end

-- Long press
_G.LongPressStartTime = {}
_G.LongPressTimeoutHandle = {}
_G.LongPressFunc = {}
_G.ShortPressFunc = {}
_G.InitPressFunc = {}

-- global callback function
_G.QmdevPressTimeoutCallBackFunc = function(KeyIdx)
    _G.LongPressFunc[KeyIdx]()
end
_G.QmdevPressCallBackFunc = function(KeyIdx, WaitMs)
    -- uluaLog("Press key " .. KeyIdx)
    _G.LongPressStartTime[KeyIdx] = uluagetTimestamp()
    _G.LongPressTimeoutHandle[KeyIdx] = uluasetTimeout("_G.QmdevPressTimeoutCallBackFunc(" .. tostring(KeyIdx) .. ")",
        WaitMs)
    if _G.InitPressFunc[KeyIdx] ~= nil then
        _G.InitPressFunc[KeyIdx]()
    end
end

_G.QmdevReleaseCallBackFunc = function(KeyIdx)
    if uluagetTimestamp() - _G.LongPressStartTime[KeyIdx] > 500 then
        uluaLog("Long Press key " .. KeyIdx)
    else
        uluaLog("Short Press key " .. KeyIdx)
        uluaclearTimeout(_G.LongPressTimeoutHandle[KeyIdx])
        _G.ShortPressFunc[KeyIdx]()
    end
end
-- @KeyIdx: (number) Key index
-- @WaitMs: (number) long press wait milliseconds
-- @LongPressFunc: (function) long press triggered function
-- @ShortPressFunc: (function) Short press triggered function
-- @InitPressFunc: (function, optional) when key down call back function
-- Qmdev:CfgLongFc(2, 1000, FlapsSet, FlapsSet)
-- No return value.
function Qmdev:CfgLongFc(KeyIdx, WaitMs, LongPressFunc, ShortPressFunc, InitPressFunc)
    self:AddKey(KeyIdx)
    if type(LongPressFunc) == "function" then
        _G.LongPressFunc[KeyIdx] = LongPressFunc
    else
        uluaLog("CfgLongFc: wrong params 1")
    end
    if type(ShortPressFunc) == "function" then
        _G.ShortPressFunc[KeyIdx] = ShortPressFunc
    else
        uluaLog("CfgLongFc: wrong params 2")
    end
    if InitPressFunc ~= nil then
        if type(InitPressFunc) == "function" then
            _G.InitPressFunc[KeyIdx] = InitPressFunc
        else
            uluaLog("CfgLongFc: wrong params 3")
        end
    end
    strpress = "_G.QmdevPressCallBackFunc(" .. tostring(KeyIdx) .. "," .. tostring(WaitMs) .. ")"
    strrelease = "_G.QmdevReleaseCallBackFunc(" .. tostring(KeyIdx) .. ")"
    -- uluaLog(strpress)
    -- uluaLog(strrelease)
    uluaQmdevRegisterKey(self.QmdevId, KeyIdx, strpress, strrelease)
end

-- CfgCmd(2, 9, "39101 (>K:ROTOR_BRAKE)", "")
-- @KeyIdx: (number) Key index
-- @RpnPressStr: (string) RPN string for key press
-- @RpnReleaseStr: (string, optional) RPN string for key release
-- No return value.
function Qmdev:CfgRpn(KeyIdx, RpnPressStr, RpnReleaseStr)
    RpnReleaseStr = RpnReleaseStr == nil and "" or RpnReleaseStr
    self:CfgCmd(KeyIdx, RpnPressStr, RpnReleaseStr)
    -- uluaLog(self.QmdevId ..', ' .. RpnPressStr.. ', '.. RpnReleaseStr)
end

-- uluaQmdevConfig(2, 'ASSIGN;6;"laminar/B738/autopilot/change_over_press"')
-- @KeyIdx: (number) Key index
-- @CmdPressStr: (string) Command string for key press
-- @CmdReleaseStr: (string, optional) Command string for key release
-- No return value.
function Qmdev:CfgCmd(KeyIdx, CmdPressStr, CmdReleaseStr)
    self:AddKey(KeyIdx)
    str = 'ASSIGN;' .. tostring(KeyIdx) .. ';"' .. CmdPressStr .. '"'
    if CmdReleaseStr ~= nil then
        str = str .. ';"' .. CmdReleaseStr .. '"'
    end
    uluaQmdevConfig(self.QmdevId, str)
    -- uluaLog(self.QmdevId .. ', ' .. str)
end

-- uluaQmdevConfig(2, 'DFKEY;3;1;0;"laminar/B738/switches/autopilot/at_arm"')
-- uluaQmdevConfig(2, 'DFKEY;3;;0;"laminar/B738/switches/autopilot/at_arm"')
-- uluaQmdevConfig(2, 'DFKEY;3;1;;"laminar/B738/switches/autopilot/at_arm"')
-- @ValStr: (string) dataref string for XP or B event for MSFS
-- @PressInt: (number, optional) Integer value for press
-- @ReleaseInt: (number, optional) Integer value for release
-- No return value.
function Qmdev:CfgVal(KeyIdx, ValStr, PressInt, ReleaseInt)
    self:AddKey(KeyIdx)
    str = 'DFKEY;' .. tostring(KeyIdx) .. ';'
    str = str .. (PressInt == nil and '' or tostring(PressInt)) .. ';'
    str = str .. (ReleaseInt == nil and '' or tostring(ReleaseInt)) .. ';"' .. ValStr .. '"'
    uluaQmdevConfig(self.QmdevId, str)
    -- uluaLog(self.QmdevId .. ', ' .. str)
end

-- uluaQmdevConfig(7, 'TDFKEY;48;"B:AUTOPILOT_Baro_1_QNH"')
-- @ValStr: (string) dataref string for XP or B event for MSFS
-- No return value.
function Qmdev:CfgValT(KeyIdx, ValStr)
    self:AddKey(KeyIdx)
    str = 'TDFKEY;' .. tostring(KeyIdx) .. ';"'
    str = str .. ValStr .. '"'
    uluaQmdevConfig(self.QmdevId, str)
    -- uluaLog(self.QmdevId .. ', ' .. str)
end

-- =========================Bits
-- Bits Get/Set
-- @idx: (number) Index in Bits array
-- @dpath: (string) Dataref path string
-- No return value.
function Qmdev:GetBit(idx, dpath, revert)
    revert = revert == nil and false or revert

    self.Bits[idx + 1] = iDataRef:New(dpath)
    if self.Bits[idx + 1] == nil then
        error("Qmdev:GetBit Error " .. dpath)
    end
    self.RevertBits[idx + 1] = revert
end

-- @idx: (number) Index in Bits array
-- @idr: (handle) Dataref handle
-- @valbase: (number, optional) Base value (default 0)
-- @val: (number, optional) Value to set
-- No return value.
function Qmdev:SetBit(idx, idr, valbase, val)
    valbase = valbase == nil and 0 or valbase
    if val == nil then
        val = self.Bits[idx + 1]:Get()
        if self.Bits[idx + 1]:ChangedUpdate() then
            uluaSet(idr, ilua_bool_ternary(val, valbase, self.RevertBits[idx + 1]))
        end
    else
        uluaSet(idr, ilua_bool_ternary(val, valbase))
    end
end

-- @idx: (number) Index in Bits array
-- @val: (number) Value to set as invalid
-- No return value.
function Qmdev:FreshBit(idx, val)
    self.Bits[idx + 1]:Invalid(val)
end

-- No parameters. Invalidates all bit values in Bits.
-- No return value.
function Qmdev:FreshBits()
    for k, v in pairs(self.Bits) do
        v:Invalid(-1)
    end
end

------------------------------------------------------------
-- PID position switch
_G.QmdevPosSwitchPosStatusDr = {}
_G.QmdevPosSwitchRpnIncStr = {}
_G.QmdevPosSwitchRpnDecStr = {}
_G.QmdevPosSwitchPosExpect = {}
_G.QmdevPosSwitchPosStepSize = {}
_G.QmdevPosSwitchPosDelay = {}

_G.QmdevPosSwitchRpnIncDr = {}
_G.QmdevPosSwitchRpnDecDr = {}

_G.QmdevPosallocator = IndexAllocator.new()

_G.QmdevPosSwitchInit = function(rpnstring, step, rpnIncstring, rpnDecstring, delay)
    local idx = _G.QmdevPosallocator:alloc()
    delayact = delay == nil and 100 or delay
    if _G.QmdevPosSwitchPosExpect[idx] ~= nil then
        uluaLog(string.format("QmdevPosSwitchInit Duplicated %d, change 1st param", idx))
    end

    _G.QmdevPosSwitchPosStepSize[idx] = step
    _G.QmdevPosSwitchPosExpect[idx] = -1
    _G.QmdevPosSwitchPosStatusDr[idx] = uluaFind(rpnstring)
    _G.QmdevPosSwitchRpnIncStr[idx] = rpnIncstring
    _G.QmdevPosSwitchRpnDecStr[idx] = rpnDecstring
    _G.QmdevPosSwitchPosDelay[idx] = delayact
    if uluaCmdBegin ~= nil then
        _G.QmdevPosSwitchRpnIncDr[idx] = uluaFind(rpnIncstring)
        _G.QmdevPosSwitchRpnDecDr[idx] = uluaFind(rpnDecstring)
    end
    return idx
end

_G.QmdevPosSwitchSet = function(idx, dnum)
    _G.QmdevPosSwitchPosExpect[idx] = dnum
    _G.QmdevPosSwitchSetAction(idx)
end

_G.QmdevPosSwitchSetAction = function(idx)
    local pos = uluaGet(QmdevPosSwitchPosStatusDr[idx])
    local steps = (_G.QmdevPosSwitchPosExpect[idx] - pos) / _G.QmdevPosSwitchPosStepSize[idx]

    uluaLog(string.format("steps=%d %d = %d ", _G.QmdevPosSwitchPosExpect[idx], pos, steps))

    if _G.QmdevPosSwitchRpnIncStr[idx] == _G.QmdevPosSwitchRpnDecStr[idx] then
        uluaLog("LOOP")
        if steps ~= 0 then
            if uluaCmdBegin == nil then
                uluaWriteCmd(QmdevPosSwitchRpnIncStr[idx])
            else
                uluaCmdOnce(_G.QmdevPosSwitchRpnIncDr[idx])
                uluasetTimeout("uluaGet(QmdevPosSwitchPosStatusDr[" .. tostring(idx) .. "])",
                    _G.QmdevPosSwitchPosDelay[idx] * 0.8)
            end

            uluasetTimeout("_G.QmdevPosSwitchSetAction(" .. tostring(idx) .. ")", _G.QmdevPosSwitchPosDelay[idx])
        end
        return
    end

    if steps > 0 then
        for uup = 1, steps do
            uluaLog("UP")
            if uluaCmdBegin == nil then
                uluaWriteCmd(QmdevPosSwitchRpnIncStr[idx])
            else
                uluaCmdOnce(_G.QmdevPosSwitchRpnIncDr[idx])
                uluasetTimeout("uluaGet(QmdevPosSwitchPosStatusDr[" .. tostring(idx) .. "])",
                    _G.QmdevPosSwitchPosDelay[idx] / 2)
            end
            if steps > 1 then
                uluasetTimeout("_G.QmdevPosSwitchSetAction(" .. tostring(idx) .. ")", _G.QmdevPosSwitchPosDelay[idx])
                break
            end
        end
    elseif steps < 0 then
        steps = steps * -1
        for ddn = 1, steps do
            uluaLog("DOWN")
            if uluaCmdBegin == nil then
                uluaWriteCmd(QmdevPosSwitchRpnDecStr[idx])
            else
                uluaCmdOnce(_G.QmdevPosSwitchRpnDecDr[idx])
                uluasetTimeout("uluaGet(QmdevPosSwitchPosStatusDr[" .. tostring(idx) .. "])",
                    _G.QmdevPosSwitchPosDelay[idx] / 2)
            end
            if steps > 1 then
                uluasetTimeout("_G.QmdevPosSwitchSetAction(" .. tostring(idx) .. ")", _G.QmdevPosSwitchPosDelay[idx])
                break
            end
        end
    end
end
-- PID position switch string
function Qmdev:GenPSwStr(idx, intexpect)
    return "QmdevPosSwitchSet(" .. tostring(idx) .. ", " .. tostring(intexpect) .. ")"
end

-- PID position switch
function Qmdev:CfgPSw(KeyIdx, idx, presexpect, resexpect)
    resstr = resexpect ~= nil and self:GenPSwStr(idx, resexpect) or ""
    self:AddKey(KeyIdx)
    if resexpect ~= nil then
        self:CfgFc(KeyIdx, self:GenPSwStr(idx, presexpect), resstr)
    else
        self:CfgFc(KeyIdx, self:GenPSwStr(idx, presexpect))
    end
end

return Qmdev
