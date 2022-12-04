local fld = require 'field'

local model = {}

function model:new(ctx)
    local obj= {}
    obj.ctx = ctx

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function model:init()
    self.field = fld:new()
    while self.field:get_match() or not self.field:has_swaps() do
        self:mix()
    end
end

function model:tick()
    match = self.field:get_match()

    if match then
        self.ctx:add_points(self.field:remove_cells(match))
        return true
    end

    if self.field:has_empty_cells() then
        self.field:lift_holes()
        self:dump()
        self.field:fill_holes()
        return true
    end

    return false
end

function model:move(from, to)
    self.field:swap(from, to)

    if not self.field:get_match() then
        self.field:swap(from, to)

        return false
    end

    return true
end

function model:mix()
    self.field:shuffle()
end

function model:dump()
    self.ctx:get_visualization():draw(self.field, self.ctx:get_points())
end

return model
