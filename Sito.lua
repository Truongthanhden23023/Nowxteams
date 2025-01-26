local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Hàm xử lý lỗi khi tạo UI và các đối tượng
local function safeCreate(instanceType, parent, properties)
    local success, instance = pcall(function()
        local instance = Instance.new(instanceType)
        for prop, value in pairs(properties) do
            instance[prop] = value
        end
        if parent then
            instance.Parent = parent
        end
        return instance
    end)
    if not success then
        warn("Error creating instance: " .. tostring(instanceType))
    end
    return instance
end

-- Tạo một ScreenGui để chứa UI
local screenGui = safeCreate("ScreenGui", LocalPlayer.PlayerGui, {Name = "NOW X TEAMS", ResetOnSpawn = false})

-- Tạo một Frame để làm nền cho decal
local background = safeCreate("Frame", screenGui, {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.5
})

-- Tạo một ImageLabel để hiển thị Decal
local imageLabel = safeCreate("ImageLabel", background, {
    Size = UDim2.new(0, 200, 0, 200),
    Position = UDim2.new(0.5, -100, 0.5, -100),
    BackgroundTransparency = 1,
    Image = "rbxassetid://124990866893793"  -- Thay ID này bằng ID decal của bạn
})

-- Hiển thị UI
screenGui.Parent = LocalPlayer.PlayerGui

-- Tạo loading screen
local function createLoadingScreen()
    local loadingGui = safeCreate("ScreenGui", LocalPlayer.PlayerGui, {Name = "NOW X TEAMS", ResetOnSpawn = false})

    local loadingBackground = safeCreate("Frame", loadingGui, {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.5
    })

    local loadingText = safeCreate("TextLabel", loadingBackground, {
        Text = "Loading...",
        Size = UDim2.new(0, 200, 0, 50),
        Position = UDim2.new(0.5, -100, 0.5, -25),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 30,
        BackgroundTransparency = 1
    })

    local spinner = safeCreate("ImageLabel", loadingBackground, {
        Size = UDim2.new(0, 50, 0, 50),
        Position = UDim2.new(0.5, -25, 0.5, 25),
        Image = "rbxassetid://124990866893793",  -- ID vòng quay mặc định
        BackgroundTransparency = 1
    })

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
        pcall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- WalkSpeed bình thường
        end)
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
            pcall(fly) -- Bảo vệ việc gọi hàm fly
        end
    end
end)

-- Xử lý tất cả các lỗi không mong muốn
local function safeExecute(func)
    local success, errorMsg = pcall(func)
    if not success then
        warn("Error: " .. errorMsg)
    end
end

-- Đảm bảo toàn bộ script chạy an toàn
safeExecute(function()
    -- Các đoạn mã quan trọng cần được bảo vệ bằng pcall ở đây
end)
