-- Capa 1: fondo negro
-- Capa 2: mapa y escena
-- Capa 3: 
-- Capa 4: entidades
-- Capa 5:
-- Capa 6:
-- Capa 7: joystick

local Renderer = {}

local push, pop = table.insert, table.remove

function Renderer:Init(num_layers)
    self.layers = {}
    for i = 0, num_layers-1 do
        push(self.layers, {})
    end
end


function Renderer:AddRenderer(obj, layer)
    assert(obj.Render, "Error::Renderer::AddRender obj passed does not contain a Render function!!")
    obj.__render_layer = layer or math.floor(#self.layers/2)
    push(self.layers[layer or math.floor(#self.layers/2)], obj)
    --print(tostring(obj).." Añadido al render capa "..obj.__render_layer.. " -> Num renders = "..#self.layers[obj.__render_layer])

end


function Renderer:RemoveRenderer(obj)
    for i = 1, #self.layers[obj.__render_layer] do
        if (self.layers[obj.__render_layer] == obj) then
            pop(self.layers[obj.__render_layer])
            --print(tostring(obj).." Eliminado del render capa "..obj.__render_layer.. " -> Num renders = "..#self.layers[obj.__render_layer])
            return
        end
    end
end

function Renderer:RemoveRendererLayer(layer)
    for i = 1, #self.layers[layer] do
        -- Si es la capa 4, mantiene el jugador activo
        if layer == 4 then
            if(self.layers[layer][i] ~= e) then
                pop(self.layers[layer], i)
            end
        else
            pop(self.layers[layer], i)
        end
    end
end


function Renderer:Render()
    for i,layer in ipairs(self.layers) do
        for i=1, #layer do
            local obj = layer[i]
            obj:Render()
        end
    end

    if Debug_Mode == true then
        print("GameLoop : "..#Game.GameLoop.tickers, "Renderer : "..#self.layers[1],#self.layers[2],#self.layers[3],#self.layers[4])
    end

end

function Renderer:eliminaMapas()
    -- body
end


return Renderer