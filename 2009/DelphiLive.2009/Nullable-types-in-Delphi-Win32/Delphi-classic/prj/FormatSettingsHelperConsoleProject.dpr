program FormatSettingsHelperConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  FormatSettingsHelperUnit in '..\src\FormatSettingsHelperUnit.pas',
  LoggerUnit in '..\src\LoggerUnit.pas',
  ReportersUnit in '..\src\ReportersUnit.pas',
  ReporterUnit in '..\src\ReporterUnit.pas',
  LoggersUnit in '..\src\LoggersUnit.pas',
  ConsoleLoggingLogicUnit in '..\src\ConsoleLoggingLogicUnit.pas',
  DateUtils,
  SetTypeInfoUnit in '..\src\SetTypeInfoUnit.pas',
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas',
  EnumTypeInfoUnit in '..\src\EnumTypeInfoUnit.pas';

type
  TFormatSettingsHelperLogic = class(TConsoleLoggingLogic)
  strict private
    procedure LogDefaultFormatSettings;
  public
    procedure Go; override;
  end;

procedure TFormatSettingsHelperLogic.LogDefaultFormatSettings;
var
  MyFormatSettings: TFormatSettings;
  SundayShortDayName: string;
begin
  MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
  SundayShortDayName := MyFormatSettings.ShortDayNames[TFormatSettings.GetDayNameIndex(DayMonday)];
  Logger.LogMulti('ShortMonthNames', MyFormatSettings.ShortMonthNames);
  Logger.LogMulti('LongMonthNames', MyFormatSettings.LongMonthNames);
  Logger.LogMulti('ShortDayNames', MyFormatSettings.ShortDayNames);
  Logger.LogMulti('LongDayNames', MyFormatSettings.LongDayNames);
  Logger.Log('CurrencyFormat', MyFormatSettings.CurrencyFormat);
  Logger.Log('NegCurrFormat', MyFormatSettings.NegCurrFormat);
  Logger.Log('ThousandSeparator', MyFormatSettings.ThousandSeparator);
  Logger.Log('DecimalSeparator', MyFormatSettings.DecimalSeparator);
  Logger.Log('CurrencyDecimals', MyFormatSettings.CurrencyDecimals);
  Logger.Log('DateSeparator', MyFormatSettings.DateSeparator);
  Logger.Log('TimeSeparator', MyFormatSettings.TimeSeparator);
  Logger.Log('ListSeparator', MyFormatSettings.ListSeparator);
  Logger.Log('CurrencyString', MyFormatSettings.CurrencyString);
  Logger.Log('ShortDateFormat', MyFormatSettings.ShortDateFormat);
  Logger.Log('LongDateFormat', MyFormatSettings.LongDateFormat);
  Logger.Log('TimeAMString', MyFormatSettings.TimeAMString);
  Logger.Log('TimePMString', MyFormatSettings.TimePMString);
  Logger.Log('ShortTimeFormat', MyFormatSettings.ShortTimeFormat);
  Logger.Log('LongTimeFormat', MyFormatSettings.LongTimeFormat);
  Logger.Log('TwoDigitYearCenturyWindow', MyFormatSettings.TwoDigitYearCenturyWindow);
end;

procedure TFormatSettingsHelperLogic.Go;
begin
  TFormatSettings.LocaleID := $0013; // nl     Nederlands
  LogDefaultFormatSettings;
  TFormatSettings.LocaleID := $0413; // nl-nl  Nederlands - Nederland
  LogDefaultFormatSettings;
  TFormatSettings.LocaleID := $0813; // nl-be  Nederlands - België
  LogDefaultFormatSettings;
  TFormatSettings.LocaleID := $0409; // en-us  English - United States
  LogDefaultFormatSettings;
  TFormatSettings.LocaleID := $0462; // fr-nl  Frysk - Nederlân
  LogDefaultFormatSettings;
end;

begin
  try
    TFormatSettingsHelperLogic.Run(TFormatSettingsHelperLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
