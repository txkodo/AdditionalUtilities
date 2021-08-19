data modify storage adu:items teleporter.channels[{.:.}].Slot set value 2b
data modify block ~ ~ ~ Items append from storage adu:items teleporter.channels[{.:.}]
data modify storage adu:items teleporter.channels[{.:.}] set value {}