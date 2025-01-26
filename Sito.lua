-- Anti AFK, Anti Kick, Fly và Di chuyển UI (Như trước đây)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Loading Screen UI
local function createLoadingScreen()
    local loadingGui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
    loadingGui.Name = "LoadingScreen"
    loadingGui.ResetOnSpawn = false  -- Giữ UI khi respawn

    local background = Instance.new("Frame", loadingGui)
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    background.BackgroundTransparency = 0.5

    local loadingText = Instance.new("TextLabel", background)
    loadingText.Text = "Loading..."
    loadingText.Size = UDim2.new(0, 200, 0, 50)
    loadingText.Position = UDim2.new(0.5, -100, 0.5, -25)
    loadingText.TextColor3 = Color3.fromRGB(255, 255, 255)
    loadingText.TextSize = 30
    loadingText.BackgroundTransparency = 1

    local spinner = Instance.new("ImageLabel", background)
    spinner.Size = UDim2.new(0, 50, 0, 50)
    spinner.Position = UDim2.new(0.5, -25, 0.5, 25)
    spinner.Image = "rbxassetid://124990866893793" -- Đây là vòng quay mặc định
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

-- Hiển thị loading screen khi game bắt đầu hoặc khi cần
loadingScreen.Enabled = true

-- Giả sử đây là một tác vụ đang chạy, sau khi hoàn thành ta sẽ ẩn loading screen
wait(5)  -- Giả sử mất 5 giây để thực hiện một tác vụ
hideLoadingScreen()

-- Anti AFK
game:GetService("RunService").Heartbeat:Connect(function()
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
local gui = Instance.new("ScreenGui", LocalPlayer.PlayerGui)
gui.Name = "MovableUI"

local frame = Instance.new("Frame", gui)
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
