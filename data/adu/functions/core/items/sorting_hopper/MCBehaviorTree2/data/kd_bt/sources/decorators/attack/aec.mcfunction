#MCFA#

#NS
#DIR
#DATA
#SELF
#CHILD
#TAG

#tag
#offset              = "~ ~ ~"
#reapplication_delay = "10"
#particle            = "entity_effect"
#radius              = "3f"
#radius_on_use       = "0f"
#radius_per_tick     = "0f"
#duration            = "32768"
#age                 = "0"
#wait_time           = "0"
#color               = "16711680"
#amplifier           = "1b"
#efffect_duration    = "0"
#show_particles      = "0b"

#%arg = {"DATA":"{DATA}","DIR":"{DIR}","SELF":"{CHILD}"}

#{SELF}.init#

#{SELF}.do#

#{SELF}.stop#




#{SELF}.init#
summon area_effect_cloud {offset} {Tags:[kd_],Particle:{particle},ReapplicationDelay:{reapplication_delay},Radius:{radius},RadiusPerTick:{radius_per_tick},RadiusOnUse:{radius_on_use},Duration:{duration},Age:{age},WaitTime:{wait_time},Effects:[{Id:7,Amplifier:{amplifier},Duration:{efffect_duration},ShowParticles:{show_particles}}]}
execute as @e[tag=kd_] run function {NS}:{DIR}{SELF}.init.as

#{SELF}.init.as#
tag @s add {tag}
tag @s add {TAG}
tag @s add _KDBT_
tag @s add _KDBT_NEW
tag @s remove kd_

#{SELF}.do#
execute unless data storage {DATA}.- run function {NS}:{DIR}{SELF}.init
execute as @e[tag={TAG},tag={tag}] run function {NS}:{DIR}{SELF}.do.follow
function {NS}:{DIR}{CHILD}.do

#{SELF}.do.follow#
tp @s ~ ~ ~ ~ ~
tag @s add _KDBT_
