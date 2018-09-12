require("Const")

function exit_menu()
    GAMESTATE = "PLAY"
end

local pause = {
    ["Play"] = exit_menu,
    ["Settings"] = {
        ["volume"] = {

            ["back"] = {},
        },
        ["back"] = {},
    }
}

return pause