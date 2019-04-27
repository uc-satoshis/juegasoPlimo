

-- Representa un nivel o pantalla del juego
local level_0_2 = require "scenes/scene".New("level_0_2")

local Entity  = require "entities/entity"

function level_0_2:OvInit()


    Game.Physics:Reset()
    
    -- cambio mapa


    -- Mapa

    Game.mapActual = require("scenes/tile_map").New("assets/maps/mapa_0_2")
end

function level_0_2:OvRender()

end

return level_0_2