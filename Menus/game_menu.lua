function Exit_Action(content) 
    print("exit app...")
    love.event.quit(0)
end

function Load_Player_Select()
    print("load player select...")
end

function Load_Player_Select()
    
end

local gm = {
    ["Start"] = {
        ["Players Select"] = Load_Player_Select,
        ["Extras"] = {
            ["FPEAINFAIEP"] = {

            }
        },
        ["back"] = Exit_Action,
    },
    ["Exit"] = Exit_Action,
}

return gm