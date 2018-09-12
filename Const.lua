--the state of the global game
GAME_STATE = "GAME"

--the state of the match
IN_GAME_STATE = "MENU"

FONTS = {
    MENU_FONT = love.graphics.newFont("BEBAS.ttf")
}

ORIGINAL_RES = {x = 800, y = 600}
SCALE = {x = love.graphics.getWidth()/ ORIGINAL_RES.x, y = love.graphics.getHeight() / ORIGINAL_RES.y}
print(SCALE.x, SCALE.y)