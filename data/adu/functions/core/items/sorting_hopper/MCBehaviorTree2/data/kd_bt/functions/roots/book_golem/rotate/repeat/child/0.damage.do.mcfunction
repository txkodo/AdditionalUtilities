
scoreboard players set $result kd_bt -1
function kd_bt:roots/book_golem/rotate/repeat/child/damage/0.do
execute unless score $result kd_bt matches -1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.-.damage
execute unless score $result kd_bt matches -1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage
