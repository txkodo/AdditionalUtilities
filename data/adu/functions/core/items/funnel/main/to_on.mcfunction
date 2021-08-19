tag @s add adu.funnel.on
execute if entity @s[tag=!adu.funnel.d] run function adu:core/items/funnel/main/wall
execute if entity @s[tag=adu.funnel.d] run function adu:core/items/funnel/main/floor