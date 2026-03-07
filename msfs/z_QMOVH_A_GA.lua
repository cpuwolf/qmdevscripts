-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2025-08-26
-- *****************************************************************
-- Do not remove below lines: hardware detection
local qmovha = com.sim.qm.Qmovha:new()
if not qmovha:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMOVH-A for GA")

-- ===========================================================
-- button binding
-- Strobe
qmovha:CfgRpn(0, "(>K:STROBES_ON)")
qmovha:CfgRpn(41, "(>K:STROBES_ON)")
qmovha:CfgRpn(1, "(>K:STROBES_OFF)")

-- beacon  lights
qmovha:CfgRpn(2, "(>K:BEACON_LIGHTS_ON)", "(>K:BEACON_LIGHTS_OFF)")

-- Wing lights
qmovha:CfgRpn(3, "1 (>L:S_OH_EXT_LT_WING)", "0 (>L:S_OH_EXT_LT_WING)")

-- NAV lights
qmovha:CfgRpn(4, "1 (>K:NAV_LIGHTS_SET)")
qmovha:CfgRpn(42, "1 (>K:NAV_LIGHTS_SET)")
qmovha:CfgRpn(5, "0 (>K:NAV_LIGHTS_SET)")

-- Taxi lights
qmovha:CfgRpn(6, "1 (>K:TAXI_LIGHTS_SET)")
qmovha:CfgRpn(45, "1 (>K:TAXI_LIGHTS_SET)")
qmovha:CfgRpn(7, "0 (>K:TAXI_LIGHTS_SET)")

-- R Landing lights
qmovha:CfgRpn(8, "2 (>L:S_OH_EXT_LT_LANDING_R)")
qmovha:CfgRpn(44, "1 (>L:S_OH_EXT_LT_LANDING_R)")
qmovha:CfgRpn(9, "0 (>L:S_OH_EXT_LT_LANDING_R)")
-- L Landing lights
qmovha:CfgRpn(10, "(>K:LANDING_LIGHTS_ON)")
qmovha:CfgRpn(43, "(>K:LANDING_LIGHTS_OFF)")
qmovha:CfgRpn(11, "(>K:LANDING_LIGHTS_OFF)")

-- DONT use this name "Qmovha_GA_loop" again
-- it must be unique across all .sec and lua files
function Qmovha_GA_loop()

end

uluaAddDoLoop("Qmovha_GA_loop()")
