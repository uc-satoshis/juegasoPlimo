local Assets = {}

function Assets:Init()
    self.assets = {}
end

function Assets:Add(a, id)
    self.assets[id] = a
end

function Assets:Get(id)
    assert(self.assets[id], "ERROR::ASSETS:: cannot find the asset "..id)
    return self.assets[id]
end

function Assets:Generate_Quads(size, image, id)
    local quads = {}
    local w = math.floor(image:getWidth()/size)
    local h = math.floor(image:getHeight()/size)

    for y = 0, h - 1 do
        for x = 0, w - 1 do
            table.insert(quads, love.graphics.newQuad(
                                                      x*size,
                                                      y*size,
                                                      size,
                                                      size,
                                                      image:getWidth(),
                                                      image:getHeight()
                                                     )
            )
        end
    end

    self:Add(quads, id)
    return quads
end

return Assets