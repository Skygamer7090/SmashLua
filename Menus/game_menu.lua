function Exit_Action(content) 
    
end

local gm = {
    ["Start"] = {
        ["Players Select"] = {

        },
        ["Extras"] = {

        }
    }
    ["Exit"] = Exit_Action
}



function gm:buttonPress(buttonName, contentTab)
    if type(gm[buttonName]) == "function" then gm[buttonName](contentTab) 
    else 
    


    return newMenu
end

return gm