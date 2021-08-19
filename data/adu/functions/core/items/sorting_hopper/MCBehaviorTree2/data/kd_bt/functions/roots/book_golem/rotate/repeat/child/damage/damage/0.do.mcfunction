
# data modify storage kd_rhp: type set value normal
scoreboard players remove @a[distance=..1.5] ReactiveHP 200
function reactive_health:mcbt/attack
scoreboard players set $result kd_bt 1