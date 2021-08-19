setblock ~ 0 ~ barrel

loot replace block ~ 0 ~ container.2 loot adu:crops/sweet_berry
data modify block ~ ~ ~ Items append from block ~ 0 ~ Items[{Slot:2b}]

setblock ~ 0 ~ bedrock

function adu:core/fuel/main