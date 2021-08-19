execute unless block ~ ~ ~ minecraft:chest{CustomName:'{"italic":false,"text":"The Void"}'} run kill @s
execute if score tick/20 adu matches 1 run data modify block ~ ~ ~ Items set value []