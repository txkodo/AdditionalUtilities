setblock ~ 0 ~ barrel
execute if data storage adu:items planter{harvested:1b} run loot replace block ~ 0 ~ container.2 loot adu:crops/wheat
data modify block ~ ~ ~ Items append from block ~ 0 ~ Items[{Slot:2b}]

execute store result score @s adu.planter run data get block ~ 0 ~ Items[{Slot:3b}].Count
scoreboard players add @s adu.planter 0

setblock ~ 0 ~ bedrock

execute store result score $rest adu.planter run data get block ~ ~ ~ Items[{Slot:0b}].Count
scoreboard players remove $rest adu.planter 1
execute store result block ~ ~ ~ Items[{Slot:0b}].Count byte 1 run scoreboard players get $rest adu.planter

function adu:core/fuel/main