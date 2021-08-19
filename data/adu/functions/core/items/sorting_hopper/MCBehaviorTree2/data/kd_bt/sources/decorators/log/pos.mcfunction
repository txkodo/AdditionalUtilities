#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#pos="~ ~ ~"

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
particle minecraft:flame {pos} 0 0 0 0 1
function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop