--
--   
-- _______________________|      |____________________________________________
--          ,--.    ,--.          ,--.   ,--.
--         |oo  | _  \  `.       | oo | |  oo|
-- o  o  o |~~  |(_) /   ;       | ~~ | |  ~~|o  o  o  o  o  o  o  o  o  o  o
--         |/\/\|   '._,'        |/\/\| |/\/\|
--________________________        ____________________________________________
--                        |      |

--                                                    /\
--                                                   /  \
--                                                  /    \
--                                                  | vv |
--                                                  | vv |
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--                                                  | !! | 
--           ________                               | !! |   
--          /  _____/______   ____   ____   ____    | !! |     
--         /   \  __\_  __ \_/ __ \_/ __ \ /    \   | !! |      
--         \    \_\  \  | \/\  ___/\  ___/ |  |  \  | !! |     
--          \______  /__|    \____> \____> ___|  /  | !! |     
--                                                  | !! |     
--                                                  | !! |    ________                        
--                                                  | !! |   /  _____/_____    _____   ____  
--                                                  | !! |  /   \  ___\__  \  /     \_/ __ \ 
--                                                  | !! |  \    \_\  \/ __ \|  Y Y  \  ___/ 
--                                                  | !! |   \_______ (_____ /__|_|  /\____>
--                                                  | !! |              
--                                                  | !! |
--                                                  | ^^ |
--                                     |\          /  __  \           /|
--                                     |'\________/  /  \  \_________/'|
--                                     |    []      | /\ |      []     |
--                                     |. ________  | \/ |  _________ .|
--                                     \_/        \  \__/  /         \_/
--                                                 \      /
--                                                  |XXXX| 
--                                                  |XXXX|  
--                                                  |XXXX|  
--                                                  |XXXX|   
--                                                  |XXXX|   
--                                                  |XXXX|  
--                                                  |XXXX|  
--                                                  |XXXX|  
--                                                 /  /\  \
--                                                /   --   \
--                                                \________/ 



_G.Game = {
    love.window.setFullscreen(true),
    GameLoop    = require "modules/gameloop",
    Renderer    = require "modules/renderer",
    World       = require "modules/entity_world",
    GSM         = require "modules/game_scene_manager",
    Assets      = require "modules/assets",
    Physics     = require "modules/physics_engine",
    Camera      = require "modules/camera",
    Animations  = require "modules/animations",
    Canvas      = love.graphics.newCanvas(w,h),
}

--------------------------------------
--- LOVE.LOAD ------------------------
--------------------------------------
function love.load()

    Debug_Mode = true

    -- Inicializa las variables del juego
    Game.Dim        = { w = love.graphics.getWidth(),
                        h = love.graphics.getHeight()
                      }
    Game.OS         = love.system.getOS()
    Game.FPS = 30


    -- Inicializa los sistemas del juego
    Game.GameLoop:Init()
    Game.Renderer:Init(7)
    Game.World:Init()
    Game.Assets:Init()
    Game.GSM:Init()
    Game.Physics:Init()

    -- Canvas
    Game.Canvas:setFilter("nearest","nearest")

    -- Carga mapa
    Game.Assets:Add(love.graphics.newImage("assets/maps/sprites.png"), "sprites")
    Game.Assets:Generate_Quads(32, Game.Assets:Get("sprites"), "sprites_quads")
    Game.Assets:Add(love.graphics.newImage("assets/maps/sprites2.png"), "sprites2")
    Game.Assets:Generate_Quads(32, Game.Assets:Get("sprites2"), "sprites2_quads")

    

      -- Entidad personaje
    e = Game.World:Create_Entity("player")

    -- Componentes del personaje
    e:Add(require "components/c_sprite".New(), {type = "Player", velAnimacion = 0.3})
    e:Add(require "components/c_body".New(), {x = Game.Dim.w/2-50, y = Game.Dim.h/2-50})
    e:Add(require "components/c_physics".New(), {friction = .83})
    e:Add(require "components/c_player".New(), {})
    e:Add(require "components/c_controles".New(), {})
    e:Add(require "components/c_camera_follow".New(), {})

    -- Carga lvl 0 (con mapa)
    Game.GSM:GotoScene(require "scenes/level_0")

end

---------------------------------------
-- LOVE.UPDATE ------------------------
---------------------------------------
function love.update(dt)
    Game.GameLoop:Tick(dt)
    Game.World:Tick(dt)
    Game.Camera:Update(dt)
end


---------------------------------------
--- LOVE.DRAW -------------------------
---------------------------------------
function love.draw()

    -- Dibuja en el Canvas
    love.graphics.setCanvas(Game.Canvas) -- set canvas
    Game.Camera:Set() -- set camara
    Game.Renderer:Render()  -- renderiza en el canvas
    Game.Physics:Debug_Render()
    Game.Camera:Unset() -- unset camara
    love.graphics.setCanvas() -- unset canvas

    -- Dibuja el Canvas
    love.graphics.draw(Game.Canvas, 0, 0)
end