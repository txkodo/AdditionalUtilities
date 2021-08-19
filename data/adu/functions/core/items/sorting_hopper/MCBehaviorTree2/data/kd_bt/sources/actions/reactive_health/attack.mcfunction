#MCFA#

#NS
#DIR
#SELF
#DATA

## normal:武具により軽減される
## fixed:固定ダメージ
#type="normal"

#damage
#target

#{SELF}.do#
# data modify storage kd_rhp: type set value {type}
scoreboard players remove {target} ReactiveHP {damage}
function reactive_health:mcbt/attack
scoreboard players set $result kd_bt 1