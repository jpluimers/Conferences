unit XokumFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids,
  DataLinkReflectorUnit, DataAwareControlControllerUnit, EnterEscapeFixerUnit,
  DbDisplayLabelUnit;

type
  TXokumForm = class(TForm)
    XokumDataSource: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    DataAwareControlController1: TDataAwareControlController;
    MinMaxAbonneeNummerButton: TButton;
    DataLinkReflector1: TDataLinkReflector;
    DbDisplayLabel1: TDbDisplayLabel;
    procedure MinMaxAbonneeNummerButtonClick(Sender: TObject);
  end;

var
  XokumForm: TXokumForm;

implementation

uses
  XokumDataModuleUnit;

{$R *.dfm}

procedure TXokumForm.MinMaxAbonneeNummerButtonClick(Sender: TObject);
var
  MinAbonneenummer: Integer;
  MaxAbonneeNummer: Integer;
begin
  XokumDataModule.GetMinMaxAbonneeNummer(MinAbonneenummer, MaxAbonneeNummer);
  ShowMessage(Format('Min=%d, Max=%d', [MinAbonneenummer, MaxAbonneeNummer]));
end;

end.
