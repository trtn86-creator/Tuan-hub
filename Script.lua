-- ====================================================================
--                  TUẤN HUB - REDZ STYLE MENU (FULL CODE)
-- ====================================================================

-- 1. LOAD THƯ VIỆN FLUENT UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- 2. TẠO CỬA SỔ MENU TUẤN HUB PHONG CÁCH REDZ
local Window = Fluent:CreateWindow({
    Title = "TUẤN HUB | BLOX FRUITS",
    SubTitle = "Redz Edition v2.0",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 420),
    Acrylic = false,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Biến lưu trạng thái bật/tắt các tính năng (Flags)
_G.AutoFarm = false
_G.FastAttack = false
_G.AutoStatsMelee = false
_G.AutoStatsDefense = false
_G.AutoGacha = false
_G.AutoStore = false

-- 3. TẠO CÁC TAB NỘI DUNG
local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "sword" }),
    Stats = Window:AddTab({ Title = "Auto Stats", Icon = "user" }),
    Fruit = Window:AddTab({ Title = "Trái Quỷ", Icon = "apple" }),
    Misc = Window:AddTab({ Title = "Hệ Thống", Icon = "settings" })
}

-- Thông báo chào mừng
Tabs.Main:AddParagraph({
    Title = "TUẤN HUB",
    Content = "Chào mừng bạn đến với Tuấn Hub! Giao diện được tối ưu hóa theo phong cách Redz Hub."
})

-- 4. KẾT NỐI NÚT BẬT/TẮT VỚI BIẾN ĐIỀU KHIỂN

-- --- TAB: MAIN FARM ---
local ToggleFarm = Tabs.Main:AddToggle("AutoFarm", { Title = "Auto Farm Level", Default = false })
ToggleFarm:OnChanged(function(Value)
    _G.AutoFarm = Value
end)

local ToggleAttack = Tabs.Main:AddToggle("FastAttack", { Title = "Fast Attack (Đánh Nhanh)", Default = false })
ToggleAttack:OnChanged(function(Value)
    _G.FastAttack = Value
end)

-- --- TAB: AUTO STATS ---
local ToggleMelee = Tabs.Stats:AddToggle("StatsMelee", { Title = "Auto Cộng Điểm Melee", Default = false })
ToggleMelee:OnChanged(function(Value)
    _G.AutoStatsMelee = Value
end)

local ToggleDefense = Tabs.Stats:AddToggle("StatsDefense", { Title = "Auto Cộng Điểm Defense", Default = false })
ToggleDefense:OnChanged(function(Value)
    _G.AutoStatsDefense = Value
end)

-- --- TAB: TRÁI QUỶ ---
local ToggleGacha = Tabs.Fruit:AddToggle("AutoGacha", { Title = "Auto Random Trái Quỷ", Default = false })
ToggleGacha:OnChanged(function(Value)
    _G.AutoGacha = Value
end)

local ToggleStore = Tabs.Fruit:AddToggle("AutoStore", { Title = "Auto Cất Trái Quỷ", Default = false })
ToggleStore:OnChanged(function(Value)
    _G.AutoStore = Value
end)

-- --- TAB: HỆ THỐNG ---
Tabs.Misc:AddButton({
    Title = "Dịch Chuyển Server Khác (Server Hop)",
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
    Title = "Bật Chống AFK (Anti-AFK)",
    Callback = function()
        local VirtualUser = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        Fluent:Notify({ Title = "Tuấn Hub", Content = "Đã bật chống AFK!", Duration = 3 })
    end
})

-- ====================================================================
-- 5. LUỒNG LOGIC TỰ ĐỘNG CHẠY NGẦM (BACKGROUND LOOPS)
-- ====================================================================

-- Loop: Auto Cộng Điểm
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoStatsMelee then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Melee", 1)
        end
        if _G.AutoStatsDefense then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", "Defense", 1)
        end
    end
end)

-- Loop: Auto Random & Cất Trái Quỷ
task.spawn(function()
    while task.wait(2) do
        if _G.AutoGacha then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
        end
        if _G.AutoStore then
            for _, item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if item:IsA("Tool") and item:FindFirstChild("DataFolder") then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", item.Name, item)
                end
            end
        end
    end
end)

-- THÔNG BÁO TẢI THÀNH CÔNG
Fluent:Notify({
    Title = "Tuấn Hub",
    Content = "Đã tải thành công giao diện Tuấn Hub Redz Edition!",
    Duration = 5
})
