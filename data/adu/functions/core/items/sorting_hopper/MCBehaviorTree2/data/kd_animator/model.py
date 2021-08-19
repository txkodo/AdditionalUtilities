import json
from pathlib import Path
from animation import getAnimations
from itertools import product

def getANIM(path,name):
  path = path / (name +'.animation.json')
  with path.open() as f:
    content = f.read()
  return json.loads(content)

def getJEM(path,name):
  path = path / (name +'.jem')
  with path.open() as f:
    content = f.read()
  return json.loads(content)

def getBones(jem:dict):
  bone_temp = list(filter(lambda x:x['part']=='bone',jem['models']))
  if len(bone_temp) != 1:
    raise Exception('boneは一つだけ')
  bone = bone_temp[0]
  return bone['submodels']

#models:[{MODEL},...]
def flatttenBones(models,model_map:dict={}):
  zero = [0.0,0.0,0.0]
  for model in models:
    t = model['translate'] if 'translate' in model else zero
    r = model['rotation'] if 'rotation' in model else zero
    model_map[model['id']] = {'translate':t,'rotation':r}
    if 'submodels' in model:
      model_map|=flatttenBones(model['submodels'])
  return model_map

def genCEM(path:Path):
  name = path.name

  #get json data
  jem  = getJEM(path,name)
  anim = getANIM(path,name)
  
  #bone model data
  bones = getBones(jem)
  
  #{bone:{rotation:[],translate:[]]}}
  partOrigins = flatttenBones(bones)

  start_ticks, animations = getAnimations(anim,'(age%8192+8192*(max_health%1))%8192',partOrigins)

  def animateBones(bones:list[dict]):
    return [ bone  | {'part':bone['id']} | ({'animations': [animateBone(bone)]} if animateBone(bone) else {}) for bone in bones ]

  def animateBone(bone:dict):
    bone_animations = {}
    bone_id = bone['id']

    origins = { k1+k2:partOrigins[bone_id][v1][v2] for k1,v1 in zip("tr",('translate','rotation')) for k2,v2 in zip("xyz",(0,1,2))}
    origins['ty'] = -origins['ty']
    suffix = { ''.join(x):'+' + bone_id[:-2] + '.' + ''.join(x) if bone_id[-1] == '_' else '' for x in product("r","xyz") }

    for k in map(''.join,product("tsr","xyz")):
      if bone_id  in animations and k in animations[bone_id]:
        bone_animations[bone_id+'.'+ k] = animations[bone_id][k] + (suffix[k] if k in suffix else '')
      elif k in suffix:
        bone_animations[bone_id+'.'+ k] = (str(origins[k]) + suffix[k]) if k[0] !='s' else suffix[k]

    if 'submodels' in bone:
      for bone in bone['submodels']:
        bone_animations |= { bone_id+':'+k:v for k,v in animateBone(bone).items()}

    return bone_animations

  jem['models'] = animateBones(bones)

  return start_ticks,json.dumps(jem)
