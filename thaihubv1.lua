-- THÁI HUB V1 OFFICIAL

local player = game.Players.LocalPlayer
local players = game:GetService("Players")
local lighting = game:GetService("Lighting")
local run = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local vu = game:GetService("VirtualUser")

-- GUI
local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

-- LOADING
local loading = Instance.new("TextLabel",gui)
loading.Size = UDim2.new(1,0,1,0)
loading.BackgroundColor3 = Color3.fromRGB(0,0,0)
loading.TextColor3 = Color3.fromRGB(0,255,0)
loading.TextScaled = true
loading.Text = "THÁI HUB V1\nĐang khởi động..."

task.wait(3)
loading:Destroy()

-- FIX LAG AUTO
task.spawn(function()
for _,v in pairs(game:GetDescendants()) do
if v:IsA("Part") or v:IsA("MeshPart") then
v.Material = Enum.Material.SmoothPlastic
v.Reflectance = 0
end
if v:IsA("Decal") then
v.Transparency = 1
end
end
lighting.GlobalShadows = false
lighting.FogEnd = 100000
end)

-- CHARACTER
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

player.CharacterAdded:Connect(function(c)
char = c
humanoid = char:WaitForChild("Humanoid")
end)

-- MENU
local menu = Instance.new("Frame",gui)
menu.Size = UDim2.new(0,260,0,300)
menu.Position = UDim2.new(0.5,-130,0.5,-150)
menu.BackgroundColor3 = Color3.fromRGB(0,0,0)

local title = Instance.new("TextLabel",menu)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "THÁI HUB V1"
title.TextScaled = true
title.TextColor3 = Color3.fromRGB(0,255,0)

-- THU NHỎ
local mini = Instance.new("TextButton",menu)
mini.Size = UDim2.new(0,30,0,30)
mini.Position = UDim2.new(1,-35,0,5)
mini.Text = "-"

local open = Instance.new("TextButton",gui)
open.Size = UDim2.new(0,50,0,50)
open.Position = UDim2.new(0.9,0,0.45,0)
open.Text = "TH"
open.BackgroundColor3 = Color3.fromRGB(0,0,0)
open.Visible = false

mini.MouseButton1Click:Connect(function()
menu.Visible=false
open.Visible=true
teleMenu.Visible=false
end)

open.MouseButton1Click:Connect(function()
menu.Visible=true
open.Visible=false
end)

-- BUTTON FUNCTION
local function btn(name,x,y,w)
local b = Instance.new("TextButton",menu)
b.Size = UDim2.new(w,0,0,40)
b.Position = UDim2.new(x,0,0,y)
b.Text = name
b.BackgroundColor3 = Color3.fromRGB(170,170,170)
return b
end

-- SPEED
local speed=false
local speedBtn=btn("Speed",0,40,0.5)

speedBtn.MouseButton1Click:Connect(function()
speed=not speed
humanoid.WalkSpeed = speed and 80 or 16
end)

-- JUMP
local jump=false
local jumpBtn=btn("Jump",0.5,40,0.5)

jumpBtn.MouseButton1Click:Connect(function()
jump=not jump
humanoid.JumpPower = jump and 120 or 50
end)

-- INFINITE JUMP AUTO
UIS.JumpRequest:Connect(function()
local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
if hum then
hum:ChangeState("Jumping")
end
end)

-- FULLBRIGHT
local fb=false
local fbBtn=btn("FullBright",0,85,1)

fbBtn.MouseButton1Click:Connect(function()
fb=not fb
if fb then
lighting.Brightness=3
lighting.ClockTime=12
lighting.FogEnd=100000
else
lighting.Brightness=1
end
end)

-- NOCLIP
local noclip=false
local noclipBtn=btn("Noclip",0,130,0.5)

noclipBtn.MouseButton1Click:Connect(function()
noclip=not noclip
end)

run.Stepped:Connect(function()
if noclip and char then
for _,v in pairs(char:GetDescendants()) do
if v:IsA("BasePart") then
v.CanCollide=false
end
end
end
end)

-- ESP
local esp=false
local espBtn=btn("ESP",0.5,130,0.5)

espBtn.MouseButton1Click:Connect(function()
esp=not esp
for _,p in pairs(players:GetPlayers()) do
if p~=player and p.Character then
if esp then
local h=Instance.new("Highlight")
h.FillColor=Color3.fromRGB(255,0,0)
h.Parent=p.Character
else
for _,v in pairs(p.Character:GetChildren()) do
if v:IsA("Highlight") then
v:Destroy()
end
end
end
end
end
end)

-- TELEPORT MENU
local teleBtn=btn("Teleport",0,175,1)

teleMenu=Instance.new("Frame",gui)
teleMenu.Size=UDim2.new(0,200,0,250)
teleMenu.Position=UDim2.new(1,-210,0.5,-125)
teleMenu.BackgroundColor3=Color3.fromRGB(0,0,0)
teleMenu.Visible=false

local scroll=Instance.new("ScrollingFrame",teleMenu)
scroll.Size=UDim2.new(1,0,1,0)

teleBtn.MouseButton1Click:Connect(function()
teleMenu.Visible=not teleMenu.Visible
end)

task.spawn(function()
while true do
task.wait(3)
scroll:ClearAllChildren()
local y=0
for _,p in pairs(players:GetPlayers()) do
if p~=player then
local b=Instance.new("TextButton",scroll)
b.Size=UDim2.new(1,0,0,30)
b.Position=UDim2.new(0,0,0,y)
b.Text=p.Name
b.MouseButton1Click:Connect(function()
if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
player.Character.HumanoidRootPart.CFrame =
p.Character.HumanoidRootPart.CFrame
end
end)
y=y+35
end
end
end
end)

-- FLY
local flyBtn=btn("Fly",0,220,0.5)
flyBtn.MouseButton1Click:Connect(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)

-- COMMAND
local cmdBtn=btn("Command",0.5,220,0.5)
cmdBtn.MouseButton1Click:Connect(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)

-- REJOIN
local rejoinBtn=btn("Rejoin",0,265,0.5)
rejoinBtn.MouseButton1Click:Connect(function()
TeleportService:Teleport(game.PlaceId, player)
end)

-- SERVER HOP
local hopBtn=btn("Server Hop",0.5,265,0.5)

hopBtn.MouseButton1Click:Connect(function()

local req = game:HttpGet(
"https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"
)

local data = HttpService:JSONDecode(req)

for _,v in pairs(data.data) do
if v.playing < v.maxPlayers then
TeleportService:TeleportToPlaceInstance(game.PlaceId,v.id,player)
break
end
end

end)

-- ANTI AFK
player.Idled:Connect(function()
vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
task.wait(1)
vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
