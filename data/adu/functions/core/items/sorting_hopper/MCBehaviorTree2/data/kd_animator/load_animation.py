import json
import math
from pathlib import Path

def tick(second):
  return round(20*second)

def adjustComponent(kind,axis,value):
  adjust = {
    ('r',0):math.radians(value),
    ('r',1):math.radians(value),
    ('r',2):math.radians(value),
    ('t',0):-value,
    ('t',1):-value,
    ('t',2):value,
  }
  return adjust[(kind,axis)]

def getANIM(path):
  name = path.name
  path = path / (name +'.animation.json')
  with path.open() as f:
    content = f.read()
  json_content = json.loads(content)

  return { animation:(tick(animation_data['animation_length']),flattenAnimation(animation_data)) for animation,animation_data in json_content['animations'].items() }

def flattenAnimation(animation):
  components = {}
  kindMap = {'rotation':'r','position':'t'}
  for bone,bone_value in animation['bones'].items():
    for kind,vectors in bone_value.items():
      if kind in ('rotation','position'):
        components|={(bone,kindMap[kind],axis):[(value[0],adjustComponent(kindMap[kind],axis,value[1]),value[2]) for value in values] for axis,values in loadVectors(vectors).items() }
  return components

def loadVectors(vectors):
  if type(vectors) is list:
    return loadVectors({'0':vectors})

  components = []
  for k,v in vectors.items():
    if type(v) is list:
      components.append((tick(float(k)),v,True))
    elif type(v) is dict:
      components.append((tick(float(k)),v['post'],False))

  components = { axis : [(component[0],component[1][axis],component[2]) for component in components ] for axis in (0,1,2)}
  return components