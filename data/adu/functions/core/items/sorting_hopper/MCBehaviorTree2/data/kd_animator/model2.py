from pathlib import Path
import load_animation
import load_model
import json
import math

class V_component:
  def __init__(self,parent,bone,kind,axis,default,param):
    def adjustComponent(value):
      adjust = {
        ('r',0):math.radians(value),
        ('r',1):math.radians(value),
        ('r',2):math.radians(value),
        ('t',0):value,
        ('t',1):-value,
        ('t',2):value,
      }
      return adjust[(self.kind,self.axis)]

    self.parent = parent
    self.bone     = bone
    self.kind     = kind
    self.axis     = axis
    self.default  = adjustComponent(default)
    self.segments = []
    self.time     = 0.0
    self.param = param

  def addAnimation(self,knots:list[tuple],start,length):
    end = start + length
    times,values,knot_types = zip(*knots)
    values = tuple(self.default+value for value in values)
    self.segments += larpSegments(times,values,knot_types,start,end,self.param)

  def noAnimation(self,time):
    self.segments += [(time,[self.default])]

  def exportFunc(self):
    segments = []
    segments.append(self.segments[0])
    for i in range(1,len(self.segments)):
      if self.segments[i-1][1] != self.segments[i][1]:
        segments.append(self.segments[i])

    suffix = '+'+ self.bone[:-2]+'.'+self.kind+'xyz'[self.axis] if self.bone[-1] == '_' and self.kind == 'r' else ''

    if len(segments)==1 and len(segments[0][1]) == 1 and not suffix:
      return None

    return { self.componentName() :joinedFuncs(segments,suffix,self.param)}

  def componentName(self):
    return self.parent+self.bone+'.'+self.kind+'xyz'[self.axis]

def joinedFuncs(segments,suffix,param):
  times,_ = zip(*segments)
  funcs = [segmentToStr(segment,f'({param}-{time})') + suffix for time,segment in segments]
  return binarySearch(f'{param}<{{0}}',times,funcs)


def binarySearch(condition,keys,funcs):
  l = len(keys)
  if l > 1:
    half = l//2
    before = binarySearch(condition,keys[:half],funcs[:half])
    after  = binarySearch(condition,keys[half:],funcs[half:])
    return f'if({condition.format(keys[half])},{before},{after})'
  elif l == 1:
    return funcs[0]


def segmentToStr(segment,param:str):
  def withSymbol(i:float):
    return f'+{i:.10f}' if i >= 0 else f'{i:.10f}'

  def recursive(nums:list[float],param:str)->str:
    if len(nums) > 1 and recursive(nums[1:],param):
      return f'({recursive(nums[1:],param)}*{param}{withSymbol(nums[0])})' if nums[0] else f'{recursive(nums[1:],param)}*{param}'
    else:
      num = nums[0]
      return f'{num:.10f}' if nums[0] else f''

  f = recursive(segment,param)
  return f if f else '0'

def larpSegments(times:list[float],values:list[float],knotTypes:list[bool],start:float,end:float,param:str):
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
    b = [ p0-(t0*a) ,a]
    return b

  l = len(times)
  vecs = [0.0] + [ (values[i+1] - values[i-1])/(times[i+1] - times[i-1]) for i in range(1,l-1)] + [0.0]
  segmentTypes = [ i and j for i,j in zip(knotTypes[1:],knotTypes[:-1])]

  segments = [ linear(values[i],values[i+1],0,times[i+1]-times[i]) if segmentTypes[i] else catMullrom(values[i],values[i+1],vecs[i],vecs[i+1],0,times[i+1]-times[i]) for i in range(len(segmentTypes))]

  times = tuple(map(lambda x: x+start,times))
  if times[0] != start:
    times = (start,) + times
    segments = [[values[0]]] + segments

  if times[-1] != end:
    segments = segments + [[values[-1]]]
    times = times + (end,)

  return list(zip(times[:-1],segments))

def adjustComponent(kind,axis,value):
  adjust = {
    ('r',0):math.radians(value),
    ('r',1):math.radians(value),
    ('r',2):math.radians(value),
    ('t',0):-value,
    ('t',1):value,
    ('t',2):value,
  }
  return adjust[(kind,axis)]

def genModel(path,param):
  model = load_model.getModel(path)

  components = load_model.flattenModel(model['models'][0]['submodels'])
  components = { bone:V_component(default[0],*bone,adjustComponent(bone[1],bone[2],default[1]),param) for bone,default in components.items()}

  anim  = load_animation.getANIM(path)

  time = 0.0
  storage = {}
  for anim_name,(length,a_componemts) in anim.items():
    storage[anim_name] = {'s':time,'l':length}
    for key in components:
      if key in a_componemts:
        components[key].addAnimation(a_componemts[key],time,length)
      else:
        components[key].noAnimation(time)
    time += length
  
  funcs = {}
  for key,component in components.items():
    func = component.exportFunc()
    if func:
      funcs |= func

  model['models'] = model['models'][0]['submodels']
  for part in model['models']:
    part['part'] = part['id']

  model['models'][0]['animations'] = [funcs]

  del model['texture']

  return storage, json.dumps(model)