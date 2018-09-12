local c = require("Class")
local Menu = c:derive("Menu")

function searchTable(table, to_find)
    for i,v in pairs(table) do
        if i == to_find then
            return true 
        end
    end 
    return false
end

function GetParentTable(orignalTab, currentTab) 
    
    print(searchTable(originalTab, "Start"))
    while searchTable(originalTab, currentTab) do

    end

    return 
end

function buttonPress(buttonName, contentTab)
    
    print("--- new button pressed ---")
    for i,v in pairs(contentTab) do
        print(i)
    end
    
    local menu_type = type(contentTab[buttonName])
    
    if menu_type == "function" then
        contentTab[buttonName](contentTab)

        -- returns the table unchanged
        return contentTab
    elseif menu_type == "table" then 
        -- returns the new table
        return contentTab[buttonName]
    end
end

function Menu:new()
    -- container for all menus
    self.menus = {}
    AddMenu(self.menus, "Menus/game_menu")

end 

function Menu:update(dt)

end

function Menu:draw()
    for i,v in pairs(self.menus) do
        
    end
end

function love.mousepressed(x, y, b)

end

function AddMenu(menuTab, menuLink)
    --loads the menu table
    local game_menu = require(menuLink)

    --final insert
    table.insert(menuTab, game_menu)
end

return Menu