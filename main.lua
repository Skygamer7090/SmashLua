require "Const" 
local Menu = require("Menu")

function love.load()
    Menu = Menu()
end

function love.update(dt)
    --
end

function love.draw()
    love.graphics.scale(SCALE.x, SCALE.y)
    --love.graphics.print(GAME_STATE)
    if GAME_STATE == "OPENING" then

    elseif GAME_STATE == "GAME" then
        --Map:draw()
        if IN_GAME_STATE == "MENU" then
            Menu:draw()
        elseif IN_GAME_STATE == "PLAY" then
            
        end
    end
end

function love.mousepressed(x, y, b)
    x = x / SCALE.x
    y = y / SCALE.y


    if GAME_STATE == "OPENING" then

    elseif GAME_STATE == "GAME" then
        
        if IN_GAME_STATE == "MENU" then
            Menu:mousepressed(x, y, b)
        elseif IN_GAME_STATE == "PLAY" then
            
        end
    end
end
