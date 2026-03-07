-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-22
-- *****************************************************************
if ilua_is_acftitle_excluded("A3") or ilua_is_acfpath_excluded("toliss") then
    if ilua_is_acftitle_excluded("A2") or ilua_is_acfpath_excluded("toliss") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qcduaf = com.sim.qm.Qcduaf:new()
if not qcduaf:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 FO for Toliss")

if uluaFind("AirbusFBW/PanelBrightnessLevel") == nil then
    -- Toliss is not ready yet
    ilua_req_reload()
    return
end

ilua_qlcd_set_airplane(101)

-- ===========================================================
-- button binding

qcduaf:CfgCmd(0, "AirbusFBW/MCDU2LSK1L")
qcduaf:CfgCmd(1, "AirbusFBW/MCDU2LSK2L")
qcduaf:CfgCmd(2, "AirbusFBW/MCDU2LSK3L")
qcduaf:CfgCmd(3, "AirbusFBW/MCDU2LSK4L")
qcduaf:CfgCmd(4, "AirbusFBW/MCDU2LSK5L")
qcduaf:CfgCmd(5, "AirbusFBW/MCDU2LSK6L")
qcduaf:CfgCmd(6, "AirbusFBW/MCDU2LSK1R")
qcduaf:CfgCmd(7, "AirbusFBW/MCDU2LSK2R")
qcduaf:CfgCmd(8, "AirbusFBW/MCDU2LSK3R")
qcduaf:CfgCmd(9, "AirbusFBW/MCDU2LSK4R")
qcduaf:CfgCmd(10, "AirbusFBW/MCDU2LSK5R")
qcduaf:CfgCmd(11, "AirbusFBW/MCDU2LSK6R")
qcduaf:CfgCmd(12, "AirbusFBW/MCDU2DirTo")
qcduaf:CfgCmd(13, "AirbusFBW/MCDU2Prog")
qcduaf:CfgCmd(14, "AirbusFBW/MCDU2Perf")
qcduaf:CfgCmd(15, "AirbusFBW/MCDU2Init")
qcduaf:CfgCmd(16, "AirbusFBW/MCDU2Data")
qcduaf:CfgCmd(17, "AirbusFBW/MCDU2Fpln")
qcduaf:CfgCmd(18, "AirbusFBW/MCDU2RadNav")
qcduaf:CfgCmd(19, "AirbusFBW/MCDU2FuelPred")
qcduaf:CfgCmd(20, "AirbusFBW/MCDU2SecFpln")
qcduaf:CfgCmd(21, "AirbusFBW/MCDU2ATC")
qcduaf:CfgCmd(22, "AirbusFBW/MCDU2Menu")
qcduaf:CfgCmd(23, "AirbusFBW/MCDU2Airport")
qcduaf:CfgCmd(24, "AirbusFBW/MCDU2SlewUp")
qcduaf:CfgCmd(25, "AirbusFBW/MCDU2SlewLeft")
qcduaf:CfgCmd(26, "AirbusFBW/MCDU2SlewRight")
qcduaf:CfgCmd(27, "AirbusFBW/MCDU2Key1")
qcduaf:CfgCmd(28, "AirbusFBW/MCDU2Key2")
qcduaf:CfgCmd(29, "AirbusFBW/MCDU2Key3")
qcduaf:CfgCmd(30, "AirbusFBW/MCDU2Key4")
qcduaf:CfgCmd(31, "AirbusFBW/MCDU2Key5")
qcduaf:CfgCmd(32, "AirbusFBW/MCDU2Key6")
qcduaf:CfgCmd(33, "AirbusFBW/MCDU2Key7")
qcduaf:CfgCmd(34, "AirbusFBW/MCDU2Key8")
qcduaf:CfgCmd(35, "AirbusFBW/MCDU2Key9")
qcduaf:CfgCmd(36, "AirbusFBW/MCDU2KeyDecimal")
qcduaf:CfgCmd(37, "AirbusFBW/MCDU2Key0")
qcduaf:CfgCmd(38, "AirbusFBW/MCDU2KeyPM")
qcduaf:CfgCmd(39, "AirbusFBW/MCDU2KeyA")
qcduaf:CfgCmd(40, "AirbusFBW/MCDU2KeyB")
qcduaf:CfgCmd(41, "AirbusFBW/MCDU2KeyC")
qcduaf:CfgCmd(42, "AirbusFBW/MCDU2KeyD")
qcduaf:CfgCmd(43, "AirbusFBW/MCDU2KeyE")
qcduaf:CfgCmd(44, "AirbusFBW/MCDU2KeyF")
qcduaf:CfgCmd(45, "AirbusFBW/MCDU2KeyG")
qcduaf:CfgCmd(46, "AirbusFBW/MCDU2KeyH")
qcduaf:CfgCmd(47, "AirbusFBW/MCDU2KeyI")
qcduaf:CfgCmd(48, "AirbusFBW/MCDU2KeyJ")
qcduaf:CfgCmd(49, "AirbusFBW/MCDU2KeyK")
qcduaf:CfgCmd(50, "AirbusFBW/MCDU2KeyL")
qcduaf:CfgCmd(51, "AirbusFBW/MCDU2KeyM")
qcduaf:CfgCmd(52, "AirbusFBW/MCDU2KeyN")
qcduaf:CfgCmd(53, "AirbusFBW/MCDU2KeyO")
qcduaf:CfgCmd(54, "AirbusFBW/MCDU2KeyP")
qcduaf:CfgCmd(55, "AirbusFBW/MCDU2KeyQ")
qcduaf:CfgCmd(56, "AirbusFBW/MCDU2KeyR")
qcduaf:CfgCmd(57, "AirbusFBW/MCDU2KeyS")
qcduaf:CfgCmd(58, "AirbusFBW/MCDU2KeyT")
qcduaf:CfgCmd(59, "AirbusFBW/MCDU2KeyU")
qcduaf:CfgCmd(60, "AirbusFBW/MCDU2KeyV")
qcduaf:CfgCmd(61, "AirbusFBW/MCDU2KeyW")
qcduaf:CfgCmd(62, "AirbusFBW/MCDU2KeyX")
qcduaf:CfgCmd(63, "AirbusFBW/MCDU2KeyY")
qcduaf:CfgCmd(64, "AirbusFBW/MCDU2KeyZ")
qcduaf:CfgCmd(65, "AirbusFBW/MCDU2KeySpace")
qcduaf:CfgCmd(66, "AirbusFBW/MCDU2KeyOverfly")
qcduaf:CfgCmd(67, "AirbusFBW/MCDU2KeySlash")
qcduaf:CfgCmd(68, "AirbusFBW/MCDU2KeyClear")
qcduaf:CfgCmd(69, "AirbusFBW/MCDU2KeyDim")
qcduaf:CfgCmd(70, "AirbusFBW/MCDU2KeyBright")
qcduaf:CfgCmd(71, "AirbusFBW/MCDU2SlewDown")
-- ===========================================================
-- Read data

qcduaf:GetFm1("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetInd("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetRdy("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetFm2("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetMenu("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetFail("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")
qcduaf:GetFmgc("cpuwolf/qmdev/QCDU-A3201/condbtn[0]")

qcduaf:GetBkl("AirbusFBW/PanelBrightnessLevel", 60)

qcduaf:GetScreenBrt("AirbusFBW/DUBrightness[7]") -- 0-1
local dr_ac_bus = iDataRef:New("sim/cockpit/electrical/avionics_on")

function CDU_A320_FO_LED_UPD()
    local b_ac_bus = dr_ac_bus:Get()

    qcduaf:SetLeds()

    if dr_ac_bus:ChangedUpdate() then
        qcduaf:SetScreenBrt(0)
        qcduaf:FreshScreenBrt()
    end

    if b_ac_bus == 0 then
        qcduaf:Off()
        return
    end

    qcduaf:SetScreenBrt()
    qcduaf:SetBkl()

end

uluaAddDoLoop("CDU_A320_FO_LED_UPD()")

