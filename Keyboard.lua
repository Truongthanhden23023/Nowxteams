-- Tạo GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer.PlayerGui

-- Tạo TextBox
local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 200, 0, 50)
textBox.Position = UDim2.new(0, 100, 0, 100)
textBox.PlaceholderText = "Nhập gì đó..."
textBox.Parent = screenGui

-- Tạo nút để ẩn/hiện TextBox
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 100, 0, 50)
toggleButton.Position = UDim2.new(0, 100, 0, 160)
toggleButton.Text = "Ẩn/Hiện TextBox"
toggleButton.Parent = screenGui

-- Tạo nút "Delete"
local deleteButton = Instance.new("TextButton")
deleteButton.Size = UDim2.new(0, 100, 0, 50)
deleteButton.Position = UDim2.new(0, 220, 0, 160)
deleteButton.Text = "Xóa"
deleteButton.Parent = screenGui

-- Tạo nút "Enter"
local enterButton = Instance.new("TextButton")
enterButton.Size = UDim2.new(0, 100, 0, 50)
enterButton.Position = UDim2.new(0, 340, 0, 160)
enterButton.Text = "Enter"
enterButton.Parent = screenGui

-- Ẩn TextBox khi bắt đầu
textBox.Visible = false

-- Chức năng ẩn/hiện TextBox
toggleButton.MouseButton1Click:Connect(function()
    textBox.Visible = not textBox.Visible
end)

-- Chức năng xóa nội dung TextBox
deleteButton.MouseButton1Click:Connect(function()
    textBox.Text = ""
end)

-- Chức năng của nút Enter
enterButton.MouseButton1Click:Connect(function()
    print("Nội dung nhập vào là: " .. textBox.Text) -- Ví dụ: Hiển thị nội dung nhập vào
end)
