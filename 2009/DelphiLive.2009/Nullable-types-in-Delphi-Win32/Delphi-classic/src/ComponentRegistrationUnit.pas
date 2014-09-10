unit ComponentRegistrationUnit;

interface

procedure Register;

implementation

uses
  Classes, NullableCurrencyStaticTextUnit, NullableDoubleStaticTextUnit, NullableIntegerStaticTextUnit;

procedure Register;
begin
  RegisterComponents('SDC-2009', [
    NullableCurrencyStaticTextUnit.TCustomNullableCurrencyStaticText,
    NullableDoubleStaticTextUnit.TCustomNullableDoubleStaticText,
    NullableIntegerStaticTextUnit.TNullableIntegerStaticText
  ]);
end;

end.
