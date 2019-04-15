local Physics_Engine = {}

local deg   = math.deg
local atan2 = math.atan2
local cos = math.cos
local sin = math.sin

function Physics_Engine:Init()
    self.bodies = {}
    self.bodies_npc = {}
    self.statics = {}
    self.map_change = {}
    Game.GameLoop:AddLoop(self)
end


function Physics_Engine:Reset()
    self.bodies = {}
    self.bodies_npc = {}
    self.statics = {}
    self.map_change = {}
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
        Map= rect.map,        
        SpawnX = rect.spawnX,
        SpawnY = rect.spawnY
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



function Physics_Engine:Add_Body_npc(entity, settings)
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
    
    table.insert(self.bodies_npc, entity)
end




function Physics_Engine:Tick(dt)

    --print("..PHYSICS ENGINE.. B: "..#self.bodies.."  BNPC: "..#self.bodies_npc.."  S: "..#self.statics.."  TP: "..#self.map_change)

    -- player body colisions and movement
    for i, body in ipairs(self.bodies) do
        local v_body = self:Create_Rect(body.Position, body.Size)
        local x_body = body:Get_X_Body(dt)
        local y_body = body:Get_Y_Body(dt)
        

        for j, static in ipairs(self.statics) do
            local static_body = self:Create_Rect(static.Position, static.Size)
            -- static x_body collision
            if (static_body:Intersects(x_body)) then
                x_body.pos.x = v_body.pos.x 
            end
            -- static y_body collision
            if (static_body:Intersects(y_body)) then
                y_body.pos.y = v_body.pos.y
            end
        end



        for j, map_body in ipairs(self.map_change) do
            local map_change_body = self:Create_Rect(map_body.Position, map_body.Size)
            -- map_change
            if (map_change_body:Intersects(x_body)) or (map_change_body:Intersects(y_body)) then
                Game.GSM:GotoScene(require (map_body.Map ))
                 Game.Camera:Set() 
                 Game.Camera:SetX(map_body.SpawnX)
                 Game.Camera:SetY(map_body.SpawnY)
                 Game.Camera:Unset() 

                  x_body.pos.x= map_body.SpawnX
                  y_body.pos.y= map_body.SpawnY
            end
        end



        for j, npc_body in ipairs(self.bodies_npc) do
            local npc_body = self:Create_Rect(npc_body.Position, npc_body.Size)
            -- npc x_body collision
            if (npc_body:Intersects(x_body)) then
                x_body.pos.x = v_body.pos.x 
            end

            -- npc y_body collision
            if (npc_body:Intersects(y_body)) then
                y_body.pos.y = v_body.pos.y
            end       
        end


        body:Decel()
        body.Position.x = x_body.pos.x
        body.Position.y = y_body.pos.y
    end



  -- npc body colisions and movement
  for i, body_npc in ipairs(self.bodies_npc ) do
        local v_body_npc = self:Create_Rect(body_npc.Position, body_npc.Size)
        local x_body_npc = body_npc:Get_X_Body(dt)
        local y_body_npc = body_npc:Get_Y_Body(dt)


        --player colision
        for j,body in ipairs(self.bodies) do
            local body = self:Create_Rect(body.Position, body.Size)
            -- player x_body collision
            if (body:Intersects(x_body_npc)) then
                x_body_npc.pos.x = v_body_npc.pos.x 
            end

            -- player y_body collision
            if (body:Intersects(y_body_npc)) then
                y_body_npc.pos.y = v_body_npc.pos.y
            end       
        end


        for j, static in ipairs(self.statics) do
           local static_body = self:Create_Rect(static.Position, static.Size)
            -- static x_body collision
            if (static_body:Intersects(x_body_npc)) then
                x_body_npc.pos.x = v_body_npc.pos.x 
            end
            -- static y_body collision
            if (static_body:Intersects(y_body_npc)) then
                y_body_npc.pos.y = v_body_npc.pos.y
            end
        end


        body_npc:Decel()
        body_npc.Position.x = x_body_npc.pos.x
        body_npc.Position.y = y_body_npc.pos.y
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

        -- Pinta cuerpo player de blanco
         love.graphics.setColor(255, 255, 255)
        for i, body in ipairs(self.bodies) do
            love.graphics.rectangle("line",body.Position.x, body.Position.y, body.Size.x, body.Size.y)
        end

        -- Pinta cuerpo npc de verde
         love.graphics.setColor(0, 255, 0)
        for i, body_npc in ipairs(self.bodies_npc) do
            love.graphics.rectangle("line",body_npc.Position.x, body_npc.Position.y, body_npc.Size.x, body_npc.Size.y)
        end

        love.graphics.setColor(255,255,255, 255)
    end

end

return Physics_Engine