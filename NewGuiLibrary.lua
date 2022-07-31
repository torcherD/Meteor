local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/eixotic07/Meteor/main/NewGuiLibrary.lua"))()

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
local servCollec = game:GetService("CollectionService")

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

local CFrameNew = CFrame.new
local cam = workspace.CurrentCamera

-- Reenable non exec cons
local function enec(id)
local signals = disabled_signals[id]

if (signals == nil or #signals == 0) then return end

for i = 1, #signals do 
local connection = signals[i]
local confunc = connection.Function

if (type(confunc) == 'function' and islclosure(confunc) and not isexecclosure(confunc)) then
connection:Enable()
end
end

tabClear(disabled_signals[id])
end

local function dnec(signal) 
    local s = {}
    for _, con in ipairs(getconnections(signal)) do 
        local func = con.Function
        if (func and islclosure(func)) then
            if (not is_synapse_function(func)) then 
                s[#s+1] = con
                con:Disable() 
            end
        end
    end
    return s
end

local scriptCons = {}

-- Locals


local clientPlayer = servPlayers.LocalPlayer
local clientMouse = clientPlayer:GetMouse()
local clientChar = clientPlayer.Character
local clientRoot, clientHumanoid do 
scriptCons.charRespawn = clientPlayer.CharacterAdded:Connect(function(newChar) 
clientChar = newChar
clientRoot = newChar:WaitForChild('HumanoidRootPart', 10)
clientHumanoid = newChar:WaitForChild('Humanoid', 10)

end)

if (clientChar) then 
clientRoot = clientChar:FindFirstChild('HumanoidRootPart')
clientHumanoid = clientChar:FindFirstChild('Humanoid')
end
end
local clientCamera do 
clientCamera = workspace.CurrentCamera or workspace:FindFirstChildOfClass('Camera')
scriptCons.cameraUpdate = workspace:GetPropertyChangedSignal('CurrentCamera'):Connect(function() 
clientCamera = workspace.CurrentCamera or workspace:FindFirstChildOfClass('Camera')

end)
end

local function Cape(char, texture)
for i,v in pairs(char:GetDescendants()) do
if v.Name == "Cape" then
	v:Remove()
end
end
local hum = char:WaitForChild("Humanoid")
local torso = nil
if hum.RigType == Enum.HumanoidRigType.R15 then
torso = char:WaitForChild("UpperTorso")
else
torso = char:WaitForChild("Torso")
end
local p = Instance.new("Part", torso.Parent)
p.Name = "Cape"
p.Anchored = false
p.CanCollide = false
p.TopSurface = 0
p.BottomSurface = 0
p.FormFactor = "Custom"
p.Size = Vector3.new(0.2,0.2,0.2)
p.Transparency = 1
local decal = Instance.new("Decal", p)
decal.Texture = texture
decal.Face = "Back"
local msh = Instance.new("BlockMesh", p)
msh.Scale = Vector3.new(9,17.5,0.5)
local motor = Instance.new("Motor", p)
motor.Part0 = p
motor.Part1 = torso
motor.MaxVelocity = 0.01
motor.C0 = CFrame.new(0,2,0) * CFrame.Angles(0,math.rad(90),0)
motor.C1 = CFrame.new(0,1,0.45) * CFrame.Angles(0,math.rad(90),0)
local wave = false
repeat wait(1/44)
decal.Transparency = torso.Transparency
local ang = 0.1
local oldmag = torso.Velocity.magnitude
local mv = 0.002
if wave then
	ang = ang + ((torso.Velocity.magnitude/10) * 0.05) + 0.05
	wave = false
else
	wave = true
end
ang = ang + math.min(torso.Velocity.magnitude/11, 0.5)
motor.MaxVelocity = math.min((torso.Velocity.magnitude/111), 0.04) --+ mv
motor.DesiredAngle = -ang
if motor.CurrentAngle < -0.2 and motor.DesiredAngle > -0.2 then
	motor.MaxVelocity = 0.04
end
repeat wait() until motor.CurrentAngle == motor.DesiredAngle or math.abs(torso.Velocity.magnitude - oldmag) >= (torso.Velocity.magnitude/10) + 1
if torso.Velocity.magnitude < 0.1 then
	wait(0.1)
end
until not p or p.Parent ~= torso.Parent
end


local getasset = getcustomasset or getsynasset

local betterfile = function(file)
  local suc, res = pcall(function() return readfile(file) end) return suc and res ~= nil
end

local requestfunction = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
  if tab.Method == "GET" then
      return { Body = game:HttpGet(tab.Url, true), Headers = {}, StatusCode = 200 }
  else
      return { Body = "bad exploit", Headers = {}, StatusCode = 404 }
  end
end  

local assetstab = {}
function getcustomasset(path, name)
  if betterfile(path) then
      if assetstab[path] == nil then
          assetstab[path] = getasset(path)
      end
      return assetstab[path]
  end
  if not isfile(path) then
      spawn(function()
          local ScreenGuii = Instance.new("ScreenGui")
          ScreenGuii.Parent = game.CoreGui
          ScreenGuii.Name = "Download"
          
          local text = Instance.new("TextLabel")
          text.Size = UDim2.new(1, 0, 0, 36)
          text.Text = "Downloading "..path
          text.BackgroundTransparency = 1
          text.TextStrokeTransparency = 0
          text.TextSize = 30
          text.Font = Enum.Font.SourceSans
          text.TextColor3 = Color3.new(1, 1, 1)
          text.Position = UDim2.new(0, 0, 0, -36)
          text.Parent = ScreenGuii
          repeat wait(1) until isfile(path)
          text:remove()
          ScreenGuii:remove()
      end)
      makefolder("Meteor/assets")
      local req = "https://raw.githubusercontent.com/eixotic07/Meteor/main/assets/"..name ..".png"
      writefile(path,game:HttpGet(req))
  end
  if assetstab[path] == nil then
      assetstab[path] = getasset(path)
  end
  return assetstab[path]
end


local lplr = game.Players.LocalPlayer
local cam = workspace.CurrentCamera


-- Bedwars Stuff


local function getremote(tab)
    for i,v in pairs(tab) do
        if v == "Client" then
            return tab[i + 1]
        end
    end
    return ""
end


local Client = require(game:GetService("ReplicatedStorage").TS.remotes).default.Client
local KnitClient = debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)

local ClientStoreHandle = require(lplr.PlayerScripts.TS.ui.store).ClientStore

local BedwarsControllers = {
    SprintControl = require(game:GetService("Players").LocalPlayer.PlayerScripts.TS.controllers.global.sprint["sprint-controller"]).SprintController,
    ItemStuff = debug.getupvalue(require(game:GetService("ReplicatedStorage").TS.item["item-meta"]).getItemMeta, 1),
    InventoryUtil = require(game:GetService("ReplicatedStorage").TS.inventory["inventory-util"]).InventoryUtil,
    FunnyController = KnitClient.Controllers.PaintShotgunController,
    FovController = KnitClient.Controllers.FovController,
    ItemDropController = KnitClient.Controllers.ItemDropController,
    InviteController = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"].lobby.out.client.controllers["party-controller"]).PartyController,
    NotificationController = require(game:GetService("ReplicatedStorage")["rbxts_include"]["node_modules"]["@easy-games"]["game-core"].out.client.controllers["notification-controller"]).NotificationController,
    DamageIndicator = KnitClient.Controllers.DamageIndicatorController.spawnDamageIndicator,
}

local BedwarsConst = {
    FunnyConst = require(game.ReplicatedStorage.TS.games.bedwars.items["paint-shotgun"]["paint-shotgun-constants"]).PaintShotgunConstants
}

local BedwarsRemotes = {
    FunnyRemote = Client:Get(getremote(debug.getconstants(BedwarsControllers.FunnyController.fire, 3))),
    AttackRemote = Client:Get(getremote(debug.getconstants(getmetatable(KnitClient.Controllers.SwordController)["attackEntity"]))),
    ProjectileRemote = getremote(debug.getconstants(debug.getupvalues(getmetatable(KnitClient.Controllers.ProjectileController)["launchProjectileWithValues"])[2])),
    DropRemote = Client:Get(getremote(debug.getconstants(BedwarsControllers.ItemDropController.dropItemInHand, 3))),
}

local matchState = 1




function getinv(plr)
    local plr = plr or lplr
    local invUtil1, invUtil2 = pcall(function() return BedwarsControllers.InventoryUtil.getInventory(plr) end)
    return (invUtil1 and invUtil2 or { items = {}, armor = {}, hand = nil })
end


function getsword()
    local SwordDamage
    local HighDamage
    local SwordSlots
    local Swords = getinv().items
    for i, v in pairs(Swords) do
        if v.itemType:lower():find("sword") or v.itemType:lower():find("blade") then
            if HighDamage == nil or BedwarsControllers.ItemStuff[v.itemType].sword.damage > HighDamage then
                SwordDamage = v
                HighDamage = BedwarsControllers.ItemStuff[v.itemType].sword.damage
                SwordSlots = i
            end
        end
    end
    return SwordDamage, SwordSlots
end

local function hvFunc(val)
    return {hashval = val}
end

local isAlivePlr
function isAlive(plr)
    isAlivePlr = plr or lplr
    if isAlivePlr.Character and isAlivePlr.Character:FindFirstChild("HumanoidRootPart") and isAlivePlr.Character:FindFirstChild("Humanoid") and isAlivePlr.Character.Humanoid.Health > 0 then
        return true
        else
        return false
    end
end

local function playanimation(id) 
    if isAlive() then 
        local animation = Instance.new("Animation")
        animation.AnimationId = id
        local animatior = lplr.Character.Humanoid.Animator
        animatior:LoadAnimation(animation):Play()
    end
end


function KillauraRemote()
    for i,v in pairs(game.Players:GetChildren()) do
        if matchState ~= 0 and isAlive() and isAlive(v) and v ~= game.Players.LocalPlayer then
            if (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude < DistanceValue and v.Team ~= game.Players.LocalPlayer.Team and isAlive(v) then
                selfPosition = lplr.Character.HumanoidRootPart.Position + (DistanceValue > 14 and (lplr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude > 14 and (CFrame.lookAt(lplr.Character.HumanoidRootPart.Position, v.Character.HumanoidRootPart.Position).lookVector * 4) or Vector3.new(0, 0, 0))
                Entity = v.Character
                target = v.Character:GetPrimaryPartCFrame().Position
                local Attacked2 = BedwarsRemotes.AttackRemote:CallServer({["chargedAttack"] = { ["chargeRatio"] = 0 },
                    ["entityInstance"] = Entity,
                    ["validate"] = {
		                ["targetPosition"] = {
		                ["value"] = target
		               },
		               ["selfPosition"] = {
		                ["value"] = selfPosition
	                }
    	           },
                    ["weapon"] = getsword() ~= nil and getsword().tool
                })
            end
        end
    end
end

function FunnyKillAuraRemote(FunnyDistance)
    for i,v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer and isAlive() and isAlive(v) then
            if (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude < FunnyDistance and v.Team ~= game.Players.LocalPlayer.Team then
                wait(0.1)
                BedwarsRemotes.FunnyRemote:SendToServer(v.Character:GetPrimaryPartCFrame().Position, v.Character.HumanoidRootPart.CFrame.LookVector);
            end
        end
    end
end

function CrashAuraRemote(CrashDistance)
    for i,v in pairs(game.Players:GetPlayers()) do
        if v ~= lplr and isAlive() and isAlive(v) then
            if (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude < CrashDistance and v.Team ~= game.Players.LocalPlayer.Team then
                BedwarsControllers.InviteController.invitePlayer(nil, v)
                wait(0.1)
                BedwarsControllers.InviteController.leaveParty()
            end
        end
    end
end


function GetMapName()
    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
        if v.Name == "Map" then
            if v:FindFirstChild("Worlds") then
                for i, v in pairs(v.Worlds:GetChildren()) do
                    if v.Name ~= "Void_World" then
                        return v.Name
                    end
		        end
		    end
		end
	end
end

local MapName = GetMapName()


local ClosetBlock = {Distance = math.huge}
function GetBlock(bedArgs)
    AboveBlock = 0
    for i,v in pairs(game:GetService("Workspace").Map.Worlds[MapName].Blocks:GetChildren()) do
        --if v.Name ~= "bed" and (v.Position - bedArgs).Magnitude < 9 then
            --if (v.Position - bedArgs).Magnitude < ClosetBlock.Distance then
                
            if v.Position.X == bedArgs.X and v.Position.Z == bedArgs.Z and v.Name ~= "bed" and (v.Position.Y - bedArgs.Y) <= 9 and v.Position.Y > bedArgs.Y then
            AboveBlock = AboveBlock + 1
        end
    end
    return AboveBlock
end


function DestroyNearestBeds()
    for i, v in pairs(game:GetService("Workspace").Map.Worlds[MapName].Blocks:GetChildren()) do
        if isAlive() and v.Name == "bed" and v.Covers.BrickColor ~= game.Players.LocalPlayer.Team.TeamColor and isAlive() then
            if (v.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).Magnitude < 30 then
                bedX = math.round(v.Position.X / 3)
                bedY = math.round(v.Position.Y / 3) + GetBlock(v.Position)
                bedZ = math.round(v.Position.Z / 3)
                game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.DamageBlock:InvokeServer({
                    ["blockRef"] = {
                        ["blockPosition"] = Vector3.new(bedX, bedY, bedZ)
                    }, 
                ["hitPosition"] = Vector3.new(bedX, bedY, bedZ), 
                ["hitNormal"] = Vector3.new(bedX, bedY, bedZ)})
            wait(0.1)
            end
        end
    end
end

function StealChest()
    for i,v in pairs(game.Workspace.Map.Worlds[mapName]:GetChildren()) do
        if v.Name == "chest" then
            if v:FindFirstChild("ChestFolderValue") then
                if (lplr.Character.HumanoidRootPart.Position - v.Position).Magnitude < 45 then
                    for i,k in pairs(v.ChestFolderValue.Value:GetChildren()) do
                        if k.Name ~= "ChestOwner" then
                            -- This script was generated by Hydroxide's RemoteSpy: https://github.com/Upbolt/Hydroxide

--local ohInstance1 = game:GetService("ReplicatedStorage").Inventories.BlockChest
--local ohInstance2 = .stone_sword --[[ PARENTED TO NIL OR DESTROYED ]]

--game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged["Inventory:ChestGetItem"]:InvokeServer(ohInstance1, ohInstance2)
                        end
                    end
                end
            end
        end
    end
end

function FPSBoost()
    for i,v in pairs(servCollec:GetTagged("block")) do
        v.Material = Enum.Material.Fabric
        for i,v in pairs(v:GetChildren()) do
            if v:IsA("Texture") then
                v.Transparency = 1
            end
        end
    end
end

function UnFPSBoost()
    for i,v in pairs(servCollec:GetTagged("block")) do
        v.Material = Enum.Material.Fabric
        for i,v in pairs(v:GetChildren()) do
            if v:IsA("Texture") then
                v.Transparency = 0
            end
        end
    end
end

function DupeItems()
    for i,v in pairs(game.ReplicatedStorage.Inventories:GetChildren()) do
        if v.Name == lplr.Name and v then
            for i,v in pairs(v:GetChildren()) do
                local ItemDroped = BedwarsRemotes.DropRemote.instance:InvokeServer({ ["item"] = v, ["amount"] = 1 - tostring(9e9/0) })
                if ItemDroped then
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if v ~= lplr and v.Team ~= lplr.Team then
                            ItemDroped.CFrame = v.Character.HumanoidRootPart.CFrame
                        end
                    end
                end
            end
        end
    end
end

local CustomAnims = {
    Normal = {
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
        {CFrame = CFrameNew(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
    },
    Slow = {
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.15},
        {CFrame = CFrameNew(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.15}
    },
    ["Vertical Spin"] = {
        {CFrame = CFrameNew(0, 0, 0) * CFrame.Angles(math.rad(-90), math.rad(8), math.rad(5)), Time = 0.1},
        {CFrame = CFrameNew(0, 0, 0) * CFrame.Angles(math.rad(180), math.rad(3), math.rad(13)), Time = 0.1},
        {CFrame = CFrameNew(0, 0, 0) * CFrame.Angles(math.rad(90), math.rad(-5), math.rad(8)), Time = 0.1},
        {CFrame = CFrameNew(0, 0, 0) * CFrame.Angles(math.rad(0), math.rad(-0), math.rad(-0)), Time = 0.1}
    },
    Exhibition = {
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.1},
        {CFrame = CFrameNew(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.2}
    },
    ["Exhibition Old"] = {
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.15},
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(-30), math.rad(50), math.rad(-90)), Time = 0.05},
        {CFrame = CFrameNew(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.1},
        {CFrame = CFrameNew(0.7, -0.71, 0.59) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.05},
        {CFrame = CFrameNew(0.63, -0.1, 1.37) * CFrame.Angles(math.rad(-84), math.rad(50), math.rad(-38)), Time = 0.15}
    },
    ["Air Swing"] = {
        {CFrame = CFrameNew(5, -1, -1) * CFrame.Angles(math.rad(-40), math.rad(0), math.rad(0)), Time = 0.05},
        {CFrame = CFrameNew(5, -0.7, -1) * CFrame.Angles(math.rad(-120), math.rad(20), math.rad(-10)), Time = 0.05},
    },
    ["Meteor"] = {
        {CFrame = CFrameNew(5, -3, 2) * CFrame.Angles(math.rad(120), math.rad(160), math.rad(140)), Time = 0.12},
        {CFrame = CFrameNew(5, -2.5, -1) * CFrame.Angles(math.rad(80), math.rad(180), math.rad(180)), Time = 0.12},
        {CFrame = CFrameNew(5, -3.4, -3.3) * CFrame.Angles(math.rad(45), math.rad(160), math.rad(190)), Time = 0.12},
        {CFrame = CFrameNew(5, -2.5, -1) * CFrame.Angles(math.rad(80), math.rad(180), math.rad(180)), Time = 0.12},
    },
    Jello = {
        {CFrame = CFrameNew(0.69, -0.7, 0.6) * CFrame.Angles(math.rad(295), math.rad(55), math.rad(290)), Time = 0.05},
        {CFrame = CFrameNew(0.69, -0.71, 0.6) * CFrame.Angles(math.rad(200), math.rad(60), math.rad(1)), Time = 0.05}
    },
    ["Slow Tap"] = {
        {CFrame = CFrameNew(5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), Time = 0.25},
        {CFrame = CFrameNew(5, -1, -0.3) * CFrame.Angles(math.rad(-100), math.rad(-30), math.rad(10)), Time = 0.25}
    },
    ["Fast Tap"] = {
        {CFrame = CFrameNew(5, -1, 0) * CFrame.Angles(math.rad(0), math.rad(0), math.rad(10)), Time = 0.2},
        {CFrame = CFrameNew(5, -1, -0.3) * CFrame.Angles(math.rad(-100), math.rad(-30), math.rad(10)), Time = 0.05}
    },
    ["Extend"] = {
        {CFrame = CFrameNew(3, 0, 1) * CFrame.Angles(math.rad(-60), math.rad(30), math.rad(-40)), Time = 0.2},
        {CFrame = CFrameNew(3.3, -.2, 0.7) * CFrame.Angles(math.rad(-70), math.rad(10), math.rad(-20)), Time = 0.2},
        {CFrame = CFrameNew(3.8, -.2, 1.3) * CFrame.Angles(math.rad(-80), math.rad(0), math.rad(-20)), Time = 0.1},
        {CFrame = CFrameNew(3, .3, 1.3) * CFrame.Angles(math.rad(-90), math.rad(0), math.rad(-20)), Time = 0.07},
        {CFrame = CFrameNew(3, .3, .8) * CFrame.Angles(math.rad(-90), math.rad(10), math.rad(-40)), Time = 0.07},
    },
}




local m_meteor = ui:newMenu("Configs")
local m_combat = ui:newMenu('Combat')
local m_player= ui:newMenu('Player')
local m_exploit = ui:newMenu("Exploits")
local m_render = ui:newMenu('Render')
local m_world = ui:newMenu('World')


local p_speed = m_player:addMod("Speed")
local p_speed2 = m_player:addMod("Speed V2")
local p_fly = m_player:addMod("Fly")
local p_ljump = m_player:addMod("Long Jump")
local p_hjump = m_player:addMod("Hight Jump")
local p_sprint = m_player:addMod("Sprint")
local m_float = m_player:addMod('Float')
local p_nofall = m_player:addMod("NoFall")

local c_killaura = m_combat:addMod("Kill Aura")

local r_fov = m_render:addMod("FOV")
local r_fps = m_render:addMod("FPS Boost")
local r_cape = m_render:addMod("Cape")

local w_antiVoid = m_world:addMod("Anti Void")
local w_chestS = m_world:addMod("Chest Stealer")
local w_nuker = m_world:addMod("Nuker")

local m_modlist = m_meteor:addMod("Mod List")


-- Speed
local d_speed = p_speed:addSlider("Speed", {min = 1, cur = 1.8, max = 5.7, step = 0.1})

--
local s_sprint = p_sprint:addSlider("Sprint Boost", {min = 1, cur = 1, max = 2, step = 0.01})

-- Float
local f_vel = m_float:addSlider('Velocity',{min = -10, cur = 0, max = 10, step = 0.1}):setTooltip('The amount of velocity you\'ll have when floating')

-- Fly
local fly_vel = p_fly:addSlider("Velocity", {min = 1, cur = 20, max = 50, step = 0.1})

-- Hight Jump
local hj_force = p_hjump:addSlider("Force", {min = 10, cur = 40, max = 100, step = 1})

-- KillAura
local k_funny = c_killaura:addToggle("Multi Aura")
local k_crash = c_killaura:addToggle("Crash Aura")
local k_sound = c_killaura:addToggle("Swing Sound")
local k_sound2 = c_killaura:addSlider("Sound", {min = 0, cur = 0.2, max = 1, step = 0.1})
local k_anim = c_killaura:addToggle("Custom Animation")
local k_swingAnim = c_killaura:addDropdown("Swing Animation")
local k_distance = c_killaura:addSlider("Distance", {min = -1, cur = 18, max = 24, step = 1})
local k_cdistance = c_killaura:addSlider("Crash Distance", {min = 16, cur = 56, max = 100, step = 1})

-- FOV
local f_value = r_fov:addSlider("Fov Value", {min = 80, cur = 120, max = 120, step = 1})

-- Anti Void
local av_trans = w_antiVoid:addSlider("Transparency", {min = 0, cur = 0.4, max = 1, step = 0.001})

-- ModList
local ModListCorner = m_modlist:addDropdown('Corner'):setTooltip('The corner the modlist is in')


k_swingAnim:addOption("Normal")
k_swingAnim:addOption("Slow")
k_swingAnim:addOption("Vertical Spin")
k_swingAnim:addOption("Exhibition")
k_swingAnim:addOption("Exhibition Old")
k_swingAnim:addOption("Air Swing")
k_swingAnim:addOption("Meteor"):Select()
k_swingAnim:addOption("Extend")
k_swingAnim:addOption("Jello")
k_swingAnim:addOption("Slow Tap")
k_swingAnim:addOption("Fast Tap")

ModListCorner:addOption('Top left'):setTooltip('Sets the modlist to be at the top left')
ModListCorner:addOption('Top right'):setTooltip('Sets the modlist to be at the top right')
ModListCorner:addOption('Bottom left'):setTooltip('Sets the modlist to be at the bottom left; default option'):Select()
ModListCorner:addOption('Bottom right'):setTooltip('Sets the modlist to be at the bottom right')


AntiVoidTrans = av_trans:getValue()
SelectedAnim = k_swingAnim:GetSelection()
DistanceValue = k_distance:getValue()
FlyVelocity = fly_vel:getValue()
FloatVelocity = f_vel:getValue()
SpeedVal = d_speed:getValue()
FunnyAura = k_funny:getValue()
SprintBoostVal = s_sprint:getValue()
CrashAura = k_crash:getValue()
CrashDistanceVal = k_cdistance:getValue()
KillAuraAnim = k_anim:getValue()
FovValue = f_value:getValue()
ModListSelected = ModListCorner:GetSelection()
HJForce = hj_force:getValue()

s_sprint:Connect("Changed", function(v)
    SprintBoostVal = v
    s_sprint:Reset()
end)

f_value:Connect("Changed", function(v)
    FovValue = v
    r_fov:Reset()
end)

av_trans:Connect("Changed", function(v)
    AntiVoidTrans = v
    w_antiVoid:Reset()
end)

ModListCorner:Connect('Changed',function(v) 
    m_modlist:Reset()
    ModListSelected = v
end)

d_speed:Connect("Changed", function(v)
    SpeedVal = v
end)

f_vel:Connect("Changed", function(v)
    FloatVelocity = v
end)

fly_vel:Connect("Changed", function(v)
    FlyVelocity = v
end)

k_funny:Connect("Toggled", function(v)
    FunnyAura = v
    c_killaura:Reset()
end)

k_crash:Connect("Toggled", function(v)
    CrashAura = v
    c_killaura:Reset()
end)

k_distance:Connect("Changed", function(v)
    DistanceValue = v
end)

k_cdistance:Connect("Changed", function(v)
    CrashDistanceVal = v
end)

k_anim:Connect("Toggled", function(v)
    KillAuraAnim = v
end)

k_swingAnim:Connect("Changed", function(v)
    SelectedAnim = v
    c_killaura:Reset()
end)

hj_force:Connect("Changed", function(v)
    HJForce = v
end)

-- COMBAT
local origC0 = game.ReplicatedStorage.Assets.Viewmodel.RightHand.RightWrist.C0
local oldErrorNotification = BedwarsControllers.NotificationController.sendErrorNotification
c_killaura:Connect("Toggled", function(t)
    if (t) then
        servRun:BindToRenderStep("KillAura", 0, function(v)
            KillauraRemote()
        end)
        spawn(function()
            repeat wait(0.1)
                if (KillAuraAnim) and (t) then
                    for i,v in pairs(game.Players:GetPlayers()) do
                        if isAlive() and isAlive(v) and v ~= game.Players.LocalPlayer then
                            if (v.Character.HumanoidRootPart.Position - lplr.Character.HumanoidRootPart.Position).Magnitude < DistanceValue and v.Team ~= game.Players.LocalPlayer.Team and isAlive(v) then
                                if (KillAuraAnim) and t then
                                    pcall(function()
                                        for i,v in pairs(CustomAnims[SelectedAnim]) do
                                            if isAlive() and cam.Viewmodel.RightHand.RightWrist and origC0 and t then
                                                AnimPlaying = game:GetService("TweenService"):Create(cam.Viewmodel.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC0 * v.CFrame})
                                                AnimPlaying:Play()
                                                task.wait(v.Time - 0.01)
                                            end
                                        end
                                        --[[
                                        for i,v in pairs(CustomAnims[SelectedAnim]) do
                                            if isAlive() and lplr.Character.RightHand.RightWrist and origC02 and t then
                                                AnimPlaying = game:GetService("TweenService"):Create(lplr.Character.RightHand.RightWrist, TweenInfo.new(v.Time), {C0 = origC02 * v.CFrame})
                                                AnimPlaying:Play()
                                                task.wait(v.Time - 0.01)
                                            end
                                        end
                                        --]]
                                    end)
                                end
                            end
                        end
                    end
                end
            until (not t)
        end) 
        servRun:BindToRenderStep("FunnyKillAura", 2000, function(v)
             if (FunnyAura) and t then
                 FunnyKillAuraRemote(DistanceValue)
                 BedwarsConst.FunnyConst.COOLDOWN = 0
            end
        end)
        servRun:BindToRenderStep("CrashKillAura", 2000, function(v)
            if (CrashAura) and t then
                CrashAuraRemote(CrashDistanceVal)
                BedwarsControllers.NotificationController.sendErrorNotification = function() end
            end
        end)
    else
        servRun:UnbindFromRenderStep("KillAura")
        servRun:UnbindFromRenderStep("FunnyKillAura")
        servRun:UnbindFromRenderStep("CrashKillAura")
        BedwarsControllers.NotificationController.sendErrorNotification = oldErrorNotification
    end
end)




k_distance:Connect("Changed", function(v)
   DistanceValue = v
end)


local l_plr = game:GetService("Players").LocalPlayer
local l_humrp = l_plr.Character.HumanoidRootPart

local resp_con = l_plr.CharacterAdded:Connect(function(c) 
    l_humrp = c:WaitForChild("HumanoidRootPart",3)
    l_hum = c:WaitForChild("Humanoid",3)
end)

local function skipFrame() 
    return game:GetService("RunService").Heartbeat:Wait()
end

local moveDir
local dt
local velo
function LJump(LSpeed)
    moveDir = lplr.Character.Humanoid.MoveDirection
    print(moveDir)
    velo = moveDir * (LSpeed - lplr.Character.Humanoid.WalkSpeed)
    velo = CFrame.new(velo.x, l_humrp.CFrame.y, velo.z)
    lplr.Character.HumanoidRootPart.CFrame = velo
    print("did it")
end

p_ljump:Connect("Toggled", function(t)
    if (t) then
        print("a")
        LJump(100)
    end
end)


m_float:Connect('Enabled',function() 
    FloatNewBV = Instance.new('BodyVelocity')
    FloatNewBV.MaxForce = Vector3.new(0, 9e9, 0)
    FloatNewBV.Velocity = Vector3.new(0, FloatVelocity, 0)
    FloatNewBV.Parent = clientRoot
end)
            
m_float:Connect('Disabled',function() 
    if (FloatNewBV) then
        FloatNewBV:Destroy();
        FloatNewBV = nil
    end
end)

p_sprint:Connect("Toggled", function(t)
    if t then
        sprintConnection = game.Players.LocalPlayer.CharacterAdded:connect(function(char)
            if char then
                KnitClient.Controllers.SprintController:getMovementStatusModifier():addModifier({
                    moveSpeedMultiplier = SprintBoostVal,
                    blockSprint = true
                })
            end
	    end)
        KnitClient.Controllers.SprintController:getMovementStatusModifier():addModifier({
            moveSpeedMultiplier = SprintBoostVal,
            blockSprint = true
        })
        sprintConnection:Disconnect()
        servRun:BindToRenderStep("Sprint", 2000, function(dt)
            BedwarsControllers.SprintControl:startSprinting()
        end)
    else
        servRun:UnbindFromRenderStep("Sprint")
        KnitClient.Controllers.SprintController:getMovementStatusModifier():addModifier({
            moveSpeedMultiplier = 1,
            blockSprint = true
        })
        BedwarsControllers.SprintControl:stopSprinting()
    end
end)


p_fly:Connect("Toggled", function(t)
    if t then
        FlyNewBV = Instance.new('BodyVelocity')
        FlyNewBV.MaxForce = Vector3.new(0, 9e9, 0)
        FlyNewBV.Parent = clientRoot
        servRun:BindToRenderStep("Fly", 2000, function(dt)
            if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftShift) then
                FlyNewBV.Velocity = Vector3.new(0, -FlyVelocity, 0)
            elseif game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space) then
                FlyNewBV.Velocity = Vector3.new(0, FlyVelocity, 0)
            else
                FlyNewBV.Velocity = Vector3.new(0, 0, 0) 
            end
        end)
        a = dnec(l_humrp.Changed)
        b = dnec(l_humrp:GetPropertyChangedSignal("BodyVelocity"))
        c = dnec(l_humrp:GetPropertyChangedSignal("Velocity"))
    else
        servRun:UnbindFromRenderStep("Fly")
        if (FlyNewBV) then
            FlyNewBV:Destroy();
            FlyNewBV = nil
            
            for i,v in ipairs(a) do
                v:Enable()
            end
            for i,v in ipairs(b) do
                v:Enable()
            end
            for i,v in ipairs(c) do
                v:Enable()
            end
        end
    end
end)

   
            
p_speed:Connect("Toggled", function(t)
    if t and not FlyOn then
        a = dnec(l_humrp.Changed)
        b = dnec(l_humrp:GetPropertyChangedSignal("CFrame"))
        servRun:BindToRenderStep("Speed", 2000, function(dt)
            if isAlive() then
                lplr.Character.HumanoidRootPart.CFrame += lplr.Character.Humanoid.MoveDirection * dt * 5 * SpeedVal
            end
        end)
    else 
        servRun:UnbindFromRenderStep("Speed")
        for i,v in ipairs(a) do
            v:Enable()
        end
        for i,v in ipairs(b) do
            v:Enbale()
        end
    end
end)

p_hjump:Connect("Toggled", function(t)
    if (t) then
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        HJVel = Instance.new('BodyVelocity')
        HJVel.MaxForce = Vector3.new(0, 9e9, 0)
        HJVel.Parent = clientRoot
        HJVel.Velocity = Vector3.new(0, HJForce, 0)
        e = dnec(l_humrp.Changed)
        f = dnec(l_humrp:GetPropertyChangedSignal("BodyVelocity"))
        g = dnec(l_humrp:GetPropertyChangedSignal("Velocity"))
    else
        game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
        if (HJVel) then
            HJVel:Destroy()
            HJVel = nil
            
            for i,v in ipairs(e) do
                v:Enable()
            end
            for i,v in ipairs(f) do
                v:Enable()
            end
            for i,v in ipairs(g) do
                v:Enable()
            end
        end
    end
end)


p_nofall:Connect("Toggled", function(t)
    if (t) then
        local old 
        old = hookmetamethod(game, "__namecall", function(self, ...)
            local args = {...}
            if getnamecallmethod() == "FireServer" and tostring(self) == "GroundHit" then 
                oldarg1, oldarg2, oldarg3 = args[1], args[2], args[3]
                args[1] = nil
                args[2] = nil
                args[3] = nil
                return old(self, unpack(args))
            end
            return old(self, ...)
        end)
    else
        if oldarg1 and oldarg2 and oldarg3 then
            local old 
            old = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                if getnamecallmethod() == "FireServer" and tostring(self) == "GroundHit" then 
                    args[1] = oldarg1
                    args[2] = oldarg2
                    args[3] = oldarg3
                    return old(self, unpack(args))
                end
                return old(self, ...)
            end)
        end
    end
end)

-- Exploits

    


-- RENDER

r_fov:Connect("Toggled", function(t)
    if (t) then
        OldFov = BedwarsControllers.FovController:getFOV()
        BedwarsControllers.FovController:setFOV(FovValue)
        servRun:BindtoRenderStep("FOV", 2000, function()
            if OldFov ~= BedwarsControllers.FovController:getFOV() then
                OldFov = BedwarsControllers.FovController:getFOV()
                BedwarsControllers.FovController:setFOV(FovValue)
            end
        end)
    else
        servRun:UnbindFromRenderStep("FOV")
        BedwarsControllers.FovController:setFOV(OldFov)
    end
end)

r_fps:Connect("Toggled", function(t)
    if (t) then
        FPSBoost()
    else
        UnFPSBoost()
    end
end)


r_cape:Connect("Enabled", function(v)
    meteorcapeconnection = game.Players.LocalPlayer.CharacterAdded:connect(function(char)
		if char then
			task.spawn(function()
				pcall(function()
                    Cape(char, getcustomasset("Meteor/assets/MeteorCape.png", "MeteorCape"))
				end)
			end)
		end
	end)
	if game.Players.LocalPlayer.Character  then
		task.spawn(function()
			pcall(function() 
                Cape(game.Players.LocalPlayer.Character, getcustomasset("Meteor/assets/MeteorCape.png", "MeteorCape"))
			end)
		end)
	end
end)


r_cape:Connect("Disabled", function(v)
  if meteorcapeconnection then
      meteorcapeconnection:Disconnect()
      if game.Players.LocalPlayer.Character then
          for i,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
              if v.Name == "Cape" then
                  v:remove()
              end
          end
      end
    end
end)

w_chestS:Connect("Toggled", function(t)
    if (t) then
        servRun:BindtoRenderStep("StealChest", 2000, function(dt)
            StealChest()
        end)
    else
        servRun:UnbindFromRenderStep("StealChest")
    end
end)


w_nuker:Connect("Toggled", function(t)
    if (t) then
        servRun:BindToRenderStep("Nuke", 2000, function(dt)
            DestroyNearestBeds()
        end)
    else
        servRun:UnbindFromRenderStep("Nuke")
    end
end)

w_antiVoid:Connect("Toggled", function(t)
    if (t) then
        local antiVoid = instNew("Part", game.Workspace)
        
        antiVoid.Name = "AntiVoidPart"
        antiVoid.Size = vec3(2100, 0.5, 2000)
        antiVoid.Position = vec3(160.5, 25, 247.5)
        antiVoid.Transparency = AntiVoidTrans
        antiVoid.Anchored = true
        
        antiVoid.Touched:Connect(function(HasTouched)
            if HasTouched.Parent:WaitForChild("Humanoid") and HasTouched.Parent.Name == lplr.Name then
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                task.wait(0.15)
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
                task.wait(0.15)
                game.Players.LocalPlayer.Character.Humanoid:ChangeState("Jumping")
            end
        end)
    else
        game.Workspace.AntiVoidPart:remove()
    end
end)

        
-- Meteor

            
local _managelm = ui:manageml()
local uiframe = _managelm[1]
local uilist = _managelm[2]
local uititle = _managelm[3]
            
            
m_modlist:Connect('Enabled',function() 
                
if (ModListSelected == 'Top left') then
    uiframe.Position = dimScale(0, 0)
    uiframe.AnchorPoint = vec2(0, 0)
                    
    uilist.HorizontalAlignment = 'Left'
    uilist.VerticalAlignment = 'Top'
                    
    ui:manageml(-100, 10, 'Left', 'PaddingLeft')
                    
    elseif (ModListSelected == 'Top right') then
        uiframe.Position = dimScale(1, 0)
        uiframe.AnchorPoint = vec2(1, 0)
                    
        uilist.HorizontalAlignment = 'Right'
        uilist.VerticalAlignment = 'Top'
                    
        ui:manageml(-100, 10, 'Right', 'PaddingRight')
    elseif (ModListSelected == 'Bottom left') then
        uiframe.Position = dimScale(0, 1)
        uiframe.AnchorPoint = vec2(0, 1)
                    
        uilist.HorizontalAlignment = 'Left'
        uilist.VerticalAlignment = 'Bottom'
                    
        ui:manageml(-100, 10, 'Left', 'PaddingLeft')
    elseif (ModListSelected == 'Bottom right') then
        uiframe.Position = dimScale(1, 1)
        uiframe.AnchorPoint = vec2(1, 1)
                    
        uilist.HorizontalAlignment = 'Right'
        uilist.VerticalAlignment = 'Bottom'
                    
        ui:manageml(-100, 10, 'Right', 'PaddingRight')
    end
                
                
    uiframe.Visible = true
end)
            
m_modlist:Connect('Disabled',function() 
    uiframe.Visible = false
end)



p_speed:Reset()
p_fly:Reset()
p_sprint:Reset()
m_float:Reset()
p_nofall:Reset()
c_killaura:Reset()
r_cape:Reset()
r_fov:Reset()
r_fps:Reset()
w_nuker:Reset()
w_antiVoid:Reset()
m_modlist:Reset()
