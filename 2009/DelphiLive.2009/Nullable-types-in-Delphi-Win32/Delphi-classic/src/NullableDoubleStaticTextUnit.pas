unit NullableDoubleStaticTextUnit;

interface

uses
  Classes, NumericStaticTextUnit, Controls, NullablesUnit, NullableWrappersUnit;

// TNullableDoubleStaticText 

type
  TCustomNullableDoubleStaticText = class(TBaseNumericStaticText)
  strict private
    FValue: TNullableDouble;
    FValueEditor: TNullableDoubleWrapper;
    function GetValueEditor: TNullableDoubleWrapper;
    procedure SetValueEditor(const NewValue: TNullableDoubleWrapper);
    procedure ValueEditorChanged(Sender: TObject);
  strict protected
    procedure CalculateText; override;
    function GetIsNull: Boolean; override;
    function GetValue: TNullableDouble;
    procedure SetIsNull(const Value: Boolean); override;
    procedure SetValue(const NewValue: TNullableDouble); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property DecimalDigits;
    property IsFilled;
    property IsNull;
    property Value: TNullableDouble read GetValue write SetValue;
    property ValueEditor: TNullableDoubleWrapper read GetValueEditor write SetValueEditor;
  end;

type
  TNullableDoubleStaticText = class(TCustomNullableDoubleStaticText)
  published // from TCustomNullableDoubleStaticText
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

{ TCustomNullableDoubleStaticText }

constructor TCustomNullableDoubleStaticText.Create(aOwner: TComponent);
begin
  inherited;
  FValueEditor := TNullableDoubleWrapper.Create(TNullableDouble.Null());
  ValueEditor := FValueEditor;
  ValueEditor.OnChange := ValueEditorChanged;
  Value := Pi;
end;

destructor TCustomNullableDoubleStaticText.Destroy;
begin
  FValueEditor.Free;
  FValueEditor := nil;
  inherited;
end;

procedure TCustomNullableDoubleStaticText.CalculateText;
begin
  if Assigned(Self) then  
    TControlUtils.CalculateText(Self, FormatSettings, Value);
end;

function TCustomNullableDoubleStaticText.GetIsNull: Boolean;
begin
  if Assigned(Self.ValueEditor) then
    Result := Self.ValueEditor.IsNull
  else
    Result := False;
end;

function TCustomNullableDoubleStaticText.GetValue: TNullableDouble;
begin
  Result := FValue;
end;

function TCustomNullableDoubleStaticText.GetValueEditor: TNullableDoubleWrapper;
begin
  if Assigned(Self.FValueEditor) then
    if (csDesigning in ComponentState) then
      Self.FValueEditor.NullableValue := Self.Value
    else // run-time: de invoer waarde van de gebruiker nemen
      Self.FValueEditor.NullableValue := TNullableDouble.Parse(Text);
  Result := Self.FValueEditor;
end;

procedure TCustomNullableDoubleStaticText.SetIsNull(const Value: Boolean);
begin
  if Assigned(Self.ValueEditor) then
    Self.ValueEditor.IsNull := Value;
end;

procedure TCustomNullableDoubleStaticText.SetValue(const NewValue: TNullableDouble);
begin
  FValue := NewValue;
  CalculateText();
end;

procedure TCustomNullableDoubleStaticText.SetValueEditor(const NewValue: TNullableDoubleWrapper);
begin
  if Assigned(Self.FValueEditor) then
    Self.FValueEditor.Assign(NewValue)
  else
    Text := '';
end;

procedure TCustomNullableDoubleStaticText.ValueEditorChanged(Sender: TObject);
var
  NullableDoubleWrapper: TNullableDoubleWrapper;
begin
  if Assigned(Sender) then
  begin
    if Sender is TNullableDoubleWrapper then
    begin
      NullableDoubleWrapper := TNullableDoubleWrapper(Sender);
      Self.Value := NullableDoubleWrapper.NullableValue;
    end;
  end;
end;

end.
