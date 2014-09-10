unit ReporterUnit;

interface

type
  TReporter = class abstract
  public
    procedure Report(const Line: string); virtual; abstract;
  end;

implementation

end.
