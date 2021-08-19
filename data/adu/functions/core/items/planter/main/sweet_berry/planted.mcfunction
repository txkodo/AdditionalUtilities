execute store result score $rest adu.planter run data get block ~ ~ ~ Items[{Slot:0b}].Count
scoreboard players remove $rest adu.planter 1
execute store result block ~ ~ ~ Items[{Slot:0b}].Count byte 1 run scoreboard players get $rest adu.planter

function adu:core/fuel/main