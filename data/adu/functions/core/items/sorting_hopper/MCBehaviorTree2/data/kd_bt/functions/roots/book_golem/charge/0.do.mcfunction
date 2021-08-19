
execute unless data storage kd_bt:test t.-[-16]._.charge.- run function kd_bt:roots/book_golem/charge/0.init
execute if data storage kd_bt:test t.-[-16]._.charge{-:1b} run function kd_bt:roots/book_golem/charge/1.do
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/charge/0.childend
execute if data storage kd_bt:test t.-[-16]._.charge{-:1b} if score @s kd_anim_progress matches 0 run function kd_bt:roots/book_golem/charge/0.start
execute if data storage kd_bt:test t.-[-16]._.charge{-:0b} if score @s kd_anim_progress matches 0 run scoreboard players set $result kd_bt 1

