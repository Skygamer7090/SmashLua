require("Const")
local Menu = require("Menu")

function love.load()
    Menu = Menu()
end

function love.update(dt)
    --
end

function love.draw()
    love.graphics.print(GAME_STATE)
    if GAME_STATE == "OPENING" then

    elseif GAME_STATE == "GAME" then
        --Map:draw()
        if IN_GAME_STATE == "MENU" then
            Menu:draw();
        elseif IN_GAME_STATE == "PLAY" then
            
        end
    end
end
