#MCFA#

#NS
#DIR
#DATA
#SELF

#tick
#score="{UNIQUE}"

#%event = "tick"

#INIT_EACH#
scoreboard objectives add {score} dummy

#RESET_EACH#
scoreboard objectives remove {score} dummy

#{SELF}.init#
scoreboard players set @s {score} {tick}
data modify storage {DATA}.- set value 1b

#{SELF}.tick#
scoreboard players remove @s {score} 1
execute if score @s {score} matches 0 run function {NS}:{DIR}{SELF}.end

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage kd_bt:- {event:tick} run function {NS}:{DIR}{SELF}.tick

#{SELF}.end#
scoreboard players set $result kd_bt 1
data remove storage {DATA}

#{SELF}.stop#
scoreboard players set $result kd_bt 0
data remove storage {DATA}
