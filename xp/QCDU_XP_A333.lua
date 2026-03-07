-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2026-01-23
-- *****************************************************************
if PLANE_ICAO ~= "A333" then
    return
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection

local qfcu_a330_xp_new = false
if uluaFind("laminar/A333/adirs/on_bat_status") then
    -- X-Plane 12.40 is here
    qfcu_a330_xp_new = true
end

uluaLog("QCDU-A320 for X-Plane Default A333")


ilua_qlcd_set_airplane(100)

-- ===========================================================
-- button binding

qcdua:CfgCmd(0, "sim/FMS/ls_1l")
qcdua:CfgCmd(1, "sim/FMS/ls_2l")
qcdua:CfgCmd(2, "sim/FMS/ls_3l")
qcdua:CfgCmd(3, "sim/FMS/ls_4l")
qcdua:CfgCmd(4, "sim/FMS/ls_5l")
qcdua:CfgCmd(5, "sim/FMS/ls_6l")
qcdua:CfgCmd(6, "sim/FMS/ls_1r")
qcdua:CfgCmd(7, "sim/FMS/ls_2r")
qcdua:CfgCmd(8, "sim/FMS/ls_3r")
qcdua:CfgCmd(9, "sim/FMS/ls_4r")
qcdua:CfgCmd(10, "sim/FMS/ls_5r")
qcdua:CfgCmd(11, "sim/FMS/ls_6r")
qcdua:CfgCmd(12, "sim/FMS/dir_intc")
qcdua:CfgCmd(13, "sim/FMS/prog")
qcdua:CfgCmd(14, "sim/FMS/perf")
qcdua:CfgCmd(15, "sim/FMS/index")
qcdua:CfgCmd(16, "sim/FMS/data")
qcdua:CfgCmd(17, "sim/FMS/fpln")
qcdua:CfgCmd(18, "sim/FMS/navrad")
qcdua:CfgCmd(19, "sim/FMS/fuel_pred")
qcdua:CfgCmd(20, "sim/FMS/sec_fpln")
qcdua:CfgCmd(21, "sim/FMS/atc_comm")
qcdua:CfgCmd(22, "sim/FMS/menu")
qcdua:CfgCmd(23, "sim/FMS/airport")
qcdua:CfgCmd(24, "sim/FMS/up")
qcdua:CfgCmd(25, "sim/FMS/prev")
qcdua:CfgCmd(26, "sim/FMS/next")
qcdua:CfgCmd(27, "sim/FMS/key_1")
qcdua:CfgCmd(28, "sim/FMS/key_2")
qcdua:CfgCmd(29, "sim/FMS/key_3")
qcdua:CfgCmd(30, "sim/FMS/key_4")
qcdua:CfgCmd(31, "sim/FMS/key_5")
qcdua:CfgCmd(32, "sim/FMS/key_6")
qcdua:CfgCmd(33, "sim/FMS/key_7")
qcdua:CfgCmd(34, "sim/FMS/key_8")
qcdua:CfgCmd(35, "sim/FMS/key_9")
qcdua:CfgCmd(36, "sim/FMS/key_period")
qcdua:CfgCmd(37, "sim/FMS/key_0")
qcdua:CfgCmd(38, "sim/FMS/key_minus")
qcdua:CfgCmd(39, "sim/FMS/key_A")
qcdua:CfgCmd(40, "sim/FMS/key_B")
qcdua:CfgCmd(41, "sim/FMS/key_C")
qcdua:CfgCmd(42, "sim/FMS/key_D")
qcdua:CfgCmd(43, "sim/FMS/key_E")
qcdua:CfgCmd(44, "sim/FMS/key_F")
qcdua:CfgCmd(45, "sim/FMS/key_G")
qcdua:CfgCmd(46, "sim/FMS/key_H")
qcdua:CfgCmd(47, "sim/FMS/key_I")
qcdua:CfgCmd(48, "sim/FMS/key_J")
qcdua:CfgCmd(49, "sim/FMS/key_K")
qcdua:CfgCmd(50, "sim/FMS/key_L")
qcdua:CfgCmd(51, "sim/FMS/key_M")
qcdua:CfgCmd(52, "sim/FMS/key_N")
qcdua:CfgCmd(53, "sim/FMS/key_O")
qcdua:CfgCmd(54, "sim/FMS/key_P")
qcdua:CfgCmd(55, "sim/FMS/key_Q")
qcdua:CfgCmd(56, "sim/FMS/key_R")
qcdua:CfgCmd(57, "sim/FMS/key_S")
qcdua:CfgCmd(58, "sim/FMS/key_T")
qcdua:CfgCmd(59, "sim/FMS/key_U")
qcdua:CfgCmd(60, "sim/FMS/key_V")
qcdua:CfgCmd(61, "sim/FMS/key_W")
qcdua:CfgCmd(62, "sim/FMS/key_X")
qcdua:CfgCmd(63, "sim/FMS/key_Y")
qcdua:CfgCmd(64, "sim/FMS/key_Z")
qcdua:CfgCmd(65, "sim/FMS/key_space")
qcdua:CfgCmd(66, "sim/FMS/key_overfly")
qcdua:CfgCmd(67, "sim/FMS/key_slash")
qcdua:CfgCmd(68, "sim/FMS/key_clear")
qcdua:CfgCmd(69, "laminar/A333/buttons/fms1_brightness_dn")
qcdua:CfgCmd(70, "laminar/A333/buttons/fms1_brightness_up")
qcdua:CfgCmd(71, "sim/FMS/down")

-- ===========================================================
-- Read data

qcdua:GetFm1("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetInd("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetRdy("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFm2("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetMenu("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFail("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFmgc("cpuwolf/qmdev/QCDU-A320/condbtn[0]")

qcdua:GetBkl("laminar/a333/rheostats/integ_light_brightness", 60) -- 0~1

local dr_ac_bus
if not qfcu_a330_xp_new then
    dr_ac_bus = iDataRef:New("sim/cockpit2/radios/actuators/com2_power")
else
    dr_ac_bus = iDataRef:New("laminar/A333/elec/dc_bat_bus_has_power")
end

if qfcu_a330_xp_new then
    qcdua:GetScreenBrt("laminar/a333/MCDU1/bright_setting")  -- 0-1
else
    qcdua:GetScreenBrt("sim/cockpit/electrical/avionics_on") -- 0-1
end

function CDU_XP_A333_LED_UPD()
    local b_ac_bus = dr_ac_bus:Get()
    qcdua:SetLeds()
    if dr_ac_bus:ChangedUpdate() then
        qcdua:SetScreenBrt(0)
        qcdua:FreshScreenBrt()
    end

    if b_ac_bus == 0 then
        qcdua:Off()
        return
    else
        qcdua:FreshBkl()
    end
    qcdua:SetScreenBrt()
    qcdua:SetBkl()
end

uluaAddDoLoop("CDU_XP_A333_LED_UPD()")
