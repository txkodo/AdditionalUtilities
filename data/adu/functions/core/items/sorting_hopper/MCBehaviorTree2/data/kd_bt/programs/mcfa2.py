import re
from pathlib import Path
from formattable import Formattable,McFunction,FormattableException,deepFormat,deepFormattable
import json
import consts

# class MCFA:
  #   mcfas = []
  #   @classmethod
  #   def newMCFA(cls,mcfa):
  #     cls.mcfas += [mcfa]

  #   @classmethod
  #   def bakeInit(cls,dirpath):
  #     content = '\n'.join( i.exportInit() for i in cls.mcfas if i.exportInit() )
  #     dirpath.innerFile('__init__','mcfunction').write(content)

  #   @staticmethod
  #   def open(path:McFilePath):
  #     with open(path.getFilePath()) as f:
  #       lines = f.readlines()
  #     return MCFAdecoder(path,lines).toMCFA(path)

  #   def __init__(self,arg:dict,prop:dict,funcs:list[McFunction],path:McFilePath,initonce:McFunction=None,initeach:McFunction=None):
  #     self.arg = arg
  #     self.prop = prop
  #     self.funcs = funcs
  #     self.path = path
  #     self.init = initonce.exportLine({}) if initonce else ''
  #     self.initeach = initeach
  #     self.baked = False
  #     MCFA.newMCFA(self)

  #   def exportInit(self):
  #     if self.baked and self.init:
  #       return self.init
  #     else:
  #       return None

  #   def export(self,arg):
  #     return reduce(lambda x,y: x|y,map(lambda x: x.exportDict(arg),self.funcs))

  #   def bake(self,arg:dict,dirpath:McDirPath) -> dict[str,str]:
  #     self.baked = True
  #     self.arg |= arg | {'consts.DIR':dirpath.getMcPath()}
  #     self.formatArgs()

  #     if not dirpath:
  #       dirpath = self.path.fileFolder()
  #     if self.initeach:
  #       self.init += '\n' + self.initeach.exportLine(arg)
  #     for name,content in self.export(arg).items():
  #       dirpath.innerFile(name,'mcfunction').write(content)
  #     return self.formatProps()

  #   def formatArgs(self):
  #     complete = False
  #     while not complete:
  #       complete = True
  #       for name, arg in self.arg.items():
  #         if type(arg) is Formattable:
  #           try:
  #             self.arg[name] = arg.tojson(self.arg)
  #           except FormatError:
  #             complete = False

  #   def formatProps(self):
  #     return { k:v.tojson(self.arg) for k,v in self.prop.items() }

loaded = {}

def loadMCFA(name):
  if name in loaded:
    return loaded[name]
  new = MCFAdecoder( consts.SOURCE_ROOT_PATH / (name + '.mcfunction') ).toMCFA()
  loaded[name] = new
  return new

class MCFAerror(Exception):pass

class MCFA:

  initfuncs  = ''
  resetfuncs = ''

  @classmethod
  def genInitAndReset(cls):
    with (consts.FUNCTION_ROOT_PATH /  'init.mcfunction').open(mode='w') as f:
      f.write(cls.initfuncs)
    with (consts.FUNCTION_ROOT_PATH / 'reset.mcfunction').open(mode='w') as f:
      f.write(cls.resetfuncs)

  def __init__(self,path,args,props,init_once,init_each,reset_once,reset_each,funcs):
    self.path  = path
    self.args  = args
    self.props = props
    self.init_once:McFunction  = init_once
    self.init_each:McFunction  = init_each
    self.reset_once:McFunction = reset_once
    self.reset_each:McFunction = reset_each
    self.funcs = funcs
    self.baked = False

  def bake(self,path:Path,kwargs):

    args  = self.formatarg( kwargs)
    props = self.formatprop(  args)

    if not self.baked and self.init_once:
      MCFA.initfuncs  += (self.init_once.exportContent(self.args))

    if self.init_each:
      MCFA.initfuncs  += (self.init_each.exportContent(args))

    if not self.baked and self.reset_once:
      MCFA.resetfuncs += (self.reset_once.exportContent(self.args))

    if self.reset_each:
      MCFA.resetfuncs += (self.reset_each.exportContent(args))

    funcs = {}
    for func in self.funcs:
      try:
        funcs |= func.exports(args)      
      except FormattableException as e:
        raise FormattableException(*e.args,f'at {func.name} in {self.path}')

    for name,func in funcs.items():
      funcpath = path / (name+'.mcfunction')
      with funcpath.open(mode='w') as f:
        f.write(func)

    return props

  def formatarg(self,kwargs):
    newkwargs = {}
    for k,v in self.args.items():
      if k in kwargs:
        newkwargs[k] = kwargs[k]
      elif v != None:
        try:
          newkwargs[k] = deepFormat(v,kwargs)[1]
        except FormattableException as e:
          raise FormattableException(*e.args,f'in {self.path}')
      else:
        raise MCFAerror(f'MCFA argument "{k}" is not set.\n in {self.path}')
    return newkwargs

  def formatprop(self,kwargs):
    newkwargs = {}
    try:
      newkwargs = deepFormat(self.props,kwargs)[1]
    except FormattableException as e:
      raise MCFAerror(f'in {self.path}') from e
    return newkwargs

class McfaDecodeError(Exception):pass

class MCFAdecoder:

  isBlank        = lambda x: not bool(x.strip())
  isComment      = lambda x: x.startswith('##')
  isMCFAdef      = re.compile(r'#\s*MCFA\s*#\s*',     re.A).fullmatch
  getArgDef      = re.compile(r'#([\w-]+)\s*(?:=(.+))?').fullmatch
  getPropDef     = re.compile(r'#%([\w-]+)\s*=(.+)'    ).fullmatch
  isFuncLikeDef  = re.compile(r'#\s*[\w{}\*\.-]+\s*#\s*',re.A  ).fullmatch
  isInitOnceDef  = re.compile(r'#\s*INIT_ONCE\s*#\s*',re.A  ).fullmatch
  isInitEachDef  = re.compile(r'#\s*INIT_EACH\s*#\s*',re.A  ).fullmatch
  isResetOnceDef = re.compile(r'#\s*RESET_ONCE\s*#\s*',re.A  ).fullmatch
  isResetEachDef = re.compile(r'#\s*RESET_EACH\s*#\s*',re.A  ).fullmatch
  getFuncDef     = re.compile(r'#\s*((?:\.?(?:{\*?[\w_-]+}|[a-z0-9_-]+))+)\.?\s*#',re.A).fullmatch

  def toMCFA(self):
    return MCFA(self.path,self.args,self.props,self.initOnce,self.initEach,self.resetOnce,self.resetEach,self.funcs)

  def __init__(self,path:Path):
    self.path = path
    self.args = {}
    self.props = {}
    self.funcs = []
    self.initOnce = None
    self.initEach = None
    self.resetOnce = None
    self.resetEach = None

    # ファイルをIteratorとして使用
    self.lineiter = path.open()
    self.sequence()

  def sequence(self):
    nextline = None

    # 読み込み開始

    while not nextline:
      nextline = self.mcfa(next(self.lineiter).strip())

    # MCFAコメント後
  
    nextline = None
    while not nextline:
      nextline = self.beforeFunc(next(self.lineiter).strip())

    # args,props読み込み終了

    # consts.TNIT_ONCEが存在した場合読み込み
    if MCFAdecoder.isInitOnceDef(nextline):
      nextline,self.initOnce = self.getFunc('consts.INIT_ONCE')

    # consts.TNIT_EACHが存在した場合読み込み
    if MCFAdecoder.isInitEachDef(nextline): 
      nextline,self.initEach = self.getFunc('consts.INIT_EACH')

    # consts.RESET_ONCEが存在した場合読み込み
    if MCFAdecoder.isResetOnceDef(nextline):
      nextline,self.resetOnce = self.getFunc('consts.RESET_ONCE')

    # consts.RESET_EACHが存在した場合読み込み
    if MCFAdecoder.isResetEachDef(nextline):
      nextline,self.resetEach = self.getFunc('consts.RESET_EACH')

    # functionを存在するだけ読み込み
    while nextline:
      nextline = self.function(nextline)

  def mcfa(self,line:str):
    if MCFAdecoder.isBlank(line) or MCFAdecoder.isComment(line):
      return None
    if MCFAdecoder.isMCFAdef(line):
      return line
    raise McfaDecodeError(f'MCFA must starts with "#MCFA#" not "{line}".\nin {self.path}.')

  def beforeFunc(self,line:str):

    if MCFAdecoder.isBlank(line) or MCFAdecoder.isComment(line):
      return None
    if MCFAdecoder.isMCFAdef(line):
      raise McfaDecodeError(f'do not use "#MCFA#" twice in one file.\nin {self.path}.')

    # add argument
    arg = MCFAdecoder.getArgDef(line)
    if arg:
      name,value = arg.groups()
      if type(value) is str:
        try:
          value = json.loads(f'{{"value":{value}}}')['value']
        except json.JSONDecodeError:
          raise McfaDecodeError(f'argument embedding value must be json-like not "{value}".\nin {self.path}.')
      self.args[name] = deepFormattable(value)
      return None

    # add property
    prop = MCFAdecoder.getPropDef(line)
    if prop:
      name,value = prop.groups()
      try:
        value = json.loads(f'{{"value":{value}}}')['value']
      except json.JSONDecodeError:
        raise McfaDecodeError(f'property value must be json-like not "{value}".\nin {self.path}.')
      self.props[name] = deepFormattable(value)
      return None

    return line

  def getFunc(self,name):
    func     = McFunction(name)
    block    = []
    nextline = None

    for line in self.lineiter:
      line = line.strip()
      # コメントの場合無視
      if MCFAdecoder.isComment(line):
        continue
      # 空行の場合次のブロックに
      if MCFAdecoder.isBlank(line):
        func.addBlock(block)
        block = []
        continue
      # 関数定義の場合終了
      if MCFAdecoder.isFuncLikeDef(line):
        func.addBlock(block)
        nextline = line
        break
      # それ以外の場合ブロックに追加
      block.append(line)
    # 最終行に到達した場合ブロックに追加
    else:
      func.addBlock(block)

    return nextline,func

  def function(self,line):
    name = MCFAdecoder.getFuncDef(line)
    if not name:
      raise McfaDecodeError(f'func definition "{line}" is invalid.\nin {self.path}.')
    name = name.group(1)
    line,func = self.getFunc(name)
    self.funcs.append(func)
    return line

# c = loadMCFA(Path(r'consts.C:\Users\shiyu\OneDrive\default\saves\consts.MAZE\datapacks\MCBehaviorTree2\data\kd_bt\sources\actions\test.mcfunction'))

# tpath = Path(r'consts.C:\Users\shiyu\OneDrive\default\saves\consts.MAZE\datapacks\MCBehaviorTree\data\kd_bt\test')
# k = {'consts.SELF':'SelF','consts.DATA':'DatA','consts.DIR':'DiR','a':['0','1','2']}
# r = c.bake(tpath,k)
# print(r)
