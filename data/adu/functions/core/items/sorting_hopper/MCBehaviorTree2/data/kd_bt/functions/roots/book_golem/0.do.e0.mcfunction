
tag @s add _KDBT_
scoreboard players set $new kdbt_f6o3as35dql 0
execute unless score @s kdbt_f6o3as35dql = @s kdbt_f6o3as35dql run function kd_bt:roots/book_golem/0.new
scoreboard players operation _ kd_bt = @s kdbt_f6o3as35dql
execute as @e if score @s kdbt_f6o3as35dql = _ kd_bt run function kd_bt:roots/book_golem/0.do.tag
function kd_bt:roots/book_golem/0.do.e1
tag @e remove kdbt_f6o3as35dql
