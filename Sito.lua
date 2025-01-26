-- Mã UI điều khiển người chơi (Chế độ bay, tốc độ, tự click, làm mát và chống AFK) với xử lý lỗi và gán phím tùy chỉnh

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")

-- Hàm an toàn để gọi mã sử dụng pcall
local function safeCall(func)
    local success, result = pcall(func)
    if not success then
        -- Xử lý lỗi một cách hợp lý
        warn("Đã xảy ra lỗi: " .. result)  -- Ghi lại lỗi
    end
    return success, result
end

-- Tạo GUI
local ultimateControlGui = Instance.new("ScreenGui")
ultimateControlGui.Name = "NOW X TEAMS"
ultimateControlGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(255, 0, 0)  -- Viền đỏ để trông khác biệt
mainFrame.Parent = nowxteams

-- Tiêu đề với Icon
local headerLabel = Instance.new("TextLabel")
headerLabel.Size = UDim2.new(0, 350, 0, 50)
headerLabel.Position = UDim2.new(0, 0, 0, 0)
headerLabel.Text = "NOW X TEAMS"
headerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
headerLabel.TextSize = 24
headerLabel.BackgroundTransparency = 1
headerLabel.Parent = mainFrame

-- Thêm một Icon (ImageLabel) vào tiêu đề
local iconLabel = Instance.new("ImageLabel")
iconLabel.Size = UDim2.new(0, 50, 0, 50)
iconLabel.Position = UDim2.new(0, 10, 0, 10)  -- Đặt ở bên trái văn bản tiêu đề
iconLabel.Image = "rbxassetid://124990866893793"  -- Thay thế YOUR_ASSET_ID bằng ID của hình ảnh bạn muốn sử dụng
iconLabel.BackgroundTransparency = 1  -- Đảm bảo nền trong suốt
iconLabel.Parent = mainFrame

-- Gán phím tùy chỉnh
local customKey = "sito"  -- Phím mặc định
local keyBindingLabel = Instance.new("TextLabel")
keyBindingLabel.Size = UDim2.new(0, 200, 0, 50)
keyBindingLabel.Position = UDim2.new(0.5, -100, 0, 400)
keyBindingLabel.Text = "Phím Tùy chỉnh: " .. customKey
keyBindingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBindingLabel.TextSize = 18
keyBindingLabel.BackgroundTransparency = 1
keyBindingLabel.Parent = mainFrame

-- Ô nhập để thay đổi phím
local keyTextBox = Instance.new("TextBox")
keyTextBox.Size = UDim2.new(0, 200, 0, 50)
keyTextBox.Position = UDim2.new(0.5, -100, 0, 460)
keyTextBox.Text = ""
keyTextBox.PlaceholderText = "Nhập phím"
keyTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
keyTextBox.TextSize = 18
keyTextBox.BorderSizePixel = 2
keyTextBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
keyTextBox.Parent = mainFrame

-- Lắng nghe sự kiện phím để cập nhật khi người dùng nhập phím mới
keyTextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and keyTextBox.Text ~= "" then
        customKey = keyTextBox.Text  -- Cập nhật phím tùy chỉnh
        keyBindingLabel.Text = ": Phím Tùy Chỉnh" .. customKey  -- Cập nhật hiển thị phím mới
    end
end)

-- Lắng nghe sự kiện khi người dùng nhấn phím đã gán
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end  -- Nếu game đã xử lý sự kiện, không làm gì thêm
    if input.KeyCode.Name == customKey then
        -- Thực hiện hành động khi nhấn phím đã gán
        print("Phím " .. customKey .. " đã được nhấn!")
        -- Ví dụ: Thực hiện chế độ bay hoặc tốc độ
    end
end)

-- Các nút điều khiển khác (Ví dụ: Chế độ bay, tốc độ, tự click, làm mát) sẽ theo cách tương tự
