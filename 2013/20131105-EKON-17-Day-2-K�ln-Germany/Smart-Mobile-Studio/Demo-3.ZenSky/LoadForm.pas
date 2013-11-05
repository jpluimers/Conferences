unit LoadForm;

interface

uses 
  w3system, w3graphics, w3ctrls, w3components, w3forms, w3fonts,
  w3borders,w3application, w3time;

type

  TfrmLoader=class(TW3form)
  private
     { Private methods }
    {$I 'LoadForm:intf'}
    FImages:  Array of TW3Image;
    FNames:   Array of String;
    FCounter: Integer;
    Procedure ImageLoaded(sender:TObject);
    Procedure HandleButtonClick(Sender:TObject);
  protected
    { Protected methods }
    procedure FormActivated;override;
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure StyleTagObject; reintroduce; virtual;
    procedure Resize; override;
  end;

implementation

(* small helper function *)
function ExtractFileName(Const aValue: String): String;
var
  x:  Integer;
begin
  Result:='';
  for x:=Length(aValue) downto 1 do
  begin
    if (aValue[x] = '/')
    or (aValue[x] = '\') then
    begin
      Result:=copy(aValue, x + 1, Length(aValue));
      break;
    end;
  end;
end;

//############################################################################
// TfrmLoader
//############################################################################

procedure TfrmLoader.InitializeObject;
var
  x:  Integer;
begin
  inherited;
  {$I 'LoadForm:impl'}

  btnNext.OnClick:=HandleButtonClick;

  (* init label1 *)
  w3label1.AlignText:=taCenter;
  w3label1.Caption:='Loading sprites';
  w3label1.Font.Color:=clWhite;

  (* init label2 *)
  w3label2.AlignText := taCenter;
  w3Label2.font.color := clWhite;

  (* number of images loaded into the cache *)
  FCounter := 0;

  (* names of images to load *)
  FNames.add('res/body.jpg');
  FNames.add('res/cloud_1.png');
  FNames.add('res/cloud_2.png');
  FNames.add('res/sun.png');

  (* create equal number of image elements *)
  for x := 0 to FNames.length - 1 do
    FImages.add(TW3Image.Create(nil));
end;

procedure TfrmLoader.FormActivated;
var
  x:  Integer;
begin
  (* initiate async loading on all *)
  for x := 0 to FImages.Length - 1 do
  begin
    FImages[x].OnLoad := ImageLoaded;
    FImages[x].LoadFromURL(FNames[x]);
  end;
end;

procedure TfrmLoader.ImageLoaded(Sender:TObject);
begin
  if (Sender <> nil) then
  begin

    (* last image? *)
    Inc(FCounter);
    if FCounter = FImages.Length then
    begin
      w3label1.Caption := 'All images loaded';
      w3label1.CSSClasses.Add('BlinkLabel'); //make it blink!
      w3label2.Caption := '';
      btnNext.Visible := True;
    end else
    (* update loader filename *)
    w3Label2.Caption := ExtractFileName(TW3Image(sender).URL);

  end;
end;

Procedure TfrmLoader.HandleButtonClick(Sender:TObject);
begin
  Application.GotoForm('Form1', TFormEntryEffect.feFromRight);
end;

procedure TfrmLoader.FinalizeObject;
var
  x:  Integer;
begin
  for x := 0 to FImages.length - 1 do
    FImages[x].Free;

  inherited;
end;
 
procedure TfrmLoader.Resize;
var
  dx: Integer;
begin
  inherited;
  w3label1.Width := self.width - w3label1.left * 2;
  w3label2.width := self.Width - w3label2.left * 2;

  dx := (Width div 2) - (btnNext.width div 2);
  btnNext.left := dx;
end;
 
procedure TfrmLoader.StyleTagObject;
begin
  //Custom styling
end;
 
end.
