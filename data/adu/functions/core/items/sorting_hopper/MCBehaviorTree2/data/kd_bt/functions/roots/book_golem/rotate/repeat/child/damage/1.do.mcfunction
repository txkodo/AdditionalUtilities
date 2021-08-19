
execute unless data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.- run function kd_bt:roots/book_golem/rotate/repeat/child/damage/1.init
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:damage} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/repeat/child/damage/1.damage.do
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:damage} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.damage
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:damage} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1]
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:wait} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/repeat/child/damage/1.wait.do
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:wait} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.wait
execute if data storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1].-{-:wait} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat._.child.damage._.-[-1]
