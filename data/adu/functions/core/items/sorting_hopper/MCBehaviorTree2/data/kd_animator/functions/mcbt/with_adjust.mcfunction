#> kd_animator:mcbt/with_adjust
# adjust kd_animation
# call this function as bt-collider
# @api

scoreboard players operation @s kd_animation %= $8192 kd_animation
scoreboard players operation $_ kd_animation = @s kd_animation
scoreboard players operation $_ kd_animation -= $adjust kd_animation
execute if score $_ kd_animation matches ..0 run scoreboard players operation $_ kd_animation += $8192 kd_animation
execute as @e[tag=KDBT_ANIMATION] run function kd_animator:core/with_adjust.as