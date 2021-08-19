data modify block ~ ~ ~ Items append value {id:"minecraft:beetroot_seeds",Slot:2b,Count:1b}
execute store result block ~ ~ ~ Items[-1].Count byte 1 run scoreboard players get @s adu.planter