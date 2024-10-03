Dimins = {}

local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}
function Dimins:DraggingEnabled(frame, parent)
        
    parent = parent or frame
    
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end


local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
    Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
}
local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(0, 0, 0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    },
    BloodTheme = {
        SchemeColor = Color3.fromRGB(227, 27, 27),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    GrapeTheme = {
        SchemeColor = Color3.fromRGB(166, 71, 214),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    Ocean = {
        SchemeColor = Color3.fromRGB(86, 76, 251),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(200, 200, 200),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    Midnight = {
        SchemeColor = Color3.fromRGB(26, 189, 158),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    Sentinel = {
        SchemeColor = Color3.fromRGB(230, 35, 69),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(119, 209, 138),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    Synapse = {
        SchemeColor = Color3.fromRGB(46, 48, 43),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(152, 99, 53),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    },
    Serpent = {
        SchemeColor = Color3.fromRGB(0, 166, 58),
        Background = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        Header = Color3.fromRGB(255, 255, 255), -- Trocar marrom por branco
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
    }
}
local oldTheme = ""

local SettingsT = {}

local Name = "DiminsConfig.JSON"

pcall(function()

if not pcall(function() readfile(Name) end) then
    writefile(Name, game:service'HttpService':JSONEncode(SettingsT))
end

Settings = game:service'HttpService':JSONEncode(readfile(Name))
end)

local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

function Dimins:ToggleUI()
    if game.CoreGui[LibName].Enabled then
        game.CoreGui[LibName].Enabled = false
    else
        game.CoreGui[LibName].Enabled = true
    end
end

function Dimins.CreateLib(kavName, themeList)
    if not themeList then
        themeList = themes
    end
    if themeList == "DarkTheme" then
        themeList = themeStyles.DarkTheme
    elseif themeList == "LightTheme" then
        themeList = themeStyles.LightTheme
    elseif themeList == "BloodTheme" then
        themeList = themeStyles.BloodTheme
    elseif themeList == "GrapeTheme" then
        themeList = themeStyles.GrapeTheme
    elseif themeList == "Ocean" then
        themeList = themeStyles.Ocean
    elseif themeList == "Midnight" then
        themeList = themeStyles.Midnight
    elseif themeList == "Sentinel" then
        themeList = themeStyles.Sentinel
    elseif themeList == "Synapse" then
        themeList = themeStyles.Synapse
    elseif themeList == "Serpent" then
        themeList = themeStyles.Serpent
    else
        if themeList.SchemeColor == nil then
            themeList.SchemeColor = Color3.fromRGB(74, 99, 135)
        elseif themeList.Background == nil then
            themeList.Background = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
        elseif themeList.Header == nil then
            themeList.Header = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
        elseif themeList.TextColor == nil then
            themeList.TextColor = Color3.fromRGB(255, 255, 255)
        elseif themeList.ElementColor == nil then
            themeList.ElementColor = Color3.fromRGB(255, 255, 255) -- Trocar marrom por branco
        end
    end

    themeList = themeList or {}
    local selectedTab 
    kavName = kavName or "Library"
    table.insert(Dimins, kavName)
    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")
    local blurFrame = Instance.new("Frame")
    local close = Instance.new("ImageButton")
    local title = Instance.new("TextLabel")

    blurFrame.Name = "BlurFrame"
    blurFrame.Parent = game.CoreGui
    blurFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    blurFrame.BackgroundTransparency = 1
    blurFrame.BorderSizePixel = 0
    blurFrame.Size = UDim2.new(1, 0, 1, 0)
    blurFrame.ZIndex = 0

    local tweeninfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
    local goal = {}
    goal.BackgroundTransparency = 0.6
    tween:Create(blurFrame, tweeninfo, goal):Play()

    ScreenGui.Name = kavName
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -175, 0.5, -175)
    Main.Size = UDim2.new(0, 350, 0, 350)
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.BorderSizePixel = 0
    MainHeader.Size = UDim2.new(1, 0, 0, 50)

    headerCover.CornerRadius = UDim.new(0, 10)
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.SchemeColor
    coverup.BorderSizePixel = 0
    coverup.Size = UDim2.new(1, 0, 1, 0)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1
    title.BorderSizePixel = 0
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Font = Enum.Font.SourceSansBold
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 14
    title.TextStrokeTransparency = 0.5

    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    close.BackgroundTransparency = 1
    close.BorderSizePixel = 0
    close.Position = UDim2.new(1, -30, 0.5, -10)
    close.Size = UDim2.new(0, 20, 0, 20)
    close.Image = "rbxassetid://3926305904" 
    close.ImageColor3 = themeList.TextColor
    close.ImageRectOffset = Vector2.new(964, 284)
    close.ImageRectSize = Vector2.new(36, 36)
    close.MouseButton1Click:Connect(function()
        Dimins:ToggleUI()
    end)

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.ElementColor
    MainSide.BorderSizePixel = 0
    MainSide.Position = UDim2.new(0, 0, 0, 50)
    MainSide.Size = UDim2.new(0, 100, 1, -50)

    sideCorner.CornerRadius = UDim.new(0, 10)
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.SchemeColor
    coverup_2.BorderSizePixel = 0
    coverup_2.Size = UDim2.new(1, 0, 1, 0)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = Main
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1
    tabFrames.BorderSizePixel = 0
    tabFrames.Position = UDim2.new(0, 100, 0, 50)
    tabFrames.Size = UDim2.new(1, -100, 1, -50)

    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = tabFrames
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1
    pages.BorderSizePixel = 0
    pages.Size = UDim2.new(1, 0, 1, 0)

    Pages.Name = "Pages"
    Pages.Parent = pages

    local function createTab(tabName)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = "TabButton"
        tabButton.Parent = MainSide
        tabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.BackgroundTransparency = 1
        tabButton.BorderSizePixel = 0
        tabButton.Size = UDim2.new(1, 0, 0, 30)
        tabButton.Font = Enum.Font.SourceSans
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 16
        tabButton.TextStrokeTransparency = 0.5

        local tabFrame = Instance.new("Frame")
        tabFrame.Name = tabName
        tabFrame.Parent = Pages
        tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabFrame.BackgroundTransparency = 1
        tabFrame.BorderSizePixel = 0
        tabFrame.Size = UDim2.new(1, 0, 1, 0)

        tabButton.MouseButton1Click:Connect(function()
            for _, child in pairs(Pages:GetChildren()) do
                if child:IsA("Frame") then
                    child.Visible = false
                end
            end
            tabFrame.Visible = true
        end)

        if not selectedTab then
            selectedTab = tabFrame
            tabFrame.Visible = true
        else
            tabFrame.Visible = false
        end
    end

    function Dimins:AddTab(tabName)
        createTab(tabName)
    end

    function Dimins:AddToggle(tabName, toggleName, callback)
        local toggleButton = Instance.new("TextButton")
        toggleButton.Name = toggleName
        toggleButton.Parent = pages[tabName]
        toggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        toggleButton.BorderSizePixel = 0
        toggleButton.Size = UDim2.new(1, 0, 0, 40)
        toggleButton.Font = Enum.Font.SourceSans
        toggleButton.Text = toggleName
        toggleButton.TextColor3 = themeList.TextColor
        toggleButton.TextSize = 14

        toggleButton.MouseButton1Click:Connect(function()
            if toggleButton.BackgroundColor3 == themeList.SchemeColor then
                toggleButton.BackgroundColor3 = themeList.ElementColor
                if callback then callback(false) end
            else
                toggleButton.BackgroundColor3 = themeList.SchemeColor
                if callback then callback(true) end
            end
        end)
    end

    function Dimins:AddSlider(tabName, sliderName, minValue, maxValue, defaultValue, callback)
        local sliderFrame = Instance.new("Frame")
        sliderFrame.Name = sliderName
        sliderFrame.Parent = pages[tabName]
        sliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        sliderFrame.BorderSizePixel = 0
        sliderFrame.Size = UDim2.new(1, 0, 0, 40)

        local sliderBar = Instance.new("Frame")
        sliderBar.Name = "SliderBar"
        sliderBar.Parent = sliderFrame
        sliderBar.BackgroundColor3 = themeList.SchemeColor
        sliderBar.BorderSizePixel = 0
        sliderBar.Size = UDim2.new(1, 0, 0, 10)

        local sliderThumb = Instance.new("Frame")
        sliderThumb.Name = "SliderThumb"
        sliderThumb.Parent = sliderBar
        sliderThumb.BackgroundColor3 = themeList.ElementColor
        sliderThumb.BorderSizePixel = 0
        sliderThumb.Size = UDim2.new(0, 10, 0, 10)
        sliderThumb.AnchorPoint = Vector2.new(0.5, 0.5)
        sliderThumb.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0.5, 0)

        sliderThumb.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                local function updateSlider()
                    local mouse = game.Players.LocalPlayer:GetMouse()
                    local newPosition = UDim2.new((math.clamp(mouse.X - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X) / sliderBar.AbsoluteSize.X), 0, 0.5, 0)
                    sliderThumb.Position = newPosition
                    local value = math.floor((newPosition.X.Scale * (maxValue - minValue)) + minValue)
                    if callback then callback(value) end
                end

                updateSlider()
                local connection
                connection = input.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider()
                    end
                end)
                input.InputEnded:Connect(function()
                    connection:Disconnect()
                end)
            end
        end)

        local sliderLabel = Instance.new("TextLabel")
        sliderLabel.Parent = sliderFrame
        sliderLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        sliderLabel.BackgroundTransparency = 1
        sliderLabel.Size = UDim2.new(0, 100, 1, 0)
        sliderLabel.TextColor3 = themeList.TextColor
        sliderLabel.Text = sliderName .. ": " .. defaultValue
        sliderLabel.Position = UDim2.new(1, 10, 0, 0)
        sliderLabel.AnchorPoint = Vector2.new(1, 0)

        callback(defaultValue) -- Call the callback with the default value

        -- Update the label when the slider is moved
        sliderThumb:GetPropertyChangedSignal("Position"):Connect(function()
            local value = math.floor((sliderThumb.Position.X.Scale * (maxValue - minValue)) + minValue)
            sliderLabel.Text = sliderName .. ": " .. value
        end)
    end

    return Dimins
end

return Dimins
