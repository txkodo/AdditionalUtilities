
data modify storage kd_bt:test t.-free_index set from storage kd_bt:test t.-all_index
scoreboard players set _ kdbt_f6o3as35dql 0
execute as @e[tag=kdbt_f6o3as35dql_] run function kd_bt:roots/book_golem/0.new.adj
data remove storage kd_bt:test t.-free_index[{_:1b}]
