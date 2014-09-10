unit ConsoleLoggingLogicUnit;

interface

uses
  LoggerUnit;

type
  TConsoleLoggingLogic = class;
  TConsoleLoggingLogicClass = class of TConsoleLoggingLogic;
  TConsoleLoggingLogic = class(TObject)
  strict private
    FLogger: TLogger;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class procedure Run(const ConsoleLoggingLogicClass: TConsoleLoggingLogicClass); static;
    procedure Go; virtual;
    property Logger: TLogger read FLogger;
  end;

implementation

uses
  LoggersUnit;

constructor TConsoleLoggingLogic.Create;
begin
  inherited;
  FLogger := TConsoleLogger.Create();
end;

destructor TConsoleLoggingLogic.Destroy;
begin
  inherited;
  FLogger.Free; FLogger := nil;
end;

class procedure TConsoleLoggingLogic.Run(const ConsoleLoggingLogicClass: TConsoleLoggingLogicClass);
var
  Instance: TConsoleLoggingLogic;
begin
  Instance := ConsoleLoggingLogicClass.Create();
  try
    Instance.Go();
  finally
    Instance.Free();
    Write('Press <Enter>...');
    Readln;
  end;
end;

procedure TConsoleLoggingLogic.Go;
begin
end;

end.
