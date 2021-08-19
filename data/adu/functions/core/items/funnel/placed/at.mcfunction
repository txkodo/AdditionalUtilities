summon armor_stand ~ ~-1.5 ~ {Marker:1b,Invulnerable:1b,Invisible:1b,Tags:[adu,adu.funnel,adu_],ArmorItems:[{},{},{},{Count:1b,id:"minecraft:quartz_block"}]}

execute if block ~ ~ ~ hopper[facing=east] run tag @e[tag=adu_] add adu.funnel.e
execute if block ~ ~ ~ hopper[facing=west] run tag @e[tag=adu_] add adu.funnel.w
execute if block ~ ~ ~ hopper[facing=south] run tag @e[tag=adu_] add adu.funnel.s
execute if block ~ ~ ~ hopper[facing=north] run tag @e[tag=adu_] add adu.funnel.n
execute if block ~ ~ ~ hopper[facing=down] run function adu:core/items/funnel/placed/at.down

execute if block ~ ~ ~ hopper[facing=down] run tag @e[tag=adu_] add adu.funnel.d

execute as @e[tag=adu_,tag=adu.funnel.d] run function adu:core/items/funnel/main/wall
execute if entity @e[tag=adu_,tag=!adu.funnel.d] run function adu:core/items/funnel/main/floor

tag @e[tag=adu_] remove adu_