-- Implementacao Fase 2 · Lua: if / elseif / operadores lógicos  (docs/licoes/fase02.md, passo 1)
--
-- Informacoes:
-- jogo/colisao.lua — decide por onde o defensor pode andar.
-- O neutrófilo anda pelo tecido, mas não atravessa parede, biofilme, bomba nem sensor. Aqui eu respondo duas perguntas: dá para entrar nessa célula? E essa célula fica dentro do mapa?

local colisao = {}

-- TODO 2.3 — O defensor pode entrar numa célula desse tipo?
-- Só dá para andar no "piso" e na "porta" (depois que ela aparece).
-- Todo o resto bloqueia: "parede", "biofilme", "bomba", "sensor" e até nil.
-- Ou seja, se for piso ou porta devolve true, senão devolve false.
function colisao.pode_andar(tipo)
    if tipo == "piso" or tipo == "porta" then
        return true
    end
    return false
end

-- TODO 2.4 — A célula (c, l) fica dentro do mapa?
-- Ela está dentro quando 1 <= c <= colunas e 1 <= l <= linhas. Dá para escrever tudo numa linha só com "and".
function colisao.dentro(c, l, colunas, linhas)
    return c >= 1 and c <= colunas and l >= 1 and l <= linhas
end

return colisao
