require "Const"

local c = require("Class")
local Menu = c:derive("Menu")
local Vector2 = require("Vector2")

local MENU_ITEM_OFFSET = 20
local Font = FONTS.MENU_FONT
local BUTTON_HEIGHT = Font:getHeight()
local BUTTON_WIDTH = 0






function Menu:new()
    -- container for all menus
    self.pos = Vector2(100,100)
    self.w = 300
    self.h = 300
    self.menus = {}
    self.menus_originals = {}
    self.menus_keys = {}
    self.buttons = {}
    self.currentMenu = 1
    self:AddMenu("Menus/game_menu")

end 

function Menu:buttonPress(buttonName, contentTab)
    local menu_type = type(contentTab[buttonName])
    
    if buttonName == "back" then
        local t2 = contentTab
        local t1 = self.menus_originals[self.currentMenu]
        return GetParentTable(t1, t2)
    elseif menu_type == "function" then
        contentTab[buttonName](contentTab)

        -- returns the table unchanged
        return contentTab
    elseif menu_type == "table" then 
        -- returns the new table
        return contentTab[buttonName]
    end
end

function searchTable(table, to_find)
    for i,v in pairs(table) do
        if v == to_find then
            return true 
        end
    end 
    return false
end

function GetParentTable(originalTab, currentTab) 
    print(type(originalTab), type(currentTab))
    local search = originalTab
    local currentList = listTableContent(search)
    print(unpack(currentList))
    local found = false

    -- stops when the index is found
    while not found do
        -- if its not in current search table goes on
        for i,v in pairs(search) do
            found = searchTable(search, currentTab)
        end


        for i,v in pairs(currentList) do
            if type(v) == "table" then
                search = search[i]
            end
        end

    end

    return search
end

function Menu:update(dt)

end

function Menu:draw()
    local index = 0
    local max_width = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        local text = love.graphics.newText(Font, i)
        local width = text:getWidth()

        if width > max_width then
            max_width = width
        end

        love.graphics.draw(text, self.pos.x, self.pos.y + index * MENU_ITEM_OFFSET)
        index = index + 1
    end

    BUTTON_WIDTH = max_width
end

function Menu:mousepressed(x, y, b)
    local index = 0
    for i,v in pairs(self.menus[self.currentMenu]) do
        local box = {
            x = self.pos.x,
            y = self.pos.y + index * MENU_ITEM_OFFSET,
            w = BUTTON_WIDTH,
            h = BUTTON_HEIGHT
        }
        
        if x > box.x and x < box.w + box.x and y > box.y and y < box.h + box.y then
            self.menus[self.currentMenu] = self:buttonPress(i, self.menus[self.currentMenu])
        end

        index = index + 1
    end
end

function Menu:AddMenu(menuLink)
    --loads the menu table
    local game_menu = require(menuLink)


    --final insert
    table.insert(self.menus, game_menu)
    table.insert(self.menus_originals, game_menu)
    table.insert(self.menus_keys, #self.menus)
end

function listTableContent(t)
    local c = {}
    for i,v in pairs(t) do
        table.insert(c, i)
    end
    return c
end

return Menu