data modify storage adu: fuel set value {}
data modify storage adu: fuel set from block ~ ~ ~ Items[{Slot:1b}]
execute store result score $ adu run data get storage adu: fuel.Count
scoreboard players remove $ adu 1
execute store result block ~ ~ ~ Items[{Slot:1b}].Count byte 1 run scoreboard players get $ adu

scoreboard players set $ adu 0

execute if data storage adu: fuel{id:"minecraft:lava_bucket"} run scoreboard players set $ adu 20000
execute if data storage adu: fuel{id:"minecraft:coal_block"} run scoreboard players set $ adu 16000
execute if data storage adu: fuel{id:"minecraft:dried_kelp_block"} run scoreboard players set $ adu 4000
execute if data storage adu: fuel{id:"minecraft:blaze_rod"} run scoreboard players set $ adu 2400
execute if data storage adu: fuel{id:"minecraft:coal"} run scoreboard players set $ adu 1600
execute if data storage adu: fuel{id:"minecraft:charcoal"} run scoreboard players set $ adu 1600
execute if data storage adu: fuel{id:"minecraft:scaffolding"} run scoreboard players set $ adu 400
execute if data storage adu: fuel{id:"minecraft:stick"} run scoreboard players set $ adu 100
execute if data storage adu: fuel{id:"minecraft:bamboo"} run scoreboard players set $ adu 50

execute if block ~ ~ ~ minecraft:smoker run scoreboard players operation $ adu /= $2 adu
execute if block ~ ~ ~ minecraft:blast_furnace run scoreboard players operation $ adu /= $2 adu

execute store result block ~ ~ ~ BurnTime short 1 run scoreboard players get $ adu