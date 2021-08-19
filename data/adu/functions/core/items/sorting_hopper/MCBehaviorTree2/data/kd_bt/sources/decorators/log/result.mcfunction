#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#success="success"
#failure="failure"

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
function {NS}:{DIR}{CHILD}.do
execute if score $result kd_bt matches 1 run say {success}
execute if score $result kd_bt matches 0 run say {failure}

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop