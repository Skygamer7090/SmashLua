require("Const")

function Exit_Action(content) 
    print("exit app...")
    love.event.quit(0)
end

function Load_Player_Select(GC)
    GAME_STATE = "PLAYER_SELECT"
end

local gm = {
    ["Start"] = {
        ["Players Select"] = Load_Player_Select,
        ["Extras"] = {
            ["Test 2"] = {
                ["back"] = {},
            },
            ["back"] = {},
        },
        ["back"] = {},
        },
    ["Exit"] = Exit_Action,
}

return gm