unit DbUtilityUnit;

interface

uses
  Controls,
  DB,
  DBCtrls,
  DBGrids;

function ColumnIsEditable(Column: TColumn): Boolean;
function ColumnIsRequired(Column: TColumn): Boolean;

function DataSetIsEditable(DataSet: TDataSet): Boolean;

function DataSetFieldsAreEditable(DataSet: TDataSet; Fields: string): Boolean;
function DataSetFieldsAreRequired(DataSet: TDataSet; Fields: string): Boolean;

function DataSourceIsEditable(DataSource: TDataSource): Boolean;

function DbControlIsEditable(Control: TControl; Field: TField): Boolean;
function DbControlIsRequired(Control: TControl; Field: TField): Boolean;

function FieldIsEditable(Field: TField): Boolean;
function FieldIsRequired(Field: TField): Boolean;

function GetFieldDataLinkField(FieldDataLink: TFieldDataLink): TField;

type
  TFieldBooleanFunction = function(Field: TField): Boolean;

//1 Calls Method for each Field, but returns upon the first call to Method returning true
function WalkFieldsWithBooleanMethod(DataSet: TDataSet; Fields: string; Method: TFieldBooleanFunction): Boolean;


implementation

uses
  Classes, SysUtils;

function ColumnIsEditable(Column: TColumn): Boolean;
begin
  Result := Assigned(Column)
        and Assigned(Column.Field)
        and Assigned(Column.Grid)
        and
  (
    FieldIsEditable(Column.Field) or
    (
         Column.Field.Lookup
     and DataSetFieldsAreEditable(Column.Field.DataSet, Column.Field.KeyFields)
     and (not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly))
    )
  );
end;

function ColumnIsRequired(Column: TColumn): Boolean;
begin
  Result := ColumnIsEditable(Column) and
  (
    Column.Field.Required or
    (
         Column.Field.Lookup
     and DataSetFieldsAreRequired(Column.Field.DataSet, Column.Field.KeyFields)
     and (not ((cvReadOnly in Column.AssignedValues) and Column.ReadOnly))
    )
  );
end;

function DataSetIsEditable(DataSet: TDataSet): Boolean;
begin
  Result :=
        Assigned(DataSet)
    and DataSet.Active
    and (   DataSet.CanModify
         or (DataSet.State in dsEditModes {##jpl: ?? - [dsSetKey]})
        )
    and not (DataSet.UpdateStatus = usDeleted);
end;

function DataSetFieldsAreEditable(DataSet: TDataSet; Fields: string): Boolean;
begin
  Result := WalkFieldsWithBooleanMethod(DataSet, Fields, FieldIsEditable);
end;

function DataSetFieldsAreRequired(DataSet: TDataSet; Fields: string): Boolean;
begin
  Result := DataSetFieldsAreEditable(DataSet, Fields) and
    WalkFieldsWithBooleanMethod(DataSet, Fields, FieldIsRequired);
end;

function DataSourceIsEditable(DataSource: TDataSource): Boolean;
begin
  Result :=
        Assigned(DataSource)
    and Assigned(DataSource.DataSet)
    and (   DataSource.AutoEdit
         or DataSetIsEditable(DataSource.DataSet)
        );
end;

function DbControlIsEditable(Control: TControl; Field: TField): Boolean;
begin
  Result := FieldIsEditable(Field) or
    (
         (Control is TDBLookupControl)
     and Field.Lookup
     and DataSetFieldsAreEditable(Field.DataSet, Field.KeyFields)
    )
end;

function DbControlIsRequired(Control: TControl; Field: TField): Boolean;
begin
  Result := DbControlIsEditable(Control, Field) and
  (
    Field.Required or
    (
         (Control is TDBLookupControl)
     and Field.Lookup
     and DataSetFieldsAreRequired(Field.DataSet, Field.KeyFields)
    )
  )
end;

function FieldIsEditable(Field: TField): Boolean;
begin
  Result :=
        Assigned(Field)
    and Assigned(Field.DataSet)
    and DataSetIsEditable(Field.DataSet)
    and (
         Field.CanModify
{##jpl: if we have the lookup logic here, then it fails when you assign a lookup field
        to a non-lookup DbControl, so the logic must be on the DbControl side
         or (    Field.Lookup
             and DataSetFieldsAreEditable(Field.DataSet, Field.KeyFields)
            )
}
        )
end;

function FieldIsRequired(Field: TField): Boolean;
begin
  Result := FieldIsEditable(Field) and Field.Required;
end;

function GetFieldDataLinkField(FieldDataLink: TFieldDataLink): TField;
begin
{
  The below line would work if Field was guaranteed to be filled at all times:
    Result := (DataLink as TFieldDataLink).Field;

  However, sometimes TFieldDataLink.Field returns NIL even though
  TFieldDataLink.FieldName has a valid value.
  This happens during a ReOpen sequence the Field is not yet assigned,
  and it means we cannot rely on DataLink.Field to always point to the field.

  Therefore, we get the field by using a back-door: we get it the same way
  as the TFieldDataLink would update the Field property in the
  TFieldDataLink.UpdateField method:

    if Assigned(FControl) then
      SetField(GetFieldProperty(DataSource.DataSet, FControl, FFieldName))
    else
      SetField(DataSource.DataSet.FieldByName(FFieldName));

  Since we are sure that we have a Control, we can use GetFieldProperty
  to retreive the Field for us (and don't need to call DataSet.FieldByName)
}
  Result := GetFieldProperty(
    FieldDataLink.DataSet, FieldDataLink.Control, FieldDataLink.FieldName);
end;

function WalkFieldsWithBooleanMethod(DataSet: TDataSet; Fields: string; Method: TFieldBooleanFunction): Boolean;
const
  //##jpl: CodeGear uses a hard-coded ';' constant here, so we hard-code it as well.
  // compare to TCustomSQLDataSet.LocateRecord or TDBXIndexColumns.GetFieldNames
  FieldDelimiter = ';';
var
  FieldList: TStrings;
  Index: Integer;
  FieldName: string;
  Field: TField;
begin
  Result := Assigned(DataSet);
  if Result then
  begin
    if Pos(FieldDelimiter, Fields) = 0 then
      Result := Method(DataSet.FieldByName(Fields))
    else
    begin
      FieldList := TStringList.Create;
      try
        // Alternative:
        // FieldList.CommaText := StringReplace(Fields, ';', ',', [rfReplaceAll]);
        FieldList.Delimiter := FieldDelimiter;
        FieldList.DelimitedText := Fields;
        // We could use for ... in, but it is not compatible with older Delphi versions
        for Index := 0 to FieldList.Count-1 do
        begin
          FieldName := FieldList[Index];
          Field := DataSet.FieldByName(FieldName);
          Result := Result and Method(Field);
          if not Result then
            Break;
        end;
      finally
        FieldList.Free;
      end;
    end;
  end;
end;

end.
