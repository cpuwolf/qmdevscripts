-- *****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-24
-- *****************************************************************
local QmReload = oop.class()

function QmReload:init()
    -- reload Qmdev after -1ms
    self.ReloadDelay = -1
    -- uluaLog('QmReload:init')
end

-- global call back function
_G.QmReloadActionCallBackFunc = function(KeyCode)
    local cmd_qmdev_reload = uluaFind("cpuwolf/qmdev/reload")
    if cmd_qmdev_reload ~= nil then
        uluaCmdOnce(cmd_qmdev_reload)
        uluaLog("QmReload: send cmd")
    end
end

function QmReload:Exec()
    if self.ReloadDelay > 0 then
        local delay = self.ReloadDelay
        -- clean up time
        self.ReloadDelay = -1
        uluasetTimeout("_G.QmReloadActionCallBackFunc()", delay)
    end
end

function QmReload:Req(delay)
    if delay == nil then
        delay = 1000
    end
    if delay > self.ReloadDelay then
        self.ReloadDelay = delay
    end
end

return QmReload
