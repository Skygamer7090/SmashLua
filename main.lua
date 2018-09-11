require("Const")
local gm = require("Menus/game_menu")

function love.load()
    gm:buttonPress("Exit")
end

function love.update(dt)

end

function love.draw()
    if GAME_STATE == "OPENING" then

    elseif GAME_STATE == "GAME" then
        --Map:draw()
        
    end
end