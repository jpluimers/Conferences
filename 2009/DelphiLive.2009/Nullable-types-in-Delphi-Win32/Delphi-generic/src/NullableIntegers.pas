
unit NullableInt32s;

interface

uses
  SysUtils, NullableTypes;

type
  NullableInt32 = record
  private
    const C_INIT_VALUE: string = 'I'; 
    procedure SetIsNull(const AValue: boolean);
    var fValue: Int32;
    var fInitFlag: string;
    procedure SetValue(const AValue: Int32);
    function GetValue: Int32;
    function GetIsNull: boolean;
    procedure CheckValue;
  public
    property Value: Int32 read GetValue write SetValue;
    property IsNull: boolean read GetIsNull write SetIsNull;
    function ToHex(aDigits: Integer): string;

    class operator Implicit(a : Int32) : NullableInt32;
    class operator Implicit(a : NullableInt32) : Int32;
    class operator Implicit(a : string) : NullableInt32;
    class operator Implicit(a : NullableInt32) : string;

    class operator Add(a, b: NullableInt32): NullableInt32;
    class operator Subtract(a, b: NullableInt32) : NullableInt32;
    class operator Multiply(a, b: NullableInt32) : NullableInt32;
    class operator Divide(a, b: NullableInt32) : NullableInt32;
    class operator IntDivide(a, b: NullableInt32): NullableInt32;
    class operator Modulus(a, b: NullableInt32): NullableInt32;
    class operator LeftShift(a, b: NullableInt32): NullableInt32;
    class operator RightShift(a, b: NullableInt32): NullableInt32;
    class operator BitwiseAnd(a, b: NullableInt32): NullableInt32;
    class operator BitwiseOr(a, b: NullableInt32): NullableInt32;
    class operator BitwiseXor(a, b: NullableInt32): NullableInt32;
  end;

implementation

{ NullableInt32 }

function NullableInt32.ToHex(aDigits: Integer): string;
begin
  if IsNull then
    Result := ''
  else
    Result := IntToHex(fValue, aDigits)
end;

function NullableInt32.GetIsNull: boolean;
begin
  Result := fInitFlag <> C_INIT_VALUE;
end;

function NullableInt32.GetValue: Int32;
begin
  CheckValue;
  Result := fValue;
end;

procedure NullableInt32.SetValue(const AValue: Int32);
begin
  fInitFlag := C_INIT_VALUE;
  fValue := AValue;
end;

class operator NullableInt32.Implicit(a: NullableInt32): Int32;
begin
  Result := a.Value;
end;

class operator NullableInt32.Implicit(a: Int32): NullableInt32;
begin
  Result.Value := a;
end;

class operator NullableInt32.Implicit(a: string): NullableInt32;
begin
  if a = '' then
    Result.IsNull := True
  else
    Result.Value := StrToInt(a);
end;

class operator NullableInt32.Implicit(a: NullableInt32): string;
begin
  if a.IsNull then
    Result := ''
  else
    Result := IntToStr(a.fValue);
end;

procedure NullableInt32.CheckValue;
begin
  if IsNull then
    raise ENullReference.Create('Attempted to read null as a value.');
end;

procedure NullableInt32.SetIsNull(const AValue: boolean);
begin
  if not AValue then
    Raise ENullReference.Create('Cannot convert a null value to non-null without providing a value!');
  fInitFlag := '';
end;

class operator NullableInt32.Add(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value + b.Value;
end;

class operator NullableInt32.BitwiseAnd(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value and b.Value;
end;

class operator NullableInt32.BitwiseOr(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value or b.Value;
end;

class operator NullableInt32.BitwiseXor(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value xor b.Value;
end;

class operator NullableInt32.Divide(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value div b.Value;
end;

class operator NullableInt32.IntDivide(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value div b.Value;
end;

class operator NullableInt32.LeftShift(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value shl b.Value;
end;

class operator NullableInt32.Modulus(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value mod b.Value;
end;

class operator NullableInt32.Multiply(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value * b.Value;
end;

class operator NullableInt32.RightShift(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value shr b.Value;
end;

class operator NullableInt32.Subtract(a, b: NullableInt32): NullableInt32;
begin
  Result.Value := a.Value - b.Value;
end;

end.


 
