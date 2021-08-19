
execute if block ~ ~ ~ nether_wart[age=3] store success storage adu:items planter.harvested byte 1 if block ~ ~-1 ~ soul_sand run setblock ~ ~ ~ air
execute if block ~ ~ ~ air if block ~ ~-1 ~ soul_sand store success storage adu:items planter.planted byte 1 run setblock ~ ~ ~ nether_wart[age=0]
