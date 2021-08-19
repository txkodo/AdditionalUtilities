# MCFA #

#NS
#DIR
#DATA
#SELF
#CHILDS
#%arg = {"{*CHILDS}":{"DATA":"{DATA}.{*CHILDS}","DIR":"{DIR}{*CHILDS}/","SELF":"0"}}

#{SELF}.init#
data modify storage {DATA} set value {}
data modify storage {DATA}.- set value []

data modify storage {DATA}.- prepend value {-:{-:{*CHILDS}}}

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init

execute if data storage {DATA}.-[-1].-{-:{*CHILDS}} unless score $result kd_bt matches 0 run function {NS}:{DIR}{SELF}.{*CHILDS}.do
execute if data storage {DATA}.-[-1].-{-:{*CHILDS}} if score $result kd_bt matches 1 run data remove storage {DATA}.{*CHILDS}
execute if data storage {DATA}.-[-1].-{-:{*CHILDS}} if score $result kd_bt matches 1 run data remove storage {DATA}.-[-1]

#{SELF}.{*CHILDS}.do#
scoreboard players set $result kd_bt -1
function {NS}:{DIR}{*CHILDS}/0.do

#{SELF}.stop#
execute if data {DATA}.{*CHILDS} run function {NS}:{DIR}{*CHILDS}/0.stop
