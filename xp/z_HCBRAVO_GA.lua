--**********************Copyright***********************--
-- modified by Wei Shuai <cpuwolf@gmail.com>
-- 2026-03-12
local FastTurnsPerSecond = 30 --How many spins per second  is considered FAST?
--########################################################


-- Do not remove below lines: hardware detection
local hcbravo = com.sim.qm.Hcbravo:new()
if not hcbravo:Init() then
    return
end
-- Do not remove above lines: hardware detection


hcbravo:CfgCmd(0, "sim/autopilot/heading", "")


uluaLog("HCBravo for GA")


hcbravo:GetHdg("sim/cockpit2/autopilot/heading_status")

function HCBRAVO_GA_LED_UPD()
    hcbravo:SetHdg()
end

uluaAddDoLoop("HCBRAVO_GA_LED_UPD()")
