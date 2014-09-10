object TestMainForm: TTestMainForm
  Left = 0
  Top = 0
  Caption = 'TestMainForm'
  ClientHeight = 348
  ClientWidth = 673
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DbDisplayLabel1: TDbDisplayLabel
    Left = 72
    Top = 59
    Width = 169
    Height = 17
    DataField = 'NAAM'
    DataSource = DataSource1
  end
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 11
    Height = 13
    Caption = 'ID'
    FocusControl = DBEdit1
  end
  object Label2: TLabel
    Left = 8
    Top = 60
    Width = 29
    Height = 13
    Caption = 'NAAM'
    FocusControl = DBEdit2
  end
  object Label3: TLabel
    Left = 8
    Top = 104
    Width = 76
    Height = 13
    Caption = 'OMSCHRIJVING'
    FocusControl = DBEdit3
  end
  object Label4: TLabel
    Left = 8
    Top = 148
    Width = 20
    Height = 13
    Caption = 'TAG'
    FocusControl = DBEdit4
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 220
    Width = 621
    Height = 120
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBEdit1: TDBEdit
    Left = 8
    Top = 32
    Width = 134
    Height = 21
    DataField = 'ID'
    DataSource = DataSource1
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 8
    Top = 76
    Width = 394
    Height = 21
    DataField = 'NAAM'
    DataSource = DataSource1
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 8
    Top = 120
    Width = 621
    Height = 21
    DataField = 'OMSCHRIJVING'
    DataSource = DataSource1
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 8
    Top = 164
    Width = 134
    Height = 21
    DataField = 'TAG'
    DataSource = DataSource1
    TabOrder = 4
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 191
    Width = 240
    Height = 25
    DataSource = DataSource1
    TabOrder = 5
  end
  object XokumButton: TButton
    Left = 536
    Top = 8
    Width = 129
    Height = 25
    Caption = 'XokumButton'
    TabOrder = 6
    OnClick = XokumButtonClick
  end
  object ChooseFromXokumButton: TButton
    Left = 508
    Top = 72
    Width = 157
    Height = 25
    Caption = 'ChooseFromXokumButton'
    TabOrder = 7
    OnClick = ChooseFromXokumButtonClick
  end
  object ForChInTextButton: TButton
    Left = 546
    Top = 41
    Width = 119
    Height = 25
    Caption = 'ForChInTextButton'
    TabOrder = 8
    OnClick = ForChInTextButtonClick
  end
  object Edit1: TEdit
    Left = 428
    Top = 164
    Width = 121
    Height = 21
    TabOrder = 9
    Text = 'Edit1'
  end
  object DataAwareControlController1: TDataAwareControlController
    ControllerActions = [caToggleReadOnly, caToggleParentColor, caSetColorWhenEnabled, caSetColorWhenRequired]
    DataSource = DataSource1
    Left = 472
    Top = 12
  end
  object ClientDataSet1: TClientDataSet
    Active = True
    Aggregates = <>
    FileName = 
      'C:\develop\conferences\DelphiLive.2009\Smarter-code-with-databas' +
      'es-and-data-aware-controls\data\2009.UTF8.ControllerData.xml'
    Params = <>
    Left = 168
    Top = 12
    Data = {
      6B0000009619E0BD0100000018000000040000000000030000006B0002494404
      00010010000000044E41414D0100490014000100055749445448020002001E00
      0C4F4D53434852494A56494E47010049001000010005574944544802000200FA
      000354414704000100120000000000}
    object ClientDataSet1ID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object ClientDataSet1NAAM: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAAM'
      Required = True
      Size = 30
    end
    object ClientDataSet1OMSCHRIJVING: TStringField
      FieldName = 'OMSCHRIJVING'
      Size = 250
    end
    object ClientDataSet1TAG: TIntegerField
      FieldName = 'TAG'
      ReadOnly = True
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 256
    Top = 12
  end
  object DataLinkReflector1: TDataLinkReflector
    Left = 348
    Top = 12
  end
  object RecordArrivedNotifier1: TRecordArrivedNotifier
    DataSource = DataSource1
    OnArriveRecord = RecordArrivedNotifier1ArriveRecord
    Left = 436
    Top = 68
  end
end
