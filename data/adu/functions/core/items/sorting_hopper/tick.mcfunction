execute unless block ~ ~ ~ minecraft:hopper{CustomName:'{"italic":false,"text":"Sorting Hopper"}'} run kill @s

#define tag adu.sorting_hopper

execute if data block ~ ~ ~ {TransferCooldown:0} run data modify block ~ ~ ~ TransferCooldown set value 8
execute if block ~ ~ ~ minecraft:hopper if data block ~ ~ ~ {TransferCooldown:1} run function adu:core/items/sorting_hopper/tick.next
