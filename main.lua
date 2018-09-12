require("Const")
local gm = require("Menus/game_menu")

function love.load()
    gm:buttonPress("Exit")
end

function love.update(dt)
    --
end

function love.draw()
    if GAME_STATE == "OPENING" then

    elseif GAME_STATE == "GAME" then
        --Map:draw()
        
    end
<<<<<<< HEAD
end1
=======
end
>>>>>>> dd8d2e77665f9d88c4dd214dbe52b2023867dd83
