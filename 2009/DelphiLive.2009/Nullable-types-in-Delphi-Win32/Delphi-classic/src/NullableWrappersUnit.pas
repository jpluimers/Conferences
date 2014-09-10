unit NullableWrappersUnit;

interface

uses
  Classes, NullablesUnit;

type
  TNullableIntegerWrapper = class(TPersistent)
  strict private
    FNullableValue: TNullableInteger;
    FOnChange: TNotifyEvent;
  strict protected
    procedure Changed; dynamic;
  public
    function GetIsNull: Boolean; virtual;
    function GetValue: Integer; virtual;
    procedure SetIsNull(const Value: Boolean); virtual;
    procedure SetValue(const Value: Integer); virtual;
    constructor Create(AValue: TNullableInteger);
    procedure Assign(Source: TPersistent); override;
    function GetNullableValue: TNullableInteger; virtual;
    procedure SetNullableValue(const Value: TNullableInteger); virtual;
    property NullableValue: TNullableInteger read GetNullableValue write SetNullableValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: Integer read GetValue write SetValue;
  end;

type
  TNullableCurrencyWrapper = class(TPersistent)
  strict private
    FNullableValue: TNullableCurrency;
    FOnChange: TNotifyEvent;
  strict protected
    procedure Changed; dynamic;
  public
    constructor Create(AValue: TNullableCurrency);
    procedure Assign(Source: TPersistent); override;
    function GetIsNull: Boolean; virtual;
    function GetNullableValue: TNullableCurrency; virtual;
    function GetValue: Currency; virtual;
    procedure SetIsNull(const Value: Boolean); virtual;
    procedure SetNullableValue(const Value: TNullableCurrency); virtual;
    procedure SetValue(const Value: Currency); virtual;
    property NullableValue: TNullableCurrency
      read GetNullableValue
      write SetNullableValue;
    property OnChange: TNotifyEvent
      read FOnChange
      write FOnChange;
  published
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: Currency read GetValue write SetValue;
  end;

type
  TNullableStringWrapper = class
  strict private
    FValue: TNullableString;
  public
    constructor Create(const AValue: TNullableString);
    property Value: TNullableString read FValue;
  end;

type
  TNullableDoubleWrapper = class(TPersistent)
  strict private
    FNullableValue: TNullableDouble;
    FOnChange: TNotifyEvent;
  strict protected
    procedure Changed; dynamic;
  public
    function GetIsNull: Boolean; virtual;
    function GetValue: Double; virtual;
    procedure SetIsNull(const Value: Boolean); virtual;
    procedure SetValue(const Value: Double); virtual;
    constructor Create(AValue: TNullableDouble);
    procedure Assign(Source: TPersistent); override;
    function GetNullableValue: TNullableDouble; virtual;
    procedure SetNullableValue(const Value: TNullableDouble); virtual;
    property NullableValue: TNullableDouble read GetNullableValue write SetNullableValue;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: Double read GetValue write SetValue;
  end;

implementation

uses
  SysUtils, Windows;

{ TNullableIntegerWrapper }

constructor TNullableIntegerWrapper.Create(AValue: TNullableInteger);
begin
  FNullableValue := AValue;
end;

procedure TNullableIntegerWrapper.Assign(Source: TPersistent);
var
  NewNullableValue: TNullableIntegerWrapper;
begin
  if Source is TNullableIntegerWrapper then
  begin
    NewNullableValue := TNullableIntegerWrapper(Source);
    Self.NullableValue := NewNullableValue.NullableValue;
    Exit;
  end;
  if Source = nil then
  begin
    Self.IsNull := True;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TNullableIntegerWrapper.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TNullableIntegerWrapper.GetIsNull: Boolean;
begin
  Result := Self.NullableValue.IsNull;
end;

function TNullableIntegerWrapper.GetNullableValue: TNullableInteger;
begin
  Result := FNullableValue;
end;

function TNullableIntegerWrapper.GetValue: Integer;
begin
  Result := Self.NullableValue.Value;
end;

procedure TNullableIntegerWrapper.SetIsNull(const Value: Boolean);
var
  NewNullableValue: TNullableInteger;
begin
  if Self.IsNull <> Value then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.IsNull := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;

procedure TNullableIntegerWrapper.SetNullableValue(const Value: TNullableInteger);
begin
  if Self.NullableValue <> Value then
  begin
    Self.FNullableValue := Value;
    Changed();
  end;
end;

procedure TNullableIntegerWrapper.SetValue(const Value: Integer);
var
  NewNullableValue: TNullableInteger;
begin
  if Self.Value <> Value then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.Value := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;


{ TNullableCurrencyWrapper }

constructor TNullableCurrencyWrapper.Create(AValue: TNullableCurrency);
begin
  FNullableValue := AValue;
end;

procedure TNullableCurrencyWrapper.Assign(Source: TPersistent);
var
  NewNullableValue: TNullableCurrencyWrapper;
begin
  if Source is TNullableCurrencyWrapper then
  begin
    NewNullableValue := TNullableCurrencyWrapper(Source);
    Self.NullableValue := NewNullableValue.NullableValue;
    Exit;
  end; 
  if Source = nil then
  begin
    Self.IsNull := True;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TNullableCurrencyWrapper.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TNullableCurrencyWrapper.GetIsNull: Boolean;
begin
  Result := Self.NullableValue.IsNull;
end;

function TNullableCurrencyWrapper.GetNullableValue: TNullableCurrency;
begin
  Result := FNullableValue;
end;

function TNullableCurrencyWrapper.GetValue: Currency;
begin
  Result := Self.NullableValue.Value;
end;

procedure TNullableCurrencyWrapper.SetIsNull(const Value: Boolean);
var
  Equal: Boolean;
  NewNullableValue: TNullableCurrency;
begin
  Equal := Self.IsNull = Value;
  if not Equal then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.IsNull := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;

procedure TNullableCurrencyWrapper.SetNullableValue(const Value:
  TNullableCurrency);
var
  Equal: Boolean;
begin
  Equal := Self.NullableValue = Value;
  if not Equal then
  begin
    Self.FNullableValue := Value;
    Changed();
  end;
end;

procedure TNullableCurrencyWrapper.SetValue(const Value: Currency);
var
  Equal: Boolean;
  NewNullableValue: TNullableCurrency;
begin
  Equal := Self.Value = Value;
  if not Equal then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.Value := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;


{ TNullableStringWrapper }

constructor TNullableStringWrapper.Create(const AValue: TNullableString);
begin
  FValue := AValue;
end;


{ TNullableDoubleWrapper }

constructor TNullableDoubleWrapper.Create(AValue: TNullableDouble);
begin
  FNullableValue := AValue;
end;

procedure TNullableDoubleWrapper.Assign(Source: TPersistent);
var
  NewNullableValue: TNullableDoubleWrapper;
begin
  if Source is TNullableDoubleWrapper then
  begin
    NewNullableValue := TNullableDoubleWrapper(Source);
    Self.NullableValue := NewNullableValue.NullableValue;
    Exit;
  end;
  if Source = nil then
  begin
    Self.IsNull := True;
    Exit;
  end;
  inherited Assign(Source);
end;

procedure TNullableDoubleWrapper.Changed;
begin
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

function TNullableDoubleWrapper.GetIsNull: Boolean;
begin
  Result := Self.NullableValue.IsNull;
end;

function TNullableDoubleWrapper.GetNullableValue: TNullableDouble;
begin
  Result := FNullableValue;
end;

function TNullableDoubleWrapper.GetValue: Double;
begin
  Result := Self.NullableValue.Value;
end;

procedure TNullableDoubleWrapper.SetIsNull(const Value: Boolean);
var
  Equal: Boolean;
  NewNullableValue: TNullableDouble;
begin
  Equal := Self.IsNull = Value;
  if not Equal then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.IsNull := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;

procedure TNullableDoubleWrapper.SetNullableValue(const Value: TNullableDouble);
var
  Equal: Boolean;
begin
  Equal := Self.NullableValue = Value;
  if not Equal then
  begin
    Self.FNullableValue := Value;
    Changed();
  end;
end;

procedure TNullableDoubleWrapper.SetValue(const Value: Double);
var
  Equal: Boolean;
  NewNullableValue: TNullableDouble;
begin
  Equal := Self.Value = Value;
  if not Equal then
  begin
    NewNullableValue := Self.NullableValue;
    NewNullableValue.Value := Value;
    Self.NullableValue := NewNullableValue;
  end;
end;

end.
