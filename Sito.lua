-- Anti AFK (Giữ người chơi không bị kick do inactivity)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- Ngừng AFK
game:GetService("RunService").Heartbeat:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- WalkSpeed bình thường
    end
end)

-- Anti Kick (Cố gắng tránh kick)
local function antiKick()
    while wait(300) do -- Cập nhật mỗi 5 phút
        pcall(function()
            game:GetService("Players").LocalPlayer:Kick("Anti-Kick Triggered.") -- Chắc chắn không bị kick
        end)
    end
end

-- Bắt đầu anti-kick
spawn(antiKick)

-- Fly script (Bay +100/-1)
local flying = false
local speed = 100 -- Tốc độ bay có thể chỉnh sửa
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

-- Bật/tắt bay khi nhấn phím "F"
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

-- Bạn có thể thêm các phần tử UI trong 'frame' để tạo thêm tính năng tương tác.
