-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2026-02-25
-- *****************************************************************
local Qg1kmfd = oop.class(com.sim.Qmdev)

function Qg1kmfd:init()
    self.QmdevId = 4
    -- uluaLog('Qg1kmfd:init'..self.QmdevId)
end

function Qg1kmfd:Init()
    if ilua_hw_qg1k_mfd_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qg1k_mfd == 1 then
        return false
    end
    ilua_hw_assigned_qg1k_mfd = 1
    return true
end

return Qg1kmfd
