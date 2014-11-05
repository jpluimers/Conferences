unit MissileCommand;

interface

uses
   w3system, w3touch, w3ctrls, w3components, w3application, w3game, w3gameapp,
   w3graphics, GameLogic, GameMenu, GameScore, GameScoreDialog;

type
  TApplication = class(TW3CustomGameApplication)
  private
     { Private methods }
     FGameLogic : TGameLogic;
     FGameMenu : TGameMenu;
     FGameScore : TGameScore;
     FGameScoreDialog : TGameScoreDialog;

     FIgnoreMouse : Boolean;
     FGamePaused : Boolean;
     FLastFrameTime : Float;
     FTimeAccu : Float;
     FBtnResume : TW3Button;

     FBkgndGC : TW3GraphicContext;
     FImgBkgnd : TW3Image;

     FImgAsteroid : TW3Image;
     FImgBoom : TW3Image;

  protected
     procedure  ApplicationStarting; override;
     procedure  ApplicationClosing; override;

     procedure DoImgBkgndLoaded(Sender : TObject);
     procedure DoResize;

     procedure DoClickStart(Sender : TObject);
     procedure DoClickScores(Sender : TObject);
     procedure DoClickScoresBack(Sender : TObject);
     procedure DoClickResume(Sender : TObject);

     procedure DoGameOver(Sender : TObject);

     procedure EnterPause;

     procedure PaintView(Canvas:TW3Canvas);override;

     procedure DoTouchBegins(sender:TObject; Info : TW3TouchData);
     procedure DoTouchNop(sender:TObject; Info : TW3TouchData);
     procedure DoMouseDown(Sender:TObject; Button : TMouseButton; Shift: TShiftState; X,Y : Integer);
  end;

implementation

//############################################################################
// TApplication
//############################################################################

procedure TApplication.ApplicationStarting;
begin
   inherited;

   //Initialize refresh interval, set this to 1 for optimal speed
   GameView.Delay:=20;

//   w3_setStyle(GameView.TagRef, 'background',"fixed url('res/earth.png') black no-repeat");
//   w3_setStyle(GameView.TagRef, 'background-position','center bottom');
//   w3_setStyle(GameView.TagRef, 'background-size','auto 100%');

   GameView.OnTouchBegin:=DoTouchBegins;
   GameView.OnTouchMove:=DoTouchNop;
   GameView.OnTouchEnd:=DoTouchNop;
   GameView.OnMouseDown:=DoMouseDown;

   FImgBkgnd:=TW3Image.Create(nil);

   FBkgndGC:=TW3GraphicContext.Create(null);

   FImgAsteroid:=TW3Image.Create(nil);
   FImgAsteroid.LoadFromUrl('res/asteroid_256_32.png');

   FImgBoom:=TW3Image.Create(nil);
   FImgBoom.LoadFromUrl('res/boom.png');

   FGameScore:=TGameScore.Create('Arcade');

   FGameMenu:=TGameMenu.Create(Document);
   FGameMenu.OnClickStart:=DoClickStart;
   FGameMenu.OnClickScores:=DoClickScores;

   FGameLogic:=TGameLogic.Create(FImgAsteroid.Handle, FImgBoom.Handle);
   FGameLogic.FOnGameOver:=DoGameOver;

   //Start the redraw-cycle with framecounter active
   //Note: the framecounter impacts rendering speed. Disable
   //the framerate for maximum speed (false)
   GameView.StartSession(true);
End;

procedure TApplication.ApplicationClosing;
begin
  GameView.EndSession;
  inherited;
end;

procedure TApplication.DoImgBkgndLoaded(Sender : TObject);
begin
   FBkgndGC.Allocate(FGameLogic.FWidth, FGameLogic.FHeight);
   var canvas := TW3Canvas.Create(FBkgndGC);
   canvas.DrawImageF(FImgBkgnd.Handle, 0, 0, FGameLogic.FWidth, FGameLogic.FHeight);
end;

procedure TApplication.DoResize;
begin
   var gw := GameView.Width;
   var gh := GameView.Height;

   FGameLogic.GameResize(gw, gh);

   FGameMenu.Setup(gw, gh);

   FImgBkgnd.OnLoad:=DoImgBkgndLoaded;
   FImgBkgnd.LoadFromUrl('res/earth.png');
end;

procedure TApplication.DoClickStart(Sender : TObject);
begin
   FGameMenu.Visible:=False;
   FGameLogic.GameStart;
end;

procedure TApplication.DoClickScores(Sender : TObject);
begin
   if not Assigned(FGameScoreDialog) then begin
      FGameScoreDialog:=TGameScoreDialog.Create(Document);
      FGameScoreDialog.Setup(GameView.Width, GameView.Height);
      FGameScoreDialog.OnBack:=DoClickScoresBack;
   end;

   FGameScoreDialog.Visible:=True;
   FGameScoreDialog.UpdateScore(FGameScore);

   FGameMenu.Visible:=False;
end;

procedure TApplication.DoClickScoresBack(Sender : TObject);
begin
   FGameMenu.Visible:=True;
   FGameScoreDialog.Visible:=False;
end;

procedure TApplication.DoGameOver(Sender : TObject);
begin
   FGameScore.RecordHighScore('You', FGameLogic.FScore);
   FGameMenu.Visible:=True;
end;

procedure TApplication.DoClickResume(Sender : TObject);
begin
   FGamePaused:=False;
   FBtnResume.Visible:=False;
end;

procedure TApplication.EnterPause;
begin
   if not Assigned(FBtnResume) then begin
      FBtnResume:=TW3Button.Create(Document);
      FBtnResume.Caption:='Resume';
      FBtnResume.Left:=(GameView.Width-FBtnResume.Width) div 2;
      FBtnResume.Top:=(GameView.Height-FBtnResume.Height) div 2;
      FBtnResume.OnClick:=DoClickResume;
   end;
   FBtnResume.Visible:=True;
   FGamePaused:=True;
end;

procedure TApplication.PaintView(Canvas:TW3Canvas);
begin
   if FGameLogic=nil then Exit;

   var gw := GameView.Width;
   var gh := GameView.Height;

   var newFrameTime:=Now;
   case FGameLogic.FMode of
      gmUninitialized : begin
         if not GameView.Active then Exit;
         DoResize;
         FGameLogic.Clear;
      end;
      gmPlaying, gmInterlude : begin
         if (newFrameTime-FLastFrameTime)>(1/86400) then
            EnterPause;
      end;
   end;
   FTimeAccu += (newFrameTime-FLastFrameTime)*(86400*1000);
   FLastFrameTime:=newFrameTime;

   if not FGamePaused then begin

      var nbFrames := Round(Floor(FTimeAccu/30));
      if nbFrames<=0 then Exit;
      FTimeAccu -= nbFrames*30;

      nbFrames:=MinInt(nbFrames, 2); // max 1 skip

      // Clear background
      var x := (gw-FGameLogic.FWidth) div 2;
      canvas.clearRectF(0, 0, x+1, gh);
      canvas.clearRectF(gw-x-1, 0, x+1, gh);
      canvas.DrawImageF(FBkgndGC.Handle,
                          x, 0,
                          FGameLogic.FWidth, FGameLogic.FHeight);

      FGameLogic.PaintView(Canvas);
      while nbFrames>0 do begin
         FGameLogic.Progress;
         Dec(nbFrames);
      end;

      // Draw our framerate on the screen
      if GameView.FrameRate>0 then begin
         canvas.font:='10pt verdana';
         canvas.fillStyle:='white';
         canvas.FillTextF('FPS:'+IntToStr(GameView.FrameRate), FGameLogic.FOffsetX+10, 20 ,MAX_INT);
      end;
   end;
end;

procedure TApplication.DoTouchBegins(sender:TObject;Info:TW3TouchData);
var
   i : Integer;
begin
   FGamePaused:=False;
   FIgnoreMouse:=True;
   for i:=0 to Info.Touches.Count-1 do begin
      var touch := Info.Touches[i];
      FGameLogic.FireMissile(touch.clientX, touch.clientY);
   end;
end;

procedure TApplication.DoTouchNop(sender:TObject;Info:TW3TouchData);
begin
end;

procedure TApplication.DoMouseDown(Sender:TObject;Button:TMouseButton;Shift:TShiftState;X,Y:Integer);
begin
   FGamePaused:=False;
   if not FIgnoreMouse then
      FGameLogic.FireMissile(X, Y);
end;

end.
