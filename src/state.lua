local state = {}

function state:new(next)
    local obj= {}

    obj.next = next

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function state:get_next()
    return self.next
end

function state:run(ctx)
    -- pass
end

return state
