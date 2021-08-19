
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.damage._ set value {}
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.damage._.- set value []
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.damage._.- prepend value {-:{-:damage}}
data modify storage kd_bt:test t.-[-16]._.rotate.repeat._.damage._.- prepend value {-:{-:wait}}
