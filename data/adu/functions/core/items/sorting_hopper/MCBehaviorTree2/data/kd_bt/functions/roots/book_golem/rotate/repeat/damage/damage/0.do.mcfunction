
# data modify storage kd_rhp: type set value normal
scoreboard players remove @a[distance=..3,predicate=!kd_bt:is_sneeking] ReactiveHP 200
function reactive_health:mcbt/attack
scoreboard players set $result kd_bt 1