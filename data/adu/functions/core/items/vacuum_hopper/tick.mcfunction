execute unless block ~ ~ ~ minecraft:hopper{CustomName:'{"italic":false,"text":"Vacuum Hopper"}'} run kill @s

execute if score tick/20 adu matches 0 positioned ~-4.5 ~0.5 ~-4.5 run tp @e[type=item,dx=9.0,dy=3.0,dz=9.0] ~4.5 ~ ~4.5