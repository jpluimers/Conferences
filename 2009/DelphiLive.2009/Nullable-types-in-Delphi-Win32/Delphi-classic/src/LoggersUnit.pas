unit LoggersUnit;

interface

uses
  LoggerUnit, ReporterUnit, Classes;

type
  TConsoleLogger = class(TReportingLogger)
  strict private
    FReporter: TReporter;
  public
    constructor Create;
    destructor Destroy; override;
  end;

type
  TStringsLogger = class(TReportingLogger)
  strict private
    FReporter: TReporter;
  public
    constructor Create(const Strings: TStrings);
    destructor Destroy; override;
  end;

implementation

uses
  ReportersUnit;

constructor TConsoleLogger.Create;
begin
  FReporter := TConsoleReporter.Create();
  inherited Create(FReporter);
end;

destructor TConsoleLogger.Destroy;
begin
  inherited;
  FReporter.Free; FReporter := nil;
end;

constructor TStringsLogger.Create(const Strings: TStrings);
begin
  FReporter := TStringsReporter.Create(Strings);
  inherited Create(FReporter);
end;

destructor TStringsLogger.Destroy;
begin
  inherited;
  FReporter.Free; FReporter := nil;
end;

end.
