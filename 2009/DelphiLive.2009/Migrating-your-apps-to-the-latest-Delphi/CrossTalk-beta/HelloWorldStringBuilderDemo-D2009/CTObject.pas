unit CTObject;

interface

type
{$IF Declared(RTLVersion) and (RTLVersion >= 20.0)}
  PCTChar = PChar; // PAnsiChar;
  CTString = string; // AnsiString;
{$ELSE}
  PCTChar = PChar;
  CTString = string;
{$IFEND}

  TCTObjectClass = class of TCTObject;

  TCTObject = class(TObject)
  private
    procedure CTCheckResult(aResult: integer);
    constructor CreateByRef();
  protected
    procedure ResultObjectsClear();
    procedure CTCreateObject(
      aFullName: CTString;
      aParams: array of const);
    function CTMethodCall(
      aMethodName: CTString;
      aParams: array of const
      ): Longword;
    function CTMethodCallStringResult(
      aMethodName: CTString;
      aParams: array of const
      ): CTString;
    function CTPropGet(
      aPropName: CTString
      ): Longword; overload;
    function CTPropGet(
      aPropName: CTString;
      aIndexCount: Integer;
      aIndices: array of const
      ): Longword; overload;
    procedure CTPropSet(
      aPropName: CTString;
      aValue: Longword
      ); overload;
    procedure CTPropSet(
      aPropName: CTString;
      aIndexCount: Integer;
      aIndices: array of const;
      aValue: Longword
      ); overload;
    function CTFindRef(
      aClass: TCTObjectClass;
      aTempObjID: Integer
      ): TCTObject;
  public
    destructor Destroy; override;
  end;

implementation

uses
  Classes
  , CTClient, CTException
  , SysUtils;

constructor TCTObject.CreateByRef;
begin
  inherited Create;
end;

procedure TCTObject.CTCheckResult(aResult: integer);
begin
  // <0 exception
  // 0 = all ok, no information
  // >0 information
  case aResult of
    // Ok - No message
    0: begin
    end;

    // Ok - Addl info included
    1..High(Integer): begin
    end;

    -1: begin
      raise ECTException.Create('Generic CrossTalk exception');
    end;

    -2: begin
      raise ECTException.Create('CrossTalk License is invalid or expired');
    end;

    else begin
      raise ECTException.Create('Unknown CrossTalk exception');
    end;
  end;
end;

procedure TCTObject.CTCreateObject(
  aFullName: CTString;
  aParams: array of const);
begin
  CTCheckResult(CTClient.ObjectCreate(PCTChar(aFullname), Self
    , Length(aParams), @aParams));
end;

function TCTObject.CTFindRef(aClass: TCTObjectClass; aTempObjID: Integer): TCTObject;
begin
  CTCheckResult(ObjectMatch(aTempObjID, Result));
  if Result = nil then begin
    Result := TCTObjectClass.CreateByRef();
    CTCheckResult(ObjectTransform(aTempObjID, Result));
  end;
end;

function TCTObject.CTMethodCall(aMethodName: CTString;
  aParams: array of const): Longword;
begin
  CTCheckResult(CTClient.MethodCall(Self, PCTChar(aMethodName)
    , Result, Length(aParams), @aParams));
end;

function TCTObject.CTMethodCallStringResult(aMethodName: CTString;
  aParams: array of const): CTString;
var
  xLen: Longword;
begin
  CTCheckResult(CTClient.MethodCall(Self, PCTChar(aMethodName)
    , xLen, Length(aParams), @aParams));
  SetLength(Result, xLen);
  GetResultString(PCTChar(Result));
end;

function TCTObject.CTPropGet(aPropName: CTString): Longword;
begin
  CTCheckResult(CTClient.PropGet(Self, PCTChar(aPropName), 0, nil, Result));
end;

function TCTObject.CTPropGet(aPropName: CTString; aIndexCount: Integer;
  aIndices: array of const): Longword;
begin
  CTCheckResult(CTClient.PropGet(Self, PCTChar(aPropName), aIndexCount
    , @aIndices, Result));
end;

procedure TCTObject.CTPropSet(aPropName: CTString; aIndexCount: Integer;
  aIndices: array of const; aValue: Longword);
begin
  CTCheckResult(CTClient.PropSet(Self, PCTChar(aPropName), aIndexCount
    , @aIndices, aValue));
end;

procedure TCTObject.CTPropSet(aPropName: CTString; aValue: Longword);
begin
  CTCheckResult(CTClient.PropSet(Self, PCTChar(aPropName), 0, nil, aValue));
end;

destructor TCTObject.Destroy;
begin
  ObjectDestroy(Self);
  inherited;
end;

procedure TCTObject.ResultObjectsClear;
begin
  CTClient.ResultObjectsClear();
end;

end.
