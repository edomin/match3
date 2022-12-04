local cell = {}

function cell:new(row, col)
    local obj= {}

    obj.row = row
    obj.col = col

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function cell:get_row()
    return self.row
end

function cell:get_col()
    return self.col
end

function cell:get_coords()
    return self.row, self.col
end

function cell:equal(other)
    local row_other, col_other = other:get_coords()

    return self.row == row_other and self.col == col_other
end

return cell
