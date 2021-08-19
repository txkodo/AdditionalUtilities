data modify block ~ ~ ~ CookTime set value 0s
execute if score @s adu.planter matches 0 run function adu:core/items/planter/main/fuel_check
execute unless data block ~ ~ ~ Items[{Slot:2b}] unless score @s adu.planter matches 0 run function adu:core/items/planter/main/replenish
