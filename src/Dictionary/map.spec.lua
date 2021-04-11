return function()
    local map = require(script.Parent.map)

    local dictionary = {
        promised = 10,
        fun = 20,
        thick = 30,
        cake = 40,
        ride = 50,
    }

    it("updates values in an dictionary", function()
        local new = map(dictionary, function(value)
            return value + 5
        end)

        expect(new).to.be.ok()

        expect(new.promised).to.equal(15)
        expect(new.cake).to.equal(45)
    end)

    it("does not overwrite the original dictionary", function()
        local new = map(dictionary, function(value)
            return value + 1
        end)

        expect(new).to.be.ok()
        expect(new).never.to.equal(dictionary)
    end)

    it("throws if dictionary is not a table", function()
        expect(pcall(map, Color3.new())).to.equal(false)
    end)

    it("throws if callback is not a function", function()
        expect(pcall(map, {}, game)).to.equal(false)
    end)
end
