object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 295
  ClientWidth = 415
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 184
    Top = 8
    Width = 23
    Height = 22
    OnClick = SpeedButton1Click
  end
  object MyButton: TButton
    Left = 24
    Top = 80
    Width = 75
    Height = 25
    Caption = 
      'My &Button which is haviung an extremely long caption that wraps' +
      ' around'
    TabOrder = 0
  end
end
