
-- Representa un nivel o pantalla del juego
local level_0_1  = require "scenes/scene".New("level_0_1")

local Entity  = require "entities/entity"

function level_0_1:OvInit()


    Game.Physics:Reset()
    -- Objetos solidos
    Game.Physics:Add_Static_Body({
        position = {x=560, y=470},
        size = {x=80, y=100}
    })

    Game.Physics:Add_Map_Change({
        position = {x=600, y=50},
        size = {x=80, y=100},
        map = "scenes/level_0" 
    })

       Game.Physics:Add_Map_Change({
        position = {x=200, y=450},
        size = {x=80, y=100},
        map = "scenes/level_0_2" 
    })
    

    -- Mapa
    mapActual = require("scenes/tile_map").New("assets/maps/mapa0-1")

end

function level_0_1:OvRender()

end

return level_0_1