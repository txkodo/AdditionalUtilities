import re
class FormattableException(Exception):pass

class Formattable:
  pattern  = re.compile(r'{([\w-]+)}',)
  patternMulti = re.compile(r'{\*([\w-]+)}',)
  def __init__(self,text):
    self.text:str        = text
    self.multi:list[str] = Formattable.patternMulti.findall(text)

  def __str__(self):
    return self.text

  def getMultiLength(self,kwargs):
    return len(kwargs[next(iter(self.multi))])

  def format(self,kwargs):
    # multi引数が存在した場合error
    if self.multi:
      raise FormattableException(f'"{self.text}" returns multiple lines. Use formatMulti method.')
    replaceFunc = Formattable.getReplaceFunc(kwargs)
    replaced = Formattable.pattern.sub(replaceFunc,self.text)
    return replaced

  def formatIndex(self,kwargs,index:int,length:int):

    # multi引数が存在しない場合formatメソッドの結果をreturn
    if not self.multi:
      return self.format(kwargs)

    replaceFunc = Formattable.getReplaceFunc(kwargs)
    replaced = Formattable.pattern.sub(replaceFunc,self.text)

    replaceFunc = Formattable.getReplaceFuncIndex(kwargs,index,length)
    replaced = Formattable.patternMulti.sub(replaceFunc,replaced)
    return replaced

  def formatMulti(self,kwargs):

    # multi引数が存在しない場合formatメソッドの結果をlistに格納しreturn
    if not self.multi:
      return [self.format(kwargs)]

    length = self.getMultiLength(kwargs)
    result = []
    for i in range(length):
      result.append(self.formatIndex(kwargs,i,length))
    return result

  @staticmethod
  def getReplaceFunc(kwargs):
    def replaceFunc(match:re.match):
      argname = match.group(1)

      if argname not in kwargs: # 引数が存在しない場合
        raise FormattableException(f'argment "{argname}" is not defined.')

      replace = kwargs[argname]

      if replace == None: # 引数がNullの場合
        raise FormattableException(f'argment "{argname}" is set to Null.')

      if type(replace) is list: # 引数がリストの場合
        raise FormattableException(f'argment "{argname}:{replace}" is not a str.')

      return replace

    return replaceFunc

  @staticmethod
  def getReplaceFuncIndex(kwargs,index,length):
    def replaceFunc(match:re.match):
      argname = match.group(1)

      if index >= length: # インデックスが引数長より大きい場合
        raise FormattableException(f'index "{index}" is {length} or more.')

      if argname not in kwargs: # 引数が存在しない場合
        raise FormattableException(f'argment "{argname}" is not defined.')

      replace = kwargs[argname]

      if replace == None: # 引数がNullの場合
        raise FormattableException(f'argment "{argname}" is set to Null.')

      if type(replace) is not list: # 引数がリストでない場合
        raise FormattableException(f'argment "{argname}:{replace}" is not a list.')

      if len(replace) != length: # 引数長が与えられた長さと違う場合
        raise FormattableException(f'argment "{argname}:{replace}" length is must be {length}.')

      return replace[index]

    return replaceFunc

class McFunctionError(Exception): pass

class McFunction:
  def __init__(self,name:str):
    self.name   = Formattable(name)
    self.blocks:list[Formattable] = []

  def __str__(self):
    return ''.join( str(block) for block in self.blocks)
  
  def addBlock(self,block:list[str]):
    strblock = '\n'.join(block)
    self.blocks.append(Formattable(strblock))

  def exportContent(self,kwargs):
    export = ''
    for block in self.blocks:
      formattedBlock = block.formatMulti(kwargs)
      export += '\n' + '\n'.join(formattedBlock)
    return export

  def export(self,kwargs):

    # 複数ファンクションとなる場合error
    if self.name.multi:
      raise McFunctionError(f'function "{self.name}" generates multiple function. Use exports method.')
    
    formattedName = self.name.format(kwargs)
    return {formattedName:self.exportContent(kwargs)}

  def exports(self,kwargs) -> dict[str,str]:
    # 複数ファンクションを生成する場合
    if self.name.multi:
      length = self.name.getMultiLength(kwargs)
      exportDict = {}
      for i in range(length):
        export = ''
        for block in self.blocks:
          formattedBlock = block.formatIndex(kwargs,i,length)
          export += '\n' + formattedBlock
        formattedName = self.name.formatIndex(kwargs,i,length)
        exportDict[formattedName] = export
      return exportDict

    # 単一ファンクションを生成する場合
    return self.export(kwargs)

# 階層構造を再帰的に読み取り文字列をFormattable化
def deepFormattable(obj):
  if type(obj) is list:
    return [ deepFormattable(sub) for sub in obj]
  if type(obj) is dict:
    return { deepFormattable(sub) : deepFormattable(obj[sub]) for sub in obj}
  if type(obj) is str:
    return Formattable(obj)
  return obj

# DeepFormatttableで生成した階層構造を再帰的にFormat
# 第一戻り値は複数だった場合、第二戻り値は単数だった場合
def deepFormat(obj,kwargs):

  if type(obj) is list:
    result = []
    result_multi = None
    for sub in obj:
      multi, single = deepFormat(sub,kwargs)
      if multi:
        if not result_multi:
          result_multi = [result]*len(multi)
        else:
          if len(result_multi) != len(multi):
            raise FormattableException(f'found different length unpack argment.{obj},{kwargs}')
        result_multi = [ i + j for i,j in zip(result_multi,multi)]
        result += multi
      else:
        if result_multi:
          result_multi = [ i + single for i in result_multi]
        result += single
    return result_multi,result

  if type(obj) is dict:
    result = {}
    result_multi = None
    for k,v in obj.items():
      k_multi, k_single = deepFormat(k,kwargs)
      v_multi, v_single = deepFormat(v,kwargs)
      if k_multi:
        if not result_multi:
          result_multi = [result]*len(k_multi)
        else:
          if len(result_multi) != len(k_multi):
            raise FormattableException(f'found different length unpack argment.{obj},{kwargs}')
        if v_multi:
          if len(result_multi) != len(v_multi):
            raise FormattableException(f'found different length unpack argment.{obj},{kwargs}')
          result_multi = [ i|{j:k} for i,j,k in zip(result_multi,k_multi,v_multi)]
          result |= dict(zip(k_multi,v_multi))
        else:
          result_multi = [ i|{j:v_single} for i,j in zip(result_multi,k_multi)]
          result |= { i:v_single for i in zip(k_multi)}
      else:
        if v_multi:
          if not result_multi:
            result_multi = [result]*len(v_multi)
          else:
            if len(result_multi) != len(v_multi):
              raise FormattableException(f'found different length unpack argment.{obj},{kwargs}')
          result_multi = [ i|{k_single:j} for i,j in zip(result_multi,v_multi)]
          result[k_single] = v_single
        else:
          if result_multi:
            result_multi = [ i|{k_single:v_single} for i in result_multi]
          result[k_single] = v_single
    return result_multi,result

  if type(obj) is Formattable:
    if obj.multi:
      result = obj.formatMulti(kwargs)
      return result , result
    return None,obj.format(kwargs)

  return None,obj
