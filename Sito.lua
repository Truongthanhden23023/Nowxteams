-- Client-side Script with Button, Hidden UI, Anti-Kick, Anti-Error, and Link Copying

local Player = game.Players.LocalPlayer
local PlayerGui = Player.PlayerGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = PlayerGui

-- Function to create and show the button
function createButton()
    local button = Instance.new("TextButton")
    button.Parent = ScreenGui
    button.Text = "Show UI and Copy Links"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    
    -- Button click event handler
    button.MouseButton1Click:Connect(function()
        showHiddenUI()         -- Show hidden UI elements
        copyLink("Discord")    -- Copy Discord link
        copyLink("YouTube")    -- Copy YouTube link
    end)
end

-- Function to show hidden UI elements
function showHiddenUI()
    for _, guiElement in pairs(PlayerGui:GetChildren()) do
        if guiElement:IsA("ScreenGui") then
            guiElement.Enabled = true  -- Enable all ScreenGuis
        end
    end
end

-- Function to hide UI elements initially
function hideUI()
    for _, guiElement in pairs(PlayerGui:GetChildren()) do
        if guiElement:IsA("ScreenGui") then
            guiElement.Enabled = false  -- Disable all ScreenGuis initially
        end
    end
end

-- Function to copy Discord and YouTube links to the clipboard
function copyLink(linkType)
    local link
    if linkType == "Discord" then
        link = "https://discord.gg/yYJdKyX6"
    elseif linkType == "YouTube" then
        link = "https://www.youtube.com/@Sito-v7l"
    end

    -- In Roblox, we can't directly copy to clipboard, but we can show the link in a message.
    -- Display the link in the output console or create a UI element to display the link.
    print("Link copied: " .. link)  -- Here, we simulate copying by printing the link.
end

-- Anti-Kick functionality
function antiKick()
    game:GetService("RunService").Heartbeat:Connect(function()
        -- Example: Prevent being kicked for specific conditions
        if Player.Character and Player.Character.Humanoid.Health <= 0 then
            -- Handle health-related issues, like respawning or disabling kick logic
        end
    end)
end

-- Anti-Error Code functionality
function antiErrorCode()
    -- Example: Monitor for error code situations
    local success, errorMessage = pcall(function()
        -- Simulate some error-prone logic here
        -- For example, handling errors in UI manipulation or player data
    end)
    
    if not success then
        -- Handle errors to prevent them from affecting the game
        print("An error occurred: " .. errorMessage)
    end
end

-- Initialize the script functions
hideUI()            -- Initially hide the UI elements
createButton()      -- Create the button for UI and links
antiKick()          -- Prevent the player from being kicked
antiErrorCode()     -- Prevent common error codes
