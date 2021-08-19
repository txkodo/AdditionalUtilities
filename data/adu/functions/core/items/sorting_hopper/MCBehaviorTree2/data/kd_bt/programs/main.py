from pathlib import Path
import json

import mcfa2  as mcfa
import node2  as node
import consts as consts

with (consts.ROOT_PATH / 'roots.json').open() as f:
  rootJson = json.loads(f.read())

for k,v in rootJson.items():
  root = node.get(k)
  root.bake({},v)
 
reset = consts.FUNCTION_ROOT_PATH / 'reset.mcfunction'
if reset.exists():
  reset.replace(consts.FUNCTION_ROOT_PATH / 'reset_.mcfunction')

mcfa.MCFA.genInitAndReset()