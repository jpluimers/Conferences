unit zenSky;

interface

uses 
  w3system, w3ctrls, w3components, w3forms, w3application,
  LoadForm, form1;

type
  TApplication = class(TW3CustomApplication)
  private
    FHeader: TW3HeaderControl;
  public
    procedure ApplicationStarting; override;

    property Header: TW3HeaderControl read FHeader;
  end;

implementation

uses w3graphics;

//############################################################################
// TApplication
//############################################################################


procedure TApplication.ApplicationStarting;
var
  mForm: TW3CustomForm;
begin
  FHeader:=TW3HeaderControl.create(display);
  FHeader.BackButton.Visible := False;
  FHeader.Title.Caption := 'Zen sky demo';
  FHeader.Height:=40;

  display.View.Background.fromColor(clBlack);

  //Add code above this line 
  mForm := TfrmLoader.Create(Display.View);
  mForm.Name := 'LoadForm';
  RegisterFormInstance(mForm, True);

  mForm := TForm1.Create(display.view);
  mForm.name := 'Form1';
  RegisterFormInstance(mForm, False);

  inherited;
end;


end.
