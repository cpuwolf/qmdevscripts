-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2026-02-25
-- *****************************************************************
local Qgmc710 = oop.class(com.sim.Qmdev)

function Qgmc710:init()
    self.QmdevId = 1
    -- uluaLog('Qgmc710:init'..self.QmdevId)
end

function Qgmc710:Init()
    if ilua_hw_qgmc710_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qgmc710 == 1 then
        return false
    end
    ilua_hw_assigned_qgmc710 = 1
    return true
end

return Qgmc710
