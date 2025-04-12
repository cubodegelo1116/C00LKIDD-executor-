-- c00lkidd-style fake executor
local executor = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local title = Instance.new("TextLabel")
local closeBtn = Instance.new("TextButton")
local executeBtn = Instance.new("TextButton")
local clearBtn = Instance.new("TextButton")
local scriptBox = Instance.new("TextBox")

executor.Name = "FakeExecutor"
executor.Parent = game.CoreGui
executor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

main.Name = "Main"
main.Parent = executor
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.Size = UDim2.new(0, 400, 0, 250)
main.Active = true
main.Draggable = true -- permite arrastar

title.Name = "Title"
title.Parent = main
title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
title.Size = UDim2.new(1, 0, 0, 30)
title.Font = Enum.Font.SourceSansBold
title.Text = "c00lkidd EXECUTOR"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20

closeBtn.Name = "CloseBtn"
closeBtn.Parent = main
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 18
closeBtn.MouseButton1Click:Connect(function()
	executor:Destroy()
end)

scriptBox.Name = "ScriptBox"
scriptBox.Parent = main
scriptBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scriptBox.Position = UDim2.new(0, 10, 0, 40)
scriptBox.Size = UDim2.new(1, -20, 0, 150)
scriptBox.Font = Enum.Font.Code
scriptBox.PlaceholderText = "-- Escreva seu script aqui"
scriptBox.Text = ""
scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptBox.TextSize = 16
scriptBox.ClearTextOnFocus = false
scriptBox.MultiLine = true
scriptBox.TextWrapped = true
scriptBox.TextXAlignment = Enum.TextXAlignment.Left
scriptBox.TextYAlignment = Enum.TextYAlignment.Top

executeBtn.Name = "ExecuteBtn"
executeBtn.Parent = main
executeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
executeBtn.Position = UDim2.new(0.6, 0, 1, -40)
executeBtn.Size = UDim2.new(0.3, 0, 0, 30)
executeBtn.Font = Enum.Font.SourceSansBold
executeBtn.Text = "Executar"
executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
executeBtn.TextSize = 18
executeBtn.MouseButton1Click:Connect(function()
	local code = scriptBox.Text
	local success, err = pcall(function()
		loadstring(code)()
	end)
	if not success then
		warn("Erro ao executar: " .. err)
	end
end)

clearBtn.Name = "ClearBtn"
clearBtn.Parent = main
clearBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
clearBtn.Position = UDim2.new(0.3, 0, 1, -40)
clearBtn.Size = UDim2.new(0.3, 0, 0, 30)
clearBtn.Font = Enum.Font.SourceSansBold
clearBtn.Text = "Limpar"
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.TextSize = 18
clearBtn.MouseButton1Click:Connect(function()
	scriptBox.Text = ""
end)
