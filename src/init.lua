local ParseChartData = require(script.ParseChartData)
local Symbol = require(script.Symbol)

local ERR_CAT_MISSING = "Unable to process chart data: missing category %q"
local ERR_FIELD_MISSING = "Unable to process chart data: missing key %q in category %q"

local fmt = string.format

local Chart = {}

Chart.__index = Chart
Chart.__symbol = Symbol.new("Chart")

function Chart.new(chart: string, maxChords: number)
    local self = setmetatable({}, Chart)

    local chartData = ParseChartData.parse(chart, maxChords)
    self:_populateWithChartData(chartData)

    return self
end

function Chart:_populateWithChartData(chartData)
    local difficulties = {}

    for key, values in pairs(chartData) do
        if key == "Song" then
            local resolution = assert(values.Resolution, fmt(ERR_FIELD_MISSING, "Resolution", "Song"))

            if resolution then
                self.Resolution = tonumber(resolution)
            end
        elseif key == "SyncTrack" then
            self.BPM = {
                string.match(assert(values["0"], fmt(ERR_FIELD_MISSING, "0", "SyncTrack")), "%d+") / 1000,
            }
        elseif ParseChartData.getDifficulty(key) ~= nil then
            local difficulty = ParseChartData.getDifficulty(key)
            difficulties[difficulty] = values
        end
    end

    assert(self.Resolution, fmt(ERR_CAT_MISSING, "Song"))
    assert(self.BPM, fmt(ERR_CAT_MISSING, "SyncTrack"))

    if not (difficulties.Easy or difficulties.Medium or difficulties.Hard or difficulties.Expert) then
        error(fmt(ERR_CAT_MISSING, "one of <EasyXXX | MediumXXX | HardXXX | ExpertXXX>"), 2)
    end

    local difficultyArrays = {}
    local finalNote = 0

    for difficulty, values in pairs(difficulties) do
        local difficultyArray = {}

        for key, value in pairs(values) do
            local beatsRelative = tonumber(key)
            local beat = beatsRelative / self.Resolution

            local currentNote = {
                BeatRelative = beatsRelative,
                Beat = beat,
                TimePosition = (beat / self.BPM[1]) * 60,
                Sustain = value.Sustain and {
                    LengthRelative = value.Sustain,
                    LengthBeats = value.Sustain / self.Resolution,
                    TimeLength = ((value.Sustain / self.Resolution) / self.BPM[1]) * 60,
                },
                Chord = value.Chord,
            }

            table.insert(difficultyArray, currentNote)

            local noteEnd = currentNote.TimePosition + (currentNote.Sustain and currentNote.Sustain.TimeLength or 0)

            if finalNote < noteEnd then
                finalNote = noteEnd
            end
        end

        table.sort(difficultyArray, function(a, b)
            return a.Beat < b.Beat
        end)

        difficultyArrays[difficulty] = difficultyArray
    end

    self.Difficulty = difficultyArrays
    self.MaxDuration = finalNote
end

function Chart.is(object: any): boolean
    return type(object) == "table" and (Symbol.is(object.__symbol) and object.__symbol == Chart.__symbol)
end

return Chart
