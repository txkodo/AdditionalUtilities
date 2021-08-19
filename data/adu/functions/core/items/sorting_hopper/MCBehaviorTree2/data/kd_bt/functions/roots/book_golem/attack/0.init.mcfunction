

execute if entity @p[distance=..4] run data modify storage kd_bt:test t.-[-16]._.attack.- set value 1b
execute unless data storage kd_bt:test t.-[-16]._.attack.- run scoreboard players set $result kd_bt 1
