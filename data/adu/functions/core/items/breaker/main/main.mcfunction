data modify entity @s HandItems[0] set value {}
data modify entity @s HandItems[0] set from block ~ ~ ~ Items[{Slot:0b}]
setblock ~ 0 ~ barrel
execute as @s run loot replace block ~ 0 ~ container.2 mine ^ ^ ^1 mainhand
data modify block ~ ~ ~ Items append from block ~ 0 ~ Items[{Slot:2b}]
setblock ~ 0 ~ bedrock
setblock ^ ^ ^1 air

execute store result score $ adu run data get block ~ ~ ~ Items[{Slot:0b}].tag.Damage
scoreboard players add $ adu 1
execute store result block ~ ~ ~ Items[{Slot:0b}].tag.Damage int 1 run scoreboard players get $ adu
