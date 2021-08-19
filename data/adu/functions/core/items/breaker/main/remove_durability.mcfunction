execute store result score $ adu run data get block ~ ~ ~ Items[{Slot:0b}].tag.Damage
scoreboard players add $ adu 1
execute store result block ~ ~ ~ Items[{Slot:0b}].tag.Damage int 1 run scoreboard players get $ adu

data modify entity @s HandItems[0] set from block ~ ~ ~ Items[{Slot:0b}]

execute if predicate adu:core/items/breaker/has_no_durability run function adu:core/items/breaker/main/break_tool