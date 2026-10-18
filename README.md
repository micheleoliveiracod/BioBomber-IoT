# BioBomber-IoT

Jogo no estilo Bomberman desenvolvido como projeto de estudo de **Lua, C, C++ e Internet das
Coisas (IoT)**, tendo como domínio de aplicação o **sistema imunológico humano**.

Cada fase representa um sítio anatômico distinto, defendido por um tipo celular específico
da resposta imune: neutrófilo, macrófago, célula NK, linfócito B ou linfócito T. Os agentes
agressores incluem:
- bactérias;
- vírus;
- fungos;
- toxinas;
- células neoplásicas.

Mecânicas e conceitos:
- **Ataque:** cápsulas de anticorpos, liberadas em padrão cruciforme.
- **Imunização:** introduzida na fase 9 como memória imunológica.
- **IoT:** a partir da fase 4, sob o paradigma de IoMT (*Internet of Medical Things*):
  - nanossensores teciduais medem a carga patogênica e publicam as leituras num broker de mensagens no modelo MQTT;
  - o monitor do paciente assina esses tópicos e exibe a telemetria.

## Organização do desenvolvimento
- **Fases:** o projeto é construído em 10 fases de complexidade crescente. Cada fase corresponde a uma issue, a uma branch `feature/faseNN-...` e a um Pull Request para a `develop`, conforme o modelo Gitflow ([docs/gitflow.md](docs/gitflow.md)).
- **Linguagens:**
  - Lua (fases 1 a 4), sobre o framework LÖVE;
  - C (fases 5 a 9), numa biblioteca nativa invocada pelo Lua por meio de FFI (*Foreign Function Interface*);
  - C++ (fase 10).
- **Verificação:**
  - cada etapa de uma fase possui um teste automatizado correspondente (`testes/faseNN_teste.lua`);
  - uma etapa só é registrada em commit após a aprovação do respectivo teste;
  - a integração contínua (GitHub Actions) executa, a cada push, os testes da fase corrente e de todas as anteriores (teste de regressão).

## Fases

| Fase | Sítio · Célula efetora · Agente agressor | Linguagem e conceito | IoT | Branch |
|---|---|---|---|---|
| [#1](../../issues/1) | Lesão cutânea · Neutrófilo · **Bactéria** | Lua: variáveis e aritmética | — | `feature/fase01-variaveis` |
| [#2](../../issues/2) | Corrente sanguínea · Neutrófilo · **Bactéria encapsulada** | Lua: estruturas condicionais | — | `feature/fase02-condicoes` |
| [#3](../../issues/3) | Mucosa orofaríngea · Macrófago · **Levedura (*Candida*)** | Lua: estruturas de repetição e tabelas | — | `feature/fase03-lacos-tabelas` |
| [#4](../../issues/4) | Pulmões · Macrófago · **Influenza** | Lua: strings, funções e orientação a objetos | nanossensor, tópicos, publish/subscribe | `feature/fase04-objetos-iot` |
| [#5](../../issues/5) | Corrente sanguínea (sepse) · Neutrófilo · **Colônia bacteriana** | C: tipos, operadores e funções | conversão analógico-digital (ADC) | `feature/fase05-c-funcoes` |
| [#6](../../issues/6) | Tecido com lesão neoplásica inicial · Célula NK · **Célula neoplásica** | C: vetores e laços | ruído de medição e critério de 3σ | `feature/fase06-c-vetores` |
| [#7](../../issues/7) | Seios paranasais · Macrófago · **Fungo (*Aspergillus*)** | C: ponteiros e estruturas | gêmeo digital | `feature/fase07-c-structs` |
| [#8](../../issues/8) | Tecido muscular · Linfócito B · **Toxina** | C: strings e buffers | serialização JSON | `feature/fase08-c-strings` |
| [#9](../../issues/9) | Linfonodo (pós-vacinação) · Linfócito B de memória · **Surto viral** | C: operações bit a bit | pacote MQTT | `feature/fase09-c-bits` |
| [#10](../../issues/10) | Infecção sistêmica · Resposta imune integrada · **Superbactéria** | C++: classes e `std::string` | curingas de tópico e histerese | `feature/fase10-cpp-classes` |

## Estrutura
Os diretórios de código são incorporados ao repositório à medida que cada fase é desenvolvida:

```
conf.lua, main.lua        ponto de entrada do LÖVE
jogar.bat, testar.bat     execução do jogo e dos testes no Windows
FASE_CONCLUIDA            última fase concluída (limite dos testes na integração contínua)
jogo/                     lógica do jogo em Lua (fases 1 a 4)
  iot/                    sensor, broker e monitor do paciente (fase 4)
niveis/                   mapas e parâmetros de cada fase
nativo/                   biblioteca em C e C++ (fases 5 a 10)
testes/                   testes automatizados por fase e etapa
docs/                     documentação do projeto
  PLANO.md                escopo, linguagens, fases e metodologia
  gitflow.md              convenção de versionamento e gestão das tarefas
  licoes/                 roteiro de cada fase
.github/                  integração contínua e templates de issue e Pull Request
```

## Execução
```powershell
.\jogar.bat        # inicia o jogo
.\testar.bat 3     # executa os testes da fase 3
.\testar.bat       # executa os testes de todas as fases
```

## Requisitos
- **LÖVE 11.5**, para todas as fases.
- **MSYS2 UCRT64**, com gcc, g++ e make, a partir da fase 5.

A representação gráfica utiliza apenas primitivas geométricas desenhadas em código, sem
recursos de imagem externos.
