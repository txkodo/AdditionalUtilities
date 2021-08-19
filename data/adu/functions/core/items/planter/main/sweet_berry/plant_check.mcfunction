
execute if block ~ ~ ~ sweet_berry_bush[age=3] store success storage adu:items planter.harvested byte 1 if block ~ ~-1 ~ #adu:dirt run setblock ~ ~ ~ sweet_berry_bush[age=1]
execute if block ~ ~ ~ air if block ~ ~-1 ~ #adu:dirt store success storage adu:items planter.planted byte 1 run setblock ~ ~ ~ sweet_berry_bush[age=0]
