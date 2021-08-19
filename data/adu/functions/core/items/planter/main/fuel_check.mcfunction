execute store result storage adu: _ byte 1 unless data block ~ ~ ~ {BurnTime:0s}
execute if data storage adu: {_:0b} store result storage adu: _ byte 1 if data block ~ ~ ~ Items[{Slot:1b}]
execute if data storage adu: {_:1b} run function adu:core/items/planter/main/rotated