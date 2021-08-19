
data modify storage kd_bt:test t.-[-16]._.attack._._ set value {}
data modify storage kd_bt:test t.-[-16]._.attack._._.- set value []
data modify storage kd_bt:test t.-[-16]._.attack._._.- prepend value {-:{-:wait}}
data modify storage kd_bt:test t.-[-16]._.attack._._.- prepend value {-:{-:attack}}
