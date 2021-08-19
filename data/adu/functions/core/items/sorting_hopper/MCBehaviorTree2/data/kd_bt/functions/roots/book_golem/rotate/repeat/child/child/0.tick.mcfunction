
execute store success score $_ kd_bt run data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-motion- set from entity @s Motion
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-next[2] run function kd_bt:roots/book_golem/rotate/repeat/child/child/0.tick_
execute unless data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-next[2] run data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-next append value 1
data modify entity @s Motion set from storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-motion
