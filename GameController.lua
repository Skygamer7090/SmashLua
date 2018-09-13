local c = require("Class")
local gc = c:derive("GameController")

function gc:new()
    self.players = {}
    --self.Map = Map()
    
end

function gc:draw()
    love.graphics.rectangle("fill", 0, 0, 100, 100)
end

function gc:initiatePlayers(playerCount)
    for i = 1, playerCount, 1 do
        print("inesrted player: " .. i)
        --table.insert(self.players, Player())
    end
end

return gc