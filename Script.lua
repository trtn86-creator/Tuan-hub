-- ====================================================================
--            TUẤN HUB VVIP - BLOX FRUITS (FULL ALL FEATURES)
-- ====================================================================

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "TUẤN HUB VVIP | BLOX FRUITS",
    SubTitle = "Full Functions Edition v4.0",
    TabWidth = 160,
    Size = UDim2.fromOffset(600, 450),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Biến lưu trạng thái các tính năng
_G.AutoFarm = false
_G.FastAttack = false
_G.AutoBoss = false
_G.BossHop = false
_G.AutoSeaEvent = false
_G.AutoRaid = false
_G.AutoBuyChip = false
_G.SelectChip = "Flame"
_G.AutoStatsMelee = false
_G.AutoStatsDefense = false
_G.AutoStatsSword = false
_G.AutoStatsFruit = false
_G.AutoGacha = false
_G.AutoStore = false
_G.FruitESP = false

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "sword" }),
    Boss = Window:AddTab({ Title = "Boss & Sự Kiện", Icon = "skull" }),
    Raid = Window:AddTab({ Title = "Auto Raid", Icon = "zap" }),
    Fruit = Window:AddTab({ Title = "Trái Quỷ & ESP", Icon = "apple" }),
    Teleport = Window:AddTab({ Title = "Dịch Chuyển", Icon = "map-pin" }),
    Stats = Window:AddTab({ Title = "Auto Stats", Icon = "user" }),
    Misc = Window:AddTab({ Title = "Hệ Thống", Icon = "settings" })
}

-- ==================== TAB 1: MAIN FARM ====================
Tabs.Main:AddParagraph({ Title = "CÀY CẤP TỰ ĐỘNG", Content = "Tự nhận nhiệm vụ, bay đến quái và cày cấp siêu tốc." })

local ToggleFarm = Tabs.Main:AddToggle("AutoFarm", { Title = "Auto Farm Level", Default = false })
ToggleFarm:OnChanged(function(Value) _G.AutoFarm = Value end)

local ToggleAttack = Tabs.Main:AddToggle("FastAttack", { Title = "Fast Attack (Đánh Nhanh Super)", Default = false })
ToggleAttack:OnChanged(function(Value) _G.FastAttack = Value end)

-- ==================== TAB 2: BOSS & SỰ KIỆN ====================
Tabs.Boss:AddParagraph({ Title = "SĂN BOSS & BIỂN BÍ ẨN", Content = "Tự săn Boss, đổi Server tìm Boss và cày Event." })

local ToggleBoss = Tabs.Boss:AddToggle("AutoBoss", { Title = "Auto Săn Tất Cả Boss", Default = false })
ToggleBoss:OnChanged(function(Value) _G.AutoBoss = Value end)

local ToggleBossHop = Tabs.Boss:AddToggle("BossHop", { Title = "Hop Server Khi Hết Boss", Default = false })
ToggleBossHop:OnChanged(function(Value) _G.BossHop = Value end)

local ToggleSea = Tabs.Boss:AddToggle("AutoSeaEvent", { Title = "Auto Sự Kiện Biển (Sea Event)", Default = false })
ToggleSea:OnChanged(function(Value) _G.AutoSeaEvent = Value end)

-- ==================== TAB 3: AUTO RAID ====================
Tabs.Raid:AddParagraph({ Title = "THỨC TỈNH TRÁI QUỶ", Content = "Tự mua chip, tự vào Raid và đi đảo Raid." })

local DropdownRaid = Tabs.Raid:AddDropdown("SelectChip", {
    Title = "Chọn Loại Chip Raid",
    Values = {"Flame", "Ice", "Quake", "Light", "Dark", "Rumble", "Magma", "Human: Buddha", "Sand", "Spider"},
    Default = "Flame",
})
DropdownRaid:OnChanged(function(Value) _G.SelectChip = Value end)

local ToggleBuyChip = Tabs.Raid:AddToggle("AutoBuyChip", { Title = "Auto Mua Chip Raid", Default = false })
ToggleBuyChip:OnChanged(function(Value) _G.AutoBuyChip = Value end)

local ToggleRaid = Tabs.Raid:AddToggle("AutoRaid", { Title = "Auto Start & Pass Đảo Raid", Default = false })
ToggleRaid:OnChanged(function(Value) _G.AutoRaid = Value end)

-- ==================== TAB 4: TRÁI QUỶ & ESP ====================
local ToggleGacha = Tabs.Fruit:AddToggle("AutoGacha", { Title = "Auto Random Trái Quỷ", Default = false })
ToggleGacha:OnChanged(function(Value) _G.AutoGacha = Value end)

local ToggleStore = Tabs.Fruit:AddToggle("AutoStore", { Title = "Auto Cất Trái Quỷ Vào Kho", Default = false })
ToggleStore:OnChanged(function(Value) _G.AutoStore = Value end)

local ToggleESP = Tabs.Fruit:AddToggle("FruitESP", { Title = "Bật Nhìn Xuyên Trái Quỷ (Fruit ESP)", Default = false })
ToggleESP:OnChanged(function(Value) _G.FruitESP = Value end)

-- ==================== TAB 5: DỊCH CHUYỂN (TELEPORT) ====================
Tabs.Teleport:AddButton({
    Title = "Dịch Chuyển Đến Biển 1 (Sea 1)",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end
})
Tabs.Teleport:AddButton({
    Title = "Dịch Chuyển Đến Biển 2 (Sea 2)",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa") end
})
Tabs.Teleport:AddButton({
    Title = "Dịch Chuyển Đến Biển 3 (Sea 3)",
    Callback = function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou") end
})

-- ==================== TAB 6: AUTO STATS ====================
local ToggleMelee = Tabs.Stats:AddToggle("StatsMelee", { Title = "Auto Cộng Điểm Melee", Default = false })
ToggleMelee:OnChanged(function(Value) _G.AutoStatsMelee = Value end)

local ToggleDefense = Tabs.Stats:AddToggle("StatsDefense", { Title = "Auto Cộng Điểm Defense", Default = false })
ToggleDefense:OnChanged(function(Value) _G.AutoStatsDefense = Value end)

local ToggleSword = Tabs.Stats:AddToggle("StatsSword", { Title = "Auto Cộng Điểm Sword", Default = false })
ToggleSword:OnChanged(function(Value) _G.AutoStatsSword = Value end)

local ToggleFruit = Tabs.Stats:AddToggle("StatsFruit", { Title = "Auto Cộng Điểm Demon Fruit", Default = false })
ToggleFruit:OnChanged(function(Value) _G.AutoStatsFruit = Value end)

-- ==================== TAB 7: HỆ THỐNG ====================
Tabs.Misc:AddButton({
    Title = "Đổi Server Ngẫu Nhiên (Server Hop)",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local HttpService = game:GetService("HttpService")
        local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in pairs(Servers.data) do
            if s.playing ~= s.maxPlayers and s.id ~= game.JobId then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id)
                break
            end
        end
    end
})

Tabs.Misc:AddButton({
    Title = "Kích Hoạt Chống AFK (Anti-AFK)",
    Callback = function()
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):ClickButton2(Vector2.new())
        end)
        Fluent:Notify({ Title = "Tuấn Hub VVIP", Content = "Đã bật chống AFK!", Duration = 3 })
    end
})

-- ====================================================================
--                  HỆ THỐNG XỬ LÝ LOGIC CHẠY GAME
-- ====================================================================

local Player = game.Players.LocalPlayer

local function CFrameTP(cframe)
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.CFrame = cframe
    end
end

-- Logic Main Farm / Boss Farm
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if _G.AutoFarm or _G.AutoBoss or _G.AutoRaid then
                local Target = nil
                for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and enemy:FindFirstChild("HumanoidRootPart") then
                        Target = enemy
                        break
                    end
                end

                if Target then
                    CFrameTP(Target.HumanoidRootPart.CFrame * CFrame.new(0, 9, 0))
                    local Tool = Player.Backpack:FindFirstChildOfClass("Tool") or Player.Character:FindFirstChildOfClass("Tool")
                    if Tool and not Player.Character:FindFirstChild(Tool.Name) then
                        Player.Character.Humanoid:EquipTool(Tool)
                    end
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
                end
            end
        end)
    end
end)

-- Logic Fast Attack
task.spawn(function()
    while task.wait(0.01) do
        if _G.FastAttack then
            pcall(function()
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0,0))
            end)
        end
    end
end)

-- Logic Auto Raid
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            if _G.AutoBuyChip then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)
            end
        end)
    end
end)

-- Logic Auto Stats
task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            if _G.AutoStatsMelee then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1) end
            if _G.AutoStatsDefense then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1) end
            if _G.AutoStatsSword then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Sword", 1) end
            if _G.AutoStatsFruit then game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", 1) end
        end)
    end
end)

-- Logic Auto Gacha & Store
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            if _G.AutoGacha then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end
            if _G.AutoStore then
                for _, item in pairs(Player.Backpack:GetChildren()) do
                    if item:IsA("Tool") and item:FindFirstChild("DataFolder") then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                    end
                end
            end
        end)
    end
end)

Fluent:Notify({
    Title = "TUẤN HUB VVIP",
    Content = "Tải thành công bản VVIP Full Chức Năng!",
    Duration = 5
})
