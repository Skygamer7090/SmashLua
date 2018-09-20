require("Const")

function Back()
    GAME_STATE = "OPENING"
    IN_GAME_STATE = "MENU"
end

function Play() 
    GAME_STATE = "GAME"
    IN_GAME_STATE = "PLAY"
end

local PSM = {
    Back = {
        name = "Back",
        box = {
            x = 0, y = 0,
            w = 100, h = 50
        },
        action = Back
    },

    Play = {
        name = "Play",
        box = {
            x = ORIGINAL_RES.x - 100,
            y = ORIGINAL_RES.y - 50,
            w = 100,
            h = 50,
        },
        action = Play,
    }
}


return PSM