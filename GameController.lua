local c = require("Class")

local game_menu = require("game_menu")

local gc = c:derive("GameController")

function gc:new()
    self.players = {}
    self.in_game_menu = Menu(game_menu)
end

return gc