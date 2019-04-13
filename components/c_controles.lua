local component = require "components/component"

local C_Controles = {
New = function()
    local c_controles = component.New "control"

    function c_controles.Load(e, args)
        e.ValorJS = {x=0, y=0}
    end

    function c_controles.Tick(e, dt)

        local w = Game.Dim.w
        local h = Game.Dim.h

        if (Game.OS == "Linux" or Game.OS == "Windows") then
            if love.keyboard.isDown "right" or love.keyboard.isDown "d" then
                e:Apply_Velocity(e.Speed, math.rad(0))
                e.ValorJS.x = 1
            else
                e.ValorJS.x = 0
            end

            if love.keyboard.isDown "left" or love.keyboard.isDown "a" then
                e:Apply_Velocity(e.Speed, math.rad(180))
                e.ValorJS.x = -1
            else
                e.ValorJS.x = 0
            end

            if love.keyboard.isDown "up" or love.keyboard.isDown "w"  then
                e:Apply_Velocity(e.Speed, math.rad(270))
                e.ValorJS.y = 1
            else
                e.ValorJS.y = 0
            end

            if love.keyboard.isDown "down" or love.keyboard.isDown "s"  then
                e:Apply_Velocity(e.Speed, math.rad(90))
                e.ValorJS.y = -1
            else
                e.ValorJS.y = 0
            end

        elseif (Game.OS == "Android" or Game.OS == "iOS") then

            local touches = love.touch.getTouches() -- lista de los toques en pantalla

            for i, id in ipairs(touches) do   -- recorer la lista de touchs
                
                tchX ,tchY = love.touch.getPosition(id) -- cordeenadas de cada touch

                -- Izq
                if tchX>0 and tchX<w/3 and tchY>h/3 and tchY<2*h/3 then
                    e:Apply_Velocity(e.Speed, math.rad(180))
                end
        
                -- Dcha
                if tchX>2*w/3 and tchX<w and tchY>h/3 and tchY<2*h/3 then
                    e:Apply_Velocity(e.Speed, math.rad(0))
                end
        
                if tchY>0 and tchY<h/3 and tchX>0 and tchX<w then
                    e:Apply_Velocity(e.Speed, math.rad(270))
                end
        
                if tchY>2*h/3 and tchY<h and tchX>0 and tchX<w then
                    e:Apply_Velocity(e.Speed, math.rad(90))
                end

            end
        end
    end


    function c_controles.Render(e)

    end

    return c_controles
end
}
return C_Controles