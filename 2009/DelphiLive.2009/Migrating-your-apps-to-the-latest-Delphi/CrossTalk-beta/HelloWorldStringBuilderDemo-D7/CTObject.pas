unit CTObject;

interface

type
  TCTObjectClass = class of TCTObject;

  TCTObject = class(TObject)
  private
    procedure CTCheckResult(aResult: integer);
    constructor CreateByRef();
  protected
    procedure ResultObjectsClear();
    procedure CTCreateObject(
      aFullName: string;
      aParams: array of const);
    function CTMethodCall(
      aMethodName: string;
      aParams: array of const
      ): Longword;
    function CTMethodCallStringResult(
      aMethodName: string;
      aParams: array of const
      ): string;
    function CTPropGet(
      aPropName: string
      ): Longword; overload;
    function CTPropGet(
      aPropName: string;
      aIndexCount: Integer;
      aIndices: array of const
      ): Longword; overload;
    procedure CTPropSet(
      aPropName: string;
      aValue: Longword
      ); overload;
    procedure CTPropSet(
      aPropName: string;
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
  aFullName: string;
  aParams: array of const);
begin
  CTCheckResult(CTClient.ObjectCreate(PChar(aFullname), Self
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

function TCTObject.CTMethodCall(aMethodName: string;
  aParams: array of const): Longword;
begin
  CTCheckResult(CTClient.MethodCall(Self, PChar(aMethodName)
    , Result, Length(aParams), @aParams));
end;

function TCTObject.CTMethodCallStringResult(aMethodName: string;
  aParams: array of const): string;
var
  xLen: Longword;
begin
  CTCheckResult(CTClient.MethodCall(Self, PChar(aMethodName)
    , xLen, Length(aParams), @aParams));
  SetLength(Result, xLen);
  GetResultString(PChar(Result));
end;

function TCTObject.CTPropGet(aPropName: string): Longword;
begin
  CTCheckResult(CTClient.PropGet(Self, PChar(aPropName), 0, nil, Result));
end;

function TCTObject.CTPropGet(aPropName: string; aIndexCount: Integer;
  aIndices: array of const): Longword;
begin
  CTCheckResult(CTClient.PropGet(Self, PChar(aPropName), aIndexCount
    , @aIndices, Result));
end;

procedure TCTObject.CTPropSet(aPropName: string; aIndexCount: Integer;
  aIndices: array of const; aValue: Longword);
begin
  CTCheckResult(CTClient.PropSet(Self, PChar(aPropName), aIndexCount
    , @aIndices, aValue));
end;

procedure TCTObject.CTPropSet(aPropName: string; aValue: Longword);
begin
  CTCheckResult(CTClient.PropSet(Self, PChar(aPropName), 0, nil, aValue));
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
