local c = require("Class")
local gc = c:derive("GameController")
local Player = require("Character")
local Map = require("Map")

function gc:new(players, map)
    self.players = {}
    self.Map = Map("FD", "res/FD_bkg1.jpg", "FD_colmap") 
end

function gc:update(dt)
    Map:update(dt, self.players)
end

function gc:draw()
    self.Map:draw()
end

function gc:initiatePlayers(players)
    for i, v in pairs(players) do
        table.insert(self.players, Player(v))
    end 
end

return gc