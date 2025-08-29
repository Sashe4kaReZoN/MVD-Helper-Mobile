---@diagnostic disable: need-check-nil, lowercase-global

script_name("MVD Helper Mobile")

script_version("5.7.1")
script_authors("@Sashe4ka_ReZoN", "@daniel29032012", "@makson4ck2", "@osp_x")

--Libs START
require('moonloader')
local copas            = require("copas")
local encoding         = require 'encoding'
local requests         = require('requests')
local imgui            = require('mimgui')
local inicfg           = require("inicfg")
local faicons          = require('fAwesome6')
local fa               = require('fAwesome6_solid')
local sampev           = require('lib.samp.events')
local ffi              = require('ffi')
local monet            = require("MoonMonet")
local effil            = require('effil')
local md5              = require("md5")
local memory           = require("memory") 
--Libs END

--���������
encoding.default       = 'CP1251'
local u8               = encoding.UTF8

--Windows buffs START
local startWindow      = imgui.new.bool(false)
local fastVzaimWindow  = imgui.new.bool(false)
local vzaimWindow      = imgui.new.bool(false)
local megafon          = imgui.new.bool(false)
local logsWin          = imgui.new.bool(false)
local patroolhelpmenu  = imgui.new.bool(false)
local window           = imgui.new.bool(false)
local vzWindow         = imgui.new.bool(false)
local updateWin        = imgui.new.bool(false)
local NoteWindow       = imgui.new.bool(false)
local showEditWindow   = imgui.new.bool(false)
local showAddNotePopup = imgui.new.bool(false)
local menuSizes        = imgui.new.bool(false)
local gunsWindow       = imgui.new.bool(false)
local suppWindow       = imgui.new.bool(false)
local windowTwo        = imgui.new.bool(false)
local setUkWindow      = imgui.new.bool(false)
local addUkWindow      = imgui.new.bool(false)
local importUkWindow   = imgui.new.bool(false)
local BinderWindow     = imgui.new.bool(false)
local leaderPanel      = imgui.new.bool(false)
local MainWindow       = imgui.new.bool(false)
--Windows buffs END
--������
local directIni = 'MVDHelper.ini'
local mainIni = inicfg.load({
    Accent = {
        accent = '[���������� ������]: '
    },
    Info = {
        org = u8 '�� �� �������� � ��',
        dl = u8 '�� �� �������� � ��',
        rang_n = 0
    },
    theme = {
        themeta = "standart",
        selected = 0,
        moonmonet = 759410733
    },
    settings = {
        autoRpGun = false,
        poziv = false,
        autoAccent = false,
        standartBinds = true,
        Jone = false,
        ObuchalName = "���������",
        button = false
    },
    statTimers = {
        state = false,
        clock = true,
        sesOnline = true,
        sesAfk = true,
        sesFull = true,
        dayOnline = true,
        dayAfk = true,
        dayFull = true,
        weekOnline = true,
        weekAfk = true,
        weekFull = true,
        server = nil
    },
    onDay = {
        today = os.date("%a"),
        online = 0,
        afk = 0,
        full = 0
    },
    onWeek = {
        week = 1,
        online = 0,
        afk = 0,
        full = 0
    },
    myWeekOnline = {
        [0] = 0,
        [1] = 0,
        [2] = 0,
        [3] = 0,
        [4] = 0,
        [5] = 0,
        [6] = 0
    },
    pos = {
        x = 0,
        y = 0
    },
    style = {
        round = 5.0,
        colorW = 4279834905,
        colorT = 4286677377,
    },
    menuSettings = {
        x = 850,
        y = 820,
        tab = 370,
        xpos = 90,
        vtpos = 1,
        ChildRoundind = 10
    },
    bodyCam = {
        enabled = true,
        posX = 500,
        posY = 500,
        rpBodycam = true,
        timeBk = false,
        videoRp = false,
    }
}, directIni)
inicfg.save(mainIni, directIni)

--��������� ����������
local new             = imgui.new
local button_megafon  = imgui.new.bool(mainIni.settings.button or false)
local AI_PAGE         = {}
local menu2           = 2
local ToU32           = imgui.ColorConvertFloat4ToU32
local u32             = imgui.ColorConvertFloat4ToU32
local page            = 8
local helper_path     = script.this.path
local MDS             = MONET_DPI_SCALE or 1
local str             = ffi.string
local isPatrolActive  = false
local FrameTime       = imgui.new.int(10000)
local MyGif           = nil
local tochkaMe        = imgui.new.bool(false)
local path            = getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/Binder.json"
local joneV           = imgui.new.bool(mainIni.settings.Jone)
local id              = imgui.new.int(0)
local otherorg        = imgui.new.char[256]()
local arr             = os.date("*t")
local newUkInput      = imgui.new.char(255)
local newUkUr         = imgui.new.int(0)
local spawn           = true
local autogun         = new.bool(mainIni.settings.autoRpGun)
local selected_theme  = imgui.new.int(mainIni.theme.selected)
local theme_a         = { u8 '�����������', 'MoonMonet' }
local theme_t         = { u8 'standart', 'moonmonet' }
local items           = imgui.new['const char*'][#theme_a](theme_a)
local AutoAccentBool  = new.bool(mainIni.settings.autoAccent)
local AutoAccentInput = new.char[255](u8(mainIni.Accent.accent))
local org             = u8 '�� �� �������� � ��'
local org_g           = u8 '�� �� �������� � ��'
local dol             = '�� �� �������� � ��'
local dl              = u8 '�� �� �������� � ��'
local rang_n          = 0
local notes           = {}
local newNoteTitle    = imgui.new.char[256]()
local newNoteContent  = imgui.new.char[1024]()
local editNoteTitle   = imgui.new.char[256]()
local editNoteContent = imgui.new.char[1024]()
local note_name       = nil
local note_text       = nil
local logs            = {}
local dephistory      = {}
local orgname         = imgui.new.char[255]()
local deliting_script = false
local departsettings  = {
    myorgname = new.char[255](u8 'nil'),
    toorgname = new.char[255](),
    frequency = new.char[255](),
    myorgtext = new.char[255](),
}
local changingInfo    = false
local ObuchalName     = new.char[255](u8(mainIni.settings.ObuchalName))
local orga            = imgui.new.char[255](mainIni.Info.org)
local dolzh           = imgui.new.char[255](mainIni.Info.dl)
local spawncar_bool   = false
local jsonFile        = getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/gunCommands.json"
local weapons         = {
    "�������",
    "�������",
    "������������ ���",
    "������",
    "Colt-45",
    "Desert Eagle",
    "��������",
    "������",
    "Spas",
    "���",
    "��5",
    "AK-47",
    "�4",
    "TEC-9",
    "��������",
    "����������� ��������",
    "����������",
    "��� ������"
}
local gunCommands     = {
    "/me ������ ������� � �������� ���������",
    "/me ���� � ����� �������",
    "/me ���� ������� ������������� ���� � �����",
    "/me ������ ������ � ������, ����� ��������������",
    "/me ������ �������� Colt-45, ���� ��������������",
    "/me ������ Desert Eagle � ������, ����� ��������������",
    "/me ������ ����� �� �����, ���� �������� � ����� ��������������",
    "/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ ������",
    "/me ������ �������� Spas, ���� ��������������",
    "/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ ���",
    "/me ������ ����� �� �����, ���� ��5 � ����� ��������������",
    "/me ������ ������� AK-47 �� �����",
    "/me ������ ������� �4 �� �����",
    "/me ������ ��������� ����� ���, ���� ������� ������ � ���� � ������ TEC-9",
    "/me ������ �������� ��� ������� �� ������� �����",
    "/me ������ ����������� �������� � ������� �����",
    "/me ������ ���������� �� �������",
    "/me �������� ��������������, ����� ������"
}
local newButtonText   = imgui.new.char[255]()
local newButtonCommand= imgui.new.char[2555]()
local pages = {
    { icon = faicons("HOUSE"), title = "  �������", index = 8 },
    { icon = faicons("BOOK"), title = "  ������", index = 2 },
    { icon = faicons("TOWER_BROADCAST"), title = "  ���. ����� ", index = 3 },
    { icon = faicons("RECTANGLE_LIST"), title = "  �������", index = 5 },
    { icon = faicons("CIRCLE_INFO"), title = "  ����", index = 6 },
    { icon = faicons("GEAR"), title = "  ���������", index = 1 },
}
local serversList = {
    "mobile-i", "mobile-ii", "mobile-iii", "phoenix", "tucson", "chandler", "scottdale", "brainburg",
    "saint-rose", "mesa", "red-rock", "yuma", "surprise", "prescott", "glendale", "kingman",
    "winslow", "payson", "gilbert", "show-low", "casa-grande", "page", "sun-city", "queen-creek",
    "sedona", "holiday", "wednesday", "yava", "faraway", "bumble-bee", "christmas", "mirage",
    "love", "drake"
}


local servers = {
    ["80.66.82.162"]    = { number = -1, name = "Mobile I" },
    ["80.66.82.148"]    = { number = -2, name = "Mobile II" },
    ["80.66.82.136"]    = { number = -3, name = "Mobile III" },
    ["185.169.134.44"]  = { number = 4, name = "Chandler" },
    ["185.169.134.43"]  = { number = 3, name = "Scottdale" },
    ["185.169.134.45"]  = { number = 5, name = "Brainburg" },
    ["185.169.134.5"]   = { number = 6, name = "Saint-Rose" },
    ["185.169.132.107"] = { number = 6, name = "Saint-Rose" },
    ["185.169.134.59"]  = { number = 7, name = "Mesa" },
    ["185.169.134.61"]  = { number = 8, name = "Red-Rock" },
    ["185.169.134.107"] = { number = 9, name = "Yuma" },
    ["185.169.134.109"] = { number = 10, name = "Surprise" },
    ["185.169.134.166"] = { number = 11, name = "Prescott" },
    ["185.169.134.171"] = { number = 12, name = "Glendale" },
    ["185.169.134.172"] = { number = 13, name = "Kingman" },
    ["185.169.134.173"] = { number = 14, name = "Winslow" },
    ["185.169.134.174"] = { number = 15, name = "Payson" },
    ["80.66.82.191"]    = { number = 16, name = "Gilbert" },
    ["80.66.82.190"]    = { number = 17, name = "Show Low" },
    ["80.66.82.188"]    = { number = 18, name = "Casa-Grande" },
    ["80.66.82.168"]    = { number = 19, name = "Page" },
    ["80.66.82.159"]    = { number = 20, name = "Sun-City" },
    ["80.66.82.200"]    = { number = 21, name = "Queen-Creek" },
    ["80.66.82.144"]    = { number = 22, name = "Sedona" },
    ["80.66.82.132"]    = { number = 23, name = "Holiday" },
    ["80.66.82.128"]    = { number = 24, name = "Wednesday" },
    ["80.66.82.113"]    = { number = 25, name = "Yava" },
    ["80.66.82.82"]     = { number = 26, name = "Faraway" },
    ["80.66.82.87"]     = { number = 27, name = "Bumble Bee" },
    ["80.66.82.54"]     = { number = 28, name = "Christmas" },
    ["80.66.82.39"]     = { number = 29, name = "Mirage" },
    ["80.66.82.33"]     = { number = 30, name = "Love" },
    ["185.169.134.3"]   = { number = 1, name = "Phoenix" },
    ["185.169.132.105"] = { number = 1, name = "Phoenix" },
    ["185.169.134.4"]   = { number = 2, name = "Tucson" },
    ["185.169.132.106"] = { number = 2, name = "Tucson" },
    ["mobile1.arizona-rp.com"]    = { number = -1, name = "Mobile I" },
    ["mobile2.arizona-rp.com"]    = { number = -2, name = "Mobile II" },
    ["mobile3.arizona-rp.com"]    = { number = -3, name = "Mobile III" },
    ["chandler.arizona-rp.com"]   = { number = 4, name = "Chandler" },
    ["scottdale.arizona-rp.com"]  = { number = 3, name = "Scottdale" },
    ["brainburg.arizona-rp.com"]  = { number = 5, name = "Brainburg" },
    ["saintrose.arizona-rp.com"]  = { number = 6, name = "Saint-Rose" },
    ["mesa.arizona-rp.com"]       = { number = 7, name = "Mesa" },
    ["redrock.arizona-rp.com"]    = { number = 8, name = "Red-Rock" },
    ["yuma.arizona-rp.com"]       = { number = 9, name = "Yuma" },
    ["surprise.arizona-rp.com"]   = { number = 10, name = "Surprise" },
    ["prescott.arizona-rp.com"]   = { number = 11, name = "Prescott" },
    ["glendale.arizona-rp.com"]   = { number = 12, name = "Glendale" },
    ["kingman.arizona-rp.com"]    = { number = 13, name = "Kingman" },
    ["winslow.arizona-rp.com"]    = { number = 14, name = "Winslow" },
    ["payson.arizona-rp.com"]     = { number = 15, name = "Payson" },
    ["gilbert.arizona-rp.com"]    = { number = 16, name = "Gilbert" },
    ["showlow.arizona-rp.com"]    = { number = 17, name = "Show Low" },
    ["casagrande.arizona-rp.com"] = { number = 18, name = "Casa-Grande" },
    ["page.arizona-rp.com"]       = { number = 19, name = "Page" },
    ["suncity.arizona-rp.com"]    = { number = 20, name = "Sun-City" },
    ["queencreek.arizona-rp.com"] = { number = 21, name = "Queen-Creek" },
    ["sedona.arizona-rp.com"]     = { number = 22, name = "Sedona" },
    ["holiday.arizona-rp.com"]    = { number = 23, name = "Holiday" },
    ["wednesday.arizona-rp.com"]  = { number = 24, name = "Wednesday" },
    ["yava.arizona-rp.com"]       = { number = 25, name = "Yava" },
    ["faraway.arizona-rp.com"]    = { number = 26, name = "Faraway" },
    ["bumblebee.arizona-rp.com"]  = { number = 27, name = "Bumble Bee" },
    ["christmas.arizona-rp.com"]  = { number = 28, name = "Christmas" },
    ["mirage.arizona-rp.com"]     = { number = 29, name = "Mirage" },
    ["love.arizona-rp.com"]       = { number = 30, name = "Love" },
    ["phoenix.arizona-rp.com"]    = { number = 1, name = "Phoenix" },
    ["tucson.arizona-rp.com"]     = { number = 2, name = "Tucson" },
    ["drake.arizona-rp.com"]      = { number = 31, name = "Drake" },
}

local smartUkPath = getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/smartUk.json"
local smartUkUrl = {
    ["mobile-i"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Mobile1.json",
    ["mobile-ii"]    = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Mobile2.json",
    ["mobile-iii"]   = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Mobile%203.json",
    ["phoenix"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Phoenix.json",
    ["tucson"]       = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Tucson.json",
    ["chandler"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Chandler.json",
    ["scottdale"]    = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Scottdale.json",
    ["brainburg"]    = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Brainburg.json",
    ["saint-rose"]   = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Saint-Rose.json",
    ["mesa"]         = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Mesa.json",
    ["red-rock"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Red-Rock.json",
    ["yuma"]         = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Yuma.json",
    ["surprise"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Surprise.json",
    ["prescott"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Prescott.json",
    ["glendale"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Glendale.json",
    ["kingman"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Kingman.json",
    ["winslow"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Winslow.json",
    ["payson"]       = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Payson.json",
    ["gilbert"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Gilbert.json",
    ["show-low"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Show%20Low.json",
    ["casa-grande"]  = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Casa-Grande.json",
    ["page"]         = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Page.json",
    ["sun-city"]     = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Sun-City.json",
    ["queen-creek"]  = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Queen-Creek.json",
    ["sedona"]       = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Sedona.json",
    ["holiday"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Holiday.json",
    ["wednesday"]    = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Wednesday.json",
    ["yava"]         = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Yava.json",
    ["faraway"]      = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Faraway.json",
    ["bumble-bee"]   = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Bumble%20Bee.json",
    ["christmas"]    = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Christmas.json",
    ["mirage"]       = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Mirage.json",
    ["love"]         = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Love.json",
    ["drake"]        = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/smartUkLink/Drake.json"
}

local buttonsJson = getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/buttons.json"
local standartButtons = {
    ['10-55'] = {'/m ��������, ������� �������� � ���������� � �������.', '/m ������� ���� �� ���� � ��������� ���������'}
}
local search = false

--MOONMONET START
function join_argb(a, r, g, b)
    local argb = b                          -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end
function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

function ARGBtoRGB(color)
    return bit.band(color, 0xFFFFFF)
end

function rgb2hex(r, g, b)
    local hex = string.format("#%02X%02X%02X", r, g, b)
    return hex
end

function ColorAccentsAdapter(color)
    local a, r, g, b = explode_argb(color)
    local ret = { a = a, r = r, g = g, b = b }
    function ret:apply_alpha(alpha)
        self.a = alpha
        return self
    end

    function ret:as_u32()
        return join_argb(self.a, self.b, self.g, self.r)
    end

    function ret:as_vec4()
        return imgui.ImVec4(self.r / 255, self.g / 255, self.b / 255, self.a / 255)
    end

    function ret:as_argb()
        return join_argb(self.a, self.r, self.g, self.b)
    end

    function ret:as_rgba()
        return join_argb(self.r, self.g, self.b, self.a)
    end

    function ret:as_chat()
        return string.format("%06X", ARGBtoRGB(join_argb(self.a, self.r, self.g, self.b)))
    end

    return ret
end
--MOONMONET END 
function msg(text, color) -- Custom message
    if not color then
        gen_color = monet.buildColors(mainIni.theme.moonmonet, 1.0, true)
    else
        gen_color = monet.buildColors(color, 1.0, true)
    end 
    local curcolor1 = '0x' .. ('%X'):format(gen_color.accent1.color_300)
    sampAddChatMessage("[MVD Helper]: {FFFFFF}" .. text, curcolor1)
end
function saveIni()
    inicfg.save(mainIni, directIni)
    print("CFG saved")
end
function downloadFile(url, path)
    local response = requests.get(url)

    if response.status_code == 200 then
        local filepath = path
        os.remove(filepath)
        local f = assert(io.open(filepath, 'wb'))
        f:write(response.text)
        f:close()
    else
        print('������ ����������...')
    end
end
function downloadBinder()
    file = io.open(path, "w")
    file:close()
    file = io.open(path, "a+")
    downloadFile("https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/refs/heads/main/Binder.json",
        path)
    msg('��������������� ���� �������, ������������')
    thisScript():reload()
end
function loadCommands()
    local file = io.open(jsonFile, "r")
    if file then
        local content = file:read("*a")
        file:close()
        local decodedJson = decodeJson(content)
        if decodedJson then
            gunCommands = decodedJson
            print("��������� �� �����:", gunCommands)
        else
            msg("������ ������������� JSON. �������� �����������.")
            saveCommands()
        end
    else
        msg("�� ������� ��������� JSON ���� � ����������� ������. �������� �����������")
        saveCommands()
    end
end
function saveCommands()
    local file = io.open(jsonFile, "w")
    if file then
        file:write(encodeJson(gunCommands))
        file:close()
    else
        msg("�� ������� ������� ���� ��� ������!")
    end
end
function readButtons()
    local file = io.open(buttonsJson, "r")
    if file then
        local buttonsJson = file:read("*a")
        file:close()
        return decodeJson(buttonsJson)
    else
        local file = io.open(buttonsJson, "w")
        file:write(encodeJson(standartButtons))
        file:close()
        return standartButtons
    end
end
function load_settings()
    if not doesDirectoryExist(getWorkingDirectory():gsub('\\','/') .. '/MVDHelper') then
        createDirectory(getWorkingDirectory():gsub('\\','/') ..'/MVDHelper')
    end
    if not doesDirectoryExist(getWorkingDirectory():gsub('\\','/') .. '/arzfun') then
        createDirectory(getWorkingDirectory():gsub('\\','/') ..'/arzfun')
    end
    local default_settings_binder = {
        commands = {
            {},
        },
    }
    --Binder
    if not doesFileExist(path) then
        settings = default_settings_binder
        downloadBinder()
        print('[Binder] ���� � ����������� �� ������, ��������� ����������� ���������!')
    else
        local file = io.open(path, 'r')
        if file then
            local contents = file:read('*a')
            file:close()
            if #contents == 0 then
                settings = default_settings_binder
                print('[Binder] �� ������� ������� ���� � �����������, ��������� ����������� ���������!')
            else
                local result, loaded = pcall(decodeJson, contents)
                if result then
                    settings = loaded
                    for category, _ in pairs(default_settings_binder) do
                        if settings[category] == nil then
                            settings[category] = {}
                        end
                        for key, value in pairs(default_settings_binder[category]) do
                            if settings[category][key] == nil then
                                settings[category][key] = value
                            end
                        end
                    end
                    print('[Binder] ��������� ������� ���������!')
                else
                    print('[Binder] �� ������� ������� ���� � �����������, ��������� ����������� ���������!')
                end
            end
        else
            settings = default_settings_binder
            downloadBinder()
            print('[Binder] �� ������� ������� ���� � �����������, ��������� ����������� ���������!')
        end
    end
    --Smart UK
    local file = io.open(smartUkPath, "r") -- ��������� ���� � ������ ������
    if not file then
        tableUk = { Ur = { 6 }, Text = { "��������� �� ������������ 14.4" } }
        file = io.open(smartUkPath, "w")
        file:write(encodeJson(tableUk))
        file:close()
    else
        a = file:read("*a")
        file:close()
        tableUk = decodeJson(a)
    end
    --RP guns
    loadCommands()
    --Window buttons
    readButtons()
    
end
--MTG mods binder START

function save_settings()
    local file, errstr = io.open(path, 'w')
    if file then
        local result, encoded = pcall(encodeJson, settings)
        file:write(result and encoded or "")
        file:close()
        return result
    else
        print('[Binder] �� ������� ��������� ��������� �������, ������: ', errstr)
        return false
    end
end

function isMonetLoader() return MONET_VERSION ~= nil end

if MONET_DPI_SCALE == nil then MONET_DPI_SCALE = 1.0 end


local message_color = 0x00CCFF
local message_color_hex = '{00CCFF}'

local sizeX, sizeY = getScreenResolution()
local ComboTags = new.int()
local item_list = { u8 '��� ���������', u8 '{arg} - ��������� ��� ������, �����/�����/�������', u8 '{arg_id} - ��������� ������ ID ������',
    u8 '{arg_id} {arg2} - ��������� 2 ���������: ID ������ � ������ ��� ������' }
local ImItems = imgui.new['const char*'][#item_list](item_list)
local change_cmd = ''
local change_description = ''
local change_text = ''
local change_arg = ''

local isActiveCommand = false

local tagReplacements = {
    my_id = function() return select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) end,
    my_nick = function() return sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) end,
    my_ru_nick = function() return TranslateNick(sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) end,
    get_time = function()
        return os.date("%H:%M:%S")
    end,
}
local binder_tags_text = [[
{my_id} - ��� ������� ID
{my_nick} - ��� ������� Nick
{my_ru_nick} - ���� ��� � ������� ��������� � �������

{get_time} - �������� ������� �����

{get_nick({arg_id})} - �������� Nick ������ �� ��������� ID ������
{get_rp_nick({arg_id})}  - �������� Nick ������ ��� ������� _ �� ��������� ID ������
{get_ru_nick({arg_id})}  - �������� Nick ������ �� �������� �� ��������� ID ������
]]


function registerCommandsFrom(array)
    for _, command in ipairs(array) do
        if command.enable and not command.deleted then
            register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
        end
    end
end

function register_command(chat_cmd, cmd_arg, cmd_text, cmd_waiting)
    sampRegisterChatCommand(chat_cmd, function(arg)
        if not isActiveCommand then
            local arg_check = false
            local modifiedText = cmd_text
            if cmd_arg == '{arg}' then
                if arg and arg ~= '' then
                    modifiedText = modifiedText:gsub('{arg}', arg or "")
                    arg_check = true
                else
                    msg('[Binder] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [��������]',
                        message_color)
                    play_error_sound()
                end
            elseif cmd_arg == '{arg_id}' then
                if isParamSampID(arg) then
                    arg = tonumber(arg)
                    modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}', sampGetPlayerNickname(arg) or "")
                    modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}',
                        sampGetPlayerNickname(arg):gsub('_', ' ') or "")
                    modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}',
                        TranslateNick(sampGetPlayerNickname(arg)) or "")
                    modifiedText = modifiedText:gsub('%{arg_id%}', arg or "")
                    arg_check = true
                else
                    msg('[Binder] {ffffff}����������� ' .. message_color_hex .. '/' .. chat_cmd .. ' [ID ������]',
                        message_color)
                    play_error_sound()
                end
            elseif cmd_arg == '{arg_id} {arg2}' then
                if arg and arg ~= '' then
                    local arg_id, arg2 = arg:match('(%d+) (.+)')
                    if isParamSampID(arg_id) and arg2 then
                        arg_id = tonumber(arg_id)
                        modifiedText = modifiedText:gsub('%{get_nick%(%{arg_id%}%)%}',
                            sampGetPlayerNickname(arg_id) or "")
                        modifiedText = modifiedText:gsub('%{get_rp_nick%(%{arg_id%}%)%}',
                            sampGetPlayerNickname(arg_id):gsub('_', ' ') or "")
                        modifiedText = modifiedText:gsub('%{get_ru_nick%(%{arg_id%}%)%}',
                            TranslateNick(sampGetPlayerNickname(arg_id)) or "")
                        modifiedText = modifiedText:gsub('%{arg_id%}', arg_id or "")
                        modifiedText = modifiedText:gsub('%{arg2%}', arg2 or "")
                        arg_check = true
                    else
                        msg(
                            '[Binder] {ffffff}����������� ' ..
                            message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [��������]', message_color)
                        play_error_sound()
                    end
                else
                    msg(
                        '[Binder] {ffffff}����������� ' ..
                        message_color_hex .. '/' .. chat_cmd .. ' [ID ������] [��������]',
                        message_color)
                    play_error_sound()
                end
            elseif cmd_arg == '' then
                arg_check = true
            end
            if arg_check then
                lua_thread.create(function()
                    isActiveCommand = true
                    local lines = {}
                    for line in string.gmatch(modifiedText, "[^&]+") do
                        table.insert(lines, line)
                    end
                    for _, line in ipairs(lines) do
                        if command_stop then
                            command_stop = false
                            isActiveCommand = false
                            msg('[Binder] {ffffff}��������� ������� /' .. chat_cmd .. " ������� �����������!",
                                message_color)
                            return
                        end
                        for tag, replacement in pairs(tagReplacements) do
                            line = line:gsub("{" .. tag .. "}", replacement())
                        end
                        sampSendChat(line)
                        wait(cmd_waiting * 1000)
                    end
                    isActiveCommand = false
                end)
            end
        else
            msg('[Binder] {ffffff}��������� ���������� ��������� ���������� �������!', message_color)
        end
    end)
end

function path_join(...)
    local path = ''
    local arg = { ... }
    for i = 1, #arg do
        path = path .. arg[i]
        if i ~= #arg then
            path = path .. '\\'
        end
    end
    return path
end

imgui.OnInitialize(function()
    MyGif = imgui.LoadFrames()
    decor()
    apply_n_t()

    imgui.GetIO().IniFilename = nil
    
    local config = imgui.ImFontConfig()
    config.MergeMode = true
    config.PixelSnapH = true
    iconRanges = imgui.new.ImWchar[3](faicons.min_range, faicons.max_range, 0)
    imgui.GetIO().Fonts:AddFontFromMemoryCompressedBase85TTF(faicons.get_font_data_base85('solid'), 14 * MDS, config, iconRanges) -- solid - ��� ������, ��� �� ���� thin, regular, light � duotone
    local tmp = imgui.ColorConvertU32ToFloat4(mainIni.theme['moonmonet'])
    gen_color = monet.buildColors(mainIni.theme.moonmonet, 1.0, true)
    mmcolor = imgui.new.float[3](tmp.z, tmp.y, tmp.x)

    local glyph_ranges = imgui.GetIO().Fonts:GetGlyphRangesCyrillic()
    Menu = imgui.GetIO().Fonts:AddFontFromFileTTF("fonts/Inter.ttf", 42, _, glyph_ranges)
    imgui.GetStyle():ScaleAllSizes(MDS)
    big = imgui.GetIO().Fonts:AddFontFromFileTTF("fonts/Inter.ttf", 30, _, glyph_ranges)
end)

function asyncHttpRequest(method, url, args, resolve, reject)
    local request_thread = effil.thread(function(method, url, args)
        local result, response = pcall(requests.request, method, url, effil.dump(args))
        if result then
            response.json, response.xml = nil, nil
            return true, response
        else
            return false, response
        end
    end)(method, url, args)
    if not resolve then resolve = function() end end
    if not reject then reject = function() end end
    lua_thread.create(function()
        local runner = request_thread
        while true do
            local status, err = runner:status()
            if not err then
                if status == 'completed' then
                    local result, response = runner:get()
                    if result then
                        resolve(response)
                    else
                        reject(response)
                    end
                    return
                elseif status == 'canceled' then
                    return reject(status)
                end
            else
                return reject(err)
            end
            wait(0)
        end
    end)
end
local MainWindowFrame = imgui.OnFrame(
    function() return MainWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * MONET_DPI_SCALE, 425 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.TERMINAL .. u8 " Binder by MTG MODS - ������� ����", MainWindow,
            imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)

        if imgui.BeginChild('##1', imgui.ImVec2(700 * MONET_DPI_SCALE, 700 * MONET_DPI_SCALE), true) then
            imgui.Columns(3)
            imgui.CenterColumnText(u8 "�������")
            imgui.SetColumnWidth(-1, 170 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "��������")
            imgui.SetColumnWidth(-1, 300 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "��������")
            imgui.SetColumnWidth(-1, 230 * MONET_DPI_SCALE)
            imgui.Columns(1)
            imgui.Separator()
            imgui.Columns(3)
            imgui.CenterColumnText(u8 "/binder")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "������� ������� ���� �������")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "����������")
            imgui.Columns(1)
            imgui.Separator()
            imgui.Columns(3)
            imgui.CenterColumnText(u8 "/stop [����������]")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "���������� ����� ��������� �� ������� [����������]")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "����������")
            imgui.Columns(1)
            imgui.Separator()
            for index, command in ipairs(settings.commands) do
                if not command.deleted then
                    imgui.Columns(3)
                    if command.enable then
                        imgui.CenterColumnText('/' .. u8(command.cmd))
                        imgui.NextColumn()
                        imgui.CenterColumnText(u8(command.description))
                        imgui.NextColumn()
                    else
                        imgui.CenterColumnTextDisabled('/' .. u8(command.cmd))
                        imgui.NextColumn()
                        imgui.CenterColumnTextDisabled(u8(command.description))
                        imgui.NextColumn()
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    if command.enable then
                        if imgui.SmallButton(fa.TOGGLE_ON .. '##' .. command.cmd) then
                            command.enable = not command.enable
                            save_settings()
                            sampUnregisterChatCommand(command.cmd)
                        end
                        if imgui.IsItemHovered() then
                            imgui.SetTooltip(u8 "���������� ������� /" .. command.cmd)
                        end
                    else
                        if imgui.SmallButton(fa.TOGGLE_OFF .. '##' .. command.cmd) then
                            command.enable = not command.enable
                            save_settings()
                            register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
                        end
                        if imgui.IsItemHovered() then
                            imgui.SetTooltip(u8 "��������� ������� /" .. command.cmd)
                        end
                    end
                    imgui.SameLine()
                    if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. command.cmd) then
                        change_description = command.description
                        input_description = imgui.new.char[256](u8(change_description))
                        change_arg = command.arg
                        if command.arg == '' then
                            ComboTags[0] = 0
                        elseif command.arg == '{arg}' then
                            ComboTags[0] = 1
                        elseif command.arg == '{arg_id}' then
                            ComboTags[0] = 2
                        elseif command.arg == '{arg_id} {arg2}' then
                            ComboTags[0] = 3
                        end
                        change_cmd = command.cmd
                        input_cmd = imgui.new.char[256](u8(command.cmd))
                        change_text = command.text:gsub('&', '\n')
                        input_text = imgui.new.char[8192](u8(change_text))
                        change_waiting = command.waiting
                        waiting_slider = imgui.new.float(tonumber(command.waiting))
                        BinderWindow[0] = true
                    end
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(u8 "��������� ������� /" .. command.cmd)
                    end
                    imgui.SameLine()
                    if imgui.SmallButton(fa.TRASH_CAN .. '##' .. command.cmd) then
                        imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. command.cmd)
                    end
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(u8 "�������� ������� /" .. command.cmd)
                    end
                    if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. command.cmd, _, imgui.WindowFlags.NoResize) then
                        imgui.CenterText(u8 '�� ������������� ������ ������� ������� /' .. u8(command.cmd) .. '?')
                        imgui.Separator()
                        if imgui.Button(fa.CIRCLE_XMARK .. u8 ' ���, ��������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                            imgui.CloseCurrentPopup()
                        end
                        imgui.SameLine()
                        if imgui.Button(fa.TRASH_CAN .. u8 ' ��, �������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                            command.enable = false
                            command.deleted = true
                            sampUnregisterChatCommand(command.cmd)
                            save_settings()
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                    imgui.Columns(1)
                    imgui.Separator()
                end
            end
            imgui.EndChild()
        end
        if imgui.Button(fa.CIRCLE_PLUS .. u8 ' ������� ����� �������##new_cmd', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
            local new_cmd = {
                cmd = '',
                description = '����� ������� ��������� ����',
                text = '',
                arg = '',
                enable = true,
                waiting =
                '1.200',
                deleted = false
            }
            table.insert(settings.commands, new_cmd)
            change_description = new_cmd.description
            input_description = imgui.new.char[256](u8(change_description))
            change_arg = new_cmd.arg
            ComboTags[0] = 0
            change_cmd = new_cmd.cmd
            input_cmd = imgui.new.char[256](u8(new_cmd.cmd))
            change_text = new_cmd.text:gsub('&', '\n')
            input_text = imgui.new.char[8192](u8(change_text))
            change_waiting = 1.200
            waiting_slider = imgui.new.float(1.200)
            BinderWindow[0] = true
        end
        imgui.End()
    end
)

imgui.OnFrame(
    function() return BinderWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600 * MONET_DPI_SCALE, 425 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver)
        imgui.Begin(fa.TERMINAL .. u8 " Binder by MTG MODS - �������������� ������� /" .. change_cmd, BinderWindow,
            imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        if imgui.BeginChild('##binder_edit', imgui.ImVec2(589 * MONET_DPI_SCALE, 361 * MONET_DPI_SCALE), true) then
            imgui.CenterText(fa.FILE_LINES .. u8 ' �������� �������:')
            imgui.PushItemWidth(579 * MONET_DPI_SCALE)
            imgui.InputText("##input_description", input_description, 256)
            imgui.Separator()
            imgui.CenterText(fa.TERMINAL .. u8 ' ������� ��� ������������� � ���� (��� /):')
            imgui.PushItemWidth(579 * MONET_DPI_SCALE)
            imgui.InputText("##input_cmd", input_cmd, 256)
            imgui.Separator()
            imgui.CenterText(fa.CODE .. u8 ' ��������� ������� ��������� �������:')
            imgui.Combo(u8 '', ComboTags, ImItems, #item_list)
            imgui.Separator()
            imgui.CenterText(fa.FILE_WORD .. u8 ' ��������� ���� �������:')
            imgui.InputTextMultiline("##text_multiple", input_text, 8192,
                imgui.ImVec2(579 * MONET_DPI_SCALE, 173 * MONET_DPI_SCALE))
            imgui.EndChild()
        end
        if imgui.Button(fa.CIRCLE_XMARK .. u8 ' ������', imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
            BinderWindow[0] = false
        end
        imgui.SameLine()
        if imgui.Button(fa.CLOCK .. u8 ' ��������', imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
            imgui.OpenPopup(fa.CLOCK .. u8 ' �������� (� ��������) ')
        end
        if imgui.BeginPopupModal(fa.CLOCK .. u8 ' �������� (� ��������) ', _, imgui.WindowFlags.NoResize) then
            imgui.PushItemWidth(200 * MONET_DPI_SCALE)
            imgui.SliderFloat(u8 '##waiting', waiting_slider, 0.3, 5)
            imgui.Separator()
            if imgui.Button(fa.CIRCLE_XMARK .. u8 ' ������', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
                waiting_slider = imgui.new.float(tonumber(change_waiting))
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if imgui.Button(fa.FLOPPY_DISK .. u8 ' ���������', imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.End()
        end
        imgui.SameLine()
        if imgui.Button(fa.TAGS .. u8 ' ���� ', imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
            imgui.OpenPopup(fa.TAGS .. u8 ' �������� ���� ��� ������������� � �������')
        end
        if imgui.BeginPopupModal(fa.TAGS .. u8 ' �������� ���� ��� ������������� � �������', _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.AlwaysAutoResize) then
            imgui.Text(u8(binder_tags_text))
            imgui.Separator()
            if imgui.Button(fa.CIRCLE_XMARK .. u8 ' �������', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.End()
        end
        imgui.SameLine()
        if imgui.Button(fa.FLOPPY_DISK .. u8 ' ���������', imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
            if ffi.string(input_cmd):find('%W') or ffi.string(input_cmd) == '' or ffi.string(input_description) == '' or ffi.string(input_text) == '' then
                imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8 ' ������ ���������� �������!')
            else
                local new_arg = ''
                if ComboTags[0] == 0 then
                    new_arg = ''
                elseif ComboTags[0] == 1 then
                    new_arg = '{arg}'
                elseif ComboTags[0] == 2 then
                    new_arg = '{arg_id}'
                elseif ComboTags[0] == 3 then
                    new_arg = '{arg_id} {arg2}'
                end
                local new_waiting = waiting_slider[0]
                local new_description = u8:decode(ffi.string(input_description))
                local new_command = u8:decode(ffi.string(input_cmd))
                local new_text = u8:decode(ffi.string(input_text)):gsub('\n', '&')
                if binder_create_command_9_10 then
                    for _, command in ipairs(settings.commands_manage) do
                        if command.cmd == change_cmd and command.description == change_description and command.arg == change_arg and command.text:gsub('&', '\n') == change_text then
                            command.cmd = new_command
                            command.arg = new_arg
                            command.description = new_description
                            command.text = new_text
                            command.waiting = new_waiting
                            save_settings()
                            if command.arg == '' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' [��������] {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg_id}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' [ID ������] {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg_id} {arg2}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex ..
                                    '/' .. new_command .. ' [ID ������] [��������] {ffffff}������� ���������!',
                                    message_color)
                            end
                            sampUnregisterChatCommand(change_cmd)
                            register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
                            binder_create_command_9_10 = false
                            break
                        end
                    end
                else
                    for _, command in ipairs(settings.commands) do
                        if command.cmd == change_cmd and command.description == change_description and command.arg == change_arg and command.text:gsub('&', '\n') == change_text then
                            command.cmd = new_command
                            command.arg = new_arg
                            command.description = new_description
                            command.text = new_text
                            command.waiting = new_waiting
                            save_settings()
                            if command.arg == '' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' [��������] {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg_id}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex .. '/' .. new_command .. ' [ID ������] {ffffff}������� ���������!',
                                    message_color)
                            elseif command.arg == '{arg_id} {arg2}' then
                                msg(
                                    '[Binder] {ffffff}������� ' ..
                                    message_color_hex ..
                                    '/' .. new_command .. ' [ID ������] [��������] {ffffff}������� ���������!',
                                    message_color)
                            end
                            sampUnregisterChatCommand(change_cmd)
                            register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
                            break
                        end
                    end
                end
                BinderWindow[0] = false
            end
        end
        if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8 ' ������ ���������� �������!', _, imgui.WindowFlags.AlwaysAutoResize) then
            if ffi.string(input_cmd):find('%W') then
                imgui.BulletText(u8 " � ������� ����� ������������ ������ ����. ����� �/��� �����!")
            elseif ffi.string(input_cmd) == '' then
                imgui.BulletText(u8 " ������� �� ����� ���� ������!")
            end
            if ffi.string(input_description) == '' then
                imgui.BulletText(u8 " �������� ������� �� ����� ���� ������!")
            end
            if ffi.string(input_text) == '' then
                imgui.BulletText(u8 " ���� ������� �� ����� ���� ������!")
            end
            imgui.Separator()
            if imgui.Button(fa.CIRCLE_XMARK .. u8 ' �������', imgui.ImVec2(300 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                imgui.CloseCurrentPopup()
            end
            imgui.End()
        end
        imgui.End()
    end
)

function openLink(link)
    if isMonetLoader() then
        local gta = ffi.load('GTASA')
        ffi.cdef [[
			void _Z12AND_OpenLinkPKc(const char* link);
		]]
        gta._Z12AND_OpenLinkPKc(link)
    else
        os.execute("explorer " .. link)
    end
end

function play_error_sound()
    if not isMonetLoader() and sampIsLocalPlayerSpawned() then
        addOneOffSound(getCharCoordinates(PLAYER_PED), 1149)
    end
end

local russian_characters = {
    [168] = '�',
    [184] = '�',
    [192] = '�',
    [193] = '�',
    [194] = '�',
    [195] = '�',
    [196] = '�',
    [197] = '�',
    [198] = '�',
    [199] = '�',
    [200] = '�',
    [201] = '�',
    [202] = '�',
    [203] = '�',
    [204] = '�',
    [205] = '�',
    [206] = '�',
    [207] = '�',
    [208] = '�',
    [209] = '�',
    [210] = '�',
    [211] = '�',
    [212] = '�',
    [213] = '�',
    [214] = '�',
    [215] = '�',
    [216] = '�',
    [217] = '�',
    [218] = '�',
    [219] = '�',
    [220] = '�',
    [221] = '�',
    [222] = '�',
    [223] = '�',
    [224] = '�',
    [225] = '�',
    [226] = '�',
    [227] = '�',
    [228] = '�',
    [229] = '�',
    [230] = '�',
    [231] = '�',
    [232] = '�',
    [233] = '�',
    [234] = '�',
    [235] = '�',
    [236] = '�',
    [237] = '�',
    [238] = '�',
    [239] = '�',
    [240] = '�',
    [241] = '�',
    [242] = '�',
    [243] = '�',
    [244] = '�',
    [245] = '�',
    [246] = '�',
    [247] = '�',
    [248] = '�',
    [249] = '�',
    [250] = '�',
    [251] = '�',
    [252] = '�',
    [253] = '�',
    [254] = '�',
    [255] = '�',
}
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then           -- �
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end

function string.rupper(s)
    s = s:upper()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:upper()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 224 and ch <= 255 then -- lower russian characters
            output = output .. russian_characters[ch - 32]
        elseif ch == 184 then           -- �
            output = output .. russian_characters[168]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end

function TranslateNick(name)
    if name:match('%a+') then
        for k, v in pairs({ ['ph'] = '�', ['Ph'] = '�', ['Ch'] = '�', ['ch'] = '�', ['Th'] = '�', ['th'] = '�', ['Sh'] = '�', ['sh'] = '�', ['ea'] = '�', ['Ae'] = '�', ['ae'] = '�', ['size'] = '����', ['Jj'] = '��������', ['Whi'] = '���', ['lack'] = '���', ['whi'] = '���', ['Ck'] = '�', ['ck'] = '�', ['Kh'] = '�', ['kh'] = '�', ['hn'] = '�', ['Hen'] = '���', ['Zh'] = '�', ['zh'] = '�', ['Yu'] = '�', ['yu'] = '�', ['Yo'] = '�', ['yo'] = '�', ['Cz'] = '�', ['cz'] = '�', ['ia'] = '�', ['ea'] = '�', ['Ya'] = '�', ['ya'] = '�', ['ove'] = '��', ['ay'] = '��', ['rise'] = '����', ['oo'] = '�', ['Oo'] = '�', ['Ee'] = '�', ['ee'] = '�', ['Un'] = '��', ['un'] = '��', ['Ci'] = '��', ['ci'] = '��', ['yse'] = '��', ['cate'] = '����', ['eow'] = '��', ['rown'] = '����', ['yev'] = '���', ['Babe'] = '�����', ['Jason'] = '�������', ['liy'] = '���', ['ane'] = '���', ['ame'] = '���' }) do
            name = name:gsub(k, v)
        end
        for k, v in pairs({ ['B'] = '�', ['Z'] = '�', ['T'] = '�', ['Y'] = '�', ['P'] = '�', ['J'] = '��', ['X'] = '��', ['G'] = '�', ['V'] = '�', ['H'] = '�', ['N'] = '�', ['E'] = '�', ['I'] = '�', ['D'] = '�', ['O'] = '�', ['K'] = '�', ['F'] = '�', ['y`'] = '�', ['e`'] = '�', ['A'] = '�', ['C'] = '�', ['L'] = '�', ['M'] = '�', ['W'] = '�', ['Q'] = '�', ['U'] = '�', ['R'] = '�', ['S'] = '�', ['zm'] = '���', ['h'] = '�', ['q'] = '�', ['y'] = '�', ['a'] = '�', ['w'] = '�', ['b'] = '�', ['v'] = '�', ['g'] = '�', ['d'] = '�', ['e'] = '�', ['z'] = '�', ['i'] = '�', ['j'] = '�', ['k'] = '�', ['l'] = '�', ['m'] = '�', ['n'] = '�', ['o'] = '�', ['p'] = '�', ['r'] = '�', ['s'] = '�', ['t'] = '�', ['u'] = '�', ['f'] = '�', ['x'] = 'x', ['c'] = '�', ['``'] = '�', ['`'] = '�', ['_'] = ' ' }) do
            name = name:gsub(k, v)
        end
        return name
    end
    return name
end

function isParamSampID(id)
    id = tonumber(id)
    if id ~= nil and tostring(id):find('%d') and not tostring(id):find('%D') and string.len(id) >= 1 and string.len(id) <= 3 then
        if id == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then
            return true
        elseif sampIsPlayerConnected(id) then
            return true
        else
            return false
        end
    else
        return false
    end
end
--MTG mods binder END

-- Timer START
local cfg = mainIni
mcx = 0x0087FF
local sX, sY = getScreenResolution()
local to = new.bool(cfg.statTimers.state)
local nowTime = os.date("%H:%M:%S", os.time())
local settingsonline = new.bool(false)
local myOnline = new.bool(false)
local recon = false

local sesOnline = new.int(0)
local sesAfk = new.int(0)
local sesFull = new.int(0)
local dayFull = new.int(cfg.onDay.full)
local weekFull = new.int(cfg.onWeek.full)
local sRound = new.float(cfg.style.round)

local argbW = cfg.style.colorW
local argbT = cfg.style.colorT

local tmp = imgui.ColorConvertU32ToFloat4(cfg.style.colorW)
local colorW = new.float[4](tmp.x, tmp.y, tmp.z, tmp.w)

local tmp = imgui.ColorConvertU32ToFloat4(cfg.style.colorT)
local colorT = new.float[4](tmp.x, tmp.y, tmp.z, tmp.w)

local posX, posY = cfg.pos.x, cfg.pos.y
local Radio = {
    ['clock'] = cfg.statTimers.clock,
    ['sesOnline'] = cfg.statTimers.sesOnline,
    ['sesAfk'] = cfg.statTimers.sesAfk,
    ['sesFull'] = cfg.statTimers.sesFull,
    ['dayOnline'] = cfg.statTimers.dayOnline,
    ['dayAfk'] = cfg.statTimers.dayAfk,
    ['dayFull'] = cfg.statTimers.dayFull,
    ['weekOnline'] = cfg.statTimers.weekOnline,
    ['weekAfk'] = cfg.statTimers.weekAfk,
    ['weekFull'] = cfg.statTimers.weekFull
}

local tWeekdays = {
    [0] = '�����������',
    [1] = '�����������',
    [2] = '�������',
    [3] = '�����',
    [4] = '�������',
    [5] = '�������',
    [6] = '�������'
}

imgui.OnFrame(function() return to[0] and not recon end,
    function()
        -- timer window >>
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(colorW[0], colorW[1], colorW[2], colorW[3]))
        imgui.PushStyleColor(imgui.Col.Text, imgui.ImVec4(colorT[0], colorT[1], colorT[2], colorT[3]))
        imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, sRound[0])
        imgui.SetNextWindowPos(imgui.ImVec2(posX, posY), imgui.Cond.FirstUseEver)
        local flags = imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse +
            imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize
        if not editpos then flags = flags + imgui.WindowFlags.NoMove end

        imgui.Begin(u8 '##timer', to, flags)
        local pos = imgui.GetWindowPos()

        if cfg.statTimers.clock then
            imgui.PushFont(fsClock)
            imgui.CenterTextColoredRGB(nowTime)
            imgui.PopFont()
            imgui.SetCursorPosY(30)
            imgui.CenterTextColoredRGB(getStrDate(os.time()))
            if cfg.statTimers.sesOnline or cfg.statTimers.sesAfk or cfg.statTimers.sesFull or cfg.statTimers.dayOnline or cfg.statTimers.dayAfk or cfg.statTimers.dayFull or cfg.statTimers.weekOnline or cfg.statTimers.weekAfk or cfg.statTimers.weekFull then
                imgui.Separator()
            end
        end

        imgui.PushStyleVarVec2(imgui.StyleVar.ItemSpacing, imgui.ImVec2(5, 2))
        if not sampIsLocalPlayerSpawned() then
            --imgui.CenterTextColoredRGB("�����������: " .. get_clock(connectingTime))
        else
            if cfg.statTimers.sesOnline then imgui.CenterTextColoredRGB("������ (������): " .. get_clock(sesOnline[0])) end
            if cfg.statTimers.sesAfk then imgui.CenterTextColoredRGB("AFK �� ������: " .. get_clock(sesAfk[0])) end
            if cfg.statTimers.sesFull then imgui.CenterTextColoredRGB("������ �� ������: " .. get_clock(sesFull[0])) end
            if cfg.statTimers.dayOnline then
                imgui.CenterTextColoredRGB("�� ���� (������): " ..
                    get_clock(cfg.onDay.online))
            end
            if cfg.statTimers.dayAfk then imgui.CenterTextColoredRGB("��� �� ����: " .. get_clock(cfg.onDay.afk)) end
            if cfg.statTimers.dayFull then imgui.CenterTextColoredRGB("������ �� ����: " .. get_clock(cfg.onDay.full)) end
            if cfg.statTimers.weekOnline then
                imgui.CenterTextColoredRGB("�� ������ (������): " ..
                    get_clock(cfg.onWeek.online))
            end
            if cfg.statTimers.weekAfk then imgui.CenterTextColoredRGB("��� �� ������: " .. get_clock(cfg.onWeek.afk)) end
            if cfg.statTimers.weekFull then imgui.CenterTextColoredRGB("������ �� ������: " .. get_clock(cfg.onWeek.full)) end
        end
        imgui.PopStyleVar()
        if editpos and imgui.Button(u8 "���������", imgui.ImVec2(-1, 35)) then
            editpos = false
            settingsonline[0] = true
            cfg.pos.x, cfg.pos.y = pos.x, pos.y
            if not deliting_script then saveIni() end
            msg('������� ���� ���������!')
        end

        imgui.End()
        imgui.PopStyleVar()
        imgui.PopStyleColor(2)
    end)
imgui.OnFrame(function() return settingsonline[0] end,
    function()
        -- settings menu >>
        imgui.SetNextWindowSize(imgui.ImVec2(600 * MDS, 360 * MDS), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowPos(imgui.ImVec2(sX / 2, sY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8 '#Settings', settingsonline,
            imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse +
            imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoScrollbar)
        imgui.PushFont(fsClock)
        imgui.CenterTextColoredRGB('Timer Online')
        imgui.PopFont()
        imgui.BeginChild('##RadioButtons', imgui.ImVec2(190 * MDS, 280 * MDS), true)

        if imgui.RadioButtonBool(u8 '������� ���� � �����', Radio['clock']) then
            Radio['clock'] = not Radio['clock']; cfg.statTimers.clock = Radio['clock']
        end
        if imgui.RadioButtonBool(u8 '������ ������', Radio['sesOnline']) then
            Radio['sesOnline'] = not Radio['sesOnline']; cfg.statTimers.sesOnline = Radio['sesOnline']
        end
        imgui.Hint('##1234', u8 '��� ����� ��� (������ ������)')
        if imgui.RadioButtonBool(u8 'AFK �� ������', Radio['sesAfk']) then
            Radio['sesAfk'] = not Radio['sesAfk']; cfg.statTimers.sesAfk = Radio['sesAfk']
        end
        if imgui.RadioButtonBool(u8 '����� �� ������', Radio['sesFull']) then
            Radio['sesFull'] = not Radio['sesFull']; cfg.statTimers.sesFull = Radio['sesFull']
        end
        if imgui.RadioButtonBool(u8 '������ �� ����', Radio['dayOnline']) then
            Radio['dayOnline'] = not Radio['dayOnline']; cfg.statTimers.dayOnline = Radio['dayOnline']
        end
        imgui.Hint('##1233', u8 '��� ����� ��� (������ ������)')
        if imgui.RadioButtonBool(u8 '��� �� ����', Radio['dayAfk']) then
            Radio['dayAfk'] = not Radio['dayAfk']; cfg.statTimers.dayAfk = Radio['dayAfk']
        end
        if imgui.RadioButtonBool(u8 '����� �� ����', Radio['dayFull']) then
            Radio['dayFull'] = not Radio['dayFull']; cfg.statTimers.dayFull = Radio['dayFull']
        end
        if imgui.RadioButtonBool(u8 '������ �� ������', Radio['weekOnline']) then
            Radio['weekOnline'] = not Radio['weekOnline']; cfg.statTimers.weekOnline = Radio['weekOnline']
        end
        imgui.Hint('##123', u8 '��� ����� ��� (������ ������)')
        if imgui.RadioButtonBool(u8 '��� �� ������', Radio['weekAfk']) then
            Radio['weekAfk'] = not Radio['weekAfk']; cfg.statTimers.weekAfk = Radio['weekAfk']
        end
        if imgui.RadioButtonBool(u8 '����� �� ������', Radio['weekFull']) then
            Radio['weekFull'] = not Radio['weekFull']; cfg.statTimers.weekFull = Radio['weekFull']
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild('##Customisation', imgui.ImVec2(-1, 280 * MDS), true)
        if imgui.Checkbox(u8('##State'), to) then
            cfg.statTimers.state = to[0]
            if not deliting_script then saveIni() end
        end
        imgui.SameLine()
        if to[0] then
            imgui.TextColored(imgui.ImVec4(0.00, 0.53, 0.76, 1.00), u8 '��������')
        else
            imgui.TextDisabled(u8 '���������')
        end
        if imgui.Button(u8 '��������������', imgui.ImVec2(-1, 30 * MDS)) then
            editpos = true
            settingsonline[0] = false
            msg('����������� ����')
        end
        if cfg.statTimers.server == sampGetCurrentServerAddress() then
            if imgui.Button(u8(sampGetCurrentServerName()), imgui.ImVec2(-1, 30 * MDS)) then
                cfg.statTimers.server = nil
                msg('������ ���� ������ �� ��������� ��������!')
            end
        else
            if imgui.Button(u8 '���������� ���� ������ ��������', imgui.ImVec2(-1, 30 * MDS)) then
                cfg.statTimers.server = sampGetCurrentServerAddress()
                msg('������ ������ ����� ��������� ������ �� ���� �������!')
            end
            imgui.Hint('##1123', u8 '������ ����� ����������� ������ �� ���� �������!')
        end
        imgui.PushItemWidth(-1)
        if imgui.SliderFloat('##Round', sRound, 0.0, 10.0, u8 "���������� ����: %.2f") then
            cfg.style.round = sRound[0]
        end
        imgui.PopItemWidth()

        if imgui.ColorEdit4(u8 '##Fon', colorW, imgui.ColorEditFlags.NoInputs) then
            argbW = imgui.ColorConvertFloat4ToU32(
                imgui.ImVec4(colorW[0], colorW[1], colorW[2], colorW[3])
            )
            cfg.style.colorW = argbW
        end
        imgui.SameLine()
        imgui.Text(u8 '���� ����')
        if imgui.ColorEdit4(u8 '##Texta', colorT, imgui.ColorEditFlags.NoInputs) then
            argbT = imgui.ColorConvertFloat4ToU32(
                imgui.ImVec4(colorT[0], colorT[1], colorT[2], colorT[3])
            )
            cfg.style.colorT = argbT
        end
        imgui.SameLine()
        imgui.Text(u8 '���� ������')

        imgui.EndChild()
        if imgui.Button(u8 '��������� � �������', imgui.ImVec2(-1, 30 * MDS)) then
            if not deliting_script then saveIni() end 
        end
        imgui.End()
    end)
imgui.OnFrame(function() return myOnline[0] end,
    function()
    imgui.SetNextWindowSize(imgui.ImVec2(400 * MDS, 230 * MDS), imgui.Cond.FirstUseEver)
    imgui.SetNextWindowPos(imgui.ImVec2(sX / 2, sY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8 '#WeekOnline', _,
        imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse +
        imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
    imgui.SetCursorPos(imgui.ImVec2(15 * MDS, 10 * MDS))
    imgui.PushFont(fsClock)
    imgui.CenterTextColoredRGB('������ �� ������')
    imgui.PopFont()
    imgui.CenterTextColoredRGB('{0087FF}����� ��������: ' .. get_clock(cfg.onWeek.full))
    imgui.NewLine()
    for day = 1, 6 do -- �� -> ��
        imgui.Text(u8(tWeekdays[day])); imgui.SameLine(250 * MDS)
        imgui.Text(get_clock(cfg.myWeekOnline[day]))
    end
    --> ��
    imgui.Text(u8(tWeekdays[0])); imgui.SameLine(250 * MDS)
    imgui.Text(get_clock(cfg.myWeekOnline[0]))

    imgui.SetCursorPosX((imgui.GetWindowWidth() - 200 * MDS) / 2)
    if imgui.Button(u8 '�������', imgui.ImVec2(200 * MDS, 25 * MDS)) then myOnline[0] = false end
    imgui.End()
end)


function time()
    startTime = os.time() -- "����� �������"
    connectingTime = 0
    while true do
        wait(1000)
        nowTime = os.date("%H:%M:%S", os.time())
        if sampIsLocalPlayerSpawned() then                       -- ������� ������ ����� "��������� � �������" (��� �� ������ ������� ������, �����, �� ���������� � �������)
            sesOnline[0] = sesOnline[0] + 1                      -- ������ �� ������ ��� ����� ���
            sesFull[0] = os.time() - startTime                   -- ����� ������ �� ������
            sesAfk[0] = sesFull[0] - sesOnline[0]                -- ��� �� ������

            cfg.onDay.online = cfg.onDay.online + 1              -- ������ �� ���� ��� ����� ���
            cfg.onDay.full = dayFull[0] + sesFull[0]             -- ����� ������ �� ����
            cfg.onDay.afk = cfg.onDay.full - cfg.onDay.online    -- ��� �� ����

            cfg.onWeek.online = cfg.onWeek.online + 1            -- ������ �� ������ ��� ����� ���
            cfg.onWeek.full = weekFull[0] + sesFull[0]           -- ����� ������ �� ������
            cfg.onWeek.afk = cfg.onWeek.full - cfg.onWeek.online -- ��� �� ������

            local today = tonumber(os.date('%w', os.time()))
            cfg.myWeekOnline[today] = cfg.onDay.full

            connectingTime = 0
        else
            connectingTime = connectingTime + 1 -- ����� ����������� � �������
            startTime = startTime + 1           -- �������� ������ ������� ��������
        end
    end
end

function autoSave()
    while true do
        wait(60000) -- ���������� ������ 60 ������
        if not deliting_script then saveIni() end
    end
end

function number_week() -- ��������� ������ ������ � ����
    local current_time = os.date '*t'
    local start_year = os.time { year = current_time.year, day = 1, month = 1 }
    local week_day = (os.date('%w', start_year) - 1) % 7
    return math.ceil((current_time.yday + week_day) / 7)
end

function getStrDate(unixTime)
    local tMonths = { '������', '�������', '�����', '������', '���', '����', '����', '�������', '��������', '�������',
        '������', '�������' }
    local day = tonumber(os.date('%d', unixTime))
    local month = tMonths[tonumber(os.date('%m', unixTime))]
    local weekday = tWeekdays[tonumber(os.date('%w', unixTime))]
    return string.format('%s, %s %s', weekday, day, month)
end

function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400) .. '� ' or '') .. '%H:%M:%S', time + timezone_offset)
end
function timerMain()
    if cfg.statTimers.server ~= nil and cfg.statTimers.server ~= sampGetCurrentServerAddress() then
        msg('�� ����� �� ���� �� �������� ������. ������ ��������!')
        thisScript():unload()
    end
    if mainIni.settings.button then
        megafon[0] = true
    end
    if isPatrolActive then
        patrool_time = os.difftime(os.time(), patrool_start_time)
    end
    if cfg.onDay.today ~= os.date("%a") then
        cfg.onDay.today = os.date("%a")
        cfg.onDay.online = 0
        cfg.onDay.full = 0
        cfg.onDay.afk = 0
        dayFull[0] = 0
        if not deliting_script then saveIni() end
    end
    if cfg.onWeek.week ~= number_week() then
        cfg.onWeek.week = number_week()
        cfg.onWeek.online = 0
        cfg.onWeek.full = 0
        cfg.onWeek.afk = 0
        weekFull[0] = 0
        for _, v in pairs(cfg.myWeekOnline) do v = 0 end
        if not deliting_script then saveIni() end
    end

    lua_thread.create(time)
    lua_thread.create(autoSave)
end
-- Timer END

--Menu sizes START
local xsize         = imgui.new.int(mainIni.menuSettings.x)
local ysize         = imgui.new.int(mainIni.menuSettings.y)
local tabsize       = imgui.new.int(mainIni.menuSettings.tab)
local xpos          = imgui.new.int(mainIni.menuSettings.xpos)
local vtpos         = imgui.new.int(mainIni.menuSettings.vtpos)
local childRounding = imgui.new.int(mainIni.menuSettings.ChildRoundind)
imgui.OnFrame(function() return menuSizes[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(850, 300), imgui.Cond.FirstUseEver)
    imgui.Begin(u8 '��������� ����', menuSizes)
    imgui.SliderInt(u8 "������ ����", xsize, 200, 1000)
    imgui.SliderInt(u8 "������ ����", ysize, 200, 1000)
    imgui.SliderInt(u8 "������ ��� ����", tabsize, 100, 700)
    imgui.SliderInt(u8 "��������� ��������", xpos, 1, 1000)
    imgui.SliderInt(u8 "��������� ������� ���������� ����", vtpos, 1, 15)
    imgui.SliderInt(u8 "����������� ���� � �������(����� ����� ������������� ������)", childRounding, 0, 25)
    --����
    if imgui.Combo(u8 '����', selected_theme, items, #theme_a) then
        themeta = theme_t[selected_theme[0] + 1]
        mainIni.theme.themeta = themeta
        mainIni.theme.selected = selected_theme[0]
        if not deliting_script then saveIni() end
        apply_n_t()
    end
    imgui.Text(u8 '���� MoonMonet - ')
    imgui.SameLine()
    if imgui.ColorEdit3('## COLOR', mmcolor, imgui.ColorEditFlags.NoInputs) then
        r, g, b = mmcolor[0] * 255, mmcolor[1] * 255, mmcolor[2] * 255
        argb = join_argb(0, r, g, b)
        mainIni.theme.moonmonet = argb
        if not deliting_script then saveIni() end
        apply_n_t()
    end
    --����� ���
    mainIni.menuSettings.x = xsize[0]
    mainIni.menuSettings.y = ysize[0]
    mainIni.menuSettings.tab = tabsize[0]
    mainIni.menuSettings.xpos = xpos[0]
    mainIni.menuSettings.vtpos = vtpos[0]
    mainIni.menuSettings.ChildRoundind = childRounding[0]
    if imgui.Button(u8 "���������") then
        if not deliting_script then saveIni() end
    end
    imgui.End()
end)
--Menu sizes END

--Vzaim menu START
function get_players_in_radius()
    local playersInRadius = {}
    for _, h in pairs(getAllChars()) do
        local temp2, id = sampGetPlayerIdByCharHandle(h)
        temp3, m = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local id = tonumber(id)
        if id ~= -1 and id ~= m and doesCharExist(h) then
            local x, y, z = getCharCoordinates(h)
            local mx, my, mz = getCharCoordinates(PLAYER_PED)
            local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
            if dist <= 3 then
                table.insert(playersInRadius, id)
            end
        end
    end
    return playersInRadius
end
imgui.OnFrame(function() return vzWindow[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 2.3), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.Begin(u8 '', vzWindow,
        imgui.WindowFlags.NoResize + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoTitleBar)
    if imgui.Button(u8 "��������������") then
        if #get_players_in_radius() == 1 then
            id = imgui.new.int(get_players_in_radius()[1])
            fastVzaimWindow[0] = true
            vzWindow[0] = false
        elseif #get_players_in_radius() > 1 then
            vzaimWindow[0] = true
            vzWindow[0] = false
        end
    end
    imgui.End()
end)


imgui.OnFrame(function() return vzaimWindow[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(850, 500), imgui.Cond.FirstUseEver)
    imgui.Begin(u8 '��������������', vzaimWindow)
    imgui.Text(u8 "�������� ������ ��� ��������������")
    for i = 1, #get_players_in_radius() do
        if imgui.Button(u8(sampGetPlayerNickname(get_players_in_radius()[i]))) then
            id = imgui.new.int(get_players_in_radius()[i])
            fastVzaimWindow[0] = true
            vzaimWindow[0] = false
        end
    end
    imgui.End()
end)

imgui.OnFrame(function() return fastVzaimWindow[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(850, 500), imgui.Cond.FirstUseEver)
    imgui.Begin(u8 '�������������� � ' .. sampGetPlayerNickname(id[0]), fastVzaimWindow)
    if imgui.Button(u8 '�����������') then
        lua_thread.create(function()
            sampSendChat("������� ������� �����, � �" .. nickname .. "� �" .. u8:decode(mainIni.Info.dl) .. "�.")
            wait(1500)
            sampSendChat("/do ������������� � �����.")
            wait(1500)
            sendMe(" ������� ��� ������������� �������� �� ������")
            wait(1500)
            sampSendChat("/do �" .. nickname .. "�.")
            wait(1500)
            sampSendChat("/do �" .. u8:decode(mainIni.Info.dl) .. "� " .. mainIni.Info.org .. ".")
            wait(1500)
            sampSendChat("���������� ���� ���������, � ������ �������. �� ������������, ��� ����� ���� ��������.")
            wait(1500)
            sampSendChat("/showbadge ")
        end)
    end
    if imgui.Button(u8 '����� ������') then
        lua_thread.create(function()
            sampSendChat("/do ��� � ����� �������.")
            wait(1500)
            sendMe(" ������ ����� ����� ��� �� �������")
            wait(1500)
            sampSendChat("/do ��� � ����� ����.")
            wait(1500)
            sendMe(" ������� ��� � ����� � ���� ������ �������")
            wait(1500)
            sendMe(" ������ ���� ����� " .. id[0] .. " �����������")
            wait(1500)
            sampSendChat("/do ������ ����������� ��������.")
            wait(1500)
            sendMe(" ����������� � ������� �������� �����")
            wait(1500)
            sampSendChat("/do �� ���������� �������� �������.")
            wait(1500)
            sampSendChat("/pursuit " .. id[0])
        end)
    end
    if imgui.Button(u8 '�����') then
        lua_thread.create(function()
            sendMe(" ���� ����� �� ������� �������, ����� ������ �������� � ���� ������ ����� ���������")
            wait(1500)
            sampSendChat("/do ����� ��������� � ����� � �����.")
            wait(1500)
            sendMe(" ��������� �������� ��������� ����������")
            wait(1500)
            sendMe(" ��������� �������������� � ����������")
            wait(1500)
            sendMe(" ��������� ������ � ���������")
            wait(1500)
            sendMe(" ��������� ���� � �������")
            wait(1500)
            sendMe(" ������� ����� � ������ �������")
            wait(1500)
            sampSendChat("/do ����� � ������� �������.")
            wait(1500)
            sendMe(" ������� ����� ������������� ��������� � �������")
            wait(1500)
            sendMe(" ������� ����������� � ���������� ������� ��� ������")
            wait(1500)
            sampSendChat("/arrest")
            msg("�������� �� ��������", 0x8B00FF)
        end)
    end
    if imgui.Button(u8 '������ ���������') then
        lua_thread.create(function()
            sampSendChat("/do ��������� ����� �� �����.")
            wait(1500)
            sendMe(" ���� � ��������� ���������")
            wait(1500)
            sampSendChat("/do ��������� � �����.")
            wait(1500)
            sendMe(" ������ ��������� ����� ���, ����� ��������� �� �����������")
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
            sendMe(" ��������� ������ ���� ������ �� ������� ���� � ������ ���������")
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
            sendMe(" ����� ���������� �� �����")
            wait(1500)
            sampSendChat("/gotome " .. id[0])
        end)
    end
    if imgui.Button(u8 '��������� ����� �� �����') then
        lua_thread.create(function()
            sendMe(" �������� ������ ���� �����������")
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
            sendMe(" ������ ������ ����� � ������")
            wait(1500)
            sendMe(" ������� ����������� � ������")
            wait(1500)
            sendMe(" ������������ �����")
            wait(1500)
            sampSendChat("/do ����� �������������.")
            wait(1500)
            sampSendChat("/incar " .. id[0] .. "3")
        end)
    end
    if imgui.Button(u8 '�����') then
        lua_thread.create(function()
            sendMe(" ������ ������ � �������, ������� ������ ����� �������� � ������� �� �� ����")
            wait(1500)
            sampSendChat("/do �������� ������.")
            wait(1500)
            sendMe(" �������� ������ �� ������� ����� ����")
            wait(1500)
            sendMe(" ��������� �������")
            wait(1500)
            sendMe(" �������� ������ �� �����")
            wait(1500)
            sampSendChat("/frisk " .. id[0])
        end)
    end
    if imgui.Button(u8 '�������') then
        lua_thread.create(function()
            sampSendChat("/do ������� � ��������.")
            wait(1500)
            sendMe(" ������ ������� � �������� ����� ���� ������� ���")
            wait(1500)
            sampSendChat("/m �������� ����, ������������ � ��������� ���������, ������� ���� �� ����.")
        end)
    end
    if imgui.Button(u8 '�������� �� ����') then
        lua_thread.create(function()
            sendMe(" ���� ������� � �������� ��������� ������ ������ � ����������")
            wait(1500)
            sampSendChat("/do ������ �������.")
            wait(1500)
            sendMe(" ������� �� ����� �������� ������ ��� ����� ���� ����� ���������")
            wait(1500)
            sampSendChat("/pull " .. id[0])
            wait(1500)
            sampSendChat("/cuff " .. id[0])
        end)
    end
    if imgui.Button(u8 '������ �������') then
        windowTwo[0] = not windowTwo[0]
    end
    imgui.End()
end)
--Vzaim menu END

--RP guns START

local selectedGun = nil

imgui.OnFrame(function() return gunsWindow[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(850, 500), imgui.Cond.FirstUseEver)
    imgui.Begin(u8 '��������� ��������� ������', gunsWindow)
    imgui.Text(u8 "�������� ������")

    for i = 1, #weapons do
        if imgui.Button(u8(weapons[i])) then
            selectedGun = i

            local command = gunCommands[i]
            otInput = imgui.new.char[255](u8(command))
            msg("������� ������: " .. weapons[i] .. " �������: " .. command)
        end
        if selectedGun ~= nil and selectedGun ~= "" and selectedGun == i then
            imgui.SameLine()
            imgui.Text(u8("�� ������� " .. weapons[selectedGun]))
            imgui.InputText(u8 "���������", otInput, 255)
            if imgui.Button(u8 "���������", imgui.ImVec2(100, 50)) then
                gunCommands[selectedGun] = ffi.string(otInput)
                saveCommands()
                msg("��������� ���������")
            end
        end
    end

    imgui.End()
end)
--RP guns END

--Notes START
function loadNotesFromFile()
    local file = io.open("MVDHelper/notes.json", "r")
    if file then
        local jsonData = file:read("*all")
        notes = decodeJson(jsonData) or {}
        file:close()
    else
        saveNotesToFile()
    end
end

function saveNotesToFile()
    local file = io.open("MVDHelper/notes.json", "w")
    if file then
        local jsonData = encodeJson(notes)
        file:write(jsonData)
        file:close()
    end
end
function allNotes() 
    for i, note in ipairs(notes) do
        imgui.Text(note.title)
        imgui.SameLine()
        if imgui.Button(u8 "�������##" .. i) then
            note_name = note.title
            note_text = note.content
            NoteWindow[0] = true
        end
        imgui.SameLine()
        if imgui.Button(u8 "�������������##" .. i) then
            selectedNote = i
            imgui.StrCopy(editNoteTitle, note.title)
            imgui.StrCopy(editNoteContent, note.content)
            imgui.OpenPopup(u8 "������������� �������")
            showEditWindow[0] = true
        end
        imgui.SameLine()
        if imgui.Button(u8 "�������##" .. i) then
            table.remove(notes, i)
            saveNotesToFile()
        end
    end
end

imgui.OnFrame(
    function() return NoteWindow[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(note_name, NoteWindow, imgui.WindowFlags.AlwaysAutoResize)
        imgui.Text(note_text:gsub('&', '\n'))
        imgui.Separator()
        if imgui.Button(u8 ' �������', imgui.ImVec2(imgui.GetMiddleButtonX(1), 25 * MONET_DPI_SCALE)) then
            NoteWindow[0] = false
        end
        imgui.End()
    end
)
--Notes END

--Sobes menu START
local namesobeska     = imgui.new.char[256](u8 '����������')
local rabotaet        = false
local rabota          = imgui.new.char[256]()
local let_v_shtate    = false
local goda            = imgui.new.char[256]()
local zakonoposlushen = false
local zakonka         = imgui.new.int(0)
local narkozavisim    = false
local narkozavisimost = imgui.new.char[256]()
local cherny_spisok   = false
local voenik          = false
local lic_na_avto     = false
local chatsobes       = {}
local sobesmessage    = imgui.new.char[256]()
local select_id       = imgui.new.int(1)
local sobes           = {
    pass = u8 '�� ���������',
    mc = u8 '�� ���������',
    lic = u8 '�� ���������'
}
local pages1          = {
    { icon = faicons("GEAR"), title = u8 "�������", index = 1 },
    { icon = faicons("BOOK"), title = u8 "���� �����", index = 2 },
}
imgui.OnFrame(
    function() return leaderPanel[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(910 * MDS, 480 * MDS), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "������ ����������� ��������", leaderPanel)
        imgui.BeginChild('tabs', imgui.ImVec2(173 * MDS, -1), true)
        imgui.CenterText(u8('MVD Helper v' .. thisScript().version))
        imgui.Separator()
        for _, pageData in ipairs(pages1) do
            imgui.SetCursorPosX(0)
            if imgui.PageButton(menu2 == pageData.index, pageData.icon, pageData.title, 173 * MDS - imgui.GetStyle().FramePadding.x * 2, 35 * MDS) then
                menu2 = pageData.index
            end
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild('workspace', imgui.ImVec2(-1, -1), true)
        if menu2 == 1 then
            if imgui.CollapsingHeader(u8 '������') then
                if imgui.Button(u8 '����� � ����������') then
                    lua_thread.create(function()
                        sampSendChat("������������ ��������� ���������� ������ ������������!")
                        wait(1500)
                        sampSendChat("������ ����� ��������� ������ �� ���� ����� � ���������� ������������.")
                        wait(1500)
                        sampSendChat("��� ������ ������� �������� ����� ����������� � �������.")
                        wait(1500)
                        sampSendChat(
                            "���������� - ��� ��������������� ������� ������� ����, �������������� � ���������� ������������.")
                        wait(1500)
                        sampSendChat(
                            "� ���� �������, ����� - ��� ��� ���������� ���������, �������������� � ���������� ������������ ������������..")
                        wait(1500)
                        sampSendChat("..� ���������� �� ��������� ���� � �������� ������� �������� �� ��������.")
                        wait(1500)
                        sampSendChat("��� ��������� ����������� ���� �� ������ 48 ����� � ������� �� ����������.")
                        wait(1500)
                        sampSendChat(
                            "���� � ������� 48 ����� �� �� ���������� �������������� ����, �� ������� ��������� ����������.")
                        wait(1500)
                        sampSendChat("�������� ��������, ��������� ����� ������ �� ��� ��� �� ���������� ����������.")
                        wait(1500)
                        sampSendChat(
                            "�� ����� ���������� �� ������� �������� ��������� ����� �� ����� ���������� � ��������� � ������ ������ ����������.")
                        wait(1500)
                        sampSendChat(
                            "��� ��������� ���� �������� � 'ZIP-lock', ��� � ��������� ��� ���. �����, ��� ������ ���� ����������� �������� � ����� ��� ������ ����� ������������")
                        wait(1500)
                        sampSendChat("�� ���� ������ ������ �������� � �����. � ����-�� ������� �������?")
                    end)
                end
                if imgui.Button(u8 "�������������") then
                    lua_thread.create(function()
                        sampSendChat(" ��������� ���������� ������������ ������������!")
                        wait(1500)
                        sampSendChat(" ����������� ��� �� ������ � ������������")
                        wait(1500)
                        sampSendChat(" ��� ������ ��������, ��� ����� ������������")
                        wait(1500)
                        sampSendChat(
                            " ������������ - ������� ���������� ������� �� ������ � ������� �� ������, ��������, ��������� � ���")
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
                if imgui.Button(u8 "������� ��������� � �����.") then
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
                if imgui.Button(u8 '������') then
                    lua_thread.create(function()
                        sampSendChat(
                            " ������������ ��������� ���������� ������������ �������, � ������� ������ �� ���� ������ ��������������.")
                        wait(1500)
                        sampSendChat(" ��������� �� ������ ������� ����������������, �������������;")
                        wait(1500)
                        sampSendChat(
                            " ��������� �� ������ ��������� ��������� ����������, ��������, ��� ��������, ������, ���������, ����� ����������;")
                        wait(1500)
                        sampSendChat(
                            " ��������� �� ������ ��������, ��� �� ����� (������� ���������� �������, ��� �� ���-�� �������, �� �������� �� ��� ������);")
                        wait(1500)
                        sampSendChat(
                            " ���� ������������� ��� �������� �� ������, ���������� ������ �� ��� �� ������� ������;")
                        wait(1500)
                        sampSendChat(" � ����� ������� ����������� ������� ������� ����������.")
                        wait(1500)
                        sampSendChat(
                            " ��� ��������� ��������, ���������� ��������� ����� �������� ���� �������������� (���������� ��� �������, �� ��� �� ����� �������);")
                        wait(1500)
                        sampSendChat(
                            " ��� ��������� ��������, �� ����� �������� � ���������� � ���������� �������� (���������, ���������� ���������, ��������� ���� ��� ����, ������������ ���������, ����������, ������������� �������� ���������� � ���� ��������).")
                        wait(1500)
                        sampSendChat(
                            " �� ���� ������ ������� � �����, ���� � ����-�� ���� �������, ������ �� ����� �� ������ ������ (���� ������ ������, �� ����� �������� �� ����)")
                    end)
                end
                if imgui.Button(u8 "������� ��������� �� � �� ����� ������ �� �����������.") then
                    lua_thread.create(function()
                        sampSendChat(
                            " ������ ����, ������ � ������� ��� ������ �� ���� ������� ��������� �� � �� ����� ������ �� �����������")
                        wait(1500)
                        sampSendChat(" � �����, ����� �������, �� ������ ����������� ������� ��, ��� ������� ��� ������")
                        wait(1500)
                        sampSendChat(" ������������ �������, ������� ���������, ��� ��� ���� � ��� ������� ���������")
                        wait(1500)
                        sampSendChat(" �� ���� � ������������, ��������� � �������� ������, ��� ������� �� �����")
                        wait(1500)
                        sampSendChat(
                            " ������� �� ���������� �������, ����� ��������� ��������� ���, ����� ���������� ��� ��������� ���� � ����������� ������ �������")
                        wait(1500)
                        sampSendChat(
                            " ����� ������ ���������� �������� ��, ��� ������, ����� �������, ��������� ��������� � ������, � ��� ����� �� ��������")
                        wait(1500)
                        sampSendChat(" ��������� ������� ������ ������ ������������, ������ �� ����������")
                        wait(1500)
                        sampSendChat(" ��� �� ������� �� �����, �� �� ���������� ������ �� ����, ���� �����")
                        wait(1500)
                        sampSendChat(
                            " ��������� ����� �� ������������ ����������� ������ � ��� ������, ���� �� ��������� �� ��� �������, ����� ��������� ��� ��� �������� ��������� �����")
                        wait(1500)
                        sampSendChat(" ��� ������ ����. �������� �������������, ��� ��������� ���������")
                        wait(1500)
                        sampSendChat(" �� ���� ������ ��������, ���� �������")
                    end)
                end
                if imgui.Button(u8 "������� �������.") then
                    lua_thread.create(function()
                        sampSendChat("������� ������� � ����������� ���������� � ���")
                        wait(1500)
                        sampSendChat(
                            "�������� �������� �� ����� ���������� ������������� ������ ���� ��������� � ����� ������.")
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
                        sampSendChat(
                            "- ���� �� �� ������ �������� ������ ��������, �� ����� ������������ ��� ������������.")
                        wait(1500)
                        sampSendChat("- �� ��������� ���� �����?")
                    end)
                end
                if imgui.Button(u8 "������ ������.") then
                    lua_thread.create(function()
                        sampSendChat("��� ������ ����������� ��� � ������������")
                        wait(1500)
                        sampSendChat("����, � ������������� ������������, �� ���������� ���������� ����� ����� ������")
                        wait(1500)
                        sampSendChat(
                            "���� ������� ��������� ���������� ������� ����� ������ ������ � ���������� ���� ������")
                        wait(1500)
                        sampSendChat(
                            "���� � ���� ����, � ���� �� ��������, �� ������ ������� ������ ���� �������� �� ����������, ��������� ����� ��������� � ������� ������ ������")
                        wait(1500)
                        sampSendChat("���� ������� ��� �������� ��� ����� ... ")
                        wait(1500)
                        sampSendChat(
                            " ... ������� �� ����� ������ ������ ���� � �����, ����� �������� ���� ������� ... ")
                        wait(1500)
                        sampSendChat(
                            " ... � �������� ������ �� ������� ����� ���� �������������, � ���� ������, �� ������ ��������")
                        wait(1500)
                        sampSendChat("�� ���� ������ ��������. � ����-�� ���� ������� �� ������ ������?")
                        wait(1500)
                    end)
                end
            end
            imgui.InputInt(u8 'ID ������ � ������� ������ �����������������', id, 10)
            if imgui.Button(u8 '������� ����������') then
                lua_thread.create(function()
                    sampSendChat("/do ��� ����� �� �����.")
                    wait(1500)
                    sendMe(" ���� ��� � ����� � ����� � ��������� ����������")
                    wait(1500)
                    sendMe(" ����� � ������ ���������� � ����� �� ������ �������")
                    wait(1500)
                    sampSendChat("/do �� ��� ����������� ������� '��������� ������� ������!'")
                    wait(1500)
                    sendMe(" �������� ��� � ������� ������� �� ����")
                    wait(1500)
                    sampSendChat("�� ��� �, �� ��������. �������� ������ � ���� ��������.")
                    wait(1500)
                    sampSendChat("/uninvite" .. id[0])
                end)
            end

            if imgui.Button(u8 '������� ����������') then
                lua_thread.create(function()
                    sampSendChat("/do ��� ����� �� �����.")
                    wait(1500)
                    sendMe(" ���� ��� � ����� � ����� � ��������� ����������")
                    wait(1500)
                    sendMe(" ����� � ������� � ���� ������ � ����� ����������")
                    wait(1500)
                    sampSendChat(
                        "/do �� ��� ����������� �������: '��������� ������� ��������! ��������� ��� ������� ������ :)'")
                    wait(1500)
                    sendMe(" �������� ��� � ������� ������� �� ����")
                    wait(1500)
                    sampSendChat("����������, �� �������! ����� �������� � ����������.")
                    wait(1500)
                    sampSendChat("/invite" .. id[0])
                end)
            end

            if imgui.Button(u8 '������ ������� ����������') then
                lua_thread.create(function()
                    sampSendChat("/do ��� ����� �� �����.")
                    wait(1500)
                    sendMe(" ���� ��� � ����� � ����� � ��������� ����������")
                    wait(1500)
                    sendMe(" ����� � ������ ���������� � ����� �� ������ ������ �������")
                    wait(1500)
                    sampSendChat("/do �� ��� ����������� �������: '������� �����!'")
                    wait(1500)
                    sendMe(" �������� ��� � ������� ������� �� ����")
                    wait(1500)
                    sampSendChat("�� ��� �, ������� �����. �������������.")
                    wait(1500)
                    sampSendChat("/fwarn" .. id[0])
                end)
            end

            if imgui.Button(u8 '����� ������� ����������') then
                lua_thread.create(function()
                    sampSendChat("/do ��� ����� �� �����.")
                    wait(1500)
                    sendMe(" ���� ��� � ����� � ����� � ��������� ����������")
                    wait(1500)
                    sendMe(" ����� � ������ ���������� � ����� �� ������ ����� �������")
                    wait(1500)
                    sampSendChat("/do �� ��� ����������� �������: '������� ����!'")
                    wait(1500)
                    sendMe(" �������� ��� � ������� ������� �� ����")
                    wait(1500)
                    sampSendChat("�� ��� �, ����������.")
                    wait(1500)
                    sampSendChat("/unfwarn" .. id[0])
                end)
            end
        elseif menu2 == 2 then
            imgui.Text(u8("������� id ������:"))
            imgui.SameLine()
            imgui.PushItemWidth(200)
            imgui.InputInt("                ##select id for sobes", select_id)
            namesobeska = sampGetPlayerNickname(select_id[0])
            if namesobeska then
                imgui.Text(u8(namesobeska))
            else
                imgui.Text(u8 '����������')
            end
            imgui.Separator()
            imgui.BeginChild('sobesvoprosi', imgui.ImVec2(-1, 143 * MONET_DPI_SCALE), true)
            if imgui.Button(u8 " ������ �������������", imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
                sampSendChat("������������, �� ������ �� �������������?")
            end
            imgui.SameLine()
            if imgui.Button(u8 " ��������� ���������", imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
                lua_thread.create(function()
                    sampSendChat("�������, ������������ ��� �������, ���. ����� � ��������.")
                    wait(1000)
                    sampSendChat(
                        "/b ����� �������� ������������ �������: /showpass - �������, /showmc - ���.�����, /showlic - ���������")
                    wait(2000)
                    sampSendChat("/b �� ������ ���� �����������!")
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8 " ���������� � ����", imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
                lua_thread.create(function()
                    sampSendChat("������, ������ � ����� ���� ��������.")
                    wait(2000)
                    sampSendChat("���������� � ����.")
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8 " ������ ������ ��?", imgui.ImVec2(imgui.GetMiddleButtonX(4), 0)) then
                sampSendChat("������ �� ������� ������ ��� �����������?")
            end
            imgui.Separator()
            imgui.Columns(3, nil, false)
            imgui.Text(u8 '�������: ' .. sobes['pass'])
            imgui.Text(u8 '���.�����: ' .. sobes['mc'])
            imgui.Text(u8 '��������: ' .. sobes['lic'])
            imgui.NextColumn()
            imgui.Text(u8 "��� � �����:")
            imgui.SameLine()
            if let_v_shtate then
                imgui.Text(goda)
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������")
            end
            imgui.Text(u8 "�������:")
            imgui.SameLine()
            if zakonoposlushen then
                imgui.Text(zakonka)
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������")
            end
            imgui.Text(u8 "���. �� ����:")
            imgui.SameLine()
            if lic_na_avto then
                imgui.Text(u8 "����")
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������/����")
            end
            imgui.Text(u8 "�������:")
            imgui.SameLine()
            if voenik then
                imgui.Text(u8 "����")
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������/����")
            end
            imgui.NextColumn()
            imgui.Text(u8 "�����������:")
            imgui.SameLine()
            if narkozavisim then
                imgui.Text(narkozavisimost)
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������")
            end
            imgui.Text(u8 "��������:")
            imgui.SameLine()
            imgui.Text(tostring(sampGetPlayerHealth(select_id[0])))
            imgui.Text(u8 "������ ������:")
            imgui.SameLine()
            if cherny_spisok then
                imgui.Text(u8('����'))
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������/����")
            end
            imgui.Text(u8 "��������:")
            imgui.SameLine()
            if rabotaet then
                imgui.Text(u8(str(rabota)))
            else
                imgui.TextColored(imgui.ImVec4(1, 0, 0, 1), u8 "����������")
            end
            imgui.EndChild()
            imgui.Columns(1)
            imgui.Separator()

            imgui.Text(u8 "��������� ���")
            imgui.BeginChild("ChatWindow", imgui.ImVec2(0, 100), true)
            for i, v in pairs(chatsobes) do
                imgui.Text(u8(v))
            end
            imgui.EndChild()

            imgui.PushItemWidth(800)
            imgui.InputText("##input", sobesmessage, 256)
            imgui.SameLine()
            if imgui.Button(u8 "���������") then
                sampSendChat(u8:decode(str(sobesmessage)))
            end
            imgui.PopItemWidth()

            imgui.Separator()
            if imgui.Button(u8 " ������������� ��������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
                lua_thread.create(function()
                    sampSendChat("/todo ����������! �� ������ �������������!* � ������� �� ����")
                    wait(2000)
                    sampSendChat('/invite ' .. select_id[0])
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8 "���������� �������������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 0)) then
                select_id[0] = -1
                sobes_1 = {
                    false,
                    false,
                    false
                }

                sobes = {
                    pass = u8 '�� ���������',
                    mc = u8 '�� ���������',
                    lic = u8 '�� ���������'
                }
                chatsobes = {}
                voenik = false
                lic_na_avto = false
                cherny_spisok = false
                narkozavisim = false
                zakonoposlushen = false
                rabotaet = false
                let_v_shtate = false
            end
        end
        imgui.EndChild()
        imgui.End()
    end
)
--Sobes menu END

--Smart UK START
imgui.OnFrame(
    function() return setUkWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(900, 700), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "��������� ������ �������", setUkWindow)

        if imgui.Button(u8 '������� �� ��� ������ �������') then
            DownloadUk()
        end
        if imgui.Button(u8 "������� �� ��� ������ �������") then
            importUkWindow[0] = not importUkWindow[0]
        end
        if imgui.BeginChild('Name', imgui.ImVec2(0, imgui.GetWindowSize().y - 36 - imgui.GetCursorPosY() - imgui.GetStyle().FramePadding.y * 2), true) then
            for i = 1, #tableUk["Text"] do
                imgui.Text(u8(tableUk["Text"][i] .. ' ������� �������: ' .. tostring(tableUk["Ur"][i])))
                Uk = #tableUk["Text"]
            end
            imgui.EndChild()
        end
        if imgui.Button(u8 '��������', imgui.ImVec2(GetMiddleButtonX(2), 36)) then
            addUkWindow[0] = not addUkWindow[0]
        end
        imgui.SameLine()
        if imgui.Button(u8 '�������', imgui.ImVec2(GetMiddleButtonX(2), 36)) then
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

imgui.OnFrame(
    function() return addUkWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "��������� ������ �������", addUkWindow)
        imgui.InputText(u8 '����� ������(� �������.)', newUkInput, 255)
        newUkName = u8:decode(ffi.string(newUkInput))
        imgui.InputInt(u8 '������� �������(������ �����)', newUkUr, 10)
        if imgui.Button(u8 '���������') then
            Uk = #tableUk["Text"]
            tableUk["Text"][Uk + 1] = newUkName
            tableUk["Ur"][Uk + 1] = newUkUr[0]
            encodedTable = encodeJson(tableUk)
            local file = io.open("smartUk.json", "w")
            file:write(encodedTable)
            file:flush()
            file:close()
        end
        imgui.End()
    end
)

local importUkFrame = imgui.OnFrame(
    function() return importUkWindow[0] end,
    function() return true end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "������ ������ �������", importUkWindow)
        local file = io.open(getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/smartUk.json", "r")
        a = file:read("*a")
        file:close()
        tableUk = decodeJson(a)
        for _, serverName in ipairs(serversList) do
            if imgui.Button(u8(serverName)) then
                local serverKey = string.lower(string.gsub(serverName, " ", "-"))
                local url = smartUkUrl[serverKey]
                if url then
                    downloadFile(url, smartUkPath)
                    msg(string.format("{FFFFFF} ����� ������ �� %s ������� ����������!", serverName), 0x8B00FF)
                else
                    msg(string.format("{FFFFFF} � ���������, �� ������ %s �� ������ ����� ������. �� ����� �������� � ��������� �����������", serverName), 0x8B00FF)
                end
                break
            end
        end
    end
)
--Smart UK END

--Patrul START
function startPatrul()
    startTime = os.time()
    isPatrolActive = true
end

function getPatrolDuration()
    local elapsedSeconds = os.time() - startTime
    local minutes = math.floor(elapsedSeconds / 60)
    local seconds = elapsedSeconds % 60
    return string.format("%02d:%02d", minutes, seconds)
end

function formatPatrolDuration(seconds)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60

    if minutes > 0 then
        return string.format("%d ����� %d ������", minutes, secs)
    else
        return string.format("%d ������(-�)", secs)
    end
end

imgui.OnFrame(
    function() return patroolhelpmenu[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY - 100 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver,
            imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(225 * MONET_DPI_SCALE, 113 * MONET_DPI_SCALE), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 " ##patrol_menu", patroolhelpmenu,
            imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)

        if isPatrolActive then
            imgui.Text(u8(' ����� ��������������: ') .. u8(getPatrolDuration()))
            imgui.Separator()
            if imgui.Button(u8('������'), imgui.ImVec2(100 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                lua_thread.create(function()
                    sampSendChat('/r' .. nickname .. ' �� CONTROL. ��������� �������')
                end)
            end
            imgui.SameLine()
            if imgui.Button(u8('���������'), imgui.ImVec2(100 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                lua_thread.create(function()
                    isPatrolActive = false
                    sampSendChat('/r ' .. nickname .. ' �� CONTROL. �������� �������')
                    wait(1200)
                    sampSendChat('/r ������������ ' .. formatPatrolDuration(os.time() - startTime))
                    patrolDuration = 0
                    patrool_start_time = 0
                    patroolhelpmenu[0] = false
                end)
            end
        else
            if imgui.Button(u8(' ������ �������'), imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                sampSendChat('/r ' .. nickname .. ' �� CONTROL. ������� �������.')
                startPatrul()
            end
        end

        imgui.End()
    end
)
--Patrul END

--Window buttons START
function addNewButton(name, text)
    if not buttons then
        buttons = readButtons()
    end 
    local linesArray = {}
    for line in text:gmatch("[^\r\n]+") do
        table.insert(linesArray, line)
    end
    buttons[name] = {}
    for i = 1, #linesArray do
        table.insert(buttons[name], linesArray[i])
    end
    local file = io.open(buttonsJson, "w")
    file:write(encodeJson(buttons))
    print(buttons)
    file:close()
end 

function loadButtons()
    if not buttons then
        buttons = readButtons()
    end
    local _ = imgui.new.bool(true)
    imgui.OnFrame(function() return _ end, function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 2.1), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(250, 250), imgui.Cond.FirstUseEver)
        imgui.Begin("pon", _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoMove)
        for name, text in pairs(buttons) do
            if imgui.Button(u8(name)) then
                lua_thread.create(function()
					for i = 1, #text do
						sampSendChat (text[i])
						wait(1500)
					end
				end)
            end
            imgui.SameLine()
        end
        
        imgui.End()
    end)
end

function deleteButton(name)
    buttons[name] = nil
    local file = io.open(buttonsJson, "w")
    file:write(encodeJson(buttons))
    print(buttons)
    file:close()
end

function arrayToText(array)
    local result = ""
    for i = 1, #array do
        result = result .. array[i]
        if i < #array then
            result = result .. "\n"
        end
    end
    return result
end
--Window buttons END

--CEF START
function onReceivePacket(id, bs, ...) 
    if id == 220 then
        raknetBitStreamIgnoreBits(bs, 8) 
        local type = raknetBitStreamReadInt8(bs)
        if type == 84 then
            local interfaceid = raknetBitStreamReadInt8(bs)
            local subid = raknetBitStreamReadInt8(bs)
            local len = raknetBitStreamReadInt16(bs) 
            local encoded = raknetBitStreamReadInt8(bs)
            local json = (encoded ~= 0) and raknetBitStreamDecodeString(bs, len + encoded) or raknetBitStreamReadString(bs, len)
            if interfaceid ==104 and subid == 2 then
                local json = decodeJson(json)
                if json["level"] then
                    sobes['pass'] = u8 "���������"
                    getPlayerPass(json)
                end
            end
        end
    end
end
--CEF END

--Other function START
function sendMe(text)
    if tochkaMe[0] then
        sampSendChat("/me" .. text .. ".")
    else
        sampSendChat("/me" .. text)
    end
end
function spcars(arg)
    if arg == "" then
        msg("�����������: /spcars (5 - 120)", -1)
    else
        lua_thread.create(function()
            sampSendChat("/rb ��������� ����������, ����� " .. arg .. " ������ ����� ����� ����� ���������� �����������!")
            wait(1000)
            sampSendChat("/rb ������� ���� ���������, � ��������� ������ �� ��������!")
            wait(arg * 1000)
            spawncar_bool = true
            sampSendChat("/lmenu")
        end)
    end
end

function cmd_su(p_id)
    if p_id == "" then
        msg("����� ���� ������: {FFFFFF}/su [ID].", 0x318CE7FF - 1)
    else
        id = imgui.new.int(tonumber(p_id))
        windowTwo[0] = not windowTwo[0]
    end
end
function getFilesInPath()
    local Files = {}
    for i = 1, 2 do
        table.insert(Files, getWorkingDirectory():gsub('\\','/') .. '/arzfun/' .. i .. '.png')
    end
    return Files
end
function getPlayerPass(json)
    let_v_shtate    = true
    local godashtat = json["level"]
    zakonoposlushen = true
    zakonka         = json["zakono"]
    rabotaet        = true
    local rabotka   = json["job"]
    imgui.StrCopy(rabota, rabotka)
    imgui.StrCopy(goda, godashtat)
end
function GetMiddleButtonX(count)
    local width = imgui.GetWindowContentRegionWidth()
    local space = imgui.GetStyle().ItemSpacing.x
    return count == 1 and width or width / count - ((space * (count - 1)) / count)
end

function calculateZone(x, y, z)
    local streets = {
        { "���������� ���� �������", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169 },
        { "������������� �������� �����-���", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406 },
        { "���������� ���� �������", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700 },
        { "������������� �������� �����-���", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406 },
        { "������", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000 },
        { "�����-�����", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000 },
        { "��������� ���-������", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916 },
        { "�������� ���� ���-���������", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916 },
        { "����������� ��������", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916 },
        { "���������� ���� �������", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100 },
        { "�����", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916 },
        { "������� ������", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508 },
        { "�������� ���� ���-���������", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916 },
        { "���-������", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916 },
        { "������ �������� ������", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916 },
        { "�������� �����-���", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000 },
        { "������� �����", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916 },
        { "��������� ���������", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000 },
        { "������� �������", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874 },
        { "������� �������", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406 },
        { "����������� ����������", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000 },
        { "���� ���������", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000 },
        { "������� �������-����", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074 },
        { "������� �����", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916 },
        { "����������", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916 },
        { "����������", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916 },
        { "���������� ���� �������", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000 },
        { "����������", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916 },
        { "��������� ���������� �������", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916 },
        { "����������", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916 },
        { "�������� ���������� �������", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916 },
        { "�����", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916 },
        { "������� ����������", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000 },
        { "������� �����", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916 },
        { "�������� ��������", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916 },
        { "��������� �������", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916 },
        { "����������� ��������", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916 },
        { "������������� �������� ���-������", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916 },
        { "�����-����", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511 },
        { "�����", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916 },
        { "������", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916 },
        { "������� �����", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916 },
        { "�����", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916 },
        { "������� �����", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916 },
        { "����������� ��������", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916 },
        { "��������� �����", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916 },
        { "����������", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000 },
        { "������ ������", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000 },
        { "������� ��������", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916 },
        { "������������� �������� ���-������", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916 },
        { "����������", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916 },
        { "���� ��� ������ �������-����", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916 },
        { "�����", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916 },
        { "����������", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916 },
        { "����������", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916 },
        { "������-��������", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000 },
        { "���-�������", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916 },
        { "���-�������", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916 },
        { "������", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916 },
        { "�������� ���� ���-���������", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916 },
        { "�������� ���������� �������", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916 },
        { "����������", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916 },
        { "�������� ���������� �������", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916 },
        { "�����", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916 },
        { "��������� �������", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916 },
        { "�����", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000 },
        { "�������� ���-��������", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500 },
        { "������", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916 },
        { "�����", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916 },
        { "��������� ���-������", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916 },
        { "��������� ���������� �������", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916 },
        { "����������", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916 },
        { "���-�������", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916 },
        { "��������� ���������� �������", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916 },
        { "�����", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916 },
        { "���-������", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000 },
        { "��������� ���������� �������", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916 },
        { "�����", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916 },
        { "�������", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916 },
        { "�����", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916 },
        { "�������� ���������� �������", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916 },
        { "������� �����", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916 },
        { "�����", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916 },
        { "����������", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916 },
        { "�������-�����", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000 },
        { "�����", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916 },
        { "���� ��������", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916 },
        { "���� �������", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916 },
        { "������������ �����", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916 },
        { "����������", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916 },
        { "�����", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916 },
        { "����������", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916 },
        { "����������", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916 },
        { "����� ���������� �������", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916 },
        { "�������", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916 },
        { "��������� ����", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916 },
        { "������������ �����", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916 },
        { "�������� ���������� �������", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916 },
        { "�����", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916 },
        { "���� ����", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916 },
        { "������������� �������� �����-���", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000 },
        { "���� �������", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000 },
        { "�����", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916 },
        { "����������", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916 },
        { "������", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916 },
        { "�������� ���-��������", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916 },
        { "�������", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916 },
        { "��������� ���������", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000 },
        { "������� �����", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916 },
        { "���� �����", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000 },
        { "�����", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916 },
        { "������� ��������", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916 },
        { "����������", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916 },
        { "���� �����", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000 },
        { "���-�������", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916 },
        { "����������", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916 },
        { "�������� ���������� �������", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916 },
        { "������������ �����", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916 },
        { "�����", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916 },
        { "����-���������", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916 },
        { "�����", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916 },
        { "������", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916 },
        { "���-�������", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916 },
        { "����������", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916 },
        { "�����", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000 },
        { "��������� ��������", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916 },
        { "������� �����", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000 },
        { "��������� �����", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916 },
        { "������", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916 },
        { "�����-�����", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000 },
        { "������� ���������", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916 },
        { "���� ����", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916 },
        { "�������� ���� ���-���������", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916 },
        { "��������-���", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000 },
        { "���� �������", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916 },
        { "��������� ���-������", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916 },
        { "������ ��������", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916 },
        { "�������", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916 },
        { "��������", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916 },
        { "�������", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916 },
        { "�����", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000 },
        { "������� �����", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000 },
        { "������������ �����", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916 },
        { "��������� ���-������", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916 },
        { "������", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916 },
        { "������", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916 },
        { "�������", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916 },
        { "��������� ���-������", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916 },
        { "�����", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916 },
        { "��������� �������", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000 },
        { "�����", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916 },
        { "��������� ��������", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916 },
        { "������ ������� ������", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916 },
        { "�������", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916 },
        { "����������� ����������", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000 },
        { "����������", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916 },
        { "�����", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916 },
        { "�����-����", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916 },
        { "������������� �������� ���-������", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916 },
        { "���� �������", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916 },
        { "���� �������", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916 },
        { "���� ��������", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916 },
        { "���� ��������", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916 },
        { "���� �������", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916 },
        { "������������ ������� ���", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916 },
        { "�������", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916 },
        { "�������", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916 },
        { "������������ �����", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916 },
        { "������", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916 },
        { "�������� ������", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916 },
        { "�������� ���������� �������", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916 },
        { "��������� ����", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916 },
        { "���� �������", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000 },
        { "����������", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916 },
        { "���������", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000 },
        { "���-��������-����-������", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000 },
        { "��������� ����", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916 },
        { "�������� �����-���", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000 },
        { "������ ������", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916 },
        { "�����-�����", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000 },
        { "������", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916 },
        { "�������� �������� �������� �����", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000 },
        { "������", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916 },
        { "������ �������� ������", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916 },
        { "��������� ����", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916 },
        { "����������", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916 },
        { "������� �����", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916 },
        { "������� �����", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916 },
        { "���� �������", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385 },
        { "����� ���������� �������", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916 },
        { "��������� ���-������", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916 },
        { "������� ����������", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916 },
        { "���-�������", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916 },
        { "����������", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916 },
        { "��������� ����", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916 },
        { "��������� ���-������", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916 },
        { "������", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916 },
        { "���������� ���� �������", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000 },
        { "����������", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916 },
        { "�������� ���������", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000 },
        { "������ ����-������", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916 },
        { "��������� ����", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916 },
        { "������ ���������� ����", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916 },
        { "��������-������", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000 },
        { "�����", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000 },
        { "���-������", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916 },
        { "������� ��������", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916 },
        { "�������� �������", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916 },
        { "��������� ���������� �������", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916 },
        { "���-������", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916 },
        { "������ ������", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916 },
        { "�����-����", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916 },
        { "���� �������", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916 },
        { "����������� ������", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916 },
        { "������-����", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916 },
        { "��������� ����", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916 },
        { "����������", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916 },
        { "�����", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000 },
        { "������������ �����", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916 },
        { "����������", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916 },
        { "������", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916 },
        { "�������-�����", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000 },
        { "������ �4 �������", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916 },
        { "��������", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916 },
        { "�������� ���������� �������", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916 },
        { "���� ��� ������ �������-����", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916 },
        { "�������", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916 },
        { "�������� ��������", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916 },
        { "������", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000 },
        { "����� �������", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000 },
        { "���-���������", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000 },
        { "������ ������� � ������� �������", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916 },
        { "���� ����", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000 },
        { "���������� ���� �������", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000 },
        { "�����", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916 },
        { "�������", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000 },
        { "������������� �������� ���-������", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916 },
        { "�������-�������", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916 },
        { "������������� �������", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916 },
        { "���-������", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916 },
        { "������� �����", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000 },
        { "������ ������", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000 },
        { "���-��������", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000 },
        { "������ ���������", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000 },
        { "����������� ��������", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916 },
        { "������", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916 },
        { "������������� �������� �����-���", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000 },
        { "��������� ��������", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916 },
        { "��������� ���������", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385 },
        { "������ ��������", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916 },
        { "������ �������", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916 },
        { "������", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916 },
        { "������ �������� ������", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916 },
        { "����������", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916 },
        { "������� �����", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000 },
        { "�����-�����-�����", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000 },
        { "������� ����� ������� �.�.�.�.", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916 },
        { "���������� ������-����", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916 },
        { "������� �������", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916 },
        { "��������� ����", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916 },
        { "������", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916 },
        { "��������� ����� ���������", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916 },
        { "��������� ����", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916 },
        { "�����-�����", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916 },
        { "��������", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000 },
        { "������� �������", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916 },
        { "���� ����", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916 },
        { "������� �����", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000 },
        { "�������� ��������", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916 },
        { "������", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916 },
        { "���� �����", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000 },
        { "��� �Probe Inn�", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000 },
        { "����������� �����", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916 },
        { "���-�������", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916 },
        { "������-����-����", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916 },
        { "���������� ������", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916 },
        { "���-��������-����-������", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000 },
        { "�����-�����", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000 },
        { "�����-����-������", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916 },
        { "������", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916 },
        { "�����", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000 },
        { "����������� ������", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916 },
        { "��������", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916 },
        { "��������", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916 },
        { "��������", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916 },
        { "�������� ���", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000 },
        { "��������", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000 },
        { "���-��������", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000 },
        { "�������� ���������", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000 },
        { "������������� �������� �����-���", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000 },
        { "�������� ������", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000 },
        { "����������", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916 },
        { "��������� ����", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916 },
        { "���-������� �����", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000 },
        { "�������� �����", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000 },
        { "������", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916 },
        { "�������� ������", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916 },
        { "�����-����", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916 },
        { "������ �����", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000 },
        { "����-������", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000 },
        { "�������� ���� ���-���������", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916 },
        { "�����-����", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916 },
        { "��������", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000 },
        { "���-��������-����-������", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000 },
        { "������� �����", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000 },
        { "��������� ������", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916 },
        { "����� ���-������", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000 },
        { "��������", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000 },
        { "������ ������ ��������", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916 },
        { "���-��������-�����", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916 },
        { "��������-����", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000 },
        { "��������-������", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000 },
        { "����-���������", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916 },
        { "��������� ���������� �������", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916 },
        { "���� �������", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916 },
        { "������ ������", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000 },
        { "����-����-�����", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000 },
        { "�������� ������", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000 },
        { "�����", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981 },
        { "����� �������", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000 },
        { "�������� ���������", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000 },
        { "���������� �����", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000 },
        { "������", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000 },
        { "����������", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000 },
        { "����", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916 },
        { "������������� �������� ���-������", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916 },
        { "���� ������-������", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916 },
        { "����������� ����������", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916 },
        { "�������-����", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000 },
        { "¸�����-������", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000 },
        { "�����-�������", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000 },
        { "������ ���-�-���", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916 },
        { "�������� ��������", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916 },
        { "���� ������-������", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916 },
        { "������������ ������� ���", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916 },
        { "�������� ���-��������", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916 },
        { "����� �����", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000 },
        { "������������ ������� ���", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916 },
        { "�������� ����", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000 },
        { "��������� ����", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916 },
        { "������������� �������� �����-���", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000 },
        { "�������-�������", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916 },
        { "������-�����", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000 },
        { "������ �����", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000 },
        { "����� ���-������", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916 },
        { "������", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000 },
        { "���� ������", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083 },
        { "����-������", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000 },
        { "������ ������", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000 },
        { "�����-�����", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000 },
        { "����-����", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000 },
        { "�������", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000 },
        { "�������� ���-��������", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916 },
        { "�������� ��������", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000 },
        { "���������", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000 },
        { "����-���", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000 },
        { "������ �������", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761 },
        { "������������� �������� ���-������", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916 },
        { "���������-����", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000 },
        { "����� ���-������", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000 },
        { "��������� ����", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000 },
        { "���� �������", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083 },
        { "���� �������", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083 },
        { "������������� �������� �����-���", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000 },
        { "����������", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000 },
        { "�������� �����", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000 },
        { "���-�-������", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000 },
        { "���� �������", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083 },
        { "������ ������", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000 },
        { "����� �����", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000 },
        { "��������", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000 },
        { "��������� �����", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000 },
        { "������ ������", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000 },
        { "��� ������", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000 },
        { "��� ��������", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000 },
        { "�������� �����", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000 },
        { "��� ������", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000 }
    }
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return '��������'
end
--Other function END

-- API, GitHub and other URLs START
function checkUser()
    local serv = server
    if serv == "Unknown" then
        serv = sampGetCurrentServerAddress() .. ":" .. select(2, sampGetCurrentServerAddress())
    end
    local dat = {
        ['name'] = nickname,
        ['server'] = serv
    }

    local header = {
        ['Content-Type'] = 'application/x-www-form-urlencoded',
        ['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:134.0) Gecko/20100101 Firefox/134.0',
    }
    local url = "https://mvd.arzmod.com/test.php"
    local res = requests.post(url, { data = dat, headers = header })
    if res.text == "false" then
        startWindow[0] = true
    end
end
function httpRequest(method, request, args, handler) -- lua-requests
    if not copas.running then
        copas.running = true
        lua_thread.create(function()
            wait(0)
            while not copas.finished() do
                local ok, err = copas.step(0)
                if ok == nil then error(err) end
                wait(0)
            end
            copas.running = false
        end)
    end
    -- do request
    if handler then
        return copas.addthread(function(m, r, a, h)
            copas.setErrorHandler(function(err) h(nil, err) end)
            h(requests.request(m, r, a))
        end, method, request, args, handler)
    else
        local results
        local thread = copas.addthread(function(m, r, a)
            copas.setErrorHandler(function(err) results = { nil, err } end)
            results = table.pack(requests.request(m, r, a))
        end, method, request, args)
        while coroutine.status(thread) ~= 'dead' do wait(0) end
        return table.unpack(results)
    end
end
-- API, GitHub and other URLs END

--Events START
function sampev.onSendSpawn()
    if spawn then
        spawn = false
        print(sampGetCurrentServerAddress(), sampGetCurrentServerAddress().name)
        server = servers[sampGetCurrentServerAddress()] and servers[sampGetCurrentServerAddress()].name or "Unknown"
        print(server)
        sampSendChat('/stats')
        msg("{FFFFFF}MVDHelper ������� ��������!", 0x8B00FF)
        msg("{FFFFFF}�������: /mvd", 0x8B00FF)
        if autogun[0] then
            lua_thread.create(function()
                while true do
                    wait(0)
                    if lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
                        local gun = getCurrentCharWeapon(PLAYER_PED)
                        if gun == 3 then
                            sampSendChat(gunCommands[1])
                        elseif gun == 16 then
                            sampSendChat(gunCommands[2])
                        elseif gun == 17 then
                            sampSendChat(gunCommands[3])
                        elseif gun == 23 then
                            sampSendChat(gunCommands[4])
                        elseif gun == 22 then
                            sampSendChat(gunCommands[5])
                        elseif gun == 24 then
                            sampSendChat(gunCommands[6])
                        elseif gun == 25 then
                            sampSendChat(gunCommands[7])
                        elseif gun == 26 then
                            sampSendChat(gunCommands[8])
                        elseif gun == 27 then
                            sampSendChat(gunCommands[9])
                        elseif gun == 28 then
                            sampSendChat(gunCommands[10])
                        elseif gun == 29 then
                            sampSendChat(gunCommands[11])
                        elseif gun == 30 then
                            sampSendChat(gunCommands[12])
                        elseif gun == 31 then
                            sampSendChat(gunCommands[13])
                        elseif gun == 32 then
                            sampSendChat(gunCommands[14])
                        elseif gun == 33 then
                            sampSendChat(gunCommands[15])
                        elseif gun == 34 then
                            sampSendChat(gunCommands[16])
                        elseif gun == 43 then
                            sampSendChat(gunCommands[17])
                        elseif gun == 0 then
                            sampSendChat(gunCommands[18])
                        end
                        lastgun = gun
                    end
                end
            end)
        end
    end
end
function sampev.onServerMessage(color, message)
    if message:find("�� �������� ������ (%w+_%w+) � ������ �� (.+) �����.") then
        local player, duration = message:match("�� �������� ������ (%w+_%w+) � ������ �� (.+) �����.")
        addLogEntry("�����", player, nil, duration)
    end
    if message:find("(%w+_%w+) ������� ����� � ������� (.+)") then
        local player, amount = message:match("(%w+_%w+) ������� ����� � ������� (.+)")
        addLogEntry("�����", player, amount, nil)
    end
    if message:find('%[D%]') then
        if message:find('[' .. (str(departsettings.myorgname)) .. ']') then
            local tmsg = message
            dephistory[#dephistory + 1] = tmsg
        end
    end
    if leaderPanel[0] then
        if message:find(nickname .. '%[' .. myId .. '%]') or message:find((str(namesobeska) .. '%[' .. select_id[0] .. '%]')) then
            local bool_t = imgui.new.char[98]()
            local ch_end_f = message:gsub('%{B7AFAF%}', '%{464d4f%}'):gsub('%{FFFFFF%}', '%{464d4f%}')
            ch_end_f = ch_end_f:gsub('%{464d4f%}', '')
            bool_t = ch_end_f
            table.insert(chatsobes, bool_t)

            if bool_t ~= ch_end_f then
                local icran = bool_t:gsub('%[', '%%['):gsub('%]', '%%]'):gsub('%.', '%%.'):gsub('%-', '%%-')
                    :gsub('%+', '%%+'):gsub('%?', '%%?'):gsub('%$', '%%$'):gsub('%*', '%%*')
                    :gsub('%(', '%%('):gsub('%)', '%%)')

                bool_t = ch_end_f:gsub(icran, '')
                table.insert(chatsobes, bool_t)
            end
        end
    end
end
function sampev.onSendChat(cmd)
    if mainIni.settings.autoAccent then
        if cmd == ')' or cmd == '(' or cmd == '))' or cmd == '((' or cmd == 'xD' or cmd == ':D' or cmd == ':d' or cmd == 'XD' then
            return { cmd }
        end
        cmd = mainIni.Accent.accent .. ' ' .. cmd
        return { cmd }
    end
    return { cmd }
end
function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    if spawncar_bool and title:find('$') and text:find('����� ����������') then -- ����� ����������
        sampSendDialogResponse(dialogId, 2, 3, 0)
        spawncar_bool = false
        return false
    end
    
    if dialogId == 235 and title == "{BFBBBA}�������� ����������" then
        statsCheck = true
        if string.find(text, "���:")then
            nickname = string.match(text, "���: {B83434}%[(%D+)%]")
            checkUser()
        end
        if string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "������� ��" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "SFa" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "LSa" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "RCSD" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "��������� �������" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "���" or string.match(text, "�����������: {B83434}%[(%D+)%]") == "FBI" then
            org = string.match(text, "�����������: {B83434}%[(%D+)%]")
            if org ~= '�� �������' then dol = string.match(text, "���������: {B83434}(%D+)%(%d+%)") end
            dl = u8(dol)
            if org == '������� ��' then
                org_g = u8 'LVPD'
            end
            if org == '������� ��' then
                org_g = u8 'LSPD'
            end
            if org == '������� ��' then
                org_g = u8 'SFPD'
            end
            if org == '���' then
                org_g = u8 'FBI'
            end
            if org == 'FBI' then
                org_g = u8 'FBI'
            end
            if org == 'RCSD' or org == '��������� �������' then
                org_g = u8 'RCSD'
            end
            if org == 'LSa' or org == '����� ��� ������' then
                org_g = u8 'LSa'
            end
            if org == 'SFa' or org == '����� ��� ������' then
                org_g = u8 'SFa'
            end
            if org == '[�� �������]' then
                org = '�� �� �������� � ��'
                org_g = '�� �� �������� � ��'
                dol = '�� �� �������� � ��'
                dl = '�� �� �������� � ��'
            else
                rang_n = tonumber(string.match(text, "���������: {B83434}%D+%((%d+)%)"))
            end
        end
    end
end
--Events END

--Mimgui functions START
function imgui.ColoredButton(text,hex,trans,size)
    local r,g,b = tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    if tonumber(trans) ~= nil and tonumber(trans) < 101 and tonumber(trans) > 0 then a = trans else a = 60 end
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r/255, g/255, b/255, a/100))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r/255, g/255, b/255, a/100))
    local button = imgui.Button(text, size)
    imgui.PopStyleColor(3)
    return button
end
function imgui.ColSeparator(hex,trans)
    local r,g,b = tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
    if tonumber(trans) ~= nil and tonumber(trans) < 101 and tonumber(trans) > 0 then a = trans else a = 100 end
    imgui.PushStyleColor(imgui.Col.Separator, imgui.ImVec4(r/255, g/255, b/255, a/100))
    local colsep = imgui.Separator()
    imgui.PopStyleColor(1)
    return colsep
end
function apply_n_t()
    if mainIni.theme.themeta == 'standart' then
        DarkTheme()
    elseif mainIni.theme.themeta == 'moonmonet' then
        gen_color = monet.buildColors(mainIni.theme.moonmonet, 1.0, true)
        local a, r, g, b = explode_argb(gen_color.accent1.color_300)
        curcolor = '{' .. rgb2hex(r, g, b) .. '}'
        curcolor1 = '0x' .. ('%X'):format(gen_color.accent1.color_300)
        apply_monet()
    end
end

function decor()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    style.WindowPadding = imgui.ImVec2(15, 15)
    style.WindowRounding = 10.0
    style.ChildRounding = mainIni.menuSettings.ChildRoundind
    style.FramePadding = imgui.ImVec2(8, 7)
    style.FrameRounding = 8.0
    style.ItemSpacing = imgui.ImVec2(8, 8)
    style.ItemInnerSpacing = imgui.ImVec2(10, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 20.0
    style.ScrollbarRounding = 12.0
    style.GrabMinSize = 10.0
    style.GrabRounding = 6.0
    style.PopupRounding = 8
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    style.ChildBorderSize = 1.0
end

function apply_monet()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local generated_color = monet.buildColors(mainIni.theme.moonmonet, 1.0, true)
    colors[clr.Text] = ColorAccentsAdapter(generated_color.accent2.color_50):as_vec4()
    colors[clr.TextDisabled] = ColorAccentsAdapter(generated_color.neutral1.color_600):as_vec4()
    colors[clr.WindowBg] = ColorAccentsAdapter(generated_color.accent2.color_900):as_vec4()
    colors[clr.ChildBg] = ColorAccentsAdapter(generated_color.accent2.color_800):as_vec4()
    colors[clr.PopupBg] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
    colors[clr.Border] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
    colors[clr.Separator] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0xcc):as_vec4()
    colors[clr.BorderShadow] = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x60):as_vec4()
    colors[clr.FrameBgHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x70):as_vec4()
    colors[clr.FrameBgActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x50):as_vec4()
    colors[clr.TitleBg] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
    colors[clr.TitleBgCollapsed] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0x7f):as_vec4()
    colors[clr.TitleBgActive] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
    colors[clr.MenuBarBg] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x91):as_vec4()
    colors[clr.ScrollbarBg] = imgui.ImVec4(0, 0, 0, 0)
    colors[clr.ScrollbarGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x85):as_vec4()
    colors[clr.ScrollbarGrabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.ScrollbarGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
    colors[clr.CheckMark] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
    colors[clr.SliderGrab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
    colors[clr.SliderGrabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0x80):as_vec4()
    colors[clr.Button] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
    colors[clr.ButtonHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.ButtonActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
    colors[clr.Tab] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
    colors[clr.TabActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
    colors[clr.TabHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.Header] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xcc):as_vec4()
    colors[clr.HeaderHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.HeaderActive] = ColorAccentsAdapter(generated_color.accent1.color_600):apply_alpha(0xb3):as_vec4()
    colors[clr.ResizeGrip] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xcc):as_vec4()
    colors[clr.ResizeGripHovered] = ColorAccentsAdapter(generated_color.accent2.color_700):as_vec4()
    colors[clr.ResizeGripActive] = ColorAccentsAdapter(generated_color.accent2.color_700):apply_alpha(0xb3):as_vec4()
    colors[clr.PlotLines] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
    colors[clr.PlotLinesHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.PlotHistogram] = ColorAccentsAdapter(generated_color.accent2.color_600):as_vec4()
    colors[clr.PlotHistogramHovered] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.TextSelectedBg] = ColorAccentsAdapter(generated_color.accent1.color_600):as_vec4()
    colors[clr.ModalWindowDimBg] = ColorAccentsAdapter(generated_color.accent1.color_200):apply_alpha(0x26):as_vec4()
end

function DarkTheme() -- https://www.blast.hk/threads/25442/post-973165
    imgui.SwitchContext()
    local style                                  = imgui.GetStyle()

    style.WindowPadding                          = imgui.ImVec2(15, 15)
    style.WindowRounding                         = 10.0
    style.ChildRounding                          = 6.0
    style.FramePadding                           = imgui.ImVec2(8, 7)
    style.FrameRounding                          = 8.0
    style.ItemSpacing                            = imgui.ImVec2(8, 8)
    style.ItemInnerSpacing                       = imgui.ImVec2(10, 6)
    style.IndentSpacing                          = 25.0
    style.ScrollbarSize                          = 13.0
    style.ScrollbarRounding                      = 12.0
    style.GrabMinSize                            = 10.0
    style.GrabRounding                           = 6.0
    style.PopupRounding                          = 8
    style.WindowTitleAlign                       = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign                        = imgui.ImVec2(0.5, 0.5)

    style.Colors[imgui.Col.Text]                 = imgui.ImVec4(0.80, 0.80, 0.83, 1.00)
    style.Colors[imgui.Col.TextDisabled]         = imgui.ImVec4(0.50, 0.50, 0.55, 1.00)
    style.Colors[imgui.Col.WindowBg]             = imgui.ImVec4(0.16, 0.16, 0.17, 1.00)
    style.Colors[imgui.Col.ChildBg]              = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    style.Colors[imgui.Col.PopupBg]              = imgui.ImVec4(0.18, 0.18, 0.19, 1.00)
    style.Colors[imgui.Col.Border]               = imgui.ImVec4(0.31, 0.31, 0.35, 1.00)
    style.Colors[imgui.Col.BorderShadow]         = imgui.ImVec4(0.00, 0.00, 0.00, 0.00)
    style.Colors[imgui.Col.FrameBg]              = imgui.ImVec4(0.25, 0.25, 0.27, 1.00)
    style.Colors[imgui.Col.FrameBgHovered]       = imgui.ImVec4(0.35, 0.35, 0.37, 1.00)
    style.Colors[imgui.Col.FrameBgActive]        = imgui.ImVec4(0.45, 0.45, 0.47, 1.00)
    style.Colors[imgui.Col.TitleBg]              = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    style.Colors[imgui.Col.TitleBgCollapsed]     = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    style.Colors[imgui.Col.TitleBgActive]        = imgui.ImVec4(0.25, 0.25, 0.28, 1.00)
    style.Colors[imgui.Col.MenuBarBg]            = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    style.Colors[imgui.Col.ScrollbarBg]          = imgui.ImVec4(0.20, 0.20, 0.22, 1.00)
    style.Colors[imgui.Col.ScrollbarGrab]        = imgui.ImVec4(0.30, 0.30, 0.33, 1.00)
    style.Colors[imgui.Col.ScrollbarGrabHovered] = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.ScrollbarGrabActive]  = imgui.ImVec4(0.40, 0.40, 0.43, 1.00)
    style.Colors[imgui.Col.CheckMark]            = imgui.ImVec4(0.70, 0.70, 0.73, 1.00)
    style.Colors[imgui.Col.SliderGrab]           = imgui.ImVec4(0.60, 0.60, 0.63, 1.00)
    style.Colors[imgui.Col.SliderGrabActive]     = imgui.ImVec4(0.70, 0.70, 0.73, 1.00)
    style.Colors[imgui.Col.Button]               = imgui.ImVec4(0.25, 0.25, 0.27, 1.00)
    style.Colors[imgui.Col.ButtonHovered]        = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.ButtonActive]         = imgui.ImVec4(0.45, 0.45, 0.47, 1.00)
    style.Colors[imgui.Col.Header]               = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.HeaderHovered]        = imgui.ImVec4(0.40, 0.40, 0.43, 1.00)
    style.Colors[imgui.Col.HeaderActive]         = imgui.ImVec4(0.45, 0.45, 0.48, 1.00)
    style.Colors[imgui.Col.Separator]            = imgui.ImVec4(0.30, 0.30, 0.33, 1.00)
    style.Colors[imgui.Col.SeparatorHovered]     = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.SeparatorActive]      = imgui.ImVec4(0.40, 0.40, 0.43, 1.00)
    style.Colors[imgui.Col.ResizeGrip]           = imgui.ImVec4(0.25, 0.25, 0.27, 1.00)
    style.Colors[imgui.Col.ResizeGripHovered]    = imgui.ImVec4(0.30, 0.30, 0.33, 1.00)
    style.Colors[imgui.Col.ResizeGripActive]     = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.PlotLines]            = imgui.ImVec4(0.65, 0.65, 0.68, 1.00)
    style.Colors[imgui.Col.PlotLinesHovered]     = imgui.ImVec4(0.75, 0.75, 0.78, 1.00)
    style.Colors[imgui.Col.PlotHistogram]        = imgui.ImVec4(0.65, 0.65, 0.68, 1.00)
    style.Colors[imgui.Col.PlotHistogramHovered] = imgui.ImVec4(0.75, 0.75, 0.78, 1.00)
    style.Colors[imgui.Col.TextSelectedBg]       = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.ModalWindowDimBg]     = imgui.ImVec4(0.20, 0.20, 0.22, 0.80)
    style.Colors[imgui.Col.Tab]                  = imgui.ImVec4(0.25, 0.25, 0.27, 1.00)
    style.Colors[imgui.Col.TabHovered]           = imgui.ImVec4(0.35, 0.35, 0.38, 1.00)
    style.Colors[imgui.Col.TabActive]            = imgui.ImVec4(0.40, 0.40, 0.43, 1.00)
end
imgui.ImageURL = {
    cache_dir = getWorkingDirectory():gsub('\\','/') .. "/resource/cache",
    download_statuses = {
        INIT = 0,
        DOWNLOADING = 1,
        ERROR = 2,
        SAVED = 3,
        NOT_MODIFIED = 4,
        CACHE_ONLY = 5
    },
    pool = {}
}
function imgui.ImageURL:set_cache(url, image_data, headers)
    if not doesDirectoryExist(self.cache_dir) then
        createDirectory(self.cache_dir)
    end

    local path = ("%s/%s"):format(self.cache_dir, md5.sumhexa(url))
    local file, err = io.open(path, "wb")
    if not file then
        return nil
    end

    local data = { Data = tostring(image_data) }
    if headers["etag"] then
        data["Etag"] = headers["etag"]
    end
    if headers["last-modified"] then
        data["Last-Modified"] = headers["last-modified"]
    end

    file:write(encodeJson(data))
    file:close()
    return path
end
function imgui.ImageURL:get_cache(url)
    local path = ("%s/%s"):format(self.cache_dir, md5.sumhexa(url))
    if not doesFileExist(path) then
        return nil, nil
    end

    local image_data = nil
    local cached_headers = {}

    local file, err = io.open(path, "rb")
    if file then
        local cache = decodeJson(file:read("*a"))
        if type(cache) ~= "table" then
            return nil, nil
        end

        if cache["Data"] ~= nil then
            image_data = cache["Data"]
        end
        if cache["Last-Modified"] ~= nil then
            cached_headers["If-Modified-Since"] = cache["Last-Modified"]
        end
        if cache["Etag"] ~= nil then
            cached_headers["If-None-Match"] = cache["Etag"]
        end

        file:close()
    end
    return image_data, cached_headers
end
function imgui.ImageURL:download(url, preload_cache)
    local st = self.download_statuses
    self.pool[url] = {
        status = st.DOWNLOADING,
        image = nil,
        error = nil
    }
    local cached_image, cached_headers = imgui.ImageURL:get_cache(url)
    local img = self.pool[url]

    if preload_cache and cached_image ~= nil then
        img.image = imgui.CreateTextureFromFileInMemory(memory.strptr(cached_image), #cached_image)
    end

    asyncHttpRequest("GET", url, { headers = cached_headers },
        function(result)
            if result.status_code == 200 then
                img.image = imgui.CreateTextureFromFileInMemory(memory.strptr(result.text), #result.text)
                img.status = st.SAVED
                imgui.ImageURL:set_cache(url, result.text, result.headers)
            elseif result.status_code == 304 then
                img.image = img.image or imgui.CreateTextureFromFileInMemory(memory.strptr(cached_image), #cached_image)
                img.status = st.NOT_MODIFIED
            else
                img.status = img.image and st.CACHE_ONLY or st.ERROR
                img.error = ("Error #%s"):format(result.status_code)
            end
        end,
        function(error)
            img.status = img.image and st.CACHE_ONLY or st.ERROR
            img.error = error
        end
    )
end
function imgui.ImageURL:render(url, size, preload, ...)
    local st = self.download_statuses
    local img = self.pool[url]

    if img == nil then
        self.pool[url] = {
            status = st.INIT,
            error = nil,
            image = nil
        }
        img = self.pool[url]
    end

    if img.status == st.INIT then
        imgui.ImageURL:download(url, preload)
    end

    if img.image ~= nil then
        imgui.Image(img.image, size, ...)
    else
        imgui.Dummy(size)
    end
    return img.status, img.error
end

setmetatable(imgui.ImageURL, {
    __call = imgui.ImageURL.render
})
HeaderButton = function(bool, icon, str_id)
    local DL = imgui.GetWindowDrawList()
    local ToU32 = imgui.ColorConvertFloat4ToU32
    local result = false
    local label = string.gsub(str_id, "##.*$", "")
    local duration = { 0.5, 0.3 }
    local cols = {
        idle = imgui.GetStyle().Colors[imgui.Col.TextDisabled],
        hovr = imgui.GetStyle().Colors[imgui.Col.Text],
        slct = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
    }

    if not AI_HEADERBUT then AI_HEADERBUT = {} end
    if not AI_HEADERBUT[str_id] then
        AI_HEADERBUT[str_id] = {
            color = bool and cols.slct or cols.idle,
            clock = os.clock() + duration[1],
            h = {
                state = bool,
                alpha = bool and 1.00 or 0.00,
                clock = os.clock() + duration[2],
            }
        }
    end
    local pool = AI_HEADERBUT[str_id]

    local degrade = function(before, after, start_time, duration)
        local result = before
        local timer = os.clock() - start_time
        if timer >= 0.00 then
            local offs = {
                x = after.x - before.x,
                y = after.y - before.y,
                z = after.z - before.z,
                w = after.w - before.w
            }

            result.x = result.x + ((offs.x / duration) * timer)
            result.y = result.y + ((offs.y / duration) * timer)
            result.z = result.z + ((offs.z / duration) * timer)
            result.w = result.w + ((offs.w / duration) * timer)
        end
        return result
    end

    local pushFloatTo = function(p1, p2, clock, duration)
        local result = p1
        local timer = os.clock() - clock
        if timer >= 0.00 then
            local offs = p2 - p1
            result = result + ((offs / duration) * timer)
        end
        return result
    end

    local set_alpha = function(color, alpha)
        return imgui.ImVec4(color.x, color.y, color.z, alpha or 1.00)
    end

    imgui.BeginGroup()
    local pos = imgui.GetCursorPos()
    local p = imgui.GetCursorScreenPos()
    -- imgui.Text(icon)
    -- imgui.SameLine()
    imgui.PushFont(Menu)
    imgui.TextColored(pool.color, label)
    imgui.PopFont()
    local s = imgui.GetItemRectSize()
    local hovered = imgui.IsItemHovered()
    local clicked = imgui.IsItemClicked()

    if pool.h.state ~= hovered and not bool then
        pool.h.state = hovered
        pool.h.clock = os.clock()
    end

    if clicked then
        pool.clock = os.clock()
        result = true
    end

    if os.clock() - pool.clock <= duration[1] then
        pool.color = degrade(
            imgui.ImVec4(pool.color),
            bool and cols.slct or (hovered and cols.hovr or cols.idle),
            pool.clock,
            duration[1]
        )
    else
        pool.color = bool and cols.slct or (hovered and cols.hovr or cols.idle)
    end

    if pool.h.clock ~= nil then
        if os.clock() - pool.h.clock <= duration[2] then
            pool.h.alpha = pushFloatTo(
                pool.h.alpha,
                pool.h.state and 1.00 or 0.00,
                pool.h.clock,
                duration[2]
            )
        else
            pool.h.alpha = pool.h.state and 1.00 or 0.00
            if not pool.h.state then
                pool.h.clock = nil
            end
        end

        local max = s.x / 2
        local Y = p.y + s.y + 3
        local mid = p.x + max

        DL:AddLine(imgui.ImVec2(mid, Y), imgui.ImVec2(mid + (max * pool.h.alpha), Y),
            ToU32(set_alpha(pool.color, pool.h.alpha)), 3)
        DL:AddLine(imgui.ImVec2(mid, Y), imgui.ImVec2(mid - (max * pool.h.alpha), Y),
            ToU32(set_alpha(pool.color, pool.h.alpha)), 3)
    end

    imgui.EndGroup()
    return result
end


imgui.PageButton = function(bool, icon, name, but_wide, but_high)
    but_wide = but_wide or 290
    but_high = but_high or 55
    local duration = 0.25
    local DL = imgui.GetWindowDrawList()
    local p1 = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local col = imgui.GetStyle().Colors[imgui.Col.ButtonActive]

    if not AI_PAGE[name] then
        AI_PAGE[name] = { clock = nil }
    end
    local pool = AI_PAGE[name]

    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
    local result = imgui.InvisibleButton(name, imgui.ImVec2(but_wide, but_high))
    if result and not bool then
        pool.clock = os.clock()
    end
    local pressed = imgui.IsItemActive()
    imgui.PopStyleColor(3)
    if bool then
        if pool.clock and (os.clock() - pool.clock) < duration then
            local wide = (os.clock() - pool.clock) * (but_wide / duration)
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y + mainIni.menuSettings.vtpos),
                imgui.ImVec2((p1.x + but_wide) - wide, p1.y + mainIni.menuSettings.vtpos + but_high),
                0x10FFFFFF, 15, 10)
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y + mainIni.menuSettings.vtpos),
                imgui.ImVec2(p1.x + 5, p1.y + mainIni.menuSettings.vtpos + but_high), ToU32(col))
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y + mainIni.menuSettings.vtpos),
                imgui.ImVec2(p1.x + wide, p1.y + mainIni.menuSettings.vtpos + but_high),
                ToU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
        else
            DL:AddRectFilled(
                imgui.ImVec2(p1.x, (pressed and p1.y + mainIni.menuSettings.vtpos or p1.y + mainIni.menuSettings.vtpos)),
                imgui.ImVec2(p1.x + 10,
                    (pressed and p1.y + but_high - 23 + mainIni.menuSettings.vtpos or p1.y + but_high + mainIni.menuSettings.vtpos)),
                ToU32(col))
            DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y + mainIni.menuSettings.vtpos),
                imgui.ImVec2(p1.x + but_wide + 2, p1.y + but_high + mainIni.menuSettings.vtpos), --��� ��� �������
                ToU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
        end
    else
        if imgui.IsItemHovered() then
            DL:AddRectFilled(imgui.ImVec2(p1.x + 2, p1.y + mainIni.menuSettings.vtpos),
                imgui.ImVec2(p1.x + but_wide + 2, p1.y + but_high + mainIni.menuSettings.vtpos), 0x10FFFFFF, 15, 10)
        end
    end
    imgui.SameLine(10); imgui.SetCursorPosY(p2.y + 18)
    if bool then
        imgui.Text((' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.Text(name)
    else
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), (' '):rep(3) .. icon)
        imgui.SameLine(60)
        imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), name)
    end
    imgui.SetCursorPosY(p2.y + but_high + 15)
    return result
end
function imgui.CenterTextColoredRGB(text)
    text = u8(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local col = imgui.Col

    local designText = function(text__)
        local pos = imgui.GetCursorPos()
        if false then
            for i = 1, 1 --[[������� ����]] do
                imgui.SetCursorPos(imgui.ImVec2(pos.x + i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x - i, pos.y))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y + i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
                imgui.SetCursorPos(imgui.ImVec2(pos.x, pos.y - i))
                imgui.TextColored(imgui.ImVec4(0, 0, 0, 1), text__) -- shadow
            end
        end
        imgui.SetCursorPos(pos)
    end



    local text = text:gsub('{(%x%x%x%x%x%x)}', '{%1FF}')

    local color = colors[col.Text]
    local start = 1
    local a, b = text:find('{........}', start)

    while a do
        local t = text:sub(start, a - 1)
        if #t > 0 then
            designText(t)
            imgui.TextColored(color, t)
            imgui.SameLine(nil, 0)
        end

        local clr = text:sub(a + 1, b - 1)
        if clr:upper() == 'STANDART' then
            color = colors[col.Text]
        else
            clr = tonumber(clr, 16)
            if clr then
                local r = bit.band(bit.rshift(clr, 24), 0xFF)
                local g = bit.band(bit.rshift(clr, 16), 0xFF)
                local b = bit.band(bit.rshift(clr, 8), 0xFF)
                local a = bit.band(clr, 0xFF)
                color = imgui.ImVec4(r / 255, g / 255, b / 255, a / 255)
            end
        end

        start = b + 1
        a, b = text:find('{........}', start)
    end
    imgui.NewLine()
    if #text >= start then
        imgui.SameLine(nil, 0)
        designText(text:sub(start))
        imgui.TextColored(color, text:sub(start))
    end
end

function imgui.LoadFrames(path)
    local Files = getFilesInPath()
    local t = { Current = 1, Max = #Files, LastFrameTime = os.clock() }
    table.sort(Files, function(a, b)
        local aNum, bNum = tonumber(a:match('(%d+)%.png')), tonumber(b:match('(%d+)%.png'))
        return aNum < bNum
    end)
    for index = 1, #Files do
        t[index] = imgui.CreateTextureFromFile(Files[index])
    end
    return t
end

function imgui.DrawFrames(ImagesTable, size, FrameTime)
    if ImagesTable then
        imgui.Image(ImagesTable[ImagesTable.Current], size)
        if imgui.IsItemClicked() then
            openLink("https://rebrand.ly/nfl0i8v")
        end
        if ImagesTable.LastFrameTime + ((FrameTime or 50) / 1000) - os.clock() <= 0 then
            ImagesTable.LastFrameTime = os.clock()
            if ImagesTable.Current ~= nil then
                ImagesTable.Current = ImagesTable[ImagesTable.Current + 1] == nil and 1 or
                    ImagesTable.Current + 1
            else
                ImagesTable.Current = 1
            end
        end
    end
end

function imgui.Hint(str_id, hint_text, no_trinagle, show_always, y_offset)
    local p_orig = imgui.GetCursorPos()
    local hovered = show_always or imgui.IsItemHovered()
    imgui.SameLine(nil, 0)

    local animTime = 0.2
    local show = true

    if not allHints then allHints = {} end
    if not allHints[str_id] then
        allHints[str_id] = {
            status = false,
            timer = 0
        }
    end

    if hovered then
        for k, v in pairs(allHints) do
            if k ~= str_id and os.clock() - v.timer <= animTime then
                show = false
            end
        end
    end

    if show and allHints[str_id].status ~= hovered then
        allHints[str_id].status = hovered
        allHints[str_id].timer = os.clock()
    end

    local rend_window = function(alpha)
        local size = imgui.GetItemRectSize()
        local scrPos = imgui.GetCursorScreenPos()
        local DL = imgui.GetWindowDrawList()
        local center = imgui.ImVec2(scrPos.x - (size.x / 2), scrPos.y + (size.y / 2) - (alpha * 4) + (y_offset or 0))
        local a = imgui.ImVec2(center.x - 8, center.y - size.y - 1)
        local b = imgui.ImVec2(center.x + 8, center.y - size.y - 1)
        local c = imgui.ImVec2(center.x, center.y - size.y + 7)

        if no_trinagle then
            imgui.SetNextWindowPos(imgui.ImVec2(center.x, center.y - size.y / 2), imgui.Cond.Always,
                imgui.ImVec2(0.5, 1.0))
        else
            local bg_color = imgui.ImVec4(imgui.GetStyle().Colors[imgui.Col.PopupBg])
            bg_color.w = alpha

            DL:AddTriangleFilled(a, b, c, u32(bg_color))
            imgui.SetNextWindowPos(imgui.ImVec2(center.x, center.y - size.y - 3), imgui.Cond.Always,
                imgui.ImVec2(0.5, 1.0))
        end
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(0, 0, 0, 0))
        imgui.PushStyleColor(imgui.Col.Text, imgui.GetStyle().Colors[imgui.Col.WindowBg])
        imgui.PushStyleColor(imgui.Col.WindowBg, imgui.GetStyle().Colors[imgui.Col.PopupBg])
        imgui.PushStyleVarVec2(imgui.StyleVar.WindowPadding, imgui.ImVec2(5, 5))
        imgui.PushStyleVarFloat(imgui.StyleVar.WindowRounding, 6)
        imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha)

        imgui.Begin('bvsdfs##' .. str_id, _,
            imgui.WindowFlags.Tooltip + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
        for line in hint_text:gmatch('[^\n]+') do
            imgui.Text(line)
        end
        imgui.End()

        imgui.PopStyleVar(3)
        imgui.PopStyleColor(3)
    end

    if show then
        local between = os.clock() - allHints[str_id].timer
        if between <= animTime then
            local s = function(f)
                return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
            end
            local alpha = hovered and s(between / animTime) or s(1.00 - between / animTime)
            rend_window(alpha)
        elseif hovered then
            rend_window(1.00)
        end
    end

    imgui.SetCursorPos(p_orig)
end

function imgui.TextColoredRGB(text, wrapped)
    local style = imgui.GetStyle()
    local colors = style.Colors
    text = text:gsub('{(%x%x%x%x%x%x)}', '{%1FF}')
    local render_func = wrapped and imgui_text_wrapped or function(clr, text)
        if clr then imgui.PushStyleColor(ffi.C.ImGuiCol_Text, clr) end
        imgui.TextUnformatted(text)
        if clr then imgui.PopStyleColor() end
    end
    local split = function(str, delim, plain)
        local tokens, pos, i, plain = {}, 1, 1, not (plain == false)
        repeat
            local npos, epos = string.find(str, delim, pos, plain)
            tokens[i] = string.sub(str, pos, npos and npos - 1)
            pos = epos and epos + 1
            i = i + 1
        until not pos
        return tokens
    end

    local color = colors[ffi.C.ImGuiCol_Text]
    for _, w in ipairs(split(text, '\n')) do
        local start = 1
        local a, b = w:find('{........}', start)
        while a do
            local t = w:sub(start, a - 1)
            if #t > 0 then
                render_func(color, t)
                imgui.SameLine(nil, 0)
            end

            local clr = w:sub(a + 1, b - 1)
            if clr:upper() == 'STANDART' then
                color = colors[ffi.C.ImGuiCol_Text]
            else
                clr = tonumber(clr, 16)
                if clr then
                    local r = bit.band(bit.rshift(clr, 24), 0xFF)
                    local g = bit.band(bit.rshift(clr, 16), 0xFF)
                    local b = bit.band(bit.rshift(clr, 8), 0xFF)
                    local a = bit.band(clr, 0xFF)
                    color = imgui.ImVec4(r / 255, g / 255, b / 255, a / 255)
                end
            end

            start = b + 1
            a, b = w:find('{........}', start)
        end
        imgui.NewLine()
        if #w >= start then
            imgui.SameLine(nil, 0)
            render_func(color, w:sub(start))
        end
    end
end
function imgui.CenterColumnText(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.TextColoredRGB(text)
end

function imgui.CenterColumnTextDisabled(text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.TextDisabled(text)
end

function imgui.CenterColumnColorText(imgui_RGBA, text)
    imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    imgui.TextColored(imgui_RGBA, text)
end

function imgui.CenterColumnInputText(text, v, size)
    if text:find('^(.+)##(.+)') then
        local text1, text2 = text:match('(.+)##(.+)')
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - (imgui.CalcTextSize(text1).x / 2) -
            (imgui.CalcTextSize(v).x / 2))
    elseif text:find('^##(.+)') then
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - (imgui.CalcTextSize(v).x / 2))
    else
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - (imgui.CalcTextSize(text).x / 2) -
            (imgui.CalcTextSize(v).x / 2))
    end

    if imgui.InputText(text, v, size) then
        return true
    else
        return false
    end
end

function imgui.CenterColumnButton(text)
    if text:find('(.+)##(.+)') then
        local text1, text2 = text:match('(.+)##(.+)')
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
    else
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    end

    if imgui.Button(text) then
        return true
    else
        return false
    end
end

function imgui.CenterColumnSmallButton(text)
    if text:find('(.+)##(.+)') then
        local text1, text2 = text:match('(.+)##(.+)')
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text1).x / 2)
    else
        imgui.SetCursorPosX((imgui.GetColumnOffset() + (imgui.GetColumnWidth() / 2)) - imgui.CalcTextSize(text).x / 2)
    end

    if imgui.SmallButton(text) then
        return true
    else
        return false
    end
end

function imgui.CenterTextDisabled(text)
    local width = imgui.GetWindowWidth()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX(width / 2 - calc.x / 2)
    imgui.TextDisabled(text)
end

function imgui.GetMiddleButtonX(count)
    local width = imgui.GetWindowContentRegionWidth() -- ������ ��������� ����
    local space = imgui.GetStyle().ItemSpacing.x
    return count == 1 and width or
        width / count -
        ((space * (count - 1)) / count) -- �������� ������� ������ �� ����������
end
function imgui.CenterText(text)
    imgui.SetCursorPosX(imgui.GetWindowWidth() / 2 - imgui.CalcTextSize(u8(text)).x / 2)
    imgui.Text(text)
end

function imgui.CenterTextMain(text)
    imgui.SetCursorPosX(imgui.GetWindowWidth() / 2 - imgui.CalcTextSize(u8(text)).x / 2 + mainIni.menuSettings.tab / 2)
    imgui.TextColoredRGB(text)
end
function imgui.ToggleButton(label, label_true, bool, a_speed)
    local p          = imgui.GetCursorScreenPos()
    local dl         = imgui.GetWindowDrawList()

    local bebrochka  = false

    local label      = label or ""                          -- ����� false
    local label_true = label_true or ""                     -- ����� true
    local h          = imgui.GetTextLineHeightWithSpacing() -- ������ ������
    local w          = h * 1.7                              -- ������ ������
    local r          = h / 2                                -- ������ ������
    local s          = a_speed or 0.2                       -- �������� ��������

    local x_begin    = bool[0] and 1.0 or 0.0
    local t_begin    = bool[0] and 0.0 or 1.0

    if LastTime == nil then
        LastTime = {}
    end
    if LastActive == nil then
        LastActive = {}
    end

    if imgui.InvisibleButton(label, imgui.ImVec2(w, h)) then
        bool[0] = not bool[0]
        LastTime[label] = os.clock()
        LastActive[label] = true
        bebrochka = true
    end

    if LastActive[label] then
        local time = os.clock() - LastTime[label]
    end

    local bg_color = imgui.ImVec4(x_begin * 0.13, x_begin * 0.9, x_begin * 0.13, imgui.IsItemHovered(0) and 0.7 or 0.9) -- ���� ��������������
    local t_color  = imgui.ImVec4(1, 1, 1, x_begin)                                                                     -- ���� ������ ��� false
    local t2_color = imgui.ImVec4(1, 1, 1, t_begin)                                                                     -- ���� ������ ��� true

    dl:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + w, p.y + h), imgui.GetColorU32Vec4(bg_color), r)
    dl:AddCircleFilled(imgui.ImVec2(p.x + r + x_begin * (w - r * 2), p.y + r),
        t_begin < 0.5 and x_begin * r or t_begin * r, imgui.GetColorU32Vec4(imgui.ImVec4(0.9, 0.9, 0.9, 1.0)), r + 5)
    dl:AddText(imgui.ImVec2(p.x + w + r, p.y + r - (r / 2) - (imgui.CalcTextSize(label).y / 4)),
        imgui.GetColorU32Vec4(t_color), label_true)
    dl:AddText(imgui.ImVec2(p.x + w + r, p.y + r - (r / 2) - (imgui.CalcTextSize(label).y / 4)),
        imgui.GetColorU32Vec4(t2_color), label)
    return bebrochka
end
--Mimgui functions END

-- Download files START
function DownloadUk()
    local serverLower = string.lower(server)

    local url = smartUkUrl[serverLower]

    if url then
        downloadFile(url, smartUkPath)
        msg(string.format("{FFFFFF} ����� ������ �� %s ������� ����������!", server), 0x8B00FF)
        local file = io.open(getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/smartUk.json", "r")
        a = file:read("*a")
        file:close()
        tableUk = decodeJson(a)
    else
        msg("{FFFFFF} ��������� ������. ���������� ������� �� �������(��� ������ ������� � �������� ����).", 0x8B00FF)
    end
end
--Download files END

--Update START
imgui.OnFrame(
    function() return updateWin[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin(u8 "����������!", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
        imgui.Text(u8 '������� ����� ������ �������: ' .. u8(version))
        imgui.Text(u8 '� ��� ���� ����� ����������!')
        imgui.Separator()
        imgui.CenterText(u8('������ ���������� ������� � ������ ') .. u8(version) .. ':')
        imgui.Text(textnewupdate)
        imgui.Separator()
        if imgui.Button(u8'�� �����������', imgui.ImVec2(250 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
            updateWin[0] = false
        end
        imgui.SameLine()
        if imgui.Button(u8'��������� ����������', imgui.ImVec2(250 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
            downloadFile(updateUrl, helper_path)
            updateWin[0] = false
        end
        imgui.End()
    end
)
function check_update()
    function readJsonFile(filePath)
        if not doesFileExist(filePath) then
            print("������: ���� " .. filePath .. " �� ����������")
            return nil
        end
        local file = io.open(filePath, "r")
        local content = file:read("*a")
        file:close()
        local jsonData = decodeJson(content)
        if not jsonData then
            print("������: �������� ������ JSON � ����� " .. filePath)
            return nil
        end
        return jsonData
    end

    msg('{ffffff}������� �������� �� ������� ����������...')
    local pathupdate = getWorkingDirectory():gsub('\\','/') .. "/MVDHelper/infoupdate.json"
    os.remove(pathupdate)
    local url = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/infoupdate.json"
    downloadFile(url, pathupdate)
    local updateInfo = readJsonFile(pathupdate)
    if updateInfo then
        local uVer = updateInfo.current_version
        local uText = updateInfo.update_info
        if thisScript().version ~= uVer then
            msg('{ffffff}�������� ����������!')
            updateUrl = "https://raw.githubusercontent.com/DanielBagdasarian/MVD-Helper-Mobile/main/MVDHelper.lua"
            version = uVer
            textnewupdate = uText
            updateWin[0] = true
        else
            msg('{ffffff}���������� �� �����, � ��� ���������� ������!')
        end
    end
end
--Update END

--Logs START
function loadLog()
    local file = io.open("log.json", "r")
    if file then
        local jsonData = file:read("*all")
        if jsonData ~= "" then
            logs = decodeJson(jsonData) or {}
            file:close()
        else
            saveLog()
        end
    else
        saveLog()
    end
end

function saveLog()
    local file = io.open("log.json", "w")
    if file then
        file:write(encodeJson(logs))
        file:close()
    end
end

function addLogEntry(type, player, amount, duration)
    local entry = {
        time = os.date("%Y-%m-%d %H:%M:%S"),
        type = type,
        player = player,
        amount = amount,
        duration = duration
    }
    table.insert(logs, entry)
    saveLog()
end
imgui.OnFrame(function() return logsWin[0] end, function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(700, 200), imgui.Cond.FirstUseEver)
    imgui.Begin(u8 "����", logsWin)
    for _, log in ipairs(logs) do
        if log.type == "�����" then
            imgui.Text(u8(string.format(
                "�����: %s | ���: %s | �����: %s | �����: %s",
                log.time, log.type, log.player, log.amount
            )))
        else
            imgui.Text(u8(string.format(
                "�����: %s | ���: %s | �����: %s",
                log.time, log.type, log.player)))
        end
    end
    imgui.End()
end)
--Logs END

--Other windows START
imgui.OnFrame(
    function() return windowTwo[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "������ �������", windowTwo)
        imgui.InputInt(u8 'ID ������ � ������� ������ �����������������', id, 10)

        for i = 1, #tableUk["Text"] do
            if imgui.Button(u8(tableUk["Text"][i] .. ' ������� �������: ' .. tostring(tableUk["Ur"][i]))) then
                lua_thread.create(function()
                    sampSendChat("/do ����� ����� �� �����������.")
                    wait(1500)
                    sendMe(" ������ � �������� ��������� �����, ������� ������ � �������")
                    wait(1500)
                    sampSendChat("/su " .. id[0] .. " " .. tostring(tableUk["Ur"][i]) .. " " .. tableUk["Text"][i])
                    wait(1500)
                    sampSendChat("/do ������ ����� ��������� ������� ������� � ����������� ������.")
                end)
            end
        end
        imgui.End()
    end
)
local mainMenuFrame = imgui.OnFrame(function() return window[0] end, 
    function(player)
    imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
    imgui.SetNextWindowSize(imgui.ImVec2(mainIni.menuSettings.x * MDS, mainIni.menuSettings.y), imgui.Cond.FirstUseEver)
    imgui.Begin('##Window', window, imgui.WindowFlags.NoBackground + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize)
    MainWindowPos = imgui.GetWindowPos()
    MainWindowSize = imgui.GetWindowSize()
    if menuSizes[0] then
        imgui.SetWindowSizeVec2(imgui.ImVec2(mainIni.menuSettings.x * MDS, mainIni.menuSettings.y))
    end
    imgui.BeginChild('tabs', imgui.ImVec2(mainIni.menuSettings.tab, -1), true)
    p = imgui.GetCursorScreenPos()
    imgui.DrawFrames(MyGif, imgui.ImVec2(mainIni.menuSettings.tab - 30, 120), FrameTime[0])
    imgui.SetCursorPosY(170)
    imgui.Separator()
    for _, pageData in ipairs(pages) do
        imgui.SetCursorPosX(0)
        if imgui.PageButton(page == pageData.index, pageData.icon, u8(pageData.title), 173 * MDS - imgui.GetStyle().FramePadding.x * 2, 35 * MDS) then
            page = pageData.index
        end
    end
    imgui.CenterText("version " .. thisScript().version)
    imgui.EndChild()
    imgui.SameLine()
    imgui.BeginChild('workspace', imgui.ImVec2(-1, -1), true)
    local size = imgui.GetWindowSize()
    local pos = imgui.GetWindowPos()


    local tabSize = 50

    imgui.SetCursorPos(imgui.ImVec2(size.x - mainIni.menuSettings.xpos, 5))
    if imgui.Button('X##..##Window::closebutton', imgui.ImVec2(50, 50)) then
        if window then
            window[0] = false
        end
    end

    if page == 1 then
        if changingInfo then
            imgui.Text(u8 '��� ���: ' .. nickname)
            imgui.Text(u8 '���� �����������: ')
            imgui.SameLine()
            imgui.InputText("##����", orga, 255)
            imgui.Text(u8 '���� ���������: ')
            imgui.SameLine()
            imgui.InputText("##���������", dolzh, 255)

            if imgui.Button(u8 "��������� ������") then
                mainIni.Info.org = u8(u8:decode(ffi.string(orga)))
                mainIni.Info.dl = u8(u8:decode(ffi.string(dolzh)))
                if not deliting_script then saveIni() end
                msg("�������� ������� ���������!")
                changingInfo = false
            end
        else
            imgui.Text(u8 '��� ���: ' .. nickname)
            imgui.Text(u8 '���� �����������: ' .. mainIni.Info.org)
            imgui.Text(u8 '���� ���������: ' .. mainIni.Info.dl)
            if imgui.Button(u8 "�������� ������") then
                changingInfo = true
            end
        end
        if imgui.Button(u8 ' ��������� ����� ������') then
            setUkWindow[0] = not setUkWindow[0]
        end
        imgui.Separator()
        imgui.ToggleButton(u8 '���� ��������� ������', u8 '���� ��������� ������', autogun)
        if autogun[0] then
            if imgui.Button(u8 "��������� ��������� ������") then
                gunsWindow[0] = not gunsWindow[0]
            end
            mainIni.settings.autoRpGun = true
            lua_thread.create(function()
                while true do
                    wait(0)
                    if lastgun ~= getCurrentCharWeapon(PLAYER_PED) then
                        local gun = getCurrentCharWeapon(PLAYER_PED)
                        if gun == 3 then
                            sampSendChat(gunCommands[1])
                        elseif gun == 16 then
                            sampSendChat(gunCommands[2])
                        elseif gun == 17 then
                            sampSendChat(gunCommands[3])
                        elseif gun == 23 then
                            sampSendChat(gunCommands[4])
                        elseif gun == 22 then
                            sampSendChat(gunCommands[5])
                        elseif gun == 24 then
                            sampSendChat(gunCommands[6])
                        elseif gun == 25 then
                            sampSendChat(gunCommands[7])
                        elseif gun == 26 then
                            sampSendChat(gunCommands[8])
                        elseif gun == 27 then
                            sampSendChat(gunCommands[9])
                        elseif gun == 28 then
                            sampSendChat(gunCommands[10])
                        elseif gun == 29 then
                            sampSendChat(gunCommands[11])
                        elseif gun == 30 then
                            sampSendChat(gunCommands[12])
                        elseif gun == 31 then
                            sampSendChat(gunCommands[13])
                        elseif gun == 32 then
                            sampSendChat(gunCommands[14])
                        elseif gun == 33 then
                            sampSendChat(gunCommands[15])
                        elseif gun == 34 then
                            sampSendChat(gunCommands[16])
                        elseif gun == 43 then
                            sampSendChat(gunCommands[17])
                        elseif gun == 0 then
                            sampSendChat(gunCommands[18])
                        end
                        lastgun = gun
                    end
                end
            end)
        else
            mainIni.settings.autoRpGun = false
        end
        imgui.Separator()
        imgui.ToggleButton(u8 '����-������', u8 '����-������', AutoAccentBool)
        if AutoAccentBool[0] then
            AutoAccentCheck = true
            mainIni.settings.autoAccent = true
        else
            mainIni.settings.autoAccent = false
        end
        imgui.InputText(u8 '������', AutoAccentInput, 255)
        AutoAccentText = u8:decode(ffi.string(AutoAccentInput))
        mainIni.Accent.accent = AutoAccentText
        imgui.Separator()
        if imgui.ToggleButton(u8 '����������� ������ 10-55', u8 '����������� ������ 10-55', button_megafon) then
            mainIni.settings.button = button_megafon[0]
            megafon[0] = button_megafon[0]
        end
        imgui.Separator()
        imgui.ToggleButton(u8(mainIni.settings.ObuchalName) .. u8 ' ��������', u8(mainIni.settings.ObuchalName) .. u8 ' ��������', joneV)
        if joneV[0] then
            mainIni.settings.Jone = true
        else
            mainIni.settings.Jone = false
        end
        if imgui.InputText(u8 "��� �����������", ObuchalName, 255) then
            Obuchal = u8:decode(ffi.string(ObuchalName))
            mainIni.settings.ObuchalName = Obuchal
        end
        imgui.Separator()
        if imgui.Button(u8 "��������� ����") then
            menuSizes[0] = not menuSizes[0]
        end
        imgui.ColSeparator('F94242', 100)
        if imgui.ColoredButton(u8"������� ������", 'F94242', 90) then
            imgui.OpenPopup(u8'�� ������� ��� ������ ������� ������ � ��� ��� ���������?')
        end
        if imgui.ColoredButton(u8"�������� ��������� �������", 'F94242', 90) then
            imgui.OpenPopup(u8'�� ������� ��� ������ ������� ��� ��������� �������?')
        end
        if imgui.ColoredButton(u8"������������� ������", 'F94242', 90) then
            thisScript():reload()
        end
        if imgui.BeginPopupModal(u8'�� ������� ��� ������ ������� ������ � ��� ��� ���������?', _) then
            imgui.SetWindowSizeVec2(imgui.ImVec2(750, 300))
            if imgui.Button(u8'��', imgui.ImVec2(280, 80)) then
                deliting_script = true
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/buttons.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/Binder.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/gunCommands.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/smartUk.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/infoupdate.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper")
                os.remove(getWorkingDirectory():gsub('\\','/').."/config/MVDHelper.ini")
                os.remove(helper_path)
                msg("������ ������. ���� �� ��� ������� ��-�� ����� ��� ������ ��������� ���������� �������� �� ���� � �� @daniel2903_pon")
                thisScript():reload()
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if imgui.Button(u8'���', imgui.ImVec2(280, 80)) then
                imgui.CloseCurrentPopup()
            end
            imgui.End()
        end
        if imgui.BeginPopupModal(u8'�� ������� ��� ������ ������� ��� ��������� �������?', _) then
            imgui.SetWindowSizeVec2(imgui.ImVec2(750, 300))
            if imgui.Button(u8'��', imgui.ImVec2(280, 80)) then
                deliting_script = true
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/buttons.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/Binder.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/gunCommands.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/smartUk.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper/infoupdate.json")
                os.remove(getWorkingDirectory():gsub('\\','/').."/MVDHelper")
                os.remove(getWorkingDirectory():gsub('\\','/').."/config/MVDHelper.ini")
                msg("��������� ������� ��������.")
                thisScript():reload()
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if imgui.Button(u8'���', imgui.ImVec2(280, 80)) then
                imgui.CloseCurrentPopup()
            end
            imgui.End()
        end
        imgui.ColSeparator('F94242', 100)
        if not deliting_script then saveIni() end
    elseif page == 8 then
        if imgui.Button(u8 '���� ��������������') then
            patroolhelpmenu[0] = true
        end
        imgui.SameLine()
        if imgui.Button(u8 '������ ���-�� �������') then
            leaderPanel[0] = true
        end


        if imgui.Button(u8 '��� �������, ��������') then
            logsWin[0] = true
        end
        imgui.SameLine()
        if imgui.Button(u8 '������� �������') then
            settingsonline[0] = true
        end
        imgui.SameLine()
        if imgui.Button(u8 '��������������� ����') then
            suppWindow[0] = not suppWindow[0]
        end
        if imgui.Button(u8 '������ �������') then
            windowTwo[0] = not windowTwo[0]
        end
        imgui.ToggleButton(u8 "����� �� ����� /me �� �����", u8 "����� �� ����� /me �����", tochkaMe)
    
    elseif page == 2 then -- ������
        if imgui.BeginChild('##1', imgui.ImVec2(589 * MONET_DPI_SCALE, 303 * MONET_DPI_SCALE), true) then
            imgui.Columns(3)
            imgui.CenterColumnText(u8"�������")
            imgui.SetColumnWidth(-1, 170 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8"��������")
            imgui.SetColumnWidth(-1, 300 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8"��������")
            imgui.SetColumnWidth(-1, 150 * MONET_DPI_SCALE)
            imgui.Columns(1)
            imgui.Separator()
            imgui.Columns(3)
            imgui.CenterColumnText(u8 "/binder")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "������� ������� ���� �������")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "����������")
            imgui.Columns(1)
            imgui.Separator()
            imgui.Columns(3)
            imgui.CenterColumnText(u8 "/stop")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "���������� ����� ��������� �� �������")
            imgui.NextColumn()
            imgui.CenterColumnText(u8 "����������")
            imgui.Columns(1)
            imgui.Separator()
            for index, command in ipairs(settings.commands) do
                if not command.deleted then
                    imgui.Columns(3)
                    if command.enable then
                        imgui.CenterColumnText('/' .. u8(command.cmd))
                        imgui.NextColumn()
                        imgui.CenterColumnText(u8(command.description))
                        imgui.NextColumn()
                    else
                        imgui.CenterColumnTextDisabled('/' .. u8(command.cmd))
                        imgui.NextColumn()
                        imgui.CenterColumnTextDisabled(u8(command.description))
                        imgui.NextColumn()
                    end
                    imgui.Text(' ')
                    imgui.SameLine()
                    if command.enable then
                        if imgui.SmallButton(fa.TOGGLE_ON .. '##' .. command.cmd) then
                            command.enable = not command.enable
                            save_settings()
                            sampUnregisterChatCommand(command.cmd)
                        end
                        if imgui.IsItemHovered() then
                            imgui.SetTooltip(u8 "���������� ������� /" .. command.cmd)
                        end
                    else
                        if imgui.SmallButton(fa.TOGGLE_OFF .. '##' .. command.cmd) then
                            command.enable = not command.enable
                            save_settings()
                            register_command(command.cmd, command.arg, command.text, tonumber(command.waiting))
                        end
                        if imgui.IsItemHovered() then
                            imgui.SetTooltip(u8 "��������� ������� /" .. command.cmd)
                        end
                    end
                    imgui.SameLine()
                    if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. command.cmd) then
                        change_description = command.description
                        input_description = imgui.new.char[256](u8(change_description))
                        change_arg = command.arg
                        if command.arg == '' then
                            ComboTags[0] = 0
                        elseif command.arg == '{arg}' then
                            ComboTags[0] = 1
                        elseif command.arg == '{arg_id}' then
                            ComboTags[0] = 2
                        elseif command.arg == '{arg_id} {arg2}' then
                            ComboTags[0] = 3
                        end
                        change_cmd = command.cmd
                        input_cmd = imgui.new.char[256](u8(command.cmd))
                        change_text = command.text:gsub('&', '\n')
                        input_text = imgui.new.char[8192](u8(change_text))
                        change_waiting = command.waiting
                        waiting_slider = imgui.new.float(tonumber(command.waiting))
                        BinderWindow[0] = true
                    end
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(u8 "��������� ������� /" .. command.cmd)
                    end
                    imgui.SameLine()
                    if imgui.SmallButton(fa.TRASH_CAN .. '##' .. command.cmd) then
                        imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. command.cmd)
                    end
                    if imgui.IsItemHovered() then
                        imgui.SetTooltip(u8 "�������� ������� /" .. command.cmd)
                    end
                    if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. command.cmd, _, imgui.WindowFlags.NoResize) then
                        imgui.CenterText(u8 '�� ������������� ������ ������� ������� /' .. u8(command.cmd) .. '?')
                        imgui.Separator()
                        if imgui.Button(fa.CIRCLE_XMARK .. u8 ' ���, ��������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                            imgui.CloseCurrentPopup()
                        end
                        imgui.SameLine()
                        if imgui.Button(fa.TRASH_CAN .. u8 ' ��, �������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                            command.enable = false
                            command.deleted = true
                            sampUnregisterChatCommand(command.cmd)
                            save_settings()
                            imgui.CloseCurrentPopup()
                        end
                        imgui.End()
                    end
                    imgui.Columns(1)
                    imgui.Separator()
                end
            end
            imgui.EndChild()
        end
        if imgui.Button(fa.CIRCLE_PLUS .. u8 ' ������� ����� �������##new_cmd', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
            local new_cmd = {
                cmd = '',
                description = '����� ������� ��������� ����',
                text = '',
                arg = '',
                enable = true,
                waiting =
                '1.200',
                deleted = false
            }
            table.insert(settings.commands, new_cmd)
            change_description = new_cmd.description
            input_description = imgui.new.char[256](u8(change_description))
            change_arg = new_cmd.arg
            ComboTags[0] = 0
            change_cmd = new_cmd.cmd
            input_cmd = imgui.new.char[256](u8(new_cmd.cmd))
            change_text = new_cmd.text:gsub('&', '\n')
            input_text = imgui.new.char[8192](u8(change_text))
            change_waiting = 1.200
            waiting_slider = imgui.new.float(1.200)
            BinderWindow[0] = true
        end
        if imgui.BeginChild("buttons", imgui.ImVec2(589 * MONET_DPI_SCALE, 150), true) then
            imgui.Columns(3)
            imgui.CenterColumnText(u8"�������� ������")
            imgui.SetColumnWidth(-1, 170 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8"�����")
            imgui.SetColumnWidth(-1, 300 * MONET_DPI_SCALE)
            imgui.NextColumn()
            imgui.CenterColumnText(u8"��������")
            imgui.SetColumnWidth(-1, 150 * MONET_DPI_SCALE)
            imgui.Columns(1)
            imgui.Separator()
            
            for name, command in pairs(buttons) do
                imgui.Columns(3)
                imgui.CenterColumnText(u8(name))
                imgui.NextColumn()
                imgui.CenterColumnText(u8(command[1]))
                imgui.NextColumn()
                imgui.Text(" ")
                imgui.SameLine()
                if imgui.SmallButton(fa.PEN_TO_SQUARE .. '##' .. name) then
                    newButtonText = imgui.new.char[255](u8(name))
                    newButtonCommand = imgui.new.char[255](u8(arrayToText(command)))
                    imgui.OpenPopup(fa.CIRCLE_PLUS .. u8 ' ��������� ������ �� ������')            
                end
                if imgui.BeginPopupModal(fa.CIRCLE_PLUS .. u8 ' ��������� ������ �� ������', _, imgui.WindowFlags.NoResize) then
                    imgui.InputText(u8"�������� ������", newButtonText, 255)
                    imgui.InputTextMultiline(u8"�����", newButtonCommand, 2555)
                    if imgui.Button(u8"���������", imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                        deleteButton(name)
                        addNewButton(u8:decode(ffi.string(newButtonText)), u8:decode(ffi.string(newButtonCommand)))
                        imgui.CloseCurrentPopup()
                    end
                end
                imgui.SameLine()
                if imgui.SmallButton(fa.TRASH_CAN .. '##' .. name) then
                    imgui.OpenPopup(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. name)
                end
                if imgui.IsItemHovered() then
                    imgui.SetTooltip(u8 "�������� ������ " .. name)
                end
                imgui.Columns(1)
                imgui.Separator()
                if imgui.BeginPopupModal(fa.TRIANGLE_EXCLAMATION .. u8 ' �������������� ##' .. name, _, imgui.WindowFlags.NoResize) then
                    imgui.CenterText(u8 '�� ������������� ������ ������� ������ ' .. u8(name) .. '?')
                    imgui.Separator()
                    if imgui.Button(fa.CIRCLE_XMARK .. u8 ' ���, ��������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                        imgui.CloseCurrentPopup()
                    end
                    imgui.SameLine()
                    if imgui.Button(fa.TRASH_CAN .. u8 ' ��, �������', imgui.ImVec2(200 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
                        deleteButton(name)
                    end
                    imgui.End()
                end
            end
            imgui.EndChild()
        end
            if imgui.Button(fa.CIRCLE_PLUS .. u8" ����� ������") then
                imgui.OpenPopup(fa.CIRCLE_PLUS .. u8 ' �������� ����� ������ �� ������')            
            end
            

    elseif page == 3 then -- ����� ������������
        imgui.BeginChild('##depbuttons',
            imgui.ImVec2((imgui.GetWindowWidth() * 0.35) - imgui.GetStyle().FramePadding.x * 2, 0), true,
            imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse)
        imgui.TextColoredRGB(u8 '��� ����� �����������', 1)
        if imgui.InputText('##myorgnamedep', orgname, 255) then
            departsettings.myorgname = u8:decode(str(orgname))
        end
        imgui.TextColoredRGB(u8 '��� � ��� ������������')
        imgui.InputText('##toorgnamedep', otherorg, 255)
        imgui.Separator()
        if imgui.Button(u8 '����� �����.') then
            if #str(departsettings.myorgname) > 0 then
                sampSendChat('/d [' .. (str(departsettings.myorgname)) .. '] - [����]: ����� �����.')
            else
                msg('� ��� ���-�� �� �������.')
            end
        end
        imgui.Separator()
        imgui.TextColoredRGB(u8 '������� (�� �����������)')
        imgui.PushItemWidth(200)
        imgui.InputText('##frequencydep', departsettings.frequency, 255)
        imgui.PopItemWidth()

        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild('##deptext', imgui.ImVec2(-1, -1), true, imgui.WindowFlags.NoScrollbar)
        imgui.TextColoredRGB(u8 '������� ��������� ������������ {808080}(?)')
        imgui.Hint('mytagfind depart',
            u8 '���� � ���� ������������ ����� ��� \'' ..
            (str(departsettings.myorgname)) .. u8 '\'\n� ���� ������ ��������� ��� ���������')
        imgui.Separator()
        imgui.BeginChild('##deptextlist',
            imgui.ImVec2(-1,
                imgui.GetWindowSize().y - 30 * MDS - imgui.GetStyle().FramePadding.y * 2 - imgui.GetCursorPosY()), false)
        for k, v in pairs(dephistory) do
            imgui.TextColoredRGB('{5975ff}' .. (u8(v)))
        end
        imgui.EndChild()
        imgui.SetNextItemWidth(imgui.GetWindowWidth() - 100 * MDS - imgui.GetStyle().FramePadding.x * 2)
        imgui.InputText('##myorgtextdep', departsettings.myorgtext, 255)
        imgui.SameLine()
        if imgui.Button(u8 '���������', imgui.ImVec2(0, 30 * MDS)) then
            if #str(departsettings.myorgname) > 0 then
                if #str(departsettings.frequency) == 0 then
                    sampSendChat(('/d [%s] - [%s] %s'):format(str(departsettings.myorgname),
                        u8:decode(str(otherorg)), u8:decode(str(departsettings.myorgtext))))
                else
                    sampSendChat(('/d [%s] - %s - [%s] %s'):format(str(departsettings.myorgname),
                        u8:decode(str(departsettings.frequency)), u8:decode(str(otherorg)),
                        u8:decode(str(departsettings.myorgtext))))
                end
                imgui.StrCopy(departsettings.myorgtext, '')
            else
                msg('� ��� ���-�� �� �������!')
            end
        end
        imgui.EndChild()
    elseif page == 5 then -- �������
        allNotes()
        imgui.Separator()
        if imgui.Button(u8 "�������� ����� �������", imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
            imgui.StrCopy(newNoteTitle, "")
            imgui.StrCopy(newNoteContent, "")
            imgui.OpenPopup(u8 "�������� ����� �������")
            showAddNotePopup[0] = true
        end
        if imgui.BeginPopupModal(u8 "������������� �������", showEditWindow, imgui.WindowFlags.AlwaysAutoResize) then
            imgui.Text(u8 '�������� �������')
            imgui.InputText(u8 "##nazvanie", editNoteTitle, 256)
            imgui.Text(u8 "����� �������")
            imgui.InputTextMultiline(u8 "##2663737374", editNoteContent, 1024,
                imgui.ImVec2(579 * MONET_DPI_SCALE, 173 * MONET_DPI_SCALE))
            if imgui.Button(u8 "���������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 36)) then
                notes[selectedNote].title = ffi.string(editNoteTitle)
                notes[selectedNote].content = ffi.string(editNoteContent)
                showEditWindow[0] = false
                imgui.CloseCurrentPopup()
                selectedNote = nil
                saveNotesToFile()
            end
            imgui.SameLine()
            if imgui.Button(u8 "��������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 36)) then
                showEditWindow[0] = false
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8 "�������� ����� �������", showAddNotePopup, imgui.WindowFlags.AlwaysAutoResize) then
            imgui.Text(u8 '�������� ����� �������')
            imgui.InputText(u8 "##nazvanie2", newNoteTitle, 256)
            imgui.Text(u8 '����� ����� �������')
            imgui.InputTextMultiline(u8 "##123123123", newNoteContent, 1024, imgui.ImVec2(-1, 100))
            if imgui.Button(u8 "���������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 36)) then
                table.insert(notes, { title = ffi.string(newNoteTitle), content = ffi.string(newNoteContent) })
                imgui.StrCopy(newNoteTitle, "")
                imgui.StrCopy(newNoteContent, "")
                saveNotesToFile()
                showAddNotePopup[0] = false
                imgui.CloseCurrentPopup()
            end
            imgui.SameLine()
            if imgui.Button(u8 "�������", imgui.ImVec2(imgui.GetMiddleButtonX(2), 36)) then
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8 "�������", imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                imgui.StrCopy(newNoteTitle, "")
                imgui.StrCopy(newNoteContent, "")
                showAddNotePopup[0] = false
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
    elseif page == 6 then -- ����������
        imgui.Text(u8 '������: ' .. thisScript().version)
        imgui.Text(u8 '������������: @Sashe4ka_ReZoN, @daniel2903_pon')
        imgui.Text(u8 '�� �����: t.me/lua_arz')
        if imgui.IsItemClicked() then
            openLink("https://t.me/lua_arz")
        end
        imgui.Text(u8 '����������: �������� �� ��������')
        imgui.Text(u8 '��������: arzfun.com, @Negt, @King_Rostislavia, @sidrusha, @Timur77998, @osp_x, @Theopka')
    end
    imgui.EndChild()
    imgui.End()
end)
imgui.OnFrame(
    function() return suppWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(200, 150), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "��������������� ������", suppWindow,
            imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)

        imgui.Text(u8 '�����: ' .. os.date('%H:%M:%S'))
        imgui.Text(u8 '�����: ' .. os.date('%B'))
        imgui.Text(u8 '������ ����: ' .. arr.day .. '.' .. arr.month .. '.' .. arr.year)
        local positionX, positionY, positionZ = getCharCoordinates(PLAYER_PED)
        imgui.Text(u8 '�����:' .. u8(calculateZone(positionX, positionY, positionZ)))
        local p_city = getCityPlayerIsIn(PLAYER_PED)
        if p_city == 1 then pCity = u8 '��� - ������' end
        if p_city == 2 then pCity = u8 '��� - ������' end
        if p_city == 3 then pCity = u8 '��� - ��������' end
        if getActiveInterior() ~= 0 then pCity = u8 '�� ���������� � ���������!' end
        imgui.Text(u8 '�����: ' .. (pCity or u8 '����������'))
        imgui.End()
    end
)
imgui.OnFrame(
    function() return joneV[0] end,
    function(player)
        local resX, resY = getScreenResolution()
        local sizeX, sizeY = 350, 500
        imgui.SetNextWindowPos(imgui.ImVec2(resX / 2, resY - 200), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(sizeX, sizeY), imgui.Cond.FirstUseEver)
        imgui.Begin('Jone', joneV, imgui.WindowFlags.NoDecoration + imgui.WindowFlags.AlwaysAutoResize)
        -- imgui.ImageURL(
        --     "https://sun9-73.userapi.com/impf/c622023/v622023770/33fd/T9qIlEYed6o.jpg?size=320x427&quality=96&sign=bfc6230a550a94c075a5b0747a7c6bca&c_uniq_tag=Kl4qcaTNH2y8ypcpjcIMF7CDzDRlSY1rwm8e1dQD504&type=album",
        --     imgui.ImVec2(200, 200), true)
        if window[0] then
            imgui.SetWindowFocus()

            if page == 8 then
                imgui.SetWindowFocus()
                imgui.Text(u8 "��� - ��������� �������� ��������������.")
                imgui.Text(u8 "��� �� ��� ������ ����������� ��� ������� ������� �� ������(�������� ������)")
                if imgui.Button(u8 '����� >>', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                    page = 2
                end
            elseif page == 2 then
                imgui.SetWindowFocus()
                imgui.Text(u8 "� ��� - ���� �� ����� ������ �������!\n��� ������, � ������� �� ������\n��������� ���� �������\n� ��� �� �������� �������!")
                if imgui.Button(u8 '����� >>', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                    page = 3
                end
            elseif page == 3 then
                imgui.SetWindowFocus()
                imgui.Text(u8 "��� - ������� ���. �����\n��� �� ������ ����������� � �������������\n������� ���� ��� ����, ��� ����� �����������!")
                if imgui.Button(u8 '����� >>', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                    page = 5
                end
            elseif page == 5 then
                imgui.SetWindowFocus()
                imgui.Text(u8 "��� - ������� � ���������. ����� �� ������ �������� ��� ��� ������ � ���������� ��� � ����� ������")
                if imgui.Button(u8 '����� >>', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                    page = 6
                end
            elseif page == 6 then
                imgui.SetWindowFocus()
                imgui.Text(u8 "��� ��������� ���-� � ��� �������")
                if imgui.Button(u8 '����� >>') then
                    page = 1
                end
            elseif page == 1 then -- ���� �������� tab == 1
                imgui.SetWindowFocus()
                imgui.Text(u8 "��� - ������� � ������� �� ������ ���� ���������. �� ���� �������� ���� ��������� ��.\n��� �� ������ ������� ��� ���� �� ��� ��������� ���!\n��� ��� ���� ����� ���� MVD Helper. \n�� ������ ������� MoonMonet � ��������� ���� ����!")
                if imgui.Button(u8 '��������� ����', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                    joneV[0] = false
                    mainIni.settings.Jone = false
                    if not deliting_script then saveIni() end
                end
            
            end
        else
            imgui.Text(u8 "������! � " ..
                u8(mainIni.settings.ObuchalName) .. u8 ".\n� ������ ���� �������� �������� �\n��������.")
            if imgui.Button(u8 '����� >>', imgui.ImVec2(imgui.GetMiddleButtonX(1), 0)) then
                window[0] = true
            end
            imgui.End()
        end
    end
)
imgui.OnFrame(
    function() return megafon[0] end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 8.5, sizeY / 2.1), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.Begin("������� ����", megafon,
            imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar +
            imgui.WindowFlags.NoBackground)
        imgui.SameLine()
        if imgui.Button(fa.BULLHORN, imgui.ImVec2(75 * MONET_DPI_SCALE, 25 * MONET_DPI_SCALE)) then
            sampSendChat('/m ��������, ������� �������� � ���������� � �������.')
            sampSendChat('/m ����� ��������� ��������� ���������, ������� ���� �� ���� � �� �������� �� ����������.')
            sampSendChat('/m � ������ ������������ �� ��� ����� ������ �����!')
        end
        imgui.End()
    end
)
--Other windows END

--Start window START
local start = {
    custom = nil,
    step = 1
}
imgui.OnFrame(
    function() return startWindow[0] end,
    function()
        return true
    end,
    function(player)
        imgui.SetNextWindowPos(imgui.ImVec2(sizeX / 2, sizeY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "������", startWindow)
        if start.step == 1 then
            if start.custom == nil then
                imgui.Text(u8"������! ������� �� ������� ���������� ������. ����� ������ �������� ���.")
                imgui.Text(u8"������ ����� ���������: ")
                if imgui.Button(u8"��������������(�� ����� ����������) "..fa["WAND_MAGIC"]) then
                    start.custom = "auto"
                end
                if imgui.Button(u8"������ "..fa["PEN"]) then
                    start.custom = "ruch"
                end

            elseif start.custom == "auto" then
                while not nickname do
                    imgui.TextDisabled(u8"�������� ���������� �� ����������...")
                end
                imgui.Text(u8"���������� �� ���������� ��������. ��������� ������������")
                imgui.Separator()
                imgui.Text(u8"��� Nick_Name:" .. nickname)
                if u8:decode(org) == '�� �� �������� � ��' then
                    imgui.Text(u8"�������, �� �� �������� � ��. �� �� ��� ����� ������ ������������ ������.")
                else
                    imgui.Text(u8"���� �����������: " .. org .. u8"(���������� - " .. org_g .. ")")
                    imgui.Text(u8"���� ���������: " .. dl .. "[".. rang_n .."]")
                end
                if imgui.Button(u8"���������� "..fa["RIGHT_LONG"]) then
                    mainIni.Info.org = org_g
                    mainIni.Info.rang_n = rang_n
                    mainIni.Info.dl = dl
                    if not deliting_script then saveIni() end
                    start.step = 2
                end

            elseif start.custom == "ruch" then

            end

        elseif start.step == 2 then
            imgui.Text(u8"�������! ������ ����� �������� ������� ���� �������!")
            imgui.Text(u8"�� ������� ������� ������� ����, ����, ������� �������������� ���� � ��.")
            if imgui.Button(u8"������� ��������� � ����") then
                menuSizes[0] = true
                window[0] = true
            end
            if imgui.Button(u8"��������� � ���������� "..fa["RIGHT_LONG"]) then
                window[0] = false
                menuSizes[0] = false
                start.step = 3
            end

        elseif start.step == 3 then
            imgui.Text(u8"�������! ������ ����� �������� ����� ������� ��� ���� - ��������� ������.")
            if imgui.Button(u8"���������") then
                setUkWindow[0] = not setUkWindow[0]
            end
            if imgui.Button(u8"������, ���������� "..fa["RIGHT_LONG"]) then
                setUkWindow[0] = false
                start.step = 4
            end

        elseif start.step == 4 then
            imgui.Text(u8"��� ����� ���������! �������� ����-����")
            imgui.Text(u8"������ ����� �������� �������������� �� ��������� ������.")
            imgui.ToggleButton(u8 '���� ��������� ������', u8 '���� ��������� ������', autogun)
            if autogun[0] then
                mainIni.settings.autoRpGun = true
                if not deliting_script then saveIni() end
                if imgui.Button(u8 "������� ��������� ��������� ������") then
                    gunsWindow[0] = not gunsWindow[0]
                end
            end
            if imgui.Button(u8"���������� "..fa["RIGHT_LONG"]) then
                start.step = 5
            end

        elseif start.step == 5 then
            imgui.Text(u8"����������, ��������� ������� ���������. ��� ������ ������ ��������� �� ������ �������� �� ������� �������� � ������� ����.")
            imgui.Text(u8"���� ������ ���������� �������� �� �������� ����, �� ������� ����������!")
            imgui.ToggleButton(u8(mainIni.settings.ObuchalName) .. u8 ' ��������', u8(mainIni.settings.ObuchalName) .. u8 ' ��������', joneV)
            if imgui.Button(fa["XMARK"].. u8" ������� ��� ���� " .. fa["XMARK"]) then
                startWindow[0] = false
            end
        end
        imgui.End()
    end
)
--Start window END

--MAIN
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
    while not sampIsLocalPlayerSpawned() do wait(100) end
    load_settings()
    server = servers[sampGetCurrentServerAddress()] and servers[sampGetCurrentServerAddress()].name or "Unknown"
    myId = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
    buttons = readButtons()
    loadNotesFromFile()
    timerMain()
    check_update()
    loadCommands()
    loadButtons()
    loadLog()
    sampRegisterChatCommand('mvd', function()
        window[0] = not window[0]
    end)
    sampRegisterChatCommand('spawncars', spcars)
    sampRegisterChatCommand('toset', function()
        settingsonline[0] = not settingsonline[0]
    end)
    sampRegisterChatCommand("su", cmd_su)
    sampRegisterChatCommand("stop",function()
        if isActiveCommand then
            command_stop = true
        else
            sampAddChatMessage(
                '[Binder] {ffffff}������, ������ ���� �������� ���������!', message_color)
        end 
    end)
    registerCommandsFrom(settings.commands)
    msg("������ ������� ��������! Telegram-�����: @lua_arz. ��� ��������� arzfun.com")
    if spawn then
        sampSendChat("/stats")
    end 
    sampRegisterChatCommand("autoz", cmd_z)
    while true do
        wait(0)
        if not fastVzaimWindow[0] and not vzaimWindow[0] then
            if #get_players_in_radius() >= 1 then
                vzWindow[0] = true
            else
                vzWindow[0] = false
            end
        end
        if search then
            local res, handle = sampGetCharHandleBySampPlayerId(pid)
            if res then
                local x, y, z = getCharCoordinates(handle)
                local mX, mY, mZ = getCharCoordinates(PLAYER_PED)
                if getDistanceBetweenCoords3d(x, y, z, mX, mY, mZ) < 30 then
                    sampSendChat(string.format('/z %d', pid))
                    printStringNow('~b~trying send /z', 1500)
                    wait(500)
                end
            else
                msg("����� ������ ���� � ���� ������!")
                search = false
            end
        end
    end
end

--Auto /z
function cmd_z(id)
    if id ~= nil then
        search = not search
        if search then
            local playerId = tonumber(id)
            if playerId ~= nil and sampIsPlayerConnected(playerId) then
                pid = playerId
                msg('��� ������.') 
            else
                search = false
                msg('���� �� ����� ������������ ��������, ���� ����� �� ������.') 
            end
        else
            msg('��������� �����.') 
        end
    else

    end
end