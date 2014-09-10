program NullableTypeTests;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  NullableInt32s in '..\src\NullableInt32s.pas',
  NullableTypes in '..\src\NullableTypes.pas',
  TestNullableInt32s in '..\src\TestNullableInt32s.pas',
  TestNullableTypes in '..\src\TestNullableTypes.pas',
  Generics.Casts in '..\src\Generics.Casts.pas';

{R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    TextTestRunner.RunRegisteredTests
  else
    GUITestRunner.RunRegisteredTests;
end.

