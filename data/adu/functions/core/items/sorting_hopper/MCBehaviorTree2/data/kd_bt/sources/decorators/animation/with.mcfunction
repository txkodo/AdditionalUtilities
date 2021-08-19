#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD
#TAG

#entity
#tag
#%arg = {"DATA":"{DATA}","ANIMTAG":"{tag}","ANIMENTITY":"{entity}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#
tag @s add kd_animation
attribute @s generic.attack_damage base set 0.0
effect give @s invisibility 1000000 1 true

summon {entity} ~ ~ ~ {NoAI:1b,Tags:[kd_],Invulnerable:1b}
execute as @e[tag=kd_] run function {NS}:{DIR}{SELF}.init.as

#{SELF}.init.as#
attribute @s generic.max_health base set 1024.0
tag @s add {TAG}
tag @s add {tag}
tag @s add _KDBT_
tag @s add _KDBT_NEW
tag @s remove kd_

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute as @e[tag={TAG},tag={tag}] run function {NS}:{DIR}{SELF}.do.anim
function {NS}:{DIR}{CHILD}.do

#{SELF}.do.anim#
tp @s ~ ~ ~ ~ ~
tag @s add _KDBT_


#{SELF}.stop#
function {NS}:{DIR}{CHILD}.stop
kill @e[tag={TAG},tag={tag}]