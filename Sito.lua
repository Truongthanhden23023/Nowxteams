-- Get player and PlayerGui
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local ui = playerGui:WaitForChild("MyUI") -- A frame containing all UI elements
local textBox = ui:WaitForChild("MyTextBox") -- The TextBox where text is displayed
local createButton = ui:WaitForChild("CreateButton") -- The button to simulate keypress
local deleteButton = ui:WaitForChild("DeleteButton") -- The button to delete the last character
local toggleTextBoxButton = ui:WaitForChild("ToggleTextBoxButton") -- Button to toggle visibility of TextBox

-- Anti-kick and Anti-AFK settings
local AFKTimeLimit = 300 -- Time in seconds before AFK kick (e.g., 300s = 5 minutes)
local lastActivityTime = tick()

-- Anti-kick and Anti-AFK logic
game:GetService("Players").PlayerAdded:Connect(function(player)
    player.Idled:Connect(function()
        lastActivityTime = tick()  -- Prevent idle kick by resetting AFK timer
    end)
end)

-- Track player input for Anti-AFK
local function onPlayerInput(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Keyboard then
        lastActivityTime = tick()  -- Reset AFK timer on player input
    end
end

game:GetService("UserInputService").InputBegan:Connect(onPlayerInput)

-- Anti-AFK simulation to keep player active
game:GetService("RunService").Heartbeat:Connect(function()
    if tick() - lastActivityTime > AFKTimeLimit then
        -- Simulate activity to prevent AFK (e.g., mouse click)
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
    end
end)

-- Auto-click feature
local autoClickEnabled = false
local autoClickInterval = 0.1  -- Interval in seconds
local nextAutoClickTime = 0

local function toggleAutoClick()
    autoClickEnabled = not autoClickEnabled
end

game:GetService("RunService").Heartbeat:Connect(function()
    if autoClickEnabled and tick() >= nextAutoClickTime then
        -- Simulate a click (you can adjust the position)
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(0, 0))
        nextAutoClickTime = tick() + autoClickInterval
    end
end)

-- Speed boost logic
local speedBoostEnabled = false
local originalSpeed = player.Character and player.Character.Humanoid.WalkSpeed or 16
local speedMultiplier = 2  -- Speed multiplier for boost

local function toggleSpeedBoost()
    speedBoostEnabled = not speedBoostEnabled
    if player.Character and player.Character.Humanoid then
        if speedBoostEnabled then
            player.Character.Humanoid.WalkSpeed = originalSpeed * speedMultiplier
        else
            player.Character.Humanoid.WalkSpeed = originalSpeed
        end
    end
end

-- TextBox and cooldown logic
local cooldownEnabled = false
local cooldownTime = 5  -- Cooldown time in seconds
local lastActionTime = 0

local function performActionWithCooldown()
    if tick() - lastActionTime >= cooldownTime then
        -- Perform action (e.g., print text from TextBox)
        print("Entered Text: " .. textBox.Text)
        lastActionTime = tick()
    else
        print("Action is on cooldown!")
    end
end

-- Handle clicking "Create" button (prints the TextBox text)
createButton.MouseButton1Click:Connect(function()
    performActionWithCooldown()
end)

-- Handle deleting last character in TextBox
deleteButton.MouseButton1Click:Connect(function()
    textBox.Text = textBox.Text:sub(1, -2)  -- Remove last character
end)

-- Virtual Keyboard to type in TextBox
local function createKeyboard()
    local startX = 0
    local startY = 0
    local buttonSize = UDim2.new(0, 50, 0, 50)  -- Button size
    local spacing = 10  -- Space between buttons

    for i, letter in ipairs({"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}) do
        -- Create the button
        local button = Instance.new("TextButton")
        button.Parent = ui
        button.Text = letter
        button.Size = buttonSize
        button.Position = UDim2.new(0, startX, 0, startY)
        button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        button.TextColor3 = Color3.fromRGB(0, 0, 0)

        -- Button click event to add letter to TextBox
        button.MouseButton1Click:Connect(function()
            textBox.Text = textBox.Text .. letter
        end)

        -- Update position for the next button in the row
        startX = startX + buttonSize.X.Offset + spacing
        if startX > 400 then  -- Change row after 10 buttons (adjust as needed)
            startX = 0
            startY = startY + buttonSize.Y.Offset + spacing
        end
    end
end

-- Toggle visibility of TextBox and virtual keyboard
local textBoxVisible = false
toggleTextBoxButton.MouseButton1Click:Connect(function()
    textBoxVisible = not textBoxVisible
    textBox.Visible = textBoxVisible
    if textBoxVisible then
        createKeyboard()  -- Create keyboard if TextBox is shown
    else
        -- Remove keyboard when hiding TextBox
        for _, child in pairs(ui:GetChildren()) do
            if child:IsA("TextButton") and child.Text ~= textBox.Text then
                child:Destroy()
            end
        end
    end
end)

-- Speed Boost Toggle Button
local speedBoostButton = ui:WaitForChild("SpeedBoostButton") -- Assuming you have a SpeedBoostButton
speedBoostButton.MouseButton1Click:Connect(function()
    toggleSpeedBoost()
end)

-- Auto-click Toggle Button
local autoClickButton = ui:WaitForChild("AutoClickButton") -- Assuming you have an AutoClickButton
autoClickButton.MouseButton1Click:Connect(function()
    toggleAutoClick()
end)
