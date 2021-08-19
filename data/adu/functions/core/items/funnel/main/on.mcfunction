
# スタックされたアイテムがある場合
execute if data storage adu:items funnel.multi[0] run function adu:core/items/funnel/main/on.switch

# スタックされたアイテムがない場合
execute unless data storage adu:items funnel.multi[0] run function adu:core/items/funnel/main/to_off
