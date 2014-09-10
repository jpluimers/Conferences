unit StringUtilsUnit;

interface

function CommaSeparated(const Values: array of WideString): WideString; overload;

implementation

uses
  SysUtils;

function CommaSeparated(const Values: array of WideString): WideString;
var
  Value: WideString;
begin
  Result := '';
  for Value in Values do
    if Result = '' then
      Result := Value
    else
      Result := Format('%s, %s', [Result, Value]);
end;

end.
