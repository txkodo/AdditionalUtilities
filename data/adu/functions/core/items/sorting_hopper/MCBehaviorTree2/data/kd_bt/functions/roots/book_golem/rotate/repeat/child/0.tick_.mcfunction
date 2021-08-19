
execute if score $_ kd_bt matches 1 run function kd_bt:roots/book_golem/rotate/repeat/child/0.end
execute store success score $_ kd_bt run data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.-pos- set from entity @s Pos
execute if score $_ kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/repeat/child/0.end
