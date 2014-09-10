unit NullableTypes;

interface

uses
  Variants, SysUtils;

type
  ENullReference = class(Exception)
  //  constructor Create(const AMessage: string);
  end;
  EUnsupportedType = class(Exception)

  end;

  Nullable<T> = record
  private
    var fValue: T;
    class function AddInt(const aInt, bInt): T; static;
    class function CastBack(const aValue): T; static;
    class function AddFloat(const aFloat, bFloat): T; static;
    class function AddString(const aString, bString): T; static;
    class function AddInt64(const aInt64, bInt64): T; static;
    class function NewAddInt(const aInt, bInt): T; static;

    var fInitValue: string;
    var fDefault: T;
    var fInitDefault: string;
    procedure SetValue(const AValue: T);
    function GetValue: T;
    function GetIsNull: Boolean;
    procedure CheckValue;
    procedure CheckType;
    function GetHasValue: Boolean;
    function GetHasDefault: Boolean;
  public
    property Value: T read GetValue write SetValue;
    property IsNull: Boolean read GetIsNull;
    property HasValue: Boolean read GetHasValue;
    property HasDefault: Boolean read GetHasDefault;
    procedure ClearValue;
    procedure SetDefault(const aDefault: T);

    constructor Create(const aValue: T); overload;
    constructor Create(const aValue: T; const aDefault: T); overload;

    class operator NotEqual(aLeft, aRight: Nullable<T>): Boolean;
    class operator Equal(aLeft, aRight: Nullable<T>): Boolean;
    class operator Implicit(a : T) : Nullable<T>;
    class operator Implicit(a : Nullable<T>): T;
    class operator Explicit(aValue: Nullable<T>): T;

    class operator Add(a,b :Nullable<T>): Nullable<T>;
  end;

implementation

uses
  TypInfo, Generics.Defaults, Generics.Casts;

{ Nullable<T> }

function Nullable<T>.GetHasDefault: Boolean;
begin
  Result := fInitDefault = 'I';
end;

function Nullable<T>.GetHasValue: Boolean;
begin
  Result := not IsNull;
end;

function Nullable<T>.GetIsNull: boolean;
begin
  Result := fInitValue <> 'I';
end;

function Nullable<T>.GetValue: T;
begin
  CheckType;
  CheckValue;
  Result := fValue;
end;

procedure Nullable<T>.SetDefault(const aDefault: T);
begin
  fDefault := aDefault;
  fInitDefault := 'I';
  if IsNull then
    fValue := aDefault;
end;

procedure Nullable<T>.SetValue(const AValue: T);
begin
  fInitValue := 'I';
  fValue := AValue;
end;

class operator Nullable<T>.Implicit(a: Nullable<T>): T;
begin
  Result := a.Value;
end;

class operator Nullable<T>.NotEqual(ALeft, ARight: Nullable<T>): Boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if ALeft.HasValue and ARight.HasValue then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := not Comparer.Equals(ALeft.Value, ARight.Value);
  end else
    Result := ALeft.HasValue <> ARight.HasValue;
end;

class operator Nullable<T>.Implicit(a: T): Nullable<T>;
begin
  Result.Value := a;
end;

// got the idea from Andreas Hausladen
class function Nullable<T>.CastBack(const aValue): T;
begin
  Result := T(aValue);
end;

class function Nullable<T>.AddInt(const aInt, bInt): T;
var
  value: Integer;
begin
  value := Integer(aInt) + Integer(bInt);
  Result := CastBack(value);
end;

class function Nullable<T>.AddInt64(const aInt64, bInt64): T;
var
  value: Int64;
begin
  value := Int64(aInt64) + Int64(bInt64);
  Result := CastBack(value);
end;

class function Nullable<T>.AddFloat(const aFloat, bFloat): T;
var
  value: Double;
begin
  value := Double(aFloat) + Double(bFloat);
  Result := CastBack(value);
end;

class function Nullable<T>.AddString(const aString, bString): T;
var
  value: String;
begin
  value := String(aString) + String(bString);
  Result := CastBack(value);
end;

class function Nullable<T>.NewAddInt(const aInt, bInt): T;
var
  Value: Integer;
begin
  Value := Integer(aInt) + Integer(bInt);
  Result := CastBack(Value);
end;

class operator Nullable<T>.Add(a, b: Nullable<T>): Nullable<T>;
var
  info: PTypeInfo;
begin
  if a.IsNull or b.IsNull then
    Result.ClearValue
  else
  begin
    Info := TypeInfo(T);
    case info^.Kind of
//      tkInteger: Result.Value := AddInt(a.fValue, b.fValue);
      tkInteger: Result.Value := NewAddInt(a.fValue, b.fValue);
      tkFloat: Result.Value := AddFloat(a.fValue, b.fValue);
      tkString: Result.Value := AddString(a.fValue, b.fValue);
      tkInt64: Result.Value := AddInt64(a.fValue, b.fValue);
    end;
  end;
end;

procedure Nullable<T>.CheckType;
var
  info: PTypeInfo;
begin
  Info := TypeInfo(T);
  case info^.Kind of
    tkInteger: ;
    tkFloat: ;
    tkString: ;
    tkInt64: ;
    tkUString: ;
  else
    Raise EUnsupportedType.Create('Unsupported Type: Only supports Integers, Int64, Floats and Strings.');
  end;
end;

procedure Nullable<T>.CheckValue;
begin
  if IsNull then
    if HasDefault then
      fValue := fDefault
    else
      raise ENullReference.Create('Attempted to get a null value.');
end;

procedure Nullable<T>.ClearValue;
begin
  fInitValue := '';
end;

constructor Nullable<T>.Create(const aValue: T);
begin
  SetValue(aValue);
end;

constructor Nullable<T>.Create(const aValue, aDefault: T);
begin
  SetValue(aValue);
  SetDefault(aDefault);
end;

class operator Nullable<T>.Equal(aLeft, aRight: Nullable<T>): Boolean;
var
  Comparer: IEqualityComparer<T>;
begin
  if ALeft.HasValue and ARight.HasValue then
  begin
    Comparer := TEqualityComparer<T>.Default;
    Result := Comparer.Equals(aLeft.Value, aRight.Value);
  end else
    Result := ALeft.HasValue = aRight.HasValue;
end;

class operator Nullable<T>.Explicit(aValue: Nullable<T>): T;
begin
  Result := aValue.Value;
end;

end.
