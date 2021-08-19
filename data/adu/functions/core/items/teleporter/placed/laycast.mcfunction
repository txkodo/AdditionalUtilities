execute store success storage adu: _ byte 1 if block ~ ~ ~ minecraft:blast_furnace{CustomName:'{"italic":false,"text":"Teleporter"}'}
execute if data storage adu: {_:1b} align xyz positioned ~0.5 ~0.5 ~0.5 run function adu:core/items/teleporter/placed/at
execute if data storage adu: {_:0b} positioned ^ ^ ^0.01 run function adu:core/items/teleporter/placed/laycast
