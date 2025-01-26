-- Rename Script Function
local function renameScript(newName)
    script.Name = newName
    print("-----NOW X TEAMS Việt Nam------" .. newName)
end

-- Example of renaming the script to 'NewScriptName'
renameScript("NOW X TEAMS")

-- Anti-Kick
game:GetService("Players").PlayerAdded:Connect(function(player)
    local function checkConnection()
        if player.Status == Enum.PlayerStatus.Kicked then
            player:Kick("You have been kicked due to an error.")
        end
    end
    player.Changed:Connect(checkConnection)
end)

-- Anti-ErrorCode
local function handleErrorCode()
    -- Add specific error code handling here
    local success, result = pcall(function()
        -- Simulating some error-prone code here
        error("Simulated error")
    end)

    if not success then
        print("An error occurred: " .. result)
        -- Handle the error accordingly
    end
end

-- UI Toggle
local toggleUI = false
local function toggleUIVisibility()
    if toggleUI then
        -- Code to hide UI
        print("UI hidden")
    else
        -- Code to show UI
        print("UI visible")
    end
    toggleUI = not toggleUI
end

-- FPS Display
local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 200, 0, 50)
fpsLabel.Position = UDim2.new(0, 10, 0, 10)
fpsLabel.Text = "FPS: " .. tostring(workspace:GetService("RunService").Heartbeat:Wait())
fpsLabel.Parent = game.Players.LocalPlayer.PlayerGui

local function updateFPS()
    local fps = math.floor(1 / workspace:GetService("RunService").Heartbeat:Wait())
    fpsLabel.Text = "FPS: " .. fps
end
while true do
    updateFPS()
    wait(1)
end

-- Link Buttons
local discordLink = Instance.new("TextButton")
discordLink.Size = UDim2.new(0, 200, 0, 50)
discordLink.Position = UDim2.new(0, 10, 0, 70)
discordLink.Text = "Join Discord"
discordLink.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/yYJdKyX6")
end)
discordLink.Parent = game.Players.LocalPlayer.PlayerGui

local youtubeLink = Instance.new("TextButton")
youtubeLink.Size = UDim2.new(0, 200, 0, 50)
youtubeLink.Position = UDim2.new(0, 10, 0, 130)
youtubeLink.Text = "Visit YouTube"
youtubeLink.MouseButton1Click:Connect(function()
    setclipboard("https://www.youtube.com/@Sito-v7l")
end)
youtubeLink.Parent = game.Players.LocalPlayer.PlayerGui

-- UI Toggle Handler
local userInputService = game:GetService("UserInputService")
userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.T then
        toggleUIVisibility()
    end
end)
