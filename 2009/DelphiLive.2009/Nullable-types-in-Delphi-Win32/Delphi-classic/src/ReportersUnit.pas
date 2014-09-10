unit ReportersUnit;

interface

uses
  ReporterUnit, Classes;

type
  TConsoleReporter = class(TReporter)
  public
    procedure Report(const Line: string); override;
  end;

type
  TStringsReporter = class(TReporter)
  strict private
    FStrings: TStrings;
  public
    constructor Create(const Strings: TStrings);
    destructor Destroy; override;
    procedure Report(const Line: string); override;
  end;

implementation

procedure TConsoleReporter.Report(const Line: string);
begin
  WriteLn(Line);
end;

constructor TStringsReporter.Create(const Strings: TStrings);
begin
  inherited Create();
  FStrings := Strings;
end;

destructor TStringsReporter.Destroy;
begin
  inherited;
  FStrings := nil;
end;

procedure TStringsReporter.Report(const Line: string);
var
  Strings: TStrings;
begin
  Strings := FStrings;
  if Assigned(Strings) then
    Strings.Append(Line);
end;

end.
