--!strict
--[[
    Replaces each entry with the result of `callback`
]]
type Array<T> = ({ [number]: T })

local fmt = string.format
local ERR_TYPE = "map expected %q (argument #%d) to be of type %s, but got %q (%s)"

local function map(
    list: Array<any>,
    callback: (any, number?) -> any
): Array<any>
    assert(type(list) == "table", fmt(ERR_TYPE, "list", 1, "table", tostring(list), typeof(list)))
    assert(type(callback) == "function", fmt(ERR_TYPE, "callback", 2, "function", tostring(callback), typeof(callback)))

    local new = {}

    for index, value in ipairs(list) do
        new[index] = callback(value, index)
    end

    return new
end

return map
