-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-05-11 asobo TBM930
-- ########################################################
if ilua_is_acfpath_excluded("Asobo") or ilua_is_acfpath_excluded("TBM930") then
    return
end

-- Do not remove below lines: hardware detection
local qmcp737c = com.sim.qm.Qmcp737c:new()
if not qmcp737c:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QMCP737C for TBM930")


--uluaSet(idr_qmcp737c_hid_hdg, 123)
--uluaSet(idr_qmcp737c_hid_hdgmod, 1)

--[[
local d_hdg = uluaFind("(A:AUTOPILOT HEADING LOCK DIR,Degrees)")

function qmcp737c_tbm930_digi_disp_set_HDG()
	local hdg_value = uluaGet(d_hdg)
    uluaSet(idr_qmcp737c_hid_hdg, hdg_value)
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

uluaAddDoLoop("qmcp737c_tbm930_digi_disp_set_HDG()")
--]]