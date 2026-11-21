-- niveis/nivel01.lua: os dados da fase 1.
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
    numero = 1,
    nome = "Primeira defesa",
    local_corpo = "Ferida na pele",
    regiao = "pele",        -- usado nos tópicos IoT: biobomber/pele/...
    defensor = "Neutrófilo",
    ameaca = "Bactéria",
    descricao = "Bactérias entraram por um corte. Elas andam ao acaso e morrem com uma explosão de anticorpos. Elimine todas e ache a saída escondida no biofilme.",
    imunologia = "Imunidade inata: o neutrófilo é a primeira célula de defesa a chegar numa infecção e destrói bactérias.",
    tempo = 180,
    iot = false,
    mapa = {
        "###############",
        "#P..%..%......#",
        "#.#.#.#%#.#.#.#",
        "#....%...%.b..#",
        "#.#.#%#.#.#.#%#",
        "#.%..%.b.%%..%#",
        "#.#.#%#.#.#.#.#",
        "#.%%.%.%..%%..#",
        "#%#.#.#.#%#%#%#",
        "#..%.b..%.%E%.#",
        "#.#%#.#.#.#.#.#",
        "#%.%......%%..#",
        "###############",
    },
}
