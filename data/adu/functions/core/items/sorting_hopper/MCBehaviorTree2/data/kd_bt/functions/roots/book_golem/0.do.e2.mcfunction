
scoreboard players set $result kd_bt -1
function kd_bt:roots/book_golem/1.do
execute unless score $result kd_bt matches -1 run data modify storage kd_bt:test t.-[-16].-- set value 1b
execute as @e[tag=kdbt_f6o3as35dql,tag=_KDBT_NEW] run scoreboard players operation @s kdbt_f6o3as35dql = $current kdbt_f6o3as35dql