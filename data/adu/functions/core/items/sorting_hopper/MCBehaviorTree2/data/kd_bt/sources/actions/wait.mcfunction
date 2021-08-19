#MCFA#


#NS
#DIR
#SELF
#DATA


#tick
#%event="tick"

#{SELF}.init#
data modify storage {DATA} set value {-tick:{tick}}

#{SELF}.tick#
execute store result score _ kd_bt run data get storage {DATA}.-tick
scoreboard players remove _ kd_bt 1
execute store result storage {DATA}.-tick int 1 run scoreboard players get _ kd_bt
execute if score _ kd_bt matches 0 run function {NS}:{DIR}{SELF}.end

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage kd_bt:- {event:tick} run function {NS}:{DIR}{SELF}.tick

#{SELF}.end#
scoreboard players set $result kd_bt 1
data remove storage {DATA}.-tick

#{SELF}.stop#
scoreboard players set $result kd_bt 0
data remove storage {DATA}.-tick