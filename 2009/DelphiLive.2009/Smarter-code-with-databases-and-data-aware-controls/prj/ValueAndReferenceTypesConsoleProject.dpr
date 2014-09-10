program ValueAndReferenceTypesConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  LoggerUnit in '..\src\LoggerUnit.pas',
  ReporterUnit in '..\src\ReporterUnit.pas',
  ReportersUnit in '..\src\ReportersUnit.pas',
  LoggersUnit in '..\src\LoggersUnit.pas',
  ConsoleLoggingLogicUnit in '..\src\ConsoleLoggingLogicUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas',
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas';

type
  TLogic = class(TConsoleLoggingLogic)
  strict private
    procedure LogIntegerValues;
    procedure LogIntegerPointers;
  public
    procedure Go; overload; override;
  end;

procedure TLogic.Go;
begin
  LogIntegerValues();
  LogIntegerPointers();
end;

procedure TLogic.LogIntegerValues;
var
  A: Integer;
  B: Integer;
begin
  Logger.Log('Integers');
  A := -1;
  B := -1;
  Logger.Log('A=%d, B=%d', [A, B]);
  A := 4;
  Logger.Log('A=%d, B=%d', [A, B]);
  B := 5;
  Logger.Log('A=%d, B=%d', [A, B]);
  A := B;
  Logger.Log('A=%d, B=%d', [A, B]);
  A := 6;
  Logger.Log('A=%d, B=%d', [A, B]);
end;

type
  TIntegerPointer = ^Integer;

procedure TLogic.LogIntegerPointers;
var
  A: TIntegerPointer;
  B: TIntegerPointer;
begin
  Logger.Log('IntegerPointers');
  New(A);
  New(B);
  Logger.Log('A=%d, B=%d', [A^, B^]);
  A^ := 4;
  Logger.Log('A=%d, B=%d', [A^, B^]);
  B^ := 5;
  Logger.Log('A=%d, B=%d', [A^, B^]);
  A := B;
  Logger.Log('A=%d, B=%d', [A^, B^]);
  A^ := 6;
  Logger.Log('A=%d, B=%d', [A^, B^]);
end;

begin
  try
    TLogic.Run(TLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
