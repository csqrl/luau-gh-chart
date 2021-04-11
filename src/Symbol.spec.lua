return function()
    local Symbol = require(script.Parent.Symbol)

    it("creates a new Symbol object", function()
        local symbol = Symbol.new("test")

        expect(symbol).to.be.ok()
    end)

    it("identifies Symbols with Symbol.is", function()
        local symbol = Symbol.new("test")

        expect(symbol).to.be.ok()

        expect(Symbol.is(symbol)).to.equal(true)
        expect(Symbol.is(123)).to.equal(false)
    end)

    it("throws if Symbol name is not a string", function()
        expect(pcall(Symbol.new)).to.equal(false)
    end)
end
