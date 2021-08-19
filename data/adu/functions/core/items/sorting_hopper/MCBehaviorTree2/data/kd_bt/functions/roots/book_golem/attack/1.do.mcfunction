
execute unless data storage kd_bt:test t.-[-16]._.attack._.- run function kd_bt:roots/book_golem/attack/1.init
execute if data storage kd_bt:test t.-[-16]._.attack._{-:1b} run function kd_bt:roots/book_golem/attack/2.do
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/attack/1.childend
execute if data storage kd_bt:test t.-[-16]._.attack._{-:1b} if score @s kd_anim_progress matches 0 run function kd_bt:roots/book_golem/attack/1.start
execute if data storage kd_bt:test t.-[-16]._.attack._{-:0b} if score @s kd_anim_progress matches 0 run scoreboard players set $result kd_bt 1

