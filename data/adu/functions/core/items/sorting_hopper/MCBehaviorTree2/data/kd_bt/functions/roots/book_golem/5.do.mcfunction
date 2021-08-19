
execute unless data storage kd_bt:test t.-[-16]._.- run function kd_bt:roots/book_golem/5.init
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:charge} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/5.charge.do
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:charge} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.charge
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:charge} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.-[-1]
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:rotate} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/5.rotate.do
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:rotate} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:rotate} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.-[-1]
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:attack} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/5.attack.do
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:attack} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.attack
execute if data storage kd_bt:test t.-[-16]._.-[-1].-{-:attack} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.-[-1]
