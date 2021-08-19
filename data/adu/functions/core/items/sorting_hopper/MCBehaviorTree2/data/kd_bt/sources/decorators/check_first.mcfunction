#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#commands=[]
#condition
#result="0"
#%arg = {"DATA":"{DATA}._","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
{*commands}

execute {condition} run data modify storage {DATA}.- set value 1b
execute unless data storage {DATA}.- run scoreboard players set $result kd_bt {result}

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage {DATA}.- run function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop