
data modify storage kd_bt:test t.- append value {}
scoreboard players add $current kdbt_f6o3as35dql 1
execute if score @s kdbt_f6o3as35dql > $current kdbt_f6o3as35dql run function kd_bt:roots/book_golem/0.inc
