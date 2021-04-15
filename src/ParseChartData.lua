--!strict
--[[
    Parses string data from `.chart` files and returns its
    data as a Dictionary (where category headers are keys)
]]

local Dictionary = require(script.Parent.Dictionary)
local String = require(script.Parent.String)
local List = require(script.Parent.List)

local ERR_TYPE_NOTES = "Error parsing notes: Value at position #%d should be of type %s, but got %q (%s)"

local fmt = string.format
local match = string.match
local split = string.split
local find = string.find
local gsub = string.gsub

local clamp = math.clamp
local floor = math.floor

local function getDifficulty(value: string): string?
    if match(value, "Easy%w+") then
        return "Easy"
    elseif match(value, "Medium%w+") then
        return "Medium"
    elseif match(value, "Hard%w+") then
        return "Hard"
    elseif match(value, "Expert%w+") then
        return "Expert"
    end
end

local function ParseChartData(chart: string, maxChords: number?)
    local categories = split(chart, "[")
    local chartData = {}

    if type(maxChords) ~= "number" then
        maxChords = 4
    end

    for _, category in ipairs(categories) do
        local categoryTitle = match(category, "%w+")
        local categoryData: any = match(category, "%b{}")

        if not categoryData then
            continue
        end

        categoryData = split(categoryData, "\n")

        categoryData = List.filter(categoryData, function(value)
            return find(value, "=", 0, true) ~= nil
        end)

        categoryData = List.map(categoryData, function(entry)
            local data = List.map(split(entry, "="), function(value)
                local trimmed = String.trim(value)
                local normalised = trimmed

                if match(normalised, "%b\"\"") then
                    normalised = gsub(normalised, "\"", "")
                end

                return normalised
            end)

            data = List.filter(data, function(value)
                return #value > 0
            end)

            return data
        end)

        if categoryTitle == "SyncTrack" then
            categoryData = List.filter(categoryData, function(entry)
                return match(tostring(entry[2]), "B %d+") ~= nil
            end)
        end

        categoryData = List.toDictionary(categoryData)

        if getDifficulty(categoryTitle) ~= nil then
            categoryData = Dictionary.map(categoryData, function(value)
                local values = split(value, " ")

                values[2] = tonumber(values[2])
                values[3] = tonumber(values[3])

                assert(type(values[2]) == "number", fmt(ERR_TYPE_NOTES, 2, "number", tostring(values[2]), typeof(values[2])))
                assert(type(values[3]) == "number", fmt(ERR_TYPE_NOTES, 3, "number", tostring(values[3]), typeof(values[3])))

                -- Sustain would usually be represented by "N" or "S" in values[1]; however,
                -- it's safe to assume that if length is greater than 0, then the player is
                -- expected to hold the button (chord), rather than tap

                -- Chords can be higher than `maxChords` on instruments such as Drums, but we only want
                -- `maxChords` buttons max., so we'll perform a modulus operation on the chord to ensure
                -- that it keeps it within our requirements (NB. `maxChords` is "4" by default)

                return {
                    Sustain = values[3] > 0 and values[3] or nil,
                    Chord = clamp(floor((values[2] + 1) % (maxChords + 1)), 1, maxChords),
                }
            end)
        end

        chartData[categoryTitle] = categoryData
    end

    return chartData
end

return {
    parse = ParseChartData,
    getDifficulty = getDifficulty,
}
