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

    for i,v in pairs(self.menus[1]) do
        print(i)
    end
end 

function Menu:update(dt)

end

function Menu:draw()

end

function love.mousepressed(x, y, b)

end

function AddMenu(menuTab, menuLink)
    --loads the menu table
    local game_menu = require(menuLink)

    --temp table for sorting the keys (not the tables) of the game_menu table
    local t = {}
    local t2 = {}


    for i,v in pairs(game_menu) do
        table.insert(t, i)
    end

    -- the sorting itself
    table.sort(t, 
        function(a,b) return a > b end)

    for i,v in pairs(t) do
        print(i,v)
        t2[v] = game_menu[v]
    end

    --final insert
    table.insert(menuTab, t2)
end

return Menu