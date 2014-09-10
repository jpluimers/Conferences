unit SetTypeInfoUnit;

// see http://tondrej.blogspot.com/2007/10/settostring-stringtoset.html

//Example usage:
//
//
//var
//  A: TAlignSet;
//  S: AnsiString;
//begin
//  // set to string
//  A := [alClient, alLeft, alTop];
//  S := SetToString(TypeInfo(TAlignSet), A, True);
//  ShowMessage(Format('%s ($%x)', [S, Byte(A)]));
//
//  // string to set
//  S := '[alNone, alRight, alCustom]';
//  StringToSet(TypeInfo(TAlignSet), A, S);
//  ShowMessage(Format('%s ($%x)', [SetToString(TypeInfo(TAlignSet), A, True), Byte(A)]));
//end;


interface

uses
  SysUtils, TypInfo;


function GetOrdValue(Info: PTypeInfo; const SetParam): Integer;

procedure SetOrdValue(Info: PTypeInfo; var SetParam; Value: Integer);

function SetToString(Info: PTypeInfo; const SetParam; Brackets: Boolean): string;

procedure StringToSet(Info: PTypeInfo; var SetParam; const Value: string);

{$IF Declared(RTLVersion) and (RTLVersion >= 20.0)}
  {$define d12up}
{$IFEND}
{$ifndef d12up}
type
  TSysCharSet = set of Char;
{$endif d12up}

function CharInSet(C: Char; const CharSet: TSysCharSet): Boolean;


implementation


function GetOrdValue(Info: PTypeInfo; const SetParam): Integer;
begin
  Result := 0;

  case GetTypeData(Info)^.OrdType of
    otSByte, otUByte:
      Result := Byte(SetParam);
    otSWord, otUWord:
      Result := Word(SetParam);
    otSLong, otULong:
      Result := Integer(SetParam);
  end;
end;

procedure SetOrdValue(Info: PTypeInfo; var SetParam; Value: Integer);
begin
  case GetTypeData(Info)^.OrdType of
    otSByte, otUByte:
      Byte(SetParam) := Value;
    otSWord, otUWord:
      Word(SetParam) := Value;
    otSLong, otULong:
      Integer(SetParam) := Value;
  end;
end;

function SetToString(Info: PTypeInfo; const SetParam; Brackets: Boolean): string;
var
  S: TIntegerSet;
  TypeInfo: PTypeInfo;
  I: Integer;
begin
  Result := '';

  Integer(S) := GetOrdValue(Info, SetParam);
  TypeInfo := GetTypeData(Info)^.CompType^;
  for I := 0 to SizeOf(Integer) * 8 - 1 do
    if I in S then
    begin
      if Result <> '' then
        Result := Result + ',';
      Result := Result + GetEnumName(TypeInfo, I);
    end;
  if Brackets then
    Result := '[' + Result + ']';
end;

function CharInSet(C: Char; const CharSet: TSysCharSet): Boolean;
begin
{$ifdef d12up}
  Result := SysUtils.CharInSet(C, CharSet);
{$else}
  Result := C in CharSet;
{$endif}
end;

procedure StringToSet(Info: PTypeInfo; var SetParam; const Value: string);
var
  P: PChar;
  EnumInfo: PTypeInfo;
  EnumName: string;
  EnumValue, SetValue: Longint;

  function NextWord(var P: PChar): string;
  var
    I: Integer;
  begin
    I := 0;
    // scan til whitespace
    while not (CharInSet(P[I], [',', ' ', #0,']'])) do
      Inc(I);
    SetString(Result, P, I);
    // skip whitespace
    while CharInSet(P[I], [',', ' ',']']) do
      Inc(I);
    Inc(P, I);
  end;

begin
  SetOrdValue(Info, SetParam, 0);
  if Value = '' then
    Exit;

  SetValue := 0;
  P := PChar(Value);
  // skip leading bracket and whitespace
  while CharInSet(P^, ['[',' ']) do
    Inc(P);
  EnumInfo := GetTypeData(Info)^.CompType^;
  EnumName := NextWord(P);
  while EnumName <> '' do
  begin
    EnumValue := GetEnumValue(EnumInfo, EnumName);
    if EnumValue < 0 then
    begin
      SetOrdValue(Info, SetParam, 0);
      Exit;
    end;
    Include(TIntegerSet(SetValue), EnumValue);
    EnumName := NextWord(P);
  end;
  SetOrdValue(Info, SetParam, SetValue);
end;

end.
