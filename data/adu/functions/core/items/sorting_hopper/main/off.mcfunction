data modify storage adu:items sorting_hopper.multi set from storage adu:items sorting_hopper.items
data remove storage adu:items sorting_hopper.multi[{Count:1b}]
data remove storage adu:items sorting_hopper.multi[{Slot:0b}]
data modify storage adu:items sorting_hopper.slot set value 0b
data modify storage adu:items sorting_hopper.slot set from storage adu:items sorting_hopper.multi[0].Slot

execute if data storage adu:items sorting_hopper{slot:0b} run function adu:core/items/sorting_hopper/main/free_slot

# slotがあった場合
execute unless data storage adu:items sorting_hopper{slot:0b} run function adu:core/items/sorting_hopper/main/to_on

data modify storage adu:items sorting_hopper.free set from storage adu:items sorting_hopper.items[{Slot:0b}].Count
