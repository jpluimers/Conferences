unit NullableIntegerStaticTextUnit;

interface

uses
  Classes, Controls, NumericStaticTextUnit, NullablesUnit, NullableWrappersUnit;

// TNullableIntegerStaticText

type
  TCustomNullableIntegerStaticText = class(TBaseNumericStaticText)
  strict private
    FValue: TNullableInteger;
    FValueEditor: TNullableIntegerWrapper;
    function GetValueEditor: TNullableIntegerWrapper;
    procedure SetValueEditor(const NewValue: TNullableIntegerWrapper);
    procedure ValueEditorChanged(Sender: TObject);
  strict protected
    procedure CalculateText; override;
    function GetIsNull: Boolean; override;
    function GetValue: TNullableInteger; virtual;
    procedure SetIsNull(const Value: Boolean); override;
    procedure SetValue(const NewValue: TNullableInteger); virtual;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
    property Value: TNullableInteger read GetValue write SetValue;
    property ValueEditor: TNullableIntegerWrapper read GetValueEditor write SetValueEditor;
  end;

type
  TNullableIntegerStaticText = class(TCustomNullableIntegerStaticText)
  published // TCustomNullableIntegerStaticText
    property Value;
    property ValueEditor;
  published // from TStaticText
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelEdges;
    property BevelInner;
    property BevelKind;
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
  ControlUtilsUnit;

{ TCustomNullableIntegerStaticText }

constructor TCustomNullableIntegerStaticText.Create(aOwner: TComponent);
begin
  inherited;
  FValueEditor := TNullableIntegerWrapper.Create(TNullableInteger.Null());
  ValueEditor := FValueEditor;
  ValueEditor.OnChange := ValueEditorChanged;
  Value := 984; // http://www.stetson.edu/~efriedma/numbers.html
end;

destructor TCustomNullableIntegerStaticText.Destroy;
begin
  FValueEditor.Free;
  FValueEditor := nil;
  inherited;
end;

procedure TCustomNullableIntegerStaticText.CalculateText;
begin
  if Assigned(Self) then  
    TControlUtils.SetCaption(Self, Value);
end;

function TCustomNullableIntegerStaticText.GetIsNull: Boolean;
begin
  if Assigned(Self.ValueEditor) then
    Result := Self.ValueEditor.IsNull
  else
    Result := False;
end;

function TCustomNullableIntegerStaticText.GetValue: TNullableInteger;
begin
  Result := FValue;
end;

function TCustomNullableIntegerStaticText.GetValueEditor: TNullableIntegerWrapper;
begin
  if Assigned(Self.FValueEditor) then
    Self.FValueEditor.NullableValue := TNullableInteger.Parse(Text);
  Result := Self.FValueEditor;
end;

procedure TCustomNullableIntegerStaticText.SetIsNull(const Value: Boolean);
begin
  if Assigned(Self.ValueEditor) then
    Self.ValueEditor.IsNull := Value;
end;

procedure TCustomNullableIntegerStaticText.SetValue(const NewValue: TNullableInteger);
begin
  FValue := NewValue;
  CalculateText();
end;

procedure TCustomNullableIntegerStaticText.SetValueEditor(const NewValue: TNullableIntegerWrapper);
begin
  if Assigned(Self.FValueEditor) then
    Self.FValueEditor.Assign(NewValue)
  else
    Text := '';
end;

procedure TCustomNullableIntegerStaticText.ValueEditorChanged(Sender: TObject);
var
  NullableIntegerWrapper: TNullableIntegerWrapper;
begin
  if Assigned(Sender) then
  begin
    if Sender is TNullableIntegerWrapper then
    begin
      NullableIntegerWrapper := TNullableIntegerWrapper(Sender);
      Self.Value := NullableIntegerWrapper.NullableValue;
    end;
  end;
end;

end.

