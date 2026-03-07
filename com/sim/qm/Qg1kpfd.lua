-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2026-02-25
-- *****************************************************************
local Qg1kpfd = oop.class(com.sim.Qmdev)

function Qg1kpfd:init()
    self.QmdevId = 3
    -- uluaLog('Qg1kpfd:init'..self.QmdevId)
end

function Qg1kpfd:Init()
    if ilua_hw_qg1k_pfd_absent(self.FastTurnsPerSecond) then
        return false
    end
    if ilua_hw_assigned_qg1k_pfd == 1 then
        return false
    end
    ilua_hw_assigned_qg1k_pfd = 1
    return true
end

return Qg1kpfd
