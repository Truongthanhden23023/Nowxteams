local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- Tạo UI chính
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Tạo Frame chứa các nút và các label
local UIFrame = Instance.new("Frame")
UIFrame.Size = UDim2.new(0, 400, 0, 200)
UIFrame.Position = UDim2.new(0.5, -200, 0.5, -100)
UIFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
UIFrame.Visible = false
UIFrame.Parent = ScreenGui

-- Tạo label cho Anti Kick
local AntiKickLabel = Instance.new("TextLabel")
AntiKickLabel.Text = "Anti Kick: On"
AntiKickLabel.Size = UDim2.new(0, 280, 0, 50)
AntiKickLabel.Position = UDim2.new(0, 10, 0, 10)
AntiKickLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiKickLabel.BackgroundTransparency = 1
AntiKickLabel.Parent = UIFrame

-- Tạo label cho Anti Error Code
local AntiErrorLabel = Instance.new("TextLabel")
AntiErrorLabel.Text = "Anti Error Code: On"
AntiErrorLabel.Size = UDim2.new(0, 280, 0, 50)
AntiErrorLabel.Position = UDim2.new(0, 10, 0, 60)
AntiErrorLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
AntiErrorLabel.BackgroundTransparency = 1
AntiErrorLabel.Parent = UIFrame

-- Tạo nút tắt/bật Anti Kick
local ToggleAntiKick = Instance.new("TextButton")
ToggleAntiKick.Size = UDim2.new(0, 150, 0, 50)
ToggleAntiKick.Position = UDim2.new(0, 10, 0, 110)
ToggleAntiKick.Text = "Toggle Anti Kick"
ToggleAntiKick.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleAntiKick.Parent = UIFrame
ToggleAntiKick.MouseButton1Click:Connect(function()
    if AntiKickLabel.Text == "Anti Kick: On" then
        AntiKickLabel.Text = "Anti Kick: Off"
    else
        AntiKickLabel.Text = "Anti Kick: On"
    end
end)

-- Tạo nút tắt/bật Anti Error Code
local ToggleAntiError = Instance.new("TextButton")
ToggleAntiError.Size = UDim2.new(0, 150, 0, 50)
ToggleAntiError.Position = UDim2.new(0, 170, 0, 110)
ToggleAntiError.Text = "Toggle Anti Error"
ToggleAntiError.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ToggleAntiError.Parent = UIFrame
ToggleAntiError.MouseButton1Click:Connect(function()
    if AntiErrorLabel.Text == "Anti Error Code: On" then
        AntiErrorLabel.Text = "Anti Error Code: Off"
    else
        AntiErrorLabel.Text = "Anti Error Code: On"
    end
end)

-- Tạo Loading Spinner
local LoadingFrame = Instance.new("Frame")
LoadingFrame.Size = UDim2.new(0, 100, 0, 100)
LoadingFrame.Position = UDim2.new(0.5, -50, 0.5, -50)
LoadingFrame.BackgroundTransparency = 1
LoadingFrame.Visible = false
LoadingFrame.Parent = ScreenGui

local Spinner = Instance.new("ImageLabel")
Spinner.Size = UDim2.new(0, 50, 0, 50)
Spinner.Position = UDim2.new(0.5, -25, 0.5, -25)
Spinner.Image = "rbxassetid://124990866893793"  -- ID của hình ảnh Spinner
Spinner.BackgroundTransparency = 1
Spinner.Parent = LoadingFrame

-- Thêm hiệu ứng quay cho Spinner
local TweenService = game:GetService("TweenService")
local rotationTween = TweenService:Create(Spinner, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Rotation = 360})
rotationTween:Play()

-- Hiển thị và tắt UI khi nhấn phím F
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F then
            -- Hiển thị Loading trước khi hiển thị UI
            LoadingFrame.Visible = true
            UIFrame.Visible = false
            wait(2)  -- Giả lập thời gian tải
            LoadingFrame.Visible = false
            UIFrame.Visible = true
        end
    end
end)
