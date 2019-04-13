local component = require "components/component"

local C_Player = {
New = function()
    local c_player = component.New "player"

    function c_player.Load(e, args)
        e.Speed = 16
        Game.Joystick = require("controles/joystick")
    end

    function c_player.Tick(e, dt)
        --print("Pers     "..e.Position.x, e.Position.y)
        Game.Joystick:setPos()
    end

    function c_player.Render(e)
        --print("JS        "..Game.Joystick.pos.x, Game.Joystick.pos.y)
        love.graphics.draw(Game.Joystick.imgJS, Game.Joystick.pos.x, Game.Joystick.pos.y)
    end

    return c_player
end
}
return C_Player