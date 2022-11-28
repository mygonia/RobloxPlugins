local ChangeHistoryService = game:GetService("ChangeHistoryService")
local Selection = game:GetService("Selection")

local toolbar = plugin:CreateToolbar("Organize Assets")

local newScriptButton = toolbar:CreateButton("Organize Asset Pack", "Organizes the packs in folders in the workspace", "rbxassetid://136534658")

newScriptButton.ClickableWhenViewportHidden = true

local function randomize()
	local baseplate = game.Workspace.Baseplate
	
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("MeshPart") then
			part.Position = Vector3.new((math.random() - 0.5) * baseplate.Size.X,
				10,
				(math.random() - 0.5) * baseplate.Size.Z)
		end
	end
end

local function organize()
	local currentX = -1024
	local currentZ = -1024

	local assetPack = game.Workspace:FindFirstChild("AssetPack")
	
	if assetPack then
		for _, v in pairs(assetPack:GetDescendants()) do
			if v:IsA("Folder") then
				local largestZ = 0
				local lastMesh
				for _, mesh in pairs(v:GetChildren()) do
					if mesh:IsA("MeshPart") then
						if lastMesh then
							currentX = lastMesh.Position.X + lastMesh.Size.X
						else
							currentX = -1024
						end
						local finalPosition = Vector3.new(currentX + mesh.Size.X, 20, currentZ + largestZ + mesh.Size.Z)
						mesh.Position = finalPosition

						if mesh:IsA("MeshPart") then
							if mesh.Size.Z > largestZ then
								largestZ = mesh.Size.Z
							end
						end
						lastMesh = mesh
					end
				end
				currentZ = currentZ + largestZ
				wait()
			end
		end
	end
end

local function onNewScriptButtonClicked()
	organize()
end

newScriptButton.Click:Connect(onNewScriptButtonClicked)
