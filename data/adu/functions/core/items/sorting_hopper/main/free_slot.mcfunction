data modify storage adu:items sorting_hopper.free set from storage adu:items sorting_hopper.items[{Slot:0b}].Count

execute if data storage adu:items sorting_hopper{free:1b} if data storage adu:items sorting_hopper.items[{Slot:1b}].Count run data modify storage adu:items sorting_hopper.slot set value 1b
execute if data storage adu:items sorting_hopper{free:2b} if data storage adu:items sorting_hopper.items[{Slot:2b}].Count run data modify storage adu:items sorting_hopper.slot set value 2b
execute if data storage adu:items sorting_hopper{free:3b} if data storage adu:items sorting_hopper.items[{Slot:3b}].Count run data modify storage adu:items sorting_hopper.slot set value 3b
execute if data storage adu:items sorting_hopper{free:4b} if data storage adu:items sorting_hopper.items[{Slot:4b}].Count run data modify storage adu:items sorting_hopper.slot set value 4b

execute unless data storage adu:items sorting_hopper{slot:0b} run tag @s add adu.sorting_hopper.free