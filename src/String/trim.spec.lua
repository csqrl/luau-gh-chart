return function()
    local trim = require(script.Parent.trim)

    local spacesStart = "    roblox"
    local spacesEnd = "roblox    "
    local spacesBoth = "    roblox    "
    local tabsStart = "\troblox"

    it("removes whitespace from a string", function()
        expect(trim(spacesStart)).to.equal("roblox")
        expect(trim(spacesEnd)).to.equal("roblox")
        expect(trim(spacesBoth)).to.equal("roblox")
        expect(trim(tabsStart)).to.equal("roblox")
    end)

    it("throws if `value` is not a string", function()
        expect(pcall(trim, true)).to.equal(false)
    end)
end
