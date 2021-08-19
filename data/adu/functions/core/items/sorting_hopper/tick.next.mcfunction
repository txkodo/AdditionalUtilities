# block -> storage
data modify storage adu:items sorting_hopper.items set from block ~ ~ ~ Items

execute if block ~ ~ ~ minecraft:hopper run function adu:core/items/sorting_hopper/main/main