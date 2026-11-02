--   Implementacao Fase 1 · criar e desenhar o agente   (docs/licoes/fase01.md, passo 4)
-- jogo/agente.lua — célula efetora controlada pelo jogador.
-- 

local config = require("jogo.config")
local conversoes = require("jogo.conversoes")

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
return agente