import json

def getModel(path):
  name = path.name
  path = path / (name +'.jem')
  with path.open() as f:
    content = f.read()
  return json.loads(content)

def flattenModel(model):

  def recursive(parent,bones):
    components = {}
    for bone in bones:
      components[(bone['id'],'t',1)] = (parent,bone['translate'][1] if 'translate' in bone else 0.0)
      components[(bone['id'],'t',0)] = (parent,bone['translate'][0] if 'translate' in bone else 0.0)
      components[(bone['id'],'t',2)] = (parent,bone['translate'][2] if 'translate' in bone else 0.0)
      components[(bone['id'],'r',0)] = (parent,bone['rotation' ][0] if 'rotation'  in bone else 0.0)
      components[(bone['id'],'r',1)] = (parent,bone['rotation' ][1] if 'rotation'  in bone else 0.0)
      components[(bone['id'],'r',2)] = (parent,bone['rotation' ][2] if 'rotation'  in bone else 0.0)
      if 'submodels' in bone:
        components |= recursive(parent+bone['id']+':',bone['submodels'])
    return components

  components = recursive('',model)
  return components