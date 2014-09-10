unit LoggerUnit;

interface

uses
  SysUtils, ReporterUnit, TypInfo;

type
  TLogReportEvent = procedure(const Line: string) of object;

  TStringArray = array of string;

  TLogger = class abstract(TObject)
  strict private
    FOnReport: TLogReportEvent;
  strict protected
    constructor Create(const OnLog: TLogReportEvent);
    property OnReport: TLogReportEvent read FOnReport write FOnReport;
  protected
    procedure Report(const Line: string); overload; virtual;
  public
    procedure LogMulti(const Description: string; const Items: array of string); overload; virtual;
    procedure Log(const Description: string; const Item: string); overload; virtual;
    procedure Log(const Description: string; const Item: Integer); overload; virtual;
    procedure Log(const Line: string); overload; virtual;
    procedure Log(const FormatMask: string; const Arguments: array of const); overload; virtual;
    procedure Log(const FormatMask: string; const Arguments: array of const; const FormatSettings: TFormatSettings);
        overload; virtual;
    procedure Log(const Description: string; const TypeInfo: PTypeInfo; const Value: Integer); overload; virtual;
    procedure Log(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = ''); overload; virtual;
    procedure Log(const Description: string; const Index: Integer; const Item: Integer); overload; virtual;
    procedure Log(const Description: string; const Index: Integer; const Item: string); overload; virtual;
    procedure Log(const Description: string; const Item: ShortStringBase); overload; virtual;
    procedure Report(const FormatMask: string; const Arguments: array of const); overload; virtual;
    procedure Report(const FormatMask: string; const Arguments: array of const; const FormatSettings: TFormatSettings);
        overload; virtual;
  end;

  TReportingLogger = class(TLogger)
  public
    constructor Create(Reporter: TReporter);
    destructor Destroy; override;
    property OnReport;
  end;

implementation

uses
  RecordTypeInfoUnit, SetTypeInfoUnit, EnumTypeInfoUnit;

procedure TLogger.Log(const Description: string; const Item: string);
begin
  Log('%s:%s', [Description, Item]);
end;

procedure TLogger.Log(const Description: string; const Item: Integer);
begin
  Log('%s:%d', [Description, Item]);
end;

constructor TLogger.Create(const OnLog: TLogReportEvent);
begin
  inherited Create();
  FOnReport := OnLog;
end;

procedure TLogger.Log(const Line: string);
begin
  Report(Line);
end;

procedure TLogger.Log(const FormatMask: string; const Arguments: array of const);
begin
  Report(FormatMask, Arguments);
end;

procedure TLogger.Log(const FormatMask: string; const Arguments: array of const; const FormatSettings: TFormatSettings);
begin
  Report(FormatMask, Arguments, FormatSettings);
end;

procedure TLogger.Log(const Description: string; const TypeInfo: PTypeInfo; const Value: Integer);
var
  Item: string;
begin
  Item := GetEnumNameAndOrdValue(TypeInfo, Value);
  Log(Description, Item);
end;

procedure TLogger.Log(const Description: string; const TypeTypeInfo: PTypeInfo; const Prefix: string = '');
var
  TypeTypeData: PTypeData;
  TTypeKindTypeInfo: PTypeInfo;
  TOrdTypeTypeInfo: PTypeInfo;
  TFloatTypeTypeInfo: PTypeInfo;
  TMethodKindTypeInfo: PTypeInfo;
  TIntfFlagsBaseTypeInfo: PTypeInfo;
  IntfFlagsString: string;
  RecordFieldTable: PFieldTable;
  FieldIndex: Integer;
  RecordFieldPrefix: string;
  NewPrefix: string;
  RecordFieldTableField: TFieldInfo;
begin
  if not Assigned(TypeTypeInfo) then
    Exit;
  Log('%s: TypeInfo for type %s', [Description, TypeTypeInfo.Name]);

  TTypeKindTypeInfo := TypeInfo(TTypeKind);
  NewPrefix := Prefix + '  ';
  Log(NewPrefix + 'TypeInfo.Kind', TTypeKindTypeInfo, Ord(TypeTypeInfo.Kind));

  // uses IntfInfo ;
  // uses TypInfo ;
  TypeTypeData := TypInfo.GetTypeData(TypeTypeInfo);
  case TypeTypeInfo.Kind of
    tkUnknown, tkLString, tkWString, tkVariant: ;
    tkInteger, tkChar, tkEnumeration, tkSet, tkWChar:
      begin
        TOrdTypeTypeInfo := TypeInfo(TOrdType);
        Log(NewPrefix + 'OrdType', TOrdTypeTypeInfo, Ord(TypeTypeData.OrdType));
        case TypeTypeInfo.Kind of
          tkInteger, tkChar, tkEnumeration, tkWChar:
            begin
              Log(NewPrefix + 'MinValue', TypeTypeData.MinValue);
              Log(NewPrefix + 'MaxValue', TypeTypeData.MaxValue);
              case TypeTypeInfo.Kind of
                tkInteger, tkChar, tkWChar: ;
                tkEnumeration:
                  begin
                    if Assigned(TypeTypeData.BaseType) then
                      Log(NewPrefix + 'BaseType', TypeTypeData.BaseType^, NewPrefix);
                    Log(NewPrefix + 'NameList', TypeTypeData.NameList);
                    Log(NewPrefix + 'EnumUnitName', TypeTypeData.EnumUnitName);
                  end;
              end;
            end;
          tkSet:
            begin
              if Assigned(TypeTypeData.CompType) then
                Log(Prefix + 'CompType', TypeTypeData.CompType^, NewPrefix);
            end;
        end;
      end;
    tkFloat:
      begin
        TFloatTypeTypeInfo := TypeInfo(TFloatType);
        Log(NewPrefix + 'FloatType', TFloatTypeTypeInfo, Ord(TypeTypeData.FloatType));
      end;
    tkString:
      begin
        Log(NewPrefix + 'MaxLength', TypeTypeData.MaxLength);
      end;
    tkClass:
      begin
        Log(NewPrefix + 'ClassType', TypeTypeData.ClassType.ClassName);
        if Assigned(TypeTypeData.ParentInfo) then
          Log(NewPrefix + 'ParentInfo', TypeTypeData.ParentInfo^, NewPrefix);
        Log(NewPrefix + 'PropCount', TypeTypeData.PropCount);
        Log(NewPrefix + 'UnitName', TypeTypeData.UnitName);
        {PropData: TPropData};
      end;
    tkMethod:
      begin
        TMethodKindTypeInfo := typeInfo(TMethodKind);
        Log(NewPrefix + 'MethodKind', TMethodKindTypeInfo, Ord(TypeTypeData.MethodKind));
        Log(NewPrefix + 'ParamCount', ParamCount);
        // ParamList: array[0..1023] of Char
        {ParamList: array[1..ParamCount] of
           record
             Flags: TParamFlags;
             ParamName: ShortString;
             TypeName: ShortString;
           end;
         ResultType: ShortString};
      end;
    tkInterface:
      begin
        if Assigned(TypeTypeData.IntfParent) then
          Log(NewPrefix + 'IntfParent', TypeTypeData.IntfParent^, NewPrefix); { ancestor }
        TIntfFlagsBaseTypeInfo := TypeInfo(TIntfFlagsBase);
        IntfFlagsString := SetToString(TIntfFlagsBaseTypeInfo, TypeTypeData.IntfFlags, True);
        Log(NewPrefix + 'IntfFlags', IntfFlagsString);
        Log(NewPrefix + 'Guid', GUIDToString(TypeTypeData.Guid));
        Log(NewPrefix + 'IntfUnit', TypeTypeData.IntfUnit);
        {PropData: TPropData};
      end;
    tkInt64:
      begin
        Log(NewPrefix + 'MinInt64Value', TypeTypeData.MinInt64Value);
        Log(NewPrefix + 'MaxInt64Value', TypeTypeData.MaxInt64Value);
      end;
    tkDynArray:
      begin
        Log(NewPrefix + 'elSize', TypeTypeData.elSize);
        if Assigned(TypeTypeData.elType) then
          Log(NewPrefix + 'elType', TypeTypeData.elType^, NewPrefix); // nil if type does not require cleanup
        Log(NewPrefix + 'varType', TypeTypeData.varType); // Ole Automation varType equivalent
        if Assigned(TypeTypeData.elType2) then
          Log(NewPrefix + 'elType2', TypeTypeData.elType2^, NewPrefix); // independent of cleanup
        Log(NewPrefix + 'DynUnitName', TypeTypeData.DynUnitName);
      end;
    tkRecord:
      begin //jpl: 20080908
        RecordFieldTable := GetFieldTable(TypeTypeInfo);
        Log(NewPrefix + 'RecordFieldTable.X', RecordFieldTable.X);
        Log(NewPrefix + 'RecordFieldTable.Size', RecordFieldTable.Size);
        Log(NewPrefix + 'RecordFieldTable.Count', RecordFieldTable.Count);
        for FieldIndex := 0 to RecordFieldTable.Count - 1 do
        begin
          RecordFieldTableField := RecordFieldTable.Fields[FieldIndex];
          RecordFieldPrefix := Format('%s  RecordFieldTable[%d] Offset %8.8x',
            [Prefix, FieldIndex, RecordFieldTableField.Offset]);
          if Assigned(RecordFieldTableField.TypeInfo^) then
            Log(RecordFieldPrefix, RecordFieldTableField.TypeInfo^, NewPrefix);
        end;
      end;
  end;
end;

procedure TLogger.Log(const Description: string; const Index: Integer; const Item: Integer);
begin
  Log('%s[%d]:%d', [Description, Index, Item]);
end;

procedure TLogger.Log(const Description: string; const Index: Integer; const Item: string);
begin
  Log('%s[%d]:%s', [Description, Index, Item]);
end;

procedure TLogger.Log(const Description: string; const Item: ShortStringBase);
begin
  Log(Description, string(Item));
end;

procedure TLogger.LogMulti(const Description: string; const Items: array of string);
var
  Item: string;
  Index: Integer;
begin
  Index := 0;
  for Item in Items do
  begin
    Index := Index + 1;
    Log(Format('%s[%d]', [Description, Index]), Item);
  end;
end;

procedure TLogger.Report(const FormatMask: string; const Arguments: array of const);
var
  Line: string;
begin
  Line := Format(FormatMask, Arguments);
  Log(Line);
end;

procedure TLogger.Report(const FormatMask: string; const Arguments: array of const; const FormatSettings:
    TFormatSettings);
var
  Line: string;
begin
  Line := Format(FormatMask, Arguments, FormatSettings);
end;

procedure TLogger.Report(const Line: string);
var
  OnLog: TLogReportEvent;
begin
  OnLog := Self.OnReport;
  if Assigned(OnLog) then
    OnLog(Line);
end;

constructor TReportingLogger.Create(Reporter: TReporter);
begin
  if Assigned(Reporter) then
    inherited Create(Reporter.Report)
  else
    inherited Create(nil);
end;

destructor TReportingLogger.Destroy;
begin
  inherited;

end;

end.
