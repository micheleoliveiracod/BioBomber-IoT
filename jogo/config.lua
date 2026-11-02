-- Implementacao Fase 1 · Lua: variáveis e tipos  (docs/licoes/fase01.md, passo 1)

-- Informacoes:
-- jogo/config.lua — Configuracao de números e textos fixos do jogo, de modo que ao mudar algum valor, o jogo se atualize automaticamente.
-- Os nomes em MAIÚSCULAS indicam que são constantes, ou seja, valores que não mudam durante a execução do jogo.
-- O LÖVE mede cada canal (vermelho, verde, azul) de 0 (nada) a 1 (máximo). Então { 0.2, 0.8, 1.0 } é pouco vermelho, bastante verde e azul no máximo, o que dá um azul-claro. { 1, 1, 1 } é branco e { 0, 0, 0 } é preto.
-- Assim cada arquivo vira um módulo, uma caixa com coisas dentro que outro arquivo pode pegar. O local faz a variável existir só dentro deste arquivo, sem "vazar" e colidir com nomes de outros arquivos.


local config = {} -- cria uma tabela vazia, que vai guardar as constantes do jogo

-- TODO 1.1 — números (number)
config.TAM_CELULA = 40      -- tamanho de cada célula em pixels
config.COLUNAS = 15          -- colunas do mapa
config.LINHAS = 13           -- linhas do mapa
config.VIDAS_INICIAIS = 5    -- vidas do agente no começo
config.PAVIO_BOMBA = 2.5     -- segundos até a bomba explodir

-- TODO 1.2 — texto (string) e verdadeiro/falso (boolean)
config.NOME_AGENTE = "Neutrolino"      -- nome da célula efetora, entre aspas
config.MOSTRAR_GRADE = true    -- liga a grade (booleano: true ou false)

-- TODO 1.3 — tabela (table) com 3 números de 0 a 1: { vermelho, verde, azul }
config.COR_CHAO     = { 0.35, 0.02, 0.06 }  -- plasma: vermelho-escuro (interior do vaso sanguineo)
config.COR_PAREDE   = { 0.75, 0.35, 0.40 }  -- parede do vaso (endotélio) rosa-carne
config.COR_AGENTE   = { 0.92, 0.90, 1.00 }  -- Neutrófilo branco-lilás
config.COR_BOMBA    = { 1.00, 0.85, 0.20 }  -- cápsula de anticorpos dourado
config.COR_EXPLOSAO = { 0.60, 0.95, 1.00 }  -- liberação de anticorpos ciano-claro

return config -- entrega a tabela para quando este arquivo for chamado
