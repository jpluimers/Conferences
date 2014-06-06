unit MainFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    MyButton: TButton;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  MyButton: TButton;
begin
  MyButton := TButton.Create(Self);

  with MyButton do
  begin
    Name := 'MyButton';
    Parent := Self;
    Left := 24;
    Top := 8;
    Width := 75;
    Height := 25;
    Caption := 'My &Button';
    TabOrder := 0;
  end;
end;

end.
