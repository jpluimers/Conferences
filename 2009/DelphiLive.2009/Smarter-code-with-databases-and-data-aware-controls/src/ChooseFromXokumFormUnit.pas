unit ChooseFromXokumFormUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, DB, Mask, DbDisplayLabelUnit;

type
  TChooseFromXokumForm = class(TForm)
    ChooseFromXokumClientDataSource: TDataSource;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    DbDisplayLabel1: TDbDisplayLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChooseFromXokumForm: TChooseFromXokumForm;

implementation

uses XokumDataModuleUnit;

{$R *.dfm}

end.
