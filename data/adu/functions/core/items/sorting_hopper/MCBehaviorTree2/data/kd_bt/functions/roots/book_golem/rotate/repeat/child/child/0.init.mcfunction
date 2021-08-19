
data modify entity @s NoAI set value 0b
execute positioned 0.0 0.0 0.0 run tp 0-0-0-0-1 ^ ^ ^0.5
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-motion set from entity 0-0-0-0-1 Pos
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-r set from entity @s Rotation
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.child.child.-next set value [I;]
