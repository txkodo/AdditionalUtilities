# 壁向きに再設置
execute if entity @s[tag=adu.funnel.e] run setblock ~ ~ ~ minecraft:hopper[facing=east]{CustomName:'{"italic":false,"text":"Funnel"}'}
execute if entity @s[tag=adu.funnel.w] run setblock ~ ~ ~ minecraft:hopper[facing=west]{CustomName:'{"italic":false,"text":"Funnel"}'}
execute if entity @s[tag=adu.funnel.s] run setblock ~ ~ ~ minecraft:hopper[facing=south]{CustomName:'{"italic":false,"text":"Funnel"}'}
execute if entity @s[tag=adu.funnel.n] run setblock ~ ~ ~ minecraft:hopper[facing=north]{CustomName:'{"italic":false,"text":"Funnel"}'}