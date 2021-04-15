local ServerScripts = game:GetService("ServerScriptService")
local SampleChart = require(ServerScripts["sample.chart"])

return function()
    local Chart = require(script.Parent)

    it("creates a Chart instance from data", function()
        local chart = Chart.new(SampleChart)

        expect(chart).to.be.ok()
        expect(Chart.is(chart)).to.equal(true)
    end)

    describe("Chart instance", function()
        local chart = Chart.new(SampleChart)

        it("calculates BPM and MaxDuration", function()
            expect(chart.MaxDuration).to.be.near(63.125, .001)
            expect(chart.BPM[1]).to.equal(120)
        end)

        it("calculates timings for each note and maintains order", function()
            local easyNotes = chart.Difficulty.Easy

            expect(easyNotes).to.be.a("table")
            expect(easyNotes[1]).to.be.a("table")

            expect(easyNotes[1].Beat).to.equal(1)
            expect(easyNotes[1].Chord).to.equal(2)
            expect(easyNotes[1].TimePosition).to.be.near(.5, .001)
        end)

        it("can be identified as a chart instance", function()
            expect(Chart.is(chart)).to.equal(true)
        end)
    end)
end
