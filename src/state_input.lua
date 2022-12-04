local cell = require "cell"
local inp = require "input"
local state = require "state"

local state_input = {}
setmetatable(state_input ,{__index = state})

local input = inp:new()

local dir_offset = {
    l = {row =  0, col = -1},
    r = {row =  0, col =  1},
    u = {row = -1, col =  0},
    d = {row =  1, col =  0},
}

function state_input:run(ctx)
    local model = ctx:get_model()
    local row, col, dstrow, dstcol

    while true do
        input:process()

        if input:is_incorrect() then
            print("Incorrect syntax.\nUsage:\n{q|(m 0..9 0..9 {l|r|u|d})}")
            goto continue
        end

        if input:has_quit() then
            return "QUIT"
        end

        row, col = input:get_coords()

        if row < 0 or row > 9 or col < 0 or col > 9 then
            print("Incorrect coords.")
            goto continue
        end

        local dir = input:get_direction()

        dstrow = row + dir_offset[dir].row;
        dstcol = col + dir_offset[dir].col;

        if dstrow < 0 or dstrow > 9 or dstcol < 0 or dstcol > 9 then
            print("Incorrect destination.")
            goto continue
        end

        break
        ::continue::
    end

    ctx:set_swap(cell:new(row + 1, col + 1), cell:new(dstrow + 1, dstcol + 1))

    return self.next
end

return state_input
