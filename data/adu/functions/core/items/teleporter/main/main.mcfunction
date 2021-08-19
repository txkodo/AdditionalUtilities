data merge block ~ ~ ~ {CookTime:200s,BurnTime:20000s}

function adu:core/items/teleporter/main/mark

execute if block ~ ~ ~ minecraft:blast_furnace[lit=false] unless data block ~ ~ ~ Items[{Slot:0b}] unless data block ~ ~ ~ Items[{Slot:2b}] if data storage adu:items teleporter.channels[{.:.}].id run function adu:core/items/teleporter/main/recieve
execute if block ~ ~ ~ minecraft:blast_furnace[lit=false] if data block ~ ~ ~ Items[{Slot:0b}] run function adu:core/items/teleporter/main/to_send
execute if block ~ ~ ~ minecraft:blast_furnace[lit=true] if data block ~ ~ ~ Items[{Slot:0b}] unless data storage adu:items teleporter.channels[{.:.}].id run function adu:core/items/teleporter/main/send
