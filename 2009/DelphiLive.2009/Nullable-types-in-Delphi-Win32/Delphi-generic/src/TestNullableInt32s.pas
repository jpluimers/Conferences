unit TestNullableInt32s;

interface

uses
  TestFramework, Variants, NullableInt32s, SysUtils;

type
  // Test methods for NullableInt32

  TestNullableInt32 = class(TTestCase)
  strict private
  private
    procedure ReadUnint;
    procedure ReadNull;
  published
    procedure TestRandomAssignment;
    procedure TestMaxAssignment;
    procedure TestMinAssignment;
    procedure TestMaxStringAssignment;
    procedure TestMinStringAssignment;
    procedure TestRandomStringAssignment;
    procedure TestNullStringAssignment;
    procedure TestNullStringValue;

    procedure TestIntToStr;

    procedure TestMultiplication;
    procedure TestAddition;
    procedure TestSubtraction;
    procedure TestDivision;
    procedure TestModulous;
    procedure TestShl;
    procedure TestShr;
    procedure TestAnd;
    procedure TestOr;
    procedure TestXor;

    procedure TestUninit;
    procedure TestReadNull;
  end;

implementation

uses NullableTypes;

const
  MinInt: Int32 = (MaxInt * -1) - 1;
  RandomIterations = 10000;

procedure TestNullableInt32.TestAddition;
var
  n1, n2: NullableInt32;
begin
  n1 := 10;
  n2 := n1 + 10;
  CheckEquals(20, n2);
end;

procedure TestNullableInt32.TestAnd;
var
  n1, n2: NullableInt32;
begin
  n1 := $FF;
  n2 := n1 and $F;
  CheckEquals($F, n2);
end;

procedure TestNullableInt32.TestDivision;
var
  n1, n2: NullableInt32;
begin
  n1 := 10;
  n2 := n1 div 2;
  CheckEquals(5, n2);
end;

//procedure TestNullableInt32.TestFromFloat;
//var
//  v: Extended;
//  n: NullableInt32;
//begin
//  v := 1000.001;
//  n := Round(v);
//  CheckEquals(Round(v), n);
//end;

procedure TestNullableInt32.TestIntToStr;
var
  v: Integer;
  n: NullableInt32;
begin
  v := MaxInt;
  n := v;
  CheckEquals(IntToStr(v), IntToStr(n));
end;

procedure TestNullableInt32.TestMaxAssignment;
var
  v: Integer;
  n: NullableInt32;
begin
  v := MaxInt;
  n := v;
  CheckEquals(v, n);
end;

procedure TestNullableInt32.TestMinAssignment;
var
  v: Integer;
  n: NullableInt32;
begin
  v := MinInt;
  n := v;
  CheckEquals(v, n);
end;

procedure TestNullableInt32.TestMinStringAssignment;
var
  n: NullableInt32;
  v: Integer;
  s: string;
begin
  v := MinInt;
  s := IntToStr(v);
  n := s;
  CheckEquals(v, n, s);
end;

procedure TestNullableInt32.TestModulous;
var
  n1, n2: NullableInt32;
begin
  n1 := 10;
  n2 := n1 mod 3;
  CheckEquals(1, n2);
end;

procedure TestNullableInt32.TestMultiplication;
var
  n1, n2: NullableInt32;
begin
  n1 := 10;
  n2 := n1 * 10;
  CheckEquals(100, n2);
end;

procedure TestNullableInt32.TestNullStringAssignment;
var
  n: NullableInt32;
begin
  n := '';
  CheckTrue(n.IsNull);
end;

procedure TestNullableInt32.TestNullStringValue;
var
  n: NullableInt32;
begin
  n.IsNull := True;
  CheckEquals('',n);
end;

//procedure TestNullableInt32.TestNullVariantAssignement;
//var
//  n: NullableInt32;
//begin
//  n := null;
//  CheckTrue(n.IsNull);
//end;

procedure TestNullableInt32.TestOr;
var
  n1, n2: NullableInt32;
begin
  n1 := $F0;
  n2 := n1 or $F;
  CheckEquals($FF, n2);
end;

procedure TestNullableInt32.TestRandomAssignment;
var
  v: Integer;
  n: NullableInt32;
  I: Integer;
begin
  for I := 0 to RandomIterations do
  begin
    v := Random(MaxInt);
    n := v;
    CheckEquals(v, n, IntToStr(v));
  end;
end;

procedure TestNullableInt32.TestRandomStringAssignment;
var
  n: NullableInt32;
  v: Integer;
  s: string;
  I: Integer;
begin
  for I := 0 to RandomIterations do
  begin
    v := Random(MaxInt);
    s := IntToStr(v);
    n := s;
    CheckEquals(v, n, s);
  end;
  for I := 0 to RandomIterations do
  begin
    v := Random(MaxInt) * -1;
    s := IntToStr(v);
    n := s;
    CheckEquals(v, n, s);
  end;
end;

{procedure TestNullableInt32.TestRandomVariantAssignment;
var
  n: NullableInt32;
  v: variant;
  I: Integer;
begin
  for I := 0 to RandomIterations do
  begin
    v := Random(MaxInt);
    n := v;
    CheckEquals(Integer(v), n, v);
  end;
  for I := 0 to RandomIterations do
  begin
    v := Random(MaxInt) * -1;
    n := v;
    CheckEquals(Integer(v), n, v);
  end;
end;}

procedure TestNullableInt32.ReadNull;
var
  n: NullableInt32;
  i: Integer;
begin
  n.IsNull := True;
  i := n; // Should generate exception
  n := i;
end;

procedure TestNullableInt32.TestReadNull;
begin
  CheckException(ReadNull, ENullReference);
end;

procedure TestNullableInt32.TestShl;
var
  n1, n2: NullableInt32;
begin
  n1 := 4;
  n2 := n1 shl 1;
  CheckEquals(8, n2);
end;

procedure TestNullableInt32.TestShr;
var
  n1, n2: NullableInt32;
begin
  n1 := 4;
  n2 := n1 shr 1;
  CheckEquals(2, n2);
end;

procedure TestNullableInt32.TestSubtraction;
var
  n1, n2: NullableInt32;
begin
  n1 := 10;
  n2 := n1 - 10;
  CheckEquals(0, n2);
end;

//procedure TestNullableInt32.TestToFloat;
//var
//  v: Extended;
//  n: NullableInt32;
//begin
//  n := 1000.0001;
//  v := n;
//  CheckEquals(Round(v), n);
//end;

procedure TestNullableInt32.ReadUnint;
var
  n: NullableInt32;
  i: Integer;
begin
  i := n; // Should generate exception
  n := i;
end;

procedure TestNullableInt32.TestUninit;
begin
  CheckException(ReadUnint, ENullReference);
end;

procedure TestNullableInt32.TestXor;
var
  n1, n2: NullableInt32;
begin
  n1 := $F0;
  n2 := n1 xor $F;
  CheckEquals($FF, n2);
end;

procedure TestNullableInt32.TestMaxStringAssignment;
var
  n: NullableInt32;
  v: Integer;
  s: string;
begin
  v := MaxInt;
  s := IntToStr(v);
  n := s;
  CheckEquals(v, n, s);
end;

//procedure TestNullableInt32.TestMaxVariantAssignment;
//var
//  v: Variant;
//  n: NullableInt32;
//begin
//  v := MaxInt;
//  n := v;
//  CheckEquals(Integer(v), n);
//end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestNullableInt32.Suite);
end.

