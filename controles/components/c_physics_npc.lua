local component = require "components/component"

local C_Physics_npc = {
New = function()
    local c_physics_npc = component.New "physics"

    function c_physics_npc.Load(e, args)
        assert(e.Position)

        Game.Physics:Add_Body_npc(e, args)
    end

    return c_physics_npc
end
}
return C_Physics_npc