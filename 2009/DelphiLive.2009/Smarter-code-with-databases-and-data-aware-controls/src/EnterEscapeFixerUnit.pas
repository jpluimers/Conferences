unit EnterEscapeFixerUnit;

{
Als er een TDBLookupComboBox open staat, en er is een Default en/of Cancel TButton
dan kan het form worden afgesloten en krijg je allemaal vage foutmeldingen
(cannot focus invisible control).

Dit lost het op: zodra de dropdown list open is, dan worden de Buttons met Default en Cancel
in een lijst opgeslagen en de Default / Cancel wordt uitgeschakeld.
Zodra de dropdown list gesloten is wordt de lijst afgelopen en de
Default / Cancel properties hersteld.

}

interface

uses
  Classes,
  ExtCtrls;

type
  TCustomEnterEscapeFixer = class(TComponent)
  private
    FTimer: TTimer;
    FCancelList: TList;
    FDefaultList: TList;
    function GetCancelList: TList;
    function GetDefaultList: TList;
  protected
    procedure DisableEnterEscapeButtons; virtual;
    procedure EnableEnterEscapeButtons; virtual;
    function GetTimer: TTimer; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Shot(Sender: TObject); virtual;
    property CancelList: TList read GetCancelList write FCancelList;
    property DefaultList: TList read GetDefaultList write FDefaultList;
    property Timer: TTimer read GetTimer write FTimer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TEnterEscapeFixer = class(TCustomEnterEscapeFixer)
  end;

implementation

uses
  Controls,
  DBCtrls,
  StdCtrls;

{ TCustomEnterEscapeFixer }

constructor TCustomEnterEscapeFixer.Create(AOwner: TComponent);
begin
  inherited;
  Timer.OnTimer := Shot;
  Timer.Interval := 250;
  Timer.Enabled := True;
end;

destructor TCustomEnterEscapeFixer.Destroy;
begin
  inherited;
  FCancelList.Free; FCancelList := nil;
  FDefaultList.Free; FDefaultList := nil;
  FTimer.Free; FTimer := nil;
end;

procedure TCustomEnterEscapeFixer.DisableEnterEscapeButtons;
var
  Index: Integer;
  Button: TButton;
begin
  for Index := 0 to Owner.ComponentCount-1 do
    if Owner.Components[Index] is TButton then
    begin
      Button := Owner.Components[Index] as TButton;
      if Button.Cancel then
      begin
        Button.Cancel := False;
        CancelList.Add(Button);
//        Beep;
      end;
      if Button.Default then
      begin
        Button.Default := False;
        DefaultList.Add(Button);
//        Beep;
      end;
    end;
end;

procedure TCustomEnterEscapeFixer.EnableEnterEscapeButtons;
var
  Index: Integer;
  Button: TButton;
begin
  for Index := CancelList.Count-1 downto 0 do
  begin
    Button := TButton(CancelList.Items[Index]);
    Button.Cancel := True;
//    Beep;
  end;
  CancelList.Clear;

  for Index := DefaultList.Count-1 downto 0 do
  begin
    Button := TButton(DefaultList.Items[Index]);
    Button.Default := True;
//    Beep;
  end;
  DefaultList.Clear;
end;

function TCustomEnterEscapeFixer.GetCancelList: TList;
begin
  if FCancelList = nil then
    FCancelList := TList.Create;
  Assert(Assigned(FCancelList), 'TCustomEnterEscapeFixer.GetTimer: FCancelList must be assigned');
  Result := FCancelList;
end;

function TCustomEnterEscapeFixer.GetDefaultList: TList;
begin
  if FDefaultList = nil then
    FDefaultList := TList.Create;
  Assert(Assigned(FDefaultList), 'TCustomEnterEscapeFixer.GetTimer: FDefaultList must be assigned');
  Result := FDefaultList;
end;

function TCustomEnterEscapeFixer.GetTimer: TTimer;
begin
  if FTimer = nil then
    FTimer := TTimer.Create(nil);
  Assert(Assigned(FTimer), 'TCustomEnterEscapeFixer.GetTimer: FTimer must be assigned');
  Result := FTimer;
end;

procedure TCustomEnterEscapeFixer.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  Index: Integer;
begin
  inherited;
  if Operation = opRemove then
  begin
    for Index := CancelList.Count-1 downto 0 do
      if AComponent = CancelList.Items[Index] then
        CancelList.Delete(Index);
    for Index := DefaultList.Count-1 downto 0 do
      if AComponent = DefaultList.Items[Index] then
        DefaultList.Delete(Index);
  end;
end;

procedure TCustomEnterEscapeFixer.Shot(Sender: TObject);
var
  Index: Integer;
begin
  if csDesigning in ComponentState then
    exit;
  if Assigned(Owner) then
    if Owner is TControl then
      for Index := 0 to Owner.ComponentCount-1 do
      begin
        if Owner.Components[Index] is TDBLookupComboBox then
          if TDBLookupComboBox(Owner.Components[Index]).ListVisible then
          begin
            DisableEnterEscapeButtons;
            Exit;
          end;
      end;
  // Kennelijk geen DBLookupComboBox of geen ListVisible actief
  EnableEnterEscapeButtons;
end;

end.
