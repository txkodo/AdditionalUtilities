tag @s remove adu.sorting_hopper.on
tag @s remove adu.sorting_hopper.free

execute if block ~ ~ ~ hopper[facing=south] run data modify storage adu:items sorting_hopper.items[{Slot:1b}].Slot set value 0b

execute if block ~ ~ ~ hopper[facing=west] run data modify storage adu:items sorting_hopper.items[{Slot:2b}].Slot set value 0b

execute if block ~ ~ ~ hopper[facing=north] run data modify storage adu:items sorting_hopper.items[{Slot:3b}].Slot set value 0b

execute if block ~ ~ ~ hopper[facing=east] run data modify storage adu:items sorting_hopper.items[{Slot:4b}].Slot set value 0b

setblock ~ ~ ~ hopper[facing=down]
