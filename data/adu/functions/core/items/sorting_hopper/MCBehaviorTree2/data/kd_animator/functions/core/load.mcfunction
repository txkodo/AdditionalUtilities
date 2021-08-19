scoreboard objectives add kd_animation dummy
scoreboard objectives add kd_anim_progress dummy
scoreboard players set $adjust kd_animation 0
scoreboard players set $8192 kd_animation 8192
scoreboard players set $10 kd_animation 10

function kd_animator:core/start_ticks

## by @intsuc https://gist.github.com/intsuc/c44af02741aea85c411da27a16362c09#file-load-mcfunction-L2
# trigger only when the world loded
execute store result storage kd_animation: uninitialized byte 1.0 run data modify storage kd_animation: nand_ set from storage kd_animation: nand
execute if data storage kd_animation: {uninitialized: true} run function kd_animator:world_load
