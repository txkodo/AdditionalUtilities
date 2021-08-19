#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#entity

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}","ANIM_ENTITY":"{entity}"}

#{SELF}.do#
execute if data storage kd_bt:- {event:tick} run function kd_animator:mcbt/tick
function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop