unit DataSetHelperUnit;

interface

uses
  DB, SqlExpr;

type
  TDataSetRecord = record
    //1 If nil, then empty DataSet in for ... in loop
    DataSet: TDataSet;
  end;

  TDataSetEnumerator = class
  strict private
    FDataSet: TDataSet;
    FFirstItem: Boolean;
    FEmpty: Boolean;
  public
    constructor Create(const DataSet: TDataSet);
    function GetCurrent: TDataSetRecord;
    function MoveNext: Boolean;
    //1 Mark the for ... in enumeration result as TDataSetRecord
    property Current: TDataSetRecord read GetCurrent;
  end;

  TDataSetHelper = class helper for TDataSet
  public
    //1 Returns first field that matches, if no matching field then exception
    function FieldByAnyName(const FieldNames: array of WideString): TField;
    //1 Support for ... in loop providing TDataSetRecord
    function GetEnumerator: TDataSetEnumerator;
  end;

implementation

uses
  DBConsts, StringUtilsUnit;

{ TDataSetEnumerator }

constructor TDataSetEnumerator.Create(const DataSet: TDataSet);
begin
  inherited Create;
  Self.FDataSet := DataSet;
  if DataSet.Active then
    DataSet.First() // if it already was Open, make sure we are at Bof
  else
    DataSet.Open();
  Self.FFirstItem := True;
  Self.FEmpty := DataSet.Bof and DataSet.Eof;
end;

function TDataSetEnumerator.GetCurrent: TDataSetRecord;
begin
  if Self.FEmpty then
    Result.DataSet := nil
  else
    Result.DataSet := FDataSet;
end;

function TDataSetEnumerator.MoveNext: Boolean;
begin
  // After opening a TDataSet, it always is at the first record,
  // but a TEnumerator expects to be *before* the first record
  // so we need to accommodate for that by the FFirstItem trick
  if Self.FEmpty then
    Result := False
  else
  begin
    if FFirstItem then
      FFirstItem := False
    else
      FDataSet.Next;
    Result := not FDataSet.Eof;
  end;
end;

function TDataSetHelper.FieldByAnyName(const FieldNames: array of WideString): TField;
var
  FieldName: WideString;
begin
  Result := nil;
  for FieldName in FieldNames do
  begin
    Result := FindField(FieldName);
    if Assigned(Result) then
      Exit;
  end;
  if Result = nil then
    DatabaseErrorFmt(SFieldNotFound, [CommaSeparated(FieldName)], Self);
end;

function TDataSetHelper.GetEnumerator: TDataSetEnumerator;
begin
  Result := TDataSetEnumerator.Create(Self);
end;

end.
