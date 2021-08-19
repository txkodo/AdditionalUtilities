# MCFA #

#NS
#DATA
#SELF
#DIR
#CHILD

#result="1"

#%arg = {"DATA":"{DATA}._","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
data modify storage {DATA}.- set value 1b
data modify storage {DATA}._ set value {}

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
scoreboard players set $result kd_bt -1
function {NS}:{DIR}{CHILD}.do
execute if score $result kd_bt matches {result} run function {NS}:{DIR}{SELF}.init
execute if score $result kd_bt matches {result} run function {NS}:{DIR}{SELF}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop
data remove storage {DATA}
