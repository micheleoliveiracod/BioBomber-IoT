-- Testes da fase 2. A fase está pronta quando todos passam.

-- Um mapa 15x13 só com bordas e pilares. Funciona com o mapa.tipo provisório,
-- que nem olha este parâmetro, e também com o mapa.tipo de verdade da fase 3.
local function mapa_de_pilares()
    local m = { colunas = 15, linhas = 13, celulas = {}, porta = { c = 0, l = 0, revelada = false } }
    for l = 1, 13 do
        m.celulas[l] = {}
        for c = 1, 15 do
            local parede = c == 1 or l == 1 or c == 15 or l == 13 or (c % 2 == 1 and l % 2 == 1)
            m.celulas[l][c] = parede and "parede" or "piso"
        end
    end
    return m
end

return {
    { "passo 1 · colisao.pode_andar", function(t)
        local col = require("jogo.colisao")
        t.igual(col.pode_andar("piso"), true, "piso")
        t.igual(col.pode_andar("porta"), true, "porta")
        t.igual(col.pode_andar("parede"), false, "parede")
        t.igual(col.pode_andar("biofilme"), false, "biofilme")
        t.igual(col.pode_andar("bomba"), false, "bomba")
        t.igual(col.pode_andar("sensor"), false, "sensor")
        t.igual(col.pode_andar(nil), false, "nil")
    end },
    { "passo 1 · colisao.dentro", function(t)
        local col = require("jogo.colisao")
        t.igual(col.dentro(1, 1, 15, 13), true)
        t.igual(col.dentro(15, 13, 15, 13), true)
        t.igual(col.dentro(0, 5, 15, 13), false)
        t.igual(col.dentro(16, 5, 15, 13), false)
        t.igual(col.dentro(5, 14, 15, 13), false)
    end },
    { "passo 3 · agente.direcao", function(t)
        local agente = require("jogo.agente")
        local dc, dl = agente.direcao("up");    t.igual(dc, 0); t.igual(dl, -1)
        dc, dl = agente.direcao("s");           t.igual(dc, 0); t.igual(dl, 1)
        dc, dl = agente.direcao("left");        t.igual(dc, -1); t.igual(dl, 0)
        dc, dl = agente.direcao("d");           t.igual(dc, 1); t.igual(dl, 0)
        dc, dl = agente.direcao("x");           t.igual(dc, 0); t.igual(dl, 0)
    end },
    { "passo 4 · agente.mover", function(t)
        local agente = require("jogo.agente")
        local a = agente.novo(2, 2)
        local m = mapa_de_pilares()
        t.igual(agente.mover(a, 1, 0, m), true, "andar para a direita")
        t.igual(a.c, 3, "coluna depois de andar")
        t.igual(agente.mover(a, 0, 1, m), false, "(3,3) é pilar")
        t.igual(a.l, 2, "não pode ter andado")
        a.c, a.l = 2, 2
        t.igual(agente.mover(a, 0, -1, m), false, "borda de cima")
    end },
    { "passo 2 · dano.explosao_em_inimigo", function(t)
        local dano = require("jogo.dano")
        t.igual(dano.explosao_em_inimigo("bacteria", 1), 0, "bacteria")
        t.igual(dano.explosao_em_inimigo("encapsulada", 2), 1, "encapsulada com 2")
        t.igual(dano.explosao_em_inimigo("encapsulada", 1), 0, "encapsulada com 1")
        t.igual(dano.explosao_em_inimigo("superbacteria", 6), 5, "superbacteria")
        t.igual(dano.explosao_em_inimigo("virus", 1), 0, "virus")
        t.igual(dano.explosao_em_inimigo("desconhecido", 3), 3, "tipo desconhecido")
        t.igual(dano.explosao_em_inimigo("encapsulada", 0), 0, "nunca negativo")
    end },
    { "passo 2 · dano.agente_atingido", function(t)
        local dano = require("jogo.dano")
        local a = { vidas = 2, escudo = true, invencivel = 0 }
        t.igual(dano.agente_atingido(a), "escudo")
        t.igual(a.escudo, false); t.igual(a.vidas, 2)
        t.igual(dano.agente_atingido(a), "invencivel")
        a.invencivel = 0
        t.igual(dano.agente_atingido(a), "perdeu_vida"); t.igual(a.vidas, 1)
        a.invencivel = 0
        t.igual(dano.agente_atingido(a), "fim"); t.igual(a.vidas, 0)
    end },
}
