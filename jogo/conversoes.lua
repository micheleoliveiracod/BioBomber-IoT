-- Implementacao Fase 1 · Lua: aritmética e funções simples  (docs/licoes/fase01.md, passos 2 e 3)
--
-- Informacoes:
-- jogo/conversoes.lua — determina contas simples usadas pelo jogo todo.
-- O objetivo deste arquivo é guardar funções simples que fazem contas usadas pelo jogo todo. Por exemplo, converter a coluna de uma célula em pixel, ou calcular a pontuação ao terminar uma fase.
-- O motivo é que o mapa pensa em células (coluna 3, linha 5), como um tabuleiro de xadrez (eu amo xadrez, é um dos meus jogos favoritos). A tela pensa em pixels. Eu preciso traduzir de um para o outro.
-- Operadores úteis: +  -  *  /  %  (resto)   math.floor(x) (arredonda para baixo)
-- string.format("%02d", 5) devolve "05".

-- Região	                             Conta	                        Pixels
-- Largura do mapa	                     15 colunas × 40	            600
-- Painel lateral(monitor do paciente)	 960 − 600	                    360
-- Faixa do topo(tempo, pontos, vidas) 	 —	                            60
-- Altura do mapa	                     13 linhas × 40	                520
-- Altura total	                         60 + 520	                    580

local conversoes = {}

-- TODO 1.4: celula_para_pixel
-- A célula 1 começa no pixel 0, a célula 2 no pixel 40, a célula 3 no pixel 80. Ou seja, cada célula “pula” tam pixels, mas a contagem parte do zero. Conta (celula - 1) * tamanho
-- Exemplo: celula_para_pixel(3, 40) == 80
function conversoes.celula_para_pixel(celula, tam)
    return 0
end

-- TODO 1.5 — O caminho inverso: em qual célula está um pixel?
-- Divida o pixel pelo tamanho, descarte a parte decimal e some 1. math.floor(pixel / tam) + 1
-- Exemplo: pixel_para_celula(85, 40) == 3   e   pixel_para_celula(0, 40) == 1
function conversoes.pixel_para_celula(pixel, tam)
    return 0
end

-- TODO 1.6 — Formata segundos como "mm:ss".
-- Exemplos: 125 -> "02:05"   59.9 -> "00:59"   0 -> "00:00"
-- minutos: math.floor(segundos / 60)
-- Os segundos que sobram: math.floor(segundos % 60). O % é o resto da divisão.
-- montar o texto: string.format("%02d:%02d", minutos, resto). O %02d escreve o número com 2 dígitos e completa com zero à esquerda: 5 vira "05".

function conversoes.formatar_tempo(segundos)
    return "00:00"
end

-- TODO 1.7 — Pontuação ao terminar uma fase:
--   100 por contaminante eliminado
-- + 10 por segundo inteiro que sobrou
-- + 500 por vida restante
-- Exemplo: calcular_pontos(3, 42.7, 2) == 300 + 420 + 1000 == 1720
function conversoes.calcular_pontos(eliminados, tempo_restante, vidas)
    return 0
end

return conversoes
