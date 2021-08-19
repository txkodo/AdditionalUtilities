
execute unless data storage kd_bt:test t.-[-16]._.charge._.- run function kd_bt:roots/book_golem/charge/1.init
execute if data storage kd_bt:- {event:tick} run function kd_bt:roots/book_golem/charge/1.tick
