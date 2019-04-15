require "tools/vect2"

-- Componente que representa la posicion y el tamano de una entidad
local C_Body = {
    New = function()
        local c_body = require "components/component".New("body")

        function c_body.Load(e, args)
            e.Position = math.vect2.New(args.x, args.y)
            if(args.width == nil) then
                e.Size = math.vect2.New(select(3,e.spriteActual:getViewport()), select(4,e.spriteActual:getViewport()))
            else
                e.Size = math.vect2.New(args.width, args.height)
            end
            
            function e:Intersects(e2)
                if(e2.Position == nil) then return false end
                return self.Position.x + self.Size.x > e2.Position.x and
                        self.Position.x < e2.Position.x + e2.Size.x and
                        self.Position.y + self.Size.y > e2.Position.y and
                        self.Position.y < e2.Position.y + e2.Size.y
            end
        end

        return c_body
    end,
}
return C_Body