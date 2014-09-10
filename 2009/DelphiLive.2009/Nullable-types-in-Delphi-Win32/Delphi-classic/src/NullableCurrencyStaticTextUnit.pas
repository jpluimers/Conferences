unit NullableCurrencyStaticTextUnit;

interface

uses
  Classes, NumericStaticTextUnit, Controls, NullablesUnit, NullableWrappersUnit;

// TNullableDoubleStaticText

type
  TCustomNullableCurrencyStaticText = class(TBaseNumericStaticText)
  strict private
    FValue: TNullableCurrency;
    FValueEditor: TNullableCurrencyWrapper;
    function GetValueEditor: TNullableCurrencyWrapper;
    procedure SetValueEditor(const NewValue: TNullableCurrencyWrapper);
    procedure ValueEditorChanged(Sender: TObject);
  strict protected
    procedure CalculateText; override;
    function GetIsNull: Boolean; override;
    function GetValue: TNullableCurrency;
    procedure SetIsNull(const Value: Boolean); override;
    procedure SetValue(const NewValue: TNullableCurrency); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    procedure Clear;
    property DecimalDigits;
    property IsFilled;
    property IsNull;
    property Value: TNullableCurrency read GetValue write SetValue;
    property ValueEditor: TNullableCurrencyWrapper read GetValueEditor write SetValueEditor;
  end;

type
  TNullableCurrencyStaticText = class(TCustomNullableCurrencyStaticText)
  published // from TCustomNullableCurrencyStaticText
    property DecimalDigits;
    property Value;
    property ValueEditor;
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
  ControlUtilsUnit, SysUtils, Windows;

{ TCustomNullableCurrencyStaticText }

procedure TCustomNullableCurrencyStaticText.Clear;
begin
  Value.IsFilled := False;
  Value := 0;
end;

constructor TCustomNullableCurrencyStaticText.Create(aOwner: TComponent);
begin
  inherited;
  FValueEditor := TNullableCurrencyWrapper.Create(TNullableCurrency.Null());
  ValueEditor := FValueEditor;
  ValueEditor.OnChange := ValueEditorChanged;
  Value := TNullableCurrency(1234.56);
end;

destructor TCustomNullableCurrencyStaticText.Destroy;
begin
  FValueEditor.Free;
  FValueEditor := nil;
  inherited;
end;

procedure TCustomNullableCurrencyStaticText.CalculateText;
begin
  if Assigned(Self) then  
    TControlUtils.CalculateText(Self, FormatSettings, Value);
end;

function TCustomNullableCurrencyStaticText.GetIsNull: Boolean;
begin
  if Assigned(Self.ValueEditor) then
    Result := Self.ValueEditor.IsNull
  else
    Result := False;
end;

function TCustomNullableCurrencyStaticText.GetValue: TNullableCurrency;
begin
  Result := FValue;
end;

function TCustomNullableCurrencyStaticText.GetValueEditor: TNullableCurrencyWrapper;
begin
  if Assigned(Self.FValueEditor) then
    if (csDesigning in ComponentState) then
      Self.FValueEditor.NullableValue := Self.Value
    else // run-time: de invoer waarde van de gebruiker nemen
      Self.FValueEditor.NullableValue := Self.Value;
//      Self.FValueEditor.NullableValue := TNullableCurrency.Parse(Text);
  Result := Self.FValueEditor;
end;

procedure TCustomNullableCurrencyStaticText.SetIsNull(const Value: Boolean);
begin
  if Assigned(Self.ValueEditor) then
    Self.ValueEditor.IsNull := Value;
end;

procedure TCustomNullableCurrencyStaticText.SetValue(const NewValue: TNullableCurrency);
begin
  FValue := NewValue;
  CalculateText();
end;

procedure TCustomNullableCurrencyStaticText.SetValueEditor(const NewValue: TNullableCurrencyWrapper);
begin
  if Assigned(Self.FValueEditor) then
    Self.FValueEditor.Assign(NewValue)
  else
    Text := '';
end;

procedure TCustomNullableCurrencyStaticText.ValueEditorChanged(Sender: TObject);
var
  NullableCurrencyWrapper: TNullableCurrencyWrapper;
begin
  if Assigned(Sender) then
  begin
    if Sender is TNullableCurrencyWrapper then
    begin
      NullableCurrencyWrapper := TNullableCurrencyWrapper(Sender);
      Self.Value := NullableCurrencyWrapper.NullableValue;
//##evk never used ??      NullableCurrencyWrapper := TNullableCurrencyWrapper(Sender);
    end;
  end;
end;

end.
