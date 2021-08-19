#MCFA## MCFA #

#NS
#DIR
#DATA
#SELF
#CHILD

#animation

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.start#
execute store result score $adjust kd_animation run data get storage kd_animation: ticks.{animation}.s
execute store result score @s kd_anim_progress run data get storage kd_animation: ticks.{animation}.l
function kd_animator:adjust

#{SELF}.do#
execute unless data storage {DATA} run function {NS}:{DIR}{SELF}.start
execute if score @s kd_anim_progress matches 0 run function {NS}:{DIR}{SELF}.start

function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop
