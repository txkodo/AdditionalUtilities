data modify storage adu:items teleporter.items set from block ~ ~ ~ Items
execute if block ~ ~ ~ blast_furnace[facing=east] run setblock ~ ~ ~ blast_furnace[facing=east,lit=true]
execute if block ~ ~ ~ blast_furnace[facing=west] run setblock ~ ~ ~ blast_furnace[facing=west,lit=true]
execute if block ~ ~ ~ blast_furnace[facing=north] run setblock ~ ~ ~ blast_furnace[facing=north,lit=true]
execute if block ~ ~ ~ blast_furnace[facing=south] run setblock ~ ~ ~ blast_furnace[facing=south,lit=true]
data modify block ~ ~ ~ Items set from storage adu:items teleporter.items