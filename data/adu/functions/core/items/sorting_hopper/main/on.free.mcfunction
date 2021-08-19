# onかつslot0のアイテムが1こかつfree_slotでない場合
setblock ~ 0 ~ shulker_box

data modify block ~ 0 ~ Items append from storage adu:items sorting_hopper.items[{Slot:0b}]
data modify storage adu:items sorting_hopper.items[{Slot:1b}].Slot set value 0b
data modify storage adu:items sorting_hopper.items[{Slot:2b}].Slot set value 1b
data modify storage adu:items sorting_hopper.items[{Slot:3b}].Slot set value 2b
data modify storage adu:items sorting_hopper.items[{Slot:4b}].Slot set value 3b
data modify block ~ ~ ~ Items set from storage adu:items sorting_hopper.items

loot insert ~ ~ ~ mine ~ 0 ~ debug_stick
data modify storage adu:items sorting_hopper.items set from block ~ ~ ~ Items
setblock ~ 0 ~ bedrock

execute if data storage adu:items sorting_hopper.items[{Slot:4b}] run data modify storage adu:items sorting_hopper.items[{Slot:4b}].Slot set value 5b
execute if data storage adu:items sorting_hopper.items[{Slot:3b}] run data modify storage adu:items sorting_hopper.items[{Slot:3b}].Slot set value 4b
execute if data storage adu:items sorting_hopper.items[{Slot:2b}] run data modify storage adu:items sorting_hopper.items[{Slot:2b}].Slot set value 3b
execute if data storage adu:items sorting_hopper.items[{Slot:1b}] run data modify storage adu:items sorting_hopper.items[{Slot:1b}].Slot set value 2b
execute if data storage adu:items sorting_hopper.items[{Slot:0b}] run data modify storage adu:items sorting_hopper.items[{Slot:0b}].Slot set value 1b
execute if data storage adu:items sorting_hopper.items[{Slot:5b}] run data modify storage adu:items sorting_hopper.items[{Slot:5b}].Slot set value 0b
