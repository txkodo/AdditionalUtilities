execute unless block ~ ~ ~ minecraft:hopper{CustomName:'{"italic":false,"text":"Funnel"}'} run kill @s

# block -> storage
data modify storage adu:items funnel.items set from block ~ ~ ~ Items

# インベントリが埋まっている場合
execute if block ~ ~ ~ minecraft:hopper if data storage adu:items funnel.items[4] run function adu:core/items/funnel/main/main