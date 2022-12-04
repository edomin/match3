local state = require "state"

local state_init = {}
setmetatable(state_init ,{__index = state})

function state_init:run(ctx)
    local model = ctx:get_model()

    model:init()
    model:dump()

    return self.next
end

return state_init
