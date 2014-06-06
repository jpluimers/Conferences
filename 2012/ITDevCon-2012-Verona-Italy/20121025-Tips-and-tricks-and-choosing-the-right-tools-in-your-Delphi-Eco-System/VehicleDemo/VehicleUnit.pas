unit VehicleUnit;

interface

type
  TVehicle = class(TObject)
  private
    FWheels: Integer;
  public
    constructor Create;
    function Drive: string; virtual;
    property Wheels: Integer read FWheels;
  end;

  TBike = class(TVehicle)
  private
    FFuel: string;
  public
    constructor Create;
    function Drive: string; override;
    property Fuel: string read FFuel;
  end;

  TMotorVehicle = class(TVehicle)
  private
    FFuel: string;
  public
    function Drive: string; override;
    property Fuel: string read FFuel;
  end;

  TCar = class(TMotorVehicle)
  public
    constructor Create;
  end;

  TTruck = class(TMotorVehicle)
  public
    constructor Create;
  end;

implementation

uses
  System.SysUtils;

constructor TVehicle.Create;
begin
  inherited;
  FWheels := -1;
end;

function TVehicle.Drive: string;
begin
  Result := Format('%s Drives on %d wheels', [ClassName, Wheels]);
end;

constructor TBike.Create;
begin
  inherited;
  FFuel := 'Gas';
end;

function TBike.Drive: string;
begin
  Result := Format('%s and using %s fuel', [inherited Drive, Fuel]);
end;

function TMotorVehicle.Drive: string;
begin
  Result := Format('%s and using %s fuel', [inherited Drive, Fuel]);
end;

constructor TCar.Create;
begin
  inherited;
  Fuel := 'Petrol';
end;

constructor TTruck.Create;
begin
  inherited;
  Fuel := 'Diesel';
end;

end.
