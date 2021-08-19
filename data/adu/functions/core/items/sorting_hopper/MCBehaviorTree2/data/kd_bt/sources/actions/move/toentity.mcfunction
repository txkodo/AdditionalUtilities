#MCFA#

#NS
#DIR
#DATA
#SELF

#entity
#offset="^ ^ ^"
#range

#%event="tick"

#INIT_ONCE#
forceload add 0 0
execute unless entity 0-0-0-0-1 run summon armor_stand 0.0 0.0 0.0 {NoAI:1b,Marker:1b,Invisible:1b,UUID:[I;0,0,0,1]}

#{SELF}.init#
data modify storage {DATA}.- set value 1b

#{SELF}.facing#
tp @s ~ ~ ~ ~ ~
execute positioned 0.0 0.0 0.0 run tp 0-0-0-0-1 {offset}

#{SELF}.tick#
execute facing entity {entity} feet run function {NS}:{DIR}{SELF}.facing
data modify entity @s Motion set from entity 0-0-0-0-1 Pos
execute at {entity} if entity @s[distance={range}] run scoreboard players set $result kd_bt 1

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage kd_bt:- {event:tick} run function {NS}:{DIR}{SELF}.tick