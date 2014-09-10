object ChooseFromXokumForm: TChooseFromXokumForm
  Left = 0
  Top = 0
  Caption = 'ChooseFromXokumForm'
  ClientHeight = 155
  ClientWidth = 578
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 12
    Width = 80
    Height = 13
    Caption = 'abonneenummer'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 20
    Top = 56
    Width = 57
    Height = 13
    Caption = 'achternaam'
    FocusControl = DBLookupComboBox1
  end
  object DbDisplayLabel1: TDbDisplayLabel
    Left = 220
    Top = 28
    Width = 153
    Height = 17
    DataField = 'abonneenummer'
    DataSource = ChooseFromXokumClientDataSource
  end
  object BitBtn1: TBitBtn
    Left = 20
    Top = 104
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 116
    Top = 104
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 20
    Top = 28
    Width = 134
    Height = 21
    DataField = 'abonneenummer'
    DataSource = ChooseFromXokumClientDataSource
    TabOrder = 2
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 20
    Top = 72
    Width = 534
    Height = 21
    DataField = 'achternaam'
    DataSource = ChooseFromXokumClientDataSource
    TabOrder = 3
  end
  object ChooseFromXokumClientDataSource: TDataSource
    DataSet = XokumDataModule.ChooseFromXokumClientDataSet
    Left = 308
    Top = 60
  end
end
