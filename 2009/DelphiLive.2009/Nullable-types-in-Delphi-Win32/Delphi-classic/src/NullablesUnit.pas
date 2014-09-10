unit NullablesUnit;

interface

uses
  Controls, // TDate, TTime
  SysUtils,
  BaseTypesUnit;

type
  TDateTimeFormat = (dtfDateOnly, dtfTimeOnly, dtfDateTime);

  ENullable = class(EBaseException);

  TNullableDateTime = record
  strict private
    FIsFilled: Boolean;
    FValue: TDateTime;
    function GetIsNull: Boolean;
    procedure SetIsNull(const Value: Boolean);
    procedure SetValue(const Value: TDateTime);
    procedure SetIsFilled(const Value: Boolean);
  public
    procedure Clear;
    class function DateTimeToStr(aDateTime: TDateTime; IncludeSecs: Boolean = False; IncludeMSecs: Boolean = False): string; static;
    class function DateToStr(const Date: TDate): string; static;
    class function Compare(a, b: TNullableDateTime): Integer; static;
    class function FillableDateToStr(fdt: TNullableDateTime): string; static;
    function ToDateString: string;
    class function Null: TNullableDateTime; static;
    function IncYear(const ANumberOfYears: Integer = 1): TNullableDateTime;
    //##jpl: convert to Create Constructor?
    class function Parse(const Value: string; const FormatSettings: TFormatSettings): TNullableDateTime; static;
    class function TimeToStr(aTime: TTime; IncludeSecs: Boolean = False; IncludeMSecs: Boolean = False): string; static;
    function ToLongDayName: WideString;
    function ToString(const aIncludeSec: Boolean = False; const aIncludeMSec: Boolean = False): string; overload;
    function ToString(const FormatSettings: TFormatSettings; const DateTimeFormat: TDateTimeFormat): string; overload;
    function ToTimeString: string;
    function YearOf: Word;
    class operator Implicit(aValue: TDateTime): TNullableDateTime; overload;
    class operator Implicit(aValue: Variant): TNullableDateTime; overload;
    class operator NotEqual(a, b: TNullableDateTime): Boolean;
    //    procedure Clear; //jpl: not yet needed
    property IsFilled: Boolean read FIsFilled write SetIsFilled;
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: TDateTime read FValue write SetValue;
  end;

  TNullableDateSpanFormat = (ndsfYearMonthDay, ndsfYearMonth, ndsfYear);

  /// Partially borrowed from
  /// http://www.programmersheaven.com/download/36809/0/ZipView.aspx
  /// depends on TNullableDateTime
  TNullableDateSpan = record
  strict private
    FDays: Integer;
    FIsFilled: Boolean;
    FIsNegative: Boolean;
    FMonths: Integer;
    FRunningDate: TDateTime;
    FRunningDateDay: Word;
    FRunningDateMonth: Word;
    FRunningDateYear: Word;
    FYears: Integer;
    function GetDays: Integer;
    function GetIsNegative: Boolean;
    function GetIsNull: Boolean;
    function GetMonths: Integer;
    function GetYears: Integer;
    procedure SetRunningDate(const Value: TDateTime);
    property RunningDate: TDateTime read FRunningDate write SetRunningDate;
  public
    constructor Create(FromDate: TDateTime; ToDate: TDateTime); overload;
    constructor Create(FromDate: TNullableDateTime; ToDate: TNullableDateTime); overload;
    function ToString(const SkipZeroFields: Boolean = True; const DateSpanFormat: TNullableDateSpanFormat = ndsfYearMonthDay): string; overload;
    property Days: Integer read GetDays;
    property IsFilled: Boolean read FIsFilled;
    property IsNegative: Boolean read GetIsNegative;
    property IsNull: Boolean read GetIsNull;
    property Months: Integer read GetMonths;
    property Years: Integer read GetYears;
  end;

  TNullableInteger = record
  strict private
    //1 Trick to force RTTI for a record (as per Barry Kelly)
    FForceRTTI: string;
    FIsFilled: Boolean;
    FValue: Integer;
    function GetIsNull: Boolean;
    procedure SetIsFilled(const Value: Boolean);
    procedure SetIsNull(const Value: Boolean);
    procedure SetValue(const Value: Integer);
  public
    procedure Assign(aFillableInt: TNullableInteger);
    procedure Clear;
    class function Compare(a, b: TNullableInteger): Integer; static;
    class function Null: TNullableInteger; static;
    //##jpl: convert to Create Constructor?
    class function Parse(const Value: string): TNullableInteger; static;
    function ToPadded16Hex: string;
    function ToString: string;
    class operator Add(const a, b: TNullableInteger): TNullableInteger;
    class operator Equal(const a, b: TNullableInteger): Boolean;
    class operator Explicit(const a: Variant): TNullableInteger; overload;
    class operator GreaterThan(const a, b: TNullableInteger): Boolean;
    class operator GreaterThanOrEqual(const a, b: TNullableInteger): Boolean;
    class operator Implicit(const a: Cardinal): TNullableInteger; overload;
    class operator Implicit(const a: Integer): TNullableInteger; overload;
    class operator Implicit(const a: Word): TNullableInteger; overload;
    class operator LessThan(const a, b: TNullableInteger): Boolean;
    class operator LessThanOrEqual(const a, b: TNullableInteger): Boolean;
    class operator NotEqual(const a, b: TNullableInteger): Boolean;
    class operator Subtract(const a, b: TNullableInteger): TNullableInteger;
    property IsFilled: Boolean read FIsFilled write SetIsFilled;
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: Integer read FValue write SetValue;
  end;

  /// Voor operator overloading zie:
  /// ms-help://borland.bds5/devcommon/operatoroverloads_xml.html
  ///  Depends on TNullableInteger;
  TNullableDouble = record
  strict private
    FIsFilled: Boolean;
    FValue: Double;
    function GetIsNull: Boolean;
    procedure SetIsFilled(const Value: Boolean);
    procedure SetIsNull(const Value: Boolean);
    procedure SetValue(const Value: Double);
  public
    //##jpl: convert to Create Constructor?
    constructor Create(const aValue: string; const Sign: char = #0);
    function AsVariant: Variant;
    procedure Clear;
    // returns positive value if a > b, negative if a < b, and zero if both are equal
    // empty value is always consider "smaller" then any filled value
    class function Compare(a, b: TNullableDouble): Integer; static;
    class function DoubleToFormattedString(Value: Double; Digits: Integer = 2; ExplicitPlus: Boolean = False): string; overload; static;
    class function DoubleToFormattedString(Value: Double; Digits: Integer; AFormatSettings: TFormatSettings): string; overload; static;
    class function From2DigitsScaledInteger(const I: Integer): TNullableDouble; static;
    class function Null: TNullableDouble; static;
    //##jpl: convert to Create Constructor?
    class function Parse(const s: string; const Sign: char = #0): TNullableDouble; overload; static;
    //##jpl: convert to Create Constructor?
    class function Parse(const s: string; const Sign: string): TNullableDouble; overload; static;
    //##jpl: convert to Create Constructor?
    class function Parse(const s: string; const FormatSettings: TFormatSettings): TNullableDouble; overload; static;
    function RoundToQuarters: TNullableDouble;
    procedure SetFilledAndZeroedIfEmpty;
    function ToSignedString(aDigits: Integer = 2): string;
    function ToString(const ADigits: Integer = 2; aExplicitPlus: Boolean = False): string; overload;
    function ToString(FormatSettings: TFormatSettings): string; overload;
    function ToStringAndSign(out aSign: Char; Digits: Integer = 2): string;
    class operator Add(a, b: TNullableDouble): TNullableDouble;
    class operator Divide(a, b: TNullableDouble): TNullableDouble;
    class operator Equal(a, b: TNullableDouble): Boolean;
    class operator Explicit(Value: string): TNullableDouble; overload;
    class operator Explicit(aValue: Variant): TNullableDouble; overload;
    //##jpl: add Implicit or Explicit assignment operators
    // See http://www.excastle.com/blog/archive/2005/11/08/2531.aspx
    class operator Explicit(const a: TNullableDouble): TNullableInteger; overload;
    class operator GreaterThan(A, B: TNullableDouble): Boolean;
    class operator GreaterThanOrEqual(A, B: TNullableDouble): Boolean;
    class operator Implicit(aValue: Double): TNullableDouble; overload;
    class operator Implicit(aValue: Integer): TNullableDouble; overload;
    class operator Implicit(aValue: TNullableInteger): TNullableDouble; overload;
    class operator LessThan(A, B: TNullableDouble): Boolean;
    class operator LessThanOrEqual(A, B: TNullableDouble): Boolean;
    class operator Multiply(a, b: TNullableDouble): TNullableDouble;
    class operator Negative(a: TNullableDouble): TNullableDouble;
    class operator NotEqual(a, b: TNullableDouble): Boolean;
    class operator Positive(A: TNullableDouble): TNullableDouble;
    class operator Subtract(a, b: TNullableDouble): TNullableDouble;
    property IsFilled: Boolean read FIsFilled write SetIsFilled; //##jpl: SetIsFilled can be removed when we are doing D2007
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Value: Double read FValue write SetValue;
  end;

  TNullableCurrency = record
  strict private
    FIsFilled: Boolean;
    FValue: Currency;
    class function DoubleToWindowsCurrencyString(Value: Double; Digits: Integer): string; overload; static;
    function GetIsNull: Boolean;
    function GetIsZeroOrEmpty: Boolean;
    procedure SetIsFilled(const Value: Boolean);
    procedure SetIsNull(const Value: Boolean);
    procedure SetValue(const Value: Currency);
  public
    procedure Clear;
    // returns positive value if a > b, negative if a < b, and zero if both are equal
    // empty value is always consider "smaller" then any filled value
    class function Compare(const a, b: TNullableCurrency): Integer; static;
    class function CurrencyToFormattedString(Value: Currency; Digits: Integer = 2):
      string; overload; static;
    class function CurrencyToFormattedString(Value: Currency; Digits: Integer;
      AFormatSettings: TFormatSettings): string; overload; static;
    class function Null: TNullableCurrency; static;
    //##jpl: convert to Create Constructor?
    class function Parse(const Value: string): TNullableCurrency; static;
    function ToCurrencyString(const Digits: Cardinal = 2): string;
    function ToPadded16Hex: string;
    function ToString(const Digits: Cardinal = 2): string; overload;
    function ToString(FormatSettings: TFormatSettings): string; overload;
    class operator Add(const A, B: TNullableCurrency): TNullableCurrency;
    class operator Divide(const A, B: TNullableCurrency): TNullableCurrency;
    class operator Equal(a, b: TNullableCurrency): Boolean;
    //##jpl: add Implicit or Explicit assignment operators
    // See http://www.excastle.com/blog/archive/2005/11/08/2531.aspx
    class operator Explicit(const aValue: Currency): TNullableCurrency; overload;
    class operator Explicit(const Value: string): TNullableCurrency;
    //##jpl: add Implicit or Explicit assignment operators
    // See http://www.excastle.com/blog/archive/2005/11/08/2531.aspx
    class operator Explicit(const a: TNullableCurrency): TNullableDouble; overload;
    class operator GreaterThan(A, B: TNullableCurrency): Boolean;
    class operator GreaterThanOrEqual(A, B: TNullableCurrency): Boolean;
    class operator Implicit(const A: Extended): TNullableCurrency;
    class operator Implicit(const A: Integer): TNullableCurrency;
    class operator Implicit(const A: TNullableDouble): TNullableCurrency;
    class operator Implicit(const A: TNullableInteger): TNullableCurrency;
    class operator LessThan(A, B: TNullableCurrency): Boolean;
    class operator LessThanOrEqual(A, B: TNullableCurrency): Boolean;
    class operator Multiply(const A, B: TNullableCurrency): TNullableCurrency;
    class operator Negative(a: TNullableCurrency): TNullableCurrency;
    class operator NotEqual(a, b: TNullableCurrency): Boolean;
    class operator Positive(A: TNullableCurrency): TNullableCurrency;
    class operator Subtract(const A, B: TNullableCurrency): TNullableCurrency;
    property IsFilled: Boolean read FIsFilled write SetIsFilled;
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property IsZeroOrEmpty: Boolean read GetIsZeroOrEmpty;
    property Value: Currency read FValue write SetValue;
  end;

type
  TNullableString = record
  strict private
    FIsFilled: Boolean;
    FValue: WideString;
    procedure SetValue(const Value: WideString);
  public
    procedure Clear;
    procedure Assign(const aFillableStr: TNullableString);
    property IsFilled: Boolean read FIsFilled;
    property Value: WideString read FValue write SetValue;
  end;

implementation

uses
  Variants, Math,
  DateUtils, StrUtils,
  FormatSettingsHelperUnit,
  MathUnit;

{ TNullableDateSpan }

constructor TNullableDateSpan.Create(FromDate: TDateTime; ToDate: TDateTime);
var
  FromDateYear: Word;
  FromDateMonth: Word;
  FromDateDay: Word;
  FromDateHour: Word;
  FromDateMinute: Word;
  FromDateSecond: Word;
  FromDateMilliSecond: Word;
  ToDateYear: Word;
  ToDateMonth: Word;
  ToDateDay: Word;
  ToDateHour: Word;
  ToDateMinute: Word;
  ToDateSecond: Word;
  ToDateMilliSecond: Word;
  //  RunningDate: TDateTime;
  YearsAdjusted: Boolean;
  RunningMonth: Word;
begin
  inherited;
  // DateUtils is onnauwkeurig, want gaat uit van een gemiddeld jaar (ongeveer 365.25 dagen per jaar)
  //  FYears := DateUtils.YearsBetween(ToDate, FromDate);
  //  FMonths := DateUtils.MonthsBetween(ToDate, FromDate) mod MonthsPerYear;
  //  FDays := DateUtils.DaysBetween(ToDate, FromDate)
  if FromDate > ToDate then
  begin
    FIsNegative := True;
    RunningDate := ToDate;
    ToDate := FromDate;
    FromDate := RunningDate;
  end
  else
    RunningDate := FromDate;

  // precondition: FromDate <= ToDate
  DateUtils.DecodeDateTime(FromDate, FromDateYear, FromDateMonth, FromDateDay, FromDateHour, FromDateMinute, FromDateSecond, FromDateMilliSecond);
  DateUtils.DecodeDateTime(ToDate, ToDateYear, ToDateMonth, ToDateDay, ToDateHour, ToDateMinute, ToDateSecond, ToDateMilliSecond);

  FYears := ToDateYear - FromDateYear;
  RunningDate := DateUtils.RecodeYear(FromDate, ToDateYear);

  YearsAdjusted := RunningDate > ToDate;
  if YearsAdjusted then
  begin
    Dec(FYears);
    RunningDate := DateUtils.RecodeYear(FromDate, ToDateYear - 1);
  end;

  FMonths := ToDateMonth - FromDateMonth;
  if YearsAdjusted and (FMonths < 1) then
    Inc(FMonths, 11); // 11, since months start at 1 (not at 0)

  RunningMonth := FromDateMonth + FMonths;
  RunningDate := IncMonth(RunningDate, FMonths);

  if RunningDate > ToDate then
  begin
    Dec(FMonths);
    RunningMonth := FromDateMonth + FMonths;
    RunningDate := IncMonth(RunningDate, RunningMonth);
  end;

  FDays := Round(ToDate - RunningDate);
  if FDays < 0 then
    Inc(FDays, DateUtils.DaysPerYear[False]);

  FIsFilled := True;
end;

constructor TNullableDateSpan.Create(FromDate, ToDate: TNullableDateTime);
begin
  FIsFilled := FromDate.IsFilled and ToDate.IsFilled;
  if IsFilled then
    Create(FromDate.Value, ToDate.Value);
end;

function TNullableDateSpan.GetDays: Integer;
begin
  if IsNull then
    Result := 0
  else
    Result := FDays;
end;

function TNullableDateSpan.GetIsNegative: Boolean;
begin
  if IsNull then
    Result := False
  else
    Result := FIsNegative;
end;

function TNullableDateSpan.GetIsNull: Boolean;
begin
  Result := not IsFilled;
end;

function TNullableDateSpan.GetMonths: Integer;
begin
  if IsNull then
    Result := 0
  else
    Result := FMonths;
end;

function TNullableDateSpan.GetYears: Integer;
begin
  if IsNull then
    Result := 0
  else
    Result := FYears;
end;

procedure TNullableDateSpan.SetRunningDate(const Value: TDateTime);
begin
  FRunningDate := Value;
  FRunningDateYear := YearOf(FRunningDate);
  FRunningDateMonth := MonthOf(FRunningDate);
  FRunningDateDay := DayOf(FRunningDate);
end;

function TNullableDateSpan.ToString(const SkipZeroFields: Boolean = True; const DateSpanFormat: TNullableDateSpanFormat =
  ndsfYearMonthDay): string;
  procedure AppendField(const FieldCaption: string; const Content: Integer);
  var
    Suffix: string;
  begin
    if (Content <> 0) or not SkipZeroFields then
    begin
      Suffix := Format('%d %s', [Content, FieldCaption]);
      if Result = NullAsStringValue then
        Result := Suffix
      else
        Result := Format('%s, %s', [Result, Suffix]);
    end;
  end;
begin
  Result := NullAsStringValue;
  if IsFilled then
  begin
    case DateSpanFormat of
      ndsfYearMonthDay:
        begin
          AppendField('jaar', Self.Years);
          AppendField('maanden', Self.Months);
          AppendField('dagen', Self.Days);
        end;
      ndsfYearMonth:
        begin
          AppendField('jaar', Self.Years);
          AppendField('maanden', Self.Months);
        end;
      ndsfYear:
        begin
          AppendField('jaar', Self.Years);
        end;
    end;
    if Result = NullAsStringValue then
      Result := 'nihil';
  end;
end;

{ TNullableInteger }

procedure TNullableInteger.Assign(aFillableInt: TNullableInteger);
begin
  if not aFillableInt.FIsFilled then
    Self.Value := aFillableInt.Value;
end;

procedure TNullableInteger.Clear;
begin
  FIsFilled := False;
  FValue := 0;
end;

class function TNullableInteger.Compare(a, b: TNullableInteger): Integer;
begin
  if a.IsFilled then
  begin
    if b.IsFilled then
    begin // a.IsFilled = true; b.IsFilled = true
      if a.Value > b.Value then
        Result := 1
      else
        if a.Value < b.Value then
          Result := -1
        else
          Result := 0;
    end
    else
    begin // a.IsFilled = true; b.IsFilled = false
      Result := 1; // a is greater because it is filled
    end
  end

  else
  begin
    if b.IsFilled then
    begin // a.IsFilled = false; b.IsFilled = true
      Result := -1;
    end
    else // a.IsFilled = false; b.IsFilled = false
    begin
      Result := 0;
    end
  end;
end;

function TNullableInteger.GetIsNull: Boolean;
begin
  Result := not IsFilled;
end;

class function TNullableInteger.Null: TNullableInteger;
begin
  Result.Clear;
end;

class function TNullableInteger.Parse(const Value: string): TNullableInteger;
var
  NewValue: Integer;
begin
  if TryStrToInt(Value, NewValue) then
    Result.Value := NewValue
  else
    Result.Clear();
end;

procedure TNullableInteger.SetIsFilled(const Value: Boolean);
begin
  FIsFilled := Value;
  if not IsFilled then
    Clear();
end;

procedure TNullableInteger.SetIsNull(const Value: Boolean);
begin
  IsFilled := not Value;
end;

procedure TNullableInteger.SetValue(const Value: Integer);
begin
  FValue := Value;
  FIsFilled := True;
end;

function TNullableInteger.ToPadded16Hex: string;
begin
  if not IsFilled then
    Result := ''
  else
    Result := IntToHex(Value, 16);
end;

function TNullableInteger.ToString: string;
begin
  if IsFilled then
    Result := IntToStr(Value)
  else
    Result := '';
end;

class operator TNullableInteger.Add(const a, b: TNullableInteger): TNullableInteger;
begin
  if a.IsFilled then
  begin
    if b.IsFilled then
      Result.Value := a.Value + b.Value
    else // not b.IsFilled
      Result.Value := a.Value;
  end
  else {// not a.IsFilled}
  begin
    if b.IsFilled then
      Result.Value := b.Value
    else
      Result.Clear;
  end;
end;

class operator TNullableInteger.Equal(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) = 0;
end;

class operator TNullableInteger.Explicit(const a: Variant): TNullableInteger;
begin
  if VarIsNull(a) or VarIsClear(a) then
    Result.Clear
  else
    Result.Value := a; //note: standard Variant coercion artifacts apply!
end;

class operator TNullableInteger.GreaterThan(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) > 0;
end;

class operator TNullableInteger.GreaterThanOrEqual(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) >= 0;
end;

class operator TNullableInteger.Implicit(const a: Cardinal): TNullableInteger;
begin
  Result.Value := a;
end;

class operator TNullableInteger.Implicit(const a: Integer): TNullableInteger;
begin
  Result.Value := a;
end;

class operator TNullableInteger.Implicit(const a: Word): TNullableInteger;
begin
  Result.Value := a;
end;

class operator TNullableInteger.LessThan(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) < 0;
end;

class operator TNullableInteger.LessThanOrEqual(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) <= 0;
end;

class operator TNullableInteger.NotEqual(const a, b: TNullableInteger): Boolean;
begin
  Result := Compare(a, b) <> 0;
end;

class operator TNullableInteger.Subtract(const a, b: TNullableInteger): TNullableInteger;
begin
  if a.IsFilled and b.IsFilled then
    Result.Value := a.Value - b.Value
  else // NULL
    Result.Clear();
end;

{ TNullableDouble }

constructor TNullableDouble.Create(const aValue: string; const Sign: char = #0);
var
  d: double;
  MyFormatSettings: TFormatSettings;
begin
  Self.Clear();
  if aValue <> '' then // to prevent filled value for empty string
    try
      MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
      d := SysUtils.StrToFloatDef(aValue, Self.Value, MyFormatSettings);
      Self.Value := d;
      case Sign of
        sNDash: Self.Value := -Self.Value;
        sMinus: Self.Value := -Self.Value;
      end;
    except
      on e: EConvertError do
        Self.Clear;
    end;
end;

function TNullableDouble.AsVariant: Variant;
begin
  if Self.IsNull then
    Result := Variants.Null
  else
    Result := Self.Value;
end;

procedure TNullableDouble.Clear;
begin
  FIsFilled := False;
  FValue := 0;
end;

class function TNullableDouble.Compare(a, b: TNullableDouble): Integer;
begin
  if a.IsFilled then
  begin
    if b.IsFilled then
    begin // a.IsFilled = true; b.IsFilled = true
      if a.Value > b.Value then
        Result := 1
      else
        if a.Value < b.Value then
          Result := -1
        else
          Result := 0;
    end
    else
    begin // a.IsFilled = true; b.IsFilled = false
      Result := 1; // a is greater because it is filled
    end
  end

  else //a.IsFilled = false
  begin
    if b.IsFilled then
    begin // a.IsFilled = false; b.IsFilled = true
      Result := -1;
    end
    else // a.IsFilled = false; b.IsFilled = false
    begin
      Result := 0;
    end
  end;
end;

class function TNullableDouble.DoubleToFormattedString(Value: Double; Digits: Integer = 2; ExplicitPlus: Boolean = False): string;
var
  MyFormatSettings: TFormatSettings;
begin
  //// Trick to make a Value -0:
  // var
  //   MinusZero: Double;
  //     MinusZero := 0;
  //     MinusZero := MinusZero * -1;
  //// however: this check fails, as -0 = +0 !
  //    if Value = MinusZero then ...
  MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
  Result := DoubleToFormattedString(Value, Digits, MyFormatSettings);
  if ExplicitPlus then
    case TMath.SignNoZero(Value) of
      -1:
        if Value = 0 then // all others have been done by DoubleToFormattedString
          Result := sNDash + Result;
      1:
        Result := sNPlus + Result;
    end;
  Result := ReplaceText(Result, sMinus, sNDash);
end;

class function TNullableDouble.DoubleToFormattedString(Value: Double; Digits: Integer; AFormatSettings: TFormatSettings): string;
begin
  Result := FloatToStrF(Value, ffFixed, 15, Digits, AFormatSettings);
end;

class function TNullableDouble.From2DigitsScaledInteger(const I: Integer): TNullableDouble;
begin
  Result.Value := I / 100;
end;

function TNullableDouble.GetIsNull: Boolean;
begin
  Result := not IsFilled;
end;

class function TNullableDouble.Null: TNullableDouble;
begin
  Result.Clear;
end;

class function TNullableDouble.Parse(const s: string; const Sign: char = #0): TNullableDouble;
begin
  Result := TNullableDouble.Create(s, Sign);
end;

class function TNullableDouble.Parse(const s: string; const Sign: string): TNullableDouble;
begin
  if Sign = '' then
    Result := TNullableDouble.Create(s)
  else
    if Length(Sign) = 1 then
      Result := TNullableDouble.Create(s, Sign[1])
    else
      raise ENullable.CreateFmt('TNullableDouble.Parse: invalid Sign "%s"', [Sign]);
end;

class function TNullableDouble.Parse(const s: string; const FormatSettings: TFormatSettings): TNullableDouble;
var
  TheValue: Double;
begin
  if SysUtils.TryStrToFloat(s, TheValue, FormatSettings) then
    Result.Value := TheValue
  else
    Result.Clear();
end;

function TNullableDouble.RoundToQuarters: TNullableDouble;
begin
  if Self.IsFilled then
    Result := TMath.RoundToQuarters(Self.Value)
  else // NULL
    Result.Clear();
end;

procedure TNullableDouble.SetFilledAndZeroedIfEmpty;
begin
  if not IsFilled then
    Value := 0;
end;

procedure TNullableDouble.SetIsFilled(const Value: Boolean);
begin
  FIsFilled := Value;
  if not IsFilled then
    Clear();
end;

procedure TNullableDouble.SetIsNull(const Value: Boolean);
begin
  IsFilled := not Value;
end;

procedure TNullableDouble.SetValue(const Value: Double);
begin
  FValue := Value;
  FIsFilled := True;
end;

function TNullableDouble.ToSignedString(aDigits: Integer = 2): string;
begin
  Result := ToString(aDigits, True);
end;

function TNullableDouble.ToString(const ADigits: Integer = 2; aExplicitPlus: Boolean = False):
  string;
begin
  if IsFilled then
    Result := Self.DoubleToFormattedString(Value, aDigits, aExplicitPlus)
  else
    Result := '';
end;

function TNullableDouble.ToString(FormatSettings: TFormatSettings): string;
begin
  if Self.IsFilled then
    Result := Self.DoubleToFormattedString(Self.Value,
      FormatSettings.CurrencyDecimals, FormatSettings)
  else
    Result := '';
end;

function TNullableDouble.ToStringAndSign(out aSign: Char; Digits: Integer = 2): string;
begin
  Result := '';
  aSign := sNDash;
  if IsFilled then
  begin
    Result := Self.DoubleToFormattedString(Abs(Value), Digits);
    case TMath.SignNoZero(Value) of
      NegativeValue:
        aSign := sNDash;
      PositiveValue:
        aSign := sNPlus;
    end;
  end;
end;

class operator TNullableDouble.Add(a, b: TNullableDouble): TNullableDouble;
begin
  if a.IsFilled and b.IsFilled then
    Result.Value := a.Value + b.Value
  else // NULL
    Result.Clear();
end;

class operator TNullableDouble.Divide(a, b: TNullableDouble): TNullableDouble;
begin
  if a.IsFilled and b.IsFilled then
    Result.Value := a.Value / b.Value
  else // NULL
    Result.Clear
end;

class operator TNullableDouble.Equal(a, b: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) = 0;
end;

class operator TNullableDouble.Explicit(Value: string): TNullableDouble;
begin
  Result := TNullableDouble.Parse(Value);
end;

class operator TNullableDouble.Explicit(aValue: Variant): TNullableDouble;
begin
  if VarIsNull(aValue) or VarIsClear(aValue) or VarIsEmpty(aValue) or VarIsEmptyParam(aValue) then
    Result.Clear // NULL
  else
    Result.Value := aValue;
end;

class operator TNullableDouble.Explicit(const a: TNullableDouble): TNullableInteger;
begin
  if a.IsNull then
    Result.Clear()
  else
    Result.Value := Round(a.Value); //##jpl: let op: je kunt hier precisie verliezen!!
end;

class operator TNullableDouble.GreaterThan(A, B: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) > 0;
end;

class operator TNullableDouble.GreaterThanOrEqual(A, B: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) >= 0;
end;

class operator TNullableDouble.Implicit(aValue: Double): TNullableDouble;
begin
  Result.Value := aValue;
end;

class operator TNullableDouble.Implicit(aValue: Integer): TNullableDouble;
begin
  Result.Value := aValue;
end;

class operator TNullableDouble.Implicit(aValue: TNullableInteger): TNullableDouble;
begin
  if aValue.IsFilled then
    Result := aValue.Value
  else // NULL
    Result.Clear();
end;

class operator TNullableDouble.LessThan(A, B: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) < 0;
end;

class operator TNullableDouble.LessThanOrEqual(A, B: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) <= 0;
end;

class operator TNullableDouble.Multiply(a, b: TNullableDouble): TNullableDouble;
begin
  if a.IsFilled and b.IsFilled then
    Result.Value := a.Value * b.Value
  else // NULL
    Result.Clear();
end;

class operator TNullableDouble.Negative(a: TNullableDouble): TNullableDouble;
begin
  if a.IsFilled then
    Result.Value := -a.Value
  else // NULL
    Result.Clear;
end;

class operator TNullableDouble.NotEqual(a, b: TNullableDouble): Boolean;
begin
  Result := Compare(a, b) <> 0;
end;

class operator TNullableDouble.Positive(A: TNullableDouble): TNullableDouble;
begin
  Result := A;
end;

class operator TNullableDouble.Subtract(a, b: TNullableDouble): TNullableDouble;
begin
  if a.IsFilled and b.IsFilled then
    Result.Value := a.Value - b.Value
  else // NULL
    Result.Clear();
end;

procedure TNullableCurrency.Clear;
begin
  FIsFilled := False;
  FValue := 0;
end;

class function TNullableCurrency.Compare(const a, b: TNullableCurrency): Integer;
begin
  if a.IsFilled then
  begin
    if b.IsFilled then
    begin // a.IsFilled = true; b.IsFilled = true
      if a.Value > b.Value then
        Result := 1
      else
        if a.Value < b.Value then
          Result := -1
        else
          Result := 0;
    end
    else
    begin // a.IsFilled = true; b.IsFilled = false
      Result := 1; // a is greater because it is filled
    end
  end

  else
  begin
    if b.IsFilled then
    begin // a.IsFilled = false; b.IsFilled = true
      Result := -1;
    end
    else // a.IsFilled = false; b.IsFilled = false
    begin
      Result := 0;
    end
  end;
end;

class function TNullableCurrency.CurrencyToFormattedString(
  Value: Currency;
  Digits: Integer = 2): string;
var
  MyFormatSettings: TFormatSettings;
begin
  MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
  Result := CurrencyToFormattedString(Value, Digits, MyFormatSettings);
end;

class function TNullableCurrency.CurrencyToFormattedString(Value: Currency;
  Digits: Integer; AFormatSettings: TFormatSettings): string;
begin
  Result := CurrToStrF(Value, ffCurrency, Digits, AFormatSettings);
end;

class function TNullableCurrency.DoubleToWindowsCurrencyString(
  Value: Double;
  Digits: Integer): string;
begin
  Result := FloatToStrF(Value, ffCurrency, 15, Digits);
end;

function TNullableCurrency.GetIsNull: Boolean;
begin
  Result := not IsFilled;
end;

function TNullableCurrency.GetIsZeroOrEmpty: Boolean;
begin
  Result := not IsFilled;

  if IsFilled then
    Result := (Value = 0);
end;

class function TNullableCurrency.Null: TNullableCurrency;
begin //##jpl: remove, and replace callsites by TFillableCurrency.Clear
  Result.Clear;
end;

class function TNullableCurrency.Parse(const Value: string): TNullableCurrency;
var
  x: extended;
//  aPos: Integer;
//  aFormatSettings: TFormatSettings;
//  s: string;
begin
  Result.Clear();

  if (Value <> '') then
  begin
    try
      x := StrToCurr(Value);
      Result.Value := x;
    except
      Result.Clear;
    end; // try except
//##evk copy van NullableDouble.Parse werkt niet met een currency-sign !??
//    aFormatSettings := GetD
//    s := Value;
//    aPos := Pos('.', s);
//    if aPos > 0 then
//      s := StringReplace(s, '.', ',', []);
//
//    try
//      x := StrToFloat(s, aFormatSettings);
//      Result.Value := x;
//    except
//      Result.Clear;
//    end;
  end; // if Value <> ''
end;

procedure TNullableCurrency.SetIsFilled(const Value: Boolean);
begin
  FIsFilled := Value;
  if not IsFilled then
    Clear();
end;

procedure TNullableCurrency.SetIsNull(const Value: Boolean);
begin
  IsFilled := not Value;
end;

procedure TNullableCurrency.SetValue(const Value: Currency);
begin
  Self.FValue := Value;
  Self.FIsFilled := True;
end;

function TNullableCurrency.ToCurrencyString(const Digits: Cardinal = 2): string;
begin
  if isFilled then
    Result := Self.DoubleToWindowsCurrencyString(Value, Digits)
  else
    Result := '';
end;

function TNullableCurrency.ToPadded16Hex: string;
var
  x: int64;
  a: extended;
begin
  if not IsFilled then
    Result := ''
  else
  begin
    a := Value * 10000;
    x := round(a);
    Result := IntToHex(x, 16);
  end;
end;

function TNullableCurrency.ToString(const Digits: Cardinal = 2): string;
begin
  if IsFilled then
    Result := CurrencyToFormattedString(Value, Digits)
  else
    Result := '';
end;

function TNullableCurrency.ToString(FormatSettings: TFormatSettings): string;
begin
  if Self.IsFilled then
    Result := Self.CurrencyToFormattedString(Self.Value,
      FormatSettings.CurrencyDecimals, FormatSettings)
  else
    Result := '';
end;

{ TFillableCurrency }

class operator TNullableCurrency.Add(const A, B: TNullableCurrency): TNullableCurrency;
begin
  if A.IsFilled or B.IsFilled then
    Result.Value := A.Value + B.Value
  else // both are NULL so return NULL
    Result.Clear();
end;

class operator TNullableCurrency.Divide(const A, B: TNullableCurrency):
  TNullableCurrency;
begin
  if A.IsFilled or B.IsFilled then
    Result.Value := A.Value / B.Value
  else // both are NULL so return NULL
    Result.Clear();
end;

class operator TNullableCurrency.Equal(a, b: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) = 0;
end;

class operator TNullableCurrency.Explicit(
  const aValue: Currency): TNullableCurrency;
begin
  Result.Value := aValue;
end;

class operator TNullableCurrency.Explicit(const Value: string): TNullableCurrency;
begin
  Result := TNullableCurrency.Parse(Value);
end;

class operator TNullableCurrency.Explicit(const a: TNullableCurrency): TNullableDouble;
begin
  if a.IsNull then
    Result.Clear()
  else
    Result.Value := a.Value; //##jpl: let op: je kunt hier precisie verliezen!!
end;

class operator TNullableCurrency.GreaterThan(A, B: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) > 0;
end;

class operator TNullableCurrency.GreaterThanOrEqual(A, B: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) >= 0;
end;

class operator TNullableCurrency.Implicit(const A: Extended): TNullableCurrency;
begin
  Result.Value := A;
end;

class operator TNullableCurrency.Implicit(const A: Integer): TNullableCurrency;
begin
  Result.Value := A;
end;

class operator TNullableCurrency.Implicit(const A: TNullableDouble): TNullableCurrency;
begin
  if A.IsNull then
    Result.Clear
  else
    Result.Value := A.Value;
end;

class operator TNullableCurrency.Implicit(const A: TNullableInteger): TNullableCurrency;
begin
  if A.IsNull then
    Result.Clear
  else
    Result.Value := A.Value;
end;

class operator TNullableCurrency.LessThan(A, B: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) < 0;
end;

class operator TNullableCurrency.LessThanOrEqual(A, B: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) <= 0;
end;

class operator TNullableCurrency.Multiply(const A, B: TNullableCurrency):
  TNullableCurrency;
begin
  if A.IsFilled or B.IsFilled then
    Result.Value := A.Value * B.Value
  else // both are NULL so return NULL
    Result.Clear();
end;

class operator TNullableCurrency.Negative(a: TNullableCurrency): TNullableCurrency;
begin
  if a.IsFilled then
    Result.Value := -a.Value
  else // NULL
    Result.Clear;
end;

class operator TNullableCurrency.NotEqual(a, b: TNullableCurrency): Boolean;
begin
  Result := Compare(a, b) <> 0;
end;

class operator TNullableCurrency.Positive(A: TNullableCurrency): TNullableCurrency;
begin
  Result := A;
end;

class operator TNullableCurrency.Subtract(const A, B: TNullableCurrency): TNullableCurrency;
begin
  if A.IsFilled or B.IsFilled then
    Result.Value := A.Value - B.Value
  else // both are NULL so return NULL
    Result.Clear();
end;

{ TNullableDateTime }

procedure TNullableDateTime.Clear;
begin
  FIsFilled := False;
end;

class function TNullableDateTime.Compare(a, b: TNullableDateTime): Integer;
begin
  if a.IsFilled then
  begin
    if b.IsFilled then
    begin // a.IsFilled = true; b.IsFilled = true
      if a.Value > b.Value then
        Result := 1
      else
        if a.Value < b.Value then
          Result := -1
        else
          Result := 0;
    end
    else
    begin // a.IsFilled = true; b.IsFilled = false
      Result := 1; // a is greater because it is filled
    end
  end

  else //a.IsFilled = false
  begin
    if b.IsFilled then
    begin // a.IsFilled = false; b.IsFilled = true
      Result := -1;
    end
    else // a.IsFilled = false; b.IsFilled = false
    begin
      Result := 0;
    end
  end;
end;

class function TNullableDateTime.DateTimeToStr(aDateTime: TDateTime; IncludeSecs: Boolean = False; IncludeMSecs: Boolean = False): string;
begin
  Result :=
    TNullableDateTime.DateToStr(aDateTime) + '  ' +
    TNullableDateTime.TimeToStr(aDateTime, IncludeSecs, IncludeMSecs);
end;

class function TNullableDateTime.DateToStr(const Date: TDate): string;
var
  years, months, days: Word;
begin
  DecodeDate(Date, years, months, days);
  Result := Format('%2.2d-%2.2d-%4.4d', [days, months, years]);
end;

class function TNullableDateTime.FillableDateToStr(fdt: TNullableDateTime): string;
begin //##jpl: moved to TNullableDateTime.ToDateString
  if fdt.IsFilled then
    Result := DateToStr(fdt.Value)
  else
    Result := '';
end;

function TNullableDateTime.ToDateString: string;
begin
  if IsFilled then
    Result := DateToStr(Value)
  else
    Result := '';
end;

class function TNullableDateTime.Null: TNullableDateTime;
begin //##jpl: not needed, replace callsites with call to Clear
  Result.Clear;
end;

function TNullableDateTime.GetIsNull: Boolean;
begin
  Result := not IsFilled;
end;

function TNullableDateTime.IncYear(
  const ANumberOfYears: Integer): TNullableDateTime;
begin
  if IsFilled then
  begin
    Result := DateUtils.IncYear(Value, ANumberOfYears);
  end // if IsFilled
  else
    Result.Clear;
end;

class function TNullableDateTime.Parse(const Value: string; const FormatSettings: TFormatSettings): TNullableDateTime;
begin
  Result.Clear();
  if Value <> '' then
    Result.Value := StrToDateTime(Value, FormatSettings);
end;

procedure TNullableDateTime.SetIsFilled(const Value: Boolean);
begin
  FIsFilled := Value;
  if not IsFilled then
    Clear();
end;

procedure TNullableDateTime.SetIsNull(const Value: Boolean);
begin
  IsFilled := not Value;
end;

procedure TNullableDateTime.SetValue(const Value: TDateTime);
begin
  FValue := Value;
  FIsFilled := True;
end;

class function TNullableDateTime.TimeToStr(aTime: TTime; IncludeSecs: Boolean = False; IncludeMSecs: Boolean = False): string;
var
  MyFormatSettings: TFormatSettings;
  Hours: Word;
  Minutes: Word;
  Seconds: Word;
  Milliseconds: Word;
begin
  MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
  DecodeTime(aTime, Hours, Minutes, Seconds, Milliseconds);
  Result := Format('%2.2d%s%2.2d', [Hours, MyFormatSettings.TimeSeparator, Minutes],
    MyFormatSettings);

  if IncludeSecs then
    Result := Format('%s%s%2.2d', [Result, MyFormatSettings.TimeSeparator, Seconds],
      MyFormatSettings);

  if IncludeMSecs then
    Result := Format('%s%s%2.2d', [Result, MyFormatSettings.TimeSeparator, Milliseconds],
      MyFormatSettings);
end;

function TNullableDateTime.ToLongDayName: WideString;
var
  WeekDay: Integer;
  DayNameIndex: Integer;
  MyFormatSettings: TFormatSettings;
begin
  if IsFilled then
  begin
    WeekDay := DayOfTheWeek(Value);
    DayNameIndex := TFormatSettings.GetDayNameIndex(WeekDay);
    MyFormatSettings := TFormatSettings.GetDefaultFormatSettings();
    Result := MyFormatSettings.LongDayNames[DayNameIndex];
  end
  else
    Result := NullAsStringValue;
end;

function TNullableDateTime.ToString(const aIncludeSec: Boolean = False; const aIncludeMSec: Boolean = False): string;
begin
  if IsFilled then
    Result := Self.DateTimeToStr(Value, aIncludeSec, aIncludeMSec)
      //    Result := TConvUtils.DateToStr(Value) + '  ' + TConvUtils.TimeToStr(Value, aIncludeSec, aIncludeMSec)
  else
    Result := '';
end;

function TNullableDateTime.ToString(const FormatSettings: TFormatSettings; const DateTimeFormat: TDateTimeFormat): string;
begin
  if IsFilled then
  begin
    case DateTimeFormat of
      dtfDateOnly:
        Result := SysUtils.DateToStr(Value, FormatSettings);
      dtfTimeOnly:
        Result := SysUtils.TimeToStr(Value, FormatSettings);
    else
      Result := SysUtils.DateTimeToStr(Value, FormatSettings);
    end;
  end
  else
    Result := '';
end;

function TNullableDateTime.ToTimeString: string;
begin
  if IsFilled then
    Result := TimeToStr(Value)
  else
    Result := '';
end;

function TNullableDateTime.YearOf: Word;
begin
  Result := 0;

  if IsFilled then
  begin
    Result := DateUtils.YearOf(Value);
  end; // if IsFilled
end;

class operator TNullableDateTime.Implicit(aValue: TDateTime): TNullableDateTime;
begin
  Result.Value := aValue;
end;

class operator TNullableDateTime.Implicit(aValue: Variant): TNullableDateTime;
begin
  if VarIsNull(aValue) or VarIsClear(aValue) or VarIsEmpty(aValue) or VarIsEmptyParam(aValue) then
    Result.Clear // NULL
  else
    Result.Value := aValue;
end;

class operator TNullableDateTime.NotEqual(a, b: TNullableDateTime): Boolean;
begin
  Result := Compare(a, b) <> 0;
end;

{ TFillableStr }

procedure TNullableString.Assign(const aFillableStr: TNullableString);
begin
  //  if NOT aFillableStr.FIsFilled then
  Self.Value := aFillableStr.Value;
end;

procedure TNullableString.Clear;
begin
  FIsFilled := False;
  FValue := '';
end;

procedure TNullableString.SetValue(const Value: WideString);
begin
  FValue := Value;
  FIsFilled := True;
end;

end.

