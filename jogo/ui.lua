-- jogo/ui.lua: desenha a faixa do topo, o painel lateral com as instruções da fase
-- e as mensagens de erro. Este arquivo já vem pronto.

local ui = {}

ui.TOPO = 60          -- altura da faixa do topo, em pixels
ui.PAINEL_X = 600     -- onde começa o painel lateral (à direita do mapa)
ui.LARGURA = 960
ui.ALTURA = 580

local function texto(t, x, y, cor)
    love.graphics.setColor(cor or { 1, 1, 1 })
    love.graphics.print(t, x, y)
end

-- Usa conversoes.formatar_tempo (da fase 1) quando ela já estiver escrita.
-- Enquanto não estiver, mostra "--:--".
local function tempo_formatado(segundos)
    local ok, conv = pcall(require, "jogo.conversoes")
    if ok and type(conv.formatar_tempo) == "function" then
        local ok2, s = pcall(conv.formatar_tempo, segundos)
        if ok2 and type(s) == "string" then return s end
    end
    return "--:--"
end

function ui.fundo()
    love.graphics.clear(0.08, 0.09, 0.11)
end

-- Mostra o erro de quando um módulo não carrega (por exemplo, quando falta um "end").
function ui.erro(mensagem)
    texto("Erro ao carregar um dos módulos:", 20, 20, { 1, 0.6, 0.6 })
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(mensagem, 20, 50, ui.LARGURA - 40)
    texto("Após a correção, F5 recarrega os módulos.", 20, ui.ALTURA - 40, { 0.6, 0.9, 1 })
end

function ui.topo(estado)
    love.graphics.setColor(0.13, 0.15, 0.19)
    love.graphics.rectangle("fill", 0, 0, ui.LARGURA, ui.TOPO)
    local d = estado.dados or {}
    texto(string.format("BioBomber  |  Fase %d: %s", estado.nivel, d.nome or "?"), 12, 10, { 0.6, 0.9, 1 })
    local vidas = estado.agente and estado.agente.vidas or "-"
    texto(string.format("Tempo %s    Pontos %s    Vidas %s",
        tempo_formatado(estado.tempo or 0), tostring(estado.pontos or 0), tostring(vidas)), 12, 34)
end

function ui.painel_lateral(estado)
    local x, y = ui.PAINEL_X + 16, ui.TOPO + 12
    love.graphics.setColor(0.11, 0.12, 0.15)
    love.graphics.rectangle("fill", ui.PAINEL_X, ui.TOPO, ui.LARGURA - ui.PAINEL_X, ui.ALTURA - ui.TOPO)

    local d = estado.dados or {}
    texto("Local: " .. (d.local_corpo or "?"), x, y, { 0.6, 0.9, 1 })
    texto("Defensor: " .. (d.defensor or "?"), x, y + 18, { 0.5, 1, 0.6 })
    texto("Ameaça: " .. (d.ameaca or "?"), x, y + 36, { 1, 0.75, 0.4 })
    love.graphics.setColor(0.85, 0.85, 0.85)
    love.graphics.printf(d.descricao or "", x, y + 58, 330)
    love.graphics.setColor(0.75, 0.8, 1)
    love.graphics.printf("Imunologia: " .. (d.imunologia or ""), x, y + 128, 330)

    local r = estado.resultado_testes
    local ty = y + 190
    if r then
        local cor = (r.passou == r.total and r.total > 0) and { 0.5, 1, 0.5 } or { 1, 0.6, 0.6 }
        texto(string.format("Testes da fase %d: %d/%d", estado.nivel, r.passou, r.total), x, ty, cor)
        if r.primeira_falha then
            love.graphics.setColor(1, 0.7, 0.7)
            love.graphics.printf("Primeira falha: " .. r.primeira_falha, x, ty + 18, 330)
        end
    end

    texto(string.format("Lição: docs/licoes/fase%02d.md", estado.nivel), x, ty + 56, { 0.6, 0.9, 1 })
    texto("F5 recarrega  |  PgUp/PgDn troca de fase", x, ui.ALTURA - 50, { 0.6, 0.6, 0.6 })
    texto("Setas/WASD andam  |  Espaço = bomba", x, ui.ALTURA - 30, { 0.6, 0.6, 0.6 })
end

return ui
