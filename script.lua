loadstring(game:HttpGet("https://github.com/mmjjdok-lang/MyScriptHub.git"))()
-- 👤 اللاعب
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera

-- 📌 متغيرات ثابتة (ما تنمسح بالموت)
local char, hrp, humanoid
local savedPosition = nil

-- 🔄 تحديث الشخصية عند الموت/الريسباون
local function onCharacterAdded(c)
	char = c
	hrp = char:WaitForChild("HumanoidRootPart")
	humanoid = char:WaitForChild("Humanoid")
end

onCharacterAdded(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(onCharacterAdded)

-- 🟦 الواجهة (ثابتة)
local gui = Instance.new("ScreenGui")
gui.Name = "StealGUI"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

-- 📦 Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 380, 0, 190)
frame.Position = UDim2.new(0.5, -190, 0.18, 0)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)

-- 🏷️ شريط العنوان
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, 28)
topBar.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 16)

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "Instant Steal"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 13

-- 🔵 زر الستيل
local stealBtn = Instance.new("TextButton", frame)
stealBtn.Size = UDim2.new(0.9, 0, 0, 55)
stealBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
stealBtn.Text = "Steal Brainrot"
stealBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
stealBtn.Font = Enum.Font.GothamBold
stealBtn.TextColor3 = Color3.fromRGB(255,255,255)
stealBtn.TextSize = 13
Instance.new("UICorner", stealBtn).CornerRadius = UDim.new(0, 6)

-- 🔴 زر التقدم
local forwardBtn = Instance.new("TextButton", frame)
forwardBtn.Size = UDim2.new(0.9, 0, 0, 50)
forwardBtn.Position = UDim2.new(0.05, 0, 0.62, 0)
forwardBtn.Text = "TP Forward"
forwardBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
forwardBtn.Font = Enum.Font.GothamBold
forwardBtn.TextColor3 = Color3.fromRGB(255,255,255)
forwardBtn.TextSize = 13
Instance.new("UICorner", forwardBtn).CornerRadius = UDim.new(0, 6)

-- 🔁 حفظ + انتقال (مع إصلاح الموت)
stealBtn.MouseButton1Click:Connect(function()
	if not hrp then return end

	if not savedPosition then
		savedPosition = hrp.CFrame
	else
		local originalPos = hrp.CFrame
		local camCF = camera.CFrame

		stealBtn.Text = "Processing..."

		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0

		camera.CameraType = Enum.CameraType.Scriptable
		camera.CFrame = camCF

		hrp.CFrame = savedPosition
		task.wait(0.15) -- ⬅️ سرعة الانتقال 0.15
		hrp.CFrame = originalPos

		camera.CameraType = Enum.CameraType.Custom

		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50

		stealBtn.Text = "Steal Brainrot"
	end
end)

-- 🚀 التقدم (0.15 ثانية)
forwardBtn.MouseButton1Click:Connect(function()
	if not hrp then return end

	local look = hrp.CFrame.LookVector
	local newPos = hrp.Position + (look * 10)

	local tilt = CFrame.Angles(0, math.rad(-60), 0)

	hrp.CFrame = CFrame.new(newPos, newPos + look) * tilt

	task.wait(0.15)
end)
