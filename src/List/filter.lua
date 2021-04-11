--!strict
--[[
    Filters an array by calling `predicate` on each entry.

    If predicate returns true, the entry will be added to the new array.
    If predicate returns false, the entry will be removed from the new array.
]]
type Array<T> = ({ [number]: T })

local fmt = string.format
local ERR_TYPE = "filter expected %q (argument #%d) to be of type %s, but got %q (%s)"

local function filter(
    list: Array<any>,
    predicate: (any, number?) -> boolean
): Array<any>
    assert(type(list) == "table", fmt(ERR_TYPE, "list", 1, "table", tostring(list), typeof(list)))
    assert(type(predicate) == "function", fmt(ERR_TYPE, "predicate", 2, "function", tostring(predicate), typeof(predicate)))

    local new = {}

    for index, value in ipairs(list) do
        if predicate(value, index) == true then
            table.insert(new, value)
        end
    end

    return new
end

return filter
