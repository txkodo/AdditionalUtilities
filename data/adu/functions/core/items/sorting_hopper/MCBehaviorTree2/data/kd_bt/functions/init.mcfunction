
scoreboard objectives remove kd_bt
scoreboard objectives add kd_bt dummy

scoreboard objectives remove kdbt_f6o3as35dql
scoreboard objectives add kdbt_f6o3as35dql dummy
tag @e remove kdbt_f6o3as35dql_
tag @e remove kdbt_f6o3as35dql
data modify storage kd_bt:test t.- set value []
data modify storage kd_bt:test t.-all_index set value []
scoreboard players set _ kd_bt 16
function kd_bt:roots/book_golem/0.init.f
data modify storage kd_bt:test t.-all_index prepend value {-:0}
data remove storage kd_bt:test t.-all_index[-1]
data modify storage kd_bt:test t.-free_index set from storage kd_bt:test t.-all_index
scoreboard players set $current kdbt_f6o3as35dql 0
scoreboard players set _ kdbt_f6o3as35dql 0

scoreboard objectives add wait dummy

scoreboard objectives add wait dummy

scoreboard objectives add wait dummy

forceload add 0 0
execute unless entity 0-0-0-0-1 run summon armor_stand 0.0 0.0 0.0 {NoAI:1b,Marker:1b,Invisible:1b,UUID:[I;0,0,0,1]}

scoreboard objectives add wait dummy
