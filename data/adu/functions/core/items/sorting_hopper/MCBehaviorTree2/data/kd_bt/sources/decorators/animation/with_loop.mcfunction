#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD
#TAG
#ANIMTAG
#ANIMENTITY

#animation
#%arg = {"DATA":"{DATA}._","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
data modify storage {DATA}.- set value 1b
function {NS}:{DIR}{SELF}.start

#{SELF}.start#
execute store result score $adjust kd_animation run data get storage kd_animation: ticks.{ANIMENTITY}.{animation}.s
execute store result score @s kd_anim_progress run data get storage kd_animation: ticks.{ANIMENTITY}.{animation}.l
tag @e[tag={TAG},tag={ANIMTAG}] add KDBT_ANIMATION
function kd_animator:mcbt/with_adjust

#{SELF}.childend#
data modify storage {DATA}.- set value 0b
scoreboard players set $result kd_bt -1

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage {DATA}{-:1b} run function {NS}:{DIR}{CHILD}.do
execute if score $result kd_bt matches 1 run function {NS}:{DIR}{SELF}.childend

execute if data storage {DATA}{-:1b} if score @s kd_anim_progress matches 0 run function {NS}:{DIR}{SELF}.start

execute if data storage {DATA}{-:0b} if score @s kd_anim_progress matches 0 run scoreboard players set $result kd_bt 1


#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop
