#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
function {NS}:{DIR}{CHILD}.do

execute if score $result kd_bt matches 0 run scoreboard players set $result kd_bt 2
execute if score $result kd_bt matches 1 run scoreboard players set $result kd_bt 0
execute if score $result kd_bt matches 2 run scoreboard players set $result kd_bt 1

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop