
execute facing entity @p feet run tp @s ~ ~ ~ ~ ~
data modify storage kd_bt: _ set from entity @s Rotation
data modify storage kd_bt: _[1] set value 0f
data modify entity @s Rotation set from storage kd_bt: _
scoreboard players set $result kd_bt 1