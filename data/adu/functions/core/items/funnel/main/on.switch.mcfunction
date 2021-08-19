# インベントリを交換
data modify storage adu:items funnel.items append from storage adu:items funnel.items[0]
data modify storage adu:items funnel.items[-1].Slot set from storage adu:items funnel.multi[0].Slot
data modify storage adu:items funnel.multi[0].Slot set value 0b

data modify storage adu:items funnel.items append from storage adu:items funnel.multi[0]