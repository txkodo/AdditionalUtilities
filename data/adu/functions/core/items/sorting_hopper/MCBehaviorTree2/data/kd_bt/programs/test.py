import random
def getUnique():
  def recursive(num:int):
    int_chr = num % 36
    int_chr += 87 if int_chr >= 10 else 48
    str_chr = chr(int_chr)
    if num >= 36:
      str_chr = recursive(num//36) + str_chr
    return str_chr
  
  num = random.randrange(0,131621703842267136)
  
  converted = recursive(num)
  return 'kdbt_'+'0'*(11 - len(converted)) + converted
