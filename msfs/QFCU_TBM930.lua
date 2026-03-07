-- **********************************************************************************************************--
-- modified by Wei Shuai <cpuwolf@gmail.com> 2024-05-11 asobo TBM930
-- ########################################################
if ilua_is_acfpath_excluded("Asobo") or ilua_is_acfpath_excluded("TBM930") then
    return
end

-- Do not remove below lines: hardware detection
local qfcu = com.sim.qm.Qfcu:new()
if not qfcu:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QFCU for TBM930")

-- qfcu:CfgEnc(4, 5, "B:AUTOPILOT_Heading")

-- uluaSet(idr_qfcu_hid_hdgval_i, 123)
-- uluaSet(idr_qfcu_hid_hdgmode, 1)

-- uluaSet(idr_qfcu_hid_brightval_i, 20)
-- uluaSet(idr_qfcu_hid_dispbrightval_i, 4)
-- uluaSet(idr_qfcu_hid_indbrightval_i, 1)

--[[
local d_hdg = uluaFind("(A:AUTOPILOT HEADING LOCK DIR,Degrees)")

function qfcu_tbm930_digi_disp_set_HDG()
	local hdg_value = uluaGet(d_hdg)
    uluaSet(idr_qfcu_hid_hdgval_i, hdg_value)
    uluaSet(idr_qfcu_hid_hdgmode, 1)
end

uluaAddDoLoop("qfcu_tbm930_digi_disp_set_HDG()")
--]]
