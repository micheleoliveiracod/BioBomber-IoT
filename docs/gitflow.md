# Gitflow do BioBomber-IoT

Convenção de branches, commits, Pull Requests e Kanban do projeto, seguida da aplicação às fases: milestones, labels, branches e issues.

---

## Modelo de branches

| Branch | Nasce de | Faz merge em | Convenção de nome |
|---|---|---|---|
| `main` | — | — | fixo |
| `develop` | `main` (uma vez, no início) | — | fixo |
| `feature/*` | `develop` | `develop` | `feature/faseNN-<nome>` (uma por fase) |
| `test/*` | `develop` | `develop` | `test/<nome-descritivo>` |
| `docs/*` | `develop` | `develop` | `docs/<nome-descritivo>` |
| `chore/*` | `develop` | `develop` | `chore/<nome-descritivo>` |
| `bugfix/*` | `develop` | `develop` | `bugfix/<nome-descritivo>` |
| `release/*` | `develop` | `main` **e** `develop` | `release/vX.Y` |
| `hotfix/*` | `main` | `main` **e** `develop` | `hotfix/<nome-descritivo>` |

- **`main`:** mantém sempre uma versão funcional. Só recebe merge de `release/*` ou `hotfix/*`, **sempre via Pull Request**, nunca com commit ou push direto.
- **`develop`:** branch de integração, que recebe cada fase concluída.
- **`feature/faseNN-...`:** contém o desenvolvimento de uma fase e é removida após o merge.
- **Regra de merge:** sempre `--no-ff`, sem squash, preservando no histórico a trajetória de cada branch.

## Convenção de commits (Conventional Commits)

```
<tipo>(<escopo>): <descrição curta, no imperativo, minúscula>
```

- **Tipos:** `feat`, `fix`, `test`, `docs`, `chore`, `refactor`, `ci`, `build`.
- **Escopo:** a fase (`fase01` a `fase10`) ou o módulo (`mapa`, `broker`, `nativo`...).
- **Exemplos:**
  - `feat(fase01): preenche config com números e cores`
  - `feat(fase03): implementa explosão em cruz em bombas.celulas_explosao`
  - `fix(fase05): usa divisão em double no bb_adc_para_valor`
  - `test(fase06): adiciona caso de vetor com desvio zero`
  - `chore(fase05): cria Makefile do nativo`
  - `docs(fase04): explica publish/subscribe no roteiro`
- **Um commit por etapa do roteiro.** Commits que agregam uma fase inteira são evitados.

## Testes a cada passo

Cada teste tem o número do passo do roteiro no nome, por exemplo `passo 4 · bombas.celulas_explosao`.
- **Fim de cada passo:** roda-se `.\testar.bat NN`. O commit do passo só acontece com o teste dele em `[ok]`.
- **A cada push** na branch da fase, o GitHub Actions roda os testes das fases 1 até NN. As fases anteriores continuam sendo testadas, então o que já foi construído não pode quebrar.
- **Merge:** o PR só é mergeado com o CI verde.

## Convenção de Pull Requests

- **Título:** mesmo padrão do commit. Exemplo: `feat(fase03): laços e tabelas`.
- **Destino:**
  - `feature/*`, `test/*`, `docs/*`, `chore/*` e `bugfix/*` vão para `develop`;
  - `release/*` e `hotfix/*` vão para `main`, com back-merge em `develop`.
- **Corpo:** o template `.github/pull_request_template.md`. Ele tem as seções:
  - Contexto;
  - Camadas impactadas;
  - O que mudou;
  - Como testar;
  - Checklist;
  - Observações;
  - `Closes #N`.
- **Merge:** `--no-ff`.

## Kanban (GitHub Projects, 4 colunas)

`Backlog` → `In Progress` → `In Review` → `Done`

- **Backlog:** issue registrada, ainda não iniciada.
- **In Progress:** branch `feature/faseNN-...` criada e em desenvolvimento.
- **In Review:** o PR para a `develop` foi aberto e o CI está rodando. Os critérios de aceite da issue são conferidos antes do merge.
- **Done:** PR mergeado na `develop` e issue encerrada pelo `Closes #N`.

---

## Aplicação ao projeto

### Milestones

| Milestone | Fases | Release no fim |
|---|---|---|
| **M1 - Lua** | 1 a 4 | `release/v0.1` |
| **M2 - C** | 5 a 9 | `release/v0.2` |
| **M3 - C++** | 10 | `release/v1.0` |
| **Release** | — | as três releases acima |

### Labels
Cada issue leva **duas labels**: uma de **tipo** e uma de **etapa**.

| Tipo | Etapa |
|---|---|
| `feature`, `test`, `docs`, `chore`, `bugfix` | `m1: lua`, `m2: c`, `m3: c++`, `release` |

### Branches e issues das fases

| Fase | Issue | Branch | Milestone |
|---|---|---|---|
| 1 | #1 `feat(fase01): variáveis e aritmética` | `feature/fase01-variaveis` | M1 - Lua |
| 2 | #2 `feat(fase02): condições if/elseif` | `feature/fase02-condicoes` | M1 - Lua |
| 3 | #3 `feat(fase03): laços e tabelas` | `feature/fase03-lacos-tabelas` | M1 - Lua |
| 4 | #4 `feat(fase04): objetos e primeira IoT` | `feature/fase04-objetos-iot` | M1 - Lua |
| 5 | #5 `feat(fase05): tipos e funções em C + ADC` | `feature/fase05-c-funcoes` | M2 - C |
| 6 | #6 `feat(fase06): vetores em C + regra dos 3σ` | `feature/fase06-c-vetores` | M2 - C |
| 7 | #7 `feat(fase07): ponteiros e structs + gêmeo digital` | `feature/fase07-c-structs` | M2 - C |
| 8 | #8 `feat(fase08): strings e buffers + JSON` | `feature/fase08-c-strings` | M2 - C |
| 9 | #9 `feat(fase09): bits e bytes + pacote MQTT` | `feature/fase09-c-bits` | M2 - C |
| 10 | #10 `feat(fase10): classes C++ + curingas e histerese` | `feature/fase10-cpp-classes` | M3 - C++ |

### Passo zero (uma vez só)
```bash
git switch main
git switch -c develop
git push -u origin develop
```

A primeira branch depois da `develop` é `docs/estrutura-inicial`. Ela contém só a documentação e a estrutura do repositório:
- README;
- `docs/` (sem os roteiros);
- `.github/`;
- `.gitignore` e `.gitattributes`;
- `FASE_CONCLUIDA`.

O código (`.lua`, `.bat`, `nativo/`) e os roteiros de cada fase (`docs/licoes/`) entram junto com o desenvolvimento, nas branches `feature/faseNN-...`.

### O ciclo de cada fase
1. O card da issue vai para **In Progress** e a branch é criada:
   ```bash
   git switch develop && git pull
   git switch -c feature/fase03-lacos-tabelas
   ```
2. Para cada passo do roteiro:
   - implementação do passo;
   - `.\testar.bat 3`;
   - com o teste do passo em `[ok]`, commit: `git commit -m "feat(fase03): ..."`.
3. Push da branch: `git push -u origin feature/fase03-lacos-tabelas`.
4. Com tudo verde:
   - `FASE_CONCLUIDA` passa a `3`, com o commit `chore(fase03): marca fase concluída`;
   - o PR para a `develop` é aberto com `Closes #<issue>`.
5. Com o CI verde: merge `--no-ff`, a branch é apagada e o card vai para **Done**.

### Releases (ao fim das fases 4, 9 e 10)
```bash
git switch develop && git pull
git switch -c release/v0.1
git push -u origin release/v0.1
# PR release/v0.1 -> main ; depois do merge:
git switch main && git pull
git tag v0.1 && git push origin v0.1
# back-merge: PR main -> develop
```

### O que o GitHub Actions faz (`.github/workflows/ci.yml`)

| Job | Quando | O que verifica |
|---|---|---|
| **lua** | push em `feature/**`, `test/**`, `bugfix/**`, `develop` e `main`, e PRs para `develop`/`main` | sintaxe de todos os `.lua`; compila `nativo/` (se existir); testes das fases 1 até N (se houver fase concluída) |
| **dll-windows** | os mesmos gatilhos, quando `nativo/Makefile` existir | compila a `biobomber.dll` no Windows e deixa para download em *Artifacts* |

Como o N é escolhido:
- numa branch `feature/faseNN-...`, N é o número da fase;
- nos outros casos, N é o número que está em `FASE_CONCLUIDA`.

## Resumo do aprendizado
Ao término das 10 fases, é elaborada uma síntese do conhecimento consolidado em cada uma (programação, IoT e imunologia).
