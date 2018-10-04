local c = require("Class")
local col = c:derive("Collider")

function col:new(colmap)
    self.cols = {}
    self:GetCols(colmap)
end 

function col:GetCols(colmap)
    for i,v in pairs(colmap) do
        if  v.x ~= nil and
            v.y ~= nil and
            v.w ~= nil and
            v.h ~= nil then 
            table.insert(self.cols, v)
            print(v.x, v.y, v.w, v.h)
        end 
    end
end

function col:drawDEBUG()
    love.graphics.setColor(1,0,0,0.4)
    for i,v in pairs(self.cols) do
        love.graphics.rectangle("fill", v.x - v.w/2, v.y - v.h/2, v.w, v.h)
    end
end

return col