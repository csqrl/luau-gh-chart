--!strict
--[[
    Converts an Array of Arrays to a Dictionary, where sub-Arrays
    are key-value pairs; ex. `{{ "key", "value" }, { "key2", "value2" }}`
]]
type Dictionary<Key, Value> = ({ [Key]: Value })
type Array<T> = (Dictionary<number, T>)

local fmt = string.format
local ERR_TYPE = "toDictionary expected %q (argument #%d) to be of type %s, but got %q (%s)"

local function toDictionary(list: Array<Array<any>>): Dictionary<any, any>
    assert(type(list) == "table", fmt(ERR_TYPE, "list", 1, "table", tostring(list), typeof(list)))

    local new = {}

    for _, value in ipairs(list) do
        if type(value) ~= "table" then
            continue
        end

        new[value[1]] = value[2]
    end

    return new
end

return toDictionary
