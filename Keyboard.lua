local UIS = game:GetService("UserInputService")
local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui

-- Create the virtual keyboard UI
local keyboardFrame = Instance.new("Frame")
keyboardFrame.Size = UDim2.new(0, 300, 0, 150)
keyboardFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
keyboardFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
keyboardFrame.BackgroundTransparency = 0.5
keyboardFrame.Parent = playerGui

-- Function to create buttons for each key
local function createKey(text, position)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 50, 0, 50)
    button.Position = UDim2.new(0, position.X, 0, position.Y)
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.Parent = keyboardFrame

    button.MouseButton1Click:Connect(function()
        print("Key pressed: " .. text)
        -- Add any functionality here for key press (e.g., typing text into an input box)
    end)
end

-- Create some keys for the virtual keyboard
local keys = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J"}

for i, key in ipairs(keys) do
    createKey(key, Vector2.new((i - 1) % 5 * 60, math.floor((i - 1) / 5) * 60))
end

-- Optional: Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 100, 0, 50)
closeButton.Position = UDim2.new(0.5, -50, 1, 10)
closeButton.Text = "Close"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Parent = keyboardFrame

closeButton.MouseButton1Click:Connect(function()
    keyboardFrame.Visible = false
end)

-- Optional: Add a button to show the keyboard again
local showButton = Instance.new("TextButton")
showButton.Size = UDim2.new(0, 100, 0, 50)
showButton.Position = UDim2.new(0.5, -50, 0, 10)
showButton.Text = "Show Keyboard"
showButton.TextColor3 = Color3.fromRGB(255, 255, 255)
showButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
showButton.Parent = playerGui

showButton.MouseButton1Click:Connect(function()
    keyboardFrame.Visible = true
end)
