local MyGUI = {}
local TweenService = game:GetService("TweenService")

function MyGUI:CreateFrame(title, size, backgroundColor)
    local frame = Instance.new("Frame")
    frame.Parent = game.Players.LocalPlayer.PlayerGui
    frame.Position = UDim2.new(0.5, -size.X.Offset / 2, 0.5, -size.Y.Offset / 2)
    frame.Size = size or UDim2.new(0, 300, 0, 200)
    frame.BackgroundColor3 = backgroundColor or Color3.new(0, 0, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(1, 1, 1)

    local titleText = Instance.new("TextLabel")
    titleText.Parent = frame
    titleText.Size = UDim2.new(1, 0, 0, 30)
    titleText.BackgroundColor3 = Color3.new(0, 0, 0)
    titleText.Text = title or "Mada Hub"
    titleText.TextColor3 = Color3.new(1, 1, 1)
    titleText.BorderSizePixel = 0
    titleText.TextScaled = true

    local closeButton = Instance.new("TextButton")
    closeButton.Parent = frame
    closeButton.Position = UDim2.new(1, -30, 0, 5)
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.BackgroundColor3 = Color3.new(1, 0, 0)
    closeButton.BorderSizePixel = 0
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.new(1, 1, 1)

    closeButton.MouseButton1Click:Connect(function()
        frame:Destroy()
    end)

    local minimized = false

    local toggleButton = Instance.new("TextButton")
    toggleButton.Parent = frame
    toggleButton.Position = UDim2.new(0, 0, 1, -30)
    toggleButton.Size = UDim2.new(1, 0, 0, 30)
    toggleButton.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    toggleButton.BorderSizePixel = 0
    toggleButton.Text = "Toggle"
    toggleButton.TextColor3 = Color3.new(1, 1, 1)

    local toggleImage = Instance.new("ImageLabel")
    toggleImage.Parent = toggleButton
    toggleImage.Size = UDim2.new(0, 20, 0, 20)
    toggleImage.Position = UDim2.new(0, 5, 0, 5)
    toggleImage.BackgroundTransparency = 1
    toggleImage.Image = "rbxassetid://123456789" -- Remplace cette ID par l'asset ID de l'image que tu souhaites utiliser
    toggleImage.Visible = not minimized

    toggleButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        toggleImage.Visible = not minimized
        frame.Size = minimized and UDim2.new(0, 150, 0, 30) or size or UDim2.new(0, 300, 0, 200)

        -- Animation pour réduire/agrandir
        local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(frame, tweenInfo, {Size = frame.Size})
        tween:Play()
    end)

    local dragging
    local dragStart

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position - frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            frame.Position = UDim2.new(0, input.Position.X - dragStart.X, 0, input.Position.Y - dragStart.Y)
        end
    end)

    return frame
end

function MyGUI:CreateButton(parent, buttonText, size, position, onClick)
    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = size or UDim2.new(0, 100, 0, 50)
    button.Position = position or UDim2.new(0.5, -50, 0.5, -25)
    button.BackgroundColor3 = Color3.new(0, 0.5, 0)
    button.Text = buttonText or "Button"
    button.TextColor3 = Color3.new(1, 1, 1)

    button.MouseButton1Click:Connect(onClick)

    return button
end

function MyGUI:Notify(message)
    local notification = Instance.new("TextLabel")
    notification.Parent = game.Players.LocalPlayer.PlayerGui
    notification.Size = UDim2.new(0, 300, 0, 50)
    notification.Position = UDim2.new(0.5, -150, 0, 50)
    notification.BackgroundColor3 = Color3.new(0, 0.5, 0)
    notification.Text = message
    notification.TextColor3 = Color3.new(1, 1, 1)
    notification.TextScaled = true
    notification.BorderSizePixel = 0

    wait(3) -- Affiche la notification pendant 3 secondes
    notification:Destroy()
end

return MyGUI
