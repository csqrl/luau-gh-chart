<!-- Link References -->
[CI Status]: https://github.com/ClockworkSquirrel/luau-gh-chart/actions
[Latest Release]: https://github.com/ClockworkSquirrel/luau-gh-chart/releases/latest

# luau-chart
[![CI](https://github.com/ClockworkSquirrel/luau-gh-chart/actions/workflows/ci.yml/badge.svg)][CI Status]
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/clockworksquirrel/luau-gh-chart?label=latest+release)][Latest Release]

Parses `.chart` files designed for games such as Guitar Hero into a format usable by Roblox games.

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
- `Chart.BPM: number` - Beats per minute
- `Chart.Difficulty: Dictionary<string, Array<Note>>` - A Dictionary containing the notes for each parsed difficulty level. See the **`Note`** section below for further information.
- `Chart.MaxDuration: number` - An estimation of the length of the song in minutes; this is calculated by dividing the last beat of the longest difficulty array by BPM.

### Note
A note represents each action a player is expected to perform on a specified beat/time position. It is a Dictionary which contains the following properties:

- `Note.BeatRelative: number` - The beat on which this action occurs in raw format
- `Note.Beat: number` - The beat (normalised) on which this action occurs
- `Note.TimePosition: number` - The time (in minutes) at which this action occurs
- `Note.Sustain: boolean` - Whether the player is expected to hold the note (sustain; `true`), or strum/tap (`false`)
- `Note.Chord: number` - The index of the action to perform (in the range of `1-4`, unless specified otherwise)

The notes array is sorted by the `Beat` property in ascending order.

## Example Chart Instance
Parsed from [`/test/sample.chart.lua`](/test/sample.chart.lua).

```lua
{
  ["BPM"] = 120,
  ["Difficulty"] =  ▼  {
     ["Easy"] =  ▼  {
        [1] =  ▼  {
           ["Beat"] = 1,
           ["BeatRelative"] = 192,
           ["Chord"] = 2,
           ["Sustain"] = true,
           ["TimePosition"] = 0.008
        },
        [2] =  ▶ {...},
        [3] =  ▶ {...},
        [4] =  ▶ {...},
        [5] =  ▶ {...},
        [6] =  ▶ {...},
        [7] =  ▶ {...},
        [8] =  ▶ {...},
        [9] =  ▶ {...},
        [10] =  ▶ {...},
        [11] =  ▶ {...},
        [12] =  ▶ {...},
        [13] =  ▶ {...},
        [14] =  ▶ {...},
        [15] =  ▶ {...},
        [16] =  ▶ {...},
        [17] =  ▶ {...},
        [18] =  ▶ {...},
        [19] =  ▶ {...},
        [20] =  ▶ {...},
        [21] =  ▶ {...},
        [22] =  ▶ {...},
        [23] =  ▶ {...},
        [24] =  ▶ {...},
        [25] =  ▶ {...},
        [26] =  ▶ {...},
        [27] =  ▶ {...},
        [28] =  ▶ {...},
        [29] =  ▶ {...},
        [30] =  ▶ {...},
        [31] =  ▶ {...},
        [32] =  ▶ {...},
        [33] =  ▶ {...},
        [34] =  ▶ {...},
        [35] =  ▶ {...},
        [36] =  ▶ {...},
        [37] =  ▶ {...},
        [38] =  ▶ {...},
        [39] =  ▶ {...},
        [40] =  ▶ {...},
        [41] =  ▶ {...},
        [42] =  ▶ {...},
        [43] =  ▶ {...},
        [44] =  ▶ {...},
        [45] =  ▶ {...},
        [46] =  ▶ {...},
        [47] =  ▶ {...},
        [48] =  ▶ {...},
        [49] =  ▶ {...},
        [50] =  ▶ {...}
     }
  },
  ["MaxDuration"] = 1.038,
  ["Resolution"] = 192
}
```

## References
- **[Note Chart Syntax]** @GameZelda (30th March 2007) - https://www.scorehero.com/forum/viewtopic.php?p=823618#823618
- **[Chorus]** Custom Clone Hero Charts - https://chorus.fightthe.pw/
