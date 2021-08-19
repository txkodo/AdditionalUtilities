
execute unless data storage kd_bt:test t.-[-16]._.rotate.- run function kd_bt:roots/book_golem/rotate/0.init
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:face} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/0.face.do
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:face} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.face
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:face} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.-[-1]
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:before} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/0.before.do
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:before} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.before
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:before} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.-[-1]
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:repeat} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/0.repeat.do
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:repeat} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.repeat
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:repeat} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.-[-1]
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:after} unless score $result kd_bt matches 0 run function kd_bt:roots/book_golem/rotate/0.after.do
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:after} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.after
execute if data storage kd_bt:test t.-[-16]._.rotate.-[-1].-{-:after} if score $result kd_bt matches 1 run data remove storage kd_bt:test t.-[-16]._.rotate.-[-1]
