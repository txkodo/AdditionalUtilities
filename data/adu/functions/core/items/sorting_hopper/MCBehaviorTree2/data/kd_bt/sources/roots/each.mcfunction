#MCFA#

#NS
#DATA
#SELF
#CHILD
#DIR
#score = "{UNIQUE}"
#tag   = "{UNIQUE}"
#max
#as
#%arg = {"NS":"{NS}","DATA":"{DATA}.-[-{max}]","DIR":"{DIR}","SELF":"{CHILD}","TAG":"{tag}","SCORE":"{score}"}

#INIT_ONCE#
scoreboard objectives remove kd_bt
scoreboard objectives add kd_bt dummy

#INIT_EACH#
scoreboard objectives remove {score}
scoreboard objectives add {score} dummy
tag @e remove {tag}_
tag @e remove {tag}
data modify storage {DATA}.- set value []
data modify storage {DATA}.-all_index set value []
scoreboard players set _ kd_bt {max}
function {NS}:{DIR}{SELF}.init.f
data modify storage {DATA}.-all_index prepend value {-:0}
data remove storage {DATA}.-all_index[-1]
data modify storage {DATA}.-free_index set from storage {DATA}.-all_index
scoreboard players set $current {score} 0
scoreboard players set _ {score} 0

#RESET_ONCE#
scoreboard objectives remove kd_bt

#RESET_EACH#
scoreboard objectives remove {score}
tag @e remove {tag}_
tag @e remove {tag}
data remove storage {DATA}
scoreboard players reset _ kd_bt

#{SELF}.init.f#
data modify storage {DATA}.- append value {}
data modify storage {DATA}.-all_index prepend value {}
execute store result storage {DATA}.-all_index[0].- int 1 run scoreboard players get _ kd_bt
scoreboard players remove _ kd_bt 1
execute if score _ kd_bt matches 1.. run function {NS}:{DIR}{SELF}.init.f

#{SELF}.adjust#
execute if score @s {score} < $current {score} run function {NS}:{DIR}{SELF}.dec
execute if score @s {score} > $current {score} run function {NS}:{DIR}{SELF}.inc

#{SELF}.inc#
data modify storage {DATA}.- append value {}
scoreboard players add $current {score} 1
execute if score @s {score} > $current {score} run function {NS}:{DIR}{SELF}.inc

#{SELF}.dec#
data remove storage {DATA}.-[-1]
scoreboard players remove $current {score} 1
execute if score @s {score} < $current {score} run function {NS}:{DIR}{SELF}.dec

#{SELF}.new#
execute unless data storage {DATA}.-free_index[0] run function {NS}:{DIR}{SELF}.new.refill
execute store result score @s {score} run data get storage {DATA}.-free_index[-1].-
data remove storage {DATA}.-free_index[-1]
tag @s add {tag}_
scoreboard players set $new {score} 1

#{SELF}.new.refill#
data modify storage {DATA}.-free_index set from storage {DATA}.-all_index
scoreboard players set _ {score} 0
execute as @e[tag={tag}_] run function {NS}:{DIR}{SELF}.new.adj
data remove storage {DATA}.-free_index[{_:1b}]

#{SELF}.new.adj#
execute if score @s {score} < _ {score} run function {NS}:{DIR}{SELF}.new.dec
execute if score @s {score} > _ {score} run function {NS}:{DIR}{SELF}.new.inc
data modify storage {DATA}.-free_index[-{max}]._ set value 1b

#{SELF}.new.inc#
data modify storage {DATA}.-free_index append value {}
scoreboard players add _ {score} 1
execute if score @s {score} > _ {score} run function {NS}:{DIR}{SELF}.new.inc

#{SELF}.new.dec#
data remove storage {DATA}.-free_index[-1]
scoreboard players remove _ {score} 1
execute if score @s {score} < _ {score} run function {NS}:{DIR}{SELF}.new.dec

#{SELF}.do#
tag @e remove _KDBT_
execute as {as} at @s run function {NS}:{DIR}{SELF}.do.e0
tag @e[scores={{score}=-2147483648..}] add {tag}__

execute as @e[tag={tag}__,tag=!_KDBT_] run function {NS}:{DIR}{SELF}.kill

#{SELF}.kill#
scoreboard players reset @s
tp @s ~ ~ ~
kill @s

#{SELF}.do.e0#
tag @s add _KDBT_
scoreboard players set $new {score} 0
execute unless score @s {score} = @s {score} run function {NS}:{DIR}{SELF}.new
scoreboard players operation _ kd_bt = @s {score}
execute as @e if score @s {score} = _ kd_bt run function {NS}:{DIR}{SELF}.do.tag

function {NS}:{DIR}{SELF}.do.e1

tag @e remove {tag}

#{SELF}.do.tag#
tag @s add {tag}

#{SELF}.do.e1#
function {NS}:{DIR}{SELF}.adjust
execute if score $new {score} matches 1 run data modify storage {DATA}.-[-{max}] set value {}

execute unless data storage {DATA}.-[-{max}].-- run function {NS}:{DIR}{SELF}.do.e2

#{SELF}.do.e2#
scoreboard players set $result kd_bt -1
function {NS}:{DIR}{CHILD}.do
execute unless score $result kd_bt matches -1 run data modify storage {DATA}.-[-{max}].-- set value 1b

execute as @e[tag={tag},tag=_KDBT_NEW] run scoreboard players operation @s {score} = $current {score}
