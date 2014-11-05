unit Form1;

interface

uses 
  w3system, w3graphics, w3ctrls, w3components, w3forms, w3fonts, w3borders,
  w3application, w3sprite3d, w3time;

type
  TForm1=class(TW3form)
  private
     { Private methods }
    {$I 'Form1:intf'}
    FSprites: Array of TW3Sprite;
    FTimer: TW3Timer;
    FSun: TW3Sprite;
    mVal: Float;
    Procedure HandleUpdate(Sender:TObject);
  protected
    { Protected methods }
    procedure FormActivated;override;
    procedure FormDeActivated;override;
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure StyleTagObject; reintroduce; virtual;
    procedure Resize; override;
  end;

implementation

  uses w3application,zenSky;

//############################################################################
// TForm1
//############################################################################

procedure TForm1.InitializeObject;
var
  mSprite:  TW3Sprite;
begin
  inherited;
  {$I 'Form1:impl'}
  self.Background.fromURL('res/body.jpg');

  mSprite:=TW3Sprite.Create(self);
  mSprite.Background.fromURL('res/cloud_1.png');
  mSprite.Width:=359;
  mSprite.height:=127;
  mSprite.x:=200;
  mSprite.setTransformFlags(CNT_USE_POS);
  mSprite.Update3d;
  FSprites.Add(mSprite);

  FSun:=TW3Sprite.Create(self);
  FSun.Background.fromURL('res/sun.png');
  FSun.setTransformFlags(CNT_USE_POS or CNT_USE_SCALE or CNT_USE_ROTZ);
  FSun.Width:=256;
  FSun.height:=256;
  FSun.x:=40;
  FSun.y:=30;
  FSun.Update3d;

  mSprite:=TW3Sprite.Create(self);
  mSprite.Background.fromURL('res/cloud_2.png');
  mSprite.setTransformFlags(CNT_USE_POS);
  mSprite.Width:=382;
  mSprite.height:=194;
  mSprite.x:=125;
  mSprite.y:=130;
  mSprite.Update3d;
  FSprites.Add(mSprite);

  mSprite:=TW3Sprite.Create(self);
  mSprite.Background.fromURL('res/cloud_2.png');
  mSprite.setTransformFlags(CNT_USE_POS);
  mSprite.Width:=382;
  mSprite.height:=194;
  mSprite.x:=25;
  mSprite.y:=200;
  mSprite.Update3d;
  FSprites.Add(mSprite);

  FSprites.Add(mSprite);
  FTimer:=TW3Timer.Create;
  FTimer.OnTime:=HandleUpdate;
  FTimer.Delay:=5;
  FTimer.Enabled:=False;
end;
 
procedure TForm1.FinalizeObject;
begin
  inherited;
end;

procedure TForm1.FormActivated;
Begin
  inherited;
  FTimer.Enabled:=True;
end;

procedure TForm1.FormDeActivated;
Begin
  inherited;
  FTimer.Enabled:=False;
end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
Procedure TForm1.HandleUpdate(Sender:TObject);
var
  x:  Integer;
  mSprite:  TW3Sprite;
Begin
  for x:=0 to FSprites.length-1 do
  Begin
    mSprite:=FSprites[x];
    if mSprite.x < (-mSprite.Width) then
    mSprite.x := width else
    mSprite.x := mSprite.x - ((x + 0.3) * 0.3);
  end;

  mVal:=mVal + 0.01;

  FSun.x:=(width div 2) - (FSun.Width div 2);
  FSun.y:=(height div 2) - (FSun.Height div 2);
  FSun.Scale(0.33 * sin(mVal) + 1.0);
  FSun.RotateZ(0.33 * sin(mVal) + 1.0);
  FSun.Update3d;

  for x:=0 to FSprites.length-1 do
  FSprites[x].Update3d;
end;

procedure TForm1.StyleTagObject;
begin
  //Custom styling
end;
 
end.
