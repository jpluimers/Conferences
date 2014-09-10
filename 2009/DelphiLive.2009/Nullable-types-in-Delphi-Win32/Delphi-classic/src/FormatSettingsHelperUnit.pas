unit FormatSettingsHelperUnit;

interface

uses
  SysUtils;

{
http://msdn.microsoft.com/en-us/library/0h88fahh(VS.85).aspx - Locale ID (LCID) Chart

0x0013 nl     Dutch                                 Dutch    Nederlands
0x0813 nl-BE  Dutch (Belgium)                       Dutch    Nederlands (België)
0x0413 nl-NL  Dutch (Netherlands)                   Dutch    Nederlands (Nederland)

0x0462 fy-NL  Frisian (Netherlands)                 Frisian  Frysk (Nederlân)

0x0007 de     German                                German   Deutsch
0x0C07 de-AT  German (Austria)                      German   Deutsch (Österreich)
0x0407 de-DE  German (Germany)                      German   Deutsch (Deutschland)
0x1407 de-LI  German (Liechtenstein)                German   Deutsch (Liechtenstein)
0x1007 de-LU  German (Luxembourg)                   German   Deutsch (Luxemburg)
0x0807 de-CH  German (Switzerland)                  German   Deutsch (Schweiz)

0x000C fr     French                                French   français
0x080C fr-BE  French (Belgium)                      French   français (Belgique)
0x0C0C fr-CA  French (Canada)                       French   français (Canada)
0x040C fr-FR  French (France)                       French   français (France)
0x140C fr-LU  French (Luxembourg)                   French   français (Luxembourg)
0x180C fr-MC  French (Principality of Monaco)       French   français (Principauté de Monaco)
0x100C fr-CH  French (Switzerland)                  French   français (Suisse)

0x0009 en     English                               English  English
0x0C09 en-AU  English (Australia)                   English  English (Australia)
0x2809 en-BZ  English (Belize)                      English  English (Belize)
0x1009 en-CA  English (Canada)                      English  English (Canada)
0x2409 en-029 English (Caribbean)                   English  English (Caribbean)
0x4009 en-IN  English (India)                       English  English (India)
0x1809 en-IE  English (Ireland)                     English  English (Eire)
0x2009 en-JM  English (Jamaica)                     English  English (Jamaica)
0x4409 en-MY  English (Malaysia)                    English  English (Malaysia)
0x1409 en-NZ  English (New Zealand)                 English  English (New Zealand)
0x3409 en-PH  English (Republic of the Philippines) English  English (Philippines)
0x4809 en-SG  English (Singapore)                   English  English (Singapore)
0x1C09 en-ZA  English (South Africa)                English  English (South Africa)
0x2C09 en-TT  English (Trinidad and Tobago)         English  English (Trinidad y Tobago)
0x0809 en-GB  English (United Kingdom)              English  English (United Kingdom)
0x0409 en-US  English (United States)               English  English (United States)
0x3009 en-ZW  English (Zimbabwe)                    English  English (Zimbabwe)

http://msdn.microsoft.com/en-us/library/ms776260.aspx - Locale Identifier Constants and Strings
http://www.microsoft.com/globaldev/nlsweb/default.mspx - NLS information page

}

type
  TFormatSettingsHelper = record helper for TFormatSettings
    protected
  class function GetLocaleID: Integer; static;
    class procedure SetLocaleID(const Value: Integer); static;
  public
    class function GetDefaultFormatSettings: TFormatSettings; static;
    class function GetDayNameIndex(const WeekDay: Integer): Integer; static;
    class property LocaleID: Integer read GetLocaleID write SetLocaleID;
  end;

const
  //  sMPlus = '+'; // m-plus for use as Dioptre plus sign
  //  sMDash = '—'; // m-dash for use as Dioptre minus sign -- let op: zit niet in alle fonts (wel in Tahoma)
  sNPlus = '+'; // n-plus for use as Dioptre plus sign
  sNDash = '–'; // n-dash for use as Dioptre minus sign -- let op: zit niet in alle fonts (wel in Tahoma)
  sMinus = '-'; // minus for parsing a Dioptre minus sign

implementation

uses
  Windows, DateUtils;

var
  FCurrentLocaleId: Integer = -1;

class function TFormatSettingsHelper.GetDefaultFormatSettings: TFormatSettings;
var
  NewFormatSettings: TFormatSettings;
begin
  GetLocaleFormatSettings(LocaleId, NewFormatSettings);
  NewFormatSettings.DecimalSeparator := ',';
  NewFormatSettings.DateSeparator := '-';
  NewFormatSettings.ShortDateFormat := 'dd-mm-yyyy';
  NewFormatSettings.LongTimeFormat := 'hh:mm'; // Result.ShortTimeFormat;  // h:mm
  Result := NewFormatSettings;
end;

class function TFormatSettingsHelper.GetDayNameIndex(const WeekDay: Integer): Integer;
begin
  if WeekDay in [DayMonday..DaySaturday] then
    Result := 1 + WeekDay
  else
    Result := 1;
end;

class function TFormatSettingsHelper.GetLocaleID: Integer;
begin
  if FCurrentLocaleId = -1 then
    FCurrentLocaleId := GetThreadLocale;
  Result := FCurrentLocaleId;
end;

class procedure TFormatSettingsHelper.SetLocaleID(const Value: Integer);
begin
  FCurrentLocaleId := Value;
  SetThreadLocale(Value);
end;

end.

