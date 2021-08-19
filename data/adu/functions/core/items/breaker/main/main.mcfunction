execute as @s run loot replace entity @s weapon.offhand mine ^ ^ ^1 mainhand
data modify storage adu:items breaker.result set from entity @s HandItems[1]
data modify entity @s HandItems[1] set value {}
data modify storage adu:items breaker.result.Slot set value 2b
data modify block ~ ~ ~ Items append from storage adu:items breaker.result
setblock ^ ^ ^1 air

execute if predicate adu:core/items/breaker/unbreaking_check run function adu:core/items/breaker/main/remove_durability
