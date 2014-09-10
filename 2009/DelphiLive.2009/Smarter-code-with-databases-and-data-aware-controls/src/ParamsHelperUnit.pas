unit ParamsHelperUnit;

interface

uses
  DB, BaseTypesUnit;

type
  TParamsHelper = class helper for TParams
  public
    function ParameterByAnyName(const ParameterNames: array of WideString): TParam;
  end;

  EParamsHelper = class(EBaseException);

implementation

uses
  StringUtilsUnit;

function TParamsHelper.ParameterByAnyName(const ParameterNames: array of WideString): TParam;
var
  ParameterName: WideString;
  Parameter: TParam;
begin
  for ParameterName in ParameterNames do
  begin
    Parameter := Self.FindParam(ParameterName);
    if Assigned(Parameter) then
    begin
      Parameter.Clear;
      Result := Parameter;
      Exit;
    end;
  end;
  raise EParamsHelper.Create('None of the parameters found: ' + CommaSeparated(ParameterNames));
end;

end.
