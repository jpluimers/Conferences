object XokumForm: TXokumForm
  Left = 0
  Top = 0
  Caption = 'XokumForm'
  ClientHeight = 635
  ClientWidth = 675
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    675
    635)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 44
    Width = 57
    Height = 13
    Caption = 'achternaam'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 88
    Width = 53
    Height = 13
    Caption = 'voorletters'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 132
    Width = 29
    Height = 13
    Caption = 'straat'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 8
    Top = 176
    Width = 38
    Height = 13
    Caption = 'nummer'
    FocusControl = DBEdit4
  end
  object Label5: TLabel
    Left = 8
    Top = 220
    Width = 80
    Height = 13
    Caption = 'abonneenummer'
    FocusControl = DBEdit5
  end
  object Label6: TLabel
    Left = 8
    Top = 264
    Width = 29
    Height = 13
    Caption = 'plaats'
    FocusControl = DBEdit6
  end
  object Label7: TLabel
    Left = 8
    Top = 308
    Width = 54
    Height = 13
    Caption = 'netnummer'
    FocusControl = DBEdit7
  end
  object DbDisplayLabel1: TDbDisplayLabel
    Left = 396
    Top = 188
    Width = 65
    Height = 17
    DataField = 'plaats'
    DataSource = XokumDataSource
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 360
    Width = 659
    Height = 267
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = XokumDataSource
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 240
    Height = 25
    DataSource = XokumDataSource
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 60
    Width = 524
    Height = 21
    DataField = 'achternaam'
    DataSource = XokumDataSource
    TabOrder = 2
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 104
    Width = 134
    Height = 21
    DataField = 'voorletters'
    DataSource = XokumDataSource
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 148
    Width = 264
    Height = 21
    DataField = 'straat'
    DataSource = XokumDataSource
    TabOrder = 4
  end
  object DBEdit4: TDBEdit
    Left = 8
    Top = 192
    Width = 134
    Height = 21
    DataField = 'nummer'
    DataSource = XokumDataSource
    TabOrder = 5
  end
  object DBEdit5: TDBEdit
    Left = 8
    Top = 236
    Width = 134
    Height = 21
    DataField = 'abonneenummer'
    DataSource = XokumDataSource
    TabOrder = 6
  end
  object DBEdit6: TDBEdit
    Left = 8
    Top = 280
    Width = 264
    Height = 21
    DataField = 'plaats'
    DataSource = XokumDataSource
    TabOrder = 7
  end
  object DBEdit7: TDBEdit
    Left = 8
    Top = 324
    Width = 134
    Height = 21
    DataField = 'netnummer'
    DataSource = XokumDataSource
    TabOrder = 8
  end
  object MinMaxAbonneeNummerButton: TButton
    Left = 444
    Top = 8
    Width = 181
    Height = 25
    Caption = 'MinMaxAbonneeNummerButton'
    TabOrder = 9
    OnClick = MinMaxAbonneeNummerButtonClick
  end
  object XokumDataSource: TDataSource
    DataSet = XokumDataModule.XokumClientDataSet
    Left = 260
    Top = 4
  end
  object DataAwareControlController1: TDataAwareControlController
    DataSource = XokumDataSource
    Left = 380
    Top = 4
  end
  object DataLinkReflector1: TDataLinkReflector
    DataSource = XokumDataSource
    Left = 372
    Top = 104
  end
end
