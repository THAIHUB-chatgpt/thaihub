-- THÁI HUB V2 MARKET FINAL

repeat task.wait() until game:IsLoaded()

local KEY = "THAI-DEP-ZAI"

------------------------------------------------
-- KEY SYSTEM
------------------------------------------------

local keyGui = Instance.new("ScreenGui", game.CoreGui)

local keyFrame = Instance.new("Frame", keyGui)
keyFrame.Size = UDim2.new(0,300,0,150)
keyFrame.Position = UDim2.new(0.5,-150,0.5,-75)
keyFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local keyTitle = Instance.new("TextLabel", keyFrame)
keyTitle.Size = UDim2.new(1,0,0,40)
keyTitle.Text = "ENTER KEY"
keyTitle.TextScaled = true
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)

local box = Instance.new("TextBox", keyFrame)
box.Size = UDim2.new(0.8,0,0,30)
box.Position = UDim2.new(0.1,0,0.45,0)
box.PlaceholderText = "Enter Key"

local enter = Instance.new("TextButton", keyFrame)
enter.Size = UDim2.new(0.5,0,0,30)
enter.Position = UDim2.new(0.25,0,0.75,0)
enter.Text = "ENTER"

local unlocked=false

enter.MouseButton1Click:Connect(function()

if box.Text == KEY then
unlocked=true
keyGui:Destroy()
else
box.Text="WRONG KEY"
end

end)

repeat task.wait() until unlocked

------------------------------------------------
-- LOAD SCREEN
------------------------------------------------

local loadGui = Instance.new("ScreenGui", game.CoreGui)

local loadFrame = Instance.new("Frame", loadGui)
loadFrame.Size = UDim2.new(0,300,0,120)
loadFrame.Position = UDim2.new(0.5,-150,0.5,-60)
loadFrame.BackgroundColor3 = Color3.fromRGB(0,0,0)

local loadText = Instance.new("TextLabel", loadFrame)
loadText.Size = UDim2.new(1,0,1,0)
loadText.BackgroundTransparency = 1
loadText.TextColor3 = Color3.new(1,1,1)
loadText.TextScaled = true
loadText.Text = "THÁI HUB LOADING..."

task.wait(math.random(5,10))

loadGui:Destroy()

------------------------------------------------
-- SERVICES
------------------------------------------------

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer

------------------------------------------------
-- GUI
------------------------------------------------

local gui = Instance.new("ScreenGui", game.CoreGui)

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0,420,0,320)
frame.Position = UDim2.new(0.5,-210,0.5,-160)
frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
frame.Active = true
frame.Draggable = true

local stroke = Instance.new("UIStroke", frame)
stroke.Thickness = 3
stroke.Color = Color3.fromRGB(0,170,255)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "THÁI HUB V2"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

------------------------------------------------
-- MINIMIZE
------------------------------------------------

local mini = Instance.new("TextButton", gui)
mini.Size = UDim2.new(0,35,0,35)
mini.Position = UDim2.new(0,10,0.45,0)
mini.Text = "T"

mini.MouseButton1Click:Connect(function()
frame.Visible = not frame.Visible
end)

------------------------------------------------
-- SYSTEM
------------------------------------------------

local speedOn=false
local jumpOn=false
local noclipOn=false
local infiniteJump=false

RunService.RenderStepped:Connect(function()

pcall(function()

local char=player.Character
if not char then return end

local hum=char:FindFirstChild("Humanoid")
if not hum then return end

hum.WalkSpeed = speedOn and 250 or 16
hum.JumpPower = jumpOn and 100 or 50

end)

end)

------------------------------------------------
-- INFINITE JUMP
------------------------------------------------

UIS.JumpRequest:Connect(function()

if infiniteJump then

local char = player.Character
if char then
local hum = char:FindFirstChildOfClass("Humanoid")
if hum then
hum:ChangeState(Enum.HumanoidStateType.Jumping)
end
end

end

end)

------------------------------------------------
-- TOGGLE
------------------------------------------------

local function toggle(text,x,y)

local state=false

local b=Instance.new("TextButton",frame)
b.Size=UDim2.new(0,190,0,35)
b.Position=UDim2.new(0,x,0,y)
b.BackgroundColor3=Color3.fromRGB(0,0,0)
b.TextColor3=Color3.new(1,1,1)
b.Text=text.." OFF"

b.MouseButton1Click:Connect(function()

state=not state

b.Text=text.." "..(state and "ON" or "OFF")
b.BackgroundColor3=state and Color3.fromRGB(0,200,0) or Color3.fromRGB(0,0,0)

if text=="Speed" then speedOn=state end
if text=="Jump" then jumpOn=state end
if text=="Noclip" then noclipOn=state end
if text=="InfiniteJump" then infiniteJump=state end

if text=="ESP" and state then
for _,v in pairs(Players:GetPlayers()) do
if v~=player and v.Character then
local h=Instance.new("Highlight",v.Character)
h.FillTransparency=1
h.OutlineColor=Color3.fromRGB(255,0,0)
end
end
end

end)

end

------------------------------------------------
-- CLICK
------------------------------------------------

local function click(text,x,y)

local b=Instance.new("TextButton",frame)
b.Size=UDim2.new(0,190,0,35)
b.Position=UDim2.new(0,x,0,y)
b.BackgroundColor3=Color3.fromRGB(0,0,0)
b.TextColor3=Color3.new(1,1,1)
b.Text=text

b.MouseButton1Click:Connect(function()

if text=="FullBright" then
Lighting.Brightness=3
Lighting.ClockTime=12
end

if text=="Fly" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end

if text=="InfiniteYield" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

if text=="Bacon Hub" then
loadstring(game:HttpGet("https://raw.githubusercontent.com/vinh129150/hack/main/BaconHub.lua"))()
end

if text=="Rejoin" then
TeleportService:Teleport(game.PlaceId,player)
end

if text=="Server Hop" then
TeleportService:TeleportToPlaceInstance(game.PlaceId,game.JobId)
end

end)

end

------------------------------------------------
-- BUTTONS
------------------------------------------------

toggle("Speed",10,50)
toggle("Jump",10,90)
toggle("Noclip",10,130)
toggle("InfiniteJump",10,170)
click("InfiniteYield",10,210)

click("FullBright",210,50)
toggle("ESP",210,90)
click("Fly",210,130)
click("Bacon Hub",210,170)

click("Rejoin",80,285)
click("Server Hop",220,285)

------------------------------------------------
-- NOCLIP
------------------------------------------------

RunService.Stepped:Connect(function()

if noclipOn and player.Character then
for _,v in pairs(player.Character:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide=false
end
end
end

end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------

player.Idled:Connect(function()
game:GetService("VirtualUser"):CaptureController()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)
player.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

-- Silent Assassins Auto Script

local LP, RS = game.Players.LocalPlayer, game:GetService("RunService")

-- SEMI-GOD & NO SLOW & SPEED 20
RS.Heartbeat:Connect(function()
    if LP.Character and LP.Character:FindFirstChild("Humanoid") then
        LP.Character.Humanoid.WalkSpeed = 20
        LP.Character.Humanoid.PlatformStand = false
        if LP.Character:FindFirstChild("HumanoidRootPart") then
            LP.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        end
    end
end)

RS.RenderStepped:Connect(function()
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = v.Character.HumanoidRootPart

            -- HITBOX
            hrp.Size = Vector3.new(100,100,100)
            hrp.Transparency = 0.9
            hrp.CanCollide = false

            -- ESP
            if not v.Character:FindFirstChild("Highlight") then
                local hl = Instance.new("Highlight")
                hl.Parent = v.Character
                hl.FillColor = Color3.new(1,0,0)
                hl.FillTransparency = 0.5
            end
        end
    end
end)

-- FIX LAG SIMPLE

setfpscap(60)

task.spawn(function()
    while true do
        task.wait(2)
        for _,v in pairs(game:GetService("Workspace"):GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Enabled = false
            end
        end
    end
end)
