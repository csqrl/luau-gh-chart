return function()
    local filter = require(script.Parent.filter)
    local array = { "water", "nervous", "box", "independent", "subject" }

    it("removes items from an array", function()
        local new = filter(array, function(entry)
            return #entry <= 5
        end)

        expect(new).to.be.ok()
        expect(#new).to.equal(2)
    end)

    it("preseves the order of entries", function()
        local new = filter(array, function(entry)
            return #entry > 3
        end)

        expect(new).to.be.ok()
        expect(#new).to.equal(4)

        expect(new[1]).to.equal("water")
        expect(new[2]).to.equal("nervous")
        expect(new[3]).to.equal("independent")
    end)

    it("does not overwrite the original array", function()
        local new = filter(array, function(value)
            return #value > 0
        end)

        expect(new).to.be.ok()
        expect(new).never.to.equal(array)
    end)

    it("throws if array is not a table", function()
        expect(pcall(filter, Color3.new())).to.equal(false)
    end)

    it("throws if predicate is not a function", function()
        expect(pcall(filter, {}, game)).to.equal(false)
    end)
end
