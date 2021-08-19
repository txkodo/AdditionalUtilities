
tag @e remove _KDBT_
execute as @e[type=minecraft:iron_golem] at @s run function kd_bt:roots/book_golem/0.do.e0
tag @e[scores={kdbt_f6o3as35dql=-2147483648..}] add kdbt_f6o3as35dql__
execute as @e[tag=kdbt_f6o3as35dql__,tag=!_KDBT_] run function kd_bt:roots/book_golem/0.kill
