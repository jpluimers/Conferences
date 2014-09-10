unit DbDisplayLabelUnit;

//##jpl: Extra: eentje die de 'lange displaylabel' uit de DataDict haalt

interface

uses
  Classes,
  Controls,
  DB,
  DBCtrls,
  Messages,
  StdCtrls;

type
  TCustomDbDisplayLabel = class(TCustomLabel)
  private
    FDataLink: TFieldDataLink;
    FAddColon: Boolean;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetFieldText: string;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure SetAddColon(const Value: Boolean);
  protected
    function GetLabelText: string; override;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent;
      Operation: TOperation); override;
    procedure SetAutoSize(Value: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    property Field: TField read GetField;
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property AddColon: Boolean read FAddColon write SetAddColon;
  end;

  TDbDisplayLabel = class(TCustomDbDisplayLabel)
  published
    property AddColon default True;
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize default False;
    property BiDiMode;
    property Color;
    property Constraints;
    property DataField;
    property DataSource;
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
    property Transparent;
    property ShowHint;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

implementation

uses
  VDBConsts,
  DBConsts, SysUtils;

{ TCustomDbDisplayLabel }

procedure TCustomDbDisplayLabel.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

constructor TCustomDbDisplayLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  AutoSize := False;
  ShowAccelChar := False;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FAddColon := True;
end;

procedure TCustomDbDisplayLabel.DataChange(Sender: TObject);
begin
  Caption := GetFieldText;
  if AddColon then
    Caption := Caption + ':';
end;

destructor TCustomDbDisplayLabel.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited;
end;

function TCustomDbDisplayLabel.ExecuteAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;

function TCustomDbDisplayLabel.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TCustomDbDisplayLabel.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TCustomDbDisplayLabel.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TCustomDbDisplayLabel.GetFieldText: string;
begin
  if FDataLink.Field <> nil then
    Result := FDataLink.Field.DisplayLabel
  else
    if csDesigning in ComponentState then
      Result := Name
    else
      Result := '';
end;

function TCustomDbDisplayLabel.GetLabelText: string;
begin
  if csPaintCopy in ControlState then
    Result := GetFieldText
  else
    Result := Caption;
end;

procedure TCustomDbDisplayLabel.Loaded;
begin
  inherited Loaded;
  if (csDesigning in ComponentState) then
    DataChange(Self);
end;

procedure TCustomDbDisplayLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (FDataLink <> nil) and
     (AComponent = DataSource)
  then
    DataSource := nil;
end;

procedure TCustomDbDisplayLabel.SetAddColon(const Value: Boolean);
begin
  if Value <> AddColon then
  begin
    FAddColon := Value;
    DataChange(Self);
  end;
end;

procedure TCustomDbDisplayLabel.SetAutoSize(Value: Boolean);
begin
  if AutoSize <> Value then
  begin
    if Value and FDataLink.DataSourceFixed then
      DatabaseError(SDataSourceFixed);
    inherited SetAutoSize(Value);
  end;
end;

procedure TCustomDbDisplayLabel.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TCustomDbDisplayLabel.SetDataSource(Value: TDataSource);
begin
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

function TCustomDbDisplayLabel.UpdateAction(
  Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;

function TCustomDbDisplayLabel.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;

end.
