a = '''
execute if score $_ kd_animation matches {a}.. run attribute @s generic.max_health modifier add 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f{c} "2^{c}" {d} add
execute if score $_ kd_animation matches ..{b} run attribute @s generic.max_health modifier remove 8e67300a-ccb9-41ac-a2f5-c6b3d22ae5f{c}
execute if score $_ kd_animation matches {a}.. run scoreboard players remove $_ kd_animation {a}
'''


b = ''.join( a.format(a=2**i,b=2**i-1,c=hex(i)[2:],d=2**i/8192) for i in range(12,-1,-1) )

print(b)