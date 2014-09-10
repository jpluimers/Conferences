unit About;

interface

uses Windows, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, SysUtils;

type
  TAboutBox = class(TForm)
    OKButton: TButton;
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProgramName: TLabel;
    Copyright: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

procedure ShowAboutBox;

implementation

{$R *.dfm}

const
  SCopyright     = 'Copyright © 1996, 1998-2002 Embarcadero Technologies Inc.';

procedure ShowAboutBox;
begin
  with TAboutBox.Create(Application) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  Caption := Format('About %s', [Application.Title]);
  ProgramIcon.Picture.Assign(Application.Icon);
  ProgramName.Caption := Application.Title;
  CopyRight.Caption := SCopyRight;
end;

end.

