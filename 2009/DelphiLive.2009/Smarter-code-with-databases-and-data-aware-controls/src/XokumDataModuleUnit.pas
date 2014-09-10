unit XokumDataModuleUnit;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TXokumDataModule = class(TDataModule)
    XokumClientDataSet: TClientDataSet;
    XokumClientDataSetachternaam: TStringField;
    XokumClientDataSetvoorletters: TStringField;
    XokumClientDataSetstraat: TStringField;
    XokumClientDataSetnummer: TIntegerField;
    XokumClientDataSetabonneenummer: TIntegerField;
    XokumClientDataSetplaats: TStringField;
    XokumClientDataSetnetnummer: TIntegerField;
    ChooseFromXokumClientDataSet: TClientDataSet;
    ChooseFromXokumClientDataSetabonneenummer: TIntegerField;
    ChooseFromXokumClientDataSetachternaam: TStringField;
    procedure GetMinMaxAbonneeNummer(var MinAbonneenummer: Integer; var MaxAbonneeNummer: Integer);
    procedure XokumClientDataSetNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  XokumDataModule: TXokumDataModule;

implementation

uses
  DataSetHelperUnit;

{$R *.dfm}

procedure TXokumDataModule.GetMinMaxAbonneeNummer(var MinAbonneenummer: Integer; var MaxAbonneeNummer: Integer);
var
  Index: TDataSetRecord;
begin
  MinAbonneenummer := High(Integer);
  MaxAbonneeNummer := Low(Integer);
  for Index in XokumClientDataSet do
    if Assigned(Index.DataSet) then
    begin
      if XokumClientDataSetabonneenummer.Value > MaxAbonneeNummer then
        MaxAbonneeNummer := XokumClientDataSetabonneenummer.Value;
      if XokumClientDataSetabonneenummer.Value < MinAbonneeNummer then
        MinAbonneeNummer := XokumClientDataSetabonneenummer.Value;
    end;
end;

procedure TXokumDataModule.XokumClientDataSetNewRecord(DataSet: TDataSet);
var
  SavedReadOnly: Boolean;
begin
  SavedReadOnly := XokumClientDataSetplaats.ReadOnly;
  try
    XokumClientDataSetplaats.ReadOnly := False;
    XokumClientDataSetplaats.Value := 'xolum';
  finally
    XokumClientDataSetplaats.ReadOnly := SavedReadOnly;
  end;

  SavedReadOnly := XokumClientDataSetnetnummer.ReadOnly;
  try
    XokumClientDataSetnetnummer.ReadOnly := False;
    XokumClientDataSetnetnummer.Value := 2889;
  finally
    XokumClientDataSetnetnummer.ReadOnly := SavedReadOnly;
  end;
end;

end.
