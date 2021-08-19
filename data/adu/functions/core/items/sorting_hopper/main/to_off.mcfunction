tag @s remove adu.sorting_hopper.on

execute if block ~ ~ ~ hopper[facing=south] run data modify storage adu:items sorting_hopper.items[{Slot:1b}].Slot set value 5b
execute if block ~ ~ ~ hopper[facing=south] run data modify storage adu:items sorting_hopper.items[{Slot:0b}].Slot set value 1b

execute if block ~ ~ ~ hopper[facing=west] run data modify storage adu:items sorting_hopper.items[{Slot:2b}].Slot set value 5b
execute if block ~ ~ ~ hopper[facing=west] run data modify storage adu:items sorting_hopper.items[{Slot:0b}].Slot set value 2b

execute if block ~ ~ ~ hopper[facing=north] run data modify storage adu:items sorting_hopper.items[{Slot:3b}].Slot set value 5b
execute if block ~ ~ ~ hopper[facing=north] run data modify storage adu:items sorting_hopper.items[{Slot:0b}].Slot set value 3b

execute if block ~ ~ ~ hopper[facing=east] run data modify storage adu:items sorting_hopper.items[{Slot:4b}].Slot set value 5b
execute if block ~ ~ ~ hopper[facing=east] run data modify storage adu:items sorting_hopper.items[{Slot:0b}].Slot set value 4b

data modify storage adu:items sorting_hopper.items[{Slot:5b}].Slot set value 0b

setblock ~ ~ ~ hopper[facing=down]