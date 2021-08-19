# onかつslot0のアイテムが1こかつfree_slotでない場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=!adu.sorting_hopper.free] if data storage adu:items sorting_hopper.items[{Slot:0b,Count:1b}] run function adu:core/items/sorting_hopper/main/to_off

# onかつfree_slotの場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=adu.sorting_hopper.free] if data storage adu:items sorting_hopper.items[{Slot:0b}] run function adu:core/items/sorting_hopper/main/on.free

# onかつslot0のアイテムがなかった場合
execute if entity @s[tag=adu.sorting_hopper.on,tag=adu.sorting_hopper.free] unless data storage adu:items sorting_hopper.items[{Slot:0b}] run function adu:core/items/sorting_hopper/main/to_off.empty

# offだった場合
execute if entity @s[tag=!adu.sorting_hopper.on] run function adu:core/items/sorting_hopper/main/off

# storage -> block
data modify block ~ ~ ~ Items set from storage adu:items sorting_hopper.items