scoreboard players add tick/20 adu 1
execute if score tick/20 adu matches 20 run scoreboard players set tick/20 adu 0

execute as @e[tag=adu] at @s run function adu:core/tick.as