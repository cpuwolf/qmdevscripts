-- *****************************************************************
-- created by Joseph Yoon <joseph@jyoon.pro> 2024-07-01
-- *****************************************************************
if ilua_is_acfpath_excluded("TFDi") and ilua_is_acfpath_excluded("MD-11") then
    return
end

-- Do not remove below lines: hardware detection
local qcdua = com.sim.qm.Qcdua:new()
if not qcdua:Init() then
    return
end
-- Do not remove above lines: hardware detection

uluaLog("QCDU-A320 for TFDi MD-11")

-- ===========================================================
-- button binding

-- LSK 1L ~ LSK 6R
qcdua:CfgRpn(0, '81925 (>L:CEVENT)', '81926 (>L:CEVENT)')
qcdua:CfgRpn(1, '81927 (>L:CEVENT)', '81928 (>L:CEVENT)')
qcdua:CfgRpn(2, '81929 (>L:CEVENT)', '81930 (>L:CEVENT)')
qcdua:CfgRpn(3, '81931 (>L:CEVENT)', '81932 (>L:CEVENT)')
qcdua:CfgRpn(4, '81933 (>L:CEVENT)', '81934 (>L:CEVENT)')
qcdua:CfgRpn(5, '81935 (>L:CEVENT)', '81936 (>L:CEVENT)')
qcdua:CfgRpn(6, '81937 (>L:CEVENT)', '81938 (>L:CEVENT)')
qcdua:CfgRpn(7, '81939 (>L:CEVENT)', '81940 (>L:CEVENT)')
qcdua:CfgRpn(8, '81941 (>L:CEVENT)', '81942 (>L:CEVENT)')
qcdua:CfgRpn(9, '81943 (>L:CEVENT)', '81944 (>L:CEVENT)')
qcdua:CfgRpn(10, '81945 (>L:CEVENT)', '81946 (>L:CEVENT)')
qcdua:CfgRpn(11, '81947 (>L:CEVENT)', '81948 (>L:CEVENT)')

-- DIR, PROG, PERF, INT, DATA
-- F-PLN, RADNAV, FUELPRED, SECF-PLN, ATCCOMM, MCDUMENU
-- AIRPORT
qcdua:CfgRpn(12, '81951 (>L:CEVENT)', '81952 (>L:CEVENT)')
qcdua:CfgRpn(13, '81963 (>L:CEVENT)', '81964 (>L:CEVENT)')
qcdua:CfgRpn(14, '81955 (>L:CEVENT)', '81956 (>L:CEVENT)')
qcdua:CfgRpn(15, '81957 (>L:CEVENT)', '81958 (>L:CEVENT)')
qcdua:CfgRpn(16, '81969 (>L:CEVENT)', '81970 (>L:CEVENT)')
qcdua:CfgRpn(17, '81961 (>L:CEVENT)', '81962 (>L:CEVENT)')
qcdua:CfgRpn(18, '81953 (>L:CEVENT)', '81954 (>L:CEVENT)')
qcdua:CfgRpn(19, '81959 (>L:CEVENT)', '81960 (>L:CEVENT)')
qcdua:CfgRpn(20, '81967 (>L:CEVENT)', '81968 (>L:CEVENT)')
qcdua:CfgRpn(21, '81965 (>L:CEVENT)', '81966 (>L:CEVENT)')
qcdua:CfgRpn(22, '81973 (>L:CEVENT)', '81974 (>L:CEVENT)')
qcdua:CfgRpn(23, '81971 (>L:CEVENT)', '81972 (>L:CEVENT)')

-- UP, NEXT, DOWN
qcdua:CfgRpn(24, '81975 (>L:CEVENT)', '81976 (>L:CEVENT)')
qcdua:CfgRpn(26, '81977 (>L:CEVENT)', '81978 (>L:CEVENT)')
qcdua:CfgRpn(71, '81979 (>L:CEVENT)', '81980 (>L:CEVENT)')

-- 1~9, DOT, 0, +/-
qcdua:CfgRpn(27, '81981 (>L:CEVENT)', '81982 (>L:CEVENT)')
qcdua:CfgRpn(28, '81983 (>L:CEVENT)', '81984 (>L:CEVENT)')
qcdua:CfgRpn(29, '81985 (>L:CEVENT)', '81986 (>L:CEVENT)')
qcdua:CfgRpn(30, '81987 (>L:CEVENT)', '81988 (>L:CEVENT)')
qcdua:CfgRpn(31, '81989 (>L:CEVENT)', '81990 (>L:CEVENT)')
qcdua:CfgRpn(32, '81991 (>L:CEVENT)', '81992 (>L:CEVENT)')
qcdua:CfgRpn(33, '81993 (>L:CEVENT)', '81994 (>L:CEVENT)')
qcdua:CfgRpn(34, '81995 (>L:CEVENT)', '81996 (>L:CEVENT)')
qcdua:CfgRpn(35, '81997 (>L:CEVENT)', '81998 (>L:CEVENT)')
qcdua:CfgRpn(36, '82003 (>L:CEVENT)', '82004 (>L:CEVENT)')
qcdua:CfgRpn(37, '82001 (>L:CEVENT)', '82002 (>L:CEVENT)')
qcdua:CfgRpn(38, '82057 (>L:CEVENT)', '82058 (>L:CEVENT)')

-- A~Z, SP, OVFY, /, CLR
qcdua:CfgRpn(39, '82005 (>L:CEVENT)', '82006 (>L:CEVENT)')
qcdua:CfgRpn(40, '82007 (>L:CEVENT)', '82008 (>L:CEVENT)')
qcdua:CfgRpn(41, '82009 (>L:CEVENT)', '82010 (>L:CEVENT)')
qcdua:CfgRpn(42, '82011 (>L:CEVENT)', '82012 (>L:CEVENT)')
qcdua:CfgRpn(43, '82013 (>L:CEVENT)', '82014 (>L:CEVENT)')
qcdua:CfgRpn(44, '82015 (>L:CEVENT)', '82016 (>L:CEVENT)')
qcdua:CfgRpn(45, '82017 (>L:CEVENT)', '82018 (>L:CEVENT)')
qcdua:CfgRpn(46, '82019 (>L:CEVENT)', '82020 (>L:CEVENT)')
qcdua:CfgRpn(47, '82021 (>L:CEVENT)', '82022 (>L:CEVENT)')
qcdua:CfgRpn(48, '82023 (>L:CEVENT)', '82024 (>L:CEVENT)')
qcdua:CfgRpn(49, '82025 (>L:CEVENT)', '82026 (>L:CEVENT)')
qcdua:CfgRpn(50, '82027 (>L:CEVENT)', '82028 (>L:CEVENT)')
qcdua:CfgRpn(51, '82029 (>L:CEVENT)', '82030 (>L:CEVENT)')
qcdua:CfgRpn(52, '82031 (>L:CEVENT)', '82032 (>L:CEVENT)')
qcdua:CfgRpn(53, '82033 (>L:CEVENT)', '82034 (>L:CEVENT)')
qcdua:CfgRpn(54, '82035 (>L:CEVENT)', '82036 (>L:CEVENT)')
qcdua:CfgRpn(55, '82037 (>L:CEVENT)', '82038 (>L:CEVENT)')
qcdua:CfgRpn(56, '82039 (>L:CEVENT)', '82040 (>L:CEVENT)')
qcdua:CfgRpn(57, '82041 (>L:CEVENT)', '82042 (>L:CEVENT)')
qcdua:CfgRpn(58, '82043 (>L:CEVENT)', '82044 (>L:CEVENT)')
qcdua:CfgRpn(59, '82045 (>L:CEVENT)', '82046 (>L:CEVENT)')
qcdua:CfgRpn(60, '82047 (>L:CEVENT)', '82048 (>L:CEVENT)')
qcdua:CfgRpn(61, '82049 (>L:CEVENT)', '82050 (>L:CEVENT)')
qcdua:CfgRpn(62, '82051 (>L:CEVENT)', '82052 (>L:CEVENT)')
qcdua:CfgRpn(63, '82053 (>L:CEVENT)', '82054 (>L:CEVENT)')
qcdua:CfgRpn(64, '82055 (>L:CEVENT)', '82056 (>L:CEVENT)')
qcdua:CfgRpn(65, '82061 (>L:CEVENT)', '82062 (>L:CEVENT)')
qcdua:CfgRpn(66, '82059 (>L:CEVENT)', '82060 (>L:CEVENT)')
qcdua:CfgRpn(67, '81999 (>L:CEVENT)', '82000 (>L:CEVENT)')
qcdua:CfgRpn(68, '82063 (>L:CEVENT)', '82064 (>L:CEVENT)')

-- DIM, BRT
qcdua:CfgRpn(69, '81949 (>L:CEVENT)', '81949 (>L:CEVENT)')
qcdua:CfgRpn(70, '81950 (>L:CEVENT)', '81950 (>L:CEVENT)')

-- ===========================================================
-- Read data

qcdua:GetFm1("(L:MD11_LMCDU_DSPY_LT)")
qcdua:GetInd("(L:MD11_LMCDU_DSPY_LT)")
qcdua:GetRdy("(L:MD11_LMCDU_DSPY_LT)")
qcdua:GetFm2("(L:MD11_RMCDU_DSPY_LT)")
qcdua:GetMenu("(L:MD11_LMCDU_MSG_LT)")
qcdua:GetFail("(L:MD11_LMCDU_FAIL_LT)")
qcdua:GetFmgc("(L:MD11_LMCDU_OFST_LT)")
qcdua:GetBkl("(L:MD11_OVHD_LTS_OUTER_INSTR_PED_PNL_FLOOD_KB)", 3)

function CDU_TFDIMD11_LED_UPD()
    qcdua:SetLeds()
    qcdua:SetBkl()
end

uluaAddDoLoop("CDU_TFDIMD11_LED_UPD()")

