-- *****************************************************************
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-22
-- *****************************************************************
if ilua_is_acftitle_excluded("A3") or ilua_is_acfpath_excluded("toliss") then
    if ilua_is_acftitle_excluded("A2") or ilua_is_acfpath_excluded("toliss") then
        return
    end
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 for Toliss")

if uluaFind("AirbusFBW/PanelBrightnessLevel") == nil then
    -- Toliss is not ready yet
    ilua_req_reload()
    return
end

ilua_qlcd_set_airplane(100)

-- ===========================================================
-- button binding

qcdua:CfgCmd(0, "AirbusFBW/MCDU1LSK1L")
qcdua:CfgCmd(1, "AirbusFBW/MCDU1LSK2L")
qcdua:CfgCmd(2, "AirbusFBW/MCDU1LSK3L")
qcdua:CfgCmd(3, "AirbusFBW/MCDU1LSK4L")
qcdua:CfgCmd(4, "AirbusFBW/MCDU1LSK5L")
qcdua:CfgCmd(5, "AirbusFBW/MCDU1LSK6L")
qcdua:CfgCmd(6, "AirbusFBW/MCDU1LSK1R")
qcdua:CfgCmd(7, "AirbusFBW/MCDU1LSK2R")
qcdua:CfgCmd(8, "AirbusFBW/MCDU1LSK3R")
qcdua:CfgCmd(9, "AirbusFBW/MCDU1LSK4R")
qcdua:CfgCmd(10, "AirbusFBW/MCDU1LSK5R")
qcdua:CfgCmd(11, "AirbusFBW/MCDU1LSK6R")
qcdua:CfgCmd(12, "AirbusFBW/MCDU1DirTo")
qcdua:CfgCmd(13, "AirbusFBW/MCDU1Prog")
qcdua:CfgCmd(14, "AirbusFBW/MCDU1Perf")
qcdua:CfgCmd(15, "AirbusFBW/MCDU1Init")
qcdua:CfgCmd(16, "AirbusFBW/MCDU1Data")
qcdua:CfgCmd(17, "AirbusFBW/MCDU1Fpln")
qcdua:CfgCmd(18, "AirbusFBW/MCDU1RadNav")
qcdua:CfgCmd(19, "AirbusFBW/MCDU1FuelPred")
qcdua:CfgCmd(20, "AirbusFBW/MCDU1SecFpln")
qcdua:CfgCmd(21, "AirbusFBW/MCDU1ATC")
qcdua:CfgCmd(22, "AirbusFBW/MCDU1Menu")
qcdua:CfgCmd(23, "AirbusFBW/MCDU1Airport")
qcdua:CfgCmd(24, "AirbusFBW/MCDU1SlewUp")
qcdua:CfgCmd(25, "AirbusFBW/MCDU1SlewLeft")
qcdua:CfgCmd(26, "AirbusFBW/MCDU1SlewRight")
qcdua:CfgCmd(27, "AirbusFBW/MCDU1Key1")
qcdua:CfgCmd(28, "AirbusFBW/MCDU1Key2")
qcdua:CfgCmd(29, "AirbusFBW/MCDU1Key3")
qcdua:CfgCmd(30, "AirbusFBW/MCDU1Key4")
qcdua:CfgCmd(31, "AirbusFBW/MCDU1Key5")
qcdua:CfgCmd(32, "AirbusFBW/MCDU1Key6")
qcdua:CfgCmd(33, "AirbusFBW/MCDU1Key7")
qcdua:CfgCmd(34, "AirbusFBW/MCDU1Key8")
qcdua:CfgCmd(35, "AirbusFBW/MCDU1Key9")
qcdua:CfgCmd(36, "AirbusFBW/MCDU1KeyDecimal")
qcdua:CfgCmd(37, "AirbusFBW/MCDU1Key0")
qcdua:CfgCmd(38, "AirbusFBW/MCDU1KeyPM")
qcdua:CfgCmd(39, "AirbusFBW/MCDU1KeyA")
qcdua:CfgCmd(40, "AirbusFBW/MCDU1KeyB")
qcdua:CfgCmd(41, "AirbusFBW/MCDU1KeyC")
qcdua:CfgCmd(42, "AirbusFBW/MCDU1KeyD")
qcdua:CfgCmd(43, "AirbusFBW/MCDU1KeyE")
qcdua:CfgCmd(44, "AirbusFBW/MCDU1KeyF")
qcdua:CfgCmd(45, "AirbusFBW/MCDU1KeyG")
qcdua:CfgCmd(46, "AirbusFBW/MCDU1KeyH")
qcdua:CfgCmd(47, "AirbusFBW/MCDU1KeyI")
qcdua:CfgCmd(48, "AirbusFBW/MCDU1KeyJ")
qcdua:CfgCmd(49, "AirbusFBW/MCDU1KeyK")
qcdua:CfgCmd(50, "AirbusFBW/MCDU1KeyL")
qcdua:CfgCmd(51, "AirbusFBW/MCDU1KeyM")
qcdua:CfgCmd(52, "AirbusFBW/MCDU1KeyN")
qcdua:CfgCmd(53, "AirbusFBW/MCDU1KeyO")
qcdua:CfgCmd(54, "AirbusFBW/MCDU1KeyP")
qcdua:CfgCmd(55, "AirbusFBW/MCDU1KeyQ")
qcdua:CfgCmd(56, "AirbusFBW/MCDU1KeyR")
qcdua:CfgCmd(57, "AirbusFBW/MCDU1KeyS")
qcdua:CfgCmd(58, "AirbusFBW/MCDU1KeyT")
qcdua:CfgCmd(59, "AirbusFBW/MCDU1KeyU")
qcdua:CfgCmd(60, "AirbusFBW/MCDU1KeyV")
qcdua:CfgCmd(61, "AirbusFBW/MCDU1KeyW")
qcdua:CfgCmd(62, "AirbusFBW/MCDU1KeyX")
qcdua:CfgCmd(63, "AirbusFBW/MCDU1KeyY")
qcdua:CfgCmd(64, "AirbusFBW/MCDU1KeyZ")
qcdua:CfgCmd(65, "AirbusFBW/MCDU1KeySpace")
qcdua:CfgCmd(66, "AirbusFBW/MCDU1KeyOverfly")
qcdua:CfgCmd(67, "AirbusFBW/MCDU1KeySlash")
qcdua:CfgCmd(68, "AirbusFBW/MCDU1KeyClear")
qcdua:CfgCmd(69, "AirbusFBW/MCDU1KeyDim")
qcdua:CfgCmd(70, "AirbusFBW/MCDU1KeyBright")
qcdua:CfgCmd(71, "AirbusFBW/MCDU1SlewDown")

-- ===========================================================
-- Read data

qcdua:GetFm1("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetInd("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetRdy("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFm2("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetMenu("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFail("cpuwolf/qmdev/QCDU-A320/condbtn[0]")
qcdua:GetFmgc("cpuwolf/qmdev/QCDU-A320/condbtn[0]")

qcdua:GetBkl("AirbusFBW/PanelBrightnessLevel", 60) -- 0~1
local dr_ac_bus = iDataRef:New("sim/cockpit/electrical/avionics_on")

qcdua:GetScreenBrt("AirbusFBW/DUBrightness[6]") -- 0-1

function CDU_A320_LED_UPD()
    local b_ac_bus = dr_ac_bus:Get()
    qcdua:SetLeds()
    if dr_ac_bus:ChangedUpdate() then
        qcdua:SetScreenBrt(0)
        qcdua:FreshScreenBrt()
    end

    if b_ac_bus == 0 then
        qcdua:Off()
        return
    end
    qcdua:SetScreenBrt()
    qcdua:SetBkl()

end

uluaAddDoLoop("CDU_A320_LED_UPD()")

