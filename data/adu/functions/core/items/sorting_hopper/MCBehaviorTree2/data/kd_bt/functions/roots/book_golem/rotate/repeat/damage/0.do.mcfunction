
execute unless data storage kd_bt:test t.-[-16]._.rotate.repeat._.damage.- run function kd_bt:roots/book_golem/rotate/repeat/damage/0.init
scoreboard players set $result kd_bt -1
function kd_bt:roots/book_golem/rotate/repeat/damage/1.do
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/rotate/repeat/damage/0.init
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/rotate/repeat/damage/0.do
