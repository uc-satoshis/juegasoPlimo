local component = require "components/component"

local C_Player = {
New = function()
    local c_player = component.New "player"

    function c_player.Load(e, args)
        e.Speed = 50
    end

    function c_player.Tick(e, dt)
       
    end

    return c_player
end
}
return C_Player