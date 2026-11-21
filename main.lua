-- main.lua: é por aqui que o LÖVE (versão 11.5) começa a rodar o BioBomber.
-- Este arquivo carrega a fase, recarrega o código com F5, desenha o painel e roda os testes.

-- Todos os módulos do jogo ficam na tabela J. É assim que o F5 consegue recarregar tudo.
local J = {}

-- Tudo o que muda durante a partida fica guardado aqui.
local estado = {
    nivel = 1,          -- fase atual (de 1 a 10)
    dados = nil,        -- o que foi lido de niveis/nivelNN.lua
    tempo = 0,          -- segundos restantes
    pontos = 0,
    eliminados = 0,
    agente = nil,       -- FASE 1
    resultado_testes = nil,
    erro = nil,         -- mensagem de quando algum módulo não carrega
}

local function carregar_modulos()
    J.ui = require("jogo.ui")
    J.testes = require("testes.rodar")

    -- >>> FASE 1 (docs/licoes/fase01.md, passo 5): carregue config, conversoes e agente
    J.config = require("jogo.config")
    J.conversoes = require("jogo.conversoes")
    J.agente = require("jogo.agente")
end

local function carregar_nivel(n)
    estado.nivel = n
    estado.dados = require(string.format("niveis.nivel%02d", n))
    estado.resultado_testes = J.testes.resultado(n)

    -- >>> FASE 1 (passo 5): crie o agente e comece o relógio da fase
    estado.agente = J.agente.novo(2, 2)
    estado.tempo = estado.dados.tempo

end

-- Carrega os módulos. Se der erro, a mensagem aparece na tela e o jogo não fecha.
local function iniciar()
    package.loaded["jogo.ui"] = nil
    local ok, erro = pcall(function()
        carregar_modulos()
        carregar_nivel(estado.nivel)
    end)
    estado.erro = (not ok) and tostring(erro) or nil
end

-- O F5 recarrega o código sem precisar fechar o jogo.
local function recarregar()
    for nome in pairs(package.loaded) do
        if nome:match("^jogo%.") or nome:match("^niveis%.") or nome:match("^testes%.") then
            package.loaded[nome] = nil
        end
    end
    iniciar()
end

function love.load(args)
    -- Modo de teste: "lovec . --teste 3" roda os testes da fase 3 e fecha o jogo.
    for i, a in ipairs(args) do
        if a == "--teste" then
            local falhas = require("testes.rodar").executar(tonumber(args[i + 1]))
            love.event.quit(falhas == 0 and 0 or 1)
            return
        end
    end
    love.graphics.setDefaultFilter("nearest", "nearest")
    iniciar()
end

function love.update(dt)
    if not love.window or estado.erro then return end

    -- >>> FASE 1 (passo 6): desconte o tempo da fase
    estado.tempo = math.max(0, estado.tempo - dt)

end

function love.keypressed(tecla)
    if tecla == "f5" then recarregar() return end
    if tecla == "escape" then love.event.quit() return end
    if tecla == "pageup" and estado.nivel < 10 then estado.nivel = estado.nivel + 1 iniciar() return end
    if tecla == "pagedown" and estado.nivel > 1 then estado.nivel = estado.nivel - 1 iniciar() return end
    if estado.erro then return end
end

function love.draw()
    J.ui.fundo()
    if estado.erro then
        J.ui.erro(estado.erro)
        return
    end

    love.graphics.push()
    love.graphics.translate(0, J.ui.TOPO)   -- o mapa começa abaixo da faixa do topo

    -- >>> FASE 1 (passo 7): desenhe o agente
    J.agente.desenhar(estado.agente, J.config.TAM_CELULA)

    love.graphics.pop()

    J.ui.topo(estado)
    J.ui.painel_lateral(estado)
end
