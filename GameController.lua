local c = require("Class")
local gc = c:derive("GameController")
local Map = require("Map")

function gc:new(players, map)
    --self:initiatePlayers(players)
    self.players = {}
    self.Map = Map("FD", "res/FD_bkg1.jpg")
    
end

function gc:draw()
    self.Map:draw()
end

function gc:initiatePlayers(playerTab)

    for i,v in pairs(playerTab) do
        print("Added player " .. i)
        table.insert(self.player, v)
    end
end

return gc