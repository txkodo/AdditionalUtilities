# MCFA #

#NS
#DIR
#DATA
#SELF
#CHILD

#as
#%arg = {"DATA":"{DATA}._","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
execute as {as} if score @s {SCORE} = $current {SCORE} run function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop