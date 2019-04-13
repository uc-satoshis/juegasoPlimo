local GameLoop = {}

local push, pop = table.insert, table.remove

function GameLoop:Init()
    self.tickers = {}
end


function GameLoop:AddLoop(obj)
    push(self.tickers, obj)
    --print(tostring(obj).." Añadido al loop -> Num objs = "..#self.tickers)
end


function GameLoop:RemoveLoop(obj)
    for i = #self.tickers, 1, -1 do
        if self.tickers[i] == obj then
            pop(self.tickers, i)
            return
        end
    end
    --print(tostring(obj).." Eliminado del loop -> Num objs = "..#self.tickers)
end


function GameLoop:Tick(dt)
    for i,v in ipairs(self.tickers) do
        v:Tick(dt)
    end
end


return GameLoop