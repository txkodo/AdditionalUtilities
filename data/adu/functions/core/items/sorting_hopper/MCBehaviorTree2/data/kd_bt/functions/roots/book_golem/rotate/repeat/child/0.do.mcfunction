
execute unless data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.- run function kd_bt:roots/book_golem/rotate/repeat/child/0.init
execute unless score $result kd_bt matches 1 if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.-.damage run function kd_bt:roots/book_golem/rotate/repeat/child/0.damage.do
execute unless score $result kd_bt matches 1 if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.-.child run function kd_bt:roots/book_golem/rotate/repeat/child/0.child.do
execute if score $result kd_bt matches 0 store result score _ kd_bt run data get storage kd_bt:test t.-[-16]._.rotate.repeat._.child.-
execute if score $result kd_bt matches 0 unless score _ kd_bt matches 0 run scoreboard players set $result kd_bt -1
