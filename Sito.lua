local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()
local UIS = game:GetService("UserInputService")
local tweenService = game:GetService("TweenService")

-- UI Elements (Create these in your Roblox Studio UI)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextBox = Instance.new("TextBox")
local ToggleButton = Instance.new("TextButton")
ScreenGui.Parent = player:WaitForChild("PlayerGui")
Frame.Parent = ScreenGui
TextBox.Parent = Frame
ToggleButton.Parent = Frame

-- UI Design (optional for your custom look)
Frame.Size = UDim2.new(0, 200, 0, 100)
TextBox.Size = UDim2.new(0, 180, 0, 40)
ToggleButton.Size = UDim2.new(0, 180, 0, 40)
ToggleButton.Text = "Toggle UI"

local cooldown = false
local speed = 50
local autoClickEnabled = false
local antiAFKEnabled = false
local antiKickEnabled = false
local cooldownTime = 2 -- Time in seconds for the cooldown

-- Anti-Kick and Anti-AFK Setup
local function preventAFK()
    while true do
        if antiAFKEnabled then
            game:GetService("Players").LocalPlayer.Idled:connect(function()
                -- Prevent AFK by moving the player
                game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end
        wait(60) -- Check every minute
    end
end

local function preventKick()
    while true do
        if antiKickEnabled then
            -- Anti-kick logic (could involve random movements or other triggers)
            player.Character:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-5, 5), 0, math.random(-5, 5)))
        end
        wait(5) -- Check every 5 seconds
    end
end

-- Auto Clicker
local function autoClick()
    while autoClickEnabled do
        mouse1click()
        wait(0.1) -- Adjust the rate of clicks
    end
end

-- Speed Boost (moves player faster)
local function speedBoost()
    while speed > 0 do
        player.Character.Humanoid.WalkSpeed = speed
        wait(0.1)
    end
end

-- UI Toggle Functionality
local function toggleUI()
    Frame.Visible = not Frame.Visible
end

-- Handling Key Inputs
UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleUI() -- Toggle UI when pressing F
    end
end)

-- Toggle Auto Clicker
ToggleButton.MouseButton1Click:Connect(function()
    if cooldown then return end
    cooldown = true

    autoClickEnabled = not autoClickEnabled
    if autoClickEnabled then
        -- Start auto-click
        spawn(autoClick)
    end
    wait(cooldownTime)
    cooldown = false
end)

-- Textbox functionality (optional use)
TextBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        -- Handle text input here, for example, changing speed or other parameters
        local userInput = tonumber(TextBox.Text)
        if userInput then
            speed = userInput -- Adjust speed based on textbox input
        end
    end
end)

-- Start Anti-AFK and Anti-Kick threads
spawn(preventAFK)
spawn(preventKick)

-- Start Speed Boost functionality
spawn(speedBoost)
