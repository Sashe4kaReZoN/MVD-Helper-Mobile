script_name("MVD Helper Mobile")
script_version("4.6")
script_author("@Sashe4ka_ReZoN")

local imgui = require 'mimgui'
local ffi = require 'ffi'
local inicfg = require("inicfg")
local faicons = require('fAwesome6')
local sampev = require('lib.samp.events')
function isMonetLoader() return MONET_VERSION ~= nil end

local encoding = require 'encoding'
encoding.default = 'CP1251'
local u8 = encoding.UTF8
local new = imgui.new


sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}������ ������� ����������", 0x8B00FF)
sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}������:t.me/Sashe4ka_ReZoN",0x8B00FF)
sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}����� ���������� ��������,������� /mvd and /mvds ",0x8B00FF)

local renderWindow = new.bool()
local sizeX, sizeY = getScreenResolution()
local id = imgui.new.int(0)
local otherorg = imgui.new.char(255)
local zk = new.bool()
local autogun = new.bool()
local tab = 1
local patrul = new.bool()
local partner = imgui.new.char(255)
local chatrp = new.bool()
local arr = os.date("*t")
local poziv = imgui.new.char(255)
local pozivn = imgui.new.bool()
local suppWindow = imgui.new.bool()
windowTwo = imgui.new.bool()
setUkWindow = imgui.new.bool()
addUkWindow = imgui.new.bool()
local newUkInput = imgui.new.char(255)
local newUkUr = imgui.new.int(0)
local car = faicons('CAR')
local list = faicons('list')
local info = faicons('info')
local settings = faicons('gear')
local radio = faicons('user')
local pen = faicons('pen')
local sliders = faicons('sliders')
local userSecret = faicons('user-secret')
leaderPanel = imgui.new.bool()
local spawn = true
local mainIni = inicfg.load({
    Accent = {
        accent = '[���������� ������]: ',
        autoAccent = false
    },
    Info = {
        org = '�� �� �������� � ��',
        dl = '�� �� �������� � ��',
        rang_n = 0
    },
    theme = {
        themeta = 0
    }
}, "mvdhelper.ini")
local file = io.open("smartUk.json", "r") -- ��������� ���� � ������ ������
a = file:read("*a") -- ������ ����, ��� � ��� �������
file:close() -- ���������
tableUk = decodeJson(a) -- ������ ���� JSON-�������



local statsCheck = false

local AutoAccentBool = new.bool(mainIni.Accent.autoAccent)
local AutoAccentInput = new.char[255](u8(mainIni.Accent.accent))
local org = u8'�� �� �������� � ��'
local org_g = u8'�� �� �������� � ��'
local ccity = u8'�� �� �������� � ��'
local org_tag = u8'�� �� �������� � ��'
local dol = '�� �� �������� � ��'
local dl = u8'�� �� �������� � ��'
local rang_n = 0
local colorList = {u8'�����������', u8'�������', u8'������',u8'�����', u8'����������'} -- ������ ������� � ���������� ���
local colorListNumber = new.int(mainIni.theme.themeta) -- ������ ����� ��� ����� �������� ����� ��������� ����
local colorListBuffer = new['const char*'][#colorList](colorList) -- ������ ����� ��� ������
local nickname = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
local autoScrinArest = new.bool()

local sliderBuf = new.int() -- ����� ��� ��������� ��������
theme = {
    {
        change = function()
            imgui.SwitchContext()
            --==[ STYLE ]==--
            imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
            imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
            imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
            imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
            imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
            imgui.GetStyle().IndentSpacing = 0
            imgui.GetStyle().ScrollbarSize = 10
            imgui.GetStyle().GrabMinSize = 10

            --==[ BORDER ]==--
            imgui.GetStyle().WindowBorderSize = 1
            imgui.GetStyle().ChildBorderSize = 1
            imgui.GetStyle().PopupBorderSize = 1
            imgui.GetStyle().FrameBorderSize = 1
            imgui.GetStyle().TabBorderSize = 1

            --==[ ROUNDING ]==--
            imgui.GetStyle().WindowRounding = 5
            imgui.GetStyle().ChildRounding = 5
            imgui.GetStyle().FrameRounding = 5
            imgui.GetStyle().PopupRounding = 5
            imgui.GetStyle().ScrollbarRounding = 5
            imgui.GetStyle().GrabRounding = 5
            imgui.GetStyle().TabRounding = 5

            --==[ ALIGN ]==--
            imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
            imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
            imgui.GetStyle().SelectableTextAlign = imgui.ImVec2(0.5, 0.5)
            
            --==[ COLORS ]==--
            imgui.GetStyle().Colors[imgui.Col.Text]                   = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = imgui.ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = imgui.ImVec4(0.07, 0.07, 0.07, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = imgui.ImVec4(0.25, 0.25, 0.26, 0.54)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = imgui.ImVec4(0.25, 0.25, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = imgui.ImVec4(0.00, 0.00, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = imgui.ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = imgui.ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = imgui.ImVec4(0.21, 0.20, 0.20, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = imgui.ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = imgui.ImVec4(0.20, 0.20, 0.20, 1.00)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = imgui.ImVec4(0.47, 0.47, 0.47, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = imgui.ImVec4(1.00, 1.00, 1.00, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = imgui.ImVec4(1.00, 1.00, 1.00, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = imgui.ImVec4(1.00, 1.00, 1.00, 0.95)
            imgui.GetStyle().Colors[imgui.Col.Tab]                    = imgui.ImVec4(0.12, 0.12, 0.12, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabHovered]             = imgui.ImVec4(0.28, 0.28, 0.28, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabActive]              = imgui.ImVec4(0.30, 0.30, 0.30, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = imgui.ImVec4(0.07, 0.10, 0.15, 0.97)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = imgui.ImVec4(0.14, 0.26, 0.42, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = imgui.ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = imgui.ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = imgui.ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = imgui.ImVec4(1.00, 0.60, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = imgui.ImVec4(1.00, 0.00, 0.00, 0.35)
            imgui.GetStyle().Colors[imgui.Col.DragDropTarget]         = imgui.ImVec4(1.00, 1.00, 0.00, 0.90)
            imgui.GetStyle().Colors[imgui.Col.NavHighlight]           = imgui.ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.NavWindowingHighlight]  = imgui.ImVec4(1.00, 1.00, 1.00, 0.70)
            imgui.GetStyle().Colors[imgui.Col.NavWindowingDimBg]      = imgui.ImVec4(0.80, 0.80, 0.80, 0.20)
            imgui.GetStyle().Colors[imgui.Col.ModalWindowDimBg]       = imgui.ImVec4(0.00, 0.00, 0.00, 0.70)
        end
    },
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(1.00, 1.00, 1.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
            imgui.GetStyle().Colors[imgui.Col.Tab]                    = ImVec4(0.98, 0.26, 0.26, 0.40)
            imgui.GetStyle().Colors[imgui.Col.TabHovered]             = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabActive]              = ImVec4(0.98, 0.06, 0.06, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocused]           = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TabUnfocusedActive]     = ImVec4(0.98, 0.26, 0.26, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
        end
    },
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.60, 0.60, 0.60, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.70, 0.70, 0.70, 0.40)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.15, 0.15, 0.15, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.19, 0.19, 0.19, 0.71)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.34, 0.34, 0.34, 0.79)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.00, 0.69, 0.33, 0.80)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.00, 0.74, 0.36, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.69, 0.33, 0.50)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.00, 0.80, 0.38, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.16, 0.16, 0.16, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.00, 0.82, 0.39, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.00, 1.00, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.00, 0.77, 0.37, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.00, 0.82, 0.39, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.00, 0.87, 0.42, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.00, 0.76, 0.37, 0.57)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.00, 0.88, 0.42, 0.89)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(1.00, 1.00, 1.00, 0.40)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(1.00, 1.00, 1.00, 0.60)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(1.00, 1.00, 1.00, 0.80)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.00, 0.76, 0.37, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.00, 0.86, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(0.00, 0.74, 0.36, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.00, 0.69, 0.33, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(0.00, 0.80, 0.38, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.00, 0.69, 0.33, 0.72)
        end
    },
    {
        change = function()
            local ImVec4 = imgui.ImVec4
            imgui.SwitchContext()
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)
            imgui.GetStyle().Colors[imgui.Col.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
            imgui.GetStyle().Colors[imgui.Col.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
            imgui.GetStyle().Colors[imgui.Col.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)local search = imgui.new.char[256]() -- ������ ����� ��� ������
            imgui.GetStyle().Colors[imgui.Col.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
            imgui.GetStyle().Colors[imgui.Col.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
            imgui.GetStyle().Colors[imgui.Col.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
            imgui.GetStyle().Colors[imgui.Col.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.Separator]              = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
            imgui.GetStyle().Colors[imgui.Col.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
            imgui.GetStyle().Colors[imgui.Col.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
            imgui.GetStyle().Colors[imgui.Col.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
            imgui.GetStyle().Colors[imgui.Col.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
            imgui.GetStyle().Colors[imgui.Col.WindowBg]               = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.ChildBg]                = ImVec4(0.10, 0.10, 0.10, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PopupBg]                = ImVec4(0.06, 0.53, 0.98, 0.70)
            imgui.GetStyle().Colors[imgui.Col.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
            imgui.GetStyle().Colors[imgui.Col.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
            imgui.GetStyle().Colors[imgui.Col.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
            imgui.GetStyle().Colors[imgui.Col.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
            imgui.GetStyle().Colors[imgui.Col.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
        end
    },
    {
    	change = function()
    		imgui.SwitchContext()
			local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	colors[clr.WindowBg]			  = ImVec4(0.14, 0.12, 0.16, 1.00);
	colors[clr.ChildBg]		 			= ImVec4(0.30, 0.20, 0.39, 0.10);
	colors[clr.PopupBg]			   = ImVec4(0.30, 0.20, 0.39, 0.80);
	colors[clr.Border]				= ImVec4(0.89, 0.85, 0.92, 0.30);
	colors[clr.BorderShadow]		  = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]			   = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]		= ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]		 = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]			   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBgCollapsed]	  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBgActive]		 = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.MenuBarBg]			 = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]		   = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]		 = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CheckMark]			 = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]			= ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]				= ImVec4(0.41, 0.19, 0.63, 0.44);
	colors[clr.ButtonHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]		  = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Separator]			  = colors[clr.Border]
	colors[clr.SeparatorHovered]	   = ImVec4(0.41, 0.19, 0.63, 0.78)
	colors[clr.SeparatorActive]		= ImVec4(0.41, 0.19, 0.63, 1.00)
	colors[clr.Header]				= ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]		 = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]		  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]			= ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]	 = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]	  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotLines]			 = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]	  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]		 = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]		= ImVec4(0.41, 0.19, 0.63, 0.43);
    	end
	}
    
}

imgui.OnFrame(
    function() return renderWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(1700, 700), imgui.Cond.FirstUseEver)
        imgui.Begin(thisScript().name .. " " .. thisScript().version .. " ", renderWindow)
        imgui.SetCursorPosY(50)
        imgui.Text(u8'MVD Helper 4.5 \n ��� Arizona Mobile', imgui.SetCursorPosX(50))
        if imgui.Button(settings .. u8' ���������', imgui.ImVec2(280, 50)) then 
            tab = 1
        elseif imgui.Button(list .. u8' ��������', imgui.ImVec2(280, 50)) then
            tab = 2

        elseif imgui.Button(radio .. u8' ����� ������������', imgui.ImVec2(280, 50)) then
            tab = 3

        elseif imgui.Button(userSecret .. u8' ��� ��', imgui.ImVec2(280, 50)) then
            tab = 4

        elseif imgui.Button(pen .. u8' ���������', imgui.ImVec2(280, 50)) then
            tab = 5

        elseif imgui.Button(sliders .. u8' �������������', imgui.ImVec2(280, 50)) then
            tab = 6
            
        elseif imgui.Button(info .. u8' ����', imgui.ImVec2(280, 50)) then
            tab = 7
        end
        imgui.SetCursorPos(imgui.ImVec2(300, 50))
        if imgui.BeginChild('Name##'..tab, imgui.ImVec2(), true) then -- [��� ������] ������ ����� � ������� �������� ����������
            -- == [��������] ���������� ������� == --
            if tab == 1 then -- ���� �������� tab == 1
                imgui.Text(u8'��� ���: '.. nickname)
                imgui.Text(u8'���� �����������: '.. mainIni.Info.org)
                imgui.Text(u8'���� ���������: '.. mainIni.Info.dl)
                if imgui.Combo(u8'����',colorListNumber,colorListBuffer, #colorList) then -- ������ ����� ��� ������ ����
                    themeta = theme[colorListNumber[0]+1].change() -- ������ �� ��������� ����
                    mainIni.theme.themeta = colorListNumber[0]
                    inicfg.save(mainIni, 'mvdhelper.ini')
                end
                if imgui.Button(u8'��') then
                    setUkWindow[0] = not setUkWindow[0]
                end
            elseif tab == 2 then -- ���� �������� tab == 2
                imgui.InputInt(u8 'ID ������ � ������� ������ �����������������', id, 10)
                if imgui.Button(u8 '�����������') then
                    lua_thread.create(function()
                        sampSendChat("������� ������� �����, � �" .. nickname .. "� �" ..  u8:decode(mainIni.Info.dl) .."�.")
                        wait(1500)
                        sampSendChat("/do ������������� � �����.")
                        wait(1500)
                        sampSendChat("/me ������� ��� ������������� �������� �� ������")
                        wait(1500)
                        sampSendChat("/do �" .. nickname .. "�.")
                        wait(1500)
                        sampSendChat("/do �" .. u8:decode(mainIni.Info.dl) .. "� " .. mainIni.Info.org .. ".")
                        wait(1500)
                        sampSendChat("���������� ���� ���������, � ������ �������. �� ������������, ��� ����� ���� ��������.")
                    end)
                end
                if imgui.Button(u8 '����� ������') then
                    lua_thread.create(function()
                        sampSendChat("/do ��� � ����� �������.")
                        wait(1500)
                        sampSendChat("/me ������ ����� ����� ��� �� �������")
                        wait(1500)
                        sampSendChat("/do ��� � ����� ����.")
                        wait(1500)
                        sampSendChat("/me ������� ��� � ����� � ���� ������ �������")
                        wait(1500)
                        sampSendChat("/me ������ ���� ����� " .. id[0] .. " �����������")
                        wait(1500)
                        sampSendChat("/do ������ ����������� ��������.")
                        wait(1500)
                        sampSendChat("/me ����������� � ������� �������� �����")
                        wait(1500)
                        sampSendChat("/do �� ���������� �������� �������.")
                        wait(1500)
                        sampSendChat("/pursuit " .. id[0])
                    end)
                end
                if imgui.Button(u8 '�����') then
                    lua_thread.create(function()
                        sampSendChat("/me ���� ����� �� ������� �������, ����� ������ �������� � ���� ������ ����� ���������")
                        wait(1500)
                        sampSendChat("/do ����� ��������� � ����� � �����.")
                        wait(1500)
                        sampSendChat("/me ��������� �������� ��������� ����������")
                        wait(1500)
                        sampSendChat("/me ��������� �������������� � ����������")
                        wait(1500)
                        sampSendChat("/me ��������� ������ � ���������")
                        wait(1500)
                        sampSendChat("/me ��������� ���� � �������")
                        wait(1500)
                        sampSendChat("/me ������� ����� � ������ �������")
                        wait(1500)
                        sampSendChat("/do ����� � ������� �������.")
                        wait(1500)
                        sampSendChat("/me ������� ����� ������������� ��������� � �������")
                        wait(1500)
                        sampSendChat("/me ������� ����������� � ���������� ������� ��� ������")
                        wait(1500)
                        sampSendChat("/arrest")
                        sampAddChatMessage("�������� �� ��������", -1)
                    end)
                end
                if imgui.Button(u8 '������ ���������') then
                    lua_thread.create(function()
                        sampSendChat("/do ��������� ����� �� �����.")
                        wait(1500)
                        sampSendChat("/me ���� � ��������� ���������")
                        wait(1500)
                        sampSendChat("/do ��������� � �����.")
                        wait(1500)
                        sampSendChat(
                            "/me ������ ��������� ����� ���, ����� ��������� �� �����������")
                        wait(1500)
                        sampSendChat("/do ���������� ������.")
                        wait(1500)
                        sampSendChat("/cuff " .. id[0])
                    end)
                end
                if imgui.Button(u8 '����� ���������') then
                    lua_thread.create(function()
                        sampSendChat("/do ���� �� ���������� � �������.")
                        wait(1500)
                        sampSendChat(
                            "/me ��������� ������ ���� ������ �� ������� ���� � ������ ���������")
                        wait(1500)
                        sampSendChat("/do ���������� ��������.")
                        wait(1500)
                        sampSendChat("/uncuff " .. id[0])
                    end)
                end
                if imgui.Button(u8 '����� �� �����') then
                    lua_thread.create(function()
                        sampSendChat("/me ������� ������ ���� ����������")
                        wait(1500)
                        sampSendChat("/me ����� ���������� �� �����")
                        wait(1500)
                        sampSendChat("/gotome " .. id[0])
                    end)
                end
                if imgui.Button(u8 '��������� ����� �� �����') then
                    lua_thread.create(function()
                        sampSendChat("/me �������� ������ ���� �����������")
                        wait(1500)
                        sampSendChat("/do ���������� ��������.")
                        wait(1500)
                        sampSendChat("/ungotome " .. id[0])
                    end)
                end
                if imgui.Button(u8 '� ������(������������� �� 3-� �����)') then
                    lua_thread.create(function()
                        sampSendChat("/do ����� � ������ �������.")
                        wait(1500)
                        sampSendChat("/me ������ ������ ����� � ������")
                        wait(1500)
                        sampSendChat("/me ������� ����������� � ������")
                        wait(1500)
                        sampSendChat("/me ������������ �����")
                        wait(1500)
                        sampSendChat("/do ����� �������������.")
                        wait(1500)
                        sampSendChat("/incar " .. id[0] .. "3")
                    end)
                end
                if imgui.Button(u8 '�����') then
                    lua_thread.create(function()
                        sampSendChat("/me ������ ������ � �������, ������� ������ ����� �������� � ������� �� �� ����")
                        wait(1500)
                        sampSendChat("/do �������� ������.")
                        wait(1500)
                        sampSendChat("/me �������� ������ �� ������� ����� ����")
                        wait(1500)
                        sampSendChat("/me ��������� �������/me �������� ������ �� �����")
                        wait(1500)
                        sampSendChat("/frisk " .. id[0])
                    end)
                end
                if imgui.Button(u8 '�������') then
                    lua_thread.create(function()
                        sampSendChat("/do ������� � ��������.")
                        wait(1500)
                        sampSendChat("/me ������ ������� � �������� ����� ���� ������� ���")
                        wait(1500)
                        sampSendChat("/m �������� ����, ������������ � ��������� ���������, ������� ���� �� ����.")
                    end)
                end
                if imgui.Button(u8 '�������� �� ����') then
                    lua_thread.create(function()
                        sampSendChat("/me ���� ������� � �������� ��������� ������ ������ � ����������")
                        wait(1500)
                        sampSendChat("/do ������ �������.")
                        wait(1500)
                        sampSendChat("/me ������� �� ����� �������� ������ ��� ����� ���� ����� ���������")
                        wait(1500)
                        sampSendChat("/pull " .. id[0])
                        wait(1500)
                        sampSendChat("/cuff " .. id[0])
                    end)
                end
                if imgui.Button(u8 '������ �������') then
                    windowTwo[0] = not windowTwo[0]
                end
                
            elseif tab == 3 then -- ���� �������� tab == 3
                imgui.InputText(u8 '������� � ������� ������ �����������������', otherorg, 255)
                otherdeporg = u8:decode(ffi.string(otherorg))
                imgui.Checkbox(u8 '�������� �����', zk)
                if imgui.Button(u8 '����� �� �����') then
                    if zk[0] then
                        sampSendChat("/d [" .. mainIni.Info.org .. "] z.k [" .. otherdeporg .. "] �� �����!")
                    else
                        sampSendChat("/d [" .. mainIni.Info.org .. "] to [" .. otherdeporg .. "] �� �����!")
                    end
                end
                if imgui.Button(u8 '�����') then
                    sampSendChat("/d [" .. mainIni.Info.org .. "] to [ALL] ��������, ����� �����.")
                end
            elseif tab == 4 then
                if imgui.CollapsingHeader(u8'������') then
                    if imgui.CollapsingHeader(u8'������') then
                        if imgui.Button(u8'����� � ����������') then
                            lua_thread.create(function()
                                sampSendChat("������������ ��������� ���������� ������ ������������!")
                                wait(1500)
                                sampSendChat("������ ����� ��������� ������ �� ���� ����� � ���������� ������������.")
                                wait(1500)
                                sampSendChat("��� ������ ������� �������� ����� ����������� � �������.")
                                wait(1500)
                                sampSendChat("���������� - ��� ��������������� ������� ������� ����, �������������� � ���������� ������������.")
                                wait(1500)
                                sampSendChat("� ���� �������, ����� - ��� ��� ���������� ���������, �������������� � ���������� ������������ ������������..")
                                wait(1500)
                                sampSendChat("..� ���������� �� ��������� ���� � �������� ������� �������� �� ��������.")
                                wait(1500)
                                sampSendChat("��� ��������� ����������� ���� �� ������ 48 ����� � ������� �� ����������.")
                                wait(1500)
                                sampSendChat("���� � ������� 48 ����� �� �� ���������� �������������� ����, �� ������� ��������� ����������.")
                                wait(1500)
                                sampSendChat("�������� ��������, ��������� ����� ������ �� ��� ��� �� ���������� ����������.")
                                wait(1500)
                                sampSendChat("�� ����� ���������� �� ������� �������� ��������� ����� �� ����� ���������� � ��������� � ������ ������ ����������.")
                                wait(1500)
                                sampSendChat("��� ��������� ���� �������� � 'ZIP-lock', ��� � ��������� ��� ���. �����, ��� ������ ���� ����������� �������� � ����� ��� ������ ����� ������������")
                                wait(1500)
                                sampSendChat("�� ���� ������ ������ �������� � �����. � ����-�� ������� �������?")
                            end)
                        end
                        if imgui.Button("�������������") then
                            lua_thread.create(function()
                                sampSendChat(" ��������� ���������� ������������ ������������!")
                                wait(1500)
                                sampSendChat(" ����������� ��� �� ������ � ������������") 
                                wait(1500)
                                sampSendChat(" ��� ������ ��������, ��� ����� ������������") 
                                wait(1500)
                                sampSendChat(" ������������ - ������� ���������� ������� �� ������ � ������� �� ������, ��������, ��������� � ���") 
                                wait(1500)
                                sampSendChat(" �� ���� ������� ���������� ������ ��������� ������� ����������") 
                                wait(1500)
                                sampSendChat(" ��� ����������  ������� �������, ������ ������") 
                                wait(1500)
                                sampSendChat(" �� ������ � ��������� ��������� � ���������� �� '��'") 
                                wait(1500)
                                sampSendChat(" �� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������") 
                                wait(1500)
                                sampSendChat(" ������ �������� ������� �� ��������!") 
                            end)
                        end
                        if imgui.Button(u8"�������������") then
                            lua_thread.create(function()
                                sampSendChat(" ��������� ���������� ������������ ������������!")
                                wait(1500)
                                sampSendChat(" ����������� ��� �� ������ � ������������") 
                                wait(1500)
                                sampSendChat(" ��� ������ ��������, ��� ����� ������������") 
                                wait(1500)
                                sampSendChat(" ������������ - ������� ���������� ������� �� ������ � ������� �� ������, ��������, ��������� � ���") 
                                wait(1500)
                                sampSendChat(" �� ���� ������� ���������� ������ ��������� ������� ����������") 
                                wait(1500)
                                sampSendChat(" ��� ����������  ������� �������, ������ ������") 
                                wait(1500)
                                sampSendChat(" �� ������ � ��������� ��������� � ���������� �� '��'") 
                                wait(1500)
                                sampSendChat(" �� ��������� ������� � �� ��������� ������������ ���� �� �������� ���������") 
                                wait(1500)
                                sampSendChat(" ������ �������� ������� �� ��������!") 
                            end)
                        end
                        if imgui.Button(u8"������� ��������� � �����.") then
                            lua_thread.create(function()
                                sampSendChat(" ��������� ���������� ������������ ������������!") 
                                wait(1500)
                                sampSendChat(" ����������� ��� �� ������ ������� ��������� � �����") 
                                wait(1500)
                                sampSendChat(" /b ��������� ��������� � ����� ���� (in ic, /r, /n, /fam, /sms,)") 
                                wait(1500)
                                sampSendChat(" ��������� ������������ ���������� ����������") 
                                wait(1500)
                                sampSendChat(" ��������� ��������� ������") 
                                wait(1500)
                                sampSendChat(" ��������� ��������� ����� ��� �������") 
                                wait(1500)
                                sampSendChat(" /b ��������� ������� � AFK ����� ��� �� 30 ������") 
                                wait(1500)
                                sampSendChat(" ��������� ���������� �������� ����� �� ����������� �� ���� ������� ������") 
                                wait(1500)
                                sampSendChat(" /b ��������� ����� �������� � ����� (/anim) ����������: ��. ������") 
                                wait(1500)
                                sampSendChat(" /b ��������� ������������� ������� [/smoke � �����]")
                            end)
                        end
                        if imgui.Button(u8'������') then
                            lua_thread.create(function()
                                sampSendChat(" ������������ ��������� ���������� ������������ �������, � ������� ������ �� ���� ������ ��������������.") 
                                wait(1500)
                                sampSendChat(" ��������� �� ������ ������� ����������������, �������������;") 
                                wait(1500)
                                sampSendChat(" ��������� �� ������ ��������� ��������� ����������, ��������, ��� ��������, ������, ���������, ����� ����������;") 
                                wait(1500)
                                sampSendChat(" ��������� �� ������ ��������, ��� �� ����� (������� ���������� �������, ��� �� ���-�� �������, �� �������� �� ��� ������);") 
                                wait(1500)
                                sampSendChat(" ���� ������������� ��� �������� �� ������, ���������� ������ �� ��� �� ������� ������;") 
                                wait(1500)
                                sampSendChat(" � ����� ������� ����������� ������� ������� ����������.")
                                wait(1500)
                                sampSendChat(" ��� ��������� ��������, ���������� ��������� ����� �������� ���� �������������� (���������� ��� �������, �� ��� �� ����� �������);") 
                                wait(1500)
                                sampSendChat(" ��� ��������� ��������, �� ����� �������� � ���������� � ���������� �������� (���������, ���������� ���������, ��������� ���� ��� ����, ������������ ���������, ����������, ������������� �������� ���������� � ���� ��������).")
                                wait(1500)
                                sampSendChat(" �� ���� ������ ������� � �����, ���� � ����-�� ���� �������, ������ �� ����� �� ������ ������ (���� ������ ������, �� ����� �������� �� ����)") 
                            end)
                        end
                        if imgui.Button(u8"������� ��������� �� � �� ����� ������ �� �����������.") then
                            lua_thread.create(function()
                                sampSendChat(" ������ ����, ������ � ������� ��� ������ �� ���� ������� ��������� �� � �� ����� ������ �� �����������") 
                                wait(1500)
                                sampSendChat(" � �����, ����� �������, �� ������ ����������� ������� ��, ��� ������� ��� ������") 
                                wait(1500)
                                sampSendChat(" ������������ �������, ������� ���������, ��� ��� ���� � ��� ������� ���������") 
                                wait(1500)
                                sampSendChat(" �� ���� � ������������, ��������� � �������� ������, ��� ������� �� �����") 
                                wait(1500)
                                sampSendChat(" ������� �� ���������� �������, ����� ��������� ��������� ���, ����� ���������� ��� ��������� ���� � ����������� ������ �������") 
                                wait(1500)
                                sampSendChat(" ����� ������ ���������� �������� ��, ��� ������, ����� �������, ��������� ��������� � ������, � ��� ����� �� ��������") 
                                wait(1500)
                                sampSendChat(" ��������� ������� ������ ������ ������������, ������ �� ����������") 
                                wait(1500)
                                sampSendChat(" ��� �� ������� �� �����, �� �� ���������� ������ �� ����, ���� �����") 
                                wait(1500)
                                sampSendChat(" ��������� ����� �� ������������ ����������� ������ � ��� ������, ���� �� ��������� �� ��� �������, ����� ��������� ��� ��� �������� ��������� �����") 
                                wait(1500)
                                sampSendChat(" ��� ������ ����. �������� �������������, ��� ��������� ���������") 
                                wait(1500)
                                sampSendChat(" �� ���� ������ ��������, ���� �������") 
                            end)
                        end
                        if imgui.Button(u8"������� �������.") then
                            lua_thread.create(function()
                                sampSendChat("������� ������� � ����������� ���������� � ���") 
                                wait(1500)
                                sampSendChat("�������� �������� �� ����� ���������� ������������� ������ ���� ��������� � ����� ������.") 
                                wait(1500)
                                sampSendChat("��� ������� ������������ ������������, � ������ � ��� ��� �������� ���.") 
                                wait(1500)
                                sampSendChat("��� ����� ���������, ����� �� ������ �� ������������ ���������.") 
                                wait(1500)
                                sampSendChat("������� ���� �����:") 
                                wait(1500)
                                sampSendChat("- �� ������ ����� ������� ��������.") 
                                wait(1500)
                                sampSendChat("- ��, ��� �� �������, ����� � ����� ������������ ������ ��� � ����.") 
                                wait(1500)
                                sampSendChat("- ��� ������� ����� �������������� ��� �������.") 
                                wait(1500)
                                sampSendChat("- ���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ������������.") 
                                wait(1500)
                                sampSendChat("- �� ��������� ���� �����?")
                            end)
                        end
                        if imgui.Button(u8"������ ������.") then
                            lua_thread.create(function()
                                sampSendChat("��� ������ ����������� ��� � ������������") 
                                wait(1500)
                                sampSendChat("����, � ������������� ������������, �� ���������� ���������� ����� ����� ������") 
                                wait(1500)
                                sampSendChat("���� ������� ��������� ���������� ������� ����� ������ ������ � ���������� ���� ������") 
                                wait(1500)
                                sampSendChat("���� � ���� ����, � ���� �� ��������, �� ������ ������� ������ ���� �������� �� ����������, ��������� ����� ��������� � ������� ������ ������") 
                                wait(1500)
                                sampSendChat("���� ������� ��� �������� ��� ����� ... ") 
                                wait(1500)
                                sampSendChat(" ... ������� �� ����� ������ ������ ���� � �����, ����� �������� ���� ������� ... ") 
                                wait(1500)
                                sampSendChat(" ... � �������� ������ �� ������� ����� ���� �������������, � ���� ������, �� ������ ��������") 
                                wait(1500)
                                sampSendChat("�� ���� ������ ��������. � ����-�� ���� ������� �� ������ ������?") wait(1500)
                            end)
                        end
                    end
                end
                if rang_n > 8 then
                    if imgui.Button(u8'������ ������/�����������') then
                        leaderPanel[0] = not leaderPanel[0]
                    end
                end
            elseif tab == 5 then 
                if imgui.CollapsingHeader(u8 '��') then
                    for i = 1, #tableUk["Text"] do
                        imgui.Text(u8(tableUk["Text"][i] .. ' ������� �������: ' .. tableUk["Text"][i]))
                    end
                end
                if imgui.CollapsingHeader(u8 '���-����') then
                    imgui.Text(u8"10-1 - ������� ���� �������� �� ��������� (�������� ������� � ���).")
                    imgui.Text(u8"10-2 - ����� � �������.")
                    imgui.Text(u8"10-2R: �������� �������.")
                    imgui.Text(u8"10-3 - ������������� (�������� ������������).")
                    imgui.Text(u8"10-4 - �������.")
                    imgui.Text(u8"10-5 - ���������.")
                    imgui.Text(u8"10-6 - �� �������/�������/���.")
                    imgui.Text(u8"10-7 - ��������.")
                    imgui.Text(u8"10-8 - ����������.")
                    imgui.Text(u8"10-14 - ������ ��������������� (�������� ������� � ���� ���������������).")
                    imgui.Text(u8"10-15 - ������������� ���������� (�������� ���������� ������������� � �������).")
                    imgui.Text(u8"10-18 - ��������� ��������� �������������� ������.")
                    imgui.Text(u8"10-20 - �������.")
                    imgui.Text(u8"10-21 - �������� ��������.")
                    imgui.Text(u8"10-22 - ����������� � ....")
                    imgui.Text(u8"10-27 - ����� ���������� ������� (�������� ������ ���������� � �����).")
                    imgui.Text(u8"10-30 - �������-������������ ������������.")
                    imgui.Text(u8"10-40 - ������� ��������� ����� (����� 4).")
                    imgui.Text(u8"10-41 - ����������� ����������.")
                    imgui.Text(u8"10-46 - ������� �����.")
                    imgui.Text(u8"10-55 - ������� ������� ����.")
                    imgui.Text(u8"10-57 VICTOR - ������ �� ����������� (�������� ������ ����, ���� ����, ���������� ������� ������, �������, ����������� ��������).")
                    imgui.Text(u8"10-57 FOXTROT - ����� ������ (�������� ��������� ��������������, ������ (��� ������� ���������� � ����������), �������, ����������� ��������).")
                    imgui.Text(u8"10-60 - ���������� �� ���������� (�������� ������ ����, ����, ���������� ������� ������).")
                    imgui.Text(u8"10-61 - ���������� � ����� ������������� (�������� ����, ������).")
                    imgui.Text(u8"10-66 - ������� ���� ���������� �����.")
                    imgui.Text(u8"10-70 - ������ ��������� (� ������� �� 10-18 ���������� ������� ���������� ������ � ���).")
                    imgui.Text(u8"10-71 - ������ ����������� ���������.")
                    imgui.Text(u8"10-99 - �������� �������������.")
                    imgui.Text(u8"10-100 - ��������� ���������� ")
                end
                if imgui.CollapsingHeader(u8 '���������� ��������') then
                    imgui.CenterText('���������� ���������� �����������')
                    imgui.Text(u8"* ADAM (A) - ���������� ������� � ����� ��������� �� ������")
                    imgui.Text(u8"* LINCOLN (L) - ���������� ������� � ����� �������� �� ������")
                    imgui.Text(u8"* LINCOLN 10/20/30/40/50/60 - ���������� ������������")
                    imgui.CenterText('���������� ������ ������������ �������')
                    imgui.Text(u8"* MARY (M) - ���������� �������������� �������")
                    imgui.Text(u8"* AIR (AIR) - ���������� ����� Air Support Division")
                    imgui.Text(u8"* AIR-100 - ���������� ������������ Air Support Division")
                    imgui.Text(u8"* AIR-10 - ���������� ������������� ����� Air Support Division")
                    imgui.Text(u8"* EDWARD (E) - ���������� Tow Unit")  
                end

            elseif tab == 6 then 
                imgui.Checkbox(u8 '���� ��������� ������', autogun)
                if autogun[0] then
                    lua_thread.create(function()
                        while true do
                            wait(0)
                            if lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
                                local gun = getCurrentCharWeapon(PLAYER_PED)
                                if gun == 3 then
                                    sampSendChat("/me ������ ������� � �������� ���������")
                                elseif gun == 16 then
                                    sampSendChat("/me ���� � ����� �������")
                                elseif gun == 17 then
                                    sampSendChat("/me ���� ������� ������������� ���� � �����")
                                elseif gun == 23 then
                                    sampSendChat("/me ������ ������ � ������, ����� ��������������")
                                elseif gun == 22 then
                                    sampSendChat("/me ������ �������� Colt-45, ���� ��������������")
                                elseif gun == 24 then
                                    sampSendChat("/me ������ Desert Eagle � ������, ����� ��������������")
                                elseif gun == 25 then
                                    sampSendChat("/me ������ ����� �� �����, ���� �������� � ����� ��������������")
                                elseif gun == 26 then
                                    sampSendChat("/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ ������")
                                elseif gun == 27 then
                                    sampSendChat("/me ������ �������� Spas, ���� ��������������")
                                elseif gun == 28 then
                                    sampSendChat("/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ ���")
                                elseif gun == 29 then
                                    sampSendChat("/me ������ ����� �� �����, ���� ��5 � ����� ��������������")
                                elseif gun == 30 then
                                    sampSendChat("/me ������ ������� AK-47 �� �����")
                                elseif gun == 31 then
                                    sampSendChat("/me ������ ������� �4 �� �����")
                                elseif gun == 32 then
                                    sampSendChat("/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ TEC-9")
                                elseif gun == 33 then
                                    sampSendChat("/me ������ �������� ��� ������� �� ������� �����")
                                elseif gun == 34 then
                                    sampSendChat("/me ������ ����������� �������� � ������� �����")
                                elseif gun == 43 then
                                    sampSendChat("/me ������ ���������� �� �������")
                                elseif gun == 0 then
                                    sampSendChat("/me �������� ��������������, ����� ������")
                                end
                                lastgun = gun
                            end
                        end
                    end)
                end
                imgui.Checkbox(u8'����-������ ������� ������ 10 �����(�������� ��� ������)/]. ����� 30 �����', patrul)
                imgui.InputText(u8'��� ������ ���������(�� ���������)', partner, 255)
                partnerNick = u8:decode(ffi.string(partner))
                imgui.Checkbox(u8'�������� ��� ��������', pozivn)
                imgui.InputText(u8'��� ��������', poziv, 255)
                pozivnoi = u8:decode(ffi.string(poziv))
                if patrul[0] and pozivn[0] then
                    poziv[0] = false
                    patrul[0] = false
                    lua_thread.create(function()
                        sampSendChat("/r " .. nickname .. " [" .. pozivnoi .. "]. ������ � �������. �������� - " .. partnerNick .. ". ��������.")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. " [" .. pozivnoi .. "]. ��������� ������� � " .. partnerNick .. ". ��������� ����������. ��������")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. " [" .. pozivnoi .. "]. ��������� ������� � " .. partnerNick .. ". ��������� ����������. ��������")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. " [" .. pozivnoi .. "]. ���������� ������� � " .. partnerNick .. ".")
                    end)
                elseif patrul[0] then
                    lua_thread.create(function()
                        patrul[0] = false
                        sampSendChat("/r " .. nickname .. ". ������ � �������. �������� - " .. partnerNick .. ". ��������.")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. ". ��������� ������� � " .. partnerNick .. ". ��������� ����������. ��������")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. ". ��������� ������� � " .. partnerNick .. ". ��������� ����������. ��������")
                        wait(599999)
                        sampSendChat("/r " .. nickname .. ". ���������� ������� � " .. partnerNick .. ".")
                    end)

                end
                imgui.Checkbox(u8'���� ������', AutoAccentBool)
                if AutoAccentBool[0] then
                    AutoAccentCheck = true
                    mainIni.Accent.autoAccent = true
                    inicfg.save(mainIni, "mvdhelper.ini")
                else 
                    mainIni.Accent.autoAccent = false
                    inicfg.save(mainIni, "mvdhelper.ini")
                end 
                imgui.InputText(u8'������', AutoAccentInput, 255)
                AutoAccentText = u8:decode(ffi.string(AutoAccentInput))
                mainIni.Accent.accent = AutoAccentText
                inicfg.save(mainIni, "mvdhelper.ini")
                if imgui.Button(u8'��������������� ������') then
                	suppWindow[0] = not suppWindow [0]
                	
				end
            elseif tab == 7 then 
                imgui.Text(u8'������: 4.6')
                imgui.Text(u8'�����������: @Sashe4ka_ReZoN')
                imgui.Text(u8'�� �����: @lua_arz')
                imgui.Text(u8'����������: https://qiwi.com/n/SASHE4KAREZON')
                imgui.Text(u8'���������� 4.1 - ��������� ����������, ���������� ������� "����" � "��� ��". �������� ���� ������. ���� �����.')
                imgui.Text(u8'���������� 4.2 - ���� ���� �����������. ������ � ������� �� � ������ �����(������ ������ ����� �������� �� 9 �����).')
                imgui.Text(u8'���������� 4.3 - ���� �����������. ���������� ��� � ������ �����������')
                imgui.Text(u8'���������� 4.4 - �������� ������,������ ������(� ����������)')
                imgui.Text(u8'���������� 4.5 - ������ ����� ��������� ���� ��. ��������� ���������� ����. �������� /mvds')
                imgui.Text(u8'���������� 4.6 - ���� �����')
            end
            -- == [��������] ���������� ������� ����������� == --
            imgui.EndChild()
            imgui.End()
        end
    end
)

function main()
    if statsCheck == false then
    end
    sampRegisterChatCommand('mvd', openwindow)
    sampRegisterChatCommand("showpass", cmd_showpass)
    sampRegisterChatCommand("showlic", cmd_showlic)
    sampRegisterChatCommand("showskill", cmd_showskill)
    sampRegisterChatCommand("showmc", cmd_showmc)
    sampRegisterChatCommand("pull", cmd_pull)
    sampRegisterChatCommand("invite", cmd_invite)
    sampRegisterChatCommand("uninvite", cmd_uninvite)
    sampRegisterChatCommand("cuff",cmd_cuff)
    sampRegisterChatCommand("uncuff",cmd_uncuff)
    sampRegisterChatCommand("gotome",cmd_gotome)
    sampRegisterChatCommand("ungotome",cmd_ungotome)
    sampRegisterChatCommand("frisk", cmd_frisk)
    sampRegisterChatCommand("showbadge", cmd_showbadge)
    sampRegisterChatCommand("tencodes",cmd_tencodes)
    sampRegisterChatCommand("marks",cmd_marks)
    sampRegisterChatCommand("sitcodes",cmd_sitcodes)
    sampRegisterChatCommand("mask", cmd_mask)
    sampRegisterChatCommand("arm", cmd_arm)
    sampRegisterChatCommand("drug", cmd_drug) 
    sampRegisterChatCommand("asu", cmd_asu) 
    sampRegisterChatCommand("arrest", cmd_arrest) 
    sampRegisterChatCommand("stop", cmd_stop) 
    sampRegisterChatCommand("giverank",cmd_giverank) 
    sampRegisterChatCommand("unmask",cmd_unmask) 
    sampRegisterChatCommand("miranda",cmd_miranda) 
    sampRegisterChatCommand("bodyon",cmd_bodyon) 
    sampRegisterChatCommand("bodyoff",cmd_bodyoff) 
    sampRegisterChatCommand("ticket",cmd_ticket)
    sampRegisterChatCommand("pursuit",cmd_pursuit)
    sampRegisterChatCommand("drugtestno",cmd_drugtestno)
    sampRegisterChatCommand("drugtestyes",cmd_drugtestyes)
    sampRegisterChatCommand("vzatka",cmd_vzatka)
    sampRegisterChatCommand("bomb",cmd_bomb)
    sampRegisterChatCommand("probiv",cmd_probiv)
    sampRegisterChatCommand("dismiss",cmd_dismiss)
    sampRegisterChatCommand("demoute",cmd_demoute)
    sampRegisterChatCommand("cure",cmd_cure)
    sampRegisterChatCommand("zsu",cmd_zsu)
    sampRegisterChatCommand("find",cmd_find)
    sampRegisterChatCommand("incar",cmd_incar)
    sampRegisterChatCommand("eject",cmd_eject)
    sampRegisterChatCommand("pog",cmd_pog)
    sampRegisterChatCommand("pas",cmd_pas)
    sampRegisterChatCommand("clear",cmd_clear)
    sampRegisterChatCommand("take",cmd_take)
    sampRegisterChatCommand("time",cmd_time)
    sampRegisterChatCommand("gcuff",cmd_gcuff)
    sampRegisterChatCommand("fbi.pravda", cmd_pravda_fbi)
    sampRegisterChatCommand("fbi.secret", cmd_secret_fbi)
    sampRegisterChatCommand("finger.p", cmd_finger_person)
    sampRegisterChatCommand("podmoga", cmd_warn)
    sampRegisterChatCommand("mvds",cmd_mvds)
    sampRegisterChatCommand("stop", cmd_stop)
    sampRegisterChatCommand("grim", cmd_grim)
    sampRegisterChatCommand("eks", cmd_eks)
end

function sampev.onSendSpawn()
	if spawn and isMonetLoader() then
		spawn = false
		sampSendChat('/stats')
        sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}������ ������� ����������", 0x8B00FF)
        sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}������:t.me/Sashe4ka_ReZoN",0x8B00FF)
        sampAddChatMessage("[Sashe4ka Police Helper]: {FFFFFF}����� ���������� ��������,������� /mvd and /mvds ",0x8B00FF)
        nickname = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
    end
end

function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if dialogId == 235 and title == "{BFBBBA}�������� ����������" then
        statsCheck = true
        if string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "RCPD" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "RCSD"  or string.match(text, "�����������: {B83434}%[(%D+)%]") == "��������� �������" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "���" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "FBI" then
            org = string.match(text, "�����������: {B83434}%[(%D+)%]")
            if org ~= '�� �������' then dol = string.match(text, "���������: {B83434}(%D+)%(%d+%)") end
            dl = u8(dol)
            if org == '������� ��' then org_g = u8'LVPD'; ccity = u8'���-��������'; org_tag = 'LVPD' end
            if org == '������� ��' then org_g = u8'LSPD'; ccity = u8'���-������'; org_tag = 'LSPD' end
            if org == '������� ��' then org_g = u8'SFPD'; ccity = u8'���-������'; org_tag = 'SFPD' end
            if org == '���' then org_g = u8'FBI'; ccity = u8'���-������'; org_tag = 'FBI' end
            if org == 'FBI' then org_g = u8'FBI'; ccity = u8'���-������'; org_tag = 'FBI' end
            if org == 'RCSD' or org == '��������� �������' then org_g = u8'RCSD'; ccity = u8'Red Country'; org_tag = 'RCSD' end
            if org == 'RCPD' or org == '��������� �������' then org_g = u8'RCPD'; ccity = u8'Red Country'; org_tag = 'RCPD' end
            if org == '[�� �������]' then
                org = '�� �� �������� � ��'
                org_g = '�� �� �������� � ��'
                ccity = '�� �� �������� � ��'
                org_tag = '�� �� �������� � ��'
                dol = '�� �� �������� � ��'
                dl = '�� �� �������� � ��'
            else
                rang_n = tonumber(string.match(text, "���������: {B83434}%D+%((%d+)%)"))   
            end      
            mainIni.Info.org = org_g
            mainIni.Info.rang_n = rang_n
            mainIni.Info.dl = dl
            inicfg.save(mainIni,'mvdhelper.ini')
        end
    end
end

function openwindow()
    renderWindow[0] = not renderWindow[0]
end

function decor()
    -- == ����� ����� == --
    imgui.SwitchContext()
    local ImVec4 = imgui.ImVec4
    imgui.GetStyle().WindowPadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().FramePadding = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemSpacing = imgui.ImVec2(5, 5)
    imgui.GetStyle().ItemInnerSpacing = imgui.ImVec2(2, 2)
    imgui.GetStyle().TouchExtraPadding = imgui.ImVec2(0, 0)
    imgui.GetStyle().IndentSpacing = 0
    imgui.GetStyle().ScrollbarSize = 10
    imgui.GetStyle().GrabMinSize = 10
    imgui.GetStyle().WindowBorderSize = 1
    imgui.GetStyle().ChildBorderSize = 1
    imgui.GetStyle().PopupBorderSize = 1
    imgui.GetStyle().FrameBorderSize = 1
    imgui.GetStyle().TabBorderSize = 1
    imgui.GetStyle().WindowRounding = 8
    imgui.GetStyle().ChildRounding = 8
    imgui.GetStyle().FrameRounding = 8
    imgui.GetStyle().PopupRounding = 8
    imgui.GetStyle().ScrollbarRounding = 8
    imgui.GetStyle().GrabRounding = 8
    imgui.GetStyle().TabRounding = 8
end

imgui.OnInitialize(function()
    decor() -- ��������� ����� �����
    theme[colorListNumber[0]+1].change() -- ��������� �������� �����
    imgui.GetIO().IniFilename = nil
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), 20, config, iconRanges) -- solid - ��� ������, ��� �� ���� thin, regular, light � duotone
end)

function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowWidth()/2-imgui.CalcTextSize(u8(text)).x/2)
    imgui.Text(u8(text))
end

function cmd_showpass(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/showpass [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ ����� � �����������")
            wait(1500)
            sampSendChat("/do ����� � ����.")
            wait(1500)
            sampSendChat("/me ������ �������")
            wait(1500)
            sampSendChat("/do ������� � ����.")
            wait(1500)
            sampSendChat("/me ������� ������� �������� �� ������")
            wait(1500)
            sampSendChat("/showpass " .. id .. " ")
        end)
    end
end

function cmd_showbadge(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/showbadge [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me �� ����������� ������� ������ �������������")  
            wait(1500) 
            sampSendChat("/me ������ �������� � ���������� ����, ������� ���������� �������� ��������") 
            wait(1500) 
            sampSendChat("/do ���� ��������� ������ ������������� � �������.")
            wait(1500)
            sampSendChat("/me ������ �������� , ����� ��� ������� � ������")
            wait(1500)
            sampSendChat ("/showbadge "..id.." ")
        end)
    end
end

function cmd_showlic(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/showlic [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ ����� � �����������")
            wait(1500)
            sampSendChat("/do ����� � ����.")
            wait(1500)
            sampSendChat("/me ������ ��������")
            wait(1500)
            sampSendChat("/do �������� � ����.")
            wait(1500)
            sampSendChat("/me ������� �������� �������� �� ������")
            wait(1500)
            sampSendChat("/showlic " .. id .. " ")
        end)
    end
end

function cmd_mvds(id)
        lua_thread.create(function()
        sampShowDialog(1,"������� MVD HELPER 4.5", "/showlic -  ���������� ���� ��������\n/showpass - ���������� ��� �������\n/showmc - ���������� ���� ���. �����\n/showskill - ���������� ���� ������ ������\n/showbadge - �������� ���� ������������� ��������\n/pull - ���������� �������� �� ���� � ��������\n/uninvite - ������� �������� �� �����������\n/invite - ������� �������� � �����������\n/cuff - ������ ���������\n/uncuff - ����� ���������\n/frisk - �������� ��������\n/mask - ������ �����\n/arm - �����/������ ����������\n/asu - ������ ������\n/drug - ������������ ���������\n/arrest - ����� ��� ������ ��������\n/stop - 10-55 �������-����\n/giverank - ������ ���� ��������\n/unmask - ����� ����� � �����������\n/miranda - �������� �����\n/bodyon - �������� ����-������\n/bodyoff - ��������� ����-������\n/ticket - �������� �����\n/pursuit - ����� ������������� �� �������\n/drugtestno - ���� �� ��������� ( ������������� )\n/drugtestyes - ���� �� ��������� ( ������������� )\n/vzatka - �� ������\n/bomb - �������������� �����\n/dismiss - ������� �������� �� ����������� ( 6 ��� )\n/demoute - ������� �������� �� ����������� ( 9 ��� )\n/cure - �������� ����� �������� ��������\n/find - ��������� ������ �����������\n/incar - �������� ����������� � ������\n/tencodes - ��� ����\n/marks - ����� ����\n/sitcodes - ������������ ����\n/zsu - ������ � ������\n/mask - ������ �����\n/take - ������� ���������� ����\n/gcuff - cuff + gotome\n/fbi.secret - �������� � ������������� ������������ ���\n/fbi.pravda - �������� � ����������� ���� �� �������\n/finger.p - ������ ���������� ������� ��������\n/podmoga - ����� ������� � /r\n/grim - ��������� �����\n/eks - ���������� ������\n�����:t.me/Sashe4ka_ReZoN", "�������", "Exit", 0)
        end)
        end
        

function cmd_showskill(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/showskill [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ ����� � �����������")
            wait(1500)
            sampSendChat("/do ����� � ����.")
            wait(1500)
            sampSendChat("/me ������ ������� � ����")
            wait(1500)
            sampSendChat("/do ������� � ����.")
            wait(1500)
            sampSendChat("/me ������� ������� �������� �� ������")
            wait(1500)
            sampSendChat("/showskill " .. id .. " ")
        end)
    end
end

function cmd_showmc(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/showmc [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ ����� � �����������")
            wait(1500)
            sampSendChat("/do ����� � ����.")
            wait(1500)
            sampSendChat("/me ������ ���. �����")
            wait(1500)
            sampSendChat("/do ���. ����� � ����.")
            wait(1500)
            sampSendChat("/me ������� ���. ����� ����� ����� �� ������")
            wait(1500)
            sampSendChat("/showmc " .. id .. " ")
        end)
    end
end

function cmd_pull(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/pull [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/pull " .. id .. " ")
            wait(1500)
            sampSendChat("/me ������� ������� � �����, ������ ������� �� � ����� ���� �� ���� ��������")
            wait(1500)
            sampSendChat("/me ������ ������, ������ ����� ������� � ������� �������� �� ������ ...")
            wait(1500)
            sampSendChat("/me ... ����� ����, �������� �������������� �� ������� � ������� ��� ����")

        end)
    end
end

function cmd_invite(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/invite [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/do ��� ������� ��������� ������.")
            wait(1500)
            sampSendChat("/do ����� � �������...")
            wait(1500)
            sampSendChat("/me ����� ���� � ������, ����� ���� ���� ����� � ������� � ����")
            wait(1500)
            sampSendChat("/me ������� ����� � �������")
            wait(1500)
            sampSendChat("/todo ����� �������������*�������� ������� �� ����� ����������")
            wait(1500)
            sampSendChat("/invite " .. id .. " ")
        end)
    end
end

function cmd_uninvite(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/uninvite [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat ("/do �� ����� ������������ ������� ������ � ����������� Police.")
            wait(1500)
            sampSendChat ("/do �� ����� ���������� ���������� ��� � ����� ������")
            wait(1500)
            sampSendChat ("/me ��������� ������ ����, ��������� ���� ��� � �����")
            wait(1500)
            sampSendChat ("/do ������� ������ ��� � �����.")
            wait(1500)
            sampSendChat("/me ��������� ������ ����, ����� �� ������ ��������� ���")
            wait(1500)
            sampSendChat ("/me ����� ���� ������ �����������")
            wait(1500)
            sampSendChat ("/me ����� �� ������ ������� ����������")
            wait(1500)
            sampSendChat ("/do ���: ��������� ���������� � ����������.")
            wait(1500)
            sampSendChat ("/me ������ ��������� ���, �������� ���������� � ����������, ����� ���� ����� ������ ������� ����������")
            wait(1500)
            sampSendChat ("/do ���: ��������� ������� ������ �� ���� ������.")
            wait(1500)
            sampSendChat("/uninvite " .. id .. " ")
        end)
    end
end

function cmd_cuff(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/cuff [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/do ��������� ����� �� �����.")
            wait(1500)
            sampSendChat("/me ���� � ��������� ���������")
            wait(1500)
            sampSendChat("/do ��������� � �����.")
            wait(1500)
            sampSendChat("/me ������ ��������� ����� ���, ����� ��������� �� �����������")
            wait(1500)
            sampSendChat("/do ���������� ������.")
            wait(1500)
            sampSendChat("/cuff "..id.." ")
         end)
      end
   end

function cmd_uncuff(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/uncuff [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/do ���� �� ���������� � �������.")
            wait(1500)
            sampSendChat("/me ��������� ������ ���� ������ �� ������� ���� � ������ ���������")
            wait(1500)
            sampSendChat("/do ���������� ��������.")
            wait(1500)
            sampSendChat("/uncuff "..id.." ")
        end)
     end
  end

function cmd_gotome(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/gotome [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������� ������ ���� ����������")
            wait(1500)
            sampSendChat("/me ����� ���������� �� �����")
            wait(1500)
            sampSendChat("/gotome "..id.." ")
        end)
     end
  end

function cmd_ungotome(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/ungotome [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me �������� ������ ���� �����������")
            wait(1500)
            sampSendChat("/do ���������� ��������.")
            wait(1500)
            sampSendChat("/ungotome "..id.." ")
        end)
     end
  end

function cmd_gcuff(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/gcuff [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/do ��������� ����� �� �����.") 
            wait(1500) 
            sampSendChat("/me ���� � ��������� ���������") 
            wait(1500) 
            sampSendChat("/do ��������� � �����.") 
            wait(1500) 
            sampSendChat("/me ������ ��������� ����� ���, ����� ��������� �� �����������") 
            wait(1500) 
            sampSendChat("/do ���������� ������.") 
            wait(1500) 
            sampSendChat("/cuff "..id.." ")
            wait(1500)
            sampSendChat("/me ������� ������ ���� ����������") 
            wait(1500) 
            sampSendChat("/me ����� ���������� �� �����") 
            wait(1500) 
            sampSendChat("/gotome "..id.." ")
        end)
     end
  end

function cmd_frisk(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/frisk [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ����� ��������� ��������, ����� ����������� ���������� �� ����� ���� ...")
            wait(1500)
            sampSendChat("/do �������� ������.")
            wait(1500)
            sampSendChat("/me �������� ������ �� ������� ����� ����")
            wait(1500)
            sampSendChat("/me ... �� ��� ����� ��������� ���������� ����������, ���������� �� ��� ��������")
            wait(1500)
            sampSendChat("/frisk " .. id .. " ")
        end)
    end
end


function cmd_pursuit(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/pursuit [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/do ��� � ����� �������.")
            wait(1500)
            sampSendChat("/me ������ ��� �� ������ �������")
            wait(1500)
            sampSendChat("/me ������� ��� � ����� � ���� ������ �������")
            wait(1500)
            sampSendChat("/me ������ ���� � ������� �����������")
            wait(1500)
            sampSendChat("/do ������ ����������� ��������.")
            wait(1500)
            sampSendChat("/me ����������� � ������� �������� �����")
            wait(1500)
            sampSendChat("/pursuit " .. id .. " ")
        end)
    end
end

function cmd_arm(id)

        lua_thread.create(function()
            sampSendChat("/armour")
            wait(1500)
            sampSendChat("/me ������ �������� � �����������")
        end)
    end


function cmd_mask()
lua_thread.create(function()
            sampSendChat("/mask")
            wait(1500)
            sampSendChat("/me ����� �� ���� ��������, ����� ��������� �� ����")
        end)
    end

function cmd_drug(id)
    if id == "" then
         sampAddChatMessage("����� ���-�� ����� [1-3]: {FFFFFF}/usedrugs [1-3].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ �� ������� �������� �����")
            wait(1500)
            sampSendChat("/do ���� ������, ���� ��.")
            sampSendChat("/usedrugs "..id.." ")
        end)
    end
   end

function cmd_asu(arg)
lua_thread.create(function()
    local arg1, arg2, arg3 = arg:match('(.+) (.+) (.+)')		
    if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then
        sampSendChat('/su '..arg1..' '..arg2..' '..arg3..'')
		wait(1000)
		sampSendChat("/me ���� ����� � �������� ��������� � ������� ���������� � ����������")
   wait(1000)
   sampSendChat("/do ������ ��������� ������� ����� �� ����������.")
   wait(1000)
   sampSendChat("/todo 10-4, ����� �����.*������� ����� �� ������� ���������")
    else
		sampAddChatMessage("����� ���� ������: {FFFFFF}/asu [ID] [���-�� �������] [�������].", 0x318CE7FF -1)
		end
	end)
end


function cmd_arrest(id)
    if id == "" then
         sampAddChatMessage("����� ���� ������:: {FFFFFF}/arrest [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ����� �� �������, ������� ���������� � ����������� ����������� ...")
            wait(1500)
            sampSendChat("/me �������� �������� ��� �������������")
            wait(1500)
            sampSendChat("/do �����������: �������, �������� ���� ��������.")
            wait(1500)
            sampSendChat("/do �� ������� ������� 2 �������, ����� �������� �����������.")
            sampSendChat("/arrest "..id.." ")
        end)
    end
   end

function cmd_giverank(arg)
    lua_thread.create(function()
        local arg1, arg2 = arg:match('(.+) (.+)')  
        if arg1 ~= nil and arg2 ~= nil then
            sampSendChat('/giverank '..arg1..' '..arg2..'')
            wait(1500)
            sampSendChat("/do � ����� ��������� ����� � ��������.") 
            wait(1500) 
            sampSendChat("/do ����� ������� � � ��� ��������� ����� � ��������� ������������.") 
            wait(1500) 
            sampSendChat("/me ������ ��������� ���� ������� �����, � ������� ��� ��������") 
            wait(1500) 
            sampSendChat("/do ����� ��������� � ������� �������.") 
            wait(1500) 
            sampSendChat("/me ������� ��������� ���� ������� ����� � ����� ������� ��������") 
            wait(1500) 
            sampSendChat("/do ������������ � ������� � ����� ��������� �������.*�������� ����� � ��������") 
            wait(1500)
        else
            sampAddChatMessage("����� ���� ������:{FFFFFF}/giverank [ID] [���� 1-9].",0x318CE7FF -1)
        end
    end)
end
 
function cmd_unmask(id)
    if id == nil or id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/unmask [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function() 
            sampSendChat("/me ����� ��������������, ����� ����� �������� ������� ����� � ��������")
            wait(1500)
            sampSendChat("/unmask "..id.." ")
        end)
    end
end

function cmd_miranda()
lua_thread.create(function()
            sampSendChat("�� ������ ����� ������� ��������.")
            wait(1500)
            sampSendChat(" ��, ��� �� �������, �� ����� � ����� ������������ ������ ��� � ����.")
            wait(1500)
            sampSendChat(" �� ������ ����� �� �������� � �� ���� ���������� ������.")
            wait(1500)
            sampSendChat(" ���� � ��� ��� ��������, ����������� ����������� ��� ��������, ������� �������� �� ������� � ���� ����.")
            wait(1500)
            sampSendChat(" ��� ������� ���� �����?")
        end)
     end

function cmd_bodyon()

        lua_thread.create(function()
            sampSendChat("/do �� �����  ����� ������ AXON BODY 3.")
            wait(1500)
            sampSendChat("/me ������ ��������� ���� ���������� � ������� � ����� ���� ��� ��� ���������")
            wait(1500)
            sampSendChat("/do ���� ������ ������ ���� � ����������.")
        end)
     end

function cmd_bodyoff()

lua_thread.create(function()
            sampSendChat("/do �� �����  ����� ������ AXON BODY 3.")
            wait(1500)
            sampSendChat("/me ������ ��������� ���� ���������� � ������� � ����� ���� ��� ��� �����������")
            wait(1500)
            sampSendChat("/do ���� ������ ������ ���� � �����������")
        end)
     end


function cmd_ticket(arg) 
    lua_thread.create(function() 
        local id, prichina, price = arg:match('(%d+)%s(%d+)%s(.)')
        if id ~= nil and prichina ~= nil and price ~= nil then
                sampSendChat("/me ������ ��������� ��������, ����������� ��� � ��� � ������� ������� ��� �����") 
                wait(1500) 
                sampSendChat("/todo �������� ������� ������������, ����� ��������� ����� � �������!*����� ��������") 
                wait(1500)
                sampSendChat('/ticket '..id..' '..prichina..'  '..price..' ')
        else 
      sampAddChatMessage("����� ���� ������: {FFFFFF}/ticket [ID] [�����] [�������].", 0x318CE7FF)
      end 
     end)
    end

function cmd_pursuit(id)
    if id == "" then
         sampAddChatMessage("����� ���� ������: {FFFFFF}/pursuit [ID].", 0x318CE7FF - 1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������� ���� �� ���������� ��������� ����������, ����� ����� �� ���� ������ �� �����")
            wait(1500)
            sampSendChat("/me ����� ���, �������� ����� �������� � ������� ������������ �� ���")
            wait(1500)
            sampSendChat("/pursuit "..id.." ")
        end)
     end
  end

function cmd_drugtestno()
lua_thread.create(function()
            sampSendChat("/me ������ �� �������� ����� Drug-test")
            wait(1500)
            sampSendChat("/me ���� �� ������ �������� � �������� �������")
            wait(1500)
            sampSendChat("/me ������� � �������� �������� ��������")
            wait(1500)
            sampSendChat ("/me ������� � �������� ���� �����-����-10")
            wait(1700)
            sampSendChat("/me ������� ���������� ����������� ��������")
            wait(1700)
            sampSendChat("/do ���� ��� ������������� ���������, �������� �� �������� ����������. ")
        end)
     end


function cmd_drugtestyes()
lua_thread.create(function()
            sampSendChat("/me ������ �� �������� ����� Drug-test")
            wait(1500)
            sampSendChat("/me ���� �� ������ �������� � �������� �������")
            wait(1500)
            sampSendChat("/me ������� � �������� �������� ��������")
            wait(1500)
            sampSendChat ("/me ������� � �������� ���� �����-����-10")
            wait(1700)
            sampSendChat("/me ������� ���������� ����������� ��������")
            wait(1700)
            sampSendChat("/do ���� ��� ������������� ���������, �������� �������� ����������.")
        end)
     end

function cmd_vzatka()

lua_thread.create(function()
         sampSendChat("/me ������� �� ������������, ������ � �������� ����� � ��������.")
         wait(1500)
         sampSendChat("/me ����� �� �������� ����� � ������ ������, ������ �� ������ �������.")
         wait(1500)
         sampSendChat("/do �� �������� �������� � ������ ���� ��������: 3.000.000$.")
      end)
   end


function cmd_bomb()
lua_thread.create(function()

         sampSendChat("/do ����� ��������� ��������� �����, �� ����� ������� ������.")
         wait(1500)
         sampSendChat("/do �� ����������� ���������� ��������� ����� �����.")
         wait(1500)
         sampSendChat("/me ������ ����� ��������� �� ����������� ��� ��� �������������� ����")
         wait(1500)
         sampSendChat("/me ������ ��� �� ����� ������� ���, ��������������� �� ���� ����� � ������, ...")
         wait(1500)
         sampSendChat("/me ... ����� ���������� � ����������� �������� ��������� ������")
         wait(1500)
         sampSendChat("/do [���������]: - �� �������� ������, ��� ����� PR-256, ������� ������� ��������.")
         wait(1500)
         sampSendChat("/do [���������]: - � ������� ���� ����� ����� ������������ �� ����, ����������.")
         wait(1500)
         sampSendChat("/me ����� � ��� ������ search for the nearest device, ����� ���� ��� ����� �����")
         wait(1500)
         sampSendChat("/do ��� ����� ���������� INNPR-256NNI.")
         wait(1500)
         sampSendChat("/me ����������� � ����������, ����� ������� �� ���� ����������")
         wait(1500)
         sampSendChat("/do [���������]: - ��, �� ������������, ������ ������� ��� 1-0-5-J-J-Q-G-2-2.")
         wait(1500)
         sampSendChat("/me ����� ������� ��� ��������� �����������")
         wait(1500)
         sampSendChat("/do ������ �� ����� �����������.")
         wait(1500)
         sampSendChat("/todo ����������.*������ �� ����� � �����������")
         wait(1500)
         sampSendChat("/do [���������]: - ���� ������ ���������, ������ ����� � ����, ����� �����.")
      end)
   end


function cmd_probiv()
lua_thread.create(function()

         sampSendChat("/do �� ����� ����� ������ ��� ����������.")
         wait(1500)
         sampSendChat("/me ���� � ����� ��� , ����� ��������� ��������...")
         wait(1500)
         sampSendChat("/me ... �� ��� ����, ID-����� , �������� � ������")
         wait(1500)
         sampSendChat("/do �� ������ ��� ����������� ��� ���������� � ��������.")
      end)
   end

function cmd_dismiss(arg) 
lua_thread.create(function() 
    local arg1, arg2 = arg:match('(.+) (.+)')   
    if arg1 ~= nil and arg2 ~= nil then 
   sampSendChat('/dismiss '..arg1..' '..arg2..'') 
   wait(1500) 
   sampSendChat("/do � ������ ������� ���� ��������� ���.")
   wait (1500)
   sampSendChat("/me ������ ��� �� ������� �������, ����� ����� ��������� �� ���� ������ ���������� ����� ����, ID ����� � �����")
   wait(1500)
   sampSendChat("/do �� ������ ��� ��������� ������ ���������� � ����������.")
   wait(1500)
   sampSendChat("/me ����� �� ������ ������� �� ���. �����������")
   wait(1500)
   sampSendChat ("/do ��������� ��� ������ �� ������ '���. ����������'.")
   wait(1500)
   sampSendChat("/me ����� ��� ������� � ������ ������") 
    else 
  sampAddChatMessage("����� ���� ������:{FFFFFF} /dismiss [ID] [�������].",0x318CE7FF -1) 
  end 
 end) 
end

function cmd_demoute(arg) 
lua_thread.create(function() 
    local arg1, arg2 = arg:match('(.+) (.+)')   
    if arg1 ~= nil and arg2 ~= nil then 
        sampSendChat('/demoute '..arg1..' '..arg2..'') 
  wait(1500) 
        sampSendChat("/do ��� ����� � ��������� �������.") 
         wait(1500) 
         sampSendChat("/me ������ ����� � ������ ������, ����� ���� ������ ���") 
         wait(1500) 
         sampSendChat("/me ������ � ��� ���� ������ ����������� ���������������� ��������, ����� ���� ����� �� ������ Demoute") 
         wait(1500) 
         sampSendChat("/do ��������� ������� ������ �� ���� ������ ���������������� ��������")
    else 
  sampAddChatMessage("����� ���� ������:{FFFFFF} /demoute [ID] [�������].",0x318CE7FF -1) 
  end 
 end) 
end

function cmd_cure(id)
    if id == "" then   
             sampAddChatMessage("����� ���� ������: {FFFFFF}/cure [ID].", 0x318CE7FF)
    else
        lua_thread.create(function() 
             sampSendChat("/todo ���-�� ��� ������ �����*������ ����������� ����� � �����")
             wait(1500)
             sampSendChat("/me ������ ����������� ����� ����� �������������")
             wait(1500)
             sampSendChat("/do ���.����� �� �����.")
             wait(1500)
             sampSendChat("/me ����������� ��� �����, ����� ����������� ����� �� ������ �������")
             wait(1500)
             sampSendChat("/do ����� �����������.")
             wait(1500)
             sampSendChat("/me �������� �������� ������ ������, ����� �� ������� �������� �����")
             wait(1500)
             sampSendChat("/do ������ ��������� ����� ������ �������� �������� ������.")
             wait(1500)
             sampSendChat("/cure "..id.." ")
         end)
      end
   end


function cmd_find(id)
    if id == "" then
         sampAddChatMessage("����� ���� ������: {FFFFFF}/find [ID].", 0x318CE7FF - 1)
    else
        lua_thread.create(function()
         sampSendChat("/do ��� � ����� �������.")
         wait(1500)
         sampSendChat("/me ������ ����� ����� ��� �� �������")
         wait(1500)
         sampSendChat("/do ��� � ����� ����.")
         wait(1500)
         sampSendChat("/me ������� ��� � ����� � ���� ������ �������")
         wait(1500)
         sampSendChat("/me ������ ���� � ������� �����������")
         wait(1500)
         sampSendChat("/do ������ ����������� ��������.")
         wait(1500)
         sampSendChat("/me ����������� � ������� �������� �����")
         wait(1500)
         sampSendChat ("/do �� ���������� �������� �������.")
         wait(1500)
         sampSendChat("/find "..id.." ")
      end)
   end
end

function cmd_zsu(arg)
lua_thread.create(function()
    local arg1, arg2, arg3 = arg:match('(.+) (.+) (.+)')
    if arg1 ~= nil and arg2 ~= nil and arg3 ~= nil then
        sampSendChat('/r ���������� ���������� � ������ ���� N-'..arg1..'.')
		wait(2500)
		sampSendChat('/r �� ������� - ' ..arg3..'. '..arg2..' �������.')
    else
		sampAddChatMessage("����� ���� ������: {FFFFFF}/zsu [ID] [���-�� �������] [�������].",0x318CE7FF -1)
		end
	end)
end

function cmd_incar(arg)
lua_thread.create(function()
    local arg1, arg2 = arg:match('(.+) (.+)')  
    if arg1 ~= nil and arg2 ~= nil then
        sampSendChat('/incar '..arg1..' '..arg2..'')
  wait(1500)
  sampSendChat('/me ������ ������ ����� � ������')
  wait(1500)
  sampSendChat('/me ������� ����������� � ������')
  wait(1500)
  sampSendChat('/me ������������ �����')
    else
  sampAddChatMessage("����� ���� ������:{FFFFFF}/incar [ID] [����� 1-4].",0x318CE7FF -1)
  end
 end)
end

function cmd_eject(id)
    if id == "" then
        sampAddChatMessage("����� ���� ������:: {FFFFFF}/eject [ID].",0x318CE7FF -1)
    else
        lua_thread.create(function()
            sampSendChat("/me ������ ����� ����, ����� �������� �������� �� ����")
            wait(1500)
            sampSendChat("/eject "..id.." ")
            wait(1500)
            sampSendChat("/me ������ ����� ����")
      end)
   end
end

function cmd_pog(id)
    if id == "" then
         sampAddChatMessage("����� ���� ������: {FFFFFF}/pog [ID].", 0x318CE7FF - 1)
    else
        lua_thread.create(function()
         sampSendChat("/m ��������, ���������� ������������ ��������, ��������� ���������...")
         wait(1500)
         sampSendChat("/m ����� � ������ ����� �� ������ ����������!")
      end)
   end
end

function cmd_tencodes(id)
        lua_thread.create(function()
        sampShowDialog(1,"������ �������� ���-�����", "10-1 - ������� ���� �������� �� ��������� (������� ������� � ���).\n10-3 - ������������� (��� ������� ���������).\n10-4 - �������.\n10-5 - ��������� ��������� ���������.\n10-6 - �� �������/�������/���.\n10-7 - ��������.\n10-8 - � ��������� ����� �����/�� ��������.\n10-14 - ������ ��������������� (������� ������� � ���� ���������������).\n10-15 - ������������� ���������� (������� ���-�� �������������, �������).\n10-18 - ��������� ��������� �������������� ������.\n10-20 - �������.\n10-21 - ��������� � ������� � ���������������, �������� ��������.\n10-22 - ������������� � '�������' (��������� � ����������� �������).\n10-27 - ����� ���������� ������� (������� ������ � ����� ����������).\n10-46 - ������� �����.\n10-55 - ������� ����.\n10-66 - ��������� ����������� ����� (���� ��������, ��� ������������� � ���� ��������/�������� ������������. ���� ��������� ��������� ����� ������).\n10-88 - ������/��.\n10-99 - �������� �������������\n10-100 �������� ���������� ��� �������\n�����:t.me/Sashe4ka_ReZoN", "�������", "Exit", 0)
        end)
        end

function cmd_marks(id)
        lua_thread.create(function()
        sampShowDialog(1,"���������� �� ����", "ADAM [A] ���������� �����, ���������� �� ���� ��������.\nLINCOLN [L] ���������� �����, ���������� �� ������ �������.\nAIR [AIR] ���������� ���������� �����, � ������� ���� ��������\nAir Support Division [ASD] ���������� ����� ��������� ���������.\nMARY [M] ���������� ����-�������.\nHENRY [H] ���������� ������ - ����������� �����, ���������� �� ������ ��� ���� ������.\nCHARLIE [C] ���������� ������ �������.\nROBERT [R] ���������� ������ ����������.\nSUPERVISOR [SV] ���������� ������������ ������� (STAFF).\nDavid [D] ���������� ����.������\n������ ������ ��� ������ � �������, ������ ��������� ���������� �� ���� ������ (/vdesc)\n�����:t.me/Sashe4ka_ReZoN", "�������", "Exit", 0)
         end)
         end

function cmd_sitcodes(id)
        lua_thread.create(function()
        sampShowDialog(1,"������������ ����", "CODE 0 - ������ �����.\nCODE 1 - ������ � ����������� ���������.\nCODE 2 - ������� ����� � ������ �����������. ��� ��������� ����� � ����.��������, �������� ���.\nCODE 2 HIGH - ������������ �����. �� ��� �� ��� ��������� ����� � ����.��������, �������� ���.\nCODE 3 - ������� �����. ������������� ����� � ����.��������, ������������� ��������� ������� ���.\nCODE 4 - ������ �� ���������.\nCODE 4 ADAM - ������ �� ��������� � ������ ������ �������. ������� ����������� �� �������� ������ ���� ������ ������� ������.\nCODE 7 - ������� �� ����.\nCODE 30 - ������������ '�����' ������������ �� ����� ������������.\nCODE 30 RINGER - ������������ '�������' ������������ �� ����� ������������.\nCODE 37 - ����������� ��������� ������������� ��������. ���������� ������� �����, �������� ����������, ����������� ��������.\n�����:t.me/Sashe4ka_ReZoN", "�������", "Exit", 0)
         end)
         end

function cmd_pas(arg)
 lua_thread.create(function()
  if tonumber(arg) == nil then
  sampAddChatMessage("����� ���� ������ : {FFFFFF}/pas [ID].", 0x318CE7FF -1)
  else
  id = arg
  sampSendChat('������������, ������� ��� �� ��������.')
  wait(1500)
  sampSendChat('/do ����� �� ����� ����� ������������, ������ - ������� ������� � ��������.')
  wait(1500)
  sampSendChat('/showbadge '..id) 
  wait(1500)
  sampSendChat('����� ���������� �������� �������������� ���� ��������.')
  end
 end)
end

function cmd_clear(arg)
  if tonumber(arg) == nil then
   sampAddChatMessage("����� ���� ������: {FFFFFF} /clear [ID].", 0x318CE7FF -1)  
  else
  lua_thread.create(function()
  id = arg
  sampSendChat("/me ����� �� ��������, ������� ���������� ��� ��������, ������� ����� �� �������� � �������")
  wait(1500)
  sampSendChat('/clear '..id)
  end)
 end
end

function cmd_take(id)
    if id == "" then   
             sampAddChatMessage("����� ���� ������: {FFFFFF}/take [ID].", 0x318CE7FF)
    else
        lua_thread.create(function() 
             sampSendChat("/do �� ����� ������������ ������ ��������� ��������.")
             wait(1500)
             sampSendChat("/me ����� ������ ����� ����������� ����")
             wait(1500)
             sampSendChat("/do ������� ��� ���� � �������.")
             wait(1500)
             sampSendChat("/me ������ ������� ��� ����, ����� ���� ������� ���� ����������� ����")
             wait(1500)
             sampSendChat("/me ������� ����� � ������� � ��������")
             wait(1500)
             sampSendChat("/do ����� � ������� � �������.")
             wait(1500)
             sampSendChat("/take "..id.." ")
         end)
      end
   end

function cmd_time()
        lua_thread.create(function()
		sampSendChat("/me ������ ���� � ��������� �� ���� ������  Rolex")
		wait(1500)
		sampSendChat("/time")
		sampSendChat('/do �� ����� '..os.date('%H:%M:%S'))
        end)

    end

function cmd_pravda_fbi(id)
	lua_thread.create(function ()
		sampSendChat("/do � ��������� ����� �������, �� ��� ������ �� ����������� �����.")
		wait(1500)
		sampSendChat("/me ������� � ��������, ������ ���, ������ ������� ���� �� ���� �� ���������� ������ �����.")
		wait(1500)
		sampSendChat("/me ������� � �����, ������� ����� �� ����, ������ �� ���� ������� ���� ������� A4 �� ��������.")
		wait(1500)
		sampSendChat("/me ������� ����� �����������, ������� ����� �����.")
		wait(1500)
		sampSendChat("/do ����� ����� �������.")
		wait(1500)
		sampSendChat("/do � ������� ��������: '� ���/�������/���� ��������' ")
		wait(1500)
		sampSendChat("/do '� ���� ������ ��������������� �� ���������� ������� � �������� ��� �������")
		wait(1500)
		sampSendChat("/do �� ������ ��������������� ���� ���� � ����� ����� ��������� ���������������.' ")
		wait(1500)
		sampSendChat("���������� �� ������ ��� �� �������, ���� ������� ������� � ����.")
	end)
end

function cmd_secret_fbi(id)
	lua_thread.create(function ()
		sampSendChat("/do �� ����� ����� ��������: \"�������� � ������������� ������������ ���\"")
		wait(1500)
		sampSendChat("/do ����� � ���������� ��������� ����������� ����� � ������� ����������� \"���\"")
		wait(1500)
		sampSendChat("/do � ��������� ��������: \"�, (��� / �������), ������� ������� ������ ��, ...")
		wait(1500)
		sampSendChat("/do ... ��� �����, ����, � ���� ������\"")
		wait(1500)
		sampSendChat("/do ���� ��������: \"����� ����� ������ ���������������, � � ������ ������ �������������, ...")
		wait(1500)
		sampSendChat("/do ... ����� ���� ������������ � ������������ �� ���������, ��� ������� �������\"")
		wait(1500)
		sampSendChat("/do ��� ���� ��������: \"����: ; �������: \"")
	end)
end

function cmd_finger_person(id)
	lua_thread.create(function ()
		sampSendChat("/do �� ������ ������ ��������� ��������� ����. �����.")
		wait(1500)
		sampSendChat("/me ���� ����. ����� �� �����, ����� ������� � �� ������ �����������")
		wait(1500)
		sampSendChat("/do � ����. ����� �������: ����� � �������� ��� � ���������, ����. �����.")
		wait(1500)
		sampSendChat("/me ���� ������� � ������, ������ � ��������� ������� ����� �� ������ �������� ��������")
		wait(1500)
		sampSendChat("/do ������ �������� �������� ������� ������.")
		wait(1500)
		sampSendChat("/me ������ �� ����. ����� ����������� �����, ����� ����������� � �� ������ ��������")
		wait(1500)
		sampSendChat("/do ��������� ����������� �� �����.")
		wait(1500)
		sampSendChat("/me ��������� ���� ����� � ������� ��������, �������� �� � ����. �������")
		wait(1500)
		sampSendChat("/do � ����. �������� ��������� ����� � ������� ��������.")
		wait(1500)
		sampSendChat("/me ������� ����. ������� � ������ ������ ����, ���� � ���� ������� � ������ ...")
		wait(1500)
		sampSendChat("/me ... � ��������, ������� �� � ����. �����, ����� ��������� �")
		wait(1500)
		sampSendChat("/do ����. ������� ����� � ������ ������� ����, ����. ����� �������.")
	end)
end

function cmd_warn()
	lua_thread.create(function ()
		sampSendChat("/r  ��� ��������� �������. ������� ���� �� �����  ")
	end)
end

function cmd_grim()
    lua_thread.create(function ()
    sampSendChat("/do � �������� ����� ����� ��� ����������������� �����.")
    wait(1500)
    sampSendChat("/me ������ ������� � ������ �� ���� ����� ��� �����, �������� ��� �� ������� � ������")
    wait(1500)
    sampSendChat("/do ����� ��� ����� ������.")
    wait(1500)
    sampSendChat("/do ��� ��������� ����� �������.")
    wait(1500)
    sampSendChat("/me ������������ �����, ���� ������� ����� � ������ � � ����� ����, ����� �������� ��� �� ����, ������ � �������")
    wait(1500)
    sampSendChat("/me ���� ������ ��������, ������ � � ����� � ����� �������� �� ����")
   wait(1500)
   sampSendChat("/me ��������� �� ���� �����, ������ �������� � ����� ���� � ���� �� �� ����")
   wait(1500)
   sampSendChat("/me ���� ����� � ������ � � ����� ����� � ���� � �� ����")
   wait(1500)
   sampSendChat("/me ������� ����� � ����� ��� ������������ � ������ �����")
   wait(1500)
   sampSendChat("/me ����� ����� � ������� � ������ ���")
   wait(1500)
   sampSendChat("/do �� ���� ������ ����.")
       end)
end

function cmd_eks()
    lua_thread.create(function ()
    sampSendChat ("/do � ������� ������� ����� ��������� ��������.")
wait(1500)
sampSendChat ("/me ������ ����� ������ �� ������� �������� � ����� �� �� ����� ���")
wait(1500)
sampSendChat("/do �� ����� ����� ������, ������� � ���� ����� ������, ��� ������ � ����������.")
wait(1500)
sampSendChat("/me �������� ������ � ��������� �������� ��� �� ��������� �����")
wait(1500)
sampSendChat("/me ���� � ���� ������ � ������� ������, �������� ������� � ������ ���� ����������")
wait(1500)
sampSendChat("/me ����� ������� ������ �� �������")
wait(1500)
sampSendChat("/do �� ������� ������ �������� ����� ������ �� �� ���������� ������.")
wait(1500)
sampSendChat("/me ��������� ������� � ������� �� ���� ������")
wait(1500)
sampSendChat("/me ���� �������� �� ������ � ��������� ���������� � ����� � ��������")
wait(1500)
sampSendChat("/me ������ �������� � �������� �� ������ ������")
wait(1500)
sampSendChat("/me ���� � ���� ������ ��������� ������� � ���������� �������� ����� ������")
wait(1500)
sampSendChat("/me ������� ��������� � ������ ���� ������, � ��������� ������ ��� ����� ������")
wait(1500)
sampSendChat("/do �� ������ ����������� ���������� �� ������ � ���������.")
wait(1500)
sampSendChat("/me ������� ������ ��������� ������� ������� �� ����")
wait(1500)
sampSendChat("/me ������ ������ � �����, ������ �� ����� ���������� ����.����� � �������� � ���� ������")
wait(1500)
sampSendChat("/me ���� �� ����� ��������� � ������� �� ����.�����, ����� ��������� � ���� � ������ ���")
       end)
end

local secondFrame = imgui.OnFrame(
    function() return windowTwo[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"������ �������", windowTwo)
        imgui.InputInt(u8 'ID ������ � ������� ������ �����������������', id,10)
        for i = 1, #tableUk["Text"] do
            if imgui.Button(u8(tableUk["Text"][i] .. ' ������� �������: ' .. tableUk["Ur"][i])) then
                lua_thread.create(function()
                    sampSendChat("/do ����� ����� �� �����������.")
                    wait(1500)
                    sampSendChat("/me ������ � �������� ��������� �����, ������� ������ � �������")
                    wait(1500)
                    sampSendChat("/su " .. id[0] .. " " .. tableUk["Ur"][i] .. " " .. tableUk["Text"][i])
                    wait(1500)
                    sampSendChat("/do ������ ����� ��������� ������� ������� � ����������� ������.")
                end)
            end
        end
        imgui.End()
    end
)

local thirdFrame = imgui.OnFrame(
    function() return leaderPanel[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"������ ������/�����������", leaderPanel)
        imgui.InputInt(u8'ID ������ � ������� ������ �����������������', id, 10)
        if imgui.Button(u8'������� ����������') then
            lua_thread.create(function ()
                sampSendChat("/do ��� ����� �� �����.")
                wait(1500)
                sampSendChat("/me ���� ��� � ����� � ����� � ��������� ����������")
                wait(1500)
                sampSendChat("/me ����� � ������ ���������� � ����� �� ������ �������")
                wait(1500)
                sampSendChat("/do �� ��� ����������� ������� '��������� ������� ������!'")
                wait(1500)
                sampSendChat("/me �������� ��� � ������� ������� �� ����")
                wait(1500)
                sampSendChat("�� ��� �, �� ��������. �������� ������ � ���� ��������.")
                wait(1500)
                sampSendChat("/uninvite".. id[0])
            end)
        end

        if imgui.Button(u8'������� ����������') then
            lua_thread.create(function ()
                sampSendChat("/do ��� ����� �� �����.")
                wait(1500)
                sampSendChat("/me ���� ��� � ����� � ����� � ��������� ����������")
                wait(1500)
                sampSendChat("/me ����� � ������� � ���� ������ � ����� ����������")
                wait(1500)
                sampSendChat("/do �� ��� ����������� �������: '��������� ������� ��������! ��������� ��� ������� ������ :)'")
                wait(1500)
                sampSendChat("/me �������� ��� � ������� ������� �� ����")
                wait(1500)
                sampSendChat("����������, �� �������! ����� �������� � ����������.")
                wait(1500)
                sampSendChat("/invite".. id[0])
            end)
        end

        if imgui.Button(u8'������ ������� ����������') then
            lua_thread.create(function ()
                sampSendChat("/do ��� ����� �� �����.")
                wait(1500)
                sampSendChat("/me ���� ��� � ����� � ����� � ��������� ����������")
                wait(1500)
                sampSendChat("/me ����� � ������ ���������� � ����� �� ������ ������ �������")
                wait(1500)
                sampSendChat("/do �� ��� ����������� �������: '������� �����!'")
                wait(1500)
                sampSendChat("/me �������� ��� � ������� ������� �� ����")
                wait(1500)
                sampSendChat("�� ��� �, ������� �����. �������������.")
                wait(1500)
                sampSendChat("/fwarn".. id[0])
            end)
        end

        if imgui.Button(u8'����� ������� ����������') then
            lua_thread.create(function ()
                sampSendChat("/do ��� ����� �� �����.")
                wait(1500)
                sampSendChat("/me ���� ��� � ����� � ����� � ��������� ����������")
                wait(1500)
                sampSendChat("/me ����� � ������ ���������� � ����� �� ������ ����� �������")
                wait(1500)
                sampSendChat("/do �� ��� ����������� �������: '������� ����!'")
                wait(1500)
                sampSendChat("/me �������� ��� � ������� ������� �� ����")
                wait(1500)
                sampSendChat("�� ��� �, ����������.")
                wait(1500)
                sampSendChat("/unfwarn" .. id[0])
            end)
        end
        imgui.End()
    end
)

local setUkFrame = imgui.OnFrame(
    function() return setUkWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(900, 700), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"��������� ������ �������", setUkWindow)
            if imgui.BeginChild('Name', imgui.ImVec2(700, 500), true) then
                for i = 1, #tableUk["Text"] do 
                    imgui.Text(u8(tableUk["Text"][i] .. ' ������� �������: ' .. tableUk["Ur"][i]))
                    Uk = #tableUk["Text"]
                end
                imgui.EndChild()
            end
            if imgui.Button(u8'��������', imgui.ImVec2(500, 36)) then
                addUkWindow[0] = not addUkWindow[0]
            end
            if imgui.Button(u8'�������', imgui.ImVec2(500, 36)) then
                Uk = #tableUk["Text"]
            	table.remove(tableUk.Text, #tableUk.Text)
                table.remove(tableUk.Ur, #tableUk.Ur)
            	encodedTable = encodeJson(tableUk)
                local file = io.open("smartUk.json", "w")
                file:write(encodedTable)
                file:flush()
                file:close()
                
                
				
            end
        imgui.End()
    end
)

local addUkFrame = imgui.OnFrame(
    function() return addUkWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"��������� ������ �������", addUkWindow)
            imgui.InputText(u8'����� ������(� �������.)', newUkInput, 255)
            newUkName = u8:decode(ffi.string(newUkInput))
            imgui.InputInt(u8'������� �������(������ �����)', newUkUr, 10)
            if imgui.Button(u8'���������') then
            	Uk = #tableUk["Text"]
            	tableUk["Text"][Uk+1] = newUkName
            	tableUk["Ur"][Uk+1] = newUkUr[0]
            	encodedTable = encodeJson(tableUk)
                local file = io.open("smartUk.json", "w")
                file:write(encodedTable)
                file:flush()
                file:close()
            end
        imgui.End()
    end
)

function calculateZone(x, y, z)
    local streets = {
        {"���������� ���� �������", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
        {"������������� �������� �����-���", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
        {"���������� ���� �������", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
        {"������������� �������� �����-���", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
        {"������", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
        {"�����-�����", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
        {"��������� ���-������", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
        {"�������� ���� ���-���������", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
        {"����������� ��������", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
        {"���������� ���� �������", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
        {"�����", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
        {"������� ������", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
        {"�������� ���� ���-���������", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
        {"���-������", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
        {"������ �������� ������", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
        {"�������� �����-���", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
        {"������� �����", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
        {"��������� ���������", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
        {"������� �������", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
        {"������� �������", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
        {"����������� ����������", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
        {"���� ���������", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
        {"������� �������-����", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
        {"������� �����", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
        {"����������", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
        {"����������", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
        {"���������� ���� �������", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
        {"����������", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
        {"��������� ���������� �������", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
        {"����������", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
        {"�������� ���������� �������", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
        {"�����", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
        {"������� ����������", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
        {"������� �����", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
        {"�������� ��������", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
        {"��������� �������", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
        {"����������� ��������", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
        {"������������� �������� ���-������", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
        {"�����-����", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
        {"�����", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
        {"������", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
        {"������� �����", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
        {"�����", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
        {"������� �����", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
        {"����������� ��������", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
        {"��������� �����", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
        {"����������", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
        {"������ ������", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
        {"������� ��������", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
        {"������������� �������� ���-������", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
        {"����������", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
        {"���� ��� ������ �������-����", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
        {"�����", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
        {"����������", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
        {"����������", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
        {"������-��������", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
        {"���-�������", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
        {"���-�������", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
        {"������", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
        {"�������� ���� ���-���������", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
        {"�������� ���������� �������", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
        {"����������", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
        {"�������� ���������� �������", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
        {"�����", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
        {"��������� �������", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
        {"�����", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
        {"�������� ���-��������", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
        {"������", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
        {"�����", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
        {"��������� ���-������", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
        {"��������� ���������� �������", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
        {"����������", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
        {"���-�������", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
        {"��������� ���������� �������", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
        {"�����", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
        {"���-������", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
        {"��������� ���������� �������", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
        {"�����", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
        {"�������", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
        {"�����", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
        {"�������� ���������� �������", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
        {"������� �����", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
        {"�����", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
        {"����������", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
        {"�������-�����", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
        {"�����", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
        {"���� ��������", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
        {"���� �������", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
        {"������������ �����", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
        {"����������", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
        {"�����", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
        {"����������", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
        {"����������", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
        {"����� ���������� �������", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
        {"�������", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
        {"��������� ����", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
        {"������������ �����", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
        {"�������� ���������� �������", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
        {"�����", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
        {"���� ����", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
        {"������������� �������� �����-���", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
        {"���� �������", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
        {"�����", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
        {"����������", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
        {"������", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
        {"�������� ���-��������", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
        {"�������", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
        {"��������� ���������", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
        {"������� �����", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
        {"���� �����", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
        {"�����", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
        {"������� ��������", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
        {"����������", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
        {"���� �����", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
        {"���-�������", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
        {"����������", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
        {"�������� ���������� �������", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
        {"������������ �����", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
        {"�����", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
        {"����-���������", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
        {"�����", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
        {"������", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
        {"���-�������", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
        {"����������", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
        {"�����", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
        {"��������� ��������", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
        {"������� �����", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
        {"��������� �����", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
        {"������", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
        {"�����-�����", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
        {"������� ���������", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
        {"���� ����", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
        {"�������� ���� ���-���������", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
        {"��������-���", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
        {"���� �������", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
        {"��������� ���-������", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
        {"������ ��������", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
        {"�������", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
        {"��������", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
        {"�������", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
        {"�����", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
        {"������� �����", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
        {"������������ �����", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
        {"��������� ���-������", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
        {"������", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
        {"������", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
        {"�������", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
        {"��������� ���-������", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
        {"�����", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
        {"��������� �������", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
        {"�����", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
        {"��������� ��������", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
        {"������ ������� ������", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
        {"�������", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
        {"����������� ����������", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
        {"����������", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
        {"�����", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
        {"�����-����", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
        {"������������� �������� ���-������", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
        {"���� �������", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
        {"���� �������", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
        {"���� ��������", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
        {"���� ��������", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
        {"���� �������", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
        {"������������ ������� ���", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
        {"�������", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
        {"�������", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
        {"������������ �����", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
        {"������", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
        {"�������� ������", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
        {"�������� ���������� �������", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
        {"��������� ����", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
        {"���� �������", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
        {"����������", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
        {"���������", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
        {"���-��������-����-������", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
        {"��������� ����", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
        {"�������� �����-���", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
        {"������ ������", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
        {"�����-�����", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
        {"������", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
        {"�������� �������� �������� �����", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
        {"������", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
        {"������ �������� ������", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
        {"��������� ����", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
        {"����������", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
        {"������� �����", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
        {"������� �����", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
        {"���� �������", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
        {"����� ���������� �������", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
        {"��������� ���-������", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
        {"������� ����������", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
        {"���-�������", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
        {"����������", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
        {"��������� ����", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
        {"��������� ���-������", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
        {"������", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
        {"���������� ���� �������", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
        {"����������", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
        {"�������� ���������", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
        {"������ ����-������", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
        {"��������� ����", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
        {"������ ���������� ����", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
        {"��������-������", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
        {"�����", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
        {"���-������", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
        {"������� ��������", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
        {"�������� �������", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
        {"��������� ���������� �������", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
        {"���-������", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
        {"������ ������", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
        {"�����-����", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
        {"���� �������", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
        {"����������� ������", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
        {"������-����", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
        {"��������� ����", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
        {"����������", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
        {"�����", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
        {"������������ �����", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
        {"����������", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
        {"������", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
        {"�������-�����", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
        {"������ �4 �������", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
        {"��������", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
        {"�������� ���������� �������", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
        {"���� ��� ������ �������-����", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
        {"�������", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
        {"�������� ��������", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
        {"������", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
        {"����� �������", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
        {"���-���������", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
        {"������ ������� � ������� �������", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
        {"���� ����", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
        {"���������� ���� �������", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
        {"�����", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
        {"�������", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
        {"������������� �������� ���-������", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
        {"�������-�������", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
        {"������������� �������", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
        {"���-������", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
        {"������� �����", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
        {"������ ������", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
        {"���-��������", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
        {"������ ���������", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
        {"����������� ��������", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
        {"������", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
        {"������������� �������� �����-���", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
        {"��������� ��������", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
        {"��������� ���������", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
        {"������ ��������", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
        {"������ �������", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
        {"������", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
        {"������ �������� ������", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
        {"����������", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
        {"������� �����", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
        {"�����-�����-�����", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
        {"������� ����� ������� �.�.�.�.", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
        {"���������� ������-����", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
        {"������� �������", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
        {"��������� ����", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
        {"������", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
        {"��������� ����� ���������", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
        {"��������� ����", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
        {"�����-�����", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
        {"��������", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
        {"������� �������", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
        {"���� ����", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
        {"������� �����", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
        {"�������� ��������", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
        {"������", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
        {"���� �����", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
        {"��� �Probe Inn�", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
        {"����������� �����", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
        {"���-�������", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
        {"������-����-����", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
        {"���������� ������", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
        {"���-��������-����-������", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
        {"�����-�����", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
        {"�����-����-������", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
        {"������", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
        {"�����", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
        {"����������� ������", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
        {"��������", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
        {"��������", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
        {"��������", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
        {"�������� ���", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
        {"��������", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
        {"���-��������", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
        {"�������� ���������", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
        {"������������� �������� �����-���", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
        {"�������� ������", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
        {"����������", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
        {"��������� ����", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
        {"���-������� �����", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
        {"�������� �����", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
        {"������", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
        {"�������� ������", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
        {"�����-����", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
        {"������ �����", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
        {"����-������", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
        {"�������� ���� ���-���������", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
        {"�����-����", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
        {"��������", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
        {"���-��������-����-������", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
        {"������� �����", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
        {"��������� ������", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
        {"����� ���-������", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
        {"��������", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
        {"������ ������ ��������", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
        {"���-��������-�����", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
        {"��������-����", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
        {"��������-������", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
        {"����-���������", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
        {"��������� ���������� �������", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
        {"���� �������", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
        {"������ ������", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
        {"����-����-�����", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
        {"�������� ������", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
        {"�����", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
        {"����� �������", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
        {"�������� ���������", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
        {"���������� �����", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
        {"������", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000},
        {"����������", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
        {"����", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
        {"������������� �������� ���-������", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
        {"���� ������-������", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
        {"����������� ����������", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
        {"�������-����", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
        {"¸�����-������", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
        {"�����-�������", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
        {"������ ���-�-���", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
        {"�������� ��������", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
        {"���� ������-������", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
        {"������������ ������� ���", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
        {"�������� ���-��������", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
        {"����� �����", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
        {"������������ ������� ���", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
        {"�������� ����", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
        {"��������� ����", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
        {"������������� �������� �����-���", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
        {"�������-�������", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
        {"������-�����", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
        {"������ �����", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
        {"����� ���-������", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
        {"������", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
        {"���� ������", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
        {"����-������", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
        {"������ ������", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
        {"�����-�����", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
        {"����-����", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
        {"�������", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
        {"�������� ���-��������", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
        {"�������� ��������", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
        {"���������", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
        {"����-���", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
        {"������ �������", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
        {"������������� �������� ���-������", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
        {"���������-����", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
        {"����� ���-������", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
        {"��������� ����", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
        {"���� �������", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
        {"���� �������", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
        {"������������� �������� �����-���", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
        {"����������", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
        {"�������� �����", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
        {"���-�-������", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
        {"���� �������", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
        {"������ ������", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
        {"����� �����", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
        {"��������", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
        {"��������� �����", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000},
        {"������ ������", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
        {"��� ������", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
        {"��� ��������", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
        {"�������� �����", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000},
        {"��� ������", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}
    }
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return '��������'
end

local suppWindowFrame = imgui.OnFrame(
    function() return suppWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"��������������� ������", suppWindow, imgui.WindowFlags.NoTitleBar)
            
			imgui.Text(u8'�����: '..os.date('%H:%M:%S'))
            imgui.Text(u8'�����: '..os.date('%B'))
			imgui.Text(u8'������ ����: '..arr.day..'.'.. arr.month..'.'..arr.year)
        	local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
			imgui.Text(u8'�����:' .. u8(calculateZone(positionX, positionY, positionZ)))
			local p_city = getCityPlayerIsIn(PLAYER_PED)
			if p_city == 1 then pCity = u8'��� - ������' end
			if p_city == 2 then pCity = u8'��� - ������' end
			if p_city == 3 then pCity = u8'��� - ��������' end
			if getActiveInterior() ~= 0 then pCity = u8'�� ���������� � ���������!' end
			imgui.Text(u8'�����: ' .. pCity)
		imgui.End()
    end
)

function cmd_stop(id)
	if id == nil then
		sampAddChatMessage("����� ���� ������:: {FFFFFF}/stop [ID].",0x318CE7FF -1)
    else
	else
		local nickNameStop = sampGetPlayerNickname(id)
		lua_thread.create(function()
			sampSendChat("/do ������� � ��������.")
			wait(1500)
			sampSendChat("/me ������ ������� � �������� ����� ���� ������� ���")
			wait(1500)
			sampSendChat("/m ��������� " .. nickNameStop .. " ���������� � �������!")
		end)
	end
end