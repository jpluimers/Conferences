program VCLTestProject;

uses
  Forms,
  TestMainFormUnit in '..\src\TestMainFormUnit.pas' {TestMainForm},
  FieldHelperUnit in '..\src\FieldHelperUnit.pas',
  BaseTypesUnit in '..\src\BaseTypesUnit.pas',
  MathUnit in '..\src\MathUnit.pas',
  FormatSettingsHelperUnit in '..\src\FormatSettingsHelperUnit.pas',
  NullableIntegerStaticTextUnit in '..\src\NullableIntegerStaticTextUnit.pas',
  NullableCurrencyStaticTextUnit in '..\src\NullableCurrencyStaticTextUnit.pas',
  NullableDoubleStaticTextUnit in '..\src\NullableDoubleStaticTextUnit.pas',
  NumericStaticTextUnit in '..\src\NumericStaticTextUnit.pas',
  NullablesUnit in '..\src\NullablesUnit.pas',
  NullableWrappersUnit in '..\src\NullableWrappersUnit.pas',
  ControlUtilsUnit in '..\src\ControlUtilsUnit.pas',
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestMainForm, TestMainForm);
  Application.Run;
end.
