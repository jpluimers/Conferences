unit FieldHelperUnit;

interface

uses
  DB, NullablesUnit;

type
  TFloatFieldHelper = class helper for TFloatField
  private
    function GetAsNullableDouble: TNullableDouble;
    procedure SetAsNullableDouble(const Value: TNullableDouble);
  public
    property AsNullableDouble: TNullableDouble read GetAsNullableDouble write SetAsNullableDouble;
  end;

type
  TIntegerFieldHelper = class helper for TIntegerField
  private
    function GetAsNullableInteger: TNullableInteger;
    procedure SetAsNullableInteger(const Value: TNullableInteger);
  public
    property AsNullableInteger: TNullableInteger read GetAsNullableInteger write SetAsNullableInteger;
  end;

type
  TStringFieldHelper = class helper for TStringField
  private
    function GetAsNullableString: string;
    procedure SetAsNullableString(const Value: string);
  public
    //1 Refactor naar TNullableString
    property AsNullableString: string read GetAsNullableString write SetAsNullableString;
  end;

implementation

{ TFloatFieldHelper }

function TFloatFieldHelper.GetAsNullableDouble: TNullableDouble;
begin
  if Self.IsNull then
    Result.Clear()
  else
    Result.Value := Self.Value;
end;

procedure TFloatFieldHelper.SetAsNullableDouble(const Value: TNullableDouble);
begin
  if Value.IsNull then
    Clear()
  else
    Self.Value := Value.Value;
end;

{ TIntegerFieldHelper }

function TIntegerFieldHelper.GetAsNullableInteger: TNullableInteger;
begin
  if Self.IsNull then
    Result.Clear()
  else
    Result.Value := Self.Value;
end;

procedure TIntegerFieldHelper.SetAsNullableInteger(const Value: TNullableInteger);
begin
  if Value.IsNull then
    Clear()
  else
    Self.Value := Value.Value;
end;

{ TStringFieldHelper }

function TStringFieldHelper.GetAsNullableString: string;
begin
  Result := Self.AsString;
end;

procedure TStringFieldHelper.SetAsNullableString(const Value: string);
begin
  Self.AsString := Value;
end;

end.
