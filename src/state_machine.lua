local state_init = require "state_init"
local state_input = require "state_input"
local state_process = require "state_process"
local state_swap = require "state_swap"

local state_machine = {}

function state_machine:new(ctx)
    local obj= {}

    obj.ctx = ctx
    obj.current_state = "INIT"
    obj.states = {}
    obj.states["INIT"] = state_init:new("INPUT")
    obj.states["INPUT"] = state_input:new("SWAP")
    obj.states["SWAP"] = state_swap:new("PROCESS")
    obj.states["PROCESS"] = state_process:new("INPUT")

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function state_machine:run()
    while self.current_state ~= "QUIT" do
        self.current_state = self.states[self.current_state]:run(self.ctx)
    end
end

return state_machine
