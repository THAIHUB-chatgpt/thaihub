-- THÁI HUB V2 UNIVERSAL
repeat task.wait() until game:IsLoaded()

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local player = Players.LocalPlayer

local Theme = {
    Bg=Color3.fromRGB(15,15,20), Panel=Color3.fromRGB(22,22,30),
    Element=Color3.fromRGB(30,30,42), ElementHov=Color3.fromRGB(40,40,55),
    Accent=Color3.fromRGB(0,170,255), Accent2=Color3.fromRGB(140,80,255),
    Success=Color3.fromRGB(0,200,100), Danger=Color3.fromRGB(220,50,60),
    Text=Color3.fromRGB(235,235,245), SubText=Color3.fromRGB(150,150,170),
    Font=Enum.Font.GothamMedium, FontBold=Enum.Font.GothamBold,
}

local function corner(p,r) local c=Instance.new("UICorner",p) c.CornerRadius=UDim.new(0,r or 8) return c end
local function stroke(p,c,t) local s=Instance.new("UIStroke",p) s.Color=c or Theme.Accent s.Thickness=t or 1 s.ApplyStrokeMode=Enum.ApplyStrokeMode.Border return s end
local function gradient(p,a,b,r) local g=Instance.new("UIGradient",p) g.Color=ColorSequence.new(a,b) g.Rotation=r or 0 return g end

local parentGui = (gethui and gethui()) or game:GetService("CoreGui")
local gui = Instance.new("ScreenGui")
gui.Name = "ThaiHubV2" gui.ResetOnSpawn = false gui.IgnoreGuiInset = true gui.Parent = parentGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 420)
frame.Position = UDim2.new(0.5, -250, 0.5, -210)
frame.BackgroundColor3 = Theme.Bg frame.BorderSizePixel = 0 frame.Active = true frame.Draggable = true
corner(frame, 14) stroke(frame, Theme.Accent, 2)

local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 45) topBar.BackgroundColor3 = Theme.Panel topBar.BorderSizePixel = 0
corner(topBar, 14) gradient(topBar, Theme.Accent, Theme.Accent2, 30)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(0, 150, 1, 0) title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1 title.Text = "THÁI HUB V2"
title.TextColor3 = Color3.new(1,1,1) title.Font = Theme.FontBold title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left

local fpsLabel = Instance.new("TextLabel", topBar)
fpsLabel.Size = UDim2.new(0, 90, 1, 0) fpsLabel.Position = UDim2.new(0, 165, 0, 0)
fpsLabel.BackgroundTransparency = 1 fpsLabel.Text = "FPS: --" fpsLabel.TextColor3 = Color3.new(1,1,1)
fpsLabel.Font = Theme.FontBold fpsLabel.TextSize = 12 fpsLabel.TextXAlignment = Enum.TextXAlignment.Left

local masterBtn = Instance.new("TextButton", topBar)
masterBtn.Size = UDim2.new(0, 55, 0, 28) masterBtn.Position = UDim2.new(1, -215, 0.5, -14)
masterBtn.BackgroundColor3 = Theme.Success masterBtn.Text = "ALL ON" masterBtn.TextColor3 = Color3.new(1,1,1)
masterBtn.Font = Theme.FontBold masterBtn.TextSize = 11 masterBtn.BorderSizePixel = 0 corner(masterBtn, 8)

local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30) closeBtn.Position = UDim2.new(1, -38, 0, 7)
closeBtn.BackgroundColor3 = Theme.Danger closeBtn.Text = "X" closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Font = Theme.FontBold closeBtn.TextSize = 16 closeBtn.BorderSizePixel = 0 corner(closeBtn, 8)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

local minBtn = Instance.new("TextButton", topBar)
minBtn.Size = UDim2.new(0, 30, 0, 30) minBtn.Position = UDim2.new(1, -74, 0, 7)
minBtn.BackgroundColor3 = Theme.Element minBtn.Text = "-" minBtn.TextColor3 = Theme.Text
minBtn.Font = Theme.FontBold minBtn.TextSize = 20 minBtn.BorderSizePixel = 0 corner(minBtn, 8)

-- FLOAT
local floatContainer = Instance.new("Frame", gui)
floatContainer.Size = UDim2.new(0, 105, 0, 55) floatContainer.Position = UDim2.new(0, 15, 0.45, 0)
floatContainer.BackgroundTransparency = 1 floatContainer.Visible = false

local floatBtn = Instance.new("TextButton", floatContainer)
floatBtn.Size = UDim2.new(0, 55, 0, 55) floatBtn.BackgroundColor3 = Theme.Bg
floatBtn.Text = "TH" floatBtn.TextColor3 = Color3.new(1,1,1) floatBtn.Font = Theme.FontBold
floatBtn.TextSize = 20 floatBtn.BorderSizePixel = 0 corner(floatBtn, 27) stroke(floatBtn, Theme.Accent, 2)

local lockBtn = Instance.new("TextButton", floatContainer)
lockBtn.Size = UDim2.new(0, 35, 0, 35) lockBtn.Position = UDim2.new(0, 62, 0.5, -17)
lockBtn.BackgroundColor3 = Theme.Element lockBtn.Text = "U" lockBtn.TextColor3 = Theme.Text
lockBtn.Font = Theme.FontBold lockBtn.TextSize = 16 lockBtn.BorderSizePixel = 0 corner(lockBtn, 8)
stroke(lockBtn, Theme.Accent, 1)

local uiLocked = false
local dragging, wasDragging, dragStart, startPos = false, false, nil, nil

lockBtn.MouseButton1Click:Connect(function()
    uiLocked = not uiLocked
    if uiLocked then
        lockBtn.Text = "L" lockBtn.BackgroundColor3 = Theme.Danger frame.Draggable = false
        TweenService:Create(floatBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.5}):Play()
    else
        lockBtn.Text = "U" lockBtn.BackgroundColor3 = Theme.Element frame.Draggable = true
        TweenService:Create(floatBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0}):Play()
    end
end)

floatBtn.InputBegan:Connect(function(input)
    if uiLocked then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true wasDragging = false dragStart = input.Position startPos = floatContainer.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 3 or math.abs(delta.Y) > 3 then wasDragging = true end
        floatContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false task.wait(0.05) wasDragging = false
    end
end)

minBtn.MouseButton1Click:Connect(function() frame.Visible = false floatContainer.Visible = true end)
floatBtn.MouseButton1Click:Connect(function() if wasDragging then return end frame.Visible = true floatContainer.Visible = false end)

------------------------------------------------
-- STATE
------------------------------------------------
local state = {
    Speed=false, Jump=false, Noclip=false, InfiniteJump=false,
    FullBright=false, AntiAFK=true, SilentAim=false, AimPlayer=false,
    ESP=false, ESP_Tracer=false, Fly=false, XRay=false,
    Gravity=false, AimLock=false,
}

local speedValue = 100
local gravityValue = 196
local flySpeed = 100
local aimFOV = 200
local hue = 0
local selectedPlayer = nil
local spectateOrigin = nil
local savedWaypoint = nil
local followThread = nil
local flyBV = nil
local flyBG = nil

------------------------------------------------
-- FPS
------------------------------------------------
local frames, lastFpsTick, currentFps = 0, tick(), 0
RunService.RenderStepped:Connect(function()
    frames = frames + 1
    if tick() - lastFpsTick >= 1 then currentFps = frames frames = 0 lastFpsTick = tick() end
end)
task.spawn(function()
    while gui.Parent do fpsLabel.Text = "FPS: " .. currentFps task.wait(0.5) end
end)

------------------------------------------------
-- CHARACTER LOOP
------------------------------------------------
RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = player.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if not hum then return end
        if state.Speed then hum.WalkSpeed = speedValue end
        if state.Jump then hum.JumpPower = 100 end
    end)
end)

------------------------------------------------
-- INFINITE JUMP
------------------------------------------------
UIS.JumpRequest:Connect(function()
    if state.InfiniteJump then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end
    end
end)

------------------------------------------------
-- NOCLIP
------------------------------------------------
RunService.Stepped:Connect(function()
    if not state.Noclip then return end
    local char = player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") and v.CanCollide then v.CanCollide = false end
    end
end)

------------------------------------------------
-- ANTI AFK
------------------------------------------------
player.Idled:Connect(function()
    if state.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

------------------------------------------------
-- FLY NATIVE (không cần external)
------------------------------------------------
local function startFly()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    if flyBV then flyBV:Destroy() end
    if flyBG then flyBG:Destroy() end
    flyBV = Instance.new("BodyVelocity", hrp)
    flyBV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    flyBV.Velocity = Vector3.zero
    flyBG = Instance.new("BodyGyro", hrp)
    flyBG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    flyBG.P = 1000
    flyBG.CFrame = hrp.CFrame

    task.spawn(function()
        while state.Fly and flyBV and flyBV.Parent do
            local cam = workspace.CurrentCamera
            local moveDir = Vector3.zero
            local hum = char:FindFirstChildOfClass("Humanoid")

            if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.CFrame.LookVector end
            if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.CFrame.RightVector end
            if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0,1,0) end
            if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0,1,0) end

            if moveDir.Magnitude > 0 then moveDir = moveDir.Unit end
            flyBV.Velocity = moveDir * flySpeed
            flyBG.CFrame = cam.CFrame
            RunService.RenderStepped:Wait()
        end
    end)
end

local function stopFly()
    if flyBV then flyBV:Destroy() flyBV = nil end
    if flyBG then flyBG:Destroy() flyBG = nil end
end

RunService.RenderStepped:Connect(function()
    if state.Fly then
        if not flyBV then startFly() end
    else
        if flyBV then stopFly() end
    end
end)

------------------------------------------------
-- FULLBRIGHT
------------------------------------------------
local fbConn, fbOriginal = nil, nil

local function enableFB()
    if not fbOriginal then
        fbOriginal = {
            Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
            FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows,
            Ambient = Lighting.Ambient, OutdoorAmbient = Lighting.OutdoorAmbient,
        }
    end
    if fbConn then fbConn:Disconnect() end
    fbConn = RunService.RenderStepped:Connect(function()
        Lighting.Brightness = 3
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(178,178,178)
        Lighting.OutdoorAmbient = Color3.fromRGB(178,178,178)
    end)
end

local function disableFB()
    if fbConn then fbConn:Disconnect() fbConn = nil end
    if fbOriginal then
        Lighting.Brightness = fbOriginal.Brightness
        Lighting.ClockTime = fbOriginal.ClockTime
        Lighting.FogEnd = fbOriginal.FogEnd
        Lighting.GlobalShadows = fbOriginal.GlobalShadows
        Lighting.Ambient = fbOriginal.Ambient
        Lighting.OutdoorAmbient = fbOriginal.OutdoorAmbient
    end
end

RunService.RenderStepped:Connect(function()
    if state.FullBright then if not fbConn then enableFB() end
    else if fbConn then disableFB() end end
end)

------------------------------------------------
-- GRAVITY
------------------------------------------------
RunService.RenderStepped:Connect(function()
    pcall(function()
        if state.Gravity then
            workspace.Gravity = gravityValue
        else
            workspace.Gravity = 196.2
        end
    end)
end)

------------------------------------------------
-- X-RAY
------------------------------------------------
local xraySaved = {}
RunService.RenderStepped:Connect(function()
    if state.XRay then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" and v.Transparency ~= 0.9 then
                if not xraySaved[v] then xraySaved[v] = v.Transparency end
                v.Transparency = 0.9
                v.CanCollide = false
            end
        end
    else
        for obj, orig in pairs(xraySaved) do
            pcall(function() obj.Transparency = orig obj.CanCollide = true end)
        end
        xraySaved = {}
    end
end)

------------------------------------------------
-- FOV CIRCLE
------------------------------------------------
local fovGui = Instance.new("Frame", gui)
fovGui.Name = "FOV"
fovGui.AnchorPoint = Vector2.new(0.5, 0.5)
fovGui.Position = UDim2.new(0.5, 0, 0.5, 0)
fovGui.BackgroundTransparency = 1
fovGui.Size = UDim2.new(0, aimFOV, 0, aimFOV)
fovGui.Visible = false

local fovCorner = Instance.new("UICorner", fovGui)
fovCorner.CornerRadius = UDim.new(1, 0)

local fovStroke = Instance.new("UIStroke", fovGui)
fovStroke.Color = Color3.fromRGB(0,170,255)
fovStroke.Thickness = 2

task.spawn(function()
    while gui.Parent do
        fovGui.Size = UDim2.new(0, aimFOV, 0, aimFOV)
        fovGui.Visible = state.AimLock or state.AimPlayer
        task.wait(0.1)
    end
end)

------------------------------------------------
-- TABS
------------------------------------------------
local tabsBar = Instance.new("Frame", frame)
tabsBar.Size = UDim2.new(1, -20, 0, 35) tabsBar.Position = UDim2.new(0, 10, 0, 55)
tabsBar.BackgroundTransparency = 1

local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -20, 1, -105) content.Position = UDim2.new(0, 10, 0, 95)
content.BackgroundTransparency = 1

local tabList = Instance.new("UIListLayout", tabsBar)
tabList.FillDirection = Enum.FillDirection.Horizontal
tabList.Padding = UDim.new(0, 6) tabList.SortOrder = Enum.SortOrder.LayoutOrder

local pages, tabButtons = {}, {}

local function switchTab(name)
    for n, p in pairs(pages) do p.Visible = (n == name) end
    for n, b in pairs(tabButtons) do
        if n == name then b.BackgroundColor3 = Theme.Accent b.TextColor3 = Color3.new(1,1,1)
        else b.BackgroundColor3 = Theme.Element b.TextColor3 = Theme.SubText end
    end
end

local function createTab(name)
    local btn = Instance.new("TextButton", tabsBar)
    btn.Size = UDim2.new(0, 82, 1, 0) btn.BackgroundColor3 = Theme.Element
    btn.Text = name btn.TextColor3 = Theme.SubText btn.Font = Theme.FontBold
    btn.TextSize = 11 btn.BorderSizePixel = 0 btn.AutoButtonColor = false
    corner(btn, 8) tabButtons[name] = btn

    local page = Instance.new("Frame", content)
    page.Size = UDim2.new(1, 0, 1, 0) page.BackgroundTransparency = 1 page.Visible = false
    pages[name] = page

    btn.MouseButton1Click:Connect(function() switchTab(name) end)
    return page
end

------------------------------------------------
-- ELEMENT FACTORY
------------------------------------------------
local toggleRefs = {}

local function hoverFX(btn)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.ElementHov}):Play()
    end)
    btn.MouseLeave:Connect(function()
        if btn:GetAttribute("Active") then return end
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Element}):Play()
    end)
end

local function createToggle(parent, text, key)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Theme.Element btn.Text = "" btn.BorderSizePixel = 0 btn.AutoButtonColor = false
    corner(btn, 8) stroke(btn, Theme.ElementHov, 1)

    local lbl = Instance.new("TextLabel", btn)
    lbl.Size = UDim2.new(1, -70, 1, 0) lbl.Position = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1 lbl.Text = text lbl.TextColor3 = Theme.Text
    lbl.Font = Theme.Font lbl.TextSize = 13 lbl.TextXAlignment = Enum.TextXAlignment.Left

    local ind = Instance.new("Frame", btn)
    ind.Size = UDim2.new(0, 44, 0, 22) ind.Position = UDim2.new(1, -54, 0.5, -11)
    ind.BackgroundColor3 = state[key] and Theme.Success or Theme.Panel
    ind.BorderSizePixel = 0 corner(ind, 11)

    local knob = Instance.new("Frame", ind)
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = state[key] and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    knob.BackgroundColor3 = state[key] and Color3.new(1,1,1) or Theme.SubText
    knob.BorderSizePixel = 0 corner(knob, 9)

    hoverFX(btn)
    toggleRefs[key] = {btn = btn, ind = ind, knob = knob}

    btn.MouseButton1Click:Connect(function()
        state[key] = not state[key]
        local on = state[key]
        btn:SetAttribute("Active", on)
        TweenService:Create(ind, TweenInfo.new(0.2), {BackgroundColor3 = on and Theme.Success or Theme.Panel}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {
            Position = on and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
            BackgroundColor3 = on and Color3.new(1,1,1) or Theme.SubText
        }):Play()
    end)
    return btn
end

local function createButton(parent, text, callback, color)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Theme.Element btn.Text = text btn.TextColor3 = Theme.Text
    btn.Font = Theme.Font btn.TextSize = 13 btn.BorderSizePixel = 0 btn.AutoButtonColor = false
    corner(btn, 8) stroke(btn, Theme.ElementHov, 1)
    hoverFX(btn)
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = color or Theme.Accent}):Play()
        task.wait(0.12)
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Element}):Play()
        pcall(callback)
    end)
    return btn
end

local function createGrid(page, cellW, cellH)
    local g = Instance.new("UIGridLayout", page)
    g.CellSize = UDim2.new(0, cellW or 220, 0, cellH or 38)
    g.CellPadding = UDim2.new(0, 10, 0, 10) g.SortOrder = Enum.SortOrder.LayoutOrder
    return g
end

------------------------------------------------
-- TABS
------------------------------------------------
local miscTab    = createTab("Misc")
local combatTab  = createTab("Combat")
local playerTab  = createTab("Player")
local supportTab = createTab("Phụ Trợ")
local espTab     = createTab("ESP")

createGrid(miscTab) createGrid(combatTab) createGrid(supportTab) createGrid(espTab)

------------------------------------------------
-- MISC
------------------------------------------------
createButton(miscTab, "Fly External (V3)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
end)
createButton(miscTab, "Infinite Yield", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end)
createButton(miscTab, "Bacon Hub", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.co
