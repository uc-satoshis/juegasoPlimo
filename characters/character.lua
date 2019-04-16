local Character = {
New = function()
    local character = {
                        Animations = {},
                        orden = {},

                        Hitboxes = {},

                        spriteSheet,
                        numFrames,
                        numAnimations
                    }

    function character:generateAnimations()
        local animation = {}
        local xoffset = math.floor(self.spriteSheet:getWidth()/self.numFrames)
        local yoffset = math.floor(self.spriteSheet:getHeight()/self.numAnimations)
        for y = 0, self.numAnimations - 1 do
            for x = 0, self.numFrames - 1 do
                table.insert(animation, {x*xoffset, y*yoffset, xoffset, yoffset})
            end
            self:addAnimation(animation, self.orden[y+1])
            animation = {} -- resetea la tabla con la animacion
        end
    end

    function character:addAnimation(a, id)
        self.Animations[id] = a
    end
        
    function character:addHitbox(h, id)
        self.Hitboxes[id] = h
    end
        
    function character:getAnimations()
        return self.Animations
    end

    function character:getAnimation(id)
        return self.Animations[id]
    end
        
    function character:getHitboxes()
        return self.Hitboxes
    end
    
    return character
end
}

return Character