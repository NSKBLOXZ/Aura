Players = game:GetService("Players")
UIS = game:GetService("UserInputService")
RunService = game:GetService("RunService")
VirtualUser = game:GetService("VirtualUser")
VirtualInputManager = game:GetService("VirtualInputManager")
HttpService = game:GetService("HttpService")

player = Players.LocalPlayer
playerGui = player:WaitForChild("PlayerGui")

pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "OnyxHub",
		Text = "Iniciando interface...",
		Duration = 3
	})
end)

pcall(function()
	local old = playerGui:FindFirstChild("OnyxHub")
	if old then old:Destroy() end
end)

ActionRemote = nil

function resolveActionRemote()
	local replicatedStorage = game:GetService("ReplicatedStorage")
	local packages = replicatedStorage:FindFirstChild("Packages")
	local index = packages and packages:FindFirstChild("_Index")
	local netPackage = index and index:FindFirstChild("sleitnick_net@0.2.0")
	local net = netPackage and netPackage:FindFirstChild("net")
	local remoteFolder = net and net:FindFirstChild("RE")
	ActionRemote = remoteFolder and remoteFolder:FindFirstChild("ActionRemote")
	return ActionRemote
end

resolveActionRemote()

LevelQuests = {
	{ MinLevel = 0,    MaxLevel = 100,  QuestNPC = "QuestNPCBandit",       QuestMob = "Bandit" },
	{ MinLevel = 101,  MaxLevel = 250,  QuestNPC = "QuestNPCBanditLeader", QuestMob = "Bandit Leader" },
	{ MinLevel = 251,  MaxLevel = 400,  QuestNPC = "QuestNPCMonkey",       QuestMob = "Monkey" },
	{ MinLevel = 401,  MaxLevel = 600,  QuestNPC = "QuestNPCShank",        QuestMob = "Shank" },
	{ MinLevel = 601,  MaxLevel = 800,  QuestNPC = "QuestNPCSnowBandit",   QuestMob = "Snow Bandit" },
	{ MinLevel = 801,  MaxLevel = 1000, QuestNPC = "QuestNPCMihawk",       QuestMob = "Mihawk" },
	{ MinLevel = 1001, MaxLevel = 1199, QuestNPC = "QuestNPCMons",         QuestMob = "National Level Hunter" },
	{ MinLevel = 1200, MaxLevel = 1600, QuestNPC = "QuestNPCSorcerer",     QuestMob = "Sorcerer Student" },
	{ MinLevel = 1601, MaxLevel = 2000, QuestNPC = "QuestNPCJJKBoss",      QuestMob = "Miwa" },
	{ MinLevel = 2001, MaxLevel = 2500, QuestNPC = "QuestNPCHollow",       QuestMob = "Hollow" },
	{ MinLevel = 2501, MaxLevel = 3499, QuestNPC = "QuestNPCArrancar",     QuestMob = "Arrancar" },
	{ MinLevel = 3500, MaxLevel = 4000, QuestNPC = "QuestNPCIchigo",       QuestMob = "Ichigo ( Bankai )" },
}

NPC_FARM_LIST = {
	"Bandit",
	"Bandit Leader",
	"Monkey",
	"Shank",
	"Snow Bandit",
	"Mihawk",
	"National Level Hunter",
	"Sorcerer Student",
	"Miwa",
	"Hollow",
	"Arrancar",
	"Ichigo ( Bankai )"
}

NPC_TO_QUEST = {
	["Bandit"] = "QuestNPCBandit",
	["Bandit Leader"] = "QuestNPCBanditLeader",
	["Monkey"] = "QuestNPCMonkey",
	["Shank"] = "QuestNPCShank",
	["Snow Bandit"] = "QuestNPCSnowBandit",
	["Mihawk"] = "QuestNPCMihawk",
	["National Level Hunter"] = "QuestNPCMons",
	["Sorcerer Student"] = "QuestNPCSorcerer",
	["Miwa"] = "QuestNPCJJKBoss",
	["Hollow"] = "QuestNPCHollow",
	["Arrancar"] = "QuestNPCArrancar",
	["Ichigo ( Bankai )"] = "QuestNPCIchigo",
}

BOSS_NAMES = {
	"Verdant Hero",
	"Sung Jinwoo",
	"Gojo",
	"Sukuna",
	"Saber",
	"Saber Alter",
	"Rimuru",
	"Aizen",
	"Raiden Ei",
	"Stone",
	"Gilgamesh",
	"Sukuna Shinjuku",
	"Ulquiorra",
	"Ulq",
	"VastoLorde",
	"UryuMOB",
	"ChadMOB",
	"VizardIchigo",
	"Vizard ichigo"

}

TOWER_NPCS = {
	"Tower_Katana",
	"Tower_Yoru",
	"Tower_Gryphon",
	"Tower_DualKatana"
}

DUNGEON_NPCS = {
	"ShadowKnight",
	"ShadowKnight_DualKatana",
	"ShadowKnight_Katana",
	"Shadow Monarch",
	"Quincy1",
	"Quincy2",
	"Quincy3",
	"Quincy4",
	"Quincy5",
	"Jugram",
	"Gerard",
	"Lill",
	"Yhwach",
	"Askin",
	"Bambietta",
	"KujoSara",
	"Kujou Sara",
	"Raiden",
	"Raiden Ei",
    "Miyabi",
    "Shadown Knight",
    "Shadown Monarch",
    "Black Soul",
    "White Soul",
    "Yi Sang (Half Power)",
    "Yi Sang"
}

autoQuestLevel = false
autoFarmNPC = false
autoTower = false
towerMode = "All"
selectedTowerNPC = "Tower_Katana"
selectedTowerIndex = 1

autoDungeon = false
autoReset15s = false
autoDungeonPillars = true
autoSimulatedSea = false
autoSimulatedEnter = false
autoBossOnly = false
dungeonMode = "All"
selectedDungeonNPC = "Shadow Monarch"
selectedDungeonIndex = 1
DUNGEON_MAX_DISTANCE = 650
useQuestForNPC = false

selectedNPCFarm = "Bandit" -- cursor da UI
selectedNPCIndex = 1
selectedNPCs = { ["Bandit"] = true } -- multi-seleção real

priorityMode = "BossFirst"
bossPriority = false

-- PRIORIDADE V5:
-- Auto Flores OFF = nenhum scan de flores.
-- Auto Flores ON + noite + pendentes = FLORES.
-- Senão, Boss Priority ON + boss vivo = BOSS.
-- Senão = NPC/QUEST.
flowerPriority = true

-- Boss V3: permite matar todos ou somente o boss selecionado.
bossMode = "All"
selectedBossName = BOSS_NAMES[1]
selectedBossIndex = 1
bossScanCache = {}
bossScanCacheAt = 0
BOSS_SCAN_TTL = 0.30

autoAttack = true
autoEquip = true
weaponSearchText = "Combat"
selectedWeaponName = "Combat"

antiStuck = true
antiAFK = true
noclipEnabled = true
hoverEnabled = true
faceTarget = true

farmMode = "Above"
farmHeight = 8
farmDistance = 8
attackDelay = 0.12
MAX_SIMULATED_DISTANCE = 350

currentTarget = nil
currentTargetName = "None"
currentQuestText = "None"
statusText = "Ready"

runtimeStart = tick()
killCount = 0
trackedKills = {}

bodyPosition = nil
bodyGyro = nil
noclipConnection = nil

lastTarget = nil
lastTargetPos = nil
stuckCheck = 0

CONFIG_FILE = "Onyx_Hub_Config.json"
reset15Last = os.clock()
autoFlowers = false
flowerWorkerRunning = false
flowerCollecting = false
flowerTriedThisNight = {}
flowerNightCount = 0
flowerWasNight = false
FLOWER_EXPECTED_COUNT = 5
FLOWER_MOVE_SPEED = 42 -- studs por segundo; menor = mais lento
FLOWER_ARRIVAL_DISTANCE = 6
FLOWER_BEFORE_COLLECT_DELAY = 0.35
FLOWER_NEXT_DELAY = 1.15
FLOWER_FORCE_NOCLIP = true -- noclip dedicado enquanto estiver indo/coletando flor

function setStatus(text)
	statusText = tostring(text)

	if statusLabel then
		statusLabel.Text = "● " .. statusText
	end
end

function getSe()
	return game:FindFirstChild("Se")
end

function getChar()
	return player.Character or player.CharacterAdded:Wait()
end

function getRoot()
	local char = getChar()
	return char:FindFirstChild("HumanoidRootPart")
		or char:FindFirstChild("Torso")
		or char:FindFirstChild("UpperTorso")
end

function getHumanoid()
	local char = getChar()
	return char:FindFirstChildOfClass("Humanoid")
end

function getRootDeep(model)
	if not model then return nil end

	return model:FindFirstChild("HumanoidRootPart", true)
		or model:FindFirstChild("UpperTorso", true)
		or model:FindFirstChild("Torso", true)
		or model.PrimaryPart
		or model:FindFirstChildWhichIsA("BasePart", true)
end

function getHumanoidDeep(model)
	if not model then return nil end

	return model:FindFirstChildOfClass("Humanoid")
		or model:FindFirstChildWhichIsA("Humanoid", true)
end

function isAlive(model)
	local hum = getHumanoidDeep(model)
	local root = getRootDeep(model)

	return model and model.Parent and hum and root and hum.Health > 0
end

function normalizeName(str)
	str = string.lower(tostring(str))
	str = string.gsub(str, "%s+", " ")
	str = string.gsub(str, "^%s+", "")
	str = string.gsub(str, "%s+$", "")
	return str
end

function nameMatches(realName, wantedName)
	local a = normalizeName(realName)
	local b = normalizeName(wantedName)

	if a == b then return true end

	if string.find(b, "ichigo", 1, true) and string.find(a, "ichigo", 1, true) then
		return true
	end

	return false
end

function formatRuntime(seconds)
	seconds = math.floor(seconds or 0)
	local h = math.floor(seconds / 3600)
	local m = math.floor((seconds % 3600) / 60)
	local s = seconds % 60

	return string.format("%02d:%02d:%02d", h, m, s)
end

function getLevel()
	local screen = playerGui:FindFirstChild("ScreenGui")
	local hud = screen and screen:FindFirstChild("HUD")
	local levelLabel = hud and hud:FindFirstChild("Level")

	if levelLabel and levelLabel:IsA("TextLabel") then
		local num = string.match(levelLabel.Text, "%d+")
		return tonumber(num) or 1
	end

	return 1
end

function getQuestByLevel()
	local level = getLevel()

	for _, quest in ipairs(LevelQuests) do
		if level >= quest.MinLevel and level <= quest.MaxLevel then
			return quest
		end
	end

	return LevelQuests[#LevelQuests]
end

function getQuestFrame()
	local screen = playerGui:FindFirstChild("ScreenGui")
	local questGui = screen and screen:FindFirstChild("Quest")
	local container = questGui and questGui:FindFirstChild("Container")
	local frame = container and container:FindFirstChild("QuestFrame")
	return frame
end

function getQuestText()
	local frame = getQuestFrame()
	local info = frame and frame:FindFirstChild("Info")

	if info and info:IsA("TextLabel") then
		return tostring(info.Text or "")
	end

	return ""
end

function hasQuest()
	local frame = getQuestFrame()
	if not frame then return false end
	if frame.Visible == false then return false end

	local text = getQuestText()
	local clean = string.gsub(text, "%s+", "")

	if clean == "" or clean == "NoQuest" or clean == "None" or clean == "-" then
		return false
	end

	return true
end

function isCorrectQuest(mobName)
	if not hasQuest() then return false end

	local text = string.lower(getQuestText())
	local wanted = string.lower(tostring(mobName))

	text = string.gsub(text, "%s+", " ")
	wanted = string.gsub(wanted, "%s+", " ")

	if string.find(text, wanted, 1, true) then
		return true
	end

	if string.find(wanted, "ichigo", 1, true) and string.find(text, "ichigo", 1, true) then
		return true
	end

	return false
end

function getQuestNPC(name)
	local se = getSe()
	local questFolder = se and se:FindFirstChild("NPC") and se.NPC:FindFirstChild("Quest")

	if not questFolder then
		setStatus("Se.NPC.Quest não encontrado")
		return nil
	end

	local npc = questFolder:FindFirstChild(name)

	if not npc then
		setStatus("NPC Quest não encontrado: " .. tostring(name))
	end

	return npc
end

function getEnemiesFolder()
	local se = getSe()
	local enemies = se and se:FindFirstChild("Enemies")

	if not enemies then
		setStatus("Se.Enemies não encontrado")
	end

	return enemies
end

function getFarmCFrame(targetRoot)
	if not targetRoot then return nil end

	if farmMode == "Behind" then
		return targetRoot.CFrame * CFrame.new(0, farmHeight, farmDistance)
	elseif farmMode == "Front" then
		return targetRoot.CFrame * CFrame.new(0, farmHeight, -farmDistance)
	elseif farmMode == "Below" then
		return targetRoot.CFrame * CFrame.new(0, -farmDistance, 0)
	else
		return targetRoot.CFrame * CFrame.new(0, farmHeight, 0)
	end
end

function clearSmoothHold()
	if bodyPosition then
		bodyPosition:Destroy()
		bodyPosition = nil
	end

	if bodyGyro then
		bodyGyro:Destroy()
		bodyGyro = nil
	end
end

function setupSmoothHold()
	local root = getRoot()
	if not root then return false end

	if not bodyPosition or bodyPosition.Parent ~= root then
		if bodyPosition then bodyPosition:Destroy() end

		bodyPosition = Instance.new("BodyPosition")
		bodyPosition.Name = "Onyx_SmoothPosition"
		bodyPosition.MaxForce = Vector3.new(1e9, 1e9, 1e9)
		bodyPosition.P = 22000
		bodyPosition.D = 1200
		bodyPosition.Position = root.Position
		bodyPosition.Parent = root
	end

	if not bodyGyro or bodyGyro.Parent ~= root then
		if bodyGyro then bodyGyro:Destroy() end

		bodyGyro = Instance.new("BodyGyro")
		bodyGyro.Name = "Onyx_SmoothGyro"
		bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
		bodyGyro.P = 22000
		bodyGyro.D = 900
		bodyGyro.CFrame = root.CFrame
		bodyGyro.Parent = root
	end

	return true
end

function enableNoClip()
	if noclipConnection then return end

	noclipConnection = RunService.Stepped:Connect(function()
		local normalFarmNeedsNoClip = noclipEnabled and (autoQuestLevel or autoFarmNPC or autoTower or autoDungeon or autoBossOnly or autoSimulatedSea)
		local flowerNeedsNoClip = FLOWER_FORCE_NOCLIP and autoFlowers and flowerCollecting
		if normalFarmNeedsNoClip or flowerNeedsNoClip then
			local char = getChar()
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
			end
		end
	end)
end

function disableNoClip()
	if noclipConnection then
		noclipConnection:Disconnect()
		noclipConnection = nil
	end
end

function smoothMoveTo(cframe, lookAtPos)
	if not cframe then return false end

	if hoverEnabled then
		if not setupSmoothHold() then return false end

		bodyPosition.Position = cframe.Position

		if faceTarget and lookAtPos then
			local root = getRoot()
			if root then
				bodyGyro.CFrame = CFrame.lookAt(root.Position, lookAtPos)
			end
		else
			bodyGyro.CFrame = cframe
		end

		if noclipEnabled then
			enableNoClip()
		end

		return true
	else
		clearSmoothHold()

		local hum = getHumanoid()
		if hum then
			hum:MoveTo(cframe.Position)
			return true
		end
	end

	return false
end

function findToolBySearch(container, searchText)
	if not container then return nil end

	searchText = tostring(searchText or "")
	local lowSearch = string.lower(searchText)

	if lowSearch == "" then
		return container:FindFirstChild("Combat") or container:FindFirstChildWhichIsA("Tool")
	end

	for _, tool in ipairs(container:GetChildren()) do
		if tool:IsA("Tool") and string.lower(tool.Name) == lowSearch then
			return tool
		end
	end

	for _, tool in ipairs(container:GetChildren()) do
		if tool:IsA("Tool") and string.find(string.lower(tool.Name), lowSearch, 1, true) then
			return tool
		end
	end

	local words = {}
	for word in string.gmatch(lowSearch, "%S+") do
		table.insert(words, word)
	end

	if #words > 0 then
		for _, tool in ipairs(container:GetChildren()) do
			if tool:IsA("Tool") then
				local toolName = string.lower(tool.Name)
				local ok = true

				for _, word in ipairs(words) do
					if not string.find(toolName, word, 1, true) then
						ok = false
						break
					end
				end

				if ok then return tool end
			end
		end
	end

	return nil
end

function equipSelectedTool()
	if not autoEquip then return end

	local char = getChar()
	local hum = getHumanoid()
	local backpack = player:FindFirstChild("Backpack")

	if not char or not hum then return end

	local equipped = char:FindFirstChildOfClass("Tool")

	if equipped then
		local lowName = string.lower(equipped.Name)
		local lowSearch = string.lower(tostring(weaponSearchText or ""))

		if lowSearch == "" or string.find(lowName, lowSearch, 1, true) then
			selectedWeaponName = equipped.Name
			return
		end
	end

	local wanted = findToolBySearch(backpack, weaponSearchText)

	if wanted then
		selectedWeaponName = wanted.Name
		pcall(function()
			hum:EquipTool(wanted)
		end)
		return
	end

	wanted = findToolBySearch(char, weaponSearchText)

	if wanted then
		selectedWeaponName = wanted.Name
		return
	end

	setStatus("Item não encontrado: " .. tostring(weaponSearchText))
end

function attackOnce()
	if not autoAttack then return end

	equipSelectedTool()

	local char = getChar()
	local root = getRoot()
	if not root then return end

	local tool = char and char:FindFirstChildOfClass("Tool")

	if tool then
		pcall(function()
			tool:Activate()
		end)
	end

	pcall(function()
		local remote = ActionRemote or resolveActionRemote()
		if remote and remote:IsA("RemoteEvent") then
			remote:FireServer("M1", root.CFrame)
		end
	end)
end

task.spawn(function()
	while task.wait(0.6) do
		if autoEquip then
			equipSelectedTool()
		end
	end
end)

player.CharacterAdded:Connect(function()
	task.wait(1)
	if autoEquip then
		equipSelectedTool()
	end
end)

function getClosestModelByName(name, onlyEnemies)
	local root = getRoot()
	if not root then return nil end

	local searchRoot = onlyEnemies and getEnemiesFolder() or (getSe() or game)
	if not searchRoot then return nil end

	local best = nil
	local bestDist = math.huge

	for _, obj in ipairs(searchRoot:GetDescendants()) do
		if obj:IsA("Model") and nameMatches(obj.Name, name) and isAlive(obj) then
			local eroot = getRootDeep(obj)
			if eroot then
				local dist = (root.Position - eroot.Position).Magnitude
				if dist < bestDist then
					bestDist = dist
					best = obj
				end
			end
		end
	end

	return best
end

function getClosestMob(name)
	return getClosestModelByName(name, true)
end

function updateSelectedBossIndex()
	for i, name in ipairs(BOSS_NAMES) do
		if name == selectedBossName then
			selectedBossIndex = i
			return
		end
	end

	selectedBossIndex = 1
	selectedBossName = BOSS_NAMES[1]
end

function cycleSelectedBoss(direction)
	direction = tonumber(direction) or 1
	selectedBossIndex += direction

	if selectedBossIndex > #BOSS_NAMES then
		selectedBossIndex = 1
	elseif selectedBossIndex < 1 then
		selectedBossIndex = #BOSS_NAMES
	end

	selectedBossName = BOSS_NAMES[selectedBossIndex]
	bossScanCacheAt = 0
	setStatus("Boss selecionado: " .. tostring(selectedBossName))
end

function isListedBossName(name)
	local normalized = normalizeName(name)
	for _, bossName in ipairs(BOSS_NAMES) do
		if normalized == normalizeName(bossName) then
			return true
		end
	end
	return false
end

function refreshBossScan(force)
	local now = tick()
	if not force and (now - bossScanCacheAt) < BOSS_SCAN_TTL then
		return bossScanCache
	end

	bossScanCacheAt = now
	bossScanCache = {}

	local seen = {}
	local roots = {}
	local se = getSe()

	if se then table.insert(roots, se) end
	table.insert(roots, workspace)

	for _, searchRoot in ipairs(roots) do
		for _, obj in ipairs(searchRoot:GetDescendants()) do
			if obj:IsA("Model") and not seen[obj] and obj ~= player.Character and not Players:GetPlayerFromCharacter(obj) then
				seen[obj] = true

				if isListedBossName(obj.Name) and isAlive(obj) then
					table.insert(bossScanCache, obj)
				end
			end
		end
	end

	return bossScanCache
end

function getAliveBossNames()
	local names = {}
	local added = {}

	for _, boss in ipairs(refreshBossScan(false)) do
		if boss and boss.Parent and isAlive(boss) and not added[boss.Name] then
			added[boss.Name] = true
			table.insert(names, boss.Name)
		end
	end

	table.sort(names)
	return names
end

function getClosestBoss()
	local root = getRoot()
	if not root then return nil end

	local wanted = bossMode == "Selected" and selectedBossName or nil
	local best = nil
	local bestDist = math.huge

	for _, boss in ipairs(refreshBossScan(false)) do
		if boss and boss.Parent and isAlive(boss) then
			local allowed = not wanted or normalizeName(boss.Name) == normalizeName(wanted)

			if allowed then
				local eroot = getRootDeep(boss)
				if eroot then
					local dist = (root.Position - eroot.Position).Magnitude
					if dist < bestDist then
						bestDist = dist
						best = boss
					end
				end
			end
		end
	end

	return best
end

function trackKill(model)
	if not model or trackedKills[model] then return end

	local hum = getHumanoidDeep(model)
	if not hum then return end

	trackedKills[model] = true

	hum.Died:Connect(function()
		killCount += 1
		trackedKills[model] = nil
	end)
end

function isStuckOnTarget(target)
	if not antiStuck then return false end
	if not target or not isAlive(target) then return false end

	local root = getRootDeep(target)
	if not root then return false end

	local now = tick()

	if lastTarget ~= target then
		lastTarget = target
		lastTargetPos = root.Position
		stuckCheck = now
		return false
	end

	if now - stuckCheck < 2.5 then
		return false
	end

	local moved = (root.Position - lastTargetPos).Magnitude

	lastTargetPos = root.Position
	stuckCheck = now

	return moved < 0.8
end

function getManualQuestForNPC(npcName)
	return {
		MinLevel = 0,
		MaxLevel = 999999,
		QuestNPC = NPC_TO_QUEST[npcName],
		QuestMob = npcName
	}
end

function getSelectedNPCCount()
	local count = 0
	for _, name in ipairs(NPC_FARM_LIST) do
		if selectedNPCs[name] then
			count += 1
		end
	end
	return count
end

function getSelectedNPCArray()
	local list = {}
	for _, name in ipairs(NPC_FARM_LIST) do
		if selectedNPCs[name] then
			table.insert(list, name)
		end
	end
	return list
end

function setSelectedNPCArray(list)
	selectedNPCs = {}

	if type(list) == "table" then
		for _, name in ipairs(list) do
			if NPC_TO_QUEST[tostring(name)] then
				selectedNPCs[tostring(name)] = true
			end
		end
	end

	if getSelectedNPCCount() == 0 then
		selectedNPCs["Bandit"] = true
	end
end

function cycleSelectedNPC(direction)
	direction = tonumber(direction) or 1
	selectedNPCIndex += direction

	if selectedNPCIndex > #NPC_FARM_LIST then
		selectedNPCIndex = 1
	elseif selectedNPCIndex < 1 then
		selectedNPCIndex = #NPC_FARM_LIST
	end

	selectedNPCFarm = NPC_FARM_LIST[selectedNPCIndex]
	setStatus("NPC cursor: " .. selectedNPCFarm)
end

function updateSelectedNPCIndex()
	for i, name in ipairs(NPC_FARM_LIST) do
		if name == selectedNPCFarm then
			selectedNPCIndex = i
			return
		end
	end

	selectedNPCIndex = 1
	selectedNPCFarm = NPC_FARM_LIST[1]
end

function toggleCurrentNPCSelection()
	selectedNPCs[selectedNPCFarm] = not selectedNPCs[selectedNPCFarm]

	if getSelectedNPCCount() == 0 then
		selectedNPCs[selectedNPCFarm] = true
		setStatus("Mantenha pelo menos 1 NPC selecionado")
		return
	end

	setStatus((selectedNPCs[selectedNPCFarm] and "Adicionado: " or "Removido: ") .. selectedNPCFarm)
end

function selectAllNPCs()
	for _, name in ipairs(NPC_FARM_LIST) do
		selectedNPCs[name] = true
	end
end

function selectOnlyCurrentNPC()
	selectedNPCs = { [selectedNPCFarm] = true }
end

function getClosestSelectedMob()
	local root = getRoot()
	local enemies = getEnemiesFolder()
	if not root or not enemies then return nil, nil end

	local best, bestName = nil, nil
	local bestDist = math.huge

	-- Uma única varredura para todos os NPCs selecionados.
	for _, obj in ipairs(enemies:GetDescendants()) do
		if obj:IsA("Model") and selectedNPCs[obj.Name] and isAlive(obj) then
			local eroot = getRootDeep(obj)
			if eroot then
				local dist = (root.Position - eroot.Position).Magnitude
				if dist < bestDist then
					bestDist = dist
					best = obj
					bestName = obj.Name
				end
			end
		end
	end

	return best, bestName
end

function updateNPCMultiUI()
	if npcSelectBtn then
		local mark = selectedNPCs[selectedNPCFarm] and "✓ " or "○ "
		npcSelectBtn.Text = mark .. selectedNPCFarm
	end

	if npcSelectedLabel then
		local list = getSelectedNPCArray()
		npcSelectedLabel.Text = "Selecionados (" .. tostring(#list) .. "): " .. table.concat(list, ", ")
	end

	if npcToggleBtn then
		npcToggleBtn.Text = selectedNPCs[selectedNPCFarm] and "Remover" or "Adicionar"
		npcToggleBtn.BackgroundColor3 = selectedNPCs[selectedNPCFarm] and Theme.Off or Theme.On
	end
end

function flowersHavePriority()
	if not flowerPriority then return false end
	if not autoFlowers then return false end
	if not isNightTime or not isNightTime() then return false end
	return countTriedFlowers and countTriedFlowers() < FLOWER_EXPECTED_COUNT
end

function getFarmPriority()
	if flowersHavePriority() then
		return "Flowers"
	end

	if bossPriority and priorityMode ~= "OnlyNPC" then
		local boss = getClosestBoss()
		if boss and isAlive(boss) then
			return "Boss", boss
		end
	end

	return "NPC"
end

function shouldFarmBossNow()
	if priorityMode == "OnlyNPC" then return false end
	if priorityMode == "OnlyBoss" then return true end
	if not bossPriority then return false end
	if priorityMode == "BossFirst" then return true end
	return false
end

function takeQuest(quest)
	if not quest or not quest.QuestNPC then return false end

	local npc = getQuestNPC(quest.QuestNPC)
	if not npc then return false end

	local root = getRootDeep(npc)
	local prompt = npc:FindFirstChildWhichIsA("ProximityPrompt", true)

	currentTarget = npc
	currentTargetName = quest.QuestNPC
	currentQuestText = quest.QuestNPC .. " -> " .. quest.QuestMob

	if root then
		setStatus("Indo até quest: " .. quest.QuestNPC)

		for _ = 1, 160 do
			if not autoQuestLevel and not autoFarmNPC then return false end

			local myRoot = getRoot()
			if myRoot and (myRoot.Position - root.Position).Magnitude <= 8 then
				break
			end

			smoothMoveTo(root.CFrame * CFrame.new(0, 3, 4), root.Position)
			task.wait(0.03)
		end
	end

	if prompt then
		setStatus("Pegando missão: " .. quest.QuestNPC)

		pcall(function()
			prompt.HoldDuration = 0
			prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 50)
		end)

		for _ = 1, 3 do
			pcall(function()
				fireproximityprompt(prompt)
			end)

			task.wait(0.4)

			if hasQuest() then
				setStatus("Missão pega: " .. getQuestText())
				return true
			end
		end
	else
		setStatus("Prompt não encontrado: " .. quest.QuestNPC)
	end

	return hasQuest()
end

function farmTarget(model)
	if not model or not isAlive(model) then return end

	currentTarget = model
	currentTargetName = model.Name
	trackKill(model)

	setStatus("Farmando: " .. model.Name)

	while (autoQuestLevel or autoFarmNPC or autoTower or autoDungeon or autoBossOnly or autoSimulatedSea) and model and isAlive(model) do
		if (autoQuestLevel or autoFarmNPC or autoBossOnly) and flowersHavePriority() and not flowerCollecting then
			clearSmoothHold()
			currentTarget = nil
			currentTargetName = "None"
			break
		end

		if (autoQuestLevel or autoFarmNPC) and bossPriority and priorityMode ~= "OnlyNPC"
			and isListedBossName and not isListedBossName(model.Name) then
			local bossNow = getClosestBoss()
			if bossNow and isAlive(bossNow) then
				clearSmoothHold()
				currentTarget = nil
				currentTargetName = "None"
				break
			end
		end

		local root = getRootDeep(model)
		local hum = getHumanoidDeep(model)

		if not root or not hum or hum.Health <= 0 or not model.Parent then
			clearSmoothHold()
			currentTarget = nil
			currentTargetName = "None"
			break
		end

		if autoSimulatedSea and isValidSimulatedTarget and not isValidSimulatedTarget(model) then
			setStatus("Alvo inválido ignorado: " .. tostring(model.Name))
			clearSmoothHold()
			currentTarget = nil
			currentTargetName = "None"
			break
		end

		if isStuckOnTarget(model) then
			setStatus("Anti Stuck: trocando alvo")
			clearSmoothHold()
			currentTarget = nil
			currentTargetName = "None"
			break
		end

		local targetCF = getFarmCFrame(root)
		smoothMoveTo(targetCF, root.Position)

		local myRoot = getRoot()
		if myRoot and (myRoot.Position - root.Position).Magnitude <= math.max(18, farmDistance + farmHeight + 8) then
			attackOnce()
		end

		task.wait(attackDelay)
	end
end

function startAutoBossOnly()
	task.spawn(function()
		while autoBossOnly do
			if flowersHavePriority() then
				currentTarget = nil
				currentTargetName = "None"
				clearSmoothHold()
				setStatus("Prioridade: Flores")
				task.wait(0.35)
				continue
			end

			local boss = getClosestBoss()

			if boss and isAlive(boss) then
				setStatus("Auto Boss: " .. boss.Name)
				farmTarget(boss)
			else
				currentTarget = nil
				currentTargetName = "None"
				setStatus("Aguardando boss vivo...")
				task.wait(0.6)
			end

			task.wait(0.2)
		end

		currentTarget = nil
		currentTargetName = "None"
		setStatus("Auto Boss parado")
		clearSmoothHold()
	end)
end

function startAutoQuestLevel()
	task.spawn(function()
		while autoQuestLevel do
			local quest = getQuestByLevel()
			local priority, priorityBossTarget = getFarmPriority()

			if priority == "Flowers" then
				clearSmoothHold()
				currentTarget = nil
				currentTargetName = "None"
				setStatus("Prioridade: Flores")
				task.wait(0.35)
				continue
			elseif priority == "Boss" and priorityBossTarget then
				setStatus("Prioridade Boss: " .. priorityBossTarget.Name)
				farmTarget(priorityBossTarget)
				task.wait(0.2)
				continue
			elseif priorityMode == "OnlyBoss" then
				setStatus("Aguardando Boss vivo")
				task.wait(0.6)
				continue
			end

			if hasQuest() and isCorrectQuest(quest.QuestMob) then
				setStatus("Missão ativa: " .. getQuestText())
			else
				takeQuest(quest)
			end

			local mob = getClosestMob(quest.QuestMob)

			if mob and isAlive(mob) then
				farmTarget(mob)
			else
				setStatus("Aguardando mob: " .. quest.QuestMob)
				task.wait(0.5)
			end

			task.wait(0.15)
		end

		currentTarget = nil
		currentTargetName = "None"
		setStatus("Auto Quest Level parado")
		clearSmoothHold()
	end)
end

function startAutoFarmNPC()
	task.spawn(function()
		while autoFarmNPC do
			local priority, priorityBossTarget = getFarmPriority()

			if priority == "Flowers" then
				clearSmoothHold()
				currentTarget = nil
				currentTargetName = "None"
				setStatus("Prioridade: Flores")
				task.wait(0.35)
				continue
			elseif priority == "Boss" and priorityBossTarget then
				setStatus("Prioridade Boss: " .. priorityBossTarget.Name)
				farmTarget(priorityBossTarget)
				task.wait(0.2)
				continue
			elseif priorityMode == "OnlyBoss" then
				setStatus("Aguardando Boss vivo")
				task.wait(0.6)
				continue
			end

			local mob, mobName = getClosestSelectedMob()

			if mob and mobName and isAlive(mob) then
				if useQuestForNPC then
					local manualQuest = getManualQuestForNPC(mobName)

					if manualQuest.QuestNPC then
						if not (hasQuest() and isCorrectQuest(manualQuest.QuestMob)) then
							takeQuest(manualQuest)
						end
					end
				end

				setStatus("NPC Multi: " .. mobName)
				farmTarget(mob)
			else
				setStatus("Aguardando NPCs selecionados (" .. tostring(getSelectedNPCCount()) .. ")")
				task.wait(0.5)
			end

			task.wait(0.15)
		end

		currentTarget = nil
		currentTargetName = "None"
		setStatus("Farm NPC parado")
		clearSmoothHold()
	end)
end

function getClosestTowerByName(name)
	local root = getRoot()
	if not root then return nil end

	local searchRoot = getSe() or game
	local best = nil
	local bestDist = math.huge

	for _, obj in ipairs(searchRoot:GetDescendants()) do
		if obj:IsA("Model") and obj.Name == name and isAlive(obj) then
			local eroot = getRootDeep(obj)

			if eroot then
				local dist = (root.Position - eroot.Position).Magnitude

				if dist < bestDist then
					bestDist = dist
					best = obj
				end
			end
		end
	end

	return best
end

function getClosestAnyTowerNPC()
	local root = getRoot()
	if not root then return nil end

	local best = nil
	local bestDist = math.huge

	for _, towerName in ipairs(TOWER_NPCS) do
		local mob = getClosestTowerByName(towerName)

		if mob and isAlive(mob) then
			local eroot = getRootDeep(mob)

			if eroot then
				local dist = (root.Position - eroot.Position).Magnitude

				if dist < bestDist then
					bestDist = dist
					best = mob
				end
			end
		end
	end

	return best
end

function cycleTowerNPC()
	selectedTowerIndex += 1

	if selectedTowerIndex > #TOWER_NPCS then
		selectedTowerIndex = 1
	end

	selectedTowerNPC = TOWER_NPCS[selectedTowerIndex]
	setStatus("Tower NPC selecionado: " .. selectedTowerNPC)
end

function startAutoTower()
	task.spawn(function()
		while autoTower do
			local target

			if towerMode == "All" then
				target = getClosestAnyTowerNPC()
			else
				target = getClosestTowerByName(selectedTowerNPC)
			end

			if target and isAlive(target) then
				setStatus("Tower Kill: " .. target.Name)
				farmTarget(target)
			else
				setStatus("Aguardando Tower NPC: " .. tostring(towerMode == "All" and "Todos" or selectedTowerNPC))
				task.wait(0.5)
			end

			task.wait(0.15)
		end

		currentTarget = nil
		currentTargetName = "None"
		setStatus("Auto Tower parado")
		clearSmoothHold()
	end)
end

function cleanDungeonName(s)
	s = string.lower(tostring(s or ""))
	s = string.gsub(s, "%s+", "")
	s = string.gsub(s, "_", "")
	s = string.gsub(s, "%-", "")
	s = string.gsub(s, "%.", "")
	return s
end

function isDungeonEnemyName(name)
	local n = cleanDungeonName(name)

	if string.find(n, "quincy", 1, true) then return true end
	if string.find(n, "shadow", 1, true) then return true end
	if string.find(n, "monarch", 1, true) then return true end
	if string.find(n, "raiden", 1, true) then return true end
	if string.find(n, "kujo", 1, true) then return true end
	if string.find(n, "kujou", 1, true) then return true end
	if string.find(n, "jugram", 1, true) then return true end
	if string.find(n, "gerard", 1, true) then return true end
	if string.find(n, "lill", 1, true) then return true end
	if string.find(n, "yhwach", 1, true) then return true end
	if string.find(n, "askin", 1, true) then return true end
	if string.find(n, "bambietta", 1, true) then return true end

	return false
end

function isDungeonNameMatch(objName, wantedName)
	local a = cleanDungeonName(objName)
	local b = cleanDungeonName(wantedName)

	if a == b then return true end
	if string.find(a, b, 1, true) then return true end
	if string.find(b, a, 1, true) then return true end
	if string.find(a, "quincy", 1, true) and string.find(b, "quincy", 1, true) then return true end

	return false
end

function getDungeonRoots()
	local roots = {}
	local used = {}

	local function add(obj)
		if obj and not used[obj] then
			used[obj] = true
			table.insert(roots, obj)
		end
	end

	local se = getSe()
	add(se and se:FindFirstChild("Enemies"))
	add(workspace:FindFirstChild("Enemies"))

	for _, obj in ipairs(workspace:GetChildren()) do
		if tonumber(obj.Name) then
			add(obj:FindFirstChild("Enemies"))
			add(obj)
		end
	end

	return roots
end

function isValidDungeonTarget(model, allowAnyName)
	if not model or not model.Parent then return false end
	if not model:IsA("Model") then return false end
	if model == player.Character then return false end
	if Players:GetPlayerFromCharacter(model) then return false end

	local hum = getHumanoidDeep(model)
	local root = getRootDeep(model)

	if not hum or not root then return false end
	if hum.Health <= 0 or hum.MaxHealth <= 0 then return false end

	if allowAnyName then
		return true
	end

	return isDungeonEnemyName(model.Name)
end

function getClosestDungeonEnemy(wantedName)
	local root = getRoot()
	if not root then return nil end

	local best = nil
	local bestDist = math.huge

	for _, folder in ipairs(getDungeonRoots()) do
		local allowAny = folder.Name == "Enemies"

		for _, obj in ipairs(folder:GetDescendants()) do
			if obj:IsA("Model") and isValidDungeonTarget(obj, allowAny) then
				if not wantedName or isDungeonNameMatch(obj.Name, wantedName) or allowAny then
					local eroot = getRootDeep(obj)

					if eroot then
						local dist = (root.Position - eroot.Position).Magnitude

						if dist <= DUNGEON_MAX_DISTANCE and dist < bestDist then
							bestDist = dist
							best = obj
						end
					end
				end
			end
		end
	end

	return best
end

function getClosestDungeonByName(name)
	return getClosestDungeonEnemy(name)
end

function getClosestAnyDungeonNPC()
	return getClosestDungeonEnemy(nil)
end

function cycleDungeonNPC()
	selectedDungeonIndex += 1

	if selectedDungeonIndex > #DUNGEON_NPCS then
		selectedDungeonIndex = 1
	end

	selectedDungeonNPC = DUNGEON_NPCS[selectedDungeonIndex]
	setStatus("Dungeon NPC selecionado: " .. selectedDungeonNPC)
end

function isPillarPrompt(prompt)
	if not prompt or not prompt:IsA("ProximityPrompt") then return false end

	local action = string.lower(tostring(prompt.ActionText or ""))
	local object = string.lower(tostring(prompt.ObjectText or ""))
	local full = string.lower(tostring(prompt:GetFullName()))

	if action == "break" then return true end
	if string.find(action, "break", 1, true) then return true end
	if string.find(object, "quincy", 1, true) then return true end
	if string.find(object, "cross", 1, true) then return true end
	if string.find(full, "pillar", 1, true) then return true end
	if string.find(full, "cross", 1, true) then return true end

	return false
end

function getPromptPart(prompt)
	if not prompt then return nil end

	local obj = prompt.Parent

	while obj and obj ~= game do
		if obj:IsA("BasePart") then
			return obj
		end

		if obj:IsA("Attachment") and obj.Parent and obj.Parent:IsA("BasePart") then
			return obj.Parent
		end

		if obj:IsA("Model") then
			local root = getRootDeep(obj)
			if root then return root end

			local part = obj:FindFirstChildWhichIsA("BasePart", true)
			if part then return part end
		end

		obj = obj.Parent
	end

	return nil
end

function getClosestDungeonPillar()
	local root = getRoot()
	if not root then return nil end

	local bestPart = nil
	local bestPrompt = nil
	local bestDist = math.huge

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and isPillarPrompt(obj) then
			local part = getPromptPart(obj)

			if part and part.Parent then
				local dist = (root.Position - part.Position).Magnitude

				if dist <= 700 and dist < bestDist then
					bestDist = dist
					bestPart = part
					bestPrompt = obj
				end
			end
		end
	end

	return bestPart, bestPrompt
end

function pressE()
	pcall(function()
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
		task.wait(0.1)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
	end)
end

function activatePillarPrompt(prompt)
	if not prompt then return false end

	pcall(function()
		prompt.Enabled = true
		prompt.RequiresLineOfSight = false
		prompt.HoldDuration = 0
		prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 100)
	end)

	for _ = 1, 8 do
		if not autoDungeon or not autoDungeonPillars then return false end

		pcall(function()
			fireproximityprompt(prompt)
		end)

		pcall(function()
			prompt:InputHoldBegin()
			task.wait(0.06)
			prompt:InputHoldEnd()
		end)

		pressE()
		task.wait(0.18)
	end

	return true
end

function interactDungeonPillar()
	if not autoDungeonPillars then return false end

	local part, prompt = getClosestDungeonPillar()

	if not part or not prompt then
		setStatus("Pillar não encontrado")
		return false
	end

	setStatus("Ativando: " .. tostring(prompt.ObjectText ~= "" and prompt.ObjectText or "Pillar"))

	for _ = 1, 120 do
		if not autoDungeon or not autoDungeonPillars then return false end

		local root = getRoot()
		if not root or not part or not part.Parent then return false end

		if (root.Position - part.Position).Magnitude <= 6 then
			break
		end

		smoothMoveTo(part.CFrame * CFrame.new(0, 2, 3), part.Position)
		task.wait(0.03)
	end

	local root = getRoot()
	if root and part then
		pcall(function()
			root.CFrame = part.CFrame * CFrame.new(0, 2, 2.5)
		end)
	end

	task.wait(0.15)
	local ok = activatePillarPrompt(prompt)

	clearSmoothHold()
	return ok
end

function farmDungeonTarget(model)
	if not model or not isAlive(model) then return end

	currentTarget = model
	currentTargetName = model.Name
	setStatus("Dungeon: " .. model.Name)

	local started = tick()
	local lastHp = nil
	local lastHit = tick()

	while autoDungeon and model and isAlive(model) do
		local hum = getHumanoidDeep(model)
		local root = getRootDeep(model)

		if not hum or not root or hum.Health <= 0 or not model.Parent then
			break
		end

		if lastHp == nil or hum.Health < lastHp then
			lastHp = hum.Health
			lastHit = tick()
		end

		if tick() - started > 18 or tick() - lastHit > 8 then
			setStatus("Dungeon: reescaneando alvo")
			break
		end

		smoothMoveTo(getFarmCFrame(root), root.Position)

		local myRoot = getRoot()
		if myRoot and (myRoot.Position - root.Position).Magnitude <= math.max(24, farmDistance + farmHeight + 12) then
			attackOnce()
			task.wait(0.03)
			attackOnce()
		end

		task.wait(math.max(0.06, attackDelay))
	end

	currentTarget = nil
	currentTargetName = "None"
	clearSmoothHold()
end

function startAutoDungeon()
	task.spawn(function()
		local noTargetCount = 0

		while autoDungeon do
			autoAttack = true
			autoEquip = true

			local target

			if dungeonMode == "All" then
				target = getClosestDungeonEnemy(nil)
			else
				target = getClosestDungeonEnemy(selectedDungeonNPC) or getClosestDungeonEnemy(nil)
			end

			if target and isAlive(target) then
				noTargetCount = 0
				farmDungeonTarget(target)
			else
				currentTarget = nil
				currentTargetName = "None"
				clearSmoothHold()

				local fresh = getClosestDungeonEnemy(nil)

				if fresh and isAlive(fresh) then
					noTargetCount = 0
					farmDungeonTarget(fresh)
				elseif autoDungeonPillars then
					local ok = interactDungeonPillar()

					if ok then
						noTargetCount = 0
						setStatus("Pillar ativado")
						task.wait(0.8)
					else
						noTargetCount += 1

						if noTargetCount >= 4 then
							setStatus("Reescaneando dungeon")
							noTargetCount = 0
						end

						task.wait(0.45)
					end
				else
					setStatus("Aguardando dungeon")
					task.wait(0.45)
				end
			end

			task.wait(0.15)
		end

		currentTarget = nil
		currentTargetName = "None"
		clearSmoothHold()
		setStatus("Auto Dungeon parado")
	end)
end

function getAvailableDoor()
	local doorFolder = workspace:FindFirstChild("Door")
	if not doorFolder then return nil end

	for _, door in ipairs(doorFolder:GetChildren()) do
		if door:IsA("Model") or door:IsA("Folder") then
			local prompt = door:FindFirstChildWhichIsA("ProximityPrompt", true)
			local root = getRootDeep(door)

			if prompt then
				return door, prompt, root
			end
		end
	end

	return nil
end

function startAutoSimulatedEnter()
	task.spawn(function()
		while autoSimulatedEnter do
			local door, prompt, root = getAvailableDoor()

			if door and prompt then
				setStatus("Entrando porta: " .. door.Name)

				if root then
					for _ = 1, 80 do
						if not autoSimulatedEnter then break end

						local myRoot = getRoot()
						if myRoot and (myRoot.Position - root.Position).Magnitude <= 8 then
							break
						end

						smoothMoveTo(root.CFrame * CFrame.new(0, 3, 4), root.Position)
						task.wait(0.03)
					end
				end

				pcall(function()
					prompt.HoldDuration = 0
					prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 50)
				end)

				for _ = 1, 3 do
					if not autoSimulatedEnter then break end

					pcall(function()
						fireproximityprompt(prompt)
					end)

					task.wait(0.35)
				end

				task.wait(1)
			else
				setStatus("Aguardando porta...")
				task.wait(0.6)
			end

			task.wait(0.2)
		end

		setStatus("Auto Enter parado")
	end)
end

function isInsideBadFolder(model)
	local badNames = {
		Door = true,
		NPC = true,
		Map = true,
		Quest = true,
		Questline = true,
		Seller = true,
		Teleporter = true,
		Artifact = true,
		Exchange = true,
		Tower = true,
		Merchant = true,
		Blacksmith = true,
		SafeAndInCombat = true
	}

	local obj = model
	while obj and obj ~= game do
		if badNames[obj.Name] then
			return true
		end

		obj = obj.Parent
	end

	return false
end

function isValidSimulatedTarget(model)
	if not model or not model.Parent then return false end
	if not model:IsA("Model") then return false end
	if model == player.Character then return false end
	if Players:GetPlayerFromCharacter(model) then return false end
	if isInsideBadFolder(model) then return false end

	local hum = getHumanoidDeep(model)
	local root = getRootDeep(model)

	if not hum or not root then return false end
	if hum.Health <= 0 then return false end
	if hum.MaxHealth <= 0 then return false end
	if not root:IsA("BasePart") then return false end

	local name = tostring(model.Name)
	local low = string.lower(name)

	if string.find(low, "door", 1, true)
	or string.find(low, "portal", 1, true)
	or string.find(low, "prompt", 1, true)
	or string.find(low, "quest", 1, true)
	or string.find(low, "seller", 1, true)
	or string.find(low, "teleport", 1, true)
	or string.find(low, "dummy", 1, true) then
		return false
	end

	return true
end

function getClosestSimulatedNPC()
	local root = getRoot()
	if not root then return nil end

	local best = nil
	local bestDist = math.huge
	local searchRoot = getEnemiesFolder() or workspace

	for _, obj in ipairs(searchRoot:GetDescendants()) do
		if isValidSimulatedTarget(obj) then
			local eroot = getRootDeep(obj)

			if eroot then
				local dist = (root.Position - eroot.Position).Magnitude

				if dist <= MAX_SIMULATED_DISTANCE and dist < bestDist then
					bestDist = dist
					best = obj
				end
			end
		end
	end

	return best
end

function startAutoSimulatedSea()
	task.spawn(function()
		while autoSimulatedSea do

			local target = getClosestSimulatedNPC()

			if target and isAlive(target) then
				setStatus("NPC próximo: " .. target.Name)
				farmTarget(target)
			else
				currentTarget = nil
				currentTargetName = "None"
				clearSmoothHold()
				setStatus("Aguardando NPC próximo...")
				task.wait(0.6)
			end

			task.wait(0.2)
		end

		currentTarget = nil
		currentTargetName = "None"
		clearSmoothHold()
		setStatus("Simulated Sea parado")
	end)
end



function isNightTime()
	local lighting = game:GetService("Lighting")
	local clock = tonumber(lighting.ClockTime) or 12
	return clock >= 18 or clock < 6
end

function getFlowerPromptKey(prompt)
	if not prompt then return "nil" end

	local part = getPromptPart(prompt)
	local pos = part and part.Position
	local positionKey = pos and string.format("%.1f,%.1f,%.1f", pos.X, pos.Y, pos.Z) or "no-position"

	return tostring(prompt:GetFullName()) .. "@" .. positionKey
end

function isBlueSpiderLilyPrompt(prompt)
	if not prompt or not prompt:IsA("ProximityPrompt") then return false end

	local action = string.lower(tostring(prompt.ActionText or ""))
	local object = string.lower(tostring(prompt.ObjectText or ""))
	local full = string.lower(tostring(prompt:GetFullName() or ""))
	local combined = action .. " " .. object .. " " .. full

	if string.find(combined, "blue spider lily", 1, true) then return true end
	if string.find(combined, "spider lily", 1, true) then return true end

	return false
end

function findBlueSpiderLilyPrompts()
	local found = {}

	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj:IsA("ProximityPrompt") and isBlueSpiderLilyPrompt(obj) then
			table.insert(found, obj)
		end
	end

	return found
end

function countTriedFlowers()
	local total = 0
	for _ in pairs(flowerTriedThisNight) do
		total += 1
	end
	return total
end


function moveToFlowerSlow(part)
	if not part or not part.Parent then return false end

	clearSmoothHold() -- evita disputa com BodyPosition/BodyGyro do farm

	local started = os.clock()
	local timeout = 30

	while autoFlowers and isNightTime() and part and part.Parent do
		local root = getRoot()
		if not root then
			task.wait(0.1)
			continue
		end

		local targetPosition = (part.CFrame * CFrame.new(0, 2.5, 3)).Position
		local offset = targetPosition - root.Position
		local distance = offset.Magnitude

		if distance <= FLOWER_ARRIVAL_DISTANCE then
			return true
		end

		if os.clock() - started >= timeout then
			return false
		end

		local dt = RunService.Heartbeat:Wait()
		local step = math.min(distance, math.max(8, FLOWER_MOVE_SPEED) * dt)
		local nextPosition = root.Position + offset.Unit * step

		pcall(function()
			root.CFrame = CFrame.lookAt(nextPosition, part.Position)
		end)
	end

	return false
end

function tryCollectFlower(prompt)
	if not prompt or not prompt.Parent then return false end

	local key = getFlowerPromptKey(prompt)
	if flowerTriedThisNight[key] then return false end

	-- Marca como OK antes da interação, pois a flor continua visível depois de coletada.
	flowerTriedThisNight[key] = true
	flowerNightCount = countTriedFlowers()

	local part = getPromptPart(prompt)
	if not part then
		setStatus("Flor marcada OK sem posição: " .. tostring(flowerNightCount) .. "/" .. tostring(FLOWER_EXPECTED_COUNT))
		return false
	end

	flowerCollecting = true
	currentTargetName = "Blue Spider Lily"
	if FLOWER_FORCE_NOCLIP then
		enableNoClip()
	end
	setStatus("Flor " .. tostring(flowerNightCount) .. "/" .. tostring(FLOWER_EXPECTED_COUNT) .. ": indo coletar")

	pcall(function()
		prompt.Enabled = true
		prompt.RequiresLineOfSight = false
		prompt.HoldDuration = 0
		prompt.MaxActivationDistance = math.max(prompt.MaxActivationDistance, 50)
	end)

	local arrived = moveToFlowerSlow(part)
	if arrived then
		task.wait(FLOWER_BEFORE_COLLECT_DELAY)
	else
		setStatus("Flor " .. tostring(flowerNightCount) .. ": tentativa após timeout")
	end

	for _ = 1, 3 do
		if not autoFlowers or not isNightTime() then break end
		pcall(function() fireproximityprompt(prompt) end)
		pcall(function()
			prompt:InputHoldBegin()
			task.wait(0.05)
			prompt:InputHoldEnd()
		end)
		task.wait(0.25)
	end

	flowerCollecting = false
	currentTargetName = "None"
	clearSmoothHold()
	setStatus("Flor " .. tostring(flowerNightCount) .. "/" .. tostring(FLOWER_EXPECTED_COUNT) .. " marcada OK")
	task.wait(FLOWER_NEXT_DELAY)
	return true
end

function startAutoFlowers()
	if flowerWorkerRunning then return end
	flowerWorkerRunning = true

	task.spawn(function()
		flowerWasNight = isNightTime()

		if flowerWasNight then
			flowerTriedThisNight = {}
			flowerNightCount = 0
		end

		while autoFlowers do
			local night = isNightTime()

			if night and not flowerWasNight then
				flowerTriedThisNight = {}
				flowerNightCount = 0
				setStatus("Nova noite: procurando flores")
			end

			flowerWasNight = night

			-- ÚNICO lugar que escaneia flores no mapa.
			-- Se Auto Flores = OFF, este loop nem existe.
			if night and flowerNightCount < FLOWER_EXPECTED_COUNT then
				local prompts = findBlueSpiderLilyPrompts()

				for _, prompt in ipairs(prompts) do
					if not autoFlowers or not isNightTime() then break end
					if flowerNightCount >= FLOWER_EXPECTED_COUNT then break end

					local key = getFlowerPromptKey(prompt)
					if not flowerTriedThisNight[key] then
						tryCollectFlower(prompt)
						flowerNightCount = countTriedFlowers()
					end
				end

				if flowerNightCount >= FLOWER_EXPECTED_COUNT then
					setStatus("Flores 5/5 OK • próxima tentativa só na próxima noite")
				elseif #prompts == 0 then
					setStatus("Auto Flores ON • nenhuma flor detectada")
				end
			end

			task.wait(night and 2.5 or 6)
		end

		flowerCollecting = false
		flowerWorkerRunning = false
		currentTargetName = "None"
		clearSmoothHold()
	end)
end

function encodeConfig()
	return {
		farmMode = farmMode,
		farmHeight = farmHeight,
		farmDistance = farmDistance,
		attackDelay = attackDelay,
		autoAttack = autoAttack,
		autoEquip = autoEquip,
		weaponSearchText = weaponSearchText,
		selectedWeaponName = selectedWeaponName,
		antiStuck = antiStuck,
		antiAFK = antiAFK,
		noclipEnabled = noclipEnabled,
		hoverEnabled = hoverEnabled,
		faceTarget = faceTarget,
		bossPriority = bossPriority,
		flowerPriority = flowerPriority,
		autoBossOnly = autoBossOnly,
		bossMode = bossMode,
		selectedBossName = selectedBossName,
		priorityMode = priorityMode,
		selectedNPCFarm = selectedNPCFarm,
		selectedNPCs = getSelectedNPCArray(),
		useQuestForNPC = useQuestForNPC,
		autoTower = autoTower,
		towerMode = towerMode,
		selectedTowerNPC = selectedTowerNPC,
		autoDungeon = autoDungeon,
		autoDungeonPillars = autoDungeonPillars,
		autoSimulatedSea = autoSimulatedSea,
		autoReset15s = autoReset15s,
		autoSimulatedEnter = autoSimulatedEnter,
		-- Auto Flores não é salvo: sempre inicia OFF.
		flowerMoveSpeed = FLOWER_MOVE_SPEED,
		dungeonMode = dungeonMode,
		selectedDungeonNPC = selectedDungeonNPC,
	}
end

function saveConfig()
	if not writefile then
		setStatus("writefile não suportado")
		return
	end

	local ok, encoded = pcall(function()
		return HttpService:JSONEncode(encodeConfig())
	end)

	if ok then
		writefile(CONFIG_FILE, encoded)
		setStatus("Config salva")
	else
		setStatus("Erro ao salvar config")
	end
end

function loadConfig()
	if not (isfile and readfile and isfile(CONFIG_FILE)) then
		setStatus("Config não encontrada")
		return
	end

	local ok, data = pcall(function()
		return HttpService:JSONDecode(readfile(CONFIG_FILE))
	end)

	if not ok or type(data) ~= "table" then
		setStatus("Erro ao carregar config")
		return
	end

	farmMode = tostring(data.farmMode or farmMode)
	farmHeight = tonumber(data.farmHeight) or farmHeight
	farmDistance = tonumber(data.farmDistance) or farmDistance
	attackDelay = tonumber(data.attackDelay) or attackDelay

	autoAttack = data.autoAttack ~= false
	autoEquip = data.autoEquip ~= false
	weaponSearchText = tostring(data.weaponSearchText or weaponSearchText)
	selectedWeaponName = tostring(data.selectedWeaponName or selectedWeaponName)

	antiStuck = data.antiStuck ~= false
	antiAFK = data.antiAFK ~= false
	noclipEnabled = data.noclipEnabled ~= false
	hoverEnabled = data.hoverEnabled ~= false
	faceTarget = data.faceTarget ~= false
	bossPriority = data.bossPriority == true
	flowerPriority = data.flowerPriority ~= false
	autoBossOnly = data.autoBossOnly == true
	bossMode = (data.bossMode == "Selected") and "Selected" or "All"
	selectedBossName = tostring(data.selectedBossName or selectedBossName)
	updateSelectedBossIndex()

	priorityMode = tostring(data.priorityMode or priorityMode)
	selectedNPCFarm = tostring(data.selectedNPCFarm or selectedNPCFarm)
	setSelectedNPCArray(data.selectedNPCs)
	useQuestForNPC = data.useQuestForNPC == true
	autoTower = data.autoTower == true
	towerMode = tostring(data.towerMode or towerMode)
	selectedTowerNPC = tostring(data.selectedTowerNPC or selectedTowerNPC)
	autoDungeon = data.autoDungeon == true
	autoDungeonPillars = data.autoDungeonPillars ~= false
	autoSimulatedSea = data.autoSimulatedSea == true
	autoReset15s = data.autoReset15s == true
	autoSimulatedEnter = data.autoSimulatedEnter == true
	autoFlowers = false
	flowerWorkerRunning = false
	FLOWER_MOVE_SPEED = math.clamp(tonumber(data.flowerMoveSpeed) or FLOWER_MOVE_SPEED, 15, 120)
	dungeonMode = tostring(data.dungeonMode or dungeonMode)
	selectedDungeonNPC = tostring(data.selectedDungeonNPC or selectedDungeonNPC)

	updateSelectedNPCIndex()
	setStatus("Config carregada")
end

pcall(function()
	player.Idled:Connect(function()
		if antiAFK then
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
			setStatus("Anti AFK ativo")
		end
	end)
end)

gui = Instance.new("ScreenGui")
gui.Name = "OnyxHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

Theme = {
	Background = Color3.fromRGB(8, 11, 16),
	Surface = Color3.fromRGB(14, 19, 27),
	Surface2 = Color3.fromRGB(20, 27, 37),
	Surface3 = Color3.fromRGB(25, 34, 45),
	Accent = Color3.fromRGB(45, 214, 135),
	AccentDark = Color3.fromRGB(25, 150, 95),
	Text = Color3.fromRGB(240, 246, 255),
	Muted = Color3.fromRGB(145, 158, 176),
	Danger = Color3.fromRGB(239, 78, 91),
	Blue = Color3.fromRGB(73, 132, 255),
	Off = Color3.fromRGB(55, 64, 78),
}

function tween(object, info, properties)
	pcall(function()
		game:GetService("TweenService"):Create(object, info, properties):Play()
	end)
end

function round(obj, r)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r or 12)
	c.Parent = obj
	return c
end

function addStroke(obj, transparency, color)
	local strokeObject = Instance.new("UIStroke")
	strokeObject.Color = color or Theme.Accent
	strokeObject.Transparency = transparency or 0.72
	strokeObject.Thickness = 1
	strokeObject.Parent = obj
	return strokeObject
end

main = Instance.new("Frame")
main.Size = UDim2.new(0, 590, 0, 430)
main.Position = UDim2.new(0.5, -295, 0.5, -215)
main.BackgroundColor3 = Theme.Background
main.BorderSizePixel = 0
main.Parent = gui
round(main, 20)
stroke = addStroke(main, 0.35, Theme.Accent)
shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.Position = UDim2.new(0.5, 0, 0.5, 8)
shadow.Size = UDim2.new(1, 46, 1, 46)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6014261993"
shadow.ImageColor3 = Color3.new(0, 0, 0)
shadow.ImageTransparency = 0.35
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(49, 49, 450, 450)
shadow.ZIndex = 0
shadow.Parent = main
main.ZIndex = 2

topLine = Instance.new("Frame")
topLine.Size = UDim2.new(1, -24, 0, 1)
topLine.Position = UDim2.new(0, 12, 0, 44)
topLine.BackgroundColor3 = Theme.Surface3
topLine.BorderSizePixel = 0
topLine.Parent = main

title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -90, 0, 36)
title.Position = UDim2.new(0, 18, 0, 7)
title.BackgroundTransparency = 1
title.Text = "ONYX  •  HUB"
title.TextColor3 = Theme.Text
title.Font = Enum.Font.GothamBlack
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -40, 0, 8)
close.BackgroundColor3 = Theme.Danger
close.Text = "×"
close.TextColor3 = Color3.new(1,1,1)
close.Font = Enum.Font.GothamBlack
close.TextSize = 18
close.BorderSizePixel = 0
close.Parent = main
round(close, 10)

sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 108, 1, -64)
sidebar.Position = UDim2.new(0, 10, 0, 50)
sidebar.BackgroundColor3 = Theme.Surface
sidebar.BorderSizePixel = 0
sidebar.Parent = main
round(sidebar, 14)

content = Instance.new("Frame")
content.Size = UDim2.new(1, -138, 1, -78)
content.Position = UDim2.new(0, 128, 0, 50)
content.BackgroundTransparency = 1
content.Parent = main

statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -28, 0, 24)
statusLabel.Position = UDim2.new(0, 14, 1, -28)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "● Ready"
statusLabel.TextColor3 = Theme.Accent
statusLabel.Font = Enum.Font.GothamBold
statusLabel.TextSize = 10
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = main

pages = {}
tabs = {}

function makePage(name)
	local page = Instance.new("Frame")
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.ClipsDescendants = true
	page.Visible = false
	page.Parent = content
	pages[name] = page
	return page
end

function setPage(name)
	for n, p in pairs(pages) do
		p.Visible = n == name
	end

	for n, b in pairs(tabs) do
		local selected = n == name
		tween(b, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			BackgroundColor3 = selected and Theme.AccentDark or Theme.Surface2,
			TextColor3 = selected and Theme.Text or Theme.Muted
		})
		local indicator = b:FindFirstChild("Indicator")
		if indicator then indicator.Visible = selected end
	end

	setStatus("Aba: " .. name)
end

function makeTab(name, y)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(1, -10, 0, 30)
	b.Position = UDim2.new(0, 5, 0, y)
	b.BackgroundColor3 = Theme.Surface2
	b.Text = name
	b.TextColor3 = Theme.Muted
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.BorderSizePixel = 0
	b.Parent = sidebar
	round(b, 9)

	local indicator = Instance.new("Frame")
	indicator.Name = "Indicator"
	indicator.Size = UDim2.new(0, 3, 0, 16)
	indicator.Position = UDim2.new(0, 4, 0.5, -8)
	indicator.BackgroundColor3 = Theme.Accent
	indicator.BorderSizePixel = 0
	indicator.Visible = false
	indicator.Parent = b
	round(indicator, 3)

	b.MouseEnter:Connect(function()
		if not indicator.Visible then tween(b, TweenInfo.new(0.12), {BackgroundColor3 = Theme.Surface3}) end
	end)
	b.MouseLeave:Connect(function()
		if not indicator.Visible then tween(b, TweenInfo.new(0.12), {BackgroundColor3 = Theme.Surface2}) end
	end)

	tabs[name] = b

	b.MouseButton1Click:Connect(function()
		setPage(name)
	end)

	return b
end

function makeCard(parent, name, x, y, w, h)
	local card = Instance.new("Frame")
	card.Size = UDim2.new(0, w, 0, h)
	card.Position = UDim2.new(0, x, 0, y)
	card.BackgroundColor3 = Theme.Surface
	card.BorderSizePixel = 0
	card.Parent = parent
	round(card, 14)
	addStroke(card, 0.72)

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -16, 0, 22)
	label.Position = UDim2.new(0, 10, 0, 5)
	label.BackgroundTransparency = 1
	label.Text = name
	label.TextColor3 = Theme.Text
	label.Font = Enum.Font.GothamBlack
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = card

	return card
end

function makeButton(parent, text, x, y, w, h, color)
	local b = Instance.new("TextButton")
	b.Size = UDim2.new(0, w, 0, h)
	b.Position = UDim2.new(0, x, 0, y)
	b.BackgroundColor3 = color or Theme.AccentDark
	b.Text = text
	b.TextColor3 = Theme.Muted
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.BorderSizePixel = 0
	b.Parent = parent
	round(b, 9)
	b.AutoButtonColor = false
	b.MouseEnter:Connect(function()
		tween(b, TweenInfo.new(0.12), {BackgroundTransparency = 0.08})
	end)
	b.MouseLeave:Connect(function()
		tween(b, TweenInfo.new(0.12), {BackgroundTransparency = 0})
	end)
	b.MouseButton1Down:Connect(function()
		tween(b, TweenInfo.new(0.08), {Size = UDim2.new(b.Size.X.Scale, b.Size.X.Offset - 2, b.Size.Y.Scale, b.Size.Y.Offset - 2)})
	end)
	b.MouseButton1Up:Connect(function()
		tween(b, TweenInfo.new(0.08), {Size = UDim2.new(b.Size.X.Scale, b.Size.X.Offset + 2, b.Size.Y.Scale, b.Size.Y.Offset + 2)})
	end)
	return b
end

function makeBox(parent, placeholder, x, y, w, h, value)
	local box = Instance.new("TextBox")
	box.Size = UDim2.new(0, w, 0, h)
	box.Position = UDim2.new(0, x, 0, y)
	box.BackgroundColor3 = Theme.Surface2
	box.Text = value or ""
	box.PlaceholderText = placeholder
	box.TextColor3 = Theme.Text
	box.PlaceholderColor3 = Theme.Muted
	box.Font = Enum.Font.GothamBold
	box.TextSize = 10
	box.ClearTextOnFocus = false
	box.BorderSizePixel = 0
	box.Parent = parent
	round(box, 10)
	return box
end

function updateToggleButton(button, text, state)
	button.Text = text .. ": " .. (state and "ON" or "OFF")
	button.BackgroundColor3 = state and Theme.AccentDark or Theme.Off
end

function safeInputPosition(input)
	if input and input.Position then
		return input.Position
	end

	local ok, pos = pcall(function()
		return UIS:GetMouseLocation()
	end)

	if ok and pos then
		return Vector3.new(pos.X, pos.Y, 0)
	end

	return Vector3.new(0, 0, 0)
end

function stopEverything()
	autoQuestLevel = false
	autoFarmNPC = false
	autoTower = false
	autoDungeon = false
	autoSimulatedSea = false
	autoBossOnly = false
	autoFlowers = false
	flowerCollecting = false
	autoAttack = false
	bossPriority = false

	clearSmoothHold()
	disableNoClip()

	if questBtn then updateToggleButton(questBtn, "Auto Quest Level", false) end
	if farmNPCBtn then updateToggleButton(farmNPCBtn, "Farm NPC", false) end
	if towerBtn then updateToggleButton(towerBtn, "Auto Tower", false) end
	if dungeonBtn then updateToggleButton(dungeonBtn, "Auto Dungeon", false) end
	if reset15Btn then updateToggleButton(reset15Btn, "Reset 15s", false) end
	if simulatedSeaBtn then updateToggleButton(simulatedSeaBtn, "Auto Simulated", false) end
	if autoResetBtn then updateToggleButton(autoResetBtn, "Auto Reset", false) end
	if simulatedEnterBtn then updateToggleButton(simulatedEnterBtn, "Auto Enter", false) end
	if attackBtn then updateToggleButton(attackBtn, "Auto Attack", false) end
	if priorityBtn then updateToggleButton(priorityBtn, "Boss Priority", false) end
	if autoBossOnlyBtn then updateToggleButton(autoBossOnlyBtn, "Auto Boss", false) end
	if bossPriorityBtn2 then updateToggleButton(bossPriorityBtn2, "Boss Priority", false) end
	if flowersBtn then updateToggleButton(flowersBtn, "Auto Flores", false) end

	currentTarget = nil
	currentTargetName = "None"

	setStatus("PANIC: tudo parado")
end

mainPage = makePage("Main")
settingsPage = makePage("Config")
bossesPage = makePage("Boss")
towerPage = makePage("Tower")
dungeonPage = makePage("Dungeon")
simulatedSeaPage = makePage("Sea")
priorityPage = makePage("Priority")
interfacePage = makePage("UI")
othersPage = makePage("Outros")

makeTab("Main", 8)
makeTab("Config", 40)
makeTab("Boss", 72)
makeTab("Tower", 104)
makeTab("Dungeon", 136)
makeTab("Sea", 168)
makeTab("Priority", 200)
makeTab("UI", 232)
makeTab("Outros", 264)

questCard = makeCard(mainPage, "Quest", 0, 0, 360, 112)

levelInfo = Instance.new("TextLabel")
levelInfo.Size = UDim2.new(1, -24, 0, 26)
levelInfo.Position = UDim2.new(0, 10, 0, 30)
levelInfo.BackgroundTransparency = 1
levelInfo.Text = "Level: ?"
levelInfo.TextColor3 = Color3.fromRGB(235,255,245)
levelInfo.Font = Enum.Font.GothamBold
levelInfo.TextSize = 10
levelInfo.TextXAlignment = Enum.TextXAlignment.Left
levelInfo.Parent = questCard

questInfo = Instance.new("TextLabel")
questInfo.Size = UDim2.new(1, -20, 0, 36)
questInfo.Position = UDim2.new(0, 10, 0, 50)
questInfo.BackgroundColor3 = Color3.fromRGB(14, 44, 34)
questInfo.Text = "Quest: None"
questInfo.TextColor3 = Color3.fromRGB(235,255,245)
questInfo.Font = Enum.Font.GothamBold
questInfo.TextSize = 10
questInfo.TextWrapped = true
questInfo.BorderSizePixel = 0
questInfo.Parent = questCard
round(questInfo, 10)

questBtn = makeButton(questCard, "Quest: OFF", 10, 86, 110, 24, Color3.fromRGB(55,65,65))
questBtn.MouseButton1Click:Connect(function()
	autoQuestLevel = not autoQuestLevel
	updateToggleButton(questBtn, "Auto Quest Level", autoQuestLevel)

	if autoQuestLevel then
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end
		startAutoQuestLevel()
	else
		clearSmoothHold()
		setStatus("Auto Quest Level desligado")
	end
end)

attackBtn = makeButton(questCard, "Atk: ON", 130, 86, 85, 24, Color3.fromRGB(25, 170, 105))
attackBtn.MouseButton1Click:Connect(function()
	autoAttack = not autoAttack
	updateToggleButton(attackBtn, "Auto Attack", autoAttack)
end)

npcFarmCard = makeCard(mainPage, "NPC Multi Farm", 0, 122, 390, 176)

npcSelectedLabel = Instance.new("TextLabel")
npcSelectedLabel.Size = UDim2.new(1, -20, 0, 42)
npcSelectedLabel.Position = UDim2.new(0, 10, 0, 28)
npcSelectedLabel.BackgroundColor3 = Theme.Surface2
npcSelectedLabel.Text = "Selecionados (1): Bandit"
npcSelectedLabel.TextColor3 = Theme.Text
npcSelectedLabel.Font = Enum.Font.GothamBold
npcSelectedLabel.TextSize = 9
npcSelectedLabel.TextWrapped = true
npcSelectedLabel.TextXAlignment = Enum.TextXAlignment.Left
npcSelectedLabel.BorderSizePixel = 0
npcSelectedLabel.Parent = npcFarmCard
round(npcSelectedLabel, 9)

npcPrevBtn = makeButton(npcFarmCard, "◀", 10, 78, 34, 26, Theme.Surface3)
npcPrevBtn.MouseButton1Click:Connect(function()
	cycleSelectedNPC(-1)
	updateNPCMultiUI()
end)

npcSelectBtn = makeButton(npcFarmCard, "✓ Bandit", 50, 78, 178, 26, Theme.Surface3)
npcSelectBtn.TextXAlignment = Enum.TextXAlignment.Left
npcSelectBtn.MouseButton1Click:Connect(function()
	cycleSelectedNPC(1)
	updateNPCMultiUI()
end)

npcNextBtn = makeButton(npcFarmCard, "▶", 234, 78, 34, 26, Theme.Surface3)
npcNextBtn.MouseButton1Click:Connect(function()
	cycleSelectedNPC(1)
	updateNPCMultiUI()
end)

npcToggleBtn = makeButton(npcFarmCard, "Remover", 276, 78, 104, 26, Theme.Off)
npcToggleBtn.MouseButton1Click:Connect(function()
	toggleCurrentNPCSelection()
	updateNPCMultiUI()
end)

farmNPCBtn = makeButton(npcFarmCard, "Farm NPC: OFF", 10, 112, 120, 26, Theme.Off)
farmNPCBtn.MouseButton1Click:Connect(function()
	autoFarmNPC = not autoFarmNPC
	updateToggleButton(farmNPCBtn, "Farm NPC", autoFarmNPC)

	if autoFarmNPC then
		if getSelectedNPCCount() == 0 then
			selectedNPCs[selectedNPCFarm] = true
		end
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end
		startAutoFarmNPC()
	else
		clearSmoothHold()
		setStatus("Farm NPC desligado")
	end
end)

useQuestBtn = makeButton(npcFarmCard, "Quest: OFF", 138, 112, 86, 26, Theme.Off)
useQuestBtn.MouseButton1Click:Connect(function()
	useQuestForNPC = not useQuestForNPC
	updateToggleButton(useQuestBtn, "Usar Quest", useQuestForNPC)
end)

npcAllBtn = makeButton(npcFarmCard, "Todos", 232, 112, 68, 26, Theme.Blue)
npcAllBtn.MouseButton1Click:Connect(function()
	selectAllNPCs()
	updateNPCMultiUI()
	setStatus("Todos os NPCs selecionados")
end)

npcOnlyBtn = makeButton(npcFarmCard, "Só este", 308, 112, 72, 26, Theme.Surface3)
npcOnlyBtn.MouseButton1Click:Connect(function()
	selectOnlyCurrentNPC()
	updateNPCMultiUI()
	setStatus("Somente: " .. selectedNPCFarm)
end)

npcHint = Instance.new("TextLabel")
npcHint.Size = UDim2.new(1, -20, 0, 24)
npcHint.Position = UDim2.new(0, 10, 0, 144)
npcHint.BackgroundTransparency = 1
npcHint.Text = "O farm escolhe automaticamente o NPC selecionado mais próximo."
npcHint.TextColor3 = Theme.Muted
npcHint.Font = Enum.Font.GothamBold
npcHint.TextSize = 8
npcHint.TextXAlignment = Enum.TextXAlignment.Left
npcHint.Parent = npcFarmCard

updateNPCMultiUI()

moveCard = makeCard(settingsPage, "Config", 0, 0, 360, 190)

modeBtn = makeButton(moveCard, "Mode: Above", 10, 32, 96, 24, Color3.fromRGB(14,44,34))
modeBtn.MouseButton1Click:Connect(function()
	if farmMode == "Above" then
		farmMode = "Behind"
	elseif farmMode == "Behind" then
		farmMode = "Front"
	elseif farmMode == "Front" then
		farmMode = "Below"
	else
		farmMode = "Above"
	end

	modeBtn.Text = "Mode: " .. farmMode
	setStatus("Modo: " .. farmMode)
end)

heightBox = makeBox(moveCard, "H", 114, 32, 55, 24, tostring(farmHeight))
heightBox.FocusLost:Connect(function()
	farmHeight = tonumber(heightBox.Text) or farmHeight
	farmHeight = math.clamp(farmHeight, 1, 50)
	heightBox.Text = tostring(farmHeight)
	setStatus("Altura: " .. tostring(farmHeight))
end)

distBox = makeBox(moveCard, "D", 178, 32, 55, 24, tostring(farmDistance))
distBox.FocusLost:Connect(function()
	farmDistance = tonumber(distBox.Text) or farmDistance
	farmDistance = math.clamp(farmDistance, 1, 60)
	distBox.Text = tostring(farmDistance)
	setStatus("Distância: " .. tostring(farmDistance))
end)

delayBox = makeBox(moveCard, "Delay", 10, 64, 72, 24, tostring(attackDelay))
delayBox.FocusLost:Connect(function()
	attackDelay = tonumber(delayBox.Text) or attackDelay
	attackDelay = math.clamp(attackDelay, 0.03, 2)
	delayBox.Text = tostring(attackDelay)
	setStatus("Attack Delay: " .. tostring(attackDelay))
end)

hoverBtn = makeButton(moveCard, "Hover: ON", 90, 64, 75, 24, Color3.fromRGB(25, 170, 105))
hoverBtn.MouseButton1Click:Connect(function()
	hoverEnabled = not hoverEnabled
	updateToggleButton(hoverBtn, "Hover", hoverEnabled)

	if not hoverEnabled then clearSmoothHold() end
end)

noclipBtn = makeButton(moveCard, "Clip: ON", 174, 64, 75, 24, Color3.fromRGB(25, 170, 105))
noclipBtn.MouseButton1Click:Connect(function()
	noclipEnabled = not noclipEnabled
	updateToggleButton(noclipBtn, "Noclip", noclipEnabled)

	if noclipEnabled then enableNoClip() else disableNoClip() end
end)

faceBtn = makeButton(moveCard, "Face: ON", 10, 96, 72, 24, Color3.fromRGB(25, 170, 105))
faceBtn.MouseButton1Click:Connect(function()
	faceTarget = not faceTarget
	updateToggleButton(faceBtn, "Face", faceTarget)
end)

antiStuckBtn = makeButton(moveCard, "Stuck: ON", 90, 96, 75, 24, Color3.fromRGB(25, 170, 105))
antiStuckBtn.MouseButton1Click:Connect(function()
	antiStuck = not antiStuck
	updateToggleButton(antiStuckBtn, "Anti Stuck", antiStuck)
end)

autoEquipBtn = makeButton(moveCard, "Equip: ON", 174, 96, 75, 24, Color3.fromRGB(25, 170, 105))
autoEquipBtn.MouseButton1Click:Connect(function()
	autoEquip = not autoEquip
	updateToggleButton(autoEquipBtn, "Auto Equip", autoEquip)
end)

weaponBox = makeBox(moveCard, "Item", 10, 132, 130, 24, weaponSearchText)
weaponBox.FocusLost:Connect(function()
	weaponSearchText = weaponBox.Text
	setStatus("Auto Equip busca: " .. tostring(weaponSearchText))
	equipSelectedTool()
end)

equipNowBtn = makeButton(moveCard, "Equip", 150, 132, 70, 24, Color3.fromRGB(45,95,180))
equipNowBtn.MouseButton1Click:Connect(function()
	weaponSearchText = weaponBox.Text
	equipSelectedTool()
	setStatus("Item equipado: " .. tostring(selectedWeaponName))
end)

configCard = makeCard(settingsPage, "Save", 0, 198, 360, 100)
reset15Btn = makeButton(configCard, "Reset 15s: OFF", 10, 68, 120, 24, Color3.fromRGB(55,65,65))
reset15Btn.MouseButton1Click:Connect(function()
	autoReset15s = not autoReset15s
	reset15Last = os.clock()
	updateToggleButton(reset15Btn, "Reset 15s", autoReset15s)

	if autoReset15s then
		setStatus("Reset 15s ligado")
	else
		setStatus("Reset 15s desligado")
	end
end)

resetNowBtn = makeButton(configCard, "Reset Agora", 140, 68, 100, 24, Color3.fromRGB(220,70,80))
resetNowBtn.MouseButton1Click:Connect(function()
	setStatus("Reset manual executado")
	reset15Last = os.clock()
	if forceCharacterReset then
		forceCharacterReset()
	else
		setStatus("Reset ainda não disponível")
	end
end)


makeButton(configCard, "Save", 10, 34, 70, 24, Color3.fromRGB(25, 170, 105)).MouseButton1Click:Connect(function()
	saveConfig()
end)

makeButton(configCard, "Load", 90, 34, 70, 24, Color3.fromRGB(45,95,180)).MouseButton1Click:Connect(function()
	loadConfig()

	modeBtn.Text = "Mode: " .. farmMode
	heightBox.Text = tostring(farmHeight)
	distBox.Text = tostring(farmDistance)
	delayBox.Text = tostring(attackDelay)
	weaponBox.Text = weaponSearchText
	updateNPCMultiUI()
	updateToggleButton(useQuestBtn, "Usar Quest", useQuestForNPC)

	if autoBossOnlyBtn then updateToggleButton(autoBossOnlyBtn, "Auto Boss", autoBossOnly) end
	if bossModeBtn then bossModeBtn.Text = bossMode == "Selected" and "Modo: Selecionado" or "Modo: Todos" end
	if flowerPriorityBtn then updateToggleButton(flowerPriorityBtn, "Flores > Boss", flowerPriority) end
	if bossPriorityBtn2 then updateToggleButton(bossPriorityBtn2, "Boss > NPC", bossPriority) end
	if flowersBtn then updateToggleButton(flowersBtn, "Auto Flores", false) end
	if bossSelectBtn then bossSelectBtn.Text = "Boss: " .. tostring(selectedBossName) end
	if towerModeBtn then towerModeBtn.Text = "Modo: " .. towerMode end
	if towerSelectBtn then towerSelectBtn.Text = "NPC: " .. selectedTowerNPC end
	if simulatedSeaBtn then updateToggleButton(simulatedSeaBtn, "Auto Simulated", autoSimulatedSea) end
	if autoResetBtn then updateToggleButton(autoResetBtn, "Auto Reset", autoReset15s) end
	if simulatedEnterBtn then updateToggleButton(simulatedEnterBtn, "Auto Enter", autoSimulatedEnter) end
	if dungeonPillarBtn then updateToggleButton(dungeonPillarBtn, "Pillars", autoDungeonPillars) end
	if reset15Btn then updateToggleButton(reset15Btn, "Reset 15s", autoReset15s) end
	if flowersBtn then updateToggleButton(flowersBtn, "Auto Flores", autoFlowers) end
	if flowerSpeedBox then flowerSpeedBox.Text = tostring(FLOWER_MOVE_SPEED) end
	if dungeonModeBtn then dungeonModeBtn.Text = "Modo: " .. dungeonMode end
	if dungeonSelectBtn then dungeonSelectBtn.Text = "NPC: " .. selectedDungeonNPC end
	updateNPCMultiUI()
	setStatus("Config aplicada na UI")
end)

antiAFKBtn = makeButton(configCard, "AFK: ON", 170, 34, 75, 24, Color3.fromRGB(25, 170, 105))
antiAFKBtn.MouseButton1Click:Connect(function()
	antiAFK = not antiAFK
	updateToggleButton(antiAFKBtn, "Anti AFK", antiAFK)
end)

bossCard = makeCard(bossesPage, "Boss Hunter • V3", 0, 0, 390, 268)

bossHeader = Instance.new("TextLabel")
bossHeader.Size = UDim2.new(1, -20, 0, 34)
bossHeader.Position = UDim2.new(0, 10, 0, 29)
bossHeader.BackgroundColor3 = Theme.Surface2
bossHeader.Text = "Escolha entre caçar qualquer boss vivo ou somente um boss específico."
bossHeader.TextColor3 = Theme.Muted
bossHeader.Font = Enum.Font.GothamBold
bossHeader.TextSize = 9
bossHeader.TextWrapped = true
bossHeader.BorderSizePixel = 0
bossHeader.Parent = bossCard
round(bossHeader, 9)

autoBossOnlyBtn = makeButton(bossCard, "Auto Boss: OFF", 10, 72, 145, 28, Theme.Off)
autoBossOnlyBtn.MouseButton1Click:Connect(function()
	autoBossOnly = not autoBossOnly
	updateToggleButton(autoBossOnlyBtn, "Auto Boss", autoBossOnly)

	if autoBossOnly then
		autoQuestLevel = false
		autoFarmNPC = false
		autoTower = false
		autoDungeon = false

		if questBtn then updateToggleButton(questBtn, "Auto Quest Level", false) end
		if farmNPCBtn then updateToggleButton(farmNPCBtn, "Farm NPC", false) end
		if towerBtn then updateToggleButton(towerBtn, "Auto Tower", false) end
		if dungeonBtn then updateToggleButton(dungeonBtn, "Auto Dungeon", false) end

		bossScanCacheAt = 0
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end

		setStatus("Auto Boss ligado • " .. (bossMode == "Selected" and selectedBossName or "Todos"))
		startAutoBossOnly()
	else
		clearSmoothHold()
		currentTarget = nil
		currentTargetName = "None"
		setStatus("Auto Boss desligado")
	end
end)

priorityBtn = makeButton(bossCard, "Prioridade: OFF", 165, 72, 145, 28, Theme.Off)
priorityBtn.MouseButton1Click:Connect(function()
	bossPriority = not bossPriority
	updateToggleButton(priorityBtn, "Boss Priority", bossPriority)
	if bossPriorityBtn2 then updateToggleButton(bossPriorityBtn2, "Boss Priority", bossPriority) end
end)

bossModeBtn = makeButton(bossCard, "Modo: Todos", 10, 108, 120, 28, Theme.Surface3)
bossModeBtn.MouseButton1Click:Connect(function()
	bossMode = bossMode == "All" and "Selected" or "All"
	bossModeBtn.Text = bossMode == "Selected" and "Modo: Selecionado" or "Modo: Todos"
	bossScanCacheAt = 0
	setStatus("Boss modo: " .. (bossMode == "Selected" and "Selecionado" or "Todos"))
end)

bossSelectBtn = makeButton(bossCard, "Boss: " .. tostring(selectedBossName), 140, 108, 240, 28, Theme.Surface3)
bossSelectBtn.TextXAlignment = Enum.TextXAlignment.Left
bossSelectBtn.MouseButton1Click:Connect(function()
	cycleSelectedBoss(1)
	bossSelectBtn.Text = "Boss: " .. tostring(selectedBossName)
end)

bossPrevBtn = makeButton(bossCard, "◀ Anterior", 10, 144, 105, 26, Theme.Surface3)
bossPrevBtn.MouseButton1Click:Connect(function()
	cycleSelectedBoss(-1)
	bossSelectBtn.Text = "Boss: " .. tostring(selectedBossName)
end)

bossNextBtn = makeButton(bossCard, "Próximo ▶", 125, 144, 105, 26, Theme.Surface3)
bossNextBtn.MouseButton1Click:Connect(function()
	cycleSelectedBoss(1)
	bossSelectBtn.Text = "Boss: " .. tostring(selectedBossName)
end)

bossScanBtn = makeButton(bossCard, "Reescanear", 240, 144, 100, 26, Theme.Blue)
bossScanBtn.MouseButton1Click:Connect(function()
	local alive = getAliveBossNames()
	refreshBossScan(true)
	alive = getAliveBossNames()
	setStatus("Bosses vivos detectados: " .. tostring(#alive))
end)

bossStatusPanel = Instance.new("TextLabel")
bossStatusPanel.Size = UDim2.new(1, -20, 0, 72)
bossStatusPanel.Position = UDim2.new(0, 10, 0, 180)
bossStatusPanel.BackgroundColor3 = Theme.Surface2
bossStatusPanel.Text = "Scanner aguardando..."
bossStatusPanel.TextColor3 = Theme.Text
bossStatusPanel.Font = Enum.Font.GothamBold
bossStatusPanel.TextSize = 9
bossStatusPanel.TextWrapped = true
bossStatusPanel.TextXAlignment = Enum.TextXAlignment.Left
bossStatusPanel.TextYAlignment = Enum.TextYAlignment.Top
bossStatusPanel.BorderSizePixel = 0
bossStatusPanel.Parent = bossCard
round(bossStatusPanel, 10)

towerCard = makeCard(towerPage, "Tower Auto Kill", 0, 0, 360, 205)

towerBtn = makeButton(towerCard, "Auto: OFF", 10, 34, 105, 26, Color3.fromRGB(55,65,65))
towerBtn.MouseButton1Click:Connect(function()
	autoTower = not autoTower
	updateToggleButton(towerBtn, "Auto Tower", autoTower)

	if autoTower then
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end
		startAutoTower()
	else
		clearSmoothHold()
		setStatus("Auto Tower desligado")
	end
end)

towerModeBtn = makeButton(towerCard, "All", 125, 34, 80, 26, Color3.fromRGB(14,44,34))
towerModeBtn.MouseButton1Click:Connect(function()
	if towerMode == "All" then
		towerMode = "Selected"
	else
		towerMode = "All"
	end

	towerModeBtn.Text = "Modo: " .. towerMode
	setStatus("Tower modo: " .. towerMode)
end)

towerSelectBtn = makeButton(towerCard, "NPC: Tower_Katana", 10, 70, 220, 26, Color3.fromRGB(14,44,34))
towerSelectBtn.MouseButton1Click:Connect(function()
	cycleTowerNPC()
	towerSelectBtn.Text = "NPC: " .. selectedTowerNPC
end)

dungeonCard = makeCard(dungeonPage, "Dungeon Auto Kill", 0, 0, 360, 205)

dungeonBtn = makeButton(dungeonCard, "Auto: OFF", 10, 34, 105, 26, Color3.fromRGB(55,65,65))
dungeonBtn.MouseButton1Click:Connect(function()
	autoDungeon = not autoDungeon
	updateToggleButton(dungeonBtn, "Auto Dungeon", autoDungeon)

	if autoDungeon then
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end
		startAutoDungeon()
	else
		clearSmoothHold()
		setStatus("Auto Dungeon desligado")
	end
end)

dungeonModeBtn = makeButton(dungeonCard, "All", 125, 34, 80, 26, Color3.fromRGB(14,44,34))
dungeonModeBtn.MouseButton1Click:Connect(function()
	if dungeonMode == "All" then
		dungeonMode = "Selected"
	else
		dungeonMode = "All"
	end

	dungeonModeBtn.Text = "Modo: " .. dungeonMode
	setStatus("Dungeon modo: " .. dungeonMode)
end)

dungeonSelectBtn = makeButton(dungeonCard, "NPC: ShadowKnight", 10, 70, 220, 26, Color3.fromRGB(14,44,34))
dungeonSelectBtn.MouseButton1Click:Connect(function()
	cycleDungeonNPC()
	dungeonSelectBtn.Text = "NPC: " .. selectedDungeonNPC
end)

dungeonPillarBtn = makeButton(dungeonCard, "Pillars: ON", 240, 70, 90, 26, Color3.fromRGB(25, 170, 105))
dungeonPillarBtn.MouseButton1Click:Connect(function()
	autoDungeonPillars = not autoDungeonPillars
	updateToggleButton(dungeonPillarBtn, "Pillars", autoDungeonPillars)
end)

pillarManualBtn = makeButton(dungeonCard, "Pillar", 240, 98, 90, 24, Color3.fromRGB(45,95,180))
pillarManualBtn.MouseButton1Click:Connect(function()
	task.spawn(function()
		local oldDungeon = autoDungeon
		autoDungeon = true
		autoDungeonPillars = true
		updateToggleButton(dungeonPillarBtn, "Pillars", true)
		interactDungeonPillar()
		autoDungeon = oldDungeon
	end)
end)

towerStatus = Instance.new("TextLabel")
towerStatus.Size = UDim2.new(1, -24, 0, 34)
towerStatus.Position = UDim2.new(0, 10, 0, 92)
towerStatus.BackgroundTransparency = 1
towerStatus.Text = "Status: aguardando"
towerStatus.TextColor3 = Color3.fromRGB(180, 235, 200)
towerStatus.Font = Enum.Font.GothamBold
towerStatus.TextSize = 10
towerStatus.TextXAlignment = Enum.TextXAlignment.Left
towerStatus.Parent = towerCard

dungeonStatus = Instance.new("TextLabel")
dungeonStatus.Size = UDim2.new(1, -24, 0, 34)
dungeonStatus.Position = UDim2.new(0, 10, 0, 92)
dungeonStatus.BackgroundTransparency = 1
dungeonStatus.Text = "Status: aguardando"
dungeonStatus.TextColor3 = Color3.fromRGB(180, 235, 200)
dungeonStatus.Font = Enum.Font.GothamBold
dungeonStatus.TextSize = 10
dungeonStatus.TextXAlignment = Enum.TextXAlignment.Left
dungeonStatus.Parent = dungeonCard

simulatedSeaCard = makeCard(simulatedSeaPage, "Simulated Sea", 0, 0, 360, 205)

simulatedSeaBtn = makeButton(simulatedSeaCard, "Farm: OFF", 10, 34, 105, 26, Color3.fromRGB(55,65,65))
simulatedEnterBtn = makeButton(simulatedSeaCard, "Enter: OFF", 125, 34, 105, 26, Color3.fromRGB(55,65,65))

simulatedEnterBtn.MouseButton1Click:Connect(function()
	autoSimulatedEnter = not autoSimulatedEnter
	updateToggleButton(simulatedEnterBtn, "Auto Enter", autoSimulatedEnter)

	if autoSimulatedEnter then
		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end
		startAutoSimulatedEnter()
	else
		setStatus("Auto Enter desligado")
	end
end)

autoResetBtn = makeButton(simulatedSeaCard, "Reset: OFF", 10, 70, 105, 26, Color3.fromRGB(55,65,65))
autoResetBtn.MouseButton1Click:Connect(function()
	autoReset15s = not autoReset15s
	updateToggleButton(autoResetBtn, "Auto Reset", autoReset15s)

	if autoReset15s then
		setStatus("Auto Reset ligado: 15s")
	else
		setStatus("Auto Reset desligado")
	end
end)

simulatedSeaBtn.MouseButton1Click:Connect(function()
	autoSimulatedSea = not autoSimulatedSea
	updateToggleButton(simulatedSeaBtn, "Auto Simulated", autoSimulatedSea)

	if autoSimulatedSea then
		autoQuestLevel = false
		autoFarmNPC = false
		autoTower = false
		autoDungeon = false
		autoBossOnly = false

		if questBtn then updateToggleButton(questBtn, "Auto Quest Level", false) end
		if farmNPCBtn then updateToggleButton(farmNPCBtn, "Farm NPC", false) end
		if towerBtn then updateToggleButton(towerBtn, "Auto Tower", false) end
		if dungeonBtn then updateToggleButton(dungeonBtn, "Auto Dungeon", false) end
		if autoBossOnlyBtn then updateToggleButton(autoBossOnlyBtn, "Auto Boss", false) end

		if hoverEnabled then setupSmoothHold() end
		if noclipEnabled then enableNoClip() end

		startAutoSimulatedSea()
	else
		clearSmoothHold()
		currentTarget = nil
		currentTargetName = "None"
		setStatus("Auto Simulated desligado")
	end
end)

simulatedSeaInfo = Instance.new("TextLabel")
simulatedSeaInfo.Size = UDim2.new(1, -20, 0, 30)
simulatedSeaInfo.Position = UDim2.new(0, 10, 0, 104)
simulatedSeaInfo.BackgroundColor3 = Color3.fromRGB(14, 44, 34)
simulatedSeaInfo.Text = "Auto Enter entra na porta disponível. Auto Simulated mata NPCs próximos."
simulatedSeaInfo.TextColor3 = Color3.fromRGB(235,255,245)
simulatedSeaInfo.Font = Enum.Font.GothamBold
simulatedSeaInfo.TextSize = 10
simulatedSeaInfo.TextWrapped = true
simulatedSeaInfo.BorderSizePixel = 0
simulatedSeaInfo.Parent = simulatedSeaCard
round(simulatedSeaInfo, 10)

priorityCard = makeCard(priorityPage, "Prioridade", 0, 0, 390, 180)

priorityInfo = Instance.new("TextLabel")
priorityInfo.Size = UDim2.new(1, -20, 0, 56)
priorityInfo.Position = UDim2.new(0, 10, 0, 30)
priorityInfo.BackgroundColor3 = Theme.Surface2
priorityInfo.Text = "FLORES > BOSS > NPC. Flores só entram quando Auto Flores estiver ON. Auto Flores OFF = nenhum scan de flores."
priorityInfo.TextColor3 = Theme.Muted
priorityInfo.Font = Enum.Font.GothamBold
priorityInfo.TextSize = 9
priorityInfo.TextWrapped = true
priorityInfo.BorderSizePixel = 0
priorityInfo.Parent = priorityCard
round(priorityInfo, 9)

flowerPriorityBtn = makeButton(priorityCard, "Flores > Boss: ON", 10, 98, 155, 28, Theme.On)
flowerPriorityBtn.MouseButton1Click:Connect(function()
	flowerPriority = not flowerPriority
	updateToggleButton(flowerPriorityBtn, "Flores > Boss", flowerPriority)
end)

bossPriorityBtn2 = makeButton(priorityCard, "Boss > NPC: OFF", 175, 98, 155, 28, Theme.Off)
bossPriorityBtn2.MouseButton1Click:Connect(function()
	bossPriority = not bossPriority
	updateToggleButton(bossPriorityBtn2, "Boss > NPC", bossPriority)
	if priorityBtn then updateToggleButton(priorityBtn, "Boss Priority", bossPriority) end
end)

priorityStateLabel = Instance.new("TextLabel")
priorityStateLabel.Size = UDim2.new(1, -20, 0, 30)
priorityStateLabel.Position = UDim2.new(0, 10, 0, 140)
priorityStateLabel.BackgroundTransparency = 1
priorityStateLabel.Text = "Auto Flores OFF • Boss Priority OFF • NPC"
priorityStateLabel.TextColor3 = Theme.Text
priorityStateLabel.Font = Enum.Font.GothamBlack
priorityStateLabel.TextSize = 9
priorityStateLabel.TextXAlignment = Enum.TextXAlignment.Left
priorityStateLabel.Parent = priorityCard

othersCard = makeCard(othersPage, "Blue Spider Lily", 0, 0, 360, 212)

flowersInfo = Instance.new("TextLabel")
flowersInfo.Size = UDim2.new(1, -20, 0, 58)
flowersInfo.Position = UDim2.new(0, 10, 0, 32)
flowersInfo.BackgroundColor3 = Theme.Surface2
flowersInfo.Text = "Detecta as 5 flores à noite, atravessa paredes automaticamente durante a coleta e tenta cada flor somente 1x por noite. Depois marca OK mesmo se ela continuar visível."
flowersInfo.TextColor3 = Theme.Text
flowersInfo.Font = Enum.Font.GothamBold
flowersInfo.TextSize = 10
flowersInfo.TextWrapped = true
flowersInfo.TextXAlignment = Enum.TextXAlignment.Left
flowersInfo.TextYAlignment = Enum.TextYAlignment.Top
flowersInfo.BorderSizePixel = 0
flowersInfo.Parent = othersCard
round(flowersInfo, 10)

flowerSpeedBox = makeBox(othersCard, "Velocidade", 10, 96, 90, 28, tostring(FLOWER_MOVE_SPEED))
flowerSpeedBox.FocusLost:Connect(function()
	FLOWER_MOVE_SPEED = math.clamp(tonumber(flowerSpeedBox.Text) or FLOWER_MOVE_SPEED, 15, 120)
	flowerSpeedBox.Text = tostring(FLOWER_MOVE_SPEED)
	setStatus("Velocidade das flores: " .. tostring(FLOWER_MOVE_SPEED))
end)

flowerSpeedLabel = Instance.new("TextLabel")
flowerSpeedLabel.Size = UDim2.new(0, 125, 0, 28)
flowerSpeedLabel.Position = UDim2.new(0, 110, 0, 96)
flowerSpeedLabel.BackgroundTransparency = 1
flowerSpeedLabel.Text = "studs/s (menor = lento)"
flowerSpeedLabel.TextColor3 = Theme.Muted
flowerSpeedLabel.Font = Enum.Font.GothamBold
flowerSpeedLabel.TextSize = 9
flowerSpeedLabel.TextXAlignment = Enum.TextXAlignment.Left
flowerSpeedLabel.Parent = othersCard

flowerNoclipLabel = Instance.new("TextLabel")
flowerNoclipLabel.Size = UDim2.new(0, 100, 0, 22)
flowerNoclipLabel.Position = UDim2.new(1, -112, 0, 99)
flowerNoclipLabel.BackgroundColor3 = Theme.AccentDark
flowerNoclipLabel.Text = "NOCLIP AUTO"
flowerNoclipLabel.TextColor3 = Theme.Text
flowerNoclipLabel.Font = Enum.Font.GothamBlack
flowerNoclipLabel.TextSize = 8
flowerNoclipLabel.BorderSizePixel = 0
flowerNoclipLabel.Parent = othersCard
round(flowerNoclipLabel, 8)

flowersBtn = makeButton(othersCard, "Auto Flores: OFF", 10, 132, 140, 28, Theme.Off)
flowersBtn.MouseButton1Click:Connect(function()
	autoFlowers = not autoFlowers
	updateToggleButton(flowersBtn, "Auto Flores", autoFlowers)

	if autoFlowers then
		if FLOWER_FORCE_NOCLIP or noclipEnabled then enableNoClip() end
		setStatus(isNightTime() and "Flores: iniciando busca noturna" or "Flores: aguardando a noite")
		startAutoFlowers()
	else
		flowerCollecting = false
		currentTargetName = "None"
		clearSmoothHold()
		setStatus("Auto Flores OFF • scanner parado")
	end
end)

flowersResetBtn = makeButton(othersCard, "Reescanear noite", 160, 132, 125, 28, Theme.Blue)
flowersResetBtn.MouseButton1Click:Connect(function()
	if not autoFlowers then
		setStatus("Auto Flores está OFF")
		return
	end
	flowerTriedThisNight = {}
	flowerNightCount = 0
	setStatus("Flores: sessão noturna reiniciada")
end)

flowersStatus = Instance.new("TextLabel")
flowersStatus.Size = UDim2.new(1, -20, 0, 24)
flowersStatus.Position = UDim2.new(0, 10, 0, 174)
flowersStatus.BackgroundTransparency = 1
flowersStatus.Text = "Status: OFF | 0/5 OK"
flowersStatus.TextColor3 = Theme.Muted
flowersStatus.Font = Enum.Font.GothamBold
flowersStatus.TextSize = 10
flowersStatus.TextXAlignment = Enum.TextXAlignment.Left
flowersStatus.Parent = othersCard

interfaceCard = makeCard(interfacePage, "Interface", 0, 0, 360, 86)

panicBtn = makeButton(interfaceCard, "PANIC / STOP", 10, 36, 130, 28, Color3.fromRGB(220, 70, 80))
panicBtn.MouseButton1Click:Connect(function()
	stopEverything()
end)

task.spawn(function()
	while gui and gui.Parent do
		local level = getLevel()
		local quest = getQuestByLevel()

		levelInfo.Text = "Level: " .. tostring(level)

		if quest then
			questInfo.Text = "Quest: " .. quest.QuestNPC .. "\nMob: " .. quest.QuestMob
		else
			questInfo.Text = "Quest: None"
		end

		if towerStatus then
			towerStatus.Text = "Status: " .. (autoTower and ("ON | " .. tostring(currentTargetName)) or "OFF")
		end

		if dungeonStatus then
			dungeonStatus.Text = "Status: " .. (autoDungeon and ("ON | " .. tostring(currentTargetName)) or "OFF")
		end

		if bossStatusPanel then
			local modeText = bossMode == "Selected" and ("Selecionado • " .. tostring(selectedBossName)) or "Todos"
			local stateText = autoBossOnly and tostring(currentTargetName) or "OFF"
			bossStatusPanel.Text = "Modo: " .. modeText .. "\nAuto Boss: " .. stateText .. "\nScanner de vivos: somente no botão Reescanear."
		end

		if priorityStateLabel then
			local p = "NPC"
			if autoFlowers and flowerPriority and isNightTime() and countTriedFlowers() < FLOWER_EXPECTED_COUNT then
				p = "FLORES"
			elseif bossPriority then
				p = "BOSS se vivo • senão NPC"
			end
			priorityStateLabel.Text = "Auto Flores " .. (autoFlowers and "ON" or "OFF")
				.. " • Boss Priority " .. (bossPriority and "ON" or "OFF")
				.. " • " .. p
		end

		if flowersStatus then
			local timeState = isNightTime() and "NOITE" or "DIA"
			flowersStatus.Text = "Status: " .. (autoFlowers and "ON" or "OFF") .. " | " .. timeState .. " | " .. tostring(countTriedFlowers()) .. "/5 OK"
		end

		task.wait(0.4)
	end
end)

orb = Instance.new("TextButton")
orb.Size = UDim2.new(0, 42, 0, 42)
orb.Position = UDim2.new(0, 20, 0.5, -26)
orb.BackgroundColor3 = Color3.fromRGB(25, 170, 105)
orb.Text = "◆"
orb.TextColor3 = Theme.Text
orb.Font = Enum.Font.GothamBlack
orb.TextSize = 18
orb.BorderSizePixel = 0
orb.Parent = gui
round(orb, 10)

close.MouseButton1Click:Connect(function()
	main.Visible = false
	orb.Text = "◆"
end)

orb.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	orb.Text = main.Visible and "×" or "◆"
end)

dragging = false
dragStart = nil
startPos = nil

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = safeInputPosition(input)
		startPos = main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End or input.UserInputState == Enum.UserInputState.Cancel then
				dragging = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = safeInputPosition(input) - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

function applyTheme()
	main.BackgroundColor3 = Theme.Background
	sidebar.BackgroundColor3 = Theme.Surface
	statusLabel.TextColor3 = Theme.Accent
	stroke.Color = Theme.Accent
end

updateSelectedNPCIndex()
updateSelectedBossIndex()
applyTheme()

function doAutoReset15s()
	local char = player.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")

	pcall(function()
		clearSmoothHold()
	end)

	pcall(function()
		if hum then
			hum.Health = 0
		end
	end)

	pcall(function()
		if hum then
			hum:TakeDamage(math.huge)
		end
	end)

	pcall(function()
		char:BreakJoints()
	end)

	pcall(function()
		if root then
			root.CFrame = root.CFrame * CFrame.new(0, -500, 0)
		end
	end)
end


forceCharacterReset = function()
	local char = player.Character
	if not char then return false end

	pcall(function()
		clearSmoothHold()
	end)

	local hum = char:FindFirstChildOfClass("Humanoid")
	local root = char:FindFirstChild("HumanoidRootPart")

	local did = false

	pcall(function()
		if hum then
			hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
			hum:ChangeState(Enum.HumanoidStateType.Dead)
			hum.Health = 0
			did = true
		end
	end)

	pcall(function()
		if hum then
			hum:TakeDamage(999999999)
			did = true
		end
	end)

	pcall(function()
		char:BreakJoints()
		did = true
	end)

	pcall(function()
		if root then
			root:Destroy()
			did = true
		end
	end)

	pcall(function()
		player.Character = nil
	end)

	pcall(function()
		player:LoadCharacter()
		did = true
	end)

	return did
end

RunService.Heartbeat:Connect(function()
	if autoReset15s and os.clock() - reset15Last >= 15 then
		reset15Last = os.clock()
		setStatus("Reset 15s executado")
		if forceCharacterReset then
			forceCharacterReset()
		end
	end
end)


uiScale = Instance.new("UIScale")
uiScale.Parent = main
function updateScale()
	local camera = workspace.CurrentCamera
	local viewport = camera and camera.ViewportSize or Vector2.new(1280, 720)
	uiScale.Scale = math.clamp(math.min(viewport.X / 700, viewport.Y / 520), 0.72, 1)
end
updateScale()
if workspace.CurrentCamera then
	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
end

setPage("Main")
setStatus("OnyxHub V6 carregado • Multi NPC")
pcall(function()
	game:GetService("StarterGui"):SetCore("SendNotification", {
		Title = "OnyxHub V3",
		Text = "V6 Multi NPC + prioridade limpa",
		Duration = 4
	})
end)
print("OnyxHub V6 MULTI NPC carregado")
