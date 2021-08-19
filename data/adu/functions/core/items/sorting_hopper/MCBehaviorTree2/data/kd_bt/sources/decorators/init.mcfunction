#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#function

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
function {function}

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
function {NS}:{DIR}{CHILD}.do