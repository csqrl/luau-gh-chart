local Symbol = {}

Symbol.__index = Symbol

function Symbol.new(name: string): Symbol
    assert(type(name) == "string", "Symbol name must be a string")

    local self = setmetatable({}, Symbol)

    self.Name = name
    self.ClassName = "Symbol"

    return self
end

function Symbol.is(object: any): boolean
    return type(object) == "table" and getmetatable(object) == Symbol
end

function Symbol:__tostring()
    return string.format("Symbol<%s>", self.Name)
end

return Symbol
