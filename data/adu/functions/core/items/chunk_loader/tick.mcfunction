execute unless block ~ ~ ~ minecraft:chiseled_polished_blackstone run function adu:core/items/chunk_loader/break

# main
execute if score tick/20 adu matches 3 run particle portal ~ ~ ~ 0 50 0 0.2 2000 force @a