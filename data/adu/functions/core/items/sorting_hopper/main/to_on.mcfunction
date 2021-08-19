tag @s add adu.sorting_hopper.on

execute if data storage adu:items sorting_hopper{slot:1b} run function adu:core/items/sorting_hopper/main/to_on.south
execute if data storage adu:items sorting_hopper{slot:2b} run function adu:core/items/sorting_hopper/main/to_on.west
execute if data storage adu:items sorting_hopper{slot:3b} run function adu:core/items/sorting_hopper/main/to_on.north
execute if data storage adu:items sorting_hopper{slot:4b} run function adu:core/items/sorting_hopper/main/to_on.east

data modify storage adu:items sorting_hopper.items[{Slot:5b}].Slot set value 0b