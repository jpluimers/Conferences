unit DbCrackerUnit;

interface

uses
  Classes,
  DB,
  DBGrids;

function GetColumnIsStored(Column: TColumn): Boolean;
function GetColumnsFromCustomDbGrid(CustomDbGrid: TCustomDbGrid): TDBGridColumns;
function GetCustomDbGridFromGridDataLink(
  GridDataLink: TGridDataLink): TCustomDbGrid;
function GetCustomDbGridDataLink(CustomDbGrid: TCustomDbGrid): TGridDataLink;
function GetCustomDbGridReadOnly(CustomDbGrid: TCustomDbGrid): Boolean;
function GetDataLinksFromDataSource(DataSource: TDataSource): TList;
function GetDataLinkVisualControl(DataLink: TDataLink): Boolean;
function GetDataSourcesFromDataSet(DataSet: TDataSet): TList;

implementation

{ Various cracker classes.
  The simple case is to crack various parts of the protected section into a
  public section (actually because the 'implicit friendship' you could live
  without promoting them to public explicitly).
  The complex case is then things have been hidden in the private section.
  This means you have to derive from the superclass, and construct a
  new public section that has exactly the same memory mapping as the old
  private section.
}

type
  TColumnCracker = class(TColumn)
  public
    property IsStored;
  end;

  TCustomDBGridCracker = class(TCustomDBGrid)
  public
    property Columns;
    property ReadOnly;
  end;

  TDataLinkCracker = class(TDataLink)
  public
    property VisualControl;
  end;

  TDataSetCracker = class(TComponent) //##jpl: TDataSet also has IProviderSupport)
  { In TDataSet, this section private, but this causes a compiler
    hint for the private fields that we don't use.
    The change to public does not alter the memory-mapping. }
  public // private
    FFields: TFields;
    FAggFields: TFields;
    FFieldDefs: TFieldDefs;
    FFieldDefList: TFieldDefList;
    FFieldList: TFieldList;
    FDataSources: TList;
  end;

  TDataSourceCracker = class(TDataSource)
  public
    property DataLinks;
  end;

  TGridDataLinkCracker = class(TDataLink)
  { In TGridDataLink, this section private, but this causes a compiler
    hint for the private fields that we don't use.
    The change to public does not alter the memory-mapping. }
  protected // private
    FGrid: TCustomDBGrid;
    FFieldCount: Integer;
    FFieldMap: array of Integer;
    FModified: Boolean;
    FInUpdateData: Boolean;
    FSparseMap: Boolean;
  end;

function GetColumnIsStored(Column: TColumn): Boolean;
begin
//##jpl: Asserts
  Result := TColumnCracker(Column).IsStored;
end;

function GetColumnsFromCustomDbGrid(CustomDbGrid: TCustomDbGrid): TDBGridColumns;
begin
//##jpl: Asserts
  Result := TCustomDBGridCracker(CustomDbGrid).Columns;
end;

function GetCustomDbGridFromGridDataLink(
  GridDataLink: TGridDataLink): TCustomDbGrid;
begin
//##jpl: Asserts
  Result := TGridDataLinkCracker(GridDataLink).FGrid;
end;

function GetCustomDbGridDataLink(CustomDbGrid: TCustomDbGrid): TGridDataLink;
begin
//##jpl: Asserts
  Result := TCustomDBGridCracker(CustomDbGrid).DataLink;
end;

function GetCustomDbGridReadOnly(CustomDbGrid: TCustomDbGrid): Boolean;
begin
//##jpl: Asserts
  Result := TCustomDBGridCracker(CustomDbGrid).ReadOnly;
end;

resourcestring
  sDataSourceRequired = 'A DataSource is required for this operation';
  sDataSourceWithoutDataLinks = 'This DataSource has undefined DataLinks';

function GetDataLinksFromDataSource(DataSource: TDataSource): TList;
begin
  Assert(Assigned(DataSource), sDataSourceRequired);
  Result := TDataSourceCracker(DataSource).DataLinks as TList; // extra type check for TList
  Assert(Assigned(Result), sDataSourceWithoutDataLinks);
end;

function GetDataLinkVisualControl(DataLink: TDataLink): Boolean;
begin
//##jpl: Asserts
  Result := Assigned(DataLink)
        and TDataLinkCracker(DataLink).VisualControl;
end;

resourcestring
  sDataSetRequired = 'A DataSet is required for this operation';
  sDataSetWithoutDataSources = 'This DataSet has undefined DataSources';

function GetDataSourcesFromDataSet(DataSet: TDataSet): TList;
begin
  Assert(Assigned(DataSet), sDataSetRequired);
  Result := TDataSetCracker(DataSet).FDataSources as TList; // extra type check for TList
  Assert(Assigned(Result), sDataSetWithoutDataSources);
end;

end.
