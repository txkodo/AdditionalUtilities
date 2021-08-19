from operator import itemgetter, attrgetter
from functools import reduce
import math

#多項式係数リストを文字列式に
def segmentToStr(segment,param:str):

  def withSymbol(i:int):
    return '+'+str(i) if i >= 0 else str(i) 

  def recursive(nums:list[float],param:str)->str:
    if len(nums) > 1 and recursive(nums[1:],param):
      return f'({recursive(nums[1:],param)}*{param}{withSymbol(nums[0])})' if nums[0] else f'{recursive(nums[1:],param)}*{param}'
    else:
      return f'{nums[0]}' if nums[0] else f''

  f = recursive(segment,param)
  return f if f else '0'

#複数関数を定義域で条件分岐
def joinFunction(condition:str,keys:list,functions:list[str]):
  if len(functions) > 1:
    #単純化
    simple_keys      = []
    simple_functions = []
    for i in range(len(keys)):
      if functions[i] != functions[i+1]:
        simple_keys.append(keys[i])
        simple_functions.append(functions[i])
    simple_functions.append(functions[-1])
    functions = simple_functions
  
  if len(functions) > 1:
    return 'if (' + ','.join(condition.format(key) +','+ function for key,function in zip(simple_keys,simple_functions[:-1])) +','+ simple_functions[-1] + ')'
  elif len(functions) == 1:
    return functions[0]
  else:
    return ''

#点群から補完関数の多項式係数リストを取得
def larpSegments(times:list[float],values:list[float],knotTypes:list[bool]):
  def catMullrom(p0,p1,m0,m1,t0,t1):
    a = [
      p0,
      m0,
      -3*p0-2*m0+3*p1-m1,
      2*p0+m0-2*p1+m1
    ]
    a0,a1,a2,a3 = a
    dt0 = 1
    dt1 = t1 - t0
    dt2 = dt1**2
    dt3 = dt1**3
    t00 = 1
    t01 = t0
    t02 = t01**2
    t03 = t01**3

    b = [
      1*a0*t00/dt0 - 1*a1*t01/dt1 + 1*a2*t02/dt2 - 1*a3*t03/dt3,
                      1*a1*t00/dt1 - 2*a2*t01/dt2 + 3*a3*t02/dt3,
                                    1*a2*t00/dt2 - 3*a3*t01/dt3,
                                                    1*a3*t00/dt3
    ]
    return b

  def linear(p0,p1,t0,t1):
    a = (p1-p0)/(t1-t0)
    return [ p0-(t0*a) ,a]

  l = len(times)
  vecs = [0.0] + [ 0.0 if knotTypes[i] else (values[i+1] - values[i-1])/(times[i+1] - times[i-1]) for i in range(1,l-1)] + [0.0]
  segmentTypes = [ i and j for i,j in zip(knotTypes[1:],knotTypes[:-1])]

  segments = [ linear(values[i],values[i+1],times[i],times[i+1]) if segmentTypes[i] else catMullrom(values[i],values[i+1],vecs[i],vecs[i+1],times[i],times[i+1]) for i in range(len(segmentTypes))]

  return segments

#一軸のアニメーション関数を取得
def getAnimFunction(times:list[float],values:list[float],knotTypes:list[bool],start:float,end:float,param:str):

  #区間ごとの多項式係数リストを取得
  segments = larpSegments(times,values,knotTypes)

  if times[0] != start:
    times = (start,) + times
    segments = [[values[0]]] + segments

  if times[-1] != end:
    segments = segments + [[values[-1]]]
    times = times + (end,)

  #係数の数式化
  functions = [segmentToStr(segment,param) for segment in segments]

  return list[zip(times[:-1],functions)]

#各軸のアニメーション関数を取得
def getAnimVecFunction(data:dict,start:float,length:float,param:str,conversion:str,partOrigin:dict[str,list[float]]):

  end = start + length

  def getVector(data):
    vector = []
    isLinear = False
    if type(data) is dict:
      vector = data['post']
    else:
      isLinear = True
      vector = data

    convert = {
      'rotation':lambda v: [math.radians(v[0]),math.radians(v[1]),math.radians(v[2])],
      'position':lambda v: [-v[0]-partOrigin['translate'][0] ,v[1]+partOrigin['translate'][1],v[2]+partOrigin['translate'][2]],
      'scale'   :lambda v: [v[0],v[1],v[2]]
    }

    return isLinear, convert[conversion](vector)

  #[(時間,ノットタイプ,ベクトル)]に成形し時間の昇順にソート
  data = sorted([ ((float(k)*20 + start), *getVector(v)) for k,v in data.items()],key=itemgetter(0))

  #時間,ノットタイプ,ベクトルそれぞれのタプルに分解
  times,knotTypes,vectors = zip(*data)

  #ベクトルを軸ごとに分解
  t_vector = [*zip(*vectors)]

  if conversion == 'position':
    t_vector[1] = tuple(map(lambda x:-x, t_vector[1]))
  activeAxis = [ any(components) for components in t_vector]

  #軸ごとに関数に変換
  conversionMap = {'position':'t','rotation':'r','scale':'s'}
  axisMap = { (k,axis): v+axis for axis in 'xyz' for k,v in conversionMap.items() }
  vecFunction = { axisMap[(conversion,axis)] : getAnimFunction(times,components,knotTypes,start,end,param) for components,isactive,axis in zip(t_vector,activeAxis,('xyz')) if isactive }
  return vecFunction

def getVecFunction(data,start:float,length:float,param:str,conversion,partOrigin:dict[str,list[float]]):
  if type(data) is list:
    data = {'0.0':data}
  return getAnimVecFunction(data,start,length,param,conversion,partOrigin)

#position,rotation,scale毎にアニメーション関数を取得
def getAnimVecsFunction(json:dict,start:float,length:float,param:str,partOrigin:dict[str,list[float]]):
  vecsfunction =  reduce(lambda x,y: x|y, ( getVecFunction(json[conversion],start,length,param,conversion,partOrigin) for conversion in ('position','rotation','scale') if conversion in json ),{})
  return vecsfunction

#アニメーションのパーツごとの関数を取得
def getAnimation(json:dict,start:float,param:str,partOrigins:dict[str,dict[str:list[float]]]):
  length = round(json['animation_length']*20) #second -> tick
  bones  = json['bones']
  bones_anims = { k: getAnimVecsFunction(v,start,length,param,partOrigins[k]) for k,v, in bones.items() }
  return bones_anims,length

#アニメーション毎に関数を取得しパーツごとに一つの関数に合成
def getAnimations(json:dict,param:str,partOrigins:dict[str,dict[str:list[float]]]):
  json = json['animations']
  anim_names = json.keys()
  anim_datas = json.values()

  times:list[float] = [0.0]
  animations:list[dict] = []

  #アニメーションデータを変換しリスト化
  for anim_data in anim_datas:
    if 'animation_length' in anim_data:
      animation, length = getAnimation(anim_data,times[-1],param,partOrigins)
      times.append(times[-1]+length)
      animations.append(animation)

  #動くパーツ名を抽出
  active_bones = {}
  for animation in animations:
    active_bones |= { k: active_bones[k]|set(v.keys()) if k in active_bones else set(v.keys()) for k,v in animation.items() }

  #アニメーションごとのデータをボーン軸毎のリストに合成
  conversions_anims = { k:{ vv:[] for vv in v} for k,v in active_bones.items() }
  def addAnimation(animation):
    nonlocal conversions_anims
    for bone in active_bones.keys():
      for conversion in active_bones[bone]:
        default = partOrigins[bone][{'t':'translate','r':'rotation'}[conversion[0]]][dict(zip('xyz',(0,1,2)))[conversion[1]]]
        if conversion in ('ty','tx'):
          default = -default
        conversions_anims[bone][conversion].append( animation[bone][conversion] if bone in animation and conversion in animation[bone] else str(default) )

  [addAnimation(animation) for animation in animations]

  #ボーン軸毎のリストを条件式に変換
  bones_convs_anim = { k:{ vk:joinFunction(param + ' < {0}',times[1:-1],vv) for vk, vv in v.items() } for k,v in conversions_anims.items() if v }

  return { k: { 's':int(s),'l':int(e-s)}  for k,s,e in zip(anim_names,times[:-1],times[1:]) }, bones_convs_anim