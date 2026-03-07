--*****************************************************************
-- Don't modify this file
-- created by Wei Shuai <cpuwolf@gmail.com> 2024-05-16
--*****************************************************************
local Qmcp737c = oop.class(com.sim.Qmdev)

function Qmcp737c:init()
	self.QmdevId = 2
	--uluaLog('Qmcp737c:init'..self.QmdevId)
end


function Qmcp737c:Init()
	if ilua_hw_qmcp737c_absent(self.FastTurnsPerSecond) then
		return false
	end
	if ilua_hw_assigned_qmcp737c == 1 then
		return false
	end
	ilua_hw_assigned_qmcp737c = 1
	return true
end

--CRS1
function Qmcp737c:GetCrs1(dpath)
	self.d_crs1 = iDataRef:New(dpath)
end

function Qmcp737c:SetCrs1()
    uluaSet(idr_qmcp737c_hid_crs1, self.d_crs1:Get())
    uluaSet(idr_qmcp737c_hid_crs1mod, 1)
end

function Qmcp737c:OffCrs1()
    uluaSet(idr_qmcp737c_hid_crs1mod, 0)
end
--IAS/MACh
function Qmcp737c:GetIas(dpath, ismachpath, imachpath, i8path, iapath, dshowpath)
	self.d_ias = iDataRef:New(dpath)
	self.d_is_mach = ismachpath == nil and 0 or iDataRef:New(ismachpath)
	self.d_ias_mach = imachpath == nil and 0 or iDataRef:New(imachpath)
	self.d_ias_8 = i8path == nil and 0 or iDataRef:New(i8path)
	self.d_ias_A = iapath == nil and 0 or iDataRef:New(iapath)
	self.qmcp737c_ias_show = dshowpath == nil and 1 or iDataRef:New(dshowpath)
end

function Qmcp737c:SetIas()
    local d_ias_mach_val = self.d_ias_mach:Get()

    if self.qmcp737c_ias_show:Get() > 0 then
        if self.d_is_mach:Get() > 0 then
            --uluaLog(string.format("IAS_MACH=%f", d_ias_mach_val))
            uluaSet(idr_qmcp737c_hid_disfast_4, 1)
            uluaSet(idr_qmcp737c_hid_disfast_5, 1)
            uluaSet(idr_qmcp737c_hid_ias_f, d_ias_mach_val)
            uluaSet(idr_qmcp737c_hid_iasmod, 3)
        else
            uluaSet(idr_qmcp737c_hid_disfast_4, 0)
            uluaSet(idr_qmcp737c_hid_disfast_5, 0)
            uluaSet(idr_qmcp737c_hid_ias_i, self.d_ias:Get())
            if self.d_ias_A:Get() == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 1)
            elseif self.d_ias_8:Get() == 1 then
                uluaSet(idr_qmcp737c_hid_iasmod, 2)
            else
                uluaSet(idr_qmcp737c_hid_iasmod, 0)
            end
        end
    else
        --hide IAS
        uluaSet(idr_qmcp737c_hid_iasmod, 4)
    end
end

function Qmcp737c:OffIas()
    uluaSet(idr_qmcp737c_hid_iasmod, 4)
end
--HDG
function Qmcp737c:GetHdg(dpath)
	self.d_hdg = iDataRef:New(dpath)
end

function Qmcp737c:SetHdg()
    uluaSet(idr_qmcp737c_hid_hdg, self.d_hdg:Get())
    uluaSet(idr_qmcp737c_hid_hdgmod, 1)
end

function Qmcp737c:OffHdg()
    uluaSet(idr_qmcp737c_hid_hdgmod, 0)
end
--Altitude
function Qmcp737c:GetAlt(dpath, diff)
	self.d_alt = iDataRef:New(dpath)
    self.altdiff = diff == nil and 0 or diff
end

function Qmcp737c:SetAlt()
    dd_alt = self.d_alt:Get()
    if dd_alt < 0 then
        local dis = math.abs(dd_alt + self.altdiff)
        uluaSet(idr_qmcp737c_hid_alt, dis)
        uluaSet(idr_qmcp737c_hid_altmod, 1)
    else
        local dis = dd_alt + self.altdiff
        uluaSet(idr_qmcp737c_hid_alt, dis)
        uluaSet(idr_qmcp737c_hid_altmod, 0)
    end
end

function Qmcp737c:OffAlt()
    uluaSet(idr_qmcp737c_hid_altmod, 2)
end
--VERT SPEED
function Qmcp737c:GetVs(dpath, dshowpath, diff)
	self.d_vs = iDataRef:New(dpath)
    self.qmcp737c_vvi_show = iDataRef:New(dshowpath)
    self.vsdiff = diff == nil and 0 or diff
end

function Qmcp737c:SetVs()
    local d_vs_val = self.d_vs:Get()
    if self.qmcp737c_vvi_show:Get() > 0 then
        if d_vs_val < 0 then
            local dis = math.abs(d_vs_val)
            uluaSet(idr_qmcp737c_hid_vs, dis)
            uluaSet(idr_qmcp737c_hid_vsmod, 1)
        else
            uluaSet(idr_qmcp737c_hid_vs, d_vs_val)
            uluaSet(idr_qmcp737c_hid_vsmod, 0)
        end
    else
        --hide vvi
        uluaSet(idr_qmcp737c_hid_vsmod, 2)
    end
end
function Qmcp737c:OffVs()
    uluaSet(idr_qmcp737c_hid_vsmod, 2)
end

--CRS2
function Qmcp737c:GetCrs2(dpath)
	self.d_crs2 = iDataRef:New(dpath)
end

function Qmcp737c:SetCrs2()
    uluaSet(idr_qmcp737c_hid_crs2, self.d_crs2:Get())
    uluaSet(idr_qmcp737c_hid_crs2mod, 1)
end

function Qmcp737c:OffCrs2()
    uluaSet(idr_qmcp737c_hid_crs2mod, 0)
end

--VHF1/2
function Qmcp737c:GetVhf(dcom1, dcom1s, dcom2, dcom2s)
	self.d_com = iDataRef:New(dcom1)
	self.d_coms = iDataRef:New(dcom1s)

	self.d_com2 = iDataRef:New(dcom2)
	self.d_com2s = iDataRef:New(dcom2s)
end

function Qmcp737c:SetVhfA()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfa, self.d_com:Get())
    else
        uluaSet(idr_qmcp737c_hid_vhfa, self.d_com2:Get())
    end
end

function Qmcp737c:SetVhfS()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_vhfs, self.d_coms:Get())
    else
        uluaSet(idr_qmcp737c_hid_vhfs, self.d_com2s:Get())
    end
end

function Qmcp737c:OffVhf()
    uluaSet(idr_qmcp737c_hid_vhfa, 0)
    uluaSet(idr_qmcp737c_hid_vhfs, 0)
end

function Qmcp737c:BindVhf()
    --small knob
    self:CfgEncFull(56, 57, "cpuwolf/qmdev/QMCP737C/condbtn[56]", 1, 10, 0, -39500, 39500)
    --big knob
    self:CfgEncFull(58, 59, "cpuwolf/qmdev/QMCP737C/condbtn[58]", 1, 10, 0, -39500, 39500)
    --VHF toggle
    self:CfgValT(60, "cpuwolf/qmdev/QMCP737C/condbtn[60]")
    --VHF flip
    self:CfgValT(61, "cpuwolf/qmdev/QMCP737C/condbtn[61]")
end

function Qmcp737c:RegLoopVhf(cmd_vhf1_d_small, cmd_vhf1_u_small,
    cmd_vhf1_d_big, cmd_vhf1_u_big,
    cmd_vhf2_d_small, cmd_vhf2_u_small,
    cmd_vhf2_d_big, cmd_vhf2_u_big,
    cmd_vhf1_mode, cmd_vhf2_mode)

    self.fcb_vhf1_d_small = cmd_vhf1_d_small
    self.fcb_vhf1_u_small = cmd_vhf1_u_small
    self.fcb_vhf2_d_small = cmd_vhf2_d_small
    self.fcb_vhf2_u_small = cmd_vhf2_u_small
    self.fcb_vhf1_d_big = cmd_vhf1_d_big
    self.fcb_vhf1_u_big = cmd_vhf1_u_big
    self.fcb_vhf2_d_big = cmd_vhf2_d_big
    self.fcb_vhf2_u_big = cmd_vhf2_u_big
    self.fcb_vhf1_mode = cmd_vhf1_mode
    self.fcb_vhf2_mode = cmd_vhf2_mode
end

function Qmcp737c:LoopVhf()
    local qmcp737c_val_condbtn_56 = idr_qmcp737c_hid_condbtn_56:Get()
    local qmcp737c_val_condbtn_58 = idr_qmcp737c_hid_condbtn_58:Get()
    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    local qmcp737c_val_condbtn_61 = idr_qmcp737c_hid_condbtn_61:Get()
    ---- VHF1/VHF2 small switch
    if idr_qmcp737c_hid_condbtn_56:Changed() then
        local smallstep = idr_qmcp737c_hid_condbtn_56:Delta()
        uluaLog(string.format("small=%d  %d", smallstep, qmcp737c_val_condbtn_56))
        --uluaSet(idr_qfcu_hid_condbtn_16, 0)
        idr_qmcp737c_hid_condbtn_56:Update()

        if qmcp737c_val_condbtn_60 == 0 then
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    self.fcb_vhf1_d_small()
                end
            else
                for i = 1, smallstep, 1 do
                    self.fcb_vhf1_u_small()
                end
            end
        else
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    self.fcb_vhf2_d_small()
                end
            else
                for i = 1, smallstep, 1 do
                    self.fcb_vhf2_u_small()
                end
            end
        end
    end
    ---- VHF1/VHF2 big switch
    if idr_qmcp737c_hid_condbtn_58:Changed() then
        local smallstep = idr_qmcp737c_hid_condbtn_58:Delta()
        uluaLog(string.format("big=%d  %d", smallstep, qmcp737c_val_condbtn_58))
        --uluaSet(idr_qfcu_hid_condbtn_16, 0)
        idr_qmcp737c_hid_condbtn_58:Update()

        if qmcp737c_val_condbtn_60 == 0 then
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    self.fcb_vhf1_d_big()
                end
            else
                for i = 1, smallstep, 1 do
                    self.fcb_vhf1_u_big()
                end
            end
        else
            if smallstep < 0 then
                for i = 1, -smallstep, 1 do
                    self.fcb_vhf2_d_big()
                end
            else
                for i = 1, smallstep, 1 do
                    self.fcb_vhf2_u_big()
                end
            end
        end
    end
    ----toggle VHF1/2
    if idr_qmcp737c_hid_condbtn_60:Changed() then
        idr_qmcp737c_hid_condbtn_60:Update()
    end
    ----switch active/stanby
    if idr_qmcp737c_hid_condbtn_61:Changed() then
        idr_qmcp737c_hid_condbtn_61:Update()
        if qmcp737c_val_condbtn_60 == 0 then
            self.fcb_vhf1_mode()
        else
            self.fcb_vhf2_mode()
        end
    end

end

--Nav
function Qmcp737c:GetNav(dnav1, dnav1s, dnav2, dnav2s)
	self.d_nav = iDataRef:New(dnav1)
	self.d_navs = iDataRef:New(dnav1s)

	self.d_nav2 = iDataRef:New(dnav2)
	self.d_nav2s = iDataRef:New(dnav2s)
    self.lua_nav1_or_nav2 = 0 -- NAV1 default value
end

function Qmcp737c:SetNavA()
    if self.lua_nav1_or_nav2 == 0 then
        uluaSet(idr_qmcp737c_hid_nava, self.d_nav:Get())
    else
        uluaSet(idr_qmcp737c_hid_nava, self.d_nav2:Get())
    end
    uluaSet(idr_qmcp737c_hid_navamod, 1)    
end

function Qmcp737c:SetNavS()
    if self.lua_nav1_or_nav2 == 0 then
        uluaSet(idr_qmcp737c_hid_navs, self.d_navs:Get())
    else
        uluaSet(idr_qmcp737c_hid_navs, self.d_nav2s:Get())
    end
    uluaSet(idr_qmcp737c_hid_navsmod, 1)    
end

function Qmcp737c:OffNav()
    uluaSet(idr_qmcp737c_hid_navamod, 0)
    uluaSet(idr_qmcp737c_hid_navsmod, 0)
end

function Qmcp737c:FlipNav(fcb_nav1, fcb_nav2)
    self.lua_nav1_or_nav2 = 1 - self.lua_nav1_or_nav2
    if self.lua_nav1_or_nav2 == 0 then
        fcb_nav1()
    else
        fcb_nav2()
    end
end

--LED Indicator
function Qmcp737c:GetLed(
    led_vhf1, led_vhf2,
    led_ma, led_at, 
    led_n1, led_spd, led_lvl,
    led_vnav,
    led_hdgs, led_lnav, led_vorl, led_app, led_alth, led_vs,
    led_cmda, led_cmdb,
    led_lgl, led_lgn, led_lgr)

    self.led_vhf1 = uluaFind("laminar/B738/comm/rtp_L/vhf_1_status")
    self.led_vhf2 = uluaFind("laminar/B738/comm/rtp_L/vhf_2_status")
    
    self.led_ma = uluaFind("laminar/B738/autopilot/master_capt_status")
    self.led_at = uluaFind("laminar/B738/autopilot/autothrottle_arm_pos")
    
    self.led_n1 = uluaFind("laminar/B738/autopilot/n1_status")
    self.led_spd = uluaFind("laminar/B738/autopilot/speed_status1")
    self.led_lvl = uluaFind("laminar/B738/autopilot/lvl_chg_status")
    
    self.led_vnav = uluaFind("laminar/B738/autopilot/vnav_status1")
    
    self.led_hdgs = uluaFind("laminar/B738/autopilot/hdg_sel_status")
    
    self.led_lnav = uluaFind("laminar/B738/autopilot/lnav_status")
    self.led_vorl = uluaFind("laminar/B738/autopilot/vorloc_status")
    self.led_app = uluaFind("laminar/B738/autopilot/app_status")
    
    self.led_alth = uluaFind("laminar/B738/autopilot/alt_hld_status")
    self.led_vs = uluaFind("laminar/B738/autopilot/vs_status")
    self.led_cmda = uluaFind("laminar/B738/autopilot/cmd_a_status")
    self.led_cmdb = uluaFind("laminar/B738/autopilot/cmd_b_status")
    
    self.led_lgl = uluaFind("laminar/B738/annunciator/left_gear_safe")
    self.led_lgn = uluaFind("laminar/B738/annunciator/nose_gear_safe")
    self.led_lgr = uluaFind("laminar/B738/annunciator/right_gear_safe")
end

function Qmcp737c:SetLed()

    uluaSet(idr_qmcp737c_hid_ledapp, ilua_01_ternary(self.led_app, 0))
    uluaSet(idr_qmcp737c_hid_ledalth, ilua_01_ternary(self.led_alth, 0))
    uluaSet(idr_qmcp737c_hid_ledvs, ilua_01_ternary(self.led_vs, 0))
    uluaSet(idr_qmcp737c_hid_ledcmda, ilua_01_ternary(self.led_cmda, 0))
    uluaSet(idr_qmcp737c_hid_ledcmdb, ilua_01_ternary(self.led_cmdb, 0))
    uluaSet(idr_qmcp737c_hid_ledlgn, ilua_01_ternary(self.led_lgn, 0))
    uluaSet(idr_qmcp737c_hid_ledlgl, ilua_01_ternary(self.led_lgl, 0))
    uluaSet(idr_qmcp737c_hid_ledlgr, ilua_01_ternary(self.led_lgr, 0))
    uluaSet(idr_qmcp737c_hid_ledma, ilua_01_ternary(self.led_ma, 0))
    uluaSet(idr_qmcp737c_hid_ledn1, ilua_01_ternary(self.led_n1, 0))
    uluaSet(idr_qmcp737c_hid_ledspd, ilua_01_ternary(self.led_spd, 0))
    uluaSet(idr_qmcp737c_hid_ledlvl, ilua_01_ternary(self.led_lvl, 0))
    uluaSet(idr_qmcp737c_hid_ledvnav, ilua_01_ternary(self.led_vnav, 0))
    uluaSet(idr_qmcp737c_hid_ledhdgs, ilua_01_ternary(self.led_hdgs, 0))
    uluaSet(idr_qmcp737c_hid_ledlnav, ilua_01_ternary(self.led_lnav, 0))
    uluaSet(idr_qmcp737c_hid_ledvorl, ilua_01_ternary(self.led_vorl, 0))
    uluaSet(idr_qmcp737c_hid_ledat, ilua_01_ternary(self.led_at, 0))

    local qmcp737c_val_condbtn_60 = idr_qmcp737c_hid_condbtn_60:Get()
    if qmcp737c_val_condbtn_60 == 0 then
        uluaSet(idr_qmcp737c_hid_ledvhf1, 1)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 0)
    else
        uluaSet(idr_qmcp737c_hid_ledvhf1, 0)
        uluaSet(idr_qmcp737c_hid_ledvhf2, 1)
    end
end

function Qmcp737c:OffLed()
    uluaSet(idr_qmcp737c_hid_leds, 0)
end

function Qmcp737c:LoopMcp()
    self:SetCrs1()
    self:SetIas()
    self:SetHdg()
    self:SetAlt()
    self:SetVs()
    self:SetCrs2()
end

function Qmcp737c:OffMcp()
	self:OffCrs1()
	self:OffIas()
	self:OffHdg()
	self:OffAlt()
	self:OffVs()
	self:OffCrs2()
end

return Qmcp737c

