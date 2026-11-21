-- testes/rodar.lua: roda os testes automáticos de cada fase.
--
-- Dá para usar de três jeitos:
--   1) Dentro do jogo: o painel lateral mostra "Testes da fase N: x/y".
--   2) No terminal, com o LÖVE:  lovec . --teste 3     (só a fase 3)
--                                lovec . --teste       (todas)
--   3) No terminal, com LuaJIT:  luajit testes/rodar.lua 3
--                                luajit testes/rodar.lua --ate 4   (fases 1 a 4)
--      (o GitHub Actions usa este jeito)

local M = {}

-- Funções de conferência que cada teste recebe como "t".
local function verificador()
    local t = {}
    local function falhar(msg) error(msg, 3) end

    function t.igual(obtido, esperado, msg)
        if obtido ~= esperado then
            falhar(string.format("%sesperado %s, obtido %s",
                msg and (msg .. ": ") or "", tostring(esperado), tostring(obtido)))
        end
    end

    function t.perto(obtido, esperado, tolerancia, msg)
        tolerancia = tolerancia or 1e-6
        if type(obtido) ~= "number" or math.abs(obtido - esperado) > tolerancia then
            falhar(string.format("%sesperado ~%s, obtido %s",
                msg and (msg .. ": ") or "", tostring(esperado), tostring(obtido)))
        end
    end

    function t.verdadeiro(valor, msg)
        if not valor then falhar(msg or "esperado verdadeiro") end
    end

    return t
end

-- Tira o caminho do arquivo da mensagem de erro, para ela ficar mais fácil de ler.
local function limpar(msg)
    msg = tostring(msg)
    return (msg:gsub("^[^:]*testes[/\\][%w_]+%.lua:%d+: ", ""))
end

-- Roda os testes de uma fase e devolve { total, passou, primeira_falha, linhas }.
function M.resultado(fase)
    local nome = string.format("testes.fase%02d_teste", fase)
    package.loaded[nome] = nil
    local ok, casos = pcall(require, nome)
    if not ok then
        return { total = 1, passou = 0, primeira_falha = "erro ao carregar os testes: " .. limpar(casos), linhas = {} }
    end

    local r = { total = #casos, passou = 0, linhas = {} }
    for _, caso in ipairs(casos) do
        local nome_caso, funcao = caso[1], caso[2]
        local ok_caso, erro = pcall(funcao, verificador())
        if ok_caso then
            r.passou = r.passou + 1
            table.insert(r.linhas, "  [ok]    " .. nome_caso)
        else
            local msg = nome_caso .. " — " .. limpar(erro)
            r.primeira_falha = r.primeira_falha or msg
            table.insert(r.linhas, "  [FALHA] " .. msg)
        end
    end
    return r
end

-- Roda os testes, mostra o resultado e devolve quantos falharam.
-- Com um número em "fase", roda só essa fase. Sem "fase", roda da 1 até "ate" (10, se não vier nada).
function M.executar(fase, ate)
    local primeira, ultima = fase or 1, fase or (ate or 10)
    local falhas = 0
    for f = primeira, ultima do
        local r = M.resultado(f)
        print(string.format("Fase %02d: %d/%d testes passaram", f, r.passou, r.total))
        for _, linha in ipairs(r.linhas) do print(linha) end
        if r.total == 1 and r.passou == 0 and #r.linhas == 0 then print("  " .. r.primeira_falha) end
        falhas = falhas + (r.total - r.passou)
    end
    print(falhas == 0 and "Tudo certo!" or (falhas .. " teste(s) falhando."))
    return falhas
end

-- Quando este arquivo é chamado direto do terminal: luajit testes/rodar.lua [N | --ate N]
if not love and arg and arg[0] and arg[0]:match("rodar%.lua$") then
    package.path = "./?.lua;./?/init.lua;" .. package.path
    local fase, ate
    if arg[1] == "--ate" then ate = tonumber(arg[2]) else fase = tonumber(arg[1]) end
    if ate == 0 then print("Nenhuma fase concluída ainda: nada a testar.") os.exit(0) end
    os.exit(M.executar(fase, ate) == 0 and 0 or 1)
end

return M
