
-- Representa un nivel o pantalla del juego
local level_0_1  = require "scenes/scene".New("level_0_1")

local Entity  = require "entities/entity"

function level_0_1:OvInit()


    Game.Physics:Reset()
    -- Objetos solidos
    

    e2 = Game.World:Create_Entity("npc")
    e2:Add(require "components/c_body".New(), {x = 400, y = 180, width = 64, height = 64})
    e2:Add(require "components/c_sprite".New(), {type = "Skeleton", velAnimacion = 0.3})
    e2:Add(require "components/c_physics_npc".New(), {friction = .85})

    -- Mapa
    mapActual = require("scenes/tile_map").New("assets/maps/mapa_0_1")

end

vueltuca = 0
function level_0_1:OvTick()
	
	-- me aburro xD
	--print(vueltuca)
	if vueltuca >= 0 and vueltuca < 200 then
 	   e2:Apply_Velocity(5, math.rad(180))
 	   vueltuca = vueltuca + 1
 	end 

 	if vueltuca >= 200 and vueltuca < 400 then
 	   e2:Apply_Velocity(5, math.rad(270))
 	   vueltuca = vueltuca + 1
 	end 

 	if vueltuca >= 400 and vueltuca < 600 then
 	   e2:Apply_Velocity(5, math.rad(0))
 	   vueltuca = vueltuca + 1
 	end 

 	if vueltuca >= 600 and vueltuca < 800 then
 	   e2:Apply_Velocity(5, math.rad(90))
 	   vueltuca = vueltuca + 1
 	end 

 	if vueltuca >= 800 then
 	   vueltuca = 0
 	end 

end

function level_0_1:OvRender()

end

return level_0_1