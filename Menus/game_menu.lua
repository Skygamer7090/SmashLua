function Exit_Action(content) 
    
end

function Load_Player_Select()
    
end

local gm = {
    ["Start"] = {
        ["Players Select"] = Load_Player_Select,
        ["Extras"] = {

        }
    },
    ["Exit"] = Exit_Action
}



function gm:buttonPress(buttonName, contentTab)
    local newMenu = {}

    if type(gm[buttonName]) == "function" then
        gm[buttonName](contentTab)
    else
        newMenu = gm[buttonName]
    end

    contentTab = newMenu
end

return gm