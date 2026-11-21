-- Testes da fase 1. A fase está pronta quando todos passam.
return {
    { "passo 1 · config: números", function(t)
        local cfg = require("jogo.config")
        t.igual(cfg.TAM_CELULA, 40, "TAM_CELULA")
        t.igual(cfg.COLUNAS, 15, "COLUNAS")
        t.igual(cfg.LINHAS, 13, "LINHAS")
        t.igual(cfg.VIDAS_INICIAIS, 5, "VIDAS_INICIAIS")
        t.igual(cfg.PAVIO_BOMBA, 2.5, "PAVIO_BOMBA")
    end },
    { "passo 1 · config: string, boolean e tabela", function(t)
        local cfg = require("jogo.config")
        t.igual(type(cfg.NOME_AGENTE), "string", "tipo de NOME_AGENTE")
        t.igual(type(cfg.MOSTRAR_GRADE), "boolean", "tipo de MOSTRAR_GRADE")
        t.igual(type(cfg.COR_AGENTE), "table", "tipo de COR_AGENTE")
        t.igual(#cfg.COR_AGENTE, 3, "COR_AGENTE precisa de 3 números")
    end },
    { "passo 2 · celula_para_pixel", function(t)
        local conv = require("jogo.conversoes")
        t.igual(conv.celula_para_pixel(1, 40), 0)
        t.igual(conv.celula_para_pixel(3, 40), 80)
        t.igual(conv.celula_para_pixel(15, 40), 560)
    end },
    { "passo 2 · pixel_para_celula", function(t)
        local conv = require("jogo.conversoes")
        t.igual(conv.pixel_para_celula(0, 40), 1)
        t.igual(conv.pixel_para_celula(39, 40), 1)
        t.igual(conv.pixel_para_celula(85, 40), 3)
    end },
    { "passo 3 · formatar_tempo", function(t)
        local conv = require("jogo.conversoes")
        t.igual(conv.formatar_tempo(125), "02:05")
        t.igual(conv.formatar_tempo(59.9), "00:59")
        t.igual(conv.formatar_tempo(0), "00:00")
        t.igual(conv.formatar_tempo(600), "10:00")
    end },
    { "passo 3 · calcular_pontos", function(t)
        local conv = require("jogo.conversoes")
        t.igual(conv.calcular_pontos(3, 42.7, 2), 1720)
        t.igual(conv.calcular_pontos(0, 0, 0), 0)
    end },
    { "passo 4 · agente.novo", function(t)
        local agente = require("jogo.agente")
        local a = agente.novo(2, 2)
        t.igual(a.c, 2, "c")
        t.igual(a.l, 2, "l")
        t.igual(a.vidas, 5, "vidas")
        t.igual(a.bombas, 1, "bombas")
        t.igual(a.alcance, 2, "alcance")
        t.igual(a.escudo, false, "escudo")
        t.igual(a.invencivel, 3, "invencivel")
    end },
}
