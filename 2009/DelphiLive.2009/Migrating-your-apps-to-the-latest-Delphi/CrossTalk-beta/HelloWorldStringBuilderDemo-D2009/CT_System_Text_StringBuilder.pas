unit CT_System_Text_StringBuilder;

interface

uses
  CTObject;

type
  StringBuilder = class;
  StringBuilder = class(TCTObject)
  private
    function CapacityRead: Integer;
    procedure CapacityWrite(const avalue: Integer);
    function MaxCapacityRead: Integer;
    function LengthRead: Integer;
    procedure LengthWrite(const avalue: Integer);
    function CharsRead(const aindex: Integer): Char;
    procedure CharsWrite(const aindex: Integer; const avalue: Char);
  public
    constructor Create; overload;
    constructor Create(const acapacity: Integer); overload;
    constructor Create(const avalue: CTString); overload;
    constructor Create(const avalue: CTString; const acapacity: Integer); overload;
    constructor Create(const avalue: CTString; const astartIndex: Integer; const alength: Integer; const acapacity: Integer); overload;
    constructor Create(const acapacity: Integer; const amaxCapacity: Integer); overload;
    function EnsureCapacity(const acapacity: Integer): Integer; overload;
    function ToString: CTString; overload;
    function ToString(const astartIndex: Integer; const alength: Integer): CTString; overload;
    function Append(const avalue: Char; const arepeatCount: Integer): StringBuilder; overload;
    function Append(const avalue: CTString): StringBuilder; overload;
    function Append(const avalue: CTString; const astartIndex: Integer; const acount: Integer): StringBuilder; overload;
    function AppendLine: StringBuilder; overload;
    function AppendLine(const avalue: CTString): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: CTString; const acount: Integer): StringBuilder; overload;
    function Remove(const astartIndex: Integer; const alength: Integer): StringBuilder; overload;
    function Append(const avalue: Boolean): StringBuilder; overload;
    function Append(const avalue: ShortInt): StringBuilder; overload;
    function Append(const avalue: Byte): StringBuilder; overload;
    function Append(const avalue: Char): StringBuilder; overload;
    function Append(const avalue: SmallInt): StringBuilder; overload;
    function Append(const avalue: Integer): StringBuilder; overload;
    function Append(const avalue: Int64): StringBuilder; overload;
    function Append(const avalue: Single): StringBuilder; overload;
    function Append(const avalue: Double): StringBuilder; overload;
    function Append(const avalue: Extended): StringBuilder; overload;
    function Append(const avalue: Word): StringBuilder; overload;
    function Append(const avalue: Cardinal): StringBuilder; overload;
    function Append(const avalue: TCTObject): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: CTString): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Boolean): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: ShortInt): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Byte): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: SmallInt): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Char): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Integer): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Int64): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Single): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Double): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Extended): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Word): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: Cardinal): StringBuilder; overload;
    function Insert(const aindex: Integer; const avalue: TCTObject): StringBuilder; overload;
    function AppendFormat(const aformat: CTString; const aarg0: TCTObject): StringBuilder; overload;
    function AppendFormat(const aformat: CTString; const aarg0: TCTObject; const aarg1: TCTObject): StringBuilder; overload;
    function AppendFormat(const aformat: CTString; const aarg0: TCTObject; const aarg1: TCTObject; const aarg2: TCTObject): StringBuilder; overload;
    function Replace(const aoldValue: CTString; const anewValue: CTString): StringBuilder; overload;
    function Replace(const aoldValue: CTString; const anewValue: CTString; const astartIndex: Integer; const acount: Integer): StringBuilder; overload;
    function Equals(const asb: StringBuilder): Boolean; overload;
    function Replace(const aoldChar: Char; const anewChar: Char): StringBuilder; overload;
    function Replace(const aoldChar: Char; const anewChar: Char; const astartIndex: Integer; const acount: Integer): StringBuilder; overload;
    function Equals(const aobj: TCTObject): Boolean; overload;
    function GetHashCode: Integer; overload;
    property Capacity: Integer read CapacityRead write CapacityWrite;
    property MaxCapacity: Integer read MaxCapacityRead;
    property Length: Integer read LengthRead write LengthWrite;
    property Chars[const aindex: Integer]: Char read CharsRead write CharsWrite;
  end;

implementation

{ System.Text.StringBuilder }

function StringBuilder.CapacityRead: Integer;
begin
  Result := Integer(CTPropGet('Capacity'));
end;

procedure StringBuilder.CapacityWrite(const avalue: Integer);
begin
  CTPropSet('Capacity', 0, [avalue], Integer(aValue));
end;

function StringBuilder.MaxCapacityRead: Integer;
begin
  Result := Integer(CTPropGet('MaxCapacity'));
end;

function StringBuilder.LengthRead: Integer;
begin
  Result := Integer(CTPropGet('Length'));
end;

procedure StringBuilder.LengthWrite(const avalue: Integer);
begin
  CTPropSet('Length', 0, [avalue], Integer(aValue));
end;

function StringBuilder.CharsRead(const aindex: Integer): Char;
begin
  Result := Char(CTPropGet('Chars', 1, [aindex]));
end;

procedure StringBuilder.CharsWrite(const aindex: Integer; const avalue: Char);
begin
  CTPropSet('Chars', 1, [aindex, avalue], Integer(aValue));
end;

constructor StringBuilder.Create;
begin
  CTCreateObject('System.Text.StringBuilder', []);
end;

constructor StringBuilder.Create(const acapacity: Integer);
begin
  CTCreateObject('System.Text.StringBuilder', [acapacity]);
end;

constructor StringBuilder.Create(const avalue: CTString);
begin
  CTCreateObject('System.Text.StringBuilder', [avalue]);
end;

constructor StringBuilder.Create(const avalue: CTString; const acapacity: Integer);
begin
  CTCreateObject('System.Text.StringBuilder', [avalue, acapacity]);
end;

constructor StringBuilder.Create(const avalue: CTString; const astartIndex: Integer; const alength: Integer; const acapacity: Integer);
begin
  CTCreateObject('System.Text.StringBuilder', [avalue, astartIndex, alength, acapacity]);
end;

constructor StringBuilder.Create(const acapacity: Integer; const amaxCapacity: Integer);
begin
  CTCreateObject('System.Text.StringBuilder', [acapacity, amaxCapacity]);
end;

function StringBuilder.EnsureCapacity(const acapacity: Integer): Integer;
begin
  Result := Integer(CTMethodCall('EnsureCapacity', [acapacity]));
end;

function StringBuilder.ToString: CTString;
begin
  Result := CTMethodCallStringResult('ToString', []);
end;

function StringBuilder.ToString(const astartIndex: Integer; const alength: Integer): CTString;
begin
  Result := CTMethodCallStringResult('ToString', [astartIndex, alength]);
end;

function StringBuilder.Append(const avalue: Char; const arepeatCount: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue, arepeatCount])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: CTString): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: CTString; const astartIndex: Integer; const acount: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue, astartIndex, acount])));
  ResultObjectsClear;
end;

function StringBuilder.AppendLine: StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('AppendLine', [])));
  ResultObjectsClear;
end;

function StringBuilder.AppendLine(const avalue: CTString): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('AppendLine', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: CTString; const acount: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue, acount])));
  ResultObjectsClear;
end;

function StringBuilder.Remove(const astartIndex: Integer; const alength: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Remove', [astartIndex, alength])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Boolean): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: ShortInt): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Byte): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Char): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: SmallInt): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Int64): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Single): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Double): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Extended): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Word): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: Cardinal): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Append(const avalue: TCTObject): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Append', [avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: CTString): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Boolean): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: ShortInt): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Byte): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: SmallInt): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Char): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Int64): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Single): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Double): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Extended): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Word): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: Cardinal): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.Insert(const aindex: Integer; const avalue: TCTObject): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Insert', [aindex, avalue])));
  ResultObjectsClear;
end;

function StringBuilder.AppendFormat(const aformat: CTString; const aarg0: TCTObject): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('AppendFormat', [aformat, aarg0])));
  ResultObjectsClear;
end;

function StringBuilder.AppendFormat(const aformat: CTString; const aarg0: TCTObject; const aarg1: TCTObject): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('AppendFormat', [aformat, aarg0, aarg1])));
  ResultObjectsClear;
end;

function StringBuilder.AppendFormat(const aformat: CTString; const aarg0: TCTObject; const aarg1: TCTObject; const aarg2: TCTObject): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('AppendFormat', [aformat, aarg0, aarg1, aarg2])));
  ResultObjectsClear;
end;

function StringBuilder.Replace(const aoldValue: CTString; const anewValue: CTString): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Replace', [aoldValue, anewValue])));
  ResultObjectsClear;
end;

function StringBuilder.Replace(const aoldValue: CTString; const anewValue: CTString; const astartIndex: Integer; const acount: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Replace', [aoldValue, anewValue, astartIndex, acount])));
  ResultObjectsClear;
end;

function StringBuilder.Equals(const asb: StringBuilder): Boolean;
begin
  Result := Boolean(CTMethodCall('Equals', [asb]));
end;

function StringBuilder.Replace(const aoldChar: Char; const anewChar: Char): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Replace', [aoldChar, anewChar])));
  ResultObjectsClear;
end;

function StringBuilder.Replace(const aoldChar: Char; const anewChar: Char; const astartIndex: Integer; const acount: Integer): StringBuilder;
begin
  Result := StringBuilder(CTFindRef(StringBuilder, CTMethodCall('Replace', [aoldChar, anewChar, astartIndex, acount])));
  ResultObjectsClear;
end;

function StringBuilder.Equals(const aobj: TCTObject): Boolean;
begin
  Result := Boolean(CTMethodCall('Equals', [aobj]));
end;

function StringBuilder.GetHashCode: Integer;
begin
  Result := Integer(CTMethodCall('GetHashCode', []));
end;

end.
