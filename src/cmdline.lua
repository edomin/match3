local cmdline = {}

function cmdline:new()
    local obj= {}
    obj.colors = false

    setmetatable(obj, self)
    self.__index = self

    return obj
end

function cmdline:process_args()
    if #arg > 0 then
        if arg[1] == "-c" then
            self.colors = true
        else
            print("Incorrect arguments.")
            self:print_help();

            return false
        end
    end

    return true
end

function cmdline:use_colors()
    return self.colors
end

function cmdline:print_help()
    print(
[[
Usage:
lua main.lua [-c]
-c -- Color mode
]]
    )
end

return cmdline
