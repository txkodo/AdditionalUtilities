import os
from mcpath import McRootPath,McDirPath
from mcfa import MCFA

path = McRootPath(os.path.dirname(os.path.abspath(__file__))).setDirpath('sources',['-']).innerFile('event','mcfunction')
eventfunc = MCFA.open(path)

class BTEvent:
  def __init__(self,name,roots):
    self.roots = roots
    self.name = name

  def bake(self,path:McDirPath):
    rootpath = path.superFolder().subFolder('roots')
    eventfunc.bake({'event':self.name,'ROOTDIR':rootpath.getMcPath(),'ROOTS':self.roots},path)

def genEvents(rootdict:dict[str,set])-> list[BTEvent]:
  eventdict = {}
  for root,events in rootdict.items():
    for event in events:
      if event in eventdict:
        eventdict[event] += [root]
      else:
        eventdict[event]  = [root]
  return [BTEvent(event,roots) for event,roots in eventdict.items()]