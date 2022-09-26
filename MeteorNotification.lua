local TweenService = game:GetService'TweenService'
local Debris = game:GetService'Debris'
local CoreGui = game:GetService'CoreGui'
local _G.main = {}

for i,v in pairs(CoreGui:GetChildren()) do
    if v.Name == "Notifications" then
        v:Destroy()
    end
end
local Notifications = Instance.new("ScreenGui")
local Holder = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")


Notifications.Name = "Notifications"
Notifications.Parent = CoreGui
Notifications.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Holder.Name = "Holder"
Holder.Parent = Notifications
Holder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Holder.BackgroundTransparency = 1.000
Holder.Position = UDim2.new(0.83, 0, 0, 0)
Holder.Size = UDim2.new(0, 296, 1, 0)

UIListLayout.Parent = Holder
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.Padding = UDim.new(0, 5)


function _G.main:Notification(title: string, description: string, delay: number, backgroundcolor: Color3Value, overides: Color3Value)
if overides == nil then
    overides = Color3.fromRGB(255,255,255)
end

    local Notification = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Description = Instance.new("TextLabel")
    local deboucne = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local Arrow = Instance.new("ImageButton")
    local UIPadding = Instance.new("UIPadding")
    
    Notification.Name = "Notification"
    Notification.Parent = game:GetService'CoreGui':FindFirstChild'Notifications':FindFirstChild'Holder'
    Notification.BackgroundColor3 = backgroundcolor
    Notification.Position = UDim2.new(0, 0, 1, 0)
    Notification.Size = UDim2.new(0, 200, 0, 82)
    Notification.BackgroundTransparency = 1

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Notification
    
    Title.Name = "Title"
    Title.Parent = Notification
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0406779647, 0, 0, 0)
    Title.Size = UDim2.new(0, 104, 0, 35)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 15.000
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTransparency = 1

    Description.Name = "Description"
    Description.Parent = Notification
    Description.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Description.BackgroundTransparency = 1.000
    Description.Position = UDim2.new(0.0406779647, 0, 0.280487806, 0)
    Description.Size = UDim2.new(0, 104, 0, 35)
    Description.Font = Enum.Font.Gotham
    Description.Text = description
    Description.TextColor3 = Color3.fromRGB(255, 255, 255)
    Description.TextSize = 13.000
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.TextTransparency = 1

    deboucne.Name = "deboucne"
    deboucne.Parent = Notification
    deboucne.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    deboucne.Position = UDim2.new(0.0101, 0, 0.889999986, 0)
    deboucne.Size = UDim2.new(0, 250, 0, 7)
    deboucne.BackgroundTransparency = 1 

    UICorner_2.CornerRadius = UDim.new(0, 6)
    UICorner_2.Parent = deboucne
    
    Arrow.Name = "Arrow"
    Arrow.Parent = Notification
    Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Arrow.BackgroundTransparency = 1.000
    Arrow.Position = UDim2.new(0.901694894, 0, 0.073170729, 0)
    Arrow.Size = UDim2.new(0, 24, 0, 23)
  --  Arrow.Image = "rbxassetid://9733495142"
    Arrow.ScaleType = Enum.ScaleType.Fit
    Arrow.ImageTransparency = 1 
    Arrow.ImageColor3 = overides

    UIPadding.Parent = Holder
    UIPadding.PaddingBottom = UDim.new(0, 10)
    UIPadding.PaddingLeft = UDim.new(0, 20)

local function makeVis()
  TweenService:Create(Notification,TweenInfo.new(.5), { BackgroundTransparency = 0 }):Play()
  TweenService:Create(Title,TweenInfo.new(.5), { TextTransparency = 0 }):Play()
  TweenService:Create(Description,TweenInfo.new(.5), { TextTransparency = 0 }):Play()
  TweenService:Create(deboucne,TweenInfo.new(.5), { BackgroundTransparency = 1 }):Play()
  TweenService:Create(Arrow,TweenInfo.new(.5), { ImageTransparency = 0 }):Play()
  wait()        
end
local function makeInvis()
    TweenService:Create(Notification,TweenInfo.new(.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Title,TweenInfo.new(.5), { TextTransparency = 1 }):Play()
    TweenService:Create(Description,TweenInfo.new(.5), { TextTransparency = 1 }):Play()
    TweenService:Create(deboucne,TweenInfo.new(.5), { BackgroundTransparency = 1 }):Play()
    TweenService:Create(Arrow,TweenInfo.new(.5), { ImageTransparency = 1 }):Play()
end

Arrow.MouseButton1Click:Connect(function()
    makeInvis()
    Debris:AddItem(Notification, .25)
    wait()
end)

makeVis()
a =  TweenService:Create(deboucne,TweenInfo.new(delay,Enum.EasingStyle.Quad), { Size = UDim2.new(0, 0, 0, 7)})
a:Play()
a.Completed:Connect(function(playbackState)
    wait()
    makeInvis()
    Debris:AddItem(Notification, .25)
end)
   return _G.main 
end

return _G.main
