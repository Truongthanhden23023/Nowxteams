local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Tạo một ScreenGui để chứa UI
local screenGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
screenGui.Name = "NOW X TEAMS"
screenGui.ResetOnSpawn = false

-- Tạo một Frame để làm nền cho decal
local background = Instance.new("Frame", screenGui)
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.5

-- Tạo một ImageLabel để hiển thị Decal
local imageLabel = Instance.new("ImageLabel", background)
imageLabel.Size = UDim2.new(0, 200, 0, 200)  -- Kích thước của decal
imageLabel.Position = UDim2.new(0.5, -100, 0.5, -100)  -- Vị trí ở giữa màn hình
imageLabel.BackgroundTransparency = 1  -- Không có background
imageLabel.Image = "rbxassetid://124990866893793"  -- Thay ID này bằng ID decal của bạn

-- Tạo loading screen
local function createLoadingScreen()
    local loadingGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    loadingGui.Name = "NOW X TEAMS"
    loadingGui.ResetOnSpawn = false  -- Giữ UI khi respawn

    local loadingBackground = Instance.new("Frame", loadingGui)
    loadingBackground.Size = UDim2.new(1, 0, 1, 0)
    loadingBackground.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    loadingBackground.BackgroundTransparency = 0.5

    local loadingText = Instance.new("TextLabel", loadingBackground)
    loadingText.Text = "Loading..."
    loadingText.Size = UDim2.new(0, 200, 0, 50)
    loadingText.Position = UDim2.new(0.5, -100, 0.5, -25)
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.TextSize = 30
    loadingText.BackgroundTransparency = 1

    local spinner = Instance.new("ImageLabel", loadingBackground)
    spinner.Size = UDim2.new(0, 50, 0, 50)
    spinner.Position = UDim2.new(0.5, -25, 0.5, 25)
    spinner.Image = "rbxassetid://301014156"  -- ID vòng quay mặc định
    spinner.BackgroundTransparency = 1

    return loadingGui
end

-- Hiển thị loading screen
local loadingScreen = createLoadingScreen()

local function hideLoadingScreen()
    if loadingScreen then
        loadingScreen:Destroy()  -- Ẩn loading screen sau khi hoàn thành
    end
end

-- Giả sử đây là một tác vụ đang chạy, sau khi hoàn thành ta sẽ ẩn loading screen
wait(5)  -- Giả sử mất 5 giây để thực hiện một tác vụ
hideLoadingScreen()

-- Anti AFK
RunService.Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- WalkSpeed bình thường
    end
end)

-- Anti Kick
local function antiKick()
    while wait(300) do -- Cập nhật mỗi 5 phút
        pcall(function()
            game:GetService("Players").LocalPlayer:Kick("Anti-Kick Triggered.")
        end)
    end
end

spawn(antiKick)

-- Fly script (Bay +100/-1)
local flying = false
local speed = 100
local bodyVelocity

local function fly()
    if not flying then
        flying = true
        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
            bodyVelocity.Velocity = Vector3.new(0, speed, 0)
            bodyVelocity.Parent = character.HumanoidRootPart
        end
    else
        flying = false
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed then
        if input.KeyCode == Enum.KeyCode.F then
            fly() -- Chuyển trạng thái bay
        end
    end
end)

-- Di chuyển UI tùy ý
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local dragging = false
local dragInput, dragStart, startPos

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
