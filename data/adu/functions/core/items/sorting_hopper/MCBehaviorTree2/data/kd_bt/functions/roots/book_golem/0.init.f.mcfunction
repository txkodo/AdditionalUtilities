
data modify storage kd_bt:test t.- append value {}
data modify storage kd_bt:test t.-all_index prepend value {}
execute store result storage kd_bt:test t.-all_index[0].- int 1 run scoreboard players get _ kd_bt
scoreboard players remove _ kd_bt 1
execute if score _ kd_bt matches 1.. run function kd_bt:roots/book_golem/0.init.f
