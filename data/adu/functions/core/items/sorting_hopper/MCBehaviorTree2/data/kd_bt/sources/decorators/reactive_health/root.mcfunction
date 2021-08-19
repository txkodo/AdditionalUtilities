#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
function reactive_health:mcbt/init

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute if data storage kd_bt:- {event:tick} run function reactive_health:mcbt/tick
function {NS}:{DIR}{CHILD}.do

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop
