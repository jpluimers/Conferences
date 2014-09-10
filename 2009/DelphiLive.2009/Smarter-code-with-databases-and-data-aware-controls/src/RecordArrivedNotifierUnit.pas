unit RecordArrivedNotifierUnit;

interface

uses
  DataLinkReflectorUnit, Classes;

type
  TCustomRecordArrivedNotifier = class(TCustomDataLinkReflector)
  strict private
    FRecNo: Integer;
    FOnArriveRecord: TNotifyEvent;
  strict protected
    procedure ActiveChanged(Sender: TObject); override;
    procedure ArriveRecord; virtual;
    procedure CheckBrowseMode(Sender: TObject); override;
    procedure DataSetChanged(Sender: TObject); override;
    procedure DataSetScrolled(Sender: TObject; Distance: Integer); override;
    procedure EditingChanged(Sender: TObject); override;
    procedure LayoutChanged(Sender: TObject); override;
    procedure UpdateData(Sender: TObject); override;
  strict protected
    procedure CheckArriveRecord; virtual;
    //1 for debugging purposes: allows you to set a breakpoint
    procedure DataSourceChanged; override;
    procedure InitializeFRecNo; virtual;
    property RecNo: Integer read FRecNo;
  public
    constructor Create(AOwner: TComponent); override;
    property OnArriveRecord: TNotifyEvent read FOnArriveRecord write FOnArriveRecord;
  end;

  TRecordArrivedNotifier = class(TCustomRecordArrivedNotifier)
  published
    property DataSource;
    property OnArriveRecord;
  end;

implementation

constructor TCustomRecordArrivedNotifier.Create(AOwner: TComponent);
begin
  InitializeFRecNo();
  inherited Create(AOwner);
end;

procedure TCustomRecordArrivedNotifier.InitializeFRecNo;
begin
  Self.FRecno := -1;
end;

procedure TCustomRecordArrivedNotifier.ActiveChanged(Sender: TObject);
begin
  if Assigned(Self.DataLink) then
    if Assigned(Self.DataSource) then
      if Assigned(Self.DataSet) then
        if not Self.DataSet.Active then
            InitializeFRecNo();
  inherited ActiveChanged(Sender);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.ArriveRecord;
begin
  PerformNotifyEvent(Self, Self.OnArriveRecord);
  //  CheckArriveRecord(); // not needed, we are alreaady in CheckArriveRecord()
end;

procedure TCustomRecordArrivedNotifier.CheckArriveRecord;
var
  NewRecNo: Integer;
  OldRecNo: Integer;
begin
  if Assigned(Self.DataLink) then
    if Assigned(Self.DataSource) then
      if Assigned(Self.DataSet) then
        if Self.DataSet.Active then
        begin
          OldRecNo := Self.RecNo;
          NewRecNo := Self.DataSet.RecNo;
          if OldRecNo <> NewRecNo then
          begin
            Self.FRecno := NewRecNo;
            Self.ArriveRecord();
          end;
        end;
end;

procedure TCustomRecordArrivedNotifier.CheckBrowseMode(Sender: TObject);
begin
  inherited CheckBrowseMode(Sender);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.DataSetChanged(Sender: TObject);
begin
  inherited DataSetChanged(Sender);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.DataSetScrolled(Sender: TObject; Distance: Integer);
begin
  inherited DataSetScrolled(Sender, Distance);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.DataSourceChanged;
begin
  inherited DataSourceChanged();
end;

procedure TCustomRecordArrivedNotifier.EditingChanged(Sender: TObject);
begin
  inherited EditingChanged(Sender);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.LayoutChanged(Sender: TObject);
begin
  inherited LayoutChanged(Sender);
  CheckArriveRecord();
end;

procedure TCustomRecordArrivedNotifier.UpdateData(Sender: TObject);
begin
  inherited UpdateData(Sender);
  CheckArriveRecord();
end;

end.
