local ServerScripts = game:GetService("ServerScriptService")

return function()
    local Parser = require(script.Parent.ParseChartData)
    local chartString = require(ServerScripts["sample.chart"])

    it("parses .chart strings", function()
        local chartData = Parser.parse(chartString)

        expect(chartData).to.be.ok()
        expect(chartData).to.be.a("table")

        expect(chartData.Song).to.be.ok()
        expect(chartData.EasySingle).to.be.ok()
    end)

    it("parses note data", function()
        local chartData = Parser.parse(chartString)

        expect(chartData).to.be.ok()

        expect(chartData.EasySingle).to.be.a("table")
        expect(chartData.EasySingle["192"]).to.be.a("table")
        expect(chartData.EasySingle["192"].Chord).to.equal(2)
    end)

    it("identifies difficulty from string", function()
        expect(Parser.getDifficulty("HardDrums")).to.equal("Hard")
    end)
end
