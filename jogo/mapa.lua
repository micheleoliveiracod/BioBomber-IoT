-- Implementacao Fase 2 e 3 · Lua: laços (for) e tabelas  (docs/licoes/fase03.md, passos 1 e 2)
--
-- Informacoes:
-- jogo/mapa.lua — a grade do tecido, um pedaço do corpo humano.
-- Na fase 2 ainda não existe mapa de verdade, mas o defensor já precisa esbarrar em alguma coisa. Por isso aqui só tem uma versão provisória do mapa.tipo.

local mapa = {}

-- mapa.tipo provisório: as bordas e os pilares (coluna e linha ímpares) são parede, o resto é piso.
-- Ele ignora o "m" porque ainda não tem mapa carregado. Na fase 3 eu apago esta função e escrevo a versão de verdade (TODO 3.2).
function mapa.tipo(m, c, l)
    if c <= 1 or l <= 1 or c >= 15 or l >= 13 then return "parede" end
    if c % 2 == 1 and l % 2 == 1 then return "parede" end
    return "piso"
end

return mapa
