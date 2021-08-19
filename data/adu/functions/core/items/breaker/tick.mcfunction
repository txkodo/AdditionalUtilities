execute unless block ~ ~ ~ minecraft:furnace{CustomName:'{"italic":false,"text":"Breaker"}'} run kill @s

# main
execute if score tick/20 adu matches 5 run function adu:core/items/breaker/main/check