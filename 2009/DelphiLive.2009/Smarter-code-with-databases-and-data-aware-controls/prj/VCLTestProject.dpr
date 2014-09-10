program VCLTestProject;

uses
  Forms,
  TestMainFormUnit in '..\src\TestMainFormUnit.pas' {TestMainForm},
  DataAwareControlControllerUnit in '..\src\DataAwareControlControllerUnit.pas',
  EnterEscapeFixerUnit in '..\src\EnterEscapeFixerUnit.pas',
  DbDisplayLabelUnit in '..\src\DbDisplayLabelUnit.pas',
  XokumDataModuleUnit in '..\src\XokumDataModuleUnit.pas' {XokumDataModule: TDataModule},
  XokumFormUnit in '..\src\XokumFormUnit.pas' {XokumForm},
  DataLinkReflectorUnit in '..\src\DataLinkReflectorUnit.pas',
  ChooseFromXokumFormUnit in '..\src\ChooseFromXokumFormUnit.pas' {ChooseFromXokumForm},
  DataSetHelperUnit in '..\src\DataSetHelperUnit.pas',
  ParamsHelperUnit in '..\src\ParamsHelperUnit.pas',
  DbCrackerUnit in '..\src\DbCrackerUnit.pas',
  DbUtilityUnit in '..\src\DbUtilityUnit.pas',
  StringUtilsUnit in '..\src\StringUtilsUnit.pas',
  BaseTypesUnit in '..\src\BaseTypesUnit.pas',
  RecordArrivedNotifierUnit in '..\src\RecordArrivedNotifierUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTestMainForm, TestMainForm);
  Application.CreateForm(TXokumDataModule, XokumDataModule);
  Application.CreateForm(TXokumForm, XokumForm);
  Application.CreateForm(TChooseFromXokumForm, ChooseFromXokumForm);
  Application.Run;
end.
