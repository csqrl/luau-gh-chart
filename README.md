<!-- Link References -->
[CI Status]: https://github.com/ClockworkSquirrel/luau-gh-chart/actions
[Latest Release]: https://github.com/ClockworkSquirrel/luau-gh-chart/releases/latest

# luau-chart
[![CI](https://github.com/ClockworkSquirrel/luau-gh-chart/actions/workflows/ci.yml/badge.svg)][CI Status]
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/clockworksquirrel/luau-gh-chart?label=latest+release)][Latest Release]

Parses `.chart` files (created with [Moonscraper Chart Editor](https://github.com/FireFox2000000/Moonscraper-Chart-Editor)) designed for games such as Guitar/Clone Hero into a format usable by Roblox games.

## Documentation
### `Chart.new(chart: string[, maxChords: number?]): Chart`
- **Param:** `chart: string` - A string representation of the `.chart` file to parse
- **Param** *(optional)***:** `maxChords: number?` - A number representing the max number of chords (player actions; usually buttons) to allow
- **Returns:** `Chart` - A new Chart instance constructed from the given data

See below for full information regarding Chart instances.

### `Chart.is(object: any): boolean`
- **Param:** `object: any` - The object to compare
- **Returns:** `boolean` - Whether the given object is a `Chart` instance

### Chart Instance
- `Chart.Resolution: number` - The resolution of the chart
- `Chart.BPM: Dictionary<number, number>` - Beats per minute at given intervals - **Currently only a single BPM throughout the song is supported (issue #1)**
- `Chart.Difficulty: Dictionary<string, Array<Note>>` - A Dictionary containing the notes for each parsed difficulty level. See the **`Note`** section below for further information
- `Chart.MaxDuration: number` - An estimation of the length of the song in seconds; this is calculated by taking the `TimePosition` of the final note of the longest difficulty, and adding its sustain length to it (if applicable)

### Note
A note represents each action a player is expected to perform on a specified beat/time position. It is a Dictionary which contains the following properties:

- `Note.BeatRelative: number` - The beat on which this action occurs in raw format
- `Note.Beat: number` - The beat (normalised) on which this action occurs
- `Note.TimePosition: number` - The time (in seconds) at which this action occurs
- `Note.Sustain: Sustain?` - Whether the player is expected to hold the note (`Sustain`) or strum/tap (`nil`) - See the **Sustain** section below for further information.
- `Note.Chord: number` - The index of the action to perform (in the range of `1-4`, unless specified otherwise)

The notes array is sorted by the `Beat` property in ascending order.

## Sustain
Sustain is a table that contains information about how long a player is expected to sustain a note for. If the player is not expected to sustain on a note, the "Sustain" field will be `nil`.

* `Sustain.LengthBeats: number` - The number of beats the note lasts for
* `Sustain.LengthRelative: number` - The number of beats the note lasts for in raw format
* `Sustain.TimeLength: number` - The length of time the note lasts for (in seconds)

## Example Chart Instance
Parsed from [`/test/sample.chart.lua`](/test/sample.chart.lua).

```lua
{
   ["BPM"] =  ▼  {
      [1] = 120
   },
   ["Difficulty"] =  ▼  {
      ["Easy"] =  ▼  {
         [1] =  ▼  {
            ["Beat"] = 1,
            ["BeatRelative"] = 192,
            ["Chord"] = 2,
            ["Sustain"] =  ▼  {
               ["LengthBeats"] = 3,
               ["LengthRelative"] = 576,
               ["TimeLength"] = 1.5
            },
            ["TimePosition"] = 0.5
         },
         [2] =  ▼  {
            ["Beat"] = 3.5,
            ["BeatRelative"] = 672,
            ["Chord"] = 1,
            ["Sustain"] =  ▼  {
               ["LengthBeats"] = 4.5,
               ["LengthRelative"] = 864,
               ["TimeLength"] = 2.25
            },
            ["TimePosition"] = 1.75
         },
         ...
         [48] =  ▶ {...},
         [49] =  ▶ {...},
         [50] =  ▶ {...}
      }
   },
   ["MaxDuration"] = 63.125,
   ["Resolution"] = 192
}
```

## References
- **[Note Chart Syntax]** @GameZelda (30th March 2007) - https://www.scorehero.com/forum/viewtopic.php?p=823618#823618
- **[Chorus]** Custom Clone Hero Charts - https://chorus.fightthe.pw/
