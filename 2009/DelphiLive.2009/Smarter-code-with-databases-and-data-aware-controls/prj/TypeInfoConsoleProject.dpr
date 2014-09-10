program TypeInfoConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  LoggerUnit in '..\src\LoggerUnit.pas',
  ReporterUnit in '..\src\ReporterUnit.pas',
  ReportersUnit in '..\src\ReportersUnit.pas',
  LoggersUnit in '..\src\LoggersUnit.pas',
  ConsoleLoggingLogicUnit in '..\src\ConsoleLoggingLogicUnit.pas',
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas', TypInfo;

type
{$typeinfo on}
  TNoTypeInfoRecord  = record
  strict private
    FX: Integer;
    FY: Double;
  public
    property X: Integer read FX write FX;
    property Y: Double read FY write FY;
  end;

  TTypeInfoRecord  = record
  strict private
    FS: string;
    FX: Integer;
    FY: Double;
  public
    property S: string read FS write FS;
    property X: Integer read FX write FX;
    property Y: Double read FY write FY;
  end;

  TTypeInfoClass  = class
  strict private
    FX: Integer;
    FY: Double;
  published
    property X: Integer read FX write FX;
    property Y: Double read FY write FY;
  end;

  TLogic = class(TConsoleLoggingLogic)
  public
    procedure Go; overload; override;
  end;

procedure TLogic.Go;
var
  NoTypeInfoRecord: TNoTypeInfoRecord;
  NoTypeInfoRecordTypeInfo: PTypeInfo;
  TypeInfoRecord: TTypeInfoRecord;
  TypeInfoRecordTypeInfo: PTypeInfo;
  TypeInfoClass: TTypeInfoClass;
  TypeInfoClassTypeInfo: PTypeInfo;
begin
//  NoTypeInfoRecordTypeInfo := TypeInfo(TNoTypeInfoRecord);
//  Logger.Log('NoTypeInfoRecordTypeInfo', NoTypeInfoRecordTypeInfo);

  TypeInfoRecordTypeInfo := TypeInfo(TTypeInfoRecord);
  Logger.Log('TypeInfoRecordTypeInfo', TypeInfoRecordTypeInfo);

  TypeInfoClassTypeInfo := TypeInfo(TTypeInfoClass);
  Logger.Log('TypeInfoClassTypeInfo', TypeInfoClassTypeInfo);
end;

begin
  try
    TLogic.Run(TLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
