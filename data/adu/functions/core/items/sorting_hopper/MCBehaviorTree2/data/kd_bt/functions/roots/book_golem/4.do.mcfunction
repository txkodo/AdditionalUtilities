
execute unless data storage kd_bt:test t.-[-16].- run function kd_bt:roots/book_golem/4.init
scoreboard players set $result kd_bt -1
function kd_bt:roots/book_golem/5.do
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/4.init
execute if score $result kd_bt matches 1 run function kd_bt:roots/book_golem/4.do
