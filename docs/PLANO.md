# BioBomber: Plano do projeto

## 1. Objetivo
Desenvolver, de forma incremental, um jogo no estilo Bomberman que sirva de base para o
estudo de três áreas:
- programação em Lua, C e C++;
- fundamentos de Internet das Coisas;
- conceitos de imunologia.

## 2. Domínio de aplicação
O cenário é o organismo humano sob agressão infecciosa ou neoplásica.
- **Fases:** cada fase corresponde a um sítio anatômico e a uma célula efetora da resposta imune.
- **Ataque:** cápsulas de anticorpos com propagação cruciforme. Elas removem obstáculos (biofilme e muco) e eliminam os agentes agressores.
- **Barreiras:** as paredes de tecido não são destrutíveis.
- **Saída:** fica oculta sob o biofilme e só é liberada após a eliminação de todos os agentes.

## 3. Linguagens e arquitetura

| Camada | Tecnologia | Responsabilidade | Fases |
|---|---|---|---|
| Aplicação | Lua 5.1 (LuaJIT), framework LÖVE 11.5 | Laço de jogo, mapa, entidades, interface | 1 a 4 |
| Biblioteca nativa | C (C11) | Processamento de sinais dos sensores, estatística, gêmeo digital, serialização e protocolo | 5 a 9 |
| Biblioteca nativa | C++ (C++17) | Correspondência de tópicos MQTT com curingas e alarmes com histerese | 10 |

- **Integração:** o Lua acessa a biblioteca `biobomber.dll` por meio da FFI do LuaJIT.
- **Compilação:** a biblioteca é compilada com o MSYS2 (gcc/g++).
- **IoT:** a camada de IoT é inteiramente simulada, sem dispositivos físicos.

## 4. Fases

| Fase | Sítio anatômico | Célula efetora | Agente agressor | Conteúdo de programação | Conteúdo de IoT |
|---|---|---|---|---|---|
| 1 | Lesão cutânea | Neutrófilo | Bactéria (movimento aleatório) | Variáveis, tipos e aritmética (Lua) | — |
| 2 | Corrente sanguínea | Neutrófilo | Bactéria encapsulada (dupla resistência) | Estruturas condicionais (Lua) | — |
| 3 | Mucosa orofaríngea | Macrófago | Levedura *Candida* (brotamento) | Estruturas de repetição e tabelas (Lua) | — |
| 4 | Pulmões | Macrófago | Vírus influenza (perseguição) | Strings, funções e orientação a objetos (Lua) | Nanossensores e publish/subscribe |
| 5 | Corrente sanguínea (sepse) | Neutrófilo | Colônia bacteriana (crescimento exponencial) | Tipos, operadores e funções (C) | Conversão analógico-digital |
| 6 | Tecido com lesão neoplásica inicial | Célula NK | Célula neoplásica (não visível) | Vetores e laços (C) | Ruído de medição e critério de 3σ |
| 7 | Seios paranasais | Macrófago | Fungo *Aspergillus* (expansão de biofilme) | Ponteiros e estruturas (C) | Gêmeo digital |
| 8 | Tecido muscular | Linfócito B | Toxina (estacionária, não visível) | Strings e buffers (C) | Serialização JSON |
| 9 | Linfonodo (pós-vacinação) | Linfócito B de memória | Surto viral (enxame) | Operações bit a bit (C) | Estrutura do pacote MQTT |
| 10 | Infecção sistêmica | Resposta imune integrada | Superbactéria multirresistente | Classes e `std::string` (C++) | Curingas de tópico e histerese |

**Conteúdo de imunologia por fase:**
1. Imunidade inata e o papel do neutrófilo.
2. Cápsula bacteriana e opsonização.
3. Fagocitose por macrófagos e microbiota oportunista.
4. Infecção viral e sinalização por interferon.
5. Sepse e dinâmica de crescimento bacteriano.
6. Imunovigilância tumoral por células NK e linfócitos T citotóxicos.
7. Infecção fúngica filamentosa.
8. Neutralização de toxinas por anticorpos.
9. Vacinação e memória imunológica.
10. Integração da resposta inata e adaptativa frente à resistência antimicrobiana.

## 5. Metodologia
- **Roteiro:** cada fase possui um roteiro de estudo (`docs/licoes/faseNN.md`), dividido em etapas curtas.
- **Testes:** cada etapa tem um teste automatizado (`testes/faseNN_teste.lua`), identificado pelo número da etapa. A etapa só é registrada em commit após a aprovação do teste.
- **Regressão:** a integração contínua executa os testes da fase corrente e de todas as anteriores a cada push.
- **Recarga:** o código Lua é recarregado em tempo de execução (F5). O código nativo é recompilado com `make`.
- **Versionamento:** segue o modelo Gitflow, com uma issue e uma branch por fase ([gitflow.md](gitflow.md)).
- **Síntese final:** ao término do projeto, é elaborado um resumo do conhecimento consolidado em cada fase.

A estrutura de diretórios está descrita no [README.md](../README.md).
