
function kd_bt:roots/book_golem/0.adjust
execute if score $new kdbt_f6o3as35dql matches 1 run data modify storage kd_bt:test t.-[-16] set value {}
execute unless data storage kd_bt:test t.-[-16].-- run function kd_bt:roots/book_golem/0.do.e2
