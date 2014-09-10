program NullableTypesConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  DateUtils,
  NullableWrappersUnit in '..\src\NullableWrappersUnit.pas',
  NullablesUnit in '..\src\NullablesUnit.pas',
  DataSetHelperUnit in '..\src\DataSetHelperUnit.pas',
  BaseTypesUnit in '..\src\BaseTypesUnit.pas',
  FormatSettingsHelperUnit in '..\src\FormatSettingsHelperUnit.pas',
  UnconstrainedGenericNullableUnit in '..\src\UnconstrainedGenericNullableUnit.pas',
  GenericNullableUnit in '..\src\GenericNullableUnit.pas',
  LoggerUnit in '..\src\LoggerUnit.pas',
  ReporterUnit in '..\src\ReporterUnit.pas',
  ReportersUnit in '..\src\ReportersUnit.pas',
  LoggersUnit in '..\src\LoggersUnit.pas',
  ConsoleLoggingLogicUnit in '..\src\ConsoleLoggingLogicUnit.pas',
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas';

var
  MyFormatSettings: TFormatSettings;

type
  TLogic = class(TConsoleLoggingLogic)
  strict private
    procedure LogWeekDays;
  public
    procedure Go; overload; override;
  end;

procedure TLogic.Go;
begin
  TFormatSettings.LocaleID := $0413; // nl-nl  Nederlands - Nederland
  LogWeekDays;
  TFormatSettings.LocaleID := $0413; // nl-nl  Nederlands - Nederland
  LogWeekDays;
end;

procedure TLogic.LogWeekDays;
var
  NullableDateTime: TNullableDateTime;
begin
  NullableDateTime.Value := EncodeDate(2008, 09, 21);
  Logger.Log('Zondag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 22);
  Logger.Log('Maandag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 23);
  Logger.Log('Dinsdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 24);
  Logger.Log('Woensdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 25);
  Logger.Log('Donderdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 26);
  Logger.Log('Vrijdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 09, 27);
  Logger.Log('Zaterdag', NullableDateTime.ToLongDayName());
end;

begin
  try
    TLogic.Run(TLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
