#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD

#before="before"
#after="after"

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.do#
say {before}
function {NS}:{DIR}{CHILD}.do
say {after}

#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop