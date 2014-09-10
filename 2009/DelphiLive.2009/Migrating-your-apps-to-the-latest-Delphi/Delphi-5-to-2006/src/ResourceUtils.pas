{$i AlwaysInclude.inc}

unit ResourceUtils;

{
Some code borrowed from Vladimir Gaitanoff Delphi VCL Library,
General-purpose utility routines
vgUtils.pas on http://www.koders.com
}

interface

uses
  Classes;

{ Macro for loading strings from resources }

{ --- Resourcestring }
procedure StoreResString(P: PResStringRec);
{ Saves resourcestring information }

procedure RestoreResString(P: PResStringRec);
{ Restores resourcestring information }

procedure CopyResString(Source, Dest: PResStringRec; Store: Boolean);
{ Owerwrites resourcestring information to make Dest resourcesting   }
{ the same as Source                                                 }
{ Note that if Source and Dest are in different packages you should  }
{ always restore resourcestring information before unloading package }
{ that contains Source                                               }

function FindInteger(Value: Integer; const Buff; Count: Integer): Integer;
{ Searches for Value in the Buff array. Returns index of Value or -1 if not found }

procedure FreeObject(var Obj);
{ Frees Obj and initialize it to zero }

function ListAdd(var List: TList; Item: Pointer): Pointer;
{ Adds Item to list List. If List is nil than calls TList constructor }

function ListDelete(var List: TList; Index: Integer): Pointer;
{ Deletes from List. If List is empty than destroys List }

procedure ListDestroy(var List: TList);
{ Destroys List and set it to nil }

procedure ListError(Index: Integer);
{ raises EListError exception }

function ListIndexOf(List: TList; Item: Pointer): Integer;
{ Returns index of Item in List }

function ListItem(List: TList; Index: Integer): Pointer;
{ Returns item of List raises exception if List = nil }

function ListRemove(var List: TList; Item: Pointer): Pointer;
{ Removes Item from List. If List is empty than destroys List }

implementation

uses
  Windows, SysUtils;
  
function FindInteger(Value: Integer; const Buff; Count: Integer): Integer; assembler;
asm
        XCHG    EDI,EDX
        PUSH    ECX
        REPNE   SCASD
        MOV     EDI,EDX
        POP     EAX
        JE      @@1
        XOR     EAX,EAX
@@1:    SUB     EAX,ECX
        DEC     EAX
        MOV     EDI,EDX
end;

procedure FreeObject(var Obj); assembler;
asm
  MOV     ECX, [EAX]
  TEST    ECX, ECX
  JE      @@exit
  PUSH    EAX
  MOV     EAX, ECX
  MOV     ECX, [EAX]
  MOV     DL,1
  CALL    dword ptr [ECX - 4] { vtDestroy }
  POP     EAX
  XOR     ECX, ECX
  MOV     [EAX], ECX
@@exit:
end;

function ListAdd(var List: TList; Item: Pointer): Pointer;
begin
  if List = nil then
    List := TList.Create;
  List.Add(Item);
  Result := Item;
end;

function ListDelete(var List: TList; Index: Integer): Pointer;
begin
  Result := ListItem(List, Index);
  List.Delete(Index);
  if List.Count = 0 then
    ListDestroy(List);
end;

procedure ListDestroy(var List: TList);
asm
  JMP     FreeObject
end;

procedure ListError(Index: Integer);
begin
  raise EListError.Create(IntToStr(Index));
end;

function ListIndexOf(List: TList; Item: Pointer): Integer;
begin
  if Assigned(List) then
    with List do
      Result := FindInteger(Integer(Item), List^, Count)
  else
    Result := -1;
end;

function ListItem(List: TList; Index: Integer): Pointer;
begin
  if Assigned(List) then
    Result := List[Index]
  else
  begin
    Result := nil;
    ListError(Index);
  end;
end;

function ListRemove(var List: TList; Item: Pointer): Pointer;
var
  I: Integer;
begin
  I := ListIndexOf(List, Item);
  if I >= 0 then
    Result := ListDelete(List, I)
  else
    Result := nil;
end;

type
  PStoredResStringData = ^TStoredResStringData;
  TStoredResStringData = record
    Addr: Pointer;
    Data: TResStringRec;
  end;

var
  StoredResStrings: TList = nil;

function FindStoredResStringData(P: PResStringRec): PStoredResStringData;
var
  I: Integer;
begin
  if Assigned(StoredResStrings) then
  begin
    for I := 0 to StoredResStrings.Count - 1 do
    begin
      Result := StoredResStrings[I];
      if Result^.Addr = P then
        Exit;
    end;
  end;
  Result := nil;
end;

procedure StoreResString(P: PResStringRec);
var
  Tmp: PStoredResStringData;
begin
  if not Assigned(FindStoredResStringData(P)) then
  begin
    GetMem(Tmp, SizeOf(TStoredResStringData));
    try
      Tmp^.Addr := P;
      Move(P^, Tmp^.Data, SizeOf(TResStringRec));
    except
      FreeMem(Tmp);
      raise;
    end;
    ListAdd(StoredResStrings, Tmp);
  end;
end;

procedure RestoreResString(P: PResStringRec);
var
  Tmp: PStoredResStringData;
begin
  Tmp := FindStoredResStringData(P);
  if Assigned(Tmp) then
  begin
    CopyResString(@Tmp^.Data, P, False);
    ListRemove(StoredResStrings, Tmp);
    FreeMem(Tmp);
  end;
end;

procedure CopyResString(Source, Dest: PResStringRec; Store: Boolean);
var
  SaveFlag: Integer;
begin
  if VirtualProtect(Dest, SizeOf(TResStringRec), PAGE_READWRITE, @SaveFlag) then
  try
    if Store then
      StoreResString(Dest);
    Move(Source^, Dest^, SizeOf(TResStringRec));
  finally
    VirtualProtect(Dest, SizeOf(TResStringRec), SaveFlag, @SaveFlag);
  end;
end;

end.
