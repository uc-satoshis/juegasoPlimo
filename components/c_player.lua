local component = require "components/component"

local C_Player = {
New = function()
    local c_player = component.New "player"

    function c_player.Load(e, args)
        e.Speed = 16
        Game.Joystick = require("controles/joystick")
        Game.Joystick:Init()
    end

    function c_player.Tick(e, dt)
        Game.Joystick:Update(e)
    end

    function c_player.Render(e)
        --Game.Joystick:Render()
    end

    return c_player
end
}
return C_Player