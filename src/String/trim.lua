--[[
    Removes whitespace from the beginning and end of strings
]]

local fmt = string.format
local gsub = string.gsub

local ERR_TYPE = "trim expected %q (argument #%d) to be of type %s, but got %q (%s)"

local function trim(value: string): string
    assert(type(value) == "string", fmt(ERR_TYPE, "value", 1, "string", tostring(value), typeof(value)))

    return gsub(value, "^%s*(.-)%s*$", "%1")
end

return trim
