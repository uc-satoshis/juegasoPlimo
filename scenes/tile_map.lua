local Tile_Map = {

    New = function(path)
        if(mapActual~=nil) then
            print("HOLA")
            mapActual:Destroy()
        end
        local map = require(path)
        local layers = map.layers
        for i, layer in ipairs(layers) do
            if (layer.type == "objectgroup") then
                for j, object in ipairs(layer.objects) do


                    if (object.type == "") then
                        Game.Physics:Add_Static_Body({
                            position = {x=object.x, y=object.y},
                            size = {x=object.width, y=object.height}
                        })
                    end

                    if (object.type == "static") then
                        Game.Physics:Add_Static_Body({
                            position = {x=object.x, y=object.y},
                            size = {x=object.width, y=object.height}
                        })
                    end

                    if (object.type == "teleport") then
                        Game.Physics:Add_Map_Change({
                            position = {x=object.x, y=object.y},
                            size = {x=object.width, y=object.height},
                            map= object.properties.map,
                            spawnX= object.properties.spawnX,
                            spawnY= object.properties.spawnY
                        })
                    end
                    
                end
            end
        end

        function map:Render()
            local image = Game.Assets:Get(map.tilesets[1].name)
            assert(image)
            local quads = Game.Assets:Get(map.tilesets[1].name .. "_quads")
            assert(quads)

            for i, layer in ipairs(self.layers) do
                if (layer.type == "tilelayer") then
                    for y = 0, layer.height - 1 do
                        for x = 0, layer.width - 1 do
                            local id = layer.data[(x + y * layer.width) + 1]
                            if (id ~= 0) then
                                -- render
                                love.graphics.draw(image, quads[id], x * self.tilewidth, y * self.tileheight)
                            end
                        end
                    end
                end
            end
        end

        function map:Destroy()
            Game.Renderer:RemoveRendererLayer(2)
            print("CAPA DE RENDER DE MAPAS DESTRUIDA!")
        end

        Game.Renderer:AddRenderer(map, 2)
        print("MAPA ANADIDO!")
        return map
    end
}
return Tile_Map