
execute unless data storage kd_bt:test t.-[-16]._.attack._._.- run function kd_bt:roots/book_golem/attack/2.init
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:wait} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/attack/2.wait.do
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:wait} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.attack._._.wait
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:wait} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.attack._._.-[-1]
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:attack} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/attack/2.attack.do
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:attack} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.attack._._.attack
execute if data storage kd_bt:test t.-[-16]._.attack._._.-[-1].-{-:attack} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.attack._._.-[-1]
