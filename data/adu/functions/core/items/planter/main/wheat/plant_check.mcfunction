execute if block ~ ~ ~ air if block ~ ~-1 ~ #adu:dirt run setblock ~ ~-1 ~ farmland

execute if block ~ ~ ~ wheat[age=7] store success storage adu:items planter.harvested byte 1 if block ~ ~-1 ~ farmland run setblock ~ ~ ~ air
execute if block ~ ~ ~ air if block ~ ~-1 ~ farmland store success storage adu:items planter.planted byte 1 run setblock ~ ~ ~ wheat[age=0]
