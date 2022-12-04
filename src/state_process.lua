local state = require "state"

local state_process = {}
setmetatable(state_process ,{__index = state})

function state_process:run(ctx)
    local model = ctx:get_model()

    while model:tick() do
        model:dump()
    end

    return self.next
end

return state_process
