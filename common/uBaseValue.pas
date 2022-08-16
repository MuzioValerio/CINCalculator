unit uBaseValue;

interface

uses
  System.Classes, System.SysUtils, System.StrUtils,
  uCINCalculator;

type
  TExtValueResult = (eExtracted, eEmptyIBAN, eInvalidIBAN);

  TDataStructure = class sealed (TObject)
  strict private
    FAbiCode: string;
    FCabCode: string;
    FCinCode: string;
    FContoCode: string;
    FControlCode: string;
    FNationCode: string;
    FSrcIban: string;

    FCinCodeCalculated: string;
    procedure InitializeValues;
    procedure ExtractValuesFromIBAN;
    procedure SetAbiCode(const AValue: string);
    procedure SetCabCode(const AValue: string);
    procedure SetCinCode(const AValue: string);
    procedure SetContoCode(const AValue: string);
    procedure SetControlCode(const AValue: string);
    procedure SetNationCode(const AValue: string);
    function GetCinCodeCalculated: string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ResetValues;
    function Validator: Boolean;
    procedure SplittingIBAN(const AIban: string);
    procedure CalculateCIN;
    property AbiCode: string read FAbiCode write SetAbiCode;
    property CabCode: string read FCabCode write SetCabCode;
    property CinCode: string read FCinCode write SetCinCode;
    property ContoCode: string read FContoCode write SetContoCode;
    property ControlCode: string read FControlCode write SetControlCode;
    property NationCode: string read FNationCode write SetNationCode;
    property CinCodeCalculated: string read GetCinCodeCalculated;
  end;

var
  gDataStructure: TDataStructure;

procedure CreateDataStructure;

implementation

procedure CreateDataStructure;
begin
  if not Assigned(gDataStructure) then
    gDataStructure := TDataStructure.Create;
end;

procedure TDataStructure.CalculateCIN;
begin
  SetCINCalculator;

  CINCalculator.ABICode := FAbiCode;
  CINCalculator.CABCode := FCabCode;
  CINCalculator.ContoCode := FContoCode;
  CINCalculator.Execute;

  FCinCodeCalculated := CINCalculator.CINCalculated;
end;

constructor TDataStructure.Create;
begin
  inherited Create;
  InitializeValues;
end;

destructor TDataStructure.Destroy;
begin
  inherited Destroy;
end;

procedure TDataStructure.ExtractValuesFromIBAN;
begin
  FNationCode := FSrcIban.Substring(0, 2);
  FControlCode := FSrcIban.Substring(2, 2);
  FCinCode := FSrcIban.Substring(4, 1);
  FAbiCode := FSrcIban.Substring(5, 5);
  FCabCode := FSrcIban.Substring(10, 5);
  FContoCode := FSrcIban.Substring(15, 12);
end;

procedure TDataStructure.SplittingIBAN(const AIban: string);
begin
  FSrcIban := AIban;

  if FSrcIban.Trim = '' then
    raise Exception.Create('Valore IBAN mancante.');
  if FSrcIban.Length <> 27 then
    raise Exception.Create('Valore IBAN errato.');

  ExtractValuesFromIBAN;
end;

function TDataStructure.GetCinCodeCalculated: string;
begin
  Result := FCinCodeCalculated;
end;

procedure TDataStructure.InitializeValues;
begin
  FNationCode := '';
  FControlCode := '';
  FCinCode := '';
  FAbiCode := '';
  FCabCode := '';
  FContoCode := '';

  FSrcIban := '';
end;

procedure TDataStructure.ResetValues;
begin
  InitializeValues;
end;

procedure TDataStructure.SetAbiCode(const AValue: string);
begin
  FAbiCode := AValue;
end;

procedure TDataStructure.SetCabCode(const AValue: string);
begin
  FCabCode := AValue;
end;

procedure TDataStructure.SetCinCode(const AValue: string);
begin
  FCinCode := AValue;
end;

procedure TDataStructure.SetContoCode(const AValue: string);
begin
  FContoCode := AValue;
end;

procedure TDataStructure.SetControlCode(const AValue: string);
begin
  FControlCode := AValue;
end;

procedure TDataStructure.SetNationCode(const AValue: string);
begin
  FNationCode := AValue;
end;

function TDataStructure.Validator: Boolean;
begin
  if (FAbiCode.Trim = '') or (FCabCode.Trim = '') or (FContoCode.Trim = '') then
    Exit(False);

  if (FAbiCode.Trim.Length <> 5) or (FCabCode.Trim.Length <> 5) or (FContoCode.Trim.Length <> 12) then
    Exit(False);

 Exit(True);
end;

end.
