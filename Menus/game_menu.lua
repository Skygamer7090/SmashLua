function Exit_Action(content) 
    print("exit app...")
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

        }
    },
    ["Exit"] = Exit_Action,

}

return gm