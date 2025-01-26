-- Kết nối dịch vụ cần thiết
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ui = script.Parent -- Giả sử UI nằm trong phần tử script
local cooldownTime = 5 -- Thời gian cooldown (giây)
local lastActionTime = 0 -- Thời gian thực hiện hành động lần cuối
local buttons = {} -- Danh sách chứa tất cả các nút
local keyButtons = {} -- Danh sách các phím ảo nhỏ PC

-- Tạo một nút ảo cho mỗi chữ cái từ A-Z và phím cách
local function createKeyButton(key, position, size)
    local keyButton = Instance.new("TextButton")
    keyButton.Size = UDim2.new(0, size.X, 0, size.Y)
    keyButton.Position = UDim2.new(0, position.X, 0, position.Y)
    keyButton.Text = key
    keyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    keyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    keyButton.Parent = game.Players.LocalPlayer.PlayerGui -- Thêm nút vào UI của người chơi

    -- Gán sự kiện chạm vào nút
    keyButton.MouseButton1Click:Connect(function()
        print(key .. " key pressed!")
    end)

    return keyButton
end

-- Tạo các phím ảo nhỏ (A-Z và phím Space) cho PC
local function createSmallKeyButtons()
    local startPosX = 20
    local startPosY = 200
    local spacing = 30 -- Khoảng cách giữa các phím ảo nhỏ
    local keySize = Vector2.new(30, 30) -- Kích thước nhỏ của mỗi phím ảo

    -- Tạo các nút chữ cái từ A đến Z
    local position = Vector2.new(startPosX, startPosY)
    for i = 1, 26 do
        local key = string.char(64 + i)  -- Lấy ký tự từ A đến Z
        local button = createKeyButton(key, position, keySize)
        table.insert(keyButtons, button)

        -- Cập nhật vị trí cho nút tiếp theo
        if i % 10 == 0 then
            position = Vector2.new(startPosX, position.Y + spacing) -- Dịch xuống dòng sau 10 phím
        else
            position = Vector2.new(position.X + spacing, position.Y) -- Dịch sang phải
        end
    end

    -- Tạo phím cách (space)
    local spaceButton = createKeyButton("Space", Vector2.new(startPosX, position.Y + spacing), keySize)
    table.insert(keyButtons, spaceButton)
end

-- Tạo nút ảo hiển thị UI
local function createToggleButton()
    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 100, 0, 50)
    toggleButton.Position = UDim2.new(0, 20, 0, 20)
    toggleButton.Text = "Toggle UI"
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.Parent = game.Players.LocalPlayer.PlayerGui -- Thêm nút vào UI của người chơi

    -- Gán sự kiện chạm vào nút
    toggleButton.MouseButton1Click:Connect(function()
        ui.Enabled = not ui.Enabled
    end)
end

-- Hàm bắt sự kiện phím F cho PC và phím B cho điện thoại
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.F then -- Phím F để toggle UI
        ui.Enabled = not ui.Enabled
    end
end)

-- Anti AFK (Giữ người chơi hoạt động)
local function antiAFK()
    local afkTimer = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        afkTimer = afkTimer + 1
        if afkTimer >= 30 then
            -- Tạo hành động để tránh AFK, như di chuyển nhẹ hoặc nhấn phím
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0)) -- Giả lập click
            afkTimer = 0
        end
    end)
end

-- Anti Kick (Chống bị kick ra ngoài)
local function antiKick()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0)) -- Giả lập click để tránh kick
    end)
end

-- Auto-Click và Auto-Jump với cooldown
local function autoActions()
    local lastClickTime = 0
    game:GetService("RunService").Heartbeat:Connect(function()
        if tick() - lastClickTime > cooldownTime then
            -- Thực hiện auto click
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Click!", "All")
            lastClickTime = tick()
        end
    end)
end

-- Tạo nút ảo cho các phím A-Z và phím Space
createSmallKeyButtons()

-- Tạo nút ảo hiển thị UI
createToggleButton()

-- Gọi các chức năng Anti-AFK, Anti-Kick và Auto-Click
antiAFK()
antiKick()
autoActions()
