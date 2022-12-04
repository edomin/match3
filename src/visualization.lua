local fld = require "field"

local visualization = {}

function visualization:new(use_colors)
    local obj= {}
    if use_colors then
        obj.icons = {
            [0] = " ",
            "\x1b[31m*\x1b[0m",
            "\x1b[32m*\x1b[0m",
            "\x1b[33m*\x1b[0m",
            "\x1b[34m*\x1b[0m",
            "\x1b[35m*\x1b[0m",
            "\x1b[37m*\x1b[0m"
        }
    else
        obj.icons = {[0] = " ", "A", "B", "C", "D", "E", "F"}
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function visualization:draw(field, points)
    io.write("  ")
    for i = 1, fld.WIDTH, 1 do
        io.write(i - 1)
    end
    io.write("    Score: ", points, "\n")

    io.write(" +")
    for i = 1, fld.WIDTH, 1 do
        io.write("-")
    end
    io.write("\n")

    for row = 1, fld.HEIGHT, 1 do
        io.write(row - 1, "|")
        for col = 1, fld.WIDTH, 1 do
            io.write(self.icons[field:get_crystal(row, col)])
        end
        io.write("\n")
    end
end

return visualization
