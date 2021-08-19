data modify storage adu:items planter set value {planted:0b,harvested:0b}

execute if data storage adu:items planter{planted:0b} positioned ^-4 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^-3 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^-2 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^-1 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^0 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^1 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^2 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^3 ^ ^1 run function adu:core/items/planter/main/nether_wart/z
execute if data storage adu:items planter{planted:0b} positioned ^4 ^ ^1 run function adu:core/items/planter/main/nether_wart/z

execute if data storage adu:items planter{planted:1b} run function adu:core/items/planter/main/nether_wart/loot