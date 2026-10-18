# Templates do GitHub

Guia dos templates de issues (`.github/ISSUE_TEMPLATE/`) e de Pull Request
(`.github/pull_request_template.md`). A convenção completa está em
[docs/gitflow.md](../docs/gitflow.md).

## Templates de issues

| Template | Arquivo | Label de tipo | Quando usar |
|---|---|---|---|
| 🎮 Fase | `fase.yml` | `feature` | uma issue por fase, com as etapas do roteiro e o teste de cada uma |
| 🐛 Bug Report | `bug_report.yml` | `bugfix` | algo no jogo, num teste ou num roteiro não funciona |
| 🧪 Testes | `test.yml` | `test` | novo teste ou revisão de um teste |
| 📚 Documentation | `documentation.yml` | `docs` | melhorias em roteiros, README ou documentação |
| 🔧 Chore/Maintenance | `chore.yml` | `chore` | CI, Makefile, configuração, refatoração |

Toda issue também recebe a **label de etapa** (`m1: lua`, `m2: c`, `m3: c++` ou `release`)
e o **milestone** correspondente.

## Template de Pull Request
Ele é aplicado automaticamente ao abrir um PR e tem as seções:
- **Contexto:** qual fase/issue o PR resolve.
- **Camadas impactadas:** `jogo/`, `jogo/iot/`, `nativo/`, `testes/`, `docs/`, configuração.
- **O que mudou**.
- **Como testar:** `.\testar.bat NN`.
- **Checklist:** integração contínua aprovada, teste de cada etapa, ausência de regressão e `FASE_CONCLUIDA` atualizado.
- **Closes #N**.

## Boas práticas
- **Título** no formato `<tipo>(<escopo>): <descrição>` (Conventional Commits).
- **Um commit por passo**, feito só depois do teste daquele passo passar.
- Use **`Closes #N`** para a issue fechar sozinha no merge.
