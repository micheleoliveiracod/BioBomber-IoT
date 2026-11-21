-- Implementacao Fase 1 · criar e desenhar o agente (docs/licoes/fase01.md, passo 4)
-- jogo/agente.lua — célula efetora controlada pelo jogador.


local config = require("jogo.config")
local conversoes = require("jogo.conversoes")
local mapa = require("jogo.mapa")
local colisao = require("jogo.colisao")

local agente = {}

-- TODO 1.8 — Cria o agente na célula (c, l) e devolve uma tabela com os campos:
function agente.novo(c, l)
    return {
    c = c,                          
    l = l,                          
    vidas = config.VIDAS_INICIAIS,
    bombas = 1,
    alcance = 2,
    escudo = false,
    invencivel = 3,
}
end

-- TODO 1.9 — Desenha o agente. Use a cor de config.COR_AGENTE.
-- Dica: love.graphics.setColor(cor)  e  love.graphics.circle("fill", x, y, raio)
-- O centro da célula é: celula_para_pixel(c, tam) + tam / 2
function agente.desenhar(a, tam)
    -- 1. Centro da célula, em pixels
    local x = conversoes.celula_para_pixel(a.c, tam) + tam / 2
    local y = conversoes.celula_para_pixel(a.l, tam) + tam / 2

    -- 2. Cor do neutrófilo
    love.graphics.setColor(config.COR_AGENTE)

    -- 3. Corpo da célula
    love.graphics.circle("fill", x, y, tam * 0.4)

    -- 4. Núcleo com 3 lóbulos, como vemos na coloracao de gram
love.graphics.setColor(config.COR_NUCLEO_AGENTE)
local r = tam * 0.1
love.graphics.circle("fill", x - r * 1.6, y, r)
love.graphics.circle("fill", x,           y, r)
love.graphics.circle("fill", x + r * 1.6, y, r)
end

-- ===================== FASE 2 =====================
-- Implementacao Fase 2 · Lua: if / elseif / else  (docs/licoes/fase02.md, passos 3 e 4)

-- TODO 2.1 — Transforma a tecla apertada numa direção (dc, dl), usando if / elseif / else.
-- Cada direção aceita duas teclas (seta ou WASD), então eu junto as duas com "or":
--   "up" ou "w"    -> 0, -1
--   "down" ou "s"  -> 0,  1
--   "left" ou "a"  -> -1, 0
--   "right" ou "d" -> 1,  0
--   qualquer outra -> 0,  0
-- Em Lua uma função pode devolver dois valores de uma vez: return 0, -1
function agente.direcao(tecla)
    if tecla == "up" or tecla == "w" then
        return 0, -1
    elseif tecla == "down" or tecla == "s" then
        return 0, 1
    elseif tecla == "left" or tecla == "a" then
        return -1, 0
    elseif tecla == "right" or tecla == "d" then
        return 1, 0
    else
        return 0, 0
    end
end

-- TODO 2.2 — Move o defensor uma célula na direção (dc, dl), mas só se o caminho estiver livre.
-- Calculo o destino (a.c + dc, a.l + dl), vejo o que tem lá com mapa.tipo(m, c, l)
-- e pergunto ao colisao.pode_andar(tipo) se pode entrar.
-- Se puder, atualizo a.c e a.l e devolvo true. Se não, o defensor fica parado e devolvo false.
-- ("m" é o mapa carregado. Na fase 2 ele ainda é nil, mas o mapa.tipo provisório não liga para isso.)
function agente.mover(a, dc, dl, m)
    local nc, nl = a.c + dc, a.l + dl
    if colisao.pode_andar(mapa.tipo(m, nc, nl)) then
        a.c, a.l = nc, nl
        return true
    end
    return false
end

return agente