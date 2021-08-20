# freeでないスロットのアイテムが搬出終了した場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=!adu.sorting_hopper.free] if data storage adu:items sorting_hopper.items[{Slot:0b,Count:1b}] run function adu:core/items/sorting_hopper/main/to_off

# free_slot搬出中でまだアイテムが存在する場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=adu.sorting_hopper.free] if data storage adu:items sorting_hopper.items[{Slot:0b}] run function adu:core/items/sorting_hopper/main/on.free

# 搬出が終了した場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=adu.sorting_hopper.free] unless data storage adu:items sorting_hopper.items[{Slot:0b}] run function adu:core/items/sorting_hopper/main/to_off.empty

# 非アクティブの場合
execute if entity @s[tag=!adu.sorting_hopper.on] run function adu:core/items/sorting_hopper/main/off

# storage -> block
data modify block ~ ~ ~ Items set from storage adu:items sorting_hopper.items