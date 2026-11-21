-- Implementacao Fase 2 · Lua: if / elseif / else  (docs/licoes/fase02.md, passo 2)
--
-- Informacoes:
-- jogo/dano.lua — o que acontece quando a explosão de anticorpos acerta alguém.
-- Nem todo inimigo morre com uma explosão só. A bactéria encapsulada tem uma cápsula de açúcar que esconde ela do sistema imune, então primeiro os anticorpos marcam a cápsula (opsonização) e só depois ela é destruída. No jogo isso vira: duas explosões.

local dano = {}

-- TODO 2.5 — Quanta vida o inimigo tem depois de levar uma explosão?
--   "encapsulada" e "superbacteria" -> perdem 1 de vida (vida - 1)
--   "bacteria", "levedura", "broto", "influenza", "colonia",
--   "cancer", "fungo", "toxina", "virus"  -> morrem na hora (0)
--   qualquer outro tipo -> a vida fica como estava
-- A vida nunca pode ficar negativa. Para isso eu uso math.max(0, ...).
function dano.explosao_em_inimigo(tipo, vida)
    if tipo == "encapsulada" or tipo == "superbacteria" then
        return math.max(0, vida - 1)
    elseif tipo == "bacteria" or tipo == "levedura" or tipo == "broto" or tipo == "influenza"
        or tipo == "colonia" or tipo == "cancer" or tipo == "fungo" or tipo == "toxina"
        or tipo == "virus" then
        return 0
    else
        return vida
    end
end

-- TODO 2.6 — O defensor foi atingido. "a" é a tabela que o agente.novo cria.
-- Eu mudo a tabela "a" e devolvo um texto contando o que aconteceu.
-- A ordem dos if aqui é a regra do jogo, então ela importa:
--   se a.invencivel > 0           -> nada muda,                         devolve "invencivel"
--   senão, se a.escudo for true   -> a.escudo = false, a.invencivel = 1,  devolve "escudo"
--   senão                         -> a.vidas = a.vidas - 1, a.invencivel = 2
--        se a.vidas chegou a 0    -> devolve "fim"
--        senão                    -> devolve "perdeu_vida"
function dano.agente_atingido(a)
    if a.invencivel > 0 then
        return "invencivel"
    elseif a.escudo then
        a.escudo = false
        a.invencivel = 1
        return "escudo"
    else
        a.vidas = a.vidas - 1
        a.invencivel = 2
        if a.vidas <= 0 then
            return "fim"
        else
            return "perdeu_vida"
        end
    end
end

return dano
