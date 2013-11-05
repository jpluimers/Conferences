unit GalaxyClockMain;

interface

uses
  w3system, w3application, w3ctrls, w3game, w3gameapp, w3graphics, w3components;

type
  TApplication = class(TW3CustomGameApplication)
  private
    FBackgroundImage: TW3Image;
  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
    procedure PaintView(Canvas: TW3Canvas); override;
    procedure ResizeHandler(Sender: TObject);
  end;

implementation

{ TApplication }

procedure TApplication.ApplicationStarting;
begin
  inherited;

  FBackgroundImage := TW3Image.Create(GameView);
//  FBackgroundImage.LoadFromURL('/res/M101-128.png');
  FBackgroundImage.OnLoad := ResizeHandler;

  GameView.OnResize := ResizeHandler;

  // Initialize refresh interval, set this to 1 for optimal speed
  GameView.Delay := 1000;

  // Start the redraw-cycle with framecounter active
  // Note: the framecounter impacts rendering speed. Disable
  // the framerate for maximum speed (False)
  GameView.StartSession(True);
end;

procedure TApplication.ApplicationClosing;
begin
  FBackgroundImage.Free;
  GameView.EndSession;
  inherited;
end;

procedure TApplication.ResizeHandler(Sender: TObject);
begin
  FBackgroundImage.Left := (GameView.Width - FBackgroundImage.Width) div 2;
  FBackgroundImage.Top := (GameView.Height - FBackgroundImage.Height) div 2;
end;

// Note: In a real live game you would try to cache as much
// info as you can. Typical tricks are:
//   1: Only get the Width/Height when resized
//   2: Pre-calculate strings, especially RGB/RGBA values
//   3: Only redraw what has changed, avoid a full repaint
// The code below is just to get you started

procedure TApplication.PaintView(Canvas: TW3Canvas);
begin
  // clear background
  Canvas.ClearRectF(0, 0, GameView.Width, GameView.Height);

  // define and initialize local variables
  var s := Round(MinInt(GameView.Width, GameView.Height) * 0.45);
  var cx := GameView.Width * 0.5;
  var cy := GameView.Height * 0.5;

  var hr  := Frac(Now) * 24;
  var min := Frac(hr) * 60;
  var sec := Frac(min) * 60;

  hr := Trunc(hr);
  if hr >= 12 then hr -= 12;

  Canvas.LineCap := "round";

  // write Hours
  hr := hr * (2 * PI / 12) - PI / 2;
  Canvas.LineWidth := s * 0.075;
  Canvas.StrokeStyle := "#000040";
  Canvas.BeginPath;
  Canvas.MoveToF(cx, cy);
  Canvas.LineToF(cx + Cos(hr) * s * 0.5, cy + Sin(hr) * s * 0.5);
  Canvas.Stroke;

  // write Minutes
  min := min * (2 * PI / 60) - PI / 2;
  Canvas.LineWidth := s * 0.05;
  Canvas.StrokeStyle := "#000040";
  Canvas.BeginPath;
  Canvas.MoveToF(cx, cy);
  Canvas.LineToF(cx + Cos(min) * s, cy + Sin(min) * s);
  Canvas.Stroke;

  // write Seconds
  sec := sec * (2 * PI / 60) - PI / 2;
  Canvas.LineWidth := s * 0.025;
  Canvas.StrokeStyle := "#800000";
  Canvas.BeginPath;
  Canvas.MoveToF(cx - Cos(sec) * s * 0.2, cy - Sin(sec) * s * 0.2);
  Canvas.LineToF(cx + Cos(sec) * s, cy + Sin(sec) * s);
  Canvas.Stroke;
end;

end.
