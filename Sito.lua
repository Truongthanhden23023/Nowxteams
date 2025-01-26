-- UIVisibilityToggle (LocalScript)

-- Đặt tên cho script trong mã (giúp quản lý script dễ dàng hơn)
local scriptName = "NOW X TEAMS"  -- Tên script: UIVisibilityToggle

-- Lấy đối tượng Player
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Tạo một ScreenGui để chứa các phần tử UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Tạo một Frame để chứa các phần tử UI khác
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)  -- Kích thước của frame
frame.Position = UDim2.new(0.5, -150, 0.5, -100)  -- Vị trí của frame (giữa màn hình)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Màu nền của frame
frame.BackgroundTransparency = 0.5  -- Độ trong suốt của nền
frame.Parent = screenGui

-- Tạo một TextLabel để hiển thị văn bản
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 280, 0, 50)  -- Kích thước của TextLabel
textLabel.Position = UDim2.new(0, 10, 0, 10)  -- Vị trí của TextLabel
textLabel.Text = "Chào mừng đến với UI!"  -- Nội dung văn bản
textLabel.TextSize = 24  -- Kích thước chữ
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ
textLabel.Parent = frame

-- Tạo một TextButton để bật/tắt UI
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 280, 0, 50)  -- Kích thước của nút
toggleButton.Position = UDim2.new(0, 10, 0, 70)  -- Vị trí của nút
toggleButton.Text = "Bật/Tắt UI"  -- Nội dung nút
toggleButton.TextSize = 24  -- Kích thước chữ
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Màu chữ
toggleButton.BackgroundColor3 = Color3.fromRGB(0, 128, 0)  -- Màu nền của nút
toggleButton.Parent = frame

-- Biến trạng thái để bật/tắt UI
local isUIVisible = true

-- Khi người chơi bấm vào nút, UI sẽ bật/tắt
toggleButton.MouseButton1Click:Connect(function()
    isUIVisible = not isUIVisible
    screenGui.Visible = isUIVisible  -- Bật/tắt UI
end)

-- Kiểm tra lỗi và phòng ngừa kick
local function safeAction(player)
    -- Kiểm tra nếu người chơi và nhân vật tồn tại
    if not player or not player.Character then
        warn(player.Name .. " không có nhân vật hoặc không kết nối đúng cách!")
        return false
    end

    -- Kiểm tra nếu nhân vật có đối tượng "Humanoid"
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then
        warn(player.Name .. " không có Humanoid!")
        return false
    end

    -- Kiểm tra quyền truy cập của người chơi (ví dụ: nhóm)
    if not player:IsInGroup(1234567) then
        warn(player.Name .. " không có quyền truy cập!")
        return false
    end

    return true
end

-- Phòng ngừa kick và lỗi bằng cách kiểm tra trước khi thay đổi giá trị
local function changeHealth(player, health)
    -- Kiểm tra nếu người chơi có quyền thay đổi sức khỏe
    if safeAction(player) then
        -- Giới hạn giá trị sức khỏe hợp lệ
        if health < 0 or health > 100 then
            warn("Sức khỏe không hợp lệ!")
            return
        end
        player.Character.Humanoid.Health = health
    end
end

-- Giới hạn tốc độ di chuyển hợp lệ (Phòng ngừa kick)
local function setWalkSpeed(player, speed)
    -- Kiểm tra nếu người chơi có quyền thay đổi tốc độ
    if safeAction(player) then
        -- Giới hạn tốc độ di chuyển hợp lệ
        player.Character.Humanoid.WalkSpeed = math.clamp(speed, 0, 100)
    end
end

-- Ví dụ sử dụng: Thay đổi sức khỏe và tốc độ di chuyển
game.Players.PlayerAdded:Connect(function(player)
    -- Kiểm tra và thay đổi sức khỏe
    changeHealth(player, 50)
    
    -- Thay đổi tốc độ di chuyển (giới hạn tốc độ hợp lệ)
    setWalkSpeed(player, 50)
end)

-- Đặt tên script trong hệ thống (chỉ để ghi nhớ trong mã)
print("Script name: NOW X TEAMS" .. scriptName)
