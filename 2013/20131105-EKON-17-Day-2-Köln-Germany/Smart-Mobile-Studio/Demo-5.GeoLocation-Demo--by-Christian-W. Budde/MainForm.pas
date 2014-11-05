unit MainForm;

interface

uses 
  w3system, w3graphics, w3ctrls, w3components, w3forms, w3fonts, w3borders,
  w3application, w3geolocation;

type
  TForm1 = class(TW3form)
  private
    {$I 'MainForm:intf'}
    FGeoLocation: TW3GeoLocation;
  protected
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure StyleTagObject; reintroduce; virtual;
    procedure Resize; override;
  public
    procedure PositionUpdateHandler(Sender: TObject; Position: TW3Position);
    procedure PositionErrorHandler(Sender: TObject; PositionError: TW3PositionError);
  end;

implementation

{ TForm1 }

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'MainForm:impl'}

  FGeoLocation := TW3GeoLocation.Create;
  FGeoLocation.OnPosition := @PositionUpdateHandler;

  HeaderControl.BackButton.Visible := False;
  HeaderControl.Title.Caption := 'Geolocation Demo';

  // define OnClick event using a closure
  BtUpdate.OnClick := procedure (Sender: TObject)
  begin
    FGeoLocation.QueryCurrentPosition;
  end;

  // now actually query current position
  FGeoLocation.QueryCurrentPosition;
end;

procedure TForm1.FinalizeObject;
begin
  FGeoLocation.Free;
  inherited;
end;
 
procedure TForm1.PositionUpdateHandler(Sender: TObject; Position: TW3Position);
begin
  LbPosition.Caption := 'Latitude: ' + FloatToStr(Position.Coords.Latitude) +
    '; Longitude: ' + FloatToStr(Position.Coords.Longitude) +
    '; Altitude: ' + FloatToStr(Position.Coords.Altitude) +
    '; Accuracy: ' + FloatToStr(Position.Coords.Accuracy) +
    '; Altitude Accuracy: ' + FloatToStr(Position.Coords.AltitudeAccuracy) +
    '; Heading: ' + FloatToStr(Position.Coords.Heading) +
    '; Speed: ' + FloatToStr(Position.Coords.Speed);
  LbPosition.Caption := Position.TimeStampAsString;
end;

procedure TForm1.PositionErrorHandler(Sender: TObject;
  PositionError: TW3PositionError);
begin
  raise Exception.Create('Error')
end;

procedure TForm1.Resize;
begin
  inherited;
  HeaderControl.Width := Width;
  Panel.Left := 8;
  Panel.Width := Width - 16;
  LbPosition.Width := Panel.Width - 16;
end;
 
procedure TForm1.StyleTagObject;
begin
  //Custom styling
end;
 
end.
