unit DataLinkReflectorUnit;

// copyright (c) Jeroen W. Pluimers 2001-2003

{define codesite}

interface

uses
  Classes,
  DB;

type
  TDataSetScrolledEvent = procedure (Sender: TObject; Distance: Integer) of object;
  TFieldRefEvent = procedure (Sender: TObject; Field: TFieldRef) of object;
  TFieldEvent = procedure (Sender: TObject; Field: TField) of object;

  TReflectorDataLink = class(TDataLink)
  strict private
    FOnEditingChanged: TNotifyEvent;
    FOnActiveChanged: TNotifyEvent;
    FOnUpdateData: TNotifyEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnDataSetChanged: TNotifyEvent;
    FOnCheckBrowseMode: TNotifyEvent;
    FOnDataSetScrolled: TDataSetScrolledEvent;
    FOnRecordChanged: TFieldEvent;
    FOnFocusControl: TFieldRefEvent;
  strict protected
    procedure ActiveChanged; override;
    procedure CheckBrowseMode; override;
    procedure DataSetChanged; override;
    procedure DataSetScrolled(Distance: Integer); override;
    procedure EditingChanged; override;
    procedure FocusControl(Field: TFieldRef); override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
    procedure UpdateData; override;
  public
    constructor Create;
    destructor Destroy; override;
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnCheckBrowseMode: TNotifyEvent read FOnCheckBrowseMode write FOnCheckBrowseMode;
    property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
    property OnDataSetScrolled: TDataSetScrolledEvent read FOnDataSetScrolled write FOnDataSetScrolled;
    property OnEditingChanged: TNotifyEvent read FOnEditingChanged write FOnEditingChanged;
    property OnFocusControl: TFieldRefEvent read FOnFocusControl write FOnFocusControl;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnRecordChanged: TFieldEvent read FOnRecordChanged write FOnRecordChanged;
    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
  end;

  TCustomDataLinkReflector = class(TComponent)
  private
    FDataLink: TReflectorDataLink;
    FOnDataSourceChanged: TNotifyEvent;
    FOnDataSetScrolled: TDataSetScrolledEvent;
    FOnRecordChanged: TFieldEvent;
    FOnFocusControl: TFieldRefEvent;
    FOnActiveChanged: TNotifyEvent;
    FOnUpdateData: TNotifyEvent;
    FOnCheckBrowseMode: TNotifyEvent;
    FOnLayoutChanged: TNotifyEvent;
    FOnDataSetChanged: TNotifyEvent;
    FOnEditingChanged: TNotifyEvent;
  protected // property access methods
    function GetActive: Boolean; virtual;
    function GetActiveRecord: Integer; virtual;
    function GetBOF: Boolean; virtual;
    function GetBufferCount: Integer; virtual;
    function GetDataSet: TDataSet; virtual;
    function GetDataSource: TDataSource; virtual;
    function GetDataSourceFixed: Boolean; virtual;
    function GetEditing: Boolean; virtual;
    function GetEOF: Boolean; virtual;
    function GetReadOnly: Boolean; virtual;
    function GetRecordCount: Integer; virtual;
    procedure SetActiveRecord(const Value: Integer); virtual;
    procedure SetBufferCount(const Value: Integer); virtual;
    procedure SetDataSource(const Value: TDataSource); virtual;
    procedure SetDataSourceFixed(const Value: Boolean); virtual;
    procedure SetReadOnly(const Value: Boolean); virtual;
  protected // methods
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DataSourceChanged; virtual;
    procedure RequireDataLink; virtual;
  protected // reflector methods
    procedure ActiveChanged(Sender: TObject); virtual;
    procedure CheckBrowseMode(Sender: TObject); virtual;
    procedure DataSetChanged(Sender: TObject); virtual;
    procedure DataSetScrolled(Sender: TObject; Distance: Integer); virtual;
    procedure EditingChanged(Sender: TObject); virtual;
    procedure FocusControl(Sender: TObject; Field: TFieldRef); virtual;
    procedure LayoutChanged(Sender: TObject); virtual;
    procedure RecordChanged(Sender: TObject; Field: TField); virtual;
    procedure UpdateData(Sender: TObject); virtual;
  protected // properties
    property DataLink: TReflectorDataLink read FDataLink write FDataLink;
  public // methods
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public // properties
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property OnDataSourceChanged: TNotifyEvent read FOnDataSourceChanged write FOnDataSourceChanged;
  public // reflectory properties
    property Active: Boolean read GetActive;
    property ActiveRecord: Integer read GetActiveRecord write SetActiveRecord;
    property BOF: Boolean read GetBOF;
    property BufferCount: Integer read GetBufferCount write SetBufferCount;
    property DataSet: TDataSet read GetDataSet;
    property DataSourceFixed: Boolean read GetDataSourceFixed write SetDataSourceFixed;
    property Editing: Boolean read GetEditing;
    property Eof: Boolean read GetEOF;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly;
    property RecordCount: Integer read GetRecordCount;
  public // reflector events
    property OnActiveChanged: TNotifyEvent read FOnActiveChanged write FOnActiveChanged;
    property OnCheckBrowseMode: TNotifyEvent read FOnCheckBrowseMode write FOnCheckBrowseMode;
    property OnDataSetChanged: TNotifyEvent read FOnDataSetChanged write FOnDataSetChanged;
    property OnDataSetScrolled: TDataSetScrolledEvent read FOnDataSetScrolled write FOnDataSetScrolled;
    property OnEditingChanged: TNotifyEvent read FOnEditingChanged write FOnEditingChanged;
    property OnFocusControl: TFieldRefEvent read FOnFocusControl write FOnFocusControl;
    property OnLayoutChanged: TNotifyEvent read FOnLayoutChanged write FOnLayoutChanged;
    property OnRecordChanged: TFieldEvent read FOnRecordChanged write FOnRecordChanged;
    property OnUpdateData: TNotifyEvent read FOnUpdateData write FOnUpdateData;
  end;

  TDataLinkReflector = class(TCustomDataLinkReflector)
  published
    property DataSource;
    property OnDataSourceChanged;
    property OnActiveChanged;
    property OnCheckBrowseMode;
    property OnDataSetChanged;
    property OnDataSetScrolled;
    property OnEditingChanged;
    property OnFocusControl;
    property OnLayoutChanged;
    property OnRecordChanged;
    property OnUpdateData;
  end;

procedure PerformNotifyEvent(Instance: TObject; NotifyEvent: TNotifyEvent);

implementation

{$ifdef codesite}
uses
  csIntf;
{$endif codesite}

procedure PerformNotifyEvent(Instance: TObject; NotifyEvent: TNotifyEvent);
begin
  if Assigned(NotifyEvent) then
    NotifyEvent(Instance);
end;

{ TReflectorDataLink }

procedure TReflectorDataLink.ActiveChanged;
begin
  PerformNotifyEvent(Self, OnActiveChanged);
end;

procedure TReflectorDataLink.CheckBrowseMode;
begin
  PerformNotifyEvent(Self, OnCheckBrowseMode);
end;

constructor TReflectorDataLink.Create;
begin //##jpl: This constructor solves the GPF at design time???
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'Create');
{$endif codesite}
  inherited Create;
  VisualControl := True; //##jpl: this makes the notifications come later.
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'Create');
{$endif codesite}
end;

procedure TReflectorDataLink.DataSetChanged;
begin
  PerformNotifyEvent(Self, OnDataSetChanged);
end;

procedure TReflectorDataLink.DataSetScrolled(Distance: Integer);
begin
  if Assigned(OnDataSetScrolled) then
    OnDataSetScrolled(Self, Distance);
end;

destructor TReflectorDataLink.Destroy;
begin
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'Destroy');
{$endif codesite}
  inherited;
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'Destroy');
{$endif codesite}
end;

procedure TReflectorDataLink.EditingChanged;
begin
  PerformNotifyEvent(Self, OnEditingChanged);
end;

procedure TReflectorDataLink.FocusControl(Field: TFieldRef);
begin
  if Assigned(OnFocusControl) then
    OnFocusControl(Self, Field);
end;

procedure TReflectorDataLink.LayoutChanged;
begin
  PerformNotifyEvent(Self, OnLayoutChanged);
end;

procedure TReflectorDataLink.RecordChanged(Field: TField);
begin
  if Assigned(OnRecordChanged) then
    OnRecordChanged(Self, Field);
end;

procedure TReflectorDataLink.UpdateData;
begin
  PerformNotifyEvent(Self, OnUpdateData);
end;

{ TCustomDataLinkReflector }

resourcestring
  SDataLinkRequired = 'A DataLink is required for this operation';

procedure TCustomDataLinkReflector.ActiveChanged(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnActiveChanged);
end;

procedure TCustomDataLinkReflector.CheckBrowseMode(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnCheckBrowseMode);
end;

constructor TCustomDataLinkReflector.Create(AOwner: TComponent);
begin
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'TCustomDataLinkReflector.Create');
{$endif codesite}
  inherited;
  DataLink := TReflectorDataLink.Create;
  RequireDataLink;
  DataLink.OnActiveChanged := ActiveChanged;
  DataLink.OnCheckBrowseMode := CheckBrowseMode;
  DataLink.OnDataSetChanged := DataSetChanged;
  DataLink.OnDataSetScrolled := DataSetScrolled;
  DataLink.OnEditingChanged := EditingChanged;
  DataLink.OnFocusControl := FocusControl;
  DataLink.OnLayoutChanged := LayoutChanged;
  DataLink.OnRecordChanged := RecordChanged;
  DataLink.OnUpdateData := UpdateData;
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'TCustomDataLinkReflector.Create');
{$endif codesite}
end;

procedure TCustomDataLinkReflector.DataSetChanged(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnDataSetChanged);
end;

procedure TCustomDataLinkReflector.DataSetScrolled(Sender: TObject;
  Distance: Integer);
begin
  if Assigned(OnDataSetScrolled) then
    OnDataSetScrolled(Self, Distance);
end;

procedure TCustomDataLinkReflector.DataSourceChanged;
begin
  PerformNotifyEvent(Self, OnDataSourceChanged);
end;

destructor TCustomDataLinkReflector.Destroy;
begin
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'TCustomDataLinkReflector.Destroy');
{$endif codesite}
  DataLink.Free;
  DataLink := nil;
  inherited;
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'TCustomDataLinkReflector.Destroy');
{$endif codesite}
end;

procedure TCustomDataLinkReflector.EditingChanged(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnEditingChanged);
end;

procedure TCustomDataLinkReflector.FocusControl(Sender: TObject;
  Field: TFieldRef);
begin
  if Assigned(OnFocusControl) then
    OnFocusControl(Self, Field);
end;

function TCustomDataLinkReflector.GetActive: Boolean;
begin
  RequireDataLink;
  Result := DataLink.Active;
end;

function TCustomDataLinkReflector.GetActiveRecord: Integer;
begin
  RequireDataLink;
  Result := DataLink.ActiveRecord;
end;

function TCustomDataLinkReflector.GetBOF: Boolean;
begin
  RequireDataLink;
  Result := DataLink.BOF;
end;

function TCustomDataLinkReflector.GetBufferCount: Integer;
begin
  RequireDataLink;
  Result := DataLink.BufferCount;
end;

function TCustomDataLinkReflector.GetDataSet: TDataSet;
begin
  RequireDataLink;
  Result := DataLink.DataSet;
end;

function TCustomDataLinkReflector.GetDataSource: TDataSource;
begin
  RequireDataLink;
  Result := DataLink.DataSource;
end;

function TCustomDataLinkReflector.GetDataSourceFixed: Boolean;
begin
  RequireDataLink;
  Result := DataLink.DataSourceFixed;
end;

function TCustomDataLinkReflector.GetEditing: Boolean;
begin
  RequireDataLink;
  Result := DataLink.Editing;
end;

function TCustomDataLinkReflector.GetEOF: Boolean;
begin
  RequireDataLink;
  Result := DataLink.Eof;
end;

function TCustomDataLinkReflector.GetReadOnly: Boolean;
begin
  RequireDataLink;
  Result := DataLink.ReadOnly;
end;

function TCustomDataLinkReflector.GetRecordCount: Integer;
begin
  RequireDataLink;
  Result := DataLink.RecordCount;
end;

procedure TCustomDataLinkReflector.LayoutChanged(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnLayoutChanged);
end;

procedure TCustomDataLinkReflector.Notification(AComponent: TComponent; Operation: TOperation);
begin
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'TCustomDataLinkReflector.Notification');
{$endif codesite}
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (DataLink <> nil) and
     (AComponent = DataSource)
  then
    DataSource := nil;
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'TCustomDataLinkReflector.Notification');
{$endif codesite}
end;

procedure TCustomDataLinkReflector.RecordChanged(Sender: TObject;
  Field: TField);
begin
  if Assigned(OnRecordChanged) then
    OnRecordChanged(Self, Field);
end;

procedure TCustomDataLinkReflector.RequireDataLink;
begin
  Assert(Assigned(DataLink), SDataLinkRequired);
end;

procedure TCustomDataLinkReflector.SetActiveRecord(const Value: Integer);
begin
  RequireDataLink;
  DataLink.ActiveRecord := Value;
end;

procedure TCustomDataLinkReflector.SetBufferCount(const Value: Integer);
begin
  RequireDataLink;
  DataLink.BufferCount := Value;
end;

procedure TCustomDataLinkReflector.SetDataSource(const Value: TDataSource);
var
  Changed: Boolean;
  Same: Boolean;
begin
{$ifdef codesite}
  CodeSite.EnterMethod(Self, 'TCustomDataLinkReflector.SetDataSource');
{$endif codesite}
  RequireDataLink;
  Changed := DataLink.DataSource <> Value;
  if Assigned(DataLink) then
    if not (DataLink.DataSourceFixed and (csLoading in ComponentState)) then
      if DataLink.DataSource <> Value then
      begin
        // with Lookup fields, we might be running in circles
        Same := Assigned(DataLink.DataSource) and Assigned(Value);
        if Same then
          Same := DataLink.DataSource.DataSet = Value.DataSet;
        if not Same then
          DataLink.DataSource := Value;
      end;
  if Value <> nil then
    Value.FreeNotification(Self);
  if Changed then
    DataSourceChanged;
{$ifdef codesite}
  CodeSite.ExitMethod(Self, 'TCustomDataLinkReflector.SetDataSource');
{$endif codesite}
end;

procedure TCustomDataLinkReflector.SetDataSourceFixed(const Value: Boolean);
begin
  RequireDataLink;
  DataLink.DataSourceFixed := Value;
end;

procedure TCustomDataLinkReflector.SetReadOnly(const Value: Boolean);
begin
  RequireDataLink;
  DataLink.ReadOnly := Value;
end;

procedure TCustomDataLinkReflector.UpdateData(Sender: TObject);
begin
  PerformNotifyEvent(Self, OnUpdateData);
end;

end.
