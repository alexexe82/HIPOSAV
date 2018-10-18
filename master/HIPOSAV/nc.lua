--[[ Midday Commander Color Ver. 1.4 ]]--
--[[ Created by Dimus & Neo & Totoro ]]--
--[[         (c)  No rights reserved ]]--

local unicode = require('unicode')
local fs = require('filesystem')
local term = require('term')
local shell = require('shell')
local event = require('event')
local com = require('component')
local gpu = com.gpu

local colors = {
  white = 0xFFFFFF,
  black = 0x000000,
  blue  = 0x009acd,
  green = 0x0b5e56,
  cyan  = 0xeeb422,
  red   = 0xee3b3b
}
local keys = {
  enter = 28,
  left = 203,
  right = 205,
  up = 200,
  down = 208,
  tab = 15,
  backspace = 14,
  delete = 211,
  home = 199,
  leftShift = 42,
  rightShift = 54,
  leftCtrl = 29,
  rightCtrl = 157,
  leftAlt = 56,
  rightAlt = 184,
  f1 = 59,
  f4 = 62,
  f5 = 63,
  f6 = 64,
  f7 = 65,
  f8 = 66,
  f10 = 68
}
keys['end'] = 207

local function SetColor(cl)
  gpu.setForeground(cl[1])
  gpu.setBackground(cl[2])
end
local NormalCl, PanelCl, SelectCl, WindowCl, AlarmWinCl
NormalCl={colors.white,colors.black}
if gpu.getDepth() > 1 then
  PanelCl={colors.white,colors.blue}
  SelectCl={colors.black,colors.cyan}
  WindowCl={colors.white,colors.green}
  AlarmWinCl={colors.white,colors.red}
else
  PanelCl=NormalCl
  SelectCl={colors.black,colors.white}
  WindowCl=NormalCl
  AlarmWinCl=NormalCl
end
local wScr, hScr = gpu.getResolution()
local wPanA = math.ceil(wScr / 2)
if wPanA<16 then wPanA=16 end
local wPanP=wScr-wPanA+1

local Menu
if wScr<27 then
  Menu={'','','','Ed','Cp','Mv','Dr','Dl','','Ex'}
elseif wScr<51 then
  Menu={'Hlp','','','Edt','Cpy','Mov','Dir','Del','','Ext'}
else
  Menu={'Help','','','Edit','Copy','Move','Dir','Del','','Exit'}
end
local help={"Up,Down - Navigation", "Tab - Change panel",
'Enter - Change dir/run program','Ctrl+Enter - Insert into command line',
'F1 - This help','F4 - Edit file','Shift+F4 - Create new file',
'F5 - Copy file/dir','F6 - Move file/dir','F7 - Create directory',
'Alt+F7 - Find file/dir','F8 - Delete file/dir','F10 - Exit from MC'}
local xMenu=-1
for i=1,#Menu do
  if #Menu[i]>0 then xMenu=xMenu+#tostring(i)+#Menu[i]+2 end
end
xMenu=math.ceil((wScr-xMenu) / 2)

local panel ={}
local Active

local cmdstr=''
local curpos=0
local function ShowCmd()
  SetColor(NormalCl)
  term.setCursor(1, hScr-1)
  term.clearLine()
  term.write(shell.getWorkingDirectory()..'> '..cmdstr)
  term.setCursor(term.getCursor()-curpos, hScr-1) 
end

function panel:ShowFirst()
  local p=self.Path..'/'
  if #p> self.wPan-6 then p='..'..p:sub(#p-self.wPan+7) end
  p=' '..p..' '
  term.setCursor(self.X, 1) 
  term.write('+'..string.rep('-',self.wPan-2)..'+')
  term.setCursor(self.X+(self.wPan-#p)/2,1) 
  if self==Active then
    SetColor(SelectCl)
    term.write(p)
    SetColor(PanelCl)
  else
    term.write(p)
  end
end

function panel:ShowLine(Line)
  term.setCursor(self.X, Line-self.Shift+2)
  if self.tFiles[Line]~=nil then
    local Name=self.tFiles[Line]
    if self.tSize[Line]=='DIR' then Name='/'..Name end
    if #Name>self.wPan-4 then Name=Name:sub(1,self.wPan-6)..'..' end
    Name=' '..Name..string.rep(' ',self.wPan-#Name-4)..' '
    term.write('|')
    if self==Active and Line==self.CurLine then
      SetColor(SelectCl)
      term.write(Name)
      SetColor(PanelCl)
    else
      term.write(Name)
    end
    term.write('|')
  else 
    term.write('|'..string.rep(' ',self.wPan-2)..'|')
  end
end

function panel:ShowLines()
  for i=self.Shift, self.Shift+hScr-5 do
    self:ShowLine(i)
  end
end

function panel:ShowLast()
  term.setCursor(self.X, hScr-2) 
  term.write('+'..string.rep('-',self.wPan-2)..'+')
  term.setCursor(self.X+2, hScr-2) 
  term.write(self.tSize[self.CurLine])
  if self.tSize[self.CurLine]~='DIR' then term.write(' b') end
end

function panel:Show()
  if self.CurLine>#self.tFiles then self.CurLine=#self.tFiles end  
  SetColor(PanelCl)
  self:ShowFirst()
  self:ShowLines()
  self:ShowLast()
end

function panel:GetFiles()
  local Files={}
  for name in fs.list(self.Path) do
    table.insert(Files, name)
  end
  if self.Path=='' then
    self.tFiles={}
    self.tSize={}
  else
    self.tFiles={'..'}
    self.tSize={'DIR'}
  end
  for n,Item in pairs(Files) do
    if string.sub(Item, -1) == '/' then
      table.insert(self.tFiles,Item)
      table.insert(self.tSize,'DIR')
    end
  end
  for n,Item in pairs(Files) do
    if string.sub(Item, -1) ~= '/' then
      local sPath=fs.concat(self.Path,Item)
      table.insert(self.tFiles,Item)
      table.insert(self.tSize,fs.size(sPath))
    end
  end
  self:Show()
end

function panel:SetPos(FileName)
  self.Path,FileName=FileName:match('(.-)/?([^/]+)$')
  shell.setWorkingDirectory(self.Path)
  self.CurLine=1
  self.Shift=1
  self:GetFiles()
  for i=1,#self.tFiles do
    if self.tFiles[i]==FileName then
      self.CurLine=i
      break
    end
  end
  if Active.CurLine>hScr-4 then
    Active.Shift=Active.CurLine-hScr+6
  end
end

function panel:new(x,path,wP)
  local obj={X = x, Path =path, tFiles={}, tSize={}, CurLine=1, Shift=1, wPan=wP}
  setmetatable(obj,self)
  self.__index=self
  return obj
end

local Left =panel:new(1,'',wPanP)
local Rght =panel:new(Left.wPan,shell.getWorkingDirectory(),wPanA)

Active =Rght

local Fpanel ={}
setmetatable(Fpanel,panel)

function Fpanel:new(x,path,wP)
  local obj=panel:new(x,path,wP)
  setmetatable(obj,self)
  self.__index=self
  return obj
end

local function FindFile(FileName,Path)
  local Result={}
  local SubDir={}
  for name in fs.list(Path) do
    if string.match(name, FileName) then
      table.insert(Result, fs.concat(Path,name))
    end
    if string.sub(name, -1) == '/' then
      table.insert(SubDir, fs.concat(Path,name))
    end
  end
  for i=1,#SubDir do
    local Files = FindFile(FileName,SubDir[i])
    for j=1,#Files do table.insert(Result,Files[j]) end
  end
  return Result
end

function Fpanel:GetFiles()
  local code={{'%.','%%.'},{'*','.-'},{'?','.'}}
  local Templ=self.Path
  for i=1,#code do Templ=Templ:gsub(code[i][1],code[i][2]) end
  self.tFiles=FindFile('^'..Templ..'$','')
  table.insert(self.tFiles,1,'..')
  self.tSize={'DIR'}
  for i=2,#self.tFiles do
    if fs.isDirectory(self.tFiles[i]) then
      self.tSize[i]='DIR'
    else
      self.tSize[i]=fs.size(self.tFiles[i])
    end
  end
  self:Show()
end

function Fpanel:ShowFirst()
  local p='Find:'..self.Path
  if #p> self.wPan-6 then p='..'..p:sub(#p-self.wPan+7) end
  p=' '..p..' '
  term.setCursor(self.X, 1) 
  term.write('+'..string.rep('-',self.wPan-2)..'+')
  term.setCursor(self.X+(self.wPan-#p)/2,1) 
  SetColor(SelectCl)
  term.write(p)
  SetColor(PanelCl)
end

local Find =Fpanel:new(1,'',wScr)

local function ShowPanels()
  SetColor(NormalCl)
  term.clear()
  if Active==Find then
    Find:GetFiles()
  else
    Left:GetFiles()
    Rght:GetFiles()
  end
  term.setCursor(xMenu, hScr)
  for i=1,#Menu do
    if #Menu[i]>0 then
    SetColor(NormalCl)
    term.write(' F'..i)
    SetColor(SelectCl)
    term.write(Menu[i])
    end
  end
  term.setCursorBlink(true)
end

local function Dialog(cl,Lines,Str,But)
  SetColor(cl)
  local H=#Lines+3
  local CurBut=1
  if Str then H=H+1 CurBut=0 end
  if not But then But={'Ok'} end
  local function Buttons()
    local Butt=''
    for i=1,#But do
      if i==CurBut then
        Butt=Butt..'['..But[i]..']'
      else
        Butt=Butt..' '..But[i]..' '
      end
    end
    return Butt
  end
  local W=#Buttons()
  for i=1,#Lines do
    if #Lines[i]>W then W=#Lines[i] end
  end
  if Str and (#Str>W) then W=#Str end
  W=W+4
  local x= math.ceil((wScr-W)/2)
  local y= math.ceil((hScr-H)/2)
  term.setCursor(x, y) 
  term.write(string.rep('=',W))
  for i=1,#Lines+2 do
    term.setCursor(x, y+i) 
    term.write('H'..string.rep(' ',W-2)..'H')
  end
  term.setCursor(x, y+H-1) 
  term.write(string.rep('=',W))
  for i=1,#Lines do
    term.setCursor(x+(W-#Lines[i])/2, y+i) 
    term.write(Lines[i])
  end

  while true do
    term.setCursorBlink(CurBut==0) 
    term.setCursor(x+(W-#Buttons())/2, y+H-2) 
    term.write(Buttons())
    if CurBut==0 then
      term.setCursor(x+2, y+H-3) 
      local S=Str
      if #S>W-4 then S='..'..S:sub(#S-W+7) end
      term.write(S)
    end

    local eventname, _, char, code = event.pull('key_down')
    if eventname == 'key_down' then
      if code == keys.enter then
        if CurBut==0 then CurBut=1 end
        return But[CurBut],Str
      elseif code == keys.left and CurBut~=0 then
        if CurBut>1 then CurBut=CurBut-1 end
      elseif code == keys.right and CurBut~=0 then
        if CurBut<#But then CurBut=CurBut+1 end
      elseif code == keys.tab then
        if CurBut<#But then CurBut=CurBut+1
        else CurBut=Str and 0 or 1
        end
      elseif code == keys.backspace and CurBut==0 and #Str>0 then
        term.setCursor(x, y+H-3) 
        term.write('H'..string.rep(' ',W-2)..'H')
        Str=Str:sub(1,#Str-1)
      elseif char > 0 and CurBut == 0 then
        Str = Str..unicode.char(char)
      end
    end
  end
end

local cmd, Alt, Ok, Name

local function call(...)
  local r,e=pcall(...)
  if not r then Dialog(AlarmWinCl,{e}) end
  return r
end

local function CopyMove(action,func)
  if Active==Find then return end
  Name = ((Active==Rght) and Left or Rght).Path..'/'..cmd
  cmd=Active.Path..'/'..cmd
  Ok,Name=Dialog(WindowCl,{action,cmd,'to:'},Name,{'<Ok>','Cancel'})
  if Ok=='<Ok>' then
    if cmd==Name then
      Dialog(AlarmWinCl,{'Cannot copy/move file to itself!'})
    else
      if fs.exists(Name) then
        if Dialog(AlarmWinCl,{'File already exists!',Name,'Overwrite it?'},nil,{'Yes','No'})=='Yes' then
          if call(fs.remove,Name) then call(func,cmd, Name) end
        end
      else
        call(func,cmd, Name)
      end
    end
  end
  ShowPanels()
end

local work=true
local eventKey={}
eventKey[keys.up]=function()
  if Active.CurLine>1 then
    local Line
    Line,Active.CurLine=Active.CurLine,Active.CurLine-1
    if Active.CurLine<Active.Shift then
      Active.Shift=Active.CurLine
      Active:ShowLines()
    else
      Active:ShowLine(Active.CurLine)
      Active:ShowLine(Line)
    end
    Active:ShowLast()
  else
    Active.CurLine = #Active.tFiles
    Active.Shift=Active.CurLine-hScr+5
    if Active.Shift < 1 then Active.Shift = 1 end
    Active:ShowLines()
  end
end

eventKey[keys.down]=function()
  if Active.CurLine<#Active.tFiles then
    local Line
    Line,Active.CurLine=Active.CurLine,Active.CurLine+1
    if Active.CurLine>Active.Shift+hScr-5 then
      Active.Shift=Active.CurLine-hScr+5
      Active:ShowLines()
    else
      Active:ShowLine(Active.CurLine)
      Active:ShowLine(Line)
    end
    Active:ShowLast()
  else
    Active.CurLine = 1
    Active.Shift=Active.CurLine
    Active:ShowLines()
  end
end

eventKey[keys.left]=function()
  if curpos<#cmdstr then curpos=curpos+1 end
end

eventKey[keys.right]=function()
  if curpos>0 then curpos=curpos-1 end
end

eventKey[keys.tab]=function()
  if Active==Find then return end
  if Active==Left then
    Active=Rght
    Rght.wPan=wPanA
    Left.wPan=wPanP
  else
    Active=Left
    Rght.wPan=wPanP
    Left.wPan=wPanA
  end
  Rght.X=Left.wPan
  shell.setWorkingDirectory(Active.Path)
  ShowPanels()
end

eventKey[keys.enter]=function()
  local function exec(cmd)
    SetColor(NormalCl)
    term.clear()
    term.setCursor(1,1) 
    shell.execute(cmd)
    os.sleep(3)
    ShowPanels()
  end
  curpos=0
  if Alt=='C' then
    cmdstr=cmdstr..cmd..' '
  else
    if cmdstr~='' then
      exec(cmdstr)
      cmdstr=''
      return
    end
    if Active==Find then
      Active=Find.Last
      if cmd~='..' then Active:SetPos(cmd) end
      ShowPanels()
      return
    end
    if Active.tSize[Active.CurLine]=='DIR' then
      if cmd=='..' then  Active:SetPos(Active.Path)
      else  Active:SetPos(shell.resolve(cmd)..'/..')  end
      Active:Show()
    else
      exec(cmd)
    end
  end
end

eventKey[keys.backspace]=function()
  if cmdstr~='' then
    if curpos==0 then cmdstr=cmdstr:sub(1,-2)
    else cmdstr=cmdstr:sub(1,-2-curpos)..cmdstr:sub(-curpos)
    end
  end
end

eventKey[keys.delete]=function()
  if cmdstr~='' then
    if curpos>0 then
      curpos=curpos-1
      if curpos==0 then
        cmdstr=cmdstr:sub(1,-2)
      else
        cmdstr=cmdstr:sub(1,-2-curpos)..cmdstr:sub(-curpos)
      end
    end
  end
end

eventKey[keys['end']]=function() curpos=0 end

eventKey[keys.home]=function() curpos=#cmdstr end

function AltOff() Alt='' end

eventKey[keys.leftShift]=function()
  Alt='S'
  event.timer(0.5, AltOff)
end
eventKey[keys.rightShift]=eventKey[keys.leftShift]

eventKey[keys.leftCtrl]=function()
  Alt='C'
  event.timer(0.5, AltOff)
end
eventKey[keys.rightCtrl]=eventKey[keys.leftCtrl]

eventKey[keys.leftAlt]=function()
  Alt='A'
  event.timer(0.5, AltOff)
end
eventKey[keys.rightAlt]=eventKey[keys.leftAlt]

eventKey[keys.f1]=function()
  if Active==Find then return end
  Dialog(SelectCl,help)
  ShowPanels()
end

eventKey[keys.f4]=function()
  if Alt=='S' then
    Alt=''
    Ok,Name=Dialog(WindowCl,{'File name:'},'',{'<Ok>','Cancel'})
    if Ok=='<Ok>' then
      SetColor(NormalCl)
      shell.execute('edit '..Name)
    end
  else
    if Active.tSize[Active.CurLine]=='DIR' then
      Dialog(AlarmWinCl,{'Error!', cmd, 'is not a file'})
    else
      SetColor(NormalCl)
      shell.execute('edit '..cmd)
    end
  end
  ShowPanels()
end

eventKey[keys.f5]=function()
  CopyMove('Copy file:',fs.copy)
end

eventKey[keys.f6]=function()
  CopyMove('Move file:',fs.rename)
end

eventKey[keys.f7]=function()
  if Alt=='A' then
    Alt=''
    Ok,Name=Dialog(WindowCl,{'Find file/dir:','Use ? and * for any char(s)'},'',{'<Ok>','Cancel'})
    if Ok=='<Ok>' then
      Find.Path=Name
      Find.CurLine=1
      Find.Shift=1
      if Active~=Find then
        Find.Last=Active
        Active=Find
      end
    end
  else
    if Active==Find then return end
    Ok,Name=Dialog(WindowCl,{'Directory name:'},'',{'<Ok>','Cancel'})
    if Ok=='<Ok>' then
      if Name=='..' or fs.exists(shell.resolve(Name)) then
        ShowPanels()
        Dialog(AlarmWinCl,{' File exists '})
      else
        fs.makeDirectory(shell.resolve(Name))
      end
    end
  end
  ShowPanels()
end

eventKey[keys.f8]=function()
  if Active==Find then return end
  if Dialog(AlarmWinCl,{'Do you want to delete', cmd..'?'}, nil, {'Yes','No'})=='Yes' then
    if call(fs.remove,shell.resolve(cmd)) then
--      if Active.CurLine==#Active.tFiles then Active.CurLine=Active.CurLine-1 end
    end
  end
  ShowPanels()
end

eventKey[keys.f10]=function()
  work=false
end

ShowPanels()
ShowCmd()
while work do
  local eventname, _, char, code = event.pull()
  cmd=Active.tFiles[Active.CurLine]
  if eventname =='key_down' then
    if eventKey[code] ~= nil then
      SetColor(PanelCl)
      eventKey[code]()
      ShowCmd()
    elseif char > 0 then
      if curpos==0 then cmdstr=cmdstr..unicode.char(char)
      else cmdstr=cmdstr:sub(1,-1-curpos)..unicode.char(char)..cmdstr:sub(-curpos)
      end
      ShowCmd()
    end
  end
end
SetColor(NormalCl)
term.setCursor(1, hScr)
term.clear()
print('Thank you for using Midday Commander!')