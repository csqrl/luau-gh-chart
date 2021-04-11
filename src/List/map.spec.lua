return function()
    local map = require(script.Parent.map)
    local array = { 10, 20, 30, 40, 50 }

    it("updates values in an array", function()
        local new = map(array, function(value)
            return value + 5
        end)

        expect(new).to.be.ok()
        expect(new[1]).to.equal(15)
    end)

    it("preserves the order of entries", function()
        local new = map(array, function(value)
            return value + 10
        end)

        expect(new).to.be.ok()
        expect(#new).to.equal(#array)

        expect(new[1]).to.equal(array[1] + 10)
        expect(new[2]).to.equal(array[2] + 10)
        expect(new[3]).to.equal(array[3] + 10)
    end)

    it("does not overwrite the original array", function()
        local new = map(array, function(value)
            return value + 1
        end)

        expect(new).to.be.ok()
        expect(new).never.to.equal(array)
    end)

    it("throws if array is not a table", function()
        expect(pcall(map, Color3.new())).to.equal(false)
    end)

    it("throws if callback is not a function", function()
        expect(pcall(map, {}, game)).to.equal(false)
    end)
end
