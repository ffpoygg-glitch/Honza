-- [[ BOOMBOX V19 ULTIMATE - PRIVATE & FREE DRAG EDITION ]] --

local Player = game.Players.LocalPlayer

-- // [ WHITELIST SYSTEM ] //
local WhitelistName = "Annoyed123689"
local KickMessage = "มึงจะ run script นี้หาพ่อมึงหรอ"

if Player.Name ~= WhitelistName then
    Player:Kick(KickMessage)
    return 
end

local MarketplaceService = game:GetService("MarketplaceService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Remote = game:GetService("ReplicatedStorage"):WaitForChild("RE"):WaitForChild("PlayerToolEvent")

-- // [ ENCRYPTION CORE ] //
local function _0xGH_Encrypt(_0xInput)
    local _raw = tostring(_0xInput)
    local _hex = ""
    for i = 1, #_raw do
        _hex = _hex .. string.format("%%%02X", string.byte(string.sub(_raw, i, i)))
    end
    return _hex
end

-- // UI CONSTRUCTION
local ScreenGui = Instance.new("ScreenGui", Player.PlayerGui)
ScreenGui.Name = "GuHon_Ultimate_FreeDrag"
ScreenGui.ResetOnSpawn = false

local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Name = "OpenClose"
ToggleBtn.Size = UDim2.new(0, 100, 0, 35)
ToggleBtn.Position = UDim2.new(0, 10, 0.5, -17)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ToggleBtn.Text = "GuHon XD"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ToggleBtn)
local ToggleStroke = Instance.new("UIStroke", ToggleBtn)
ToggleStroke.Thickness = 2

local Main = Instance.new("Frame", ScreenGui)
Main.Name = "MainFrame"
Main.Size = UDim2.new(0, 350, 0, 460)
Main.Position = UDim2.new(0.5, -175, 0.5, -230)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Main.Active = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 20)
local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Thickness = 4

local Header = Instance.new("TextLabel", Main)
Header.Size = UDim2.new(1, 0, 0, 45)
Header.BackgroundTransparency = 1
Header.Text = "GuHon XD - ULTIMATE"
Header.Font = Enum.Font.GothamBold
Header.TextSize = 16

local Cover = Instance.new("ImageLabel", Main)
Cover.Size = UDim2.new(0, 180, 0, 180)
Cover.Position = UDim2.new(0.5, -90, 0, 55)
Cover.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Cover.Image = "rbxassetid://15617721239"
Cover.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", Cover).CornerRadius = UDim.new(0, 15)

local Info = Instance.new("TextLabel", Main)
Info.Size = UDim2.new(0.9, 0, 0, 90)
Info.Position = UDim2.new(0.05, 0, 0, 240)
Info.BackgroundTransparency = 1
Info.TextColor3 = Color3.new(1, 1, 1)
Info.RichText = true
Info.Text = "<b>READY</b>"
Info.TextWrapped = true

local IDInput = Instance.new("TextBox", Main)
IDInput.Size = UDim2.new(0.8, 0, 0, 45)
IDInput.Position = UDim2.new(0.1, 0, 0, 335)
IDInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
IDInput.TextColor3 = Color3.new(1, 1, 1)
IDInput.PlaceholderText = "ID AUDIO"
Instance.new("UICorner", IDInput)

local ActionBtn = Instance.new("TextButton", Main)
ActionBtn.Size = UDim2.new(0.8, 0, 0, 50)
ActionBtn.Position = UDim2.new(0.1, 0, 0, 390)
ActionBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ActionBtn.Text = "เล่นเพลง"
ActionBtn.TextColor3 = Color3.new(1, 1, 1)
ActionBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", ActionBtn)
local BtnStroke = Instance.new("UIStroke", ActionBtn)
BtnStroke.Thickness = 2

-- // [ NEW: ADVANCED SMOOTH DRAGGING ] //
local function EnableDrag(frame)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

EnableDrag(Main) -- เรียกใช้ระบบลากอิสระ

-- // SYSTEM: RAINBOW & FETCH & CLICK (เหมือนเดิม)
RunService.RenderStepped:Connect(function()
    local hue = tick() % 5 / 5
    local color = Color3.fromHSV(hue, 0.8, 1)
    UIStroke.Color = color
    Header.TextColor3 = color
    BtnStroke.Color = color
    ToggleStroke.Color = color
end)

local function FindBoombox()
    local target = "boombox"
    if Player.Character then
        for _, item in pairs(Player.Character:GetChildren()) do
            if item:IsA("Tool") and item.Name:lower() == target then return item end
        end
    end
    for _, item in pairs(Player.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.Name:lower() == target then return item end
    end
    return nil
end

local isPlaying = false
ActionBtn.MouseButton1Click:Connect(function()
    if not FindBoombox() then Info.Text = "<font color='#FF0000'>⚠️ ต้องมี Boombox!</font>"; return end
    local id = IDInput.Text:match("%d+")
    if not isPlaying and id then
        local encoded = _0xGH_Encrypt(id)
        Remote:FireServer("ToolMusicText", encoded, true)
        isPlaying = true
        ActionBtn.Text = "หยุดเพลง"
    else
        Remote:FireServer("ToolMusicText", "0", true)
        isPlaying = false
        ActionBtn.Text = "เล่นเพลง"
    end
end)

ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)

