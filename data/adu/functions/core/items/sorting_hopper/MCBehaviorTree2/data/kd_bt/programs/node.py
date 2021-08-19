from importlib import import_module
from functools import reduce
from mcfa import MCFA
from mcpath import McRootPath,McDirPath,McFilePath
import os

class Disabled(Exception):pass

class BehaviorTree:
  @staticmethod
  def open(name,json):
    if 'enable' in json and not json['enable']:
      return None
    if json['type'] == 'sub':
      return None
    return {'only':OnlyBehaviorTree,'each':EachBehaviorTree}[json['type']](name,json)

  def __init__(self,name:str,json:dict) -> None:
    self.storage:str
    self.asset:MCFA
    self.name = name
    self.root = json['root']
    self.arg = {}
    json = json[self.root]
    self.tree = genNode(self.root,json)

  def bake(self,path:McDirPath):
    rootpath = path.subFolder(self.name)
    rootpath.makeDirectory()
    self.tree.bake( self.arg|{'DATA':self.storage} ,0,rootpath)
    self.asset.bake(self.arg, rootpath)

  def getEvent(self):
    return self.tree.getEvent()|{'tick'}

SYSPATH = McRootPath(os.path.dirname(os.path.abspath(__file__))).setDirpath('sources',['-'])

class OnlyBehaviorTree(BehaviorTree):
  def __init__(self,name:str,json:dict) -> None:
    super().__init__(name,json)
    self.storage     = json['$']
    self.arg['AS']   = json['as']
    self.arg['DATA'] = self.storage
    self.asset       = MCFA.open(SYSPATH.innerFile('only','mcfunction'))

class EachBehaviorTree(BehaviorTree):
  def __init__(self,name:str,json:dict) -> None:
    super().__init__(name,json)
    self.storage      = json['$']+f'.-[-{json["max"]}]'
    self.arg['AS']    = json['as']
    self.arg['DATA']  = json['$']
    self.arg['MAX']   = json['max']
    self.arg['SCORE'] = json['score']
    self.arg['TAG']   = json['tag']
    self.asset        = MCFA.open(SYSPATH.innerFile('each','mcfunction'))

class SubBehaviorTree(BehaviorTree):
  def __init__(self,name:str,json:dict) -> None:
    super().__init__(name,json)

def getDirPath(typename):
  return McRootPath(os.path.dirname(os.path.abspath(__file__))).setDirpath('sources',[typename])

class Node:

  dirpath:McRootPath
  assets = {}

  @classmethod
  def getAsset(cls,name):
    if name not in cls.assets:
      filepath:McFilePath = cls.dirpath.innerFile(name,'mcfunction')
      if os.path.exists(filepath.getFilePath()):
        cls.assets[name] = MCFA.open(filepath)
    return cls.assets[name]

  def __init__(self,name,json) -> None:
    self.asset:MCFA = self.__class__.getAsset(json['type'])
    self.name = name
    self.arg = json['arg'] if 'arg' in json else {}
    self.prop:dict[str,str]

  def bake(self,arg,path:McDirPath):
    self.prop = self.asset.bake(arg,path)

  def getEvent(self):
    return {self.prop['event'],} if 'event' in self.prop else set()

class Action(Node):
  dirpath = getDirPath('actions')
  assets = {}
  def __init__(self,name:str,json:dict) -> None:
    super().__init__(name,json)

  def bake(self,arg,index:int,path:McDirPath):
    arg = self.arg|arg|{'SELF':str(index)}
    super().bake(arg,path)

class Composite(Node):
  dirpath = getDirPath('composites')
  assets = {}
  def __init__(self,name:str,json:dict) -> None:
    super().__init__(name,json)
    self.childs = { cname:genNode(cname,cjson) for cname,cjson in json['childs'].items()}

  def bake(self,arg,index:int,path:McDirPath):
    sarg = self.arg|arg|{'SELF':str(index),'CHILDS':list(self.childs.keys())}
    super().bake(sarg,path)

    for (cname, child), carg in zip(self.childs.items(),self.prop['arg']):
      cpath = path.subFolder(cname)
      cpath.makeDirectory()
      child.bake(arg|carg,0,cpath)

  def getEvent(self):
    return reduce(lambda x,y:x|y,(child.getEvent() for child in self.childs.values()),set()) | super().getEvent()

class Decorator(Node):
  dirpath = getDirPath('decorators')
  assets = {}
  def __init__(self,name:str,json:dict) -> None:
    ddata = json['decorators'].pop(0)
    super().__init__(ddata['type'],ddata)
    self.child = genNode(name,json)

  def bake(self,arg,index:int,path:McDirPath):
    sarg = self.arg|arg|{'SELF':str(index),'CHILD':index+1}
    super().bake(sarg,path)
    self.child.bake(arg|self.prop['arg'],index+1,path)

  def getEvent(self):
    return self.child.getEvent() | super().getEvent()

def getSubTree(json:dict) -> SubBehaviorTree:
    dirpath  = os.path.dirname(os.path.abspath(__file__))
    rootpath = McRootPath(dirpath).setDirpath('roots',[])
    newjson = rootpath.innerFile(json['arg']['name'],'json').readJson()
    return SubBehaviorTree(json['arg']['name'],newjson).tree

def genNode(name:str,json:dict):
  if 'decorators' in json and len(json['decorators']) > 0 :
    return Decorator(name,json)
  elif 'childs' in json:
    return Composite(name,json)
  elif json['type'] == 'SUBTREE':
    return getSubTree(json)
  else:
    return Action(name,json)