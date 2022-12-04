local context = {}

function context:new()
    local obj= {}

    obj.swap = {}
    obj.points = 0

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function context:set_swap(from, to)
    self.swap.from = from
    self.swap.to = to

    local row, col = from:get_coords()
    local dstrow, dstcol = to:get_coords()
end

function context:set_model(model)
    self.model = model
end

function context:set_visualization(visualization)
    self.visualization = visualization
end

function context:add_points(pts)
    self.points = self.points + pts
end

function context:get_model()
    return self.model
end

function context:get_visualization()
    return self.visualization
end

function context:get_swap()
    return self.swap.from, self.swap.to
end

function context:get_points()
    return self.points
end

return context
