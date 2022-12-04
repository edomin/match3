local utl = require "utils"

local input = {
    -- token indices
    TI_CMD = 1,
    TI_COL = 2,
    TI_ROW = 3,
    TI_DIR = 4,
}

function input:new()
    local obj= {}

    obj.quit = false
    obj.incorrect = false
    obj.row = 0
    obj.col = 0
    obj.dir = ""

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function input:has_quit()
    return self.quit
end

function input:is_incorrect()
    return self.incorrect
end

function input:get_coords()
    return self.row, self.col
end

function input:get_direction()
    return self.dir
end

function input:process()
    self.quit = false
    self.incorrect = false

    io.write("> ")
    str = io.read("*l")

    tokens = utl.split(str, " ")
    tokens_count = #tokens

    if tokens_count ~= 1 and tokens_count ~= 4 then
        goto error
    end

    if tokens_count == 1 then
        if tokens[input.TI_CMD] == "q" then
            self.quit = true
            return
        else
            goto error
        end
    end

    if tokens[input.TI_CMD] ~= "m" then
        goto error
    end

    self.col = tonumber(tokens[input.TI_COL])
    self.row = tonumber(tokens[input.TI_ROW])

    if not (self.col and self.row) then
        goto error
    end

    if not string.find("lrud", tokens[input.TI_DIR]) then
        goto error
    end

    self.dir = tokens[input.TI_DIR]

    do return end

::error::
    self.incorrect = true
    return
end

function input:run(model)
    -- pass
end

return input
