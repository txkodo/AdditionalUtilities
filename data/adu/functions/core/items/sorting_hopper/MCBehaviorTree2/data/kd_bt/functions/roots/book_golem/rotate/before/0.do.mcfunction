
execute unless data storage kd_bt:test t.-[-16]._.rotate.before.- run function kd_bt:roots/book_golem/rotate/before/0.init
execute if data storage kd_bt:test t.-[-16]._.rotate.before{-:1b} run function kd_bt:roots/book_golem/rotate/before/1.do
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/rotate/before/0.childend
execute if data storage kd_bt:test t.-[-16]._.rotate.before{-:1b} if score @s kd_anim_progress matches 0 run function kd_bt:roots/book_golem/rotate/before/0.start
execute if data storage kd_bt:test t.-[-16]._.rotate.before{-:0b} if score @s kd_anim_progress matches 0 run scoreboard players set $result kd_bt 1

