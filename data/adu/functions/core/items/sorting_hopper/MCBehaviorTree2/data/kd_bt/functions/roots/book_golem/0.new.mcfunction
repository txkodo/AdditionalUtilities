
execute unless data storage kd_bt:test t.-free_index[0] run function kd_bt:roots/book_golem/0.new.refill
execute store result score @s kdbt_f6o3as35dql run data get storage kd_bt:test t.-free_index[-1].-
data remove storage kd_bt:test t.-free_index[-1]
tag @s add kdbt_f6o3as35dql_
scoreboard players set $new kdbt_f6o3as35dql 1
