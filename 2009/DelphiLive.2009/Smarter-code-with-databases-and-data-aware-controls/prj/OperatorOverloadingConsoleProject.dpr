program OperatorOverloadingConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  LoggerUnit in '..\src\LoggerUnit.pas',
  ReporterUnit in '..\src\ReporterUnit.pas',
  ReportersUnit in '..\src\ReportersUnit.pas',
  LoggersUnit in '..\src\LoggersUnit.pas',
  ConsoleLoggingLogicUnit in '..\src\ConsoleLoggingLogicUnit.pas',
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas';

type
  TMyClass = class
  end;

  TMyRecord = record
    class operator LessThan(A: TMyRecord; B: TMyClass): TMyClass;
    class operator Equal(A: TMyRecord; B: TMyClass): TMyClass;
    class operator Multiply(A: TMyRecord; B: TMyClass): TMyClass;
    class operator Round(A: TMyRecord): TMyClass;
  end;

  TLogic = class(TConsoleLoggingLogic)
  public
    procedure Go; override;
  end;

procedure TLogic.Go;
var
  Left: TMyClass;
  Right: TMyRecord;
  Result: TMyClass;
begin
  Logger.Log('Start');
  Left := TMyClass.Create;
  Result := Round(Right);
  Result := Right < Left;
//  if (Right < Left) then
//    Logger.Log('True');
  Logger.Log('Finish');
end;

class operator TMyRecord.LessThan(A: TMyRecord; B: TMyClass): TMyClass;
begin
//  Result := ;
end;

class operator TMyRecord.Equal(A: TMyRecord; B: TMyClass): TMyClass;
begin
//  Result := ;
end;

class operator TMyRecord.Multiply(A: TMyRecord; B: TMyClass): TMyClass;
begin
//  Result := ;
end;

class operator TMyRecord.Round(A: TMyRecord): TMyClass;
begin
//  Result := ;
end;

begin
  try
    TLogic.Run(TLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
