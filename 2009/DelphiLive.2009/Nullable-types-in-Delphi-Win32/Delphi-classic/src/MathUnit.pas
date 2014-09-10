unit MathUnit;

interface

uses
  Math;

type
  TMath = class(TObject)
  public
    class function RoundToFifths(const Value: Double): Double; static;
    class function RoundToHalves(const Value: Double): Double; static;
    class function RoundToHundredths(const Value: Double): Double; static;
    class function RoundToQuarters(const Value: Double): Double; static;
    class function RoundToTenths(const Value: Double): Double; static;
    class function RoundToTwentieths(const Value: Double): Double; static;
    class function SignNoZero(const AValue: Double): TValueSign; static;
  end;

implementation

//1 SimpleRound to 0.2 - round to a fifth, multiples of 1/5

class function TMath.RoundToFifths(const Value: Double): Double;
const
  FifthsPerUnit = 5;
begin
  Result := Math.SimpleRoundTo(Value * FifthsPerUnit, 0) / FifthsPerUnit;
end;

//1 SimpleRound to 0.5 - round to a half, multiples of 1/2

class function TMath.RoundToHalves(const Value: Double): Double;
const
  HalvesPerUnit = 2;
begin
  Result := Math.SimpleRoundTo(Value * HalvesPerUnit, 0) / HalvesPerUnit;
end;

//1 SimpleRound to 0.01 - round to a hundredth, multiples of 1/100

class function TMath.RoundToHundredths(const Value: Double): Double;
begin
  Result := Math.SimpleRoundTo(Value, -2);
end;

//1 SimpleRound to 0.25 - round to a quarter, multiples of 1/4

class function TMath.RoundToQuarters(const Value: Double): Double;
const
  QuartersPerUnit = 4;
begin
  Result := Math.SimpleRoundTo(Value * QuartersPerUnit, 0) / QuartersPerUnit;
end;

//1 SimpleRound to 0.1 - round to a tenth, multiples of 1/10

class function TMath.RoundToTenths(const Value: Double): Double;
begin
  Result := Math.SimpleRoundTo(Value, -1);
end;

//1 SimpleRound to 0.05 - round to a twentieth, multiples of 1/20

class function TMath.RoundToTwentieths(const Value: Double): Double;
const
  TwentiesPerTen = 2;
begin
  Result := Math.SimpleRoundTo(Value * TwentiesPerTen, -1) / TwentiesPerTen;
end;

class function TMath.SignNoZero(const AValue: Double): TValueSign;
begin
  // borrowed from Math.Sign
  if ((PInt64(@AValue)^ and $8000000000000000) = $8000000000000000) then
    Result := NegativeValue
  else
    Result := PositiveValue;
end;

end.
