unit SQLDataSetHelperUnit;

interface

uses
  DB, SqlExpr;

type
  TCustomSQLDataSetHelper = class helper for TCustomSQLDataSet
  public
    function ParameterByAnyName(const ParameterNames: array of WideString): TParam;
  end;

implementation

uses
  ParamsHelperUnit;

function TCustomSQLDataSetHelper.ParameterByAnyName(const ParameterNames: array of WideString): TParam;
begin
  Result := Params.ParameterByAnyName(ParameterNames);
end;

end.
