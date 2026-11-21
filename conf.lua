-- conf.lua: configura a janela do LÖVE.

-- Com "lovec . --teste N" a janela não abre. Só os testes rodam.
local modo_teste = false
for _, a in ipairs(arg or {}) do
    if a == "--teste" then modo_teste = true end
end

function love.conf(t)
    t.identity = "biobomber"
    t.version = "11.5"
    t.console = false

    if modo_teste then
        t.window = false
        t.modules.window = false
        t.modules.graphics = false
        t.modules.audio = false
        t.modules.sound = false
        return
    end

    t.window.title = "BioBomber"
    t.window.width = 960   -- 15 colunas x 40 px = 600 do mapa + 360 do painel
    t.window.height = 580  -- 13 linhas x 40 px = 520 do mapa + 60 do topo
end
