unit UnconstrainedGenericNullableUnit;

interface

type
  TGenericNullable<T> = record // (IFillableBase) // dit mag dus niet
  public
    class operator Add(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator BitwiseAnd(A, B: TGenericNullable<T>): TGenericNullable<T>;
//    class operator BitwiseNot(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator BitwiseOr(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator BitwiseXor(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Dec(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator Divide(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Equal(A, B: TGenericNullable<T>): Boolean;
//    class operator Explicit(A: TGenericNullable<T>): TGenericNullable<T>; overload;
    class operator GreaterThan(A, B: TGenericNullable<T>): Boolean;
    class operator GreaterThanOrEqual(A, B: TGenericNullable<T>): Boolean;
//    class operator Implicit(A: TGenericNullable<T>): TGenericNullable<T>; overload;
    class operator Inc(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator IntDivide(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator LessThan(A, B: TGenericNullable<T>): Boolean;
    class operator LessThanOrEqual(A, B: TGenericNullable<T>): Boolean;
    class operator LogicalAnd(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator LogicalNot(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator LogicalOr(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator LogicalXor(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Modulus(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Multiply(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Negative(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator NotEqual(A, B: TGenericNullable<T>): Boolean;
    class operator Positive(A: TGenericNullable<T>): TGenericNullable<T>;
    class operator Round(A: TGenericNullable<T>): TGenericNullable<T>;
//    class operator ShiftLeft(A, B: TGenericNullable<T>): TGenericNullable<T>;
//    class operator ShiftRight(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator LeftShift(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator RightShift(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Subtract(A, B: TGenericNullable<T>): TGenericNullable<T>;
    class operator Trunc(A: TGenericNullable<T>): TGenericNullable<T>;
  end;

implementation

class operator TGenericNullable<T>.Add(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Add default body inserted
end;

class operator TGenericNullable<T>.BitwiseAnd(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.BitwiseAnd default body inserted
end;

//class operator TGenericNullable<T>.BitwiseNot(A: TGenericNullable<T>): TGenericNullable<T>;
//begin
//  // TODO -cMM: TGenericNullable<T>.BitwiseNot default body inserted
//end;

class operator TGenericNullable<T>.BitwiseOr(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.BitwiseOr default body inserted
end;

class operator TGenericNullable<T>.BitwiseXor(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.BitwiseXor default body inserted
end;

class operator TGenericNullable<T>.Dec(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Dec default body inserted
end;

class operator TGenericNullable<T>.Divide(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Divide default body inserted
end;

class operator TGenericNullable<T>.Equal(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.Equal default body inserted
end;

//class operator TGenericNullable<T>.Explicit(A: TGenericNullable<T>): TGenericNullable<T>;
//begin
//  // TODO -cMM: TGenericNullable<T>.Explicit default body inserted
//end;

class operator TGenericNullable<T>.GreaterThan(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.GreaterThan default body inserted
end;

class operator TGenericNullable<T>.GreaterThanOrEqual(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.GreaterThanOrEqual default body inserted
end;

//class operator TGenericNullable<T>.Implicit(A: TGenericNullable<T>): TGenericNullable<T>;
//begin
//  // TODO -cMM: TGenericNullable<T>.Implicit default body inserted
//end;

class operator TGenericNullable<T>.Inc(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Inc default body inserted
end;

class operator TGenericNullable<T>.IntDivide(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.IntDivide default body inserted
end;

class operator TGenericNullable<T>.LessThan(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.LessThan default body inserted
end;

class operator TGenericNullable<T>.LessThanOrEqual(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.LessThanOrEqual default body inserted
end;

class operator TGenericNullable<T>.LogicalAnd(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.LogicalAnd default body inserted
end;

class operator TGenericNullable<T>.LogicalNot(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.LogicalNot default body inserted
end;

class operator TGenericNullable<T>.LogicalOr(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.LogicalOr default body inserted
end;

class operator TGenericNullable<T>.LogicalXor(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.LogicalXor default body inserted
end;

class operator TGenericNullable<T>.Modulus(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Modulus default body inserted
end;

class operator TGenericNullable<T>.Multiply(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Multiply default body inserted
end;

class operator TGenericNullable<T>.Negative(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Negative default body inserted
end;

class operator TGenericNullable<T>.NotEqual(A, B: TGenericNullable<T>): Boolean;
begin
  // TODO -cMM: TGenericNullable<T>.NotEqual default body inserted
end;

class operator TGenericNullable<T>.Positive(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Positive default body inserted
end;

class operator TGenericNullable<T>.Round(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Round default body inserted
end;

//class operator TGenericNullable<T>.ShiftLeft(A, B: TGenericNullable<T>): TGenericNullable<T>;
//begin
//  // TODO -cMM: TGenericNullable<T>.ShiftLeft default body inserted
//end;
//
//class operator TGenericNullable<T>.ShiftRight(A, B: TGenericNullable<T>): TGenericNullable<T>;
//begin
//  // TODO -cMM: TGenericNullable<T>.ShiftRight default body inserted
//end;

class operator TGenericNullable<T>.LeftShift(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.ShiftLeft default body inserted
end;

class operator TGenericNullable<T>.RightShift(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.ShiftRight default body inserted
end;

class operator TGenericNullable<T>.Subtract(A, B: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Subtract default body inserted
end;

class operator TGenericNullable<T>.Trunc(A: TGenericNullable<T>): TGenericNullable<T>;
begin
  // TODO -cMM: TGenericNullable<T>.Trunc default body inserted
end;

end.

