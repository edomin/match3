local cell = require 'cell'

local field = {
    WIDTH = 10,
    HEIGHT = 10,
    COLORS_COUNT = 6,

    VSWAPS = {
        -- #0
        -- #0
        -- 0#
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 1, col_offset = 0},
            {row_offset = 2, col_offset = 1},
        },
        -- #0
        -- 0#
        -- #0
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 1, col_offset = 1},
            {row_offset = 2, col_offset = 0},
        },
        -- 0#
        -- #0
        -- #0
        {
            {row_offset = 0, col_offset = 1},
            {row_offset = 1, col_offset = 0},
            {row_offset = 2, col_offset = 0},
        },
        -- 0#
        -- 0#
        -- #0
        {
            {row_offset = 0, col_offset = 1},
            {row_offset = 1, col_offset = 1},
            {row_offset = 2, col_offset = 0},
        },
        -- 0#
        -- #0
        -- 0#
        {
            {row_offset = 0, col_offset = 1},
            {row_offset = 1, col_offset = 0},
            {row_offset = 2, col_offset = 1},
        },
        -- #0
        -- 0#
        -- 0#
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 1, col_offset = 1},
            {row_offset = 2, col_offset = 1},
        },
    },
    HSWAPS = {
        -- ##0
        -- 00#
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 0, col_offset = 1},
            {row_offset = 1, col_offset = 2},
        },
        -- #0#
        -- 0#0
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 1, col_offset = 1},
            {row_offset = 0, col_offset = 2},
        },
        -- 0##
        -- #00
        {
            {row_offset = 1, col_offset = 0},
            {row_offset = 0, col_offset = 1},
            {row_offset = 0, col_offset = 2},
        },
        -- 00#
        -- ##0
        {
            {row_offset = 1, col_offset = 0},
            {row_offset = 1, col_offset = 1},
            {row_offset = 0, col_offset = 2},
        },
        -- 0#0
        -- #0#
        {
            {row_offset = 1, col_offset = 0},
            {row_offset = 0, col_offset = 1},
            {row_offset = 1, col_offset = 2},
        },
        -- #00
        -- 0##
        {
            {row_offset = 0, col_offset = 0},
            {row_offset = 1, col_offset = 1},
            {row_offset = 1, col_offset = 2},
        },
    },
}

function field:new()
    local obj= {}

    obj.crystals = {}
    for row = 1, field.HEIGHT, 1 do
        obj.crystals[row] = {}
        for col = 1, field.WIDTH, 1 do
            obj.crystals[row][col] = math.random(1, field.COLORS_COUNT)
        end
    end

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function field:get_crystal(row, col)
    return self.crystals[row][col]
end

function field:hor_3_in_line_equals(row, col)
    return self.crystals[row][col] ~= 0
     and self.crystals[row][col] == self.crystals[row][col + 1]
     and self.crystals[row][col] == self.crystals[row][col + 2]
end

function field:vert_3_in_line_equals(row, col)
    return self.crystals[row][col] ~= 0
     and self.crystals[row][col] == self.crystals[row + 1][col]
     and self.crystals[row][col] == self.crystals[row + 2][col]
end

function field:get_match()
    local result = {}

    for row = 1, field.HEIGHT, 1 do
        for col = 1, field.WIDTH - 2, 1 do
            if self:hor_3_in_line_equals(row, col) then
                table.insert(result, cell:new(row, col))
                table.insert(result, cell:new(row, col + 1))
                table.insert(result, cell:new(row, col + 2))
            end
        end
    end

    for row = 1, field.HEIGHT - 2, 1 do
        for col = 1, field.WIDTH, 1 do
            if self:vert_3_in_line_equals(row, col) then
                table.insert(result, cell:new(row, col))
                table.insert(result, cell:new(row + 1, col))
                table.insert(result, cell:new(row + 2, col))
            end
        end
    end

    if #result == 0 then
        return nil
    end

    -- We can not use for loop here because we need change loop counter inside
    -- loop
    local i = 1
    while i <= #result - 1 do
        for j = i + 1, #result, 1 do
            if result[i]:equal(result[j]) then
                table.remove(result, i)
                i = i - 1
                break
            end
        end
        i = i + 1
    end

    return result
end

function field:has_swaps_in_pos(row, col, offsets_table)
    local row1, col1, row2, col2, row3, col3

    for i = 1, #offsets_table, 1 do
        row1 = row + offsets_table[i][1].row_offset
        col1 = col + offsets_table[i][1].col_offset
        row2 = row + offsets_table[i][2].row_offset
        col2 = col + offsets_table[i][2].col_offset
        row3 = row + offsets_table[i][3].row_offset
        col3 = col + offsets_table[i][3].col_offset

        if self.crystals[row1][col1] == self.crystals[row2][col2]
         and self.crystals[row1][col1] == self.crystals[row3][col3] then
            return true
        end
    end

    return false
end

function field:has_swaps()
    for row = 1, field.HEIGHT - 2, 1 do
        for col = 1, field.WIDTH - 1, 1 do
            if self:has_swaps_in_pos(row, col, field.VSWAPS) then
                return true
            end
        end
    end

    for row = 1, field.HEIGHT - 1, 1 do
        for col = 1, field.WIDTH - 2, 1 do
            if self:has_swaps_in_pos(row, col, field.HSWAPS) then
                return true
            end
        end
    end

    return false
end

function field:has_empty_cells()
    for row = 1, field.HEIGHT, 1 do
        for col = 1, field.WIDTH, 1 do
            if self.crystals[row][col] == 0 then
                return true
            end
        end
    end

    return false
end

function field:shuffle()
    for row = 1, field.HEIGHT, 1 do
        for col = 1, field.WIDTH, 1 do
            local row2 = math.random(1, field.HEIGHT)
            local col2 = math.random(1, field.WIDTH)

            self.crystals[row][col], self.crystals[row2][col2]
             = self.crystals[row2][col2], self.crystals[row][col]
        end
    end
end

function field:swap(from, to)
    local row, col = from:get_coords()
    local dstrow, dstcol = to:get_coords()

    self.crystals[row][col], self.crystals[dstrow][dstcol]
     = self.crystals[dstrow][dstcol], self.crystals[row][col]
end

function field:remove_cells(cells)
    local points = 0

    for i = 1, #cells, 1 do
        self.crystals[cells[i]:get_row()][cells[i]:get_col()] = 0
        points = points + 1
    end

    return points
end

function field:lift_hole(initial_row, col)
    for row = initial_row, 2, -1 do
        self.crystals[row][col], self.crystals[row - 1][col]
         = self.crystals[row - 1][col], self.crystals[row][col]
    end
end

function field:lift_holes_in_col(col)
    for row = 2, field.HEIGHT, 1 do
        if self.crystals[row][col] == 0 then
            self:lift_hole(row, col)
        end
    end
end

function field:lift_holes()
    for col = 0, field.WIDTH, 1 do
        self:lift_holes_in_col(col)
    end
end

function field:fill_holes()
    for row = 1, field.HEIGHT, 1 do
        for col = 1, field.WIDTH, 1 do
            if self.crystals[row][col] == 0 then
                self.crystals[row][col] = math.random(1, field.COLORS_COUNT)
            end
        end
    end
end

return field
