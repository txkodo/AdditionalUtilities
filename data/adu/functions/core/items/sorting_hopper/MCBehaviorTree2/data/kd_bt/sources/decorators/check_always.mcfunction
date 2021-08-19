#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#commands=[]
#condition
#result="0"

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
*$commands

execute store success storage {DATA}.-.- byte 1 run execute {condition}
execute if data storage {DATA}.-{-:1b} run function {NS}:{DIR}{CHILD}.do
execute if data storage {DATA}.-{-:0b} run function {NS}:{DIR}{SELF}.stop

#{SELF}.stop#
scoreboard players set $result kd_bt {result}
function {NS}:{DIR}{CHILD}.stop