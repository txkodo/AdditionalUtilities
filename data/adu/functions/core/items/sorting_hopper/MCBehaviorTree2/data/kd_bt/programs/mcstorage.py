class McStorage:
  def __init__(self,storage):
    self.storage:str
    self.nbt:str
    if type(storage) is McStorage:
      self.storage = storage.storage
      self.nbt = storage.nbt
    else:
      split = storage.split()
      self.storage = split[0]
      self.nbt = split[1] if len(split) == 2 else ''

  def __str__(self):
    if self.nbt:
      return self.storage + ' ' + self.nbt
    else:
      return self.storage + ' {}'

  def append(self,nbt):
    result = McStorage(self)
    if result.nbt:
      result.nbt += '.'+ nbt
    else:
      result.nbt = nbt
    return result