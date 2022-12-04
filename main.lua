package.path = "./src/?.lua;" .. package.path

cmdl = require "cmdline"
context = require "ctx"
mdl = require "model"
sm = require "state_machine"
vis = require "visualization"

math.randomseed(os.time())

cmdline = cmdl:new()
if not cmdline:process_args() then
    return
end

ctx = context:new()
visualization = vis:new(cmdline:use_colors())
model = mdl:new(ctx)
ctx:set_model(model)
ctx:set_visualization(visualization)
state_machine = sm:new(ctx)

state_machine:run()
