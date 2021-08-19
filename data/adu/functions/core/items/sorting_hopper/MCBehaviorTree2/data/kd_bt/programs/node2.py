from pathlib import Path
import json
import random

from formattable import Formattable
import mcfa2 as mcfa
import consts

random.seed(0)

class MCBT:
  def __init__(self,path,root,tree_arg):
    self.path      = path
    self.root      = root
    self.tree_arg  = tree_arg

  def bake(self,cascade,tree_arg):
    self.root.bake(cascade,self.tree_arg|tree_arg)

def get(name:str) -> MCBT:
  if name in _loded:
    return _loded[name]
  mcbt = _load(consts.TREE_ROOT_PATH/(name+'.json'))
  _loded[name] = mcbt
  return mcbt

_loded:dict[str,MCBT] = {}

def _load(path:Path) -> MCBT:
  def loadNode(node):
    arg = node['arg'] if 'arg' in node else {}

    #root
    if 'root' in node:
      return RootNode(node['type'],arg,loadNode(node['root']))

    if 'decorators' in node and len(node['decorators']) > 0:
      decorator = node['decorators'].pop(0)
      arg = decorator['arg'] if 'arg' in decorator else {}

      #decorativetree
      if decorator['type'].startswith('#'):
        return DectorativeTreeNode(decorator['type'][1:],arg,loadNode(node))

      #decorator
      return DecoratorNode(decorator['type'],arg,loadNode(node))

    #composit
    if 'childs' in node:
      childs     = [ loadNode(child) for child in node['childs'].values()]
      childnames = [*node['childs'].keys()  ]
      return CompositNode(node['type'],arg,childnames,childs)

    #treechild
    if node['type'] == '##TREE_CHILD':
      return TreeChildNode('',arg)

    #subtree
    if node['type'].startswith('#'):
      return SubtreeNode(node['type'][1:],arg)

    #action
    return ActionNode(node['type'],arg)

  with path.open() as f:
    tree_json = json.loads(f.read())

  if 'enable' not in tree_json:
    raise MCBTerror(f'Set "enabled"::Bool in MCBT: {path}')
  if tree_json['enable'] == False:
    raise MCBTerror(f"Can't load disabled MCBT: {path}")

  tree_arg = tree_json['tree_arg'] if 'tree_arg' in tree_json else {}

  root = loadNode(tree_json)

  return MCBT(path,root,tree_arg)


class MCBTerror(Exception):pass

class Node:
  node_category = ''
  def __init__(self,node_type,arg:dict):
    self.node_type:str  = node_type
    self.mcfa:mcfa.MCFA = mcfa.loadMCFA(self.node_category+'/'+node_type)
    self.arg :dict      = self.formattableArg(arg)

  def bake(self,cascade):
    path = consts.FUNCTION_ROOT_PATH/cascade['DIR']
    path.mkdir(exist_ok=True)
    return self.mcfa.bake(path,cascade | {'UNIQUE':getUnique()} )

  def formattableArg(self,arg):
    return { k: Formattable(v) for k,v in arg.items() }

  def formatArg(self,tree_arg):
    return { k:v.format(tree_arg) for k,v in self.arg.items() }


class RootNode(Node):
  node_category = 'roots'
  def __init__(self,node_type,arg,child):
    super().__init__(node_type,arg)
    self.child    = child

  def bake(self,cascade,tree_arg):
    arg   = self.formatArg(tree_arg) | cascade
    print(self.mcfa.path,arg)
    child = str(int(arg['SELF'])+1)
    prop  = super().bake(arg | {'CHILD':child})
    self.child.bake( cascade | prop['arg'],tree_arg)


class CompositNode(Node):
  node_category = 'composites'
  def __init__(self,node_type,arg,childnames,childs):
    super().__init__(node_type,arg)
    self.childnames    = childnames
    self.childs    = childs

  def bake(self,cascade,tree_arg):
    arg  = self.formatArg(tree_arg) | cascade
    prop = super().bake( arg | {'CHILDS':self.childnames})
    for child,childname in zip(self.childs,self.childnames):
      child.bake(cascade | prop['arg'][childname],tree_arg)


class DecoratorNode(Node):
  node_category = 'decorators'
  def __init__(self,node_type,arg,child):
    super().__init__(node_type,arg)
    self.child    = child

  def bake(self,cascade,tree_arg:dict[str,str]):
    arg   = self.formatArg(tree_arg) | cascade
    child = str(int(arg['SELF'])+1)
    prop  = super().bake(arg | {'CHILD':child})
    self.child.bake(cascade | prop['arg'],tree_arg)


class DectorativeTreeNode(Node):
  def __init__(self,node_type,arg,child):
    self.tree      = get(node_type)
    self.arg       = self.formattableArg(arg)
    self.child    = child

  def bake(self,cascade,tree_arg):
    prop = self.tree.bake( cascade , self.formatArg(tree_arg) | {('TREE_CHILD',):self.child,('TREE_ARG',):tree_arg} )


class ActionNode(Node):
  node_category = 'actions'
  def __init__(self,node_type,arg):
    super().__init__(node_type,arg)

  def bake(self,cascade,tree_arg:dict[str,str]):
    arg  = self.formatArg(tree_arg) | cascade
    prop = super().bake(arg)


class TreeChildNode(Node):
  def __init__(self,node_type,arg):
    self.arg       = self.formattableArg(arg)

  def bake(self,cascade,tree_arg):
    if ('TREE_CHILD',) not in tree_arg:
      raise MCBTerror('"TREE_CHILD" node can only be used in dectorative subtree.')
    print(cascade)
    prop = tree_arg[('TREE_CHILD',)].bake( cascade , tree_arg[('TREE_ARG',)] | self.formatArg(tree_arg) )


class SubtreeNode(Node):
  def __init__(self,node_type,arg):
    self.tree      = get(node_type)
    self.arg       = self.formattableArg(arg)

  def bake(self,cascade,tree_arg):
    prop = self.tree.bake( cascade , self.formatArg(tree_arg) )

# ノードごとの固有の文字列を生成
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