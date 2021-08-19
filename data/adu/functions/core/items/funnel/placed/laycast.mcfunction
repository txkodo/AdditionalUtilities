execute store success storage adu: _ byte 1 if block ~ ~ ~ minecraft:hopper{CustomName:'{"italic":false,"text":"Funnel"}'} align xyz positioned ~0.5 ~-1 ~0.5 unless entity @e[tag=adu,distance=..0.01]
execute if data storage adu: {_:1b} align xyz positioned ~0.5 ~0.5 ~0.5 run function adu:core/items/funnel/placed/at
execute if data storage adu: {_:0b} positioned ^ ^ ^0.01 run function adu:core/items/funnel/placed/laycast
