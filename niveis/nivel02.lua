-- niveis/nivel02.lua: os dados da fase 2.
-- Você pode mudar o mapa à vontade, mas ele precisa ter 15 colunas e 13 linhas.
--
-- O que cada símbolo do mapa quer dizer (o mapa é um pedaço do corpo humano):
--   #  tecido (não quebra)              %  biofilme / muco (a explosão destrói)
--   .  caminho livre                    P  início do defensor
--   E  saída (fica escondida embaixo do biofilme)
--   S  nanossensor IoT (fases 4 a 10)
--   b bactéria  e bactéria encapsulada  l levedura  i influenza  c colônia
--   m célula cancerígena  u fungo  o toxina  v vírus  X superbactéria

return {
    numero = 2,
    nome = "Cápsula protetora",
    local_corpo = "Corrente sanguínea",
    regiao = "sangue",        -- usado nos tópicos IoT: biobomber/sangue/...
    defensor = "Neutrófilo",
    ameaca = "Bactéria encapsulada",
    descricao = "A cápsula de açúcar esconde a bactéria das defesas: precisa de DUAS explosões. As bactérias comuns continuam por aí.",
    imunologia = "Algumas bactérias têm cápsula. Anticorpos marcam a cápsula (opsonização) para o fagócito conseguir destruí-las.",
    tempo = 180,
    iot = false,
    mapa = {
        "###############",
        "#P...%%..b....#",
        "#.#.#%#%#.#.#.#",
        "#...%...%.....#",
        "#.#%#.#%#.#.#.#",
        "#%..%..%...e..#",
        "#.#%#.#.#.#.#.#",
        "#.%%.e....%.%E#",
        "#%#.#.#.#.#%#.#",
        "#%.%.%%.%%%...#",
        "#%#.#.#.#.#.#%#",
        "#...%%.e......#",
        "###############",
    },
}
