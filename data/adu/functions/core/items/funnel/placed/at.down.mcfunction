execute store result score $rot adu run data get entity @s Rotation[0]

execute if score $rot adu matches 0..44 run tag @e[tag=adu_] add adu.funnel.s
execute if score $rot adu matches 45..134 run tag @e[tag=adu_] add adu.funnel.w
execute if score $rot adu matches 135..224 run tag @e[tag=adu_] add adu.funnel.n
execute if score $rot adu matches 225..314 run tag @e[tag=adu_] add adu.funnel.e
execute if score $rot adu matches 315..360 run tag @e[tag=adu_] add adu.funnel.s