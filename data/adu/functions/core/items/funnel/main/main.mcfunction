data modify storage adu:items funnel.multi set from storage adu:items funnel.items
data remove storage adu:items funnel.multi[{Count:1b}]

# offかつ複数アイテム入っているスロットがあった場合
execute if entity @s[tag=!adu.funnel.on] if data storage adu:items funnel.multi[0] run function adu:core/items/funnel/main/to_on

# onかつslot0のアイテムが1こだった場合
execute if entity @s[tag=adu.funnel.on] if data storage adu:items funnel.items[{Slot:0b,Count:1b}] run function adu:core/items/funnel/main/on

# storage -> block
data modify block ~ ~ ~ Items set from storage adu:items funnel.items