function Exit_Action(content) 
    
end

local gm = {
    ["Start"] = {
        ["Players Select"] = {

        },
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