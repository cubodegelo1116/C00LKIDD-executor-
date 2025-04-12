local HttpService = game:GetService("HttpService")

-- Funções úteis pra salvar e ler scripts
local function salvarScript(nome, conteudo)
    local scripts = {}
    pcall(function()
        scripts = HttpService:JSONDecode(readfile("saved_scripts.json"))
    end)
    
    -- Se o script já existir, não substitua
    if not scripts[nome] then
        scripts[nome] = conteudo
        writefile("saved_scripts.json", HttpService:JSONEncode(scripts))
    else
        warn("O script com esse nome já existe!")
    end
end

local function lerScripts()
    local scripts = {}
    pcall(function()
        scripts = HttpService:JSONDecode(readfile("saved_scripts.json"))
    end)
    return scripts
end

-- GUI principal
local executor = Instance.new("ScreenGui")
executor.Name = "FakeExecutor"
executor.Parent = game.CoreGui
executor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
executor.ResetOnSpawn = false

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 250)
main.Position = UDim2.new(0.3, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Parent = executor
main.Active = true
main.Draggable = true

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
title.Text = "c00lkidd EXECUTOR"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.Font = Enum.Font.SourceSansBold
title.Parent = main

-- Botão de fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -30, 0, 0)
closeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
closeBtn.Text = "X"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.TextSize = 18
closeBtn.Parent = main

-- Botão de minimizar
local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -60, 0, 0)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.TextSize = 18
minimizeBtn.Parent = main

-- Botão flutuante (quando minimiza)
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 100, 0, 30)
floatBtn.Position = UDim2.new(0.5, 0, 0.5, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
floatBtn.Text = "Abrir"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.SourceSansBold
floatBtn.TextSize = 18
floatBtn.Parent = executor
floatBtn.Visible = false
floatBtn.Active = true
floatBtn.Draggable = true

floatBtn.MouseButton1Click:Connect(function()
	main.Visible = true
	floatBtn.Visible = false
end)

minimizeBtn.MouseButton1Click:Connect(function()
	main.Visible = false
	floatBtn.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
	executor:Destroy()
end)

-- ScriptBox
local scriptBox = Instance.new("TextBox")
scriptBox.Size = UDim2.new(1, -20, 0, 150)
scriptBox.Position = UDim2.new(0, 10, 0, 40)
scriptBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
scriptBox.Text = ""
scriptBox.TextColor3 = Color3.fromRGB(255, 255, 255)
scriptBox.Font = Enum.Font.Code
scriptBox.TextSize = 16
scriptBox.MultiLine = true
scriptBox.ClearTextOnFocus = false
scriptBox.TextWrapped = true
scriptBox.TextXAlignment = Enum.TextXAlignment.Left
scriptBox.TextYAlignment = Enum.TextYAlignment.Top
scriptBox.PlaceholderText = "--feito por cubodegelo1116"
scriptBox.Parent = main

-- Botões de baixo
local salvarBtn = Instance.new("TextButton")
salvarBtn.Size = UDim2.new(0.3, 0, 0, 30)
salvarBtn.Position = UDim2.new(0, 10, 1, -40)
salvarBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
salvarBtn.Text = "Salvar"
salvarBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
salvarBtn.Font = Enum.Font.SourceSansBold
salvarBtn.TextSize = 18
salvarBtn.Parent = main

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0.3, 0, 0, 30)
clearBtn.Position = UDim2.new(0.35, 10, 1, -40)
clearBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
clearBtn.Text = "Limpar"
clearBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
clearBtn.Font = Enum.Font.SourceSansBold
clearBtn.TextSize = 18
clearBtn.Parent = main

local executeBtn = Instance.new("TextButton")
executeBtn.Size = UDim2.new(0.3, 0, 0, 30)
executeBtn.Position = UDim2.new(0.7, -10, 1, -40)
executeBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
executeBtn.Text = "Executar"
executeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
executeBtn.Font = Enum.Font.SourceSansBold
executeBtn.TextSize = 18
executeBtn.Parent = main

-- Funções dos botões
executeBtn.MouseButton1Click:Connect(function()
	local code = scriptBox.Text
	local s, e = pcall(function()
		loadstring(code)()
	end)
	if not s then warn("Erro ao executar: "..e) end
end)

clearBtn.MouseButton1Click:Connect(function()
	scriptBox.Text = ""
end)

salvarBtn.MouseButton1Click:Connect(function()
	local nome = "Script_" .. os.date("%Y-%m-%d_%H-%M-%S")
	salvarScript(nome, scriptBox.Text)
	atualizarAbaSalvos()
end)

-- Aba lateral com scripts salvos
local abaSalvos = Instance.new("ScrollingFrame")
abaSalvos.Size = UDim2.new(0, 120, 0, 250)
abaSalvos.Position = UDim2.new(-0.3, -10, 0, 0)
abaSalvos.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
abaSalvos.ScrollBarThickness = 6
abaSalvos.Parent = main
abaSalvos.CanvasSize = UDim2.new(0, 0, 0, 0)

local function atualizarAbaSalvos()
	abaSalvos:ClearAllChildren()
	local scripts = lerScripts()
	local y = 0
	for nome, conteudo in pairs(scripts) do
		-- Botão de carregar script
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(0.7, -5, 0, 30)
		btn.Position = UDim2.new(0, 5, 0, y)
		btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		btn.Text = nome
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.SourceSansBold
		btn.TextSize = 14
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.Parent = abaSalvos

		btn.MouseButton1Click:Connect(function()
			scriptBox.Text = conteudo
		end)

		-- Botão de deletar
		local delBtn = Instance.new("TextButton")
		delBtn.Size = UDim2.new(0.3, -10, 0, 30)
		delBtn.Position = UDim2.new(0.7, 5, 0, y)
		delBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
		delBtn.Text = "X"
		delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		delBtn.Font = Enum.Font.SourceSansBold
		delBtn.TextSize = 14
		delBtn.Parent = abaSalvos

		delBtn.MouseButton1Click:Connect(function()
			scripts[nome] = nil
			writefile("saved_scripts.json", HttpService:JSONEncode(scripts))
			atualizarAbaSalvos()
		end)

		y = y + 35
	end
	abaSalvos.CanvasSize = UDim2.new(0, 0, 0, y + 10)
end

atualizarAbaSalvos()

-- Atualiza aba quando salvar
salvarBtn.MouseButton1Click:Connect(atualizarAbaSalvos)
