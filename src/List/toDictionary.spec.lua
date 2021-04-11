return function()
    local toDictionary = require(script.Parent.toDictionary)

    local array = {
        { "signal", "spin" },
        { "loss", "gentle" },
        { "lesson", "charge" },
        { "pen", "then" },
        { "zoo", "season" },
    }

    it("converts array pairs to a dictionary", function()
        local new = toDictionary(array)

        expect(new).to.be.ok()
        expect(#new).to.equal(0)
        expect(new.signal).to.equal("spin")
    end)

    it("does not overwrite the original array", function()
        local new = toDictionary(array)

        expect(new).to.be.ok()
        expect(new).never.to.equal(array)
    end)

    it("throws if array is not a table", function()
        expect(pcall(toDictionary, Color3.new())).to.equal(false)
    end)

    it("skips non-table entries", function()
        local new = toDictionary({
            { "manufacturing", "half" },
            true,
            { "travel", "family" }
        })

        expect(new).to.be.ok()
        expect(new.travel).to.equal("family")
    end)

    it("throws if \"key\" (`entry[1]`) is nil", function()
        local testArray = {
            { "across", "bridge" },
            { "mission", nil },
            { nil, "cabin" },
        }

        expect(pcall(toDictionary, testArray)).to.equal(false)
    end)
end
