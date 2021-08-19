import os
from model2 import genModel
from pathlib import Path

current_path = os.path.dirname(os.path.abspath(__file__))

c_path = Path(current_path)

resource = r'C:\Users\shiyu\OneDrive\default\resourcepacks\kd_animation'
function = r'C:\Users\shiyu\OneDrive\default\saves\MAZE\datapacks\MCBehaviorTree2\data\kd_animator\functions'

resource_path = Path(resource)
cem_path = resource_path / r'assets\minecraft\optifine\cem'

entityDirPaths = [ inner for inner in (c_path / 'entities').iterdir() if inner.is_dir() ]

start_ticks = {}
for entityDirPath in entityDirPaths:
  name = entityDirPath.name
  ticks, model = genModel(entityDirPath,'(age%8192+8192*(max_health%1))%8192')
  with (cem_path / (name + '.jem' )).open(mode='w') as f:
    f.write(model)
  start_ticks[name] = ticks

def dict2nbt(data:dict):
  return '{' + ','.join(k +':'+ (dict2nbt(v) if type(v) is dict else str(v)) for k,v in data.items()) + '}'

command = 'data modify storage kd_animation: ticks set value '+ dict2nbt(start_ticks)

function_path = Path(function)
with (function_path / 'core/start_ticks.mcfunction').open(mode='w') as f:
  print(command)
  f.write(command)
