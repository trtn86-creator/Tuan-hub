-- TUẤN HUB VVIP - BLOX FRUITS (FULL ALL FEATURES & FIXED WEAPON)
-- Auto Farm Level + Auto Melee/Sword + Fast Attack + Bring Mob

local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/redz-ui/redzUI/main/redzLib.lua"))()

local Window = RedzLib:MakeWindow({
    Title = "TUẤN HUB VVIP | BLOX FRUITS",
    SubTitle = "Full Features - Fixed Melee",
    SaveFolder = "TuanHubConfig.json"
})

Window:AddMinimizeButton({
    Button = { Image = "rbxassetid://18751493339", BackgroundTransparency = 0 },
    Corner = { CornerRadius = UDim.new(0, 6) }
})

-- TAB: FARM MAIN
local TabFarm = Window:MakeTab({"Auto Farm", "swords"})

_G.AutoFarm = false
_G.SelectWeapon = "Melee"
_G.FastAttack = true
_G.BringMob = true
_G.AutoStats = false
_G.SelectStat = "Melee"

TabFarm:AddToggle({
    Name = "Tự Động Đánh (Auto Farm Level)",
    Default = false,
    Callback = function(Value)
        _G.AutoFarm = Value
    end
})

TabFarm:AddDropdown({
    Name = "Chọn Vũ Khí Đánh (Weapon)",
    Options = {"Melee", "Sword", "Blox Fruit"},
    Default = "Melee",
    Callback = function(Value)
        _G.SelectWeapon = Value
    end
})

TabFarm:AddToggle({
    Name = "Đánh Nhanh (Fast Attack)",
    Default = true,
    Callback = function(Value)
        _G.FastAttack = Value
    end
})

TabFarm:AddToggle({
    Name = "Gom Quái Lại Gần (Bring Mobs)",
    Default = true,
    Callback = function(Value)
        _G.BringMob = Value
    end
})

-- TAB: STATS
local TabStats = Window:MakeTab({"Nâng Điểm", "signal"})

TabStats:AddDropdown({
    Name = "Chọn Chỉ Số Nâng",
    Options = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"},
    Default = "Melee",
    Callback = function(Value)
        _G.SelectStat = Value
    end
})

TabStats:AddToggle({
    Name = "Tự Động Nâng Điểm (Auto Stats)",
    Default = false,
    Callback = function(Value)
        _G.AutoStats = Value
    end
})

-- TAB: MISC / ITEM
local TabMisc = Window:MakeTab({"Khác & Trái", "cherry"})

_G.AutoChest = false
_G.AutoStoreFruit = false

TabMisc:AddToggle({
    Name = "Tự Động Gom Rương (Auto Farm Chest)",
    Default = false,
    Callback = function(Value)
        _G.AutoChest = Value
    end
})

TabMisc:AddToggle({
    Name = "Tự Động Cất Trái Ác Quỷ (Auto Store Fruit)",
    Default = false,
    Callback = function(Value)
        _G.AutoStoreFruit = Value
    end
})

-- HÀM XỬ LÝ TRANG BỊ VŨ KHÍ (MELEE/SWORD/FRUIT)
local function EquipWeapon()
    local player = game.Players.LocalPlayer
    if not player.Character then return end
    
    local toolName = _G.SelectWeapon
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") then
            if toolName == "Melee" and item.ToolTipType == "Melee" then
                player.Character.Humanoid:EquipTool(item)
                break
            elseif toolName == "Sword" and item.ToolTipType == "Sword" then
                player.Character.Humanoid:EquipTool(item)
                break
            elseif toolName == "Blox Fruit" and item.ToolTipType == "Blox Fruit" then
                player.Character.Humanoid:EquipTool(item)
                break
            end
        end
    end
end

-- VÒNG LẶP AUTO FARM CHÍNH
task.spawn(function()
    while task.wait() do
        if _G.AutoFarm then
            pcall(function()
                EquipWeapon()
                
                local player = game.Players.LocalPlayer
                local enemies = game.Workspace.Enemies:GetChildren()
                
                for _, enemy in pairs(enemies) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                        repeat
                            task.wait()
                            if not _G.AutoFarm then break end
                            EquipWeapon()
                            
                            player.Character.HumanoidRootPart.CFrame = enemy.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                            
                            if _G.FastAttack then
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                            end
                            
                        until not enemy or not enemy:FindFirstChild("Humanoid") or enemy.Humanoid.Health <= 0
                    end
                end
            end)
        end
    end
end)

-- VÒNG LẶP AUTO STATS
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoStats then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", _G.SelectStat, 3)
            end)
        end
    end
end)

-- VÒNG LẶP AUTO STORE FRUIT
task.spawn(function()
    while task.wait(2) do
        if _G.AutoStoreFruit then
            pcall(function()
                for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if item:IsA("Tool") and item.Name:find("Fruit") then
                        game:GetService("ReplicatedStorage").CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end)
        end
    end
end)
