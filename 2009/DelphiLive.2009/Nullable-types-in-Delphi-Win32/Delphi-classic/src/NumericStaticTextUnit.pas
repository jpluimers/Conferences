unit NumericStaticTextUnit;

interface

uses StdCtrls, SysUtils, Classes, Controls, Messages, NullablesUnit;

type
  TBaseNumericStaticText = class(TCustomStaticText)
  strict private
    FFormatSettings: TFormatSettings;
    FIsLoaded: Boolean;
    FNeedToInitialize: Boolean;
    procedure AdjustBounds;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure DoInitializeOnceWhenLoadedAndHandleExists;
    procedure Log(const MethodName: string);
  strict protected
    procedure CalculateText; virtual;
    procedure CreateWnd; override;
    function GetDecimalDigits: Byte; virtual;
    function GetIsFilled: Boolean; virtual;
    function GetIsNull: Boolean; virtual;
    procedure InitializeWhenHandleExists; virtual;
    procedure SetDecimalDigits(const Value: Byte); virtual;
    procedure SetIsFilled(const Value: Boolean); virtual;
    procedure SetIsNull(const Value: Boolean); virtual;
    property DecimalDigits: Byte read GetDecimalDigits write SetDecimalDigits;
    property IsFilled: Boolean read GetIsFilled write SetIsFilled;
    property IsNull: Boolean read GetIsNull write SetIsNull;
    property Alignment default taRightJustify;
    property AutoSize default False;
    property BevelKind default bkNone;
  protected
    procedure Loaded; override;
  public
    constructor Create(aOwner: TComponent); override;
    property FormatSettings: TFormatSettings read FFormatSettings;
  end;

type
  TCustomNumericStaticText = class(TBaseNumericStaticText)
  strict private
    FValue: TNullableDouble;
  strict protected
    procedure CalculateText; override;
    function GetValue: TNullableDouble; virtual;
    procedure SetValue(const NewValue: TNullableDouble); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    property DecimalDigits;
    property Value: TNullableDouble read GetValue write SetValue;
  end;

type
  TNumericStaticText = class(TCustomNumericStaticText)
  published // from TBaseNumericStaticText
    property DecimalDigits;
    property Value;
  published // from TStaticText
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind default bkNone;
    property BevelOuter;
    property BiDiMode;
    property BorderStyle;
    //    property Caption;
    property Color nodefault;
    property Constraints;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FocusControl;
    property Font;
    property ParentBiDiMode;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowAccelChar;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Transparent;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  ControlUtilsUnit, Windows, TypInfo, SetTypeInfoUnit;

{ TBaseNumericStaticText }

constructor TBaseNumericStaticText.Create(aOwner: TComponent);
begin
  Log('Create');
  inherited;
  GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, FFormatSettings);
  // make sure the IDE does not overwrite our Caption, and indicate we don't support Child components.
  ControlStyle := ControlStyle - [csAcceptsControls, csSetCaption];

  // default property values:
  Alignment := taRightJustify;
  AutoSize := False;
  BevelKind := bkNone;

  // Initialization:
  FNeedToInitialize := True;
  DoInitializeOnceWhenLoadedAndHandleExists;
end;

procedure TBaseNumericStaticText.AdjustBounds;
var
  DC: HDC;
  SaveFont: HFont;
  TextSize: TSize;
begin
  if FNeedToInitialize then
    Exit;
  if (csLoading in ComponentState) then
    Exit;
  if (csReading in ComponentState) then
    Exit;
  if not (csDesigning in ComponentState) then
    Exit;
  if AutoSize then
    Exit;
//##jpl: via een context-menu op design time oplossen
//  DC := GetDC(0);
//  try
//    SaveFont := SelectObject(DC, Font.Handle);
//    GetTextExtentPoint32(DC, PChar(Caption), Length(Caption), TextSize);
//    SelectObject(DC, SaveFont);
//  finally
//    ReleaseDC(0, DC);
//  end;
//  SetBounds(Left, Top,
//    TextSize.cx + (GetSystemMetrics(SM_CXBORDER) * 4),
//    TextSize.cy + (GetSystemMetrics(SM_CYBORDER) * 4));
end;

procedure TBaseNumericStaticText.CalculateText;
begin
//
end;

procedure TBaseNumericStaticText.CMFontChanged(var Message: TMessage);
begin
  Log('CMFontChanged');
  inherited;
  AdjustBounds;
end;

procedure TBaseNumericStaticText.CMTextChanged(var Message: TMessage);
begin
  Log('CMTextChanged');
  inherited;
  AdjustBounds;
  Invalidate;
end;

procedure TBaseNumericStaticText.CreateWnd;
begin
  Log('CreateWnd');
  inherited CreateWnd;
  DoInitializeOnceWhenLoadedAndHandleExists;
end;

procedure TBaseNumericStaticText.DoInitializeOnceWhenLoadedAndHandleExists;
var
  IsInitialized: Boolean;
begin
  Log('DoInitializeWhenHandleExists');
  { the components proparties have only been fully initialized when:
    - at designtime: the csDesigning flag got raised
    - at run-time: after the Loaded has been called
  }
  IsInitialized := FIsLoaded or (csDesigning in ComponentState);
  if FNeedToInitialize and IsInitialized and HandleAllocated then
  begin
    InitializeWhenHandleExists;
    FNeedToInitialize := False;
  end;
end;

function TBaseNumericStaticText.GetDecimalDigits: Byte;
begin
  Result := FFormatSettings.CurrencyDecimals;
end;

function TBaseNumericStaticText.GetIsFilled: Boolean;
begin
  Result := not IsNull;
end;

function TBaseNumericStaticText.GetIsNull: Boolean;
begin
  Result := False;
end;

procedure TBaseNumericStaticText.InitializeWhenHandleExists;
begin
  Log('InitializeWhenHandleExists');
  // Empty by design: descendants can override this method
end;

procedure TBaseNumericStaticText.Loaded;
begin
  Log('Loaded');
  inherited;
  FIsLoaded := True;
  DoInitializeOnceWhenLoadedAndHandleExists;
  AdjustBounds;
end;

procedure TBaseNumericStaticText.Log(const MethodName: string);
var
  Output: string;
  This: Pointer;
  ComponentStateTypeInfo: PTypeInfo;
  ComponentStateString: string;
  IsLoadedString: string;
  NeedToInitializeString: string;
begin
  Exit; //jpl: tijdens het debuggen het Exit statement eventueel in commentaar zetten om te debuggen
  This := Self;
  ComponentStateTypeInfo := TypeInfo(TComponentState);
  ComponentStateString := SetToString(ComponentStateTypeInfo, ComponentState, True);
  IsLoadedString := BoolToStr(FIsLoaded);
  NeedToInitializeString := BoolToStr(FNeedToInitialize);
  Output := Format('%s(%p):%s.%s ComponentState=%s; FIsLoaded=%s, FNeedToInitialize=%s',
    [Self.Name, This, Self.ClassName, MethodName, ComponentStateString, IsLoadedString, NeedToInitializeString]);
  OutputDebugString(PChar(Output)); // optionally log using OutputDebugString
end;

procedure TBaseNumericStaticText.SetDecimalDigits(const Value: Byte);
begin
  FFormatSettings.CurrencyDecimals := Value;
  CalculateText();
end;

procedure TBaseNumericStaticText.SetIsFilled(const Value: Boolean);
begin
  Self.IsNull := not Value;
end;

procedure TBaseNumericStaticText.SetIsNull(const Value: Boolean);
begin
  // intentionally left as a no-operation: descending classes must implement this.
end;

{ TCustomNumericStaticText }

constructor TCustomNumericStaticText.Create(aOwner: TComponent);
begin
  inherited;
  Value := Pi;
end;

procedure TCustomNumericStaticText.CalculateText;
begin
  TControlUtils.CalculateText(Self, FormatSettings, Value);
end;

function TCustomNumericStaticText.GetValue: TNullableDouble;
begin
  Result := FValue; // TNullableDouble.Parse(Text, FormatSettings);
end;

procedure TCustomNumericStaticText.SetValue(const NewValue: TNullableDouble);
begin
  FValue := NewValue;
  CalculateText();
end;

end.

