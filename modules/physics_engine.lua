local Physics_Engine = {}

local deg   = math.deg
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin

function Physics_Engine:Init()
    self.bodies = {}
    self.statics = {}
    self.map_change = {}
    Game.GameLoop:AddLoop(self)
end


function Physics_Engine:Reset()
    self.statics = {}
    self.map_change = {}
    self.bodies = {}
    e:Add(require "components/c_physics".New(), {friction = .83})
end



function Physics_Engine:Create_Rect(pos, size)
    return {
        pos = pos,
        size= size,

        Intersects = function(self, other)
            return  self.pos.x + self.size.x > other.pos.x  and
                    self.pos.x < other.pos.x + other.size.x and
                    self.pos.y + self.size.y > other.pos.y  and
                    self.pos.y < other.pos.y + other.size.y
        end
    }
end



function Physics_Engine:Add_Static_Body(rect)
    table.insert(self.statics, {
        physics_type = "static",
        Position = rect.position,
        Size     = rect.size
    })
end

function Physics_Engine:Add_Map_Change(rect)
    table.insert(self.map_change, {
        physics_type = "map_change",
        Position = rect.position,
        Size     = rect.size,
        Map= rect.map
    })
end


function Physics_Engine:Add_Body(entity, settings)
    entity.Velocity = {x = settings.vel_x or 0, y = settings.vel_y or 0}
    entity.Friction = settings.friction or 0.95
    entity.Direction= 0

    entity.physics_type = settings.type or "dynamic"

    function entity:Get_Direction()
        deg( atan2(entity.Position.y - entity.Velocity.y, entity.Position.x - entity.Velocity.x))
    end

    function entity:Apply_Velocity(speed, direction)
        self.Velocity.x = self.Velocity.x + cos(direction) * speed
        self.Velocity.y = self.Velocity.y + sin(direction) * speed
    end

    function entity:Get_X_Body(dt)
        return Game.Physics:Create_Rect(
            {x = self.Position.x + self.Velocity.x * dt, y = self.Position.y},
            self.Size
        )
    end

    function entity:Get_Y_Body(dt)
        return Game.Physics:Create_Rect(
            {x = self.Position.x, y = self.Position.y + self.Velocity.y * dt},
            self.Size
        )
    end

    function entity:Decel()
        self.Velocity.x = self.Velocity.x * self.Friction
        self.Velocity.y = self.Velocity.y * self.Friction
    end

    function entity:Collision(other) end
    
    table.insert(self.bodies, entity)
end




function Physics_Engine:Tick(dt)

    for i, body in ipairs(self.bodies) do
        local v_body = self:Create_Rect(body.Position, body.Size)
        local x_body = body:Get_X_Body(dt)
        local y_body = body:Get_Y_Body(dt)
        
        for j, static in ipairs(self.statics) do
            local static_body = self:Create_Rect(static.Position, static.Size)

            -- x_body collision
            if (static_body:Intersects(x_body)) then
                x_body.pos.x = v_body.pos.x 
            end

            -- y_body collision
            if (static_body:Intersects(y_body)) then
                y_body.pos.y = v_body.pos.y
            end
        end


        for j, map_body in ipairs(self.map_change) do
            local map_change_body = self:Create_Rect(map_body.Position, map_body.Size)

            -- map_change
            if (map_change_body:Intersects(x_body)) or (map_change_body:Intersects(y_body)) then
                Game.GSM:GotoScene(require (map_body.Map ))
            end

           
        end

        body:Decel()

        body.Position.x = x_body.pos.x
        body.Position.y = y_body.pos.y
    end

end

function Physics_Engine:Debug_Render()
    if(Debug_Mode == true) then

        -- Pinta solidos de ROJO
        love.graphics.setColor(255, 0, 0)
        for i, static in ipairs(self.statics) do
            love.graphics.rectangle("line",static.Position.x, static.Position.y, static.Size.x, static.Size.y)
        end

        -- Pinta cambios de mapa de AZUL
         love.graphics.setColor(0, 0, 255)
        for i, map_change in ipairs(self.map_change) do
            love.graphics.rectangle("line",map_change.Position.x, map_change.Position.y, map_change.Size.x, map_change.Size.y)
        end

        -- Pinta cuerpos de BLANCO
         love.graphics.setColor(255, 255, 255)
        for i, body in ipairs(self.bodies) do
            love.graphics.rectangle("line",body.Position.x, body.Position.y, body.Size.x, body.Size.y)
        end

        love.graphics.setColor(255,255,255, 255)
    end

end

return Physics_Engine