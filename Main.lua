getgenv().delusion = {
    ['Aimbot'] = {
        ['Keybind'] = Enum.KeyCode.X,

        ['Prediction'] = 0.135,
        ['Part'] = "HumanoidRootPart",

        ["CameraSmoothing"] = 0.15,
        ['ShakePower'] = 0,

        ['Jump'] = 0.56,
        ['Fall'] = -0.20,

        ["HitChance"] = true,
        ["PredictMovement"] = true,

        ["ThirdPerson"] = false,
        ["FirstPerson"] = true,
        
        ["EasingStyle"] = "Linear",
        ["EasingDirection"] = "In",
    },
    ['Silent'] = {
        ["Prediction"] = 0.14276,
        ["NearestPart"] = false,
        ["SelectedParts"] = {"Head", "HumanoidRootPart", "LowerTorso"},
        ["Detection"] = {
            ['Close'] = 35, 
            ['Mid'] = 65, 
            ['Far'] = math.huge
        },
        ["Config"] = {
            ["Points"] = {
                ["Point Offset"] = 0
            }
        }
    },
    ['RangeHit'] = {
        ["Enabled"] = false,
        ["Prediction"] = {
            ['Close'] = 0.138, 
            ['Mid'] = 0.1247, 
            ['Far'] = 0.123
        }
    },
    ["Checks"] = {
        ['DisableOnTargetDeath'] = true,
        ['DisableOnPlayerDeath'] = true,
        ['CheckKoStatus'] = true,
        ["AntiGroundShots"] = false,
        ["Curve"] = false,
    },
    ["MouseTp"] = {
        ['Smoothness'] = 0.8,
        ['HorizontalPrediction'] = 0.9,
        ['VerticalPrediction'] = 0.8,
        ['Part'] = "Head",
        ['Shake'] = true,
        ['ShakeAmount'] = {
            ["X"] = 2,
            ["Y"] = 2,
            ["Z"] = 2
        },
    },
    ["ViewCircle"] = {
        ["ShowCircle"] = true,
        ["UseRainbow"] = true,
        ["DotCount"] = 50,
        ["DotSize"] = 5,
        ["CircleRadius"] = 100,
        ["CircleOpacity"] = 1,
        ["LineThickness"] = 0.7,
        ["CircleColor"] = Color3.fromRGB(255, 255, 255)
    },
    ["PulseEffect"] = {
        ["Active"] = true,
        ["Intensity"] = 60,
        ["Frequency"] = 0.2
    },
    ["SpinEffect"] = {
        ["Active"] = true,
        ["RotationSpeed"] = 0.2
    },  
    ["Spin"] = {
        ['Enabled'] = true,
        ['SpinSpeed'] = 4900,
        ['Degrees'] = 360,
        ['Keybind'] = Enum.KeyCode.V,
    },
    ["Esp"] = {
        ['Chams'] = false,
        ['Key'] = Enum.KeyCode.T,
        ['Color'] = Color3.fromRGB(10, 50, 10),
        ['Outline'] = Color3.fromRGB(50, 50, 50)
    },
    ["Macro"] = {
        ['Enabled'] = false,
        ['Keybind'] = "x",  
        ['SideButton'] = {
            ['Enabled'] = true,
            ['Button'] = "Button4"
        },
        ['Speed'] = 0.5,
        ['Type'] = "Third", 
        ['Cooldown'] = 1,  
        ['MaxRepetitions'] = 100, 
        ['MaxDuration'] = 30,
        ['ActiveCount'] = 0 
    },
    ["Cframe"] = {
        ['Enabled'] = true,
        ['Toggle'] = "V",
        ['Multiplier'] = 0.5,
        ['Speed'] = 2
    }
}

-- Macro Script
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local SpeedGlitch = false
local VirtualInputManager = game:GetService("VirtualInputManager")

local function toggleMacro()
    if not getgenv().delusion.Macro.Enabled then return end
    SpeedGlitch = not SpeedGlitch  
    getgenv().delusion.Macro.ActiveCount = 0  
    local speed = getgenv().delusion.Macro.Speed / 100
    local maxRepetitions = getgenv().delusion.Macro.MaxRepetitions
    local maxDuration = getgenv().delusion.Macro.MaxDuration
    local startTime = os.clock()  

    while SpeedGlitch and getgenv().delusion.Macro.ActiveCount < maxRepetitions do
        if os.clock() - startTime > maxDuration then
            break  
        end

        getgenv().delusion.Macro.ActiveCount += 1
        if getgenv().delusion.Macro.Type == "Third" then
            VirtualInputManager:SendKeyEvent(true, "I", false, game)
            task.wait(speed)
            VirtualInputManager:SendKeyEvent(true, "O", false, game)
            task.wait(speed)
        elseif getgenv().delusion.Macro.Type == "First" then
            VirtualInputManager:SendMouseWheelEvent(0, 0, true, game)
            task.wait(speed)
            VirtualInputManager:SendMouseWheelEvent(0, 0, false, game)
            task.wait(speed)
        end
        task.wait(getgenv().delusion.Macro.Cooldown)  
    end

    SpeedGlitch = false 
    getgenv().delusion.Macro.ActiveCount = 0  
end

Mouse.KeyDown:Connect(function(Key)
    if Key == getgenv().delusion.Macro.Keybind then
        toggleMacro()
    end
end)

Mouse.Button2Down:Connect(function()
    if getgenv().delusion.Macro.SideButton.Enabled and 
       getgenv().delusion.Macro.SideButton.Button == "Button4" then
        toggleMacro()
    end
end)

Mouse.Button2Up:Connect(function()
    SpeedGlitch = false  
end)

Mouse.KeyDown:Connect(function(Key)
    if Key == "t" then 
        if getgenv().delusion.Macro.Type == "Third" then
            getgenv().delusion.Macro.Type = "First"
        else
            getgenv().delusion.Macro.Type = "Third"
        end
    end
end)



local function CheckAnti(Plr) 
    if Plr.Character.HumanoidRootPart.Velocity.Y < -70 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.X > 450 or Plr.Character.HumanoidRootPart.Velocity.X < -35) then
        return true
    elseif Plr and Plr.Character.HumanoidRootPart.Velocity.Y > 60 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.Z > 35 or Plr.Character.HumanoidRootPart.Velocity.Z < -35) then
        return true
    else
        return false
    end
end

local function getnamecall()
    if game.PlaceId == 2788229376 or game.PlaceId == 7213786345 or game.PlaceId == 16033173781 or game.PlaceId == 16158576873 then 
       return "UpdateMousePosI2"
   elseif game.PlaceId == 5602055394 or game.PlaceId == 7951883376 then
       return "MousePos"
   elseif game.PlaceId == 9825515356 then
       return "GetMousePos"
   end
end

function MainEventLocate()
    for _,v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v.Name == "MainEvent" then
            return v
        end
    end
end

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MainEvent = ReplicatedStorage:FindFirstChild("MainEvent")

local Locking = false
local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Plr = nil

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Toggle = false

local function getClosestPlayerToCursor()
    local closestPlayer = nil
    local closestDistance = math.huge 

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Client and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local characterPos = player.Character.HumanoidRootPart.Position
            local screenPos = Camera:WorldToScreenPoint(characterPos)
            local mousePos = UserInputService:GetMouseLocation()

            local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end

    return closestPlayer
end

UserInputService.InputBegan:Connect(function(keygo, ok)
    if not ok then
        if keygo.KeyCode == getgenv().delusion.Aimbot.Keybind then
            Locking = not Locking
            if Locking then
                Plr = getClosestPlayerToCursor()
            else
                Plr = nil
            end
        end
    end
end)

local function CheckAnti(Plr)
    if Plr.Character.HumanoidRootPart.Velocity.Y < -70 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.X > 450 or Plr.Character.HumanoidRootPart.Velocity.X < -35) then
        return true
    elseif Plr and Plr.Character.HumanoidRootPart.Velocity.Y > 60 then
        return true
    elseif Plr and (Plr.Character.HumanoidRootPart.Velocity.Z > 35 or Plr.Character.HumanoidRootPart.Velocity.Z < -35) then
        return true
    else
        return false
    end
end

local function getnamecall()
    if game.PlaceId == 2788229376 or game.PlaceId == 7213786345 or game.PlaceId == 16033173781 or game.PlaceId == 16158576873 then
        return "UpdateMousePosI2" 
    elseif game.PlaceId == 5602055394 or game.PlaceId == 7951883376 then
        return "MousePos"
    elseif game.PlaceId == 9825515356 then 
        return "MousePosUpdate"
    end
end

local namecalltype = getnamecall()

function MainEventLocate()
    for _, v in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
        if v.Name == "MainEvent" then
            return v
        end
    end
end

local Locking = false
local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Plr = nil 
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local Toggle = false

local function OnKeyPress(Input, GameProcessedEvent)
    if Input.KeyCode == getgenv().delusion.Aimbot.Keybind and not GameProcessedEvent then 
        Toggle = not Toggle
    end
end

UserInputService.InputBegan:Connect(OnKeyPress)

UserInputService.InputBegan:Connect(function(keygo, ok)
    if not ok and keygo.KeyCode == getgenv().delusion.Aimbot.Keybind then
        Locking = not Locking
        Plr = Locking and getClosestPlayerToCursor() or nil
    end
end)

function getClosestPlayerToCursor()
    local closestDist = math.huge
    local closestPlr = nil

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= Client and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local screenPos, cameraVisible = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
                if cameraVisible then
                    local mousePos = UserInputService:GetMouseLocation()
                    local distToMouse = (Vector2.new(mousePos.X, mousePos.Y) - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                    if distToMouse < closestDist then
                        closestPlr = player
                        closestDist = distToMouse
                    end
                end
            end
        end
    end

    return closestPlr
end


function getClosestPartToCursor(Player)
    local closestPart, closestDist = nil, math.huge
    
    if Player.Character and Player.Character:FindFirstChild("Humanoid") and 
       Player.Character:FindFirstChild("Head") and 
       Player.Character.Humanoid.Health > 0 and 
       Player.Character:FindFirstChild("HumanoidRootPart") then

        for _, part in pairs(Player.Character:GetChildren()) do
            if part:IsA("BasePart") then
                local screenPos, cameraVisible = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                local mousePos = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
                local distToMouse = (mousePos - Vector2.new(screenPos.X, screenPos.Y)).Magnitude
                
                if distToMouse < closestDist and table.find(getgenv().delusion.Silent.Parts, part.Name) then
                    closestPart = part
                    closestDist = distToMouse
                end
            end
        end
    end
    
    return closestPart
end


game:GetService("RunService").RenderStepped:Connect(function()
    if Plr and Plr.Character then
        if getgenv().delusion.Silent.NearestPart == true and getgenv().delusion.Aimbot.Basic == false then
            getgenv().delusion.Aimbot.Part = tostring(getClosestPartToCursor(Plr))
        elseif getgenv().delusion.Silent.Basic == true and getgenv().delusion.Aimbot.NearestPart == false then
            getgenv().delusion.Aimbot.Part = getgenv().delusion.Aimbot.Part
        end
    end
end)


local function getVelocity(Player)
    local Old = Player.Character.HumanoidRootPart.Position
    wait(0.145)
    local Current = Player.Character.HumanoidRootPart.Position
    return (Current - Old) / 0.145
end

local function GetShakedVector3(Setting)
    return Vector3.new(
        math.random(-Setting * 1e9, Setting * 1e9),
        math.random(-Setting * 1e9, Setting * 1e9),
        math.random(-Setting * 1e9, Setting * 1e9)
    ) / 1e9
end

local v = nil
local mainevent = game:GetService("ReplicatedStorage").MainEvent
local RunService = game:GetService("RunService")

RunService.Heartbeat:Connect(function(deltaTime)
    if Plr and Plr.Character and Plr.Character:FindFirstChild("HumanoidRootPart") then
        v = getVelocity(Plr)
    end
end)

local function handleToolActivation(child)
    if child:IsA("Tool") and child:FindFirstChild("MaxAmmo") then
        child.Activated:Connect(function()
            if Plr and Plr.Character then
                local Position = Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and
                    Plr.Character[getgenv().delusion.Aimbot.Part].Position + Vector3.new(0, getgenv().delusion.Aimbot.Jump, 0) or
                    Plr.Character[getgenv().delusion.Aimbot.Part].Position
                
                local prediction = getgenv().delusion.Silent.Prediction
                if not CheckAnti(Plr) then
                    mainevent:FireServer("UpdateMousePosI2", Position + (Plr.Character.HumanoidRootPart.Velocity * prediction))
                else
                    mainevent:FireServer("UpdateMousePosI2", Position + (Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed * prediction))
                end
            end
        end)
    end
end

Client.Character.ChildAdded:Connect(handleToolActivation)

Client.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(handleToolActivation)
end)

RunService.RenderStepped:Connect(function()
    if Plr and Plr.Character then
        local Position = Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall and
            Plr.Character[getgenv().delusion.Aimbot.Part].Position + Vector3.new(0, getgenv().delusion.Aimbot.Jump, 0) or
            Plr.Character[getgenv().delusion.Aimbot.Part].Position
        
        local prediction = getgenv().delusion.Aimbot.Prediction
        local shakePower = GetShakedVector3(getgenv().delusion.Aimbot.ShakePower)
        
        local cameraPosition = Position + (not CheckAnti(Plr) and (Plr.Character.HumanoidRootPart.Velocity * prediction) or (Plr.Character.Humanoid.MoveDirection * Plr.Character.Humanoid.WalkSpeed * prediction))
        local Main = CFrame.new(workspace.CurrentCamera.CFrame.p, cameraPosition + shakePower)
        
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(Main, getgenv().delusion.Aimbot.CameraSmoothing, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    end

    if getgenv().delusion.Checks.CheckKoStatus and Plr and Plr.Character then
        local KOd = Plr.Character:WaitForChild("BodyEffects")["K.O"].Value
        local Grabbed = Plr.Character:FindFirstChild("GRABBING_CONSTRAINT") ~= nil
        if Plr.Character.Humanoid.Health < 1 or KOd or Grabbed then
            Locking = false
            Plr = nil
        end
    end

    if getgenv().delusion.Checks.DisableOnTargetDeath and Plr and Plr.Character:FindFirstChild("Humanoid") then
        if Plr.Character.Humanoid.Health < 1 then
            Locking = false
            Plr = nil
        end
    end

    if getgenv().delusion.Checks.DisableOnPlayerDeath and Client.Character and Client.Character:FindFirstChild("Humanoid") and Client.Character.Humanoid.Health < 1 then
        Locking = false
        Plr = nil
    end

    if getgenv().delusion.Checks.AntiGroundShots and Plr.Character.Humanoid.Jump and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        pcall(function()
            local TargetVelv5 = Plr.Character.HumanoidRootPart
            TargetVelv5.Velocity = Vector3.new(TargetVelv5.Velocity.X, math.abs(TargetVelv5.Velocity.Y * 0.36), TargetVelv5.Velocity.Z)
            TargetVelv5.AssemblyLinearVelocity = TargetVelv5.Velocity
        end)
    end
end)


--// Chams

if getgenv().delusion.Esp.Chams == true then

local UserInputService = game:GetService("UserInputService")
local ToggleKey = getgenv().delusion.Esp.Key

local FillColor = getgenv().delusion.Esp.Color
local DepthMode = "AlwaysOnTop"
local FillTransparency = 0.5
local OutlineColor = getgenv().delusion.Esp.Outline
local OutlineTransparency = 0

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local connections = {}

local Storage = Instance.new("Folder")
Storage.Parent = CoreGui
Storage.Name = "Highlight_Storage"

local isEnabled = false

local function Highlight(plr)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = plr.Name
    Highlight.FillColor = FillColor
    Highlight.DepthMode = DepthMode
    Highlight.FillTransparency = FillTransparency
    Highlight.OutlineColor = OutlineColor
    Highlight.OutlineTransparency = 0
    Highlight.Parent = Storage
    
    local plrchar = plr.Character
    if plrchar then
        Highlight.Adornee = plrchar
    end

    connections[plr] = plr.CharacterAdded:Connect(function(char)
        Highlight.Adornee = char
    end)
end

local function EnableHighlight()
    isEnabled = true
    for _, player in ipairs(Players:GetPlayers()) do
        Highlight(player)
    end
end

local function DisableHighlight()
    isEnabled = false
    for _, highlight in ipairs(Storage:GetChildren()) do
        highlight:Destroy()
    end
    for _, connection in pairs(connections) do
        connection:Disconnect()
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == ToggleKey then
        if isEnabled then
            DisableHighlight()
        else
            EnableHighlight()
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    if isEnabled then
        Highlight(player)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    local highlight = Storage:FindFirstChild(player.Name)
    if highlight then
        highlight:Destroy()
    end
    local connection = connections[player]
    if connection then
        connection:Disconnect()
    end
end)


if isEnabled then
    EnableHighlight()
end
end


if getgenv().delusion.Spin.Enabled == true then
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Camera = workspace.CurrentCamera
    local Toggle = getgenv().delusion.Spin.Enabled
    local RotationSpeed = getgenv().delusion.Spin.SpinSpeed
    local Keybind = getgenv().delusion.Spin.Keybind
    
    local function OnKeyPress(Input, GameProcessedEvent)
        if Input.KeyCode == Keybind and not GameProcessedEvent then 
            Toggle = not Toggle
        end
    end
    
    UserInputService.InputBegan:Connect(OnKeyPress)
    
    local LastRenderTime = 0
    local TotalRotation = 0
    local function RotateCamera()
        if Toggle then
            local CurrentTime = tick()
            local TimeDelta = math.min(CurrentTime - LastRenderTime, 0.01)
            LastRenderTime = CurrentTime
    
            local RotationAngle = RotationSpeed * TimeDelta
            local Rotation = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), math.rad(RotationAngle))
            Camera.CFrame = Camera.CFrame * Rotation
            TotalRotation = TotalRotation + RotationAngle
            if TotalRotation >= getgenv().delusion.Spin.Degrees then 
                Toggle = false
                TotalRotation = 0
            end
        end
    end
    RunService.RenderStepped:Connect(RotateCamera)
    end

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

local localPlayer = players.LocalPlayer
local camera = workspace.CurrentCamera
local target = nil



--// CFrame \\--
if getgenv().delusion.Cframe.Enabled then
    repeat wait() until game:IsLoaded()
    local Players = game:GetService('Players')
    local LocalPlayer = Players.LocalPlayer
    repeat wait() until LocalPlayer.Character
    local UserInputService = game:GetService('UserInputService')
    local RunService = game:GetService('RunService')
    local isActive = false -- Changed to false to start inactive

    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftBracket then
            getgenv().delusion.Cframe.Multiplier += 0.01
            print(getgenv().delusion.Cframe.Multiplier)
            wait(0.2)
            while UserInputService:IsKeyDown(Enum.KeyCode.LeftBracket) do
                wait()
                getgenv().delusion.Cframe.Multiplier += 0.01
                print(getgenv().delusion.Cframe.Multiplier)
            end
        elseif input.KeyCode == Enum.KeyCode.RightBracket then
            getgenv().delusion.Cframe.Multiplier -= 0.01
            print(getgenv().delusion.Cframe.Multiplier)
            wait(0.2)
            while UserInputService:IsKeyDown(Enum.KeyCode.RightBracket) do
                wait()
                getgenv().delusion.Cframe.Multiplier -= 0.01
                print(getgenv().delusion.Cframe.Multiplier)
            end
        elseif input.KeyCode == Enum.KeyCode[getgenv().delusion.Cframe.Toggle:upper()] then
            isActive = not isActive
            if isActive then
                while isActive do
                    local character = LocalPlayer.Character
                    if character and character:FindFirstChild("HumanoidRootPart") then
                        local humanoidRootPart = character.HumanoidRootPart
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame + character.Humanoid.MoveDirection * getgenv().delusion.Cframe.Multiplier * getgenv().delusion.Cframe.Speed
                    end
                    RunService.Stepped:Wait()
                end
            end
        end
    end)
end



Client.Character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") and child:FindFirstChild("MaxAmmo") then
        child.Activated:Connect(function()
            if Plr and Plr.Character then
                local Position = Plr.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall 
                    and Plr.Character[getgenv().delusion.Aimbot.Part].Position + Vector3.new(0, getgenv().delusion.Aimbot.JumpOffset, 0) 
                    or Plr.Character[getgenv().delusion.Aimbot.Part].Position
                
                mainevent:FireServer(namecalltype, Position + (Plr.Character.HumanoidRootPart.Velocity * getgenv().delusion.Silent.Prediction))
            end
        end)
    end
end)


local lastInjectedScript = nil

function injectScript(scriptFunction)
    if lastInjectedScript then
        lastInjectedScript() 
        lastInjectedScript = nil
    end

    lastInjectedScript = scriptFunction
    scriptFunction() 
end

injectScript(function()
end)

injectScript(function()
end)
