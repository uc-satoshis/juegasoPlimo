local component = require "components/component"

local C_Controles = {
New = function()
    local c_controles = component.New "control"

    function c_controles.Load(e, args)
        e.Speed = 70--16
        
        if(Game.OS == "Android") then
            Game.Joystick = require("controles/joystick")
            Game.Joystick:Init()
        end
    end

    function c_controles.Tick(e, dt)

        if (Game.OS == "Linux" or Game.OS == "Windows") then
            if love.keyboard.isDown "right" or love.keyboard.isDown "d" then
                e:Apply_Velocity(e.Speed, math.rad(0))
            end

            if love.keyboard.isDown "left" or love.keyboard.isDown "a" then
                e:Apply_Velocity(e.Speed, math.rad(180))
            end

            if love.keyboard.isDown "up" or love.keyboard.isDown "w"  then
                e:Apply_Velocity(e.Speed, math.rad(270))
            end

            if love.keyboard.isDown "down" or love.keyboard.isDown "s"  then
                e:Apply_Velocity(e.Speed, math.rad(90))
            end

        elseif (Game.OS == "Android" or Game.OS == "iOS") then
            Game.Joystick:Update(e)
        end
    end


    function c_controles.Render(e)

    end

    return c_controles
end
}
return C_Controles