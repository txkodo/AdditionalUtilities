execute store success storage adu: _ byte 1 if block ~ ~ ~ minecraft:chiseled_polished_blackstone
execute if data storage adu: {_:1b} align xyz positioned ~0.5 ~0.5 ~0.5 run function adu:core/items/chunk_loader/placed/at
execute if data storage adu: {_:0b} positioned ^ ^ ^0.01 run function adu:core/items/chunk_loader/placed/laycast
