program TestApp;

uses
  Forms,
  TestFormUnit in 'TestFormUnit.pas' {Form1},
  NLResourceStrings in 'NLResourceStrings.pas',
  NLConsts in 'NLConsts.pas',
  NLRTLConsts in 'NLRTLConsts.pas',
  NLSysConst in 'NLSysConst.pas',
  ResourceUtils in 'ResourceUtils.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
