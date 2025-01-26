-- Create a TextBox and a button in the Roblox UI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0, 50, 0, 50)
textBox.PlaceholderText = "Type something..."
textBox.Parent = screenGui

local enterButton = Instance.new("TextButton")
enterButton.Size = UDim2.new(0, 100, 0, 50)
enterButton.Position = UDim2.new(0, 50, 0, 150)
enterButton.Text = "Enter"
enterButton.Parent = screenGui

-- Function to simulate Enter key press
local function onEnterPressed()
    print("Enter key pressed. Text entered:", textBox.Text)
    textBox.Text = ""  -- Clear the text box after pressing Enter
end

-- Detect the Enter key press (for simulation)
enterButton.MouseButton1Click:Connect(onEnterPressed)

-- Optional: Detect keyboard Enter key press directly
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.Return then
        onEnterPressed()
    end
end)
