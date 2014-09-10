unit TestMainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Spin, NullableIntegerStaticTextUnit,
  NullableDoubleStaticTextUnit, NumericStaticTextUnit,
  NullableCurrencyStaticTextUnit;

type
  TTestMainForm = class(TForm)
    CustomNullableCurrencyStaticText1: TCustomNullableCurrencyStaticText;
    CustomNullableDoubleStaticText1: TCustomNullableDoubleStaticText;
    NullableIntegerStaticText1: TNullableIntegerStaticText;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  end;

var
  TestMainForm: TTestMainForm;

implementation

uses
  NullablesUnit;

{$R *.dfm}

procedure TTestMainForm.Button1Click(Sender: TObject);
begin
//  NullableIntegerStaticText1.Value.Clear(); //##jpl: gaat nog niet goed
  NullableIntegerStaticText1.Value :=
    TNullableInteger.Null;
end;

procedure TTestMainForm.Button2Click(Sender: TObject);
begin
  NullableIntegerStaticText1.Value :=
    Random(1000);
end;

end.
