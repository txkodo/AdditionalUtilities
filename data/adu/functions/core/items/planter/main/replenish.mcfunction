execute if score @s adu.planter matches 1..64 run function adu:core/items/planter/main/wheat/replenish
scoreboard players remove @s adu.planter 64
execute if score @s adu.planter matches 1..64 run function adu:core/items/planter/main/beetroot/replenish
scoreboard players remove @s adu.planter 64
execute if score @s adu.planter matches 1..64 run function adu:core/items/planter/main/potato/replenish

scoreboard players set @s adu.planter 0
