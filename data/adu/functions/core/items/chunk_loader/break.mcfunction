kill @s
data modify entity @e[type=item,nbt={"Item":{"id":"minecraft:chiseled_polished_blackstone"}},limit=1,distance=..0.5] Item.tag set value {display:{Name:'{"italic":false,"text":"Chunk Loader"}'}}

forceload remove ~ ~