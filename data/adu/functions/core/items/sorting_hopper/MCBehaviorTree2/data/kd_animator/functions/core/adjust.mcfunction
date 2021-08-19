#> kd_animator:core/adjust
# adjust kd_animation

scoreboard players operation @s kd_animation %= $8192 kd_animation
scoreboard players operation $_ kd_animation = $adjust kd_animation
scoreboard players operation $_ kd_animation -= @s kd_animation
execute if score $_ kd_animation matches ..-1 run scoreboard players operation $_ kd_animation += $8192 kd_animation

#>
# @private
    #alias uuid 2power0x0 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f0
    #alias uuid 2power0x1 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f1
    #alias uuid 2power0x2 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f2
    #alias uuid 2power0x3 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f3
    #alias uuid 2power0x4 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f4
    #alias uuid 2power0x5 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f5
    #alias uuid 2power0x6 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f6
    #alias uuid 2power0x7 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f7
    #alias uuid 2power0x8 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f8
    #alias uuid 2power0x9 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f9
    #alias uuid 2power0xA 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fa
    #alias uuid 2power0xB 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fb
    #alias uuid 2power0xC 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fc

attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fc
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fb
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fa
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f9
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f8
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f7
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f6
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f5
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f4
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f3
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f2
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f1
attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f0

# max_healthが整数値であることを確認
execute store result score $_max_health kd_animation run attribute @s generic.max_health get 10
scoreboard players operation $_max_health kd_animation %= $10 kd_animation
execute unless score $_max_health kd_animation matches 0 run tellraw @a ["[ERROR] attribute: \"minecraft:generic.max_health\" must be integer.\n in function kd_animator:core/adjust\n as : ",{"selector":"@s"}]


execute if score $_ kd_animation matches 4096.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fc "2^c" 0.5 add
execute if score $_ kd_animation matches 4096.. run scoreboard players remove $_ kd_animation 4096

execute if score $_ kd_animation matches 2048.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fb "2^b" 0.25 add
execute if score $_ kd_animation matches 2048.. run scoreboard players remove $_ kd_animation 2048

execute if score $_ kd_animation matches 1024.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5fa "2^a" 0.125 add
execute if score $_ kd_animation matches 1024.. run scoreboard players remove $_ kd_animation 1024

execute if score $_ kd_animation matches 512.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f9 "2^9" 0.0625 add
execute if score $_ kd_animation matches 512.. run scoreboard players remove $_ kd_animation 512

execute if score $_ kd_animation matches 256.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f8 "2^8" 0.03125 add
execute if score $_ kd_animation matches 256.. run scoreboard players remove $_ kd_animation 256

execute if score $_ kd_animation matches 128.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f7 "2^7" 0.015625 add
execute if score $_ kd_animation matches 128.. run scoreboard players remove $_ kd_animation 128

execute if score $_ kd_animation matches 64.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f6 "2^6" 0.0078125 add
execute if score $_ kd_animation matches 64.. run scoreboard players remove $_ kd_animation 64

execute if score $_ kd_animation matches 32.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f5 "2^5" 0.00390625 add
execute if score $_ kd_animation matches 32.. run scoreboard players remove $_ kd_animation 32

execute if score $_ kd_animation matches 16.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f4 "2^4" 0.001953125 add
execute if score $_ kd_animation matches 16.. run scoreboard players remove $_ kd_animation 16

execute if score $_ kd_animation matches 8.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f3 "2^3" 0.0009765625 add
execute if score $_ kd_animation matches 8.. run scoreboard players remove $_ kd_animation 8

execute if score $_ kd_animation matches 4.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f2 "2^2" 0.00048828125 add
execute if score $_ kd_animation matches 4.. run scoreboard players remove $_ kd_animation 4

execute if score $_ kd_animation matches 2.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f1 "2^1" 0.000244140625 add
execute if score $_ kd_animation matches 2.. run scoreboard players remove $_ kd_animation 2

execute if score $_ kd_animation matches 1.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f0 "2^0" 0.0001220703125 add
