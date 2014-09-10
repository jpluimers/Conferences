unit TestMainFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Mask, DBCtrls, DB, Grids, DBGrids, DBClient,
  ExtCtrls, DataLinkReflectorUnit, DataAwareControlControllerUnit,
  DbDisplayLabelUnit, EnterEscapeFixerUnit, xmldom, Xmlxform,
  RecordArrivedNotifierUnit;

type
  TTestMainForm = class(TForm)
    DataAwareControlController1: TDataAwareControlController;
    DbDisplayLabel1: TDbDisplayLabel;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    ClientDataSet1ID: TIntegerField;
    ClientDataSet1NAAM: TStringField;
    ClientDataSet1OMSCHRIJVING: TStringField;
    ClientDataSet1TAG: TIntegerField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    DBNavigator1: TDBNavigator;
    DataLinkReflector1: TDataLinkReflector;
    XokumButton: TButton;
    ChooseFromXokumButton: TButton;
    ForChInTextButton: TButton;
    Edit1: TEdit;
    RecordArrivedNotifier1: TRecordArrivedNotifier;
    procedure ForChInTextButtonClick(Sender: TObject);
    procedure ChooseFromXokumButtonClick(Sender: TObject);
    procedure RecordArrivedNotifier1ArriveRecord(Sender: TObject);
    procedure XokumButtonClick(Sender: TObject);
  end;

var
  TestMainForm: TTestMainForm;

implementation

uses XokumFormUnit, ChooseFromXokumFormUnit, Dialogs;

{$R *.dfm}

procedure TTestMainForm.ForChInTextButtonClick(Sender: TObject);
var
  Ch: Char;
begin
  for Ch in Edit1.Text do
  begin
    ShowMessage(Ch);
  end;
end;

procedure TTestMainForm.ChooseFromXokumButtonClick(Sender: TObject);
begin
  ChooseFromXokumForm.ShowModal();
end;

procedure TTestMainForm.RecordArrivedNotifier1ArriveRecord(Sender: TObject);
begin
  Beep();
end;

procedure TTestMainForm.XokumButtonClick(Sender: TObject);
begin
  XokumForm.ShowModal();
end;

end.
