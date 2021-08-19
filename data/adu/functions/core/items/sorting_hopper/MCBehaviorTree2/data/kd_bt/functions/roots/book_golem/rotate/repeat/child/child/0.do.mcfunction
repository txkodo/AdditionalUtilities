
execute unless data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child rotated as @s run function kd_bt:roots/book_golem/rotate/repeat/child/child/0.init
execute if data storage kd_bt:- {event:tick} run function kd_bt:roots/book_golem/rotate/repeat/child/child/0.tick
data modify entity @s Rotation set from storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-r