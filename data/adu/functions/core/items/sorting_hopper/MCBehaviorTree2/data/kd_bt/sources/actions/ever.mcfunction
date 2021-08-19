#MCFA#

#NS
#DIR
#SELF
#DATA

#{SELF}.init#
data modify storage {DATA}.- set value 1b

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init