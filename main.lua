require "Const" 
local Menu = require("Menu")
local GameCont = require("GameController")

function love.load()
    Menu = Menu()
    GameCont = GameCont()
end

function love.update(dt)
    --
end

function love.draw()
    love.graphics.scale(SCALE.x, SCALE.y)
    love.graphics.print(GAME_STATE .. " / " .. IN_GAME_STATE)
    if GAME_STATE == "OPENING" then
        Menu.currentMenu = 1
        Menu:draw()
    elseif GAME_STATE == "GAME" then
        GameCont:draw()
        if IN_GAME_STATE == "MENU" then
            Menu.currentMenu = 2
            Menu:draw()
        elseif IN_GAME_STATE == "PLAY" then
            
        end
    elseif GAME_STATE == "PLAYER_SELECT" then
        
    end
    
end

function love.mousepressed(x, y, b)
    x = x / SCALE.x
    y = y / SCALE.y


    if GAME_STATE == "OPENING" then
        Menu:mousepressed(x, y, b, GameCont) 
    elseif GAME_STATE == "GAME" then
        
        if IN_GAME_STATE == "MENU" then
            Menu:mousepressed(x, y, b, GameCont)
        elseif IN_GAME_STATE == "PLAY" then
            
        end
    elseif GAME_STATE == "PLAYER_SELECT" then
        
    end
end
