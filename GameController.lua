local c = require("Class")
local gc = c:derive("GameController")
local Player = require("Character")
local Map = require("Map")

function gc:new(players, map)
    self.players = {}
    self.Map = Map("FD", "res/FD_bkg1.jpg", "colMap/FD_colmap") 
end

function gc:update(dt)
    self.Map:update(dt, self.players)
    for i,v in pairs(self.players) do
        v:update(dt)
    end
end

function gc:draw()
    self.Map:draw()
    love.graphics.setColor(1,1,1)
    for i,v in pairs(self.players) do
        v:draw(self.Map.Collider.cols)
        --v:drawDEBUG()
    end
end

function gc:initiatePlayers(players)
    for i, v in pairs(players) do
        table.insert(self.players, Player(v, i))
    end 
end

function gc:keypressed(k)

end

return gc