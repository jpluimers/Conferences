unit EnumTypeInfoUnit;

interface

uses
  TypInfo;

function GetEnumNameAndOrdValue(const TypeInfo: PTypeInfo; const Value: Integer): string; overload;

implementation

uses
  SysUtils;

function GetEnumNameAndOrdValue(const TypeInfo: PTypeInfo; const Value: Integer): string;
begin
  Result := Format('%s (%d)', [GetEnumName(TypeInfo, Value), Value]);
end;

end.
