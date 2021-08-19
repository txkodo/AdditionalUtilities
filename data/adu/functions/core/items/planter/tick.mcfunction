execute unless block ~ ~ ~ minecraft:blast_furnace{CustomName:'{"italic":false,"text":"Planter"}'} run kill @s

execute if score tick/20 adu matches 4 if data block ~ ~ ~ Items[{Slot:0b}] unless data block ~ ~ ~ Items[{Slot:2b}] run function adu:core/items/planter/main/main
