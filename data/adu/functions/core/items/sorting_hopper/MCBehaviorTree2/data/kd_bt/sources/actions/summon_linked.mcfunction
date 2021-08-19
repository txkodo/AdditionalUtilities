# MCFA #

#NS
#DIR
#SELF
#DATA

#entity
#pos="~ ~ ~"
##Tags[kd_,...] is Necessary
#nbt="{Tags:[kd_]}"
#commands = []

#{SELF}.do#
summon {entity} {pos} {nbt}

execute as @e[tag=kd_] run function {NS}:{DIR}{SELF}.do.as

scoreboard players set $result kd_bt 1

#{SELF}.do.as#
tag @s add {TAG}
tag @s add _KDBT_
tag @s add _KDBT_NEW

{*commands}

tag @s remove kd_