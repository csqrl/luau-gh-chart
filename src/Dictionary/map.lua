--!strict
--[[
    Replaces each entry with the result of `callback`
]]
type Dictionary<Key, Value> = ({ [Key]: Value })

local fmt = string.format
local ERR_TYPE = "map expected %q (argument #%d) to be of type %s, but got %q (%s)"

local function map(
    dictionary: Dictionary<any, any>,
    callback: (any, any?) -> any
): Dictionary<any, any>
    assert(type(dictionary) == "table", fmt(ERR_TYPE, "dictionary", 1, "table", tostring(dictionary), typeof(dictionary)))
    assert(type(callback) == "function", fmt(ERR_TYPE, "callback", 2, "function", tostring(callback), typeof(callback)))

    local new = {}

    for key, value in pairs(dictionary) do
        new[key] = callback(value, key)
    end

    return new
end

return map
