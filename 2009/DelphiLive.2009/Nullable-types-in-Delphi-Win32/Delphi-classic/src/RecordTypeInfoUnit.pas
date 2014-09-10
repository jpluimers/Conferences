unit RecordTypeInfoUnit;

// see also: http://wwwswt.informatik.uni-rostock.de/deutsch/Mitarbeiter/michael/lehre/Delphi_WS2000/rtti.pdf

interface

uses
  TypInfo;

type
  //1 From System unit in Delphi 2007
  TFieldInfo = packed record
    TypeInfo: PPTypeInfo;
    Offset: Cardinal;
  end;

  PFieldTable = ^TFieldTable;
  //1 From System unit in Delphi 2007
  TFieldTable = packed record
    X: Word;
    Size: Cardinal;
    Count: Cardinal;
    Fields: array [0..0] of TFieldInfo;
  end;

function GetFieldTable(TypeTypeInfo: PTypeInfo): PFieldTable;


implementation


function GetFieldTable(TypeTypeInfo: PTypeInfo): PFieldTable;
begin
  Result := PFieldTable(Integer(TypeTypeInfo) + Byte(PTypeInfo(TypeTypeInfo).Name[0]));
end;

end.
