# MCFA #

#NS
#DIR
#DATA
#SELF
#CHILDS

#%arg = {"{*CHILDS}":{"DATA":"{DATA}.{*CHILDS}","DIR":"{DIR}{*CHILDS}/","SELF":"0"}}

#{SELF}.init#
data modify storage {DATA} set value {}

data modify storage {DATA}.-.{*CHILDS} set value 1b

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init

execute unless score $result kd_bt matches 1 if data storage {DATA}.-.{*CHILDS} run function {NS}:{DIR}{SELF}.{*CHILDS}.do

execute if score $result kd_bt matches 0 store result score _ kd_bt run data get storage {DATA}.-
execute if score $result kd_bt matches 0 unless score _ kd_bt matches 0 run scoreboard players set $result kd_bt -1

#{SELF}.{*CHILDS}.do#
scoreboard players set $result kd_bt -1
function {NS}:{DIR}{*CHILDS}/0.do
execute unless score $result kd_bt matches -1 run data remove storage {DATA}.-.{*CHILDS}
execute unless score $result kd_bt matches -1 run data remove storage {DATA}.{*CHILDS}

#{SELF}.stop#
execute if data {DATA}.{*CHILDS} run function {NS}:{DIR}{*CHILDS}/0.stop