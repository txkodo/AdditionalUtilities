#MCFA#

#NS
#DIR
#DATA
#SELF

#offset="^ ^ ^"

#%event="tick"

#INIT_ONCE#
forceload add 0 0
execute unless entity 0-0-0-0-1 run summon armor_stand 0.0 0.0 0.0 {NoAI:1b,Marker:1b,Invisible:1b,UUID:[I;0,0,0,1]}

#{SELF}.init#
data modify entity @s NoAI set value 0b
execute positioned 0.0 0.0 0.0 run tp 0-0-0-0-1 {offset}
data modify storage {DATA}.-motion set from entity 0-0-0-0-1 Pos
data modify storage {DATA}.-r set from entity @s Rotation
data modify storage {DATA}.-next set value [I;]

#{SELF}.tick#
execute store success score $_ kd_bt run data modify storage {DATA}.-motion- set from entity @s Motion
execute if data storage {DATA}.-next[2] run function {NS}:{DIR}{SELF}.tick_
execute unless data storage {DATA}.-next[2] run data modify storage {DATA}.-next append value 1
data modify entity @s Motion set from storage {DATA}.-motion

#{SELF}.tick_#
execute if score $_ kd_bt matches 1 run function {NS}:{DIR}{SELF}.end
execute store success score $_ kd_bt run data modify storage {DATA}.-pos- set from entity @s Pos
execute if score $_ kd_bt matches 0 run function {NS}:{DIR}{SELF}.end

#{SELF}.end#
data modify entity @s NoAI set value 1b
scoreboard players set $result kd_bt 1
data modify storage {DATA}.- set value [0d,0d,0d]

#{SELF}.do#
execute unless data storage {DATA} rotated as @s run function {NS}:{DIR}{SELF}.init
execute if data storage kd_bt:- {event:tick} run function {NS}:{DIR}{SELF}.tick
data modify entity @s Rotation set from storage {DATA}.-r