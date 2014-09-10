program NullableTypesConsoleProject;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  DateUtils,
  NullableWrappersUnit in '..\src\NullableWrappersUnit.pas',
  NullablesUnit in '..\src\NullablesUnit.pas',
  MathUnit in '..\src\MathUnit.pas',
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
  RecordTypeInfoUnit in '..\src\RecordTypeInfoUnit.pas',
  EnumTypeInfoUnit in '..\src\EnumTypeInfoUnit.pas';

var
  MyFormatSettings: TFormatSettings;

type
  TLogic = class(TConsoleLoggingLogic)
  strict private
    procedure LogWeekDays;
    procedure ShowNullableInteger;
    procedure ShowNullableCurrency;
    procedure ShowNullableDouble;
  private
    procedure LogSum(Right: TNullableInteger; Left: TNullableInteger); overload;
    procedure LogSum(const Right, Left: TNullableCurrency); overload;
    procedure LogSum2(Right, Left: TNullableDouble);
  public
    procedure Go; overload; override;
  end;

procedure TLogic.Go;
begin
  ShowNullableInteger();
  ShowNullableCurrency();
  ShowNullableDouble();
  TFormatSettings.LocaleID := $0409; // en-us  English - Unites States
  LogWeekDays;
  TFormatSettings.LocaleID := $0413; // nl-nl  Nederlands - Nederland
  LogWeekDays;
end;

procedure TLogic.LogWeekDays;
var
  NullableDateTime: TNullableDateTime;
begin
  NullableDateTime.Clear();
  Logger.Log('cleard', NullableDateTime.ToString());
  NullableDateTime.Value := EncodeDate(2008, 12, 21);
  Logger.Log('Zondag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 22);
  Logger.Log('Maandag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 23);
  Logger.Log('Dinsdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 24);
  Logger.Log('Woensdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 25);
  Logger.Log('Donderdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 26);
  Logger.Log('Vrijdag', NullableDateTime.ToLongDayName());
  NullableDateTime.Value := EncodeDate(2008, 12, 27);
  Logger.Log('Zaterdag', NullableDateTime.ToLongDayName());
end;

procedure TLogic.ShowNullableInteger;
var
  Left: TNullableInteger;
  Right: TNullableInteger;
  Sum: TNullableInteger;
begin
  Left.Clear();
  Right.Clear();
  LogSum(Left, Right);
  Left := 4;
  LogSum(Left, Right);
  Right := 5;
  LogSum(Left, Right);
end;

procedure TLogic.LogSum(Right: TNullableInteger; Left: TNullableInteger);
var
  Sum: TNullableInteger;
begin
  Sum := Right + Left;
  Logger.Log('Sum:', Format('"%s" + "%s" = "%s"', [Left.ToString, Right.ToString, Sum.ToString]));
end;

procedure TLogic.LogSum(const Right, Left: TNullableCurrency);
var
  Sum: TNullableCurrency;
begin
  Sum := Right + Left;
  Logger.Log('Sum:', Format('"%s" + "%s" = "%s"', [Left.ToString, Right.ToString, Sum.ToString]));
end;

procedure TLogic.LogSum2(Right, Left: TNullableDouble);
var
  Sum: TNullableDouble;
begin
  Sum := Right + Left;
  Logger.Log('Sum:', Format('"%s" + "%s" = "%s"', [Left.ToString, Right.ToString, Sum.ToString]));
end;

procedure TLogic.ShowNullableCurrency;
var
  Left: TNullableCurrency;
  Right: TNullableCurrency;
  Sum: TNullableCurrency;
begin
  Left.Clear();
  Right.Clear();
  LogSum(Left, Right);
  Left := 4;
  LogSum(Left, Right);
  Right := 5;
  LogSum(Left, Right);
end;

procedure TLogic.ShowNullableDouble;
var
  Left: TNullableDouble;
  Right: TNullableDouble;
  Sum: TNullableDouble;
begin
  Left.Clear();
  Right.Clear();
  LogSum2(Left, Right);
  Left := 4;
  LogSum2(Left, Right);
  Right := 5;
  LogSum2(Left, Right);
end;

begin
  try
    TLogic.Run(TLogic);
  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;
end.
