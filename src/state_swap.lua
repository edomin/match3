local state = require "state"

local state_swap = {}
setmetatable(state_swap ,{__index = state})

function state_swap:run(ctx)
    local model = ctx:get_model()

    if not model:move(ctx:get_swap()) then
        print("No matches")
        return "INPUT"
    end
    model:dump()

    return self.next
end

return state_swap
