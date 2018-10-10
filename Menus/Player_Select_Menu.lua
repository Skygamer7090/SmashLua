require("Const")

function Back()
    GAME_STATE = "OPENING"
    IN_GAME_STATE = "MENU"
end

function Play(gc) 
    GAME_STATE = "GAME"
    IN_GAME_STATE = "PLAY"
    gc:initiatePlayers()
end

function AddPlayer(gc, playerSelector, CurButton)
    NB_OF_PLAYERS = NB_OF_PLAYERS + 1
    playerSelector:AddPlayer()
    
    if NB_OF_PLAYERS >= 4 then
        CurButton.enabled = false
    end
end

local PSM = {
    Back = {
        enabled = true,
        name = "Back",
        box = {
            x = 0, y = 0,
            w = 100, h = 50
        },
        action = Back
    },

    Play = {
        enabled = true,
        name = "Play",
        box = {
            x = ORIGINAL_RES.x - 100,
            y = ORIGINAL_RES.y - 50,
            w = 100,
            h = 50,
        },
        action = Play,
    },

    AddPlayer = {
        enabled = true,
        name = "Add Player",
        box = {
            x = ORIGINAL_RES.x/2 - 100,
            y = 0,
            w = 200,
            h = 50
        },
        action = AddPlayer,
    }
}


return PSM