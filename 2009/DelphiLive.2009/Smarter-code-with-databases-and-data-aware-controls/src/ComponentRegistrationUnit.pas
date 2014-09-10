unit ComponentRegistrationUnit;

interface

uses
  DataAwareControlControllerUnit;

{$R 'DataLinkReflectorUnit.dcr'}
{$R 'DataAwareControlControllerUnit.dcr'}
{$R 'EnterEscapeFixerUnit.dcr'}
{$R 'DbDisplayLabelUnit.dcr'}
{$R 'RecordArrivedNotifierUnit.dcr'}

procedure Register;

implementation

uses
  Classes,
  EnterEscapeFixerUnit, DbDisplayLabelUnit,
  DataLinkReflectorUnit, RecordArrivedNotifierUnit;

procedure Register;
begin
  RegisterComponents('DelphiLive!-2009', [
    DbDisplayLabelUnit.TDbDisplayLabel,
    EnterEscapeFixerUnit.TEnterEscapeFixer,
    DataAwareControlControllerUnit.TDataAwareControlController,
    DataLinkReflectorUnit.TDataLinkReflector,
    RecordArrivedNotifierUnit.TRecordArrivedNotifier
  ]);
end;

end.
