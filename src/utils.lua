return {
    split = function(str, delim)
        result = {}

        for occurence in string.gmatch(str, "[^" .. delim .. "]+") do
            result[#result + 1] = occurence
        end

        return result
    end
}
